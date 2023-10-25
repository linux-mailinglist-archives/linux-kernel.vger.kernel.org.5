Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643BA7D7184
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJYQPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJYQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:15:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9467BE5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grHZzwI3G0XHJVITT0Qr8FdKHSaR6ce8vR1kv504HMaZKL3RNTUHmwpqeOKicUtTbuRWX0yRYzcyImPbGv6PNexXJ4G4wWGF57ICnH1LfnqpI+baG8l9YsT4KFRyIwh03MQV7Ci75FglmuP9aJ8nHRcrQ7JCSHYgSh2zwNXx3n8zt2Z0tiJSzQD1pkbuZE0hqq7/SMjVOyf1Q/19AHhbPfgYVKyr2LB1YLM9KZfc+kTxi1INw3WOS9gq5NiUc77A9QOoYC2MU7TgomK+YPM+plGiuberAWBvW1TzQt42p9vfF87qIawkKU8fF/EUuGj8YAqZ6Dhu81sSTeU4y/CYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5o3/q73nMrN8BkTRFa7Qq7/qjI0ZPNUrl5RWoyECJQ=;
 b=EDYrN2zMGLdLgLQCpVZIYxxlsWqWMOI/2OZXzfq8gyjr2Mkl9IxzvEswEMl4brnGv4jJ/Fk9RnhoXq9UsPBrKYB6B1SUGjqBolebNMZS2DAHCTqrqpw49qT86Da62MLc/cBuMpd+0m4KexUfcv8WlgPJZVU/u/zRetup1HELdM9Bjw7g9XGSsYuH2V5h5DJgBBHrTWepxfxpBb+rARokau7QBiiVeKTFy9x58GbVABkmfOBi0YRQtwgaBKkIqV7w4r8T6Mnc53OtFaBxzyU6Lp6MPQJ9CKaKJs1SSWe8Px8n1QQYbElyp3aYbJRdK9O/9OrN19qQ+nHzIiBiF95DHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5o3/q73nMrN8BkTRFa7Qq7/qjI0ZPNUrl5RWoyECJQ=;
 b=Btar8vzmyUnBsDRE0Qy3Bh4qFMOL3Z8zr0125IB6mof6SEjX0O2yeufKEs6iO+500w3xCiHh3etee3n8Hpm4x8dP4wCQNPGAhz+yF8ssJnzsxmU7D1CP1U54ak2ZAwbKRCWVJIz8/onSU9CC3It3DEu7KLg8KF/N8qOh9biEk1xWvMeBFZRsric8xT/2NpdRtIFklx5wySAWika1JQ8ie130WrvSAKxkcA0TJ8hSXl6F6g3G7jbw0qnaxOFr0m7aty6+mzidpt1b0x6aCWEUiGKeysZc8VRghpYgBEM6RlxaZTC2BqrGKIMAtmUSHq9qa1VkKkA6xGYM3XQAEvKqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 16:15:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 16:15:06 +0000
Date:   Wed, 25 Oct 2023 13:15:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Message-ID: <20231025161505.GJ3952@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
 <20231024185213.GA1061115@nvidia.com>
 <ec86712a-0c46-4b27-9736-e34b02168e19@arm.com>
 <20231025125528.GG3952@nvidia.com>
 <6da52dd4-b3fe-46f8-9a38-c4315b989139@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da52dd4-b3fe-46f8-9a38-c4315b989139@arm.com>
X-ClientProxiedBy: SN1PR12CA0049.namprd12.prod.outlook.com
 (2603:10b6:802:20::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d209635-abab-4c3b-6a9e-08dbd5758d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JI0UO6RVHb8QfZ1JgvFSWaP2oZ4LRZszmQn5mnGEb5wkSTjo8eMNMtzpx20AtJTLScUlt/2POnGh7xbtBlOFV6Lroqe4jVp2XuYqZbrutOKvQHfqSx6LVfubTTceXy4b4NKsN0+ZOInYGlKx1wYBuGDCcRhDh/64A5BD1drDl3oBQV6WTn0It0ZSM1Nq9KRcAuIgjCQ443KjOGSI+42QFms4/NLn3eOCX21MVVMJQnGbI5z6rCMhcsh7ChqoeFZOyXf4CKq0Jhn9PFb7S7aOBFep0Lq18mYTb0765CQubs671r3XY8vVl+BFWFsirkx1inR7787VOv5qGDksMhT4EP1AsYI4vv5O8YRd1LCncLCaYNplKQ4UvT2sigDxYX9rn8Ge4GiGQ5Km1HvRz3f4ekmdWjXRDj580vqzNW7HZGow0TyYda7b+CnjRGd91crVX57TQL2zExijwOio3q9mAstrj3kIGGp9mP8XrzMr282fhKjlE9CjBOu5DBRFIZz72kzYF8uhmbsw7wvFX68oR7sRCzIhfzW+r0WTmr/TbleVs9m+rMOSOCRddKPNeize
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(41300700001)(1076003)(26005)(33656002)(86362001)(36756003)(38100700002)(2616005)(83380400001)(15650500001)(5660300002)(53546011)(478600001)(6916009)(316002)(66946007)(66476007)(66556008)(6486002)(6512007)(6506007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHu9V1YuG32ZdMxz2RrDdrF8AtkyDj4uPP9pAQXRrHxdhX2gZ/rmhTnUqCYq?=
 =?us-ascii?Q?jA5PkAwUrC4HEfvofvTafaSfTmIkvU1j8TGocJoq0pZHaLt7Jywdyyf/W0+3?=
 =?us-ascii?Q?TAOV5P5ZM/v8JOZuDBppmhjKcLJS1j7U6yO1UHzM7P0t08PwojHhfHy5koSl?=
 =?us-ascii?Q?CaJDKVUBsNGqs2j5FNIF42dWXPFpb4LR0bpNOlkOtwJXlXYFKD6pZ6hL/jVk?=
 =?us-ascii?Q?mkkQQ17xyA0VByPDb9MAI57AOJlZ+GNmekbr3Kzs+4fdGwemNcz63Cf2ZQNQ?=
 =?us-ascii?Q?T6xO2HTKyw2ErK4NChbDHPnvum0Av5wQuSMzNyX3uaj0RYAT7vBovPumn2Lw?=
 =?us-ascii?Q?opiZsFuaSn51PxYmYKetIH0sZUPs/1CXkOlH5G0X7mhMqURGARFw1+JoAjrw?=
 =?us-ascii?Q?2eI94XvzSE9ru51TKl2rmYSe0TNG2LzMJrUzBDZVrPTVn51oCDoVwNXz2JK0?=
 =?us-ascii?Q?7jzb6dCsx1AWIbQCv7KgaR+hRegh0rSo69NGNCTMJgXQth5n1ENFJ8d5hWw2?=
 =?us-ascii?Q?h6YE+inG9jXugWE0qRchixgjQwVslXt6NOL2D4ZBWcRxCdE1OlU9/NOWcLyl?=
 =?us-ascii?Q?2lnmI0428kg9dZvlnaVnNOqimXK0Bh8W1OmFKewIdOdlYDPSCtmqFauX36W7?=
 =?us-ascii?Q?B+5+8joXTCtZrELSvDLhxvgm41j0e3WnNrGjtINu8ZOPjFeGZUp6wl768k8t?=
 =?us-ascii?Q?0WjF4jWt8zNmsw/nZTFXiKWH5QMC6RlsrzMawGktQMjYkBvx9TAQr9VGgUUQ?=
 =?us-ascii?Q?klVuioqP92OFrje/6vdfKOw1Q5OjNrC5rozhljDmZWsBuWOT1OWnwTFWqFOx?=
 =?us-ascii?Q?5rrb2FezYItjY1Uyhvqxnl5Si5l4+J91eiyvLleLIY4CADINtDtvUb4oq1+8?=
 =?us-ascii?Q?A8797CqVulxMxCXnU5yr5YgBZzAKV1od0mEStI+SgG9FustD7it/LTdyxI/z?=
 =?us-ascii?Q?3XHaUCWtPFe4A0x5xW+1Yz8S+TlF6O4sicLUt5zoDYDhR9w+4ZQpOgg3Zc8Q?=
 =?us-ascii?Q?jC2/Ki4kvXZ7eqlI4x2jH8whgsdG8d/f4kcwvmLMXJIF8If7QKel7pxAoCrh?=
 =?us-ascii?Q?GTgN7a8pPsuvXrr6zdePgHbXqWr7Fo/vGU0k9tgHQytbTJDWo0rnyg2GCESY?=
 =?us-ascii?Q?q6HIJrR8uPioe5YpnSBDcoWHZclmaBpT049MsEqFyux4mIqTeo68sLnrNGrl?=
 =?us-ascii?Q?/plndAxl5etyY4nKhy4sK8ezECRMZ4bvm1q+Rubk5mxEBZOx03W1Zy+OaYBi?=
 =?us-ascii?Q?1qK0+9NwuGr4ZnczpuXEDsVBVvNW9qXa5vpxlscfRX8QdZ+R3j1u/7b3EmOq?=
 =?us-ascii?Q?OZJke8bk1gkTlCkjecxB5UJSZtJZuzuzs0sNHGkMN9Wd4ytITQjhz/8bkJyl?=
 =?us-ascii?Q?G/1AOIVok9xQfzQBGZMYf5xHTdzqs2k3shLix9LH+tNIPk6+uipq8qDbXJv8?=
 =?us-ascii?Q?evuY8F7EiDJq7Zgj6fi1mCGKjMKkbFG+yM1clc5tlFNeVad1+KYJVS8MNVHC?=
 =?us-ascii?Q?+oq2WYPtKeYd3Xmq5w04McDe83HlqAcqVdvt4GECiDRwg2nrMLaE3gV5f5mq?=
 =?us-ascii?Q?zJGQ4mROBE5wUjB3uk34mdzMwCfcZmle+4VQDl3M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d209635-abab-4c3b-6a9e-08dbd5758d90
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:15:06.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZQufibdom97adyfcceIEwxaXSdTm6vQGNQQGaQF3eGyoWI0yCSLJHY28xYISZeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:05:08PM +0100, Robin Murphy wrote:
> On 25/10/2023 1:55 pm, Jason Gunthorpe wrote:
> > On Wed, Oct 25, 2023 at 01:39:56PM +0100, Robin Murphy wrote:
> > > On 24/10/2023 7:52 pm, Jason Gunthorpe wrote:
> > > > On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:
> > > > 
> > > > > @@ -2279,10 +2280,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> > > > >    static int __iommu_attach_group(struct iommu_domain *domain,
> > > > >    				struct iommu_group *group)
> > > > >    {
> > > > > +	struct device *dev;
> > > > > +
> > > > >    	if (group->domain && group->domain != group->default_domain &&
> > > > >    	    group->domain != group->blocking_domain)
> > > > >    		return -EBUSY;
> > > > > +	dev = iommu_group_first_dev(group);
> > > > > +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
> > > > > +		return -EINVAL;
> > > > 
> > > > I was thinking about this later, how does this work for the global
> > > > static domains? domain->owner will not be set?
> > > > 
> > > > 	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
> > > > 		return ops->identity_domain;
> > > > 	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
> > > > 		return ops->blocked_domain;
> > > > 
> > > > Seems like it will break everything?
> > > 
> > > I don't believe it makes any significant difference - as the commit message
> > > points out, this validation is only applied at the public interface
> > > boundaries of iommu_attach_group(), iommu_attach_device(),
> > 
> > Oh, making it only work for on domain type seems kind of hacky..
> > 
> > If that is the intention maybe the owner set should be moved into
> > iommu_domain_alloc() with a little comment noting that it is limited
> > to work in only a few cases?
> > 
> > I certainly didn't understand from the commit message to mean it was
> > only actually working for one domain type and this also blocks using
> > other types with the public interface.
> 
> It's not about one particular domain type, it's about the scope of what we
> consider valid usage. External API users should almost always be attaching
> to their own domain which they have allocated, however we also tolerate
> co-attaching additional groups to the same DMA domain in rare cases where
> it's reasonable. The fact is that those users cannot allocate blocking or
> identity domains, and I can't see that they would ever have any legitimate
> business trying to do anything with them anyway. So although yes, we
> technically lose some functionality once this intersects with the static
> domain optimisation, it's only questionable functionality which was never
> explicitly intended anyway.

I have no problem with that argument, I'm saying this is a subtle
emergent property. Lets document it, lets be more explicit. The owner
checks would do well to go along with specific domain type checks as
well to robustly enforce what you just explained.

Thanks,
Jason

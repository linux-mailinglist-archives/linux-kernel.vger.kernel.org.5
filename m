Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6665B7D5AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbjJXSwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJXSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:52:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B2BD7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQIJ5malSd+6bBIbKL5mxtcfWAEplToSHdD+oz3MkHlkvosZiKv//BGmnaXfp0/ZmkphqZ2ksAPIRCeYLz1DaM0uULzgGrgTFY73ZNRAQdZqwTjPnUlHA4ko8yb8r8dXYS+YehJhxRpDlcGL3N4O6Ubc01iD69LXsRcKQrP2/K9pQZyxAVN7fHlcbW7fQ+BFID5m8/Pl81rwMSFs87jp4lwfRJt8kkz8kbIKaIaZ3iR5RLkW9Dw2BOtwUnXkStx0xh9ehpLgaXxpoJwFA0WAg9D7C1Z4KEzvQMlJCLlIPUzqjIeoOly9AdO20QTn1hdQbHcDY6rQS6DmP3EUl1NihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeRAGNxN3pIy6SI1V3Yqnoibzfd7meZNrj6sq5OIYAY=;
 b=MvdIT7uDyANdScUuIGlup5lTJ2wejtuA9hedeXKKrwO2RWbjq1phqFH6VG8ugXq8rvJ3e+mB2zfK4EO+2SVbPKPTgk4gXCG5Y4i3rxOXb9zB5zCzFIHeo6b0xvVNDV42iM8R7s8itkc79EbRQ15E4OfyIP//J46qah+UeLCEPhZlqkm0FEH5wYsKqKklIX3g8EKAnlHz8WfNkO41Suf8xJZ9GZamU4A+iRnXwIP0UFaRZt/eSSxumgCD7YWNSHF9X7+QKQsMzBo26bnolJjtcOLQ2CCWFsUUuQIAOMuBZC7XjgjPS8KOitCZFYi1D9xISWP9C9XCZUPXCE+1E1skHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeRAGNxN3pIy6SI1V3Yqnoibzfd7meZNrj6sq5OIYAY=;
 b=RNuUGXlp/UJiq2IZY2+w7OXX9ceubKBCo03pmW1j+VV4Mlgm2iuIQqgBwZ+fMjYnnCmDyOep8vdhm7PFhYFj5A97xXxvo7ID076XYz+np/tvlDCncIJ7uqQimg+5RrCn4qSJTuTypTZ5Nwh5rVlgGaNI10iHb8y1oeriH4vwuduFNS621PcNAoX8GLQosp2fZjG0fPaYABgDlJj0kd6Jh8Nh1VuM2ICY0cym6vOOoMgoWrzF7neGqgDj8SvfAUKoWy6QsRDd8oNRlqgRVOFJdlHwLXqcaXr4kqf1lsViaPXSumDVnvDA3rHkukAhYP1qCoZd9yuTiJASe34KipwJjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 18:52:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 18:52:15 +0000
Date:   Tue, 24 Oct 2023 15:52:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] iommu: Validate that devices match domains
Message-ID: <20231024185213.GA1061115@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e8bda33aac4021b444e40389648deccf61c1f37.1697047261.git.robin.murphy@arm.com>
X-ClientProxiedBy: SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b17e37-6bf1-4bf9-d430-08dbd4c2572b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4U7Ihzqbd+KkmupwkErZLeTO1tmCJ6m2pITVVQurbpfu6mDSzR58nFbEaBjJhmJQoI+SSMBKzDFoPKJcv96baYkhEXQ806NlT2AUXSpBvNM2Iq5ElhQf7Rs30+Hb2oR+QkAufDqogDKQfZo6BpGXDSqxaMAFXpdOYboNEB4OrdBz9CIuPcP2rPKgpjc5Kse42hXpQYdDODbaRSmjRYS+xW+9D00mymFG3xHZzewz+vyLz60/tyKz61tIY+XCiQS2pWngj4+3QPl3O7LSRA/0c35nflRQhjDmdyjaIGZU0XqJqs6lhj8D+rq0JRpL8VEutZPZM1Ls5MK11burjtT+DcqHLV1byhCvqqMdoyih08+1xz4/H2uYZ5cxuj6eeHTVs0m/7Zb+HKFJ8qP8e4E5vnvJluPQf42WdiycNSDA+lTlBrLKCH1/HghAPjvkQtS7rE03l7cb1z8DMBA0G07ypVH/M3gYK+06RERxV5vxbEe5PvoGZM/BFlXg/mpDUq6poCyWgCxJsHsmhCRPbjdmERtkxS5kTIbyY04xxjz3iaBMzp0fbf1Dvr34W4KjEuw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(36756003)(38100700002)(2906002)(4744005)(41300700001)(5660300002)(86362001)(8936002)(8676002)(33656002)(15650500001)(4326008)(478600001)(6506007)(1076003)(316002)(66476007)(66946007)(6916009)(66556008)(2616005)(83380400001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1UUxXPFhCzZYRNmiPaOVwyC+CWg31CVL7htttvVUQXXMfXdrAetTSPPK3oz?=
 =?us-ascii?Q?I66+qYUhfGPBgAmJ4OkYfoEcloK8Xk6THgfYpgOPrsUqCeiu8uQYBJk2YkXO?=
 =?us-ascii?Q?Mfc2U7c+xdBMRJNdZ7howjLADxJIKgyALqf/PZhfTGsNCMfTCzLaJ8yt5jfO?=
 =?us-ascii?Q?alba9d4XTwy62njs2JnsB7wUJtwTAuRwEu5z74eJkUiMF8h3HwXDmGD3EPmd?=
 =?us-ascii?Q?qISKZcp1cL+6EcHKe2EEUqRUt+oBmsjNJP2T+5KrI347c9IW+Wn0kzUxFZ8k?=
 =?us-ascii?Q?rVOPFLMfo/R/Qndp4KAxrZ+1K/Tqm9XtFd/9Wf1cr/NVXducUFs1z75MQed7?=
 =?us-ascii?Q?tbZ1yfgMC1Px1H2yrYrfeB2UQuO474uWZBj5FjPkxLVESJZdSuq8/ldoed/Y?=
 =?us-ascii?Q?LhbSGH0mgm4Y1Us3jYMwzTidFLDCYqE0ipa7/MeTffRUopnI91kabTF292lm?=
 =?us-ascii?Q?qrnZXCrsLQ9QKz6D/T27s8nRhaMY8ZpFQV9QAW38OJvC/uJIclv7ALuMbnhU?=
 =?us-ascii?Q?GehzqA6QQOjRGTFX6hjyaaAsTeOEvExVJWuUg/q8/g0pv18vGrlqnyZkFygO?=
 =?us-ascii?Q?gmmB0kWdgkWVvOEJHbw5V+guiY4ZDSAEQq2Z2lNqkeEryL3JRzES1wtv8Fls?=
 =?us-ascii?Q?8aE+4SyLzsS9rVNydUf3ul17wf5nImPF10MvA2hUOHqyWrFMqwWzLpeczG+d?=
 =?us-ascii?Q?diLIJ9Rrii2G46FT4Irr/wiyHmGKRSEw1dZi3EKiE9z09Kq1LySOmqFBQv8S?=
 =?us-ascii?Q?vZHi4RBP98EkTlwFEbzYwaN0N2DqkbLO/e2/A6FgO1JcA4mqR5/8YdaNmJal?=
 =?us-ascii?Q?RemXdEm0kpnC/9U/+iz5cNO7V2he2nm1ntGAmRaW9PY/s/6iBcboE5huZkE9?=
 =?us-ascii?Q?kz4hjJO9lOurToei0jhiftajmztshNN+UWg8WgAuR2gQSD3Ittm0kbQtY/RR?=
 =?us-ascii?Q?wTmRKosNGovSo0cx1Btig+x8exM6bNG7z5NNRBwRPbWgqzwV9+LPWveBwiwU?=
 =?us-ascii?Q?tZgT96iyDGXSUtA1btbv4EPdhFsv91k3jE967IPhDbdLCoHHkBmFN5HfLveO?=
 =?us-ascii?Q?ieckuKAE6pLN39J4mOY0UY9o3XnH6kDiKV7/9aak/niS+kLXvzpoVjND96IL?=
 =?us-ascii?Q?zVRez1RDo2hTEvAsTcP7qv42rKiaUaorLjgJM8KGwxzCR8i+I5MhmL9Txesn?=
 =?us-ascii?Q?qbWqhYchZ5LVgi7nqEXi6HyqvwfGLZ/2qHyCV0H6dZIc/PEDdD3qqGoJAPqs?=
 =?us-ascii?Q?pEqy+87Jnpf4PmM2+b4H6j54EzZH4x72DZ5Fy6+k2zxllK9fPNagIUmR3o/r?=
 =?us-ascii?Q?TGH8UqYbGgqHAvr9S6dI4ZmVfqnyrw6Q+17aGtEYY9TyLpM4OueEqnmzgZLg?=
 =?us-ascii?Q?VUXWjuWVY83q/qIVLrmqFybooPW5dErluy9zOgYw9dnBex/9QuUs1OYOSvhj?=
 =?us-ascii?Q?FsmAG38V3KrWpkFv31zwIRvsnHpFp8aB6ytWailQ8AwGB1o5+3LPj+QKuXZ8?=
 =?us-ascii?Q?1l/drV1TkWRXturVGCgo4EofgqOBXbCT2t7WSv1WDMEEmRq6WVc0pjVbarI4?=
 =?us-ascii?Q?TdhA70COSPxjr3ivSrdCS7bNlhWeLwu6XZZqgSQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b17e37-6bf1-4bf9-d430-08dbd4c2572b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:52:15.6425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UC8V2masUhCiB+irWl0jXje8oMXUKV20RfPQmYfwG+3FZUJODaU28gsyNBdScFlb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:50PM +0100, Robin Murphy wrote:

> @@ -2279,10 +2280,16 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>  static int __iommu_attach_group(struct iommu_domain *domain,
>  				struct iommu_group *group)
>  {
> +	struct device *dev;
> +
>  	if (group->domain && group->domain != group->default_domain &&
>  	    group->domain != group->blocking_domain)
>  		return -EBUSY;
>  
> +	dev = iommu_group_first_dev(group);
> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
> +		return -EINVAL;

I was thinking about this later, how does this work for the global
static domains? domain->owner will not be set?

	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
		return ops->identity_domain;
	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
		return ops->blocked_domain;

Seems like it will break everything?

I suggest we just put a simple void * tag in the const domain->ops at
compile time to indicate the owning driver.

Jason

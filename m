Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C44782CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjHUO4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHUO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:56:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1980E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy2tJHdRSsSYt0H/rtrfbBdvVzYpHN8tB/+G6GnETf27hrdHg1THvAfPAeEFUZfe/mTZpMgOoG+B6f4SBvQ4gOONzd7yqEe8B3AHzT/GheFRU5q8HexCXN+axXfKJed16bX58bp6UdaGKMoJlJjY1DI5SG0qxUUvh7QSz6x1OvDk7eRqbFi071q+ECw5+FB8n1OvF79jz8VV7Kda1cW0qjgdBMTNHsVFFWGuOaPlQZes18/cGMJcZuLmmRUXlG6JsvpMu5yiR9FkozQhUJ5dn9LrfExdGGhERjQgMp0rHfRyj+GsvR+JgG/NqtSXxRs2c71h6hT4aFdQNLq96umR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7i/AOHReMWrAM+brwW3HqS8AXNJQqpmmBX16HeNpqk=;
 b=grXnIie9xzhxdZN/xr5akWQTRdnxm4kQzU4aWOM/0tUEDGaKM2vnKbATyUsZOHRPN2OQzilK8ceXi1kvLEZShQvajxTvDzXTZkgNecr26gHJ3C7qLzADH6DzcwyhNo1kNm7KxyYuR5vhnS9m2G7LTtQD9VJmh4y8zIV/483f5LLVA4V9wRUttK6CzCKj5nNY84FtrsZfuv3onMuPT7XOMzy6m4ERkhWwSRe4By9oggnMirbbYc1xiEHrOpNuHX/NRVXk7V6b/eC9pKxz/B+v+U/6e55Hbd+/yGUP9Vbxq+D7faWnBSbrq/yfiFNJIeROGTyY7Lm8Ogak8211kltD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7i/AOHReMWrAM+brwW3HqS8AXNJQqpmmBX16HeNpqk=;
 b=LlGlMDSTWeqbM1t0w0Rmk5KDW3pL8D7LycALnn5tL/bxUw8y9f+O7z6dHYMuPl/PUOSQC7lmxscEQT8DM6h+7XI3taOU6XDWCB/M4FgsR2ClusQKJ10jqZdLovo3twzXPznVVn625HdDW32ZPThMBpvSsueI/KlfSQuEgtMjYUO2yXYuwHcGA+3RmOP7PauaVRBZejClC52oLJPrLvfVZCfcWdtn7NRkuaXWBRoYSac0krHED/hAIvcY53F4EclPk/hCjMO5aPdj8QSlWDjW3kMNSD+DiDyZ5RXGzZz9ysBqzWswZhNGkddFiRjfQ/7g9uJ6r+x5AKHLV1dsbS2x6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 14:56:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 14:56:15 +0000
Date:   Mon, 21 Aug 2023 11:56:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZON7Dt4Hkf8iwaDC@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
 <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
 <ZONQgNh6qarqgA+f@nvidia.com>
 <CAKHBV26oTZLssq5bopePojqgrEJwukKHYEbhU02nAvHHVB13mw@mail.gmail.com>
 <ZONrkVX6kZjX/wus@nvidia.com>
 <CAKHBV27PL=2jxOd0BoYdoBMTu_0rm4z_JP6iG+SVi5Ag7w2kWw@mail.gmail.com>
 <ZON0E3KV46EEPw/p@nvidia.com>
 <CAKHBV25P9kNGkM7f5Xc-HsozK362XzMz+NnLa8FcWiu3FFr13g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV25P9kNGkM7f5Xc-HsozK362XzMz+NnLa8FcWiu3FFr13g@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0428.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e50bd4a-03ed-4f82-fbff-08dba256c4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88i0y16gCTWYJGZyMRc8Ms3/W7qOhV3wHFgHL9Aatzzxfo+ItLxs55M66YzjWpgjUUP1+KerpiiHC3qY7ESS6GTtdYQy0YN44IyHRDKnFhOsISv7IgZZZ/wZf+uR70ai8E5VPeMNuPFcp/y8z3mzwvfSCgEBaD1TT5vuk+9gkRXFLBP29r1xZeJIlsaSui4JmgYtdVu2LMC6MEWmflflAS5JHUKvIspoVFqjskLZ4O1f1OcxDpmwudQ+qmLTwvgHJrPIb2oB+1EDBmWWJeOiPzrpCHc3XNtUVmwpIEGgZ6ajMyesNaZJi9E444WK/DNw64plxgQEuywJGyYu/FAhm44WYFAlrK9YEzgZHjYU/mtrMzixxTg41qyBkFpUgo5BtDjrqEQR6+sPfnJRjzZBNTYVnVaNCh9XfJKbgFcFv2w1pZvWrwd+OdNa1gSbSzbZFCOMSnseKydwKucAZxse3khicx78U0s3zVQDx34AxYpIa53zr5X5NbHGUY086VF3wcgsExeevbB6IgFaZbld5+D3V+djZRsW+Vcl8kPrFOH+ynQKC4MgPl+0Z+1dIHwZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mHHlPvWG5c+lnZBLDYLMePlUnsiR8PUlv3zoXfiCuAFs6xuL7NqrVWZgyHk?=
 =?us-ascii?Q?UEjy4FtlwbaBO0vn16XSama6uZbGgMrwu7gmqcm1L3szjWLjl3MDv26muw+I?=
 =?us-ascii?Q?7jMqHwN8FfdriljhW932kF1Tu2XI/t5McmM43khg5ti5HdvXH+drO2iURY8C?=
 =?us-ascii?Q?xa4TbrZvBIuldN2WFWnlW5KoNaMTi01adu507JkOgxDt02Pixms5E5PewrFP?=
 =?us-ascii?Q?GN6QQ5yXAzZE7W1keO5fW9IqWv4PJmxpzNbdv6Yj3vkXtoKqhkFST1EHPOYz?=
 =?us-ascii?Q?GwJNEQlzDUiDR0MzQXXaZAM13Mv53KgZRWZIOeCDVrKBTpP2G9hzmQ5hvWXC?=
 =?us-ascii?Q?wHvi5DihCxMlZJNnRCcKqRR9Xztqs5W7mYHVN2o37w02ZxeuKMNPiSh5pvdx?=
 =?us-ascii?Q?lMhFjGvjs/PnDyAWQEFik1ZyFUiahGPN9GUjMqsaVOFzMl/2bgZyZn6o6ax2?=
 =?us-ascii?Q?XLlz/jmWQ3pC6X0Y3OCmCYVWDlzCDdEbYQolaDuxcfWfF9tftTHXSirXJQHP?=
 =?us-ascii?Q?UpVuDHuEf+wRLffNrAJeDbFKTDqsslFLEfdfwiuW68FMA5V3bfyMeOyl5IBV?=
 =?us-ascii?Q?bR6xtzUOSfS1duLj89CPhPkqGXp5WyuPPsm3Wxr5pQSKe02LQpArFIqDIbhH?=
 =?us-ascii?Q?QnRjNkvYxUeRwJ0k11QBG37g7T/c+nb+IdIL0PnzqSIhq6iJzNf/O64GpZfE?=
 =?us-ascii?Q?eOsZCNRfK7GrvLnh1i/nH9bxRf5zJnJ/VGY7qx8lQpIbEoKxg2AEIj4TfXax?=
 =?us-ascii?Q?ukHViIx5eWYCQ/VpNVmHQm2vfWxcUe5bbdaJzFjaXI8w/PMHZ4xrXm6DNcos?=
 =?us-ascii?Q?YYRSOZ7TNAyCtT4vtxeitiuFqxNgYoHrcw9HfyvVnmaujslmmrEnXh7cuDMd?=
 =?us-ascii?Q?bAU5zV1xUogVLi/UtIv8XjVKqTnOejVuGyiKskPY+C3Jk2o3x5bcRKQR9M5l?=
 =?us-ascii?Q?NBmYAM1aulUAT8uz710yKzYfySk449Dp3NVY4sH/eHM3XwsVkK7xm48j6Ob+?=
 =?us-ascii?Q?6atEbL+QGU6EePwnq930LTpgWZ2RAbzbZNM7Ll8aOG8j2+8Btzm8KpRoeudR?=
 =?us-ascii?Q?ZVkVQJS5J4aq6zWFm9cd8KU0H5VpwfDzkRRppEmJ4gq60XeUhoFzZf9swvky?=
 =?us-ascii?Q?jjiu3/lg7gW5hAajs6vIejxuLmHZ3yNhdwbZ45Z3Kpj32cs4BzTivWjI3N2e?=
 =?us-ascii?Q?4cOt+AV5Xutgq0uNTPpGmyGmd4oVSU8ES4NMEmZxU9vf0HRDy6bado68v+7b?=
 =?us-ascii?Q?Sfa7OAr1jcWKJcMay0LpXAA8z1Pe77J5uhJ6YA34tHrmYnYfcRAv2+t1zn7f?=
 =?us-ascii?Q?V1Y+6e6EElcWUveif7+dk4lKag23A9Xodih/L5TmnHN+WDj834hFXWUFD3wj?=
 =?us-ascii?Q?if8XKwfc9P13L85seg06BYWno0zmCMhShpcU1KJ7FVvR5k6q6yNH3Ae+sOwQ?=
 =?us-ascii?Q?xlzuYdCGfdKiqSSJCIPw2BKKZrWcP3Qzs4K+wdUcw/HWZDWqFFYEvQqS7WWE?=
 =?us-ascii?Q?op+wYfhW5te0/ZYbXa8Br1IP60KlSJzYp4MKSGPr441xjmZ9YOO7DsLWRD9Y?=
 =?us-ascii?Q?LP0V0CDXb9ErEeKZEg/dZx0x2YjUp60fSm07kjxh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e50bd4a-03ed-4f82-fbff-08dba256c4d6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:56:15.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pM1wp1KlR3V2LqKd1ABB60Vk9cgnMSLPmrzzD757djh+yM0htZl0WqlAqTSryX3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:39:14PM +0800, Michael Shavit wrote:
> > > > > (on a loop over every smmu the domain in arm_smmu_mmu_notifier_get is
> > > > > attached to, which just at a glance looks headache inducing because of
> > > > > sva's piggybacking on the rid domain.)
> > > >
> > > > Not every smmu, just the one you are *currently* attaching to. We
> > > > don't care if the *other* smmu's have different ASIDs, maybe they are
> > > > not using BTM, or won't use SVA.
> > >
> > > I mean because the domain in arm_smmu_mmu_notifier_get is the RID
> > > domain (not the SVA domain, same issue we discussed in previous
> > > thread) , which can be attached to multiple SMMUs.
> >
> > Oh that is totally nonsensical. I expect you will need to fix that
> > sooner than later. Once the CD table is moved and there is a proper
> > way to track the PASID it should not be needed. It shouldn't fall into
> > the decision making about where to put the ASID xarray.
> 
> Right I got a bit of a chicken and egg problem with all these series.

Yes, I'm not surprised to hear this

Still, it would nice to move forward without going in a weird
direction too much.

Once the CD table is moved to the master what do you think is blocking
fixing up the SVA stuff to not rely on a RID domain?

Jason

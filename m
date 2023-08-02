Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925176D09E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjHBOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjHBOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:52:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72271E43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml4ic6jKTA/DlVl/150XU980ABMZSgurQczVOhv9E0X9022A/mCAxkv/nodaU4q85cYzOd+cZZWsQUIpZ0N80OFV0XU1XSy+db4JqbD5N8Bh4nDFfJh3hAxG3BT2NzholwJh+EXD0mmtYZ2i7Ktfwd5gG0CX9YFnsNwvrZWG+tz8VT7XiPVaU1ksXyfIoyNjDYEpT/gBGc35ChRMoTYinXHUyZJBPsm1eajksBmjZpkIyDUDaGqeqE6AafnUy6rPBlM4nqRuTAKGHtga5Wa1ittnHzwlyVsnWrsE8eDPSX5hVr807iFVG4wNwETJKyJoWrY1lx7b9NMLkUds8a1OTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C43Q6LwHoP8qd47g2u1mY48J+7Vt0aXRt186oem9ixM=;
 b=E0aQCaVP1HpUP8AjRdjs4h2qjqfFuXdhQM6/T45YgoINlijjXpftgI28s7bpbGcgdK9wOuuEEP9gkIWj9wD/qzufg2bsdCS28qNUwAnI73/nm/Gp8WpRmD7gI2G/hKqWpq8hxAtvQlAsAlo8+qNOfwZ8b7ec9e2Flq/fjcyMcvb7MWKXBkRJfLq3L5gQit38GGiydOAPa2qxryIo9stcO1nG8v9UJl/MsP2+yWOflJFrPQOi6Ggf90dl6B+Q3jSreQ8HNATKBFXzZZJWvMl15BhAZx5UEjd2jwmtj91sREBVyDglhT68YfnO9JnztM+qeaNZQp3tKTE5Ys/Ab6UTtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C43Q6LwHoP8qd47g2u1mY48J+7Vt0aXRt186oem9ixM=;
 b=esCbSthRlFUuTE3PFuxiiMZN/9zSqXRzpMe3eTdKJvVwjDWpjX2qIjm5QXfDyovu0JtpOfDD9dPpSgOFYz2e/XWtSVmz4fsL+J9oA3ul7f7nnxkj5pFfFTEMBx04Ed8lwxgnbNRV70vXQo8uVJKz4pVlaPJ81an/jTDfzSrTHOREvqHFC9VY28rGqkiREjIa96mTDhf9GsrSYHHndRlR7XeqXl+igKN8G3qyDsY59a3wBLtGp2TQrCsLBWzEICGkKaLQOiay1Jzvim3HoEBkf7aICatGNEV19JY6kwg8dGRV642RkRb95uZEPk67KhMf4S2KZGMeZ/X/sZD3nMencA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 14:52:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:52:16 +0000
Date:   Wed, 2 Aug 2023 11:52:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v11 0/8] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <ZMptngQ3vzpJLRTG@nvidia.com>
References: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724222538.3902553-1-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 65458f4c-92dd-4ad6-3104-08db93681040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXuigfnFCgq6RwK3hWrZpquoGhNUmOYv7Rh6V8G4XAo3yJ0juvnr3B1XetF32lGOAsHeRv33nOgGZppQkn+U151+RHlSmmGZlzAffZFaaWF5T7D5T9EpfM00QjorM+kUdSBwb5KBBBXdkBYHwD3jlcy499M3AgWnp3oGy6TrNllNHZVzxkJeUljWaggWxX8TuXKpaPd7ui2co+zVkE4gjcxiGrP9hqLIuS35iMoh325dcS3X9FvbqyEHJH2XICsDfkBYuUrgo4c515JgaCgk/yj+fLf+kPbFzWE5LIwzBckvVVBNvDx5Lw7y4GvU/AlFtkFX9l8bIzDaqO+vjOh55j/iN85x6Pm8DnqJFYjsNOGVfzcdi/csgvvOCr2CFu66P1PT+2TXwGqaRDBfpTo853wjSB0E4GYWxEos5Bs7Ia8lQReHNBWaCfxvKXhhB2enx5Tr6qya9LgK7DmSne4Df3gyIvgge7DHFrGoUcqtJ0sbKMJAvGcgOQfj3XQsKQLDQC9UtQIUlUv47CjuqGBd+C8+WYnCRncqF2zgH8AV4raNwQILQl4y0PnCltBPnxNjw4yOJK2vwYGlsQVrISrJZmFnjcC8bD0JGeaofOiH6oUPfK0RwsY28HrbHVPGCcbYDNvAOZnPVdX2/Hi80Y6Icg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(4744005)(478600001)(86362001)(6512007)(966005)(36756003)(6486002)(316002)(8676002)(8936002)(41300700001)(5660300002)(6916009)(4326008)(66556008)(66476007)(83380400001)(7416002)(54906003)(2906002)(38100700002)(66946007)(26005)(2616005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p9+CPYrqyFn2lnUd47/L2j2BDwZAxe3vRhdwIN+GTyG2bxq7BfBCRWibdxgP?=
 =?us-ascii?Q?OuWeqJ2+iwxH61Bz4Mxai+k1vbEfmTfgxhagJ3rM0BP+XZaN9KFcY/41MhSn?=
 =?us-ascii?Q?XxHvu0iR6rYhdvYV6yuHdq5AcsF+tugDNJblYSmo9pcip0lfuqQQGiDitRBc?=
 =?us-ascii?Q?7aOUnyTYA/iRtX89p924Hzqxhfyqq3trlK5jM4gPNir7+MvYmsm/a7n0dagB?=
 =?us-ascii?Q?Xab6YMSOhDjGrXD72wdLKuts0bEpuO5+rVWbxOWnaLga6JlcL8JhaWwoVmnF?=
 =?us-ascii?Q?nYVRHH9lVGFaopEjcYCkgIc7skL46Dq7bTY61rEsQ5dbd8QWi8CaAzEq7M1k?=
 =?us-ascii?Q?2qNuTEHP+z3Ubz1Si4g6pC/ej9uKICzieOtc/0Pm874qpBjgfkwcvsapf/xG?=
 =?us-ascii?Q?0py7kHPEMXNbDbWi9929P+cr25tW4DTSsCSEH2XXDNs/W/LvwmoZ44DXkv9a?=
 =?us-ascii?Q?YMxBePSKJgeOL1sIiMfSyr6a/woVlHiYEfnafmzFATgG/WXZyKwppMJqUe/y?=
 =?us-ascii?Q?vnoYK92IxJWKzH0aMcwIr+HnCGSvoMXtKkhKnNKKMciiqyXH5wJAOponTDrM?=
 =?us-ascii?Q?9JDU50nv/1qoSA3E0foPvdMJ58kuN0dtyMgJDTDbU6ZI3Vx6JmswmLn9ZWpx?=
 =?us-ascii?Q?4ZJnnJN4heHBSK7lAslx0pa5wLUoCKWzbZyPSi5pICXOoJ/eWQF5tsk2C9if?=
 =?us-ascii?Q?80MbPVsCD2rv7qk6uVvEMFOwaFg2bZAd1aQ3YsR2JIx073oyXDX+zJrP0Kzl?=
 =?us-ascii?Q?lItT6VUXYjZ1CaLl99yixsRxl8P/Ul14fgk0ZrPotlb/jxhjo6D43ReU0rnd?=
 =?us-ascii?Q?PSUaZNFhFU/VsyedX8iUzZC6+oTszZlQozm1kYbkLcAc8s10Rw6wn8tUQsJW?=
 =?us-ascii?Q?iq9VyJURoFdUkJBS9ivRFIjriuFmO66Lb+DC1kxnTQ5fJLWZZupXfrQiKCL8?=
 =?us-ascii?Q?6Sx+tIppACjjBcYh6jOFFmpqJqQdrq/fEiRMQvmOfAkPQiPulRTWu5k9Ya4U?=
 =?us-ascii?Q?/A/XbU18s8BVH1FR70/0/j0ojihwTlndtM23wzOrUKurfzXTo7xlbrrE05uA?=
 =?us-ascii?Q?q4yCa0ZMVBVSjor4ihnko7Mo5f/skzSMc6FUtLJT1ALYiEUd4dRSwIWHI20a?=
 =?us-ascii?Q?z+h7PBKeVgCkWyuwy+Ciimr7juPq74d/FpPmtcX5s9P+le8RFuQ5yVA0/lse?=
 =?us-ascii?Q?LWRzT9Yn/bUV+7zZlM4F3L6xKI1z+PalrIC0Q1nIqAYjvpH8ocFUqAHYrQBP?=
 =?us-ascii?Q?rA0kRnf0Fk7iPEB+8AZVAXDGnwW+k97Ea1rrCXF5sgCn3nAv88AT/FeaAQ/t?=
 =?us-ascii?Q?Y8BxIBgckqjdXyub5aoCnyI+r19oG/UIIkdpwzLMuDZwaWRFrN+In2tOQZG/?=
 =?us-ascii?Q?b+Cf269niESdV1jwymNML5D/gK3lH0Am32V5a+0qibRcMwq5t7i3BP+cY23N?=
 =?us-ascii?Q?Pf54q4x22boIVoDg1za+0hlJ2RrN52UReKBG5lq4eCK7VRj+meCDldx2eQmq?=
 =?us-ascii?Q?5YNoB0g1ulZjfPevkYuxcANM03CfQG0Tl8tsWsNyIf0/opN9wyLm141C3AFj?=
 =?us-ascii?Q?VGEvRsskFC2wAC6jD7EXMnWZQPGt3Bk1oC9dqjJZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65458f4c-92dd-4ad6-3104-08db93681040
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:52:16.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAR/PKSfv4KUircv77GrdDELsvH+eUWzCe39MBcopQLTKJL/IEfmeJXr5cB+gaOy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:25:30PM -0700, Jacob Pan wrote:
> Hi Joerg and all,
> 
> IDXD kernel work queues were disabled due to the flawed use of kernel VA
> and SVA API.
> Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> 
> The solution is to enable it under DMA API where IDXD shared workqueue users
> can use ENQCMDS to submit work on buffers mapped by DMA API.
> 
> This patchset adds support for attaching PASID to the device's default
> domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD driver
> can then re-enable the kernel work queues and use them under DMA API.
> 
> This depends on the IOASID removal series. (merged)
> https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/

If the vt-d driver bits are fine I think this series is OK

Thanks,
Jason

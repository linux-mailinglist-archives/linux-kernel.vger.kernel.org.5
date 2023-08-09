Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A557764F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHIQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHIQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:26:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7361999
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBPXX8v9Eu0Mn8LH4uVp+tQTtVRna9dYnaOOUsCm5axRI8c/cElvU9R4tk9c5wfDquEk0RRqKUMq8j4Wfw/HZAWymJZWpHwZEBQ61/WY5WuIvGbEqzwdqlg8/qM2sJD6yXM3Mmhc8L7/OI0ZtqfhWKe7sUFhqAtGyl89toPgYQeHbGVMpkH9qtbNDUdfSUvtA1A+eV2gBvKtNcnbw912iYUybtX7dS4/98GBdIKu9HoxyuxnM8adQBNe+tE5dOvgvrueeo6UGeAlI+ZBK44QFAP5vmI7NljPnCmQtvyycrVuzPTACOWi6XIhOJC2qp0+FWHvidM7fbK9tBRMkoMR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIMBe4Q3sjWD7Q1xhfNO3c9SwC088yGbqiUDWAjF4GU=;
 b=JbGR+w6yvqKTYG9ixDyQtAPBIGdXek2ojnbDcAWXY6VIl2pnv1aFVUpsYX3vF5/kEBhXvOnfxQ/7/VspZGnEe6dzWKHJITA08tSqSrpyHPnPUAHEU8gFUo+CWt1vnSavgu6EAG20kXLH1Bwf9/BgvjkdUCUIQkPD8l6Dd2Bi6uphFm/BjVfiZXluUISpy/Gou0EDolyJesKXEI4lRgO1DcZc1vm2/HMx9TXMeJcYziG6pBTbt5QChceUNb9RAlD8SyFcieon7iAlkHD1l2tvGXecOse0iyryjTtCQU1tNwPss11Qjus/TwS119yNnDX6HpbyPFYVcxkxH6mwe+CECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIMBe4Q3sjWD7Q1xhfNO3c9SwC088yGbqiUDWAjF4GU=;
 b=ixzitjF3QHkFKpNsjtW0SV+4VX2YgzWICtZdrJ3hGYXePdr8PJvwTdfQJ++7ugIpzQJbR2APN1pIAejei5tenjOTg9bXBgbNPK7in/l1iSIVGq20RtKFlZW7KvCNheddbMKteLWtRUvM2C04gWDGIZkFHHUhn2OsiEEzCAm0OS1w2PkMgLf8J1QZpEnM5o7TaTxXhf44mg5rKDN7S9bDU9aJqeevbu7UMj2Cm/iwSLkiZisUgeIFaHNGq8XbN4G53VSQlHGmYDnV6Q0l8Y0wXGsjz/0rTgZpjxM7tgEwlK9rzRRGnI7cwCGkx22XqQ9xw8dZ4ryMjFbebxANYIfNBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:26:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:26:43 +0000
Date:   Wed, 9 Aug 2023 13:26:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZNO+QVkXcHG78KG3@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
 <ZNOr0ggoO9kXHJWl@nvidia.com>
 <20230809162254.GB4591@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809162254.GB4591@willie-the-truck>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 952400bc-227a-4daf-dfaa-08db98f56b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCxRly92iVgzuHOIx5mkYKYqS2bS9bXZHcb3bEr0LJkEmQZBzgPS3rW+F5NoLLgIePGD+HFfsJFYlGdyJ6bZQdG8oVf8c/i5oLtf47jwgr1sg0Syl9MhvKF+xdRpKE0IP0LJE2C74wdRZnPi2TyezSDdFkfWW2FFiocAEJ0MsL3XStttjjh/y2h/5OlmxRexkNLZpiTGjADilqpbBdJgEBOktIxXAUBaOUZnRwQOmzWjvf7LqJWpPn8+0o0XKW2BkjcV+v9zrmlDH6kUO91evZnCGDZlgdvyTUrfaN2BqdajGCSFcFk6JnzAqz5FYNCvSwltYSJZGAEoVoDwkBnQ5en1VKb3O2A3ez+qMiLMvNx9dTXwrorfg/tSLCS9MhmKu2a+KZSJr+Xh5/QGPedChPFwQTwTSBgwbF/T8YzGXjHxOpw4epTcvc76srh8whkYnBBrVUdE2wmI1tRAYotfS6MFygBgoI/pCys/EpnTbNuAj+p0tFolelZs+D8EPb8y+erh+LX0aevt+MyuygpJ7PClMWoad3H2gkdTpjwIqBbJDOnGKAAr5Kjme1XMqIBqPI5FmDQQb2LTlP2VllXfwQ41UmerxRHpdqfsHMma4k+4BRqiRLFh9xE0IaR6q4xuTD4r+V5MRAeAlCcecnut4/FeGs4Xjgj6EI9XzcSfxEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(186006)(1800799006)(66946007)(2906002)(66476007)(66556008)(4326008)(6916009)(6486002)(8676002)(5660300002)(316002)(41300700001)(4744005)(8936002)(38100700002)(2616005)(478600001)(36756003)(26005)(6506007)(86362001)(6512007)(67856001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k65fO+/5zfsahSY/FVk/NMeN+yQ4IzqduB4b+KaKKbN17hM1yEbjt4QqIdsi?=
 =?us-ascii?Q?vgwxVvRkbgkDDZf+UqfiX/jORUi4PiRU7XbhP+PgJrSojtWQgqbbjbXzSLaG?=
 =?us-ascii?Q?MWUNyEQ3x7O50ve/QwShy6Xoi2I4qavrRt/xDU8UBuDxxJsf2KZmBDO/+rwP?=
 =?us-ascii?Q?0Vzej2MmlN7d+8hcrLuF1iW+WU9cZmAULbEs1LPtYahhrt8wtb3ek23ws4KW?=
 =?us-ascii?Q?yhMuBpWdRRIAmwLpTlOEyadz2r1soJwbCuGptJJBuHlKUYLYqsgGRHFIhlQ1?=
 =?us-ascii?Q?85uYVmotrw09nw6jX0aZoibii+40j99yDqq1y61LIBStUgt9/oucYJsAhJ7f?=
 =?us-ascii?Q?F0XLDkfb3nrvXkCQB6mY+UeBPsqScglRarlsdew9REKdWPXBWav7cZdCCsdB?=
 =?us-ascii?Q?fHfhoF0IxATUG788bz1t9RPzR/pfC6asQGKG3qAEG3AOXD7dqvo057T60q7T?=
 =?us-ascii?Q?AcR/0Kphj3Z3rEMl2uW/X1G2UgaEeBeioVU4wDWZWePHjIMcWV+kJguY8IjV?=
 =?us-ascii?Q?KFwbJtxDouaBxBRVHAu22Hhhzs2i3+395PbOp5WBs+X6nchOwXnd2384okQf?=
 =?us-ascii?Q?ie1OevT39o/Q8xUOAh3aV4QFCddJvbzqBMkEiEm/bGQTK5+WZg2LW7h3QqOb?=
 =?us-ascii?Q?d+UHWYihqL1buxJmSDUqIAFf2CHD69Fr09Raf5cQJthwmNz/VB0UXqOp7s/Z?=
 =?us-ascii?Q?zP0CYvES61f9Rury+Dgz6FPszKsHE9X2S22xyA4Z6J1DalAJ9/ulkht78oJD?=
 =?us-ascii?Q?A5WIaXZ5lNSEZhE0fWKTdeMP/KgjUWZMvSCr2luYAeDXyril5L8HX7byUfVV?=
 =?us-ascii?Q?6Da0ujTS6qtTNcXmaf9XTNXWgMfe6fX+6cz997W7N7gA9yAlofGfaWhyLQ92?=
 =?us-ascii?Q?gN3f3VyxStI1nyNNrEin0zlRyvtdaNZS6OSuWLGHRqtl5AZSj/1MPY4F5by1?=
 =?us-ascii?Q?lhBtayzbTmNzGP85T+T9FxxnsUaMoT9N1OA4lZ5L7+maJGRVZQqAFadlT2Nk?=
 =?us-ascii?Q?KewKfv+EnemBDlmDo46Pb2ifaqVTCAGkQQ/EVXjq9ZWOwCO15CTbHKSD15o1?=
 =?us-ascii?Q?j+Et4b6+gLffPEdYYp/9E+DdDeJle4QHyKJKeqNNb53UiORDgBKt08GtWOlu?=
 =?us-ascii?Q?1m47p8i06xEF8PH3hy9SBTjLcoNvUwUCch++sOYf7ow89cClJFCfvWmb0n+D?=
 =?us-ascii?Q?ser9Ahijy+1hl70Ycn5lvMsTiPXio9NWIHzhicbzipWYTUcR34Sb0NameK5n?=
 =?us-ascii?Q?9nAl6zfkzjbfBe0Zh5qidZeV7nIMiwNIAtjBduYN/0kL8fkQlmhd3qzLLGOD?=
 =?us-ascii?Q?G0MnzOpJvpgDhkrIvuWQ36EYwVCm6RLRr7ZjMfnlH8XdcowmZEojKIDRifji?=
 =?us-ascii?Q?g8sq9ETs2bMPhvowDn4S3nXntwBy0tJcSwG0+JaXUcoTUtdFAFFU++EkUVTb?=
 =?us-ascii?Q?s7oW7KssNmDqWEisnJAHEX+ayMJyY++3tydFPiBfySC9g6bDuCc33AEW+5wg?=
 =?us-ascii?Q?2SsyhnMkT56jFiR6AVZtH+63zwtBpO88X8udnphYC5EUDIxaIpJDSt6YxPNt?=
 =?us-ascii?Q?1JBqrL0DS9EtK+uN6I8reoStgkFhfUC0wH/24oQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952400bc-227a-4daf-dfaa-08db98f56b2a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:26:43.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuKfIes6erMtfWT8cpFH5awvbuedav6EDzBZOQ9rfXLUY4pabnOh3gpPh5VXpg1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 05:22:54PM +0100, Will Deacon wrote:

> > > If we want to use 4k leaf tables in some cases, how would you add
> > > that? Such a change shouldn't need the low-level strtab creation
> > > code to change.
> > 
> > You would modify arm_smmu_ctx_desc_cfg to teach it about the different
> > format. It would gain some (enum?) member that specifies the CD table
> > layout and geometry. arm_smmu_get_cd_ste() will interpret that member
> > and generate the correct STE for the specifc cd table.
> 
> Sounds a lot like the existing s1fmt field. Can we keep it?

If you are OK with the dead code, I don't object. But let's put it in
the struct arm_smmu_ctx_desc_cfg.

Jason

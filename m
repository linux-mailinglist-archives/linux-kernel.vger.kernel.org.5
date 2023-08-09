Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0D7761E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjHIN7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjHIN7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:59:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8D210B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0Ouo0x0cxEhsBVdbf/ilYFhZEU1CYzsoh5gDtLDrZysrr/BUdturWaF9ksU3sJdfxqPTtGZuaEVyvW9WKa8Jf3qAZ8aMK/dd+ZhCHy3lgIORBznUqAasbKf081w+1mlD40py5NrW8ZnYzbqkK6HL2uDRzadijPNKBrG2bjeeg/s5r0TbDKpC+TwntZCmChkiR0N5rqJ9Yau7DcmO91iQf+y2HfjQ39dr+ZD9DwnktThSOuGDazhn+17W+mxVlVy8uHkUpxcQ6247HeMUk9eCMP9xzjYjfaXJlPoKe++ZQDTvYQyp75jvZYOzNRUbHSit+6lZY1u9/XKizNQaoHMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnStTIPo+t/sYmhr8dTiDmSQ1WJVB3cm1/G1sVEG0x0=;
 b=C3yc/1lYdvIkdvPCbYFckxJ6XMIVabD6fufIJMwDt591Ru3HDuQjg+oBO1ZziRxZta+BkWmO4WRZAotYFXhIeHe5uQoHs1w8H7yzHPI50LlOfCjrp4EN1BUgkQ435hZ7+yS16oYur2K/vpGy7tPnCfqyDEt4u5pMj+/j7Yfj1LH+oU0Tfeehis9WP+BgzEQhn10wpQv/k11fMYohbdwDvxijVDSDuikbBoGNfUknZIfpSpHF2RpkMsWv7UxKcI3RQJFCC7/6clkwvLTb8Vb3h6ucv4yyyQk0d5/8c9TEpQXZaM65r6aPfY/YErrMiDn5jJLMDFcX1DXXiGjBbjDWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnStTIPo+t/sYmhr8dTiDmSQ1WJVB3cm1/G1sVEG0x0=;
 b=lWNe8cmd86sGAjHDe5NXbKoxRriJ3ifJ0bppb082KCSdjm2Sk/m7XPE1tqkIyP8jsFjLL7fe3FsvrQFrsIQxykwUjFULMCqWoNJFkOuCznzwSw7/6pOTAFB2hCbyZQ7XY1/xT4pXVm3QKyY2SiNVfPnR/4Y+cz/WSrKzH2eeqsj15RlBVk7T3oJBo37nuqiXdxb7zw2UERU22GOSZ061uvIDLzyYIZbX3JKMmkSIm9YE7sSauBXUpnxO//h8hyRSeIGKH++UfxLF4Mt+2vC6yLowPJNad4onllgbgYQyuze5Oxy5jkH8P6oV29sse/LnFgQlslViaW56JGDNxv5MSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 13:59:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 13:59:35 +0000
Date:   Wed, 9 Aug 2023 10:59:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZNObxeogswAYyDQ5@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809134941.GA4226@willie-the-truck>
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b360ed-7ba5-4326-1541-08db98e0dce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYZDrzZi/xkzERVrF5ifyZFWODpZpvYLABX2MWi+svnsWs2mnd42mjeTjHNYs55U4w7dGXUpDvuP9SDK04awvMlsWHNCJSaJm3U6FsZmNic1ntdeZyaQGY97H1CKU6oiLmNSzROVqMiBLgqJyIT3HtL2EfoUccIz1hVsIarerf4EQOte/9WgEYIdpOp/i720hQPQe/oIHOSyy4i0aoQr0WnChPJD/HTI4Da6gGYo5/Qfqf+qfpqTfNh8k9QecZFdE9LFonP4WGCCeM4YDqzFhch82D+nFdWnvcFiNf6s6XX/i9vb60J4I4cDqGcQx86AJ/o/uyaMtcB2GHXY87PACC5vl/Y8FBIIXs7YKQzSo2hmK5zpvv85fS0U/Bef2GrAobqhBNFeUgiSAowcHMTIPG2ThU/WhiqFjYB46HbNiETS4FOphWsA0r7OkEBN5kmUrXoniOlsRQHYzoIawxnwWFtkF9mjR9ExlFNSY/7+6URYwkTaWzA+DPx6iRmJ2VDD0l/LSSDlLgb6wWmDsJvpd04eTkwDtR6DKuFT/HK3iCi727bRzal9VZroT2INwYVGHzDGyny8KivUDAOIKrZDtckWq6D5QrSxx1+G1nZfz24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(1800799006)(186006)(451199021)(2906002)(6512007)(36756003)(6916009)(4326008)(478600001)(26005)(6486002)(2616005)(38100700002)(316002)(86362001)(8676002)(8936002)(6506007)(66556008)(5660300002)(66946007)(41300700001)(66476007)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iA0zVHJRCljOWnIv0rJ2+693bK+M4YyLBh2L1fTc4FA1E8sluOA9o5nP5Mxc?=
 =?us-ascii?Q?r0ft5E3IKRekYdfSAj9max4A+fwam9U9/3/bok9I6dm3VD4yY6YX4DTlUfh+?=
 =?us-ascii?Q?XvkGRtTEXh6JrPYx0P/Y5+j2X/u+60RBGZOjP/vWGP+Yt2pxc+QRMiQTvnpY?=
 =?us-ascii?Q?F5LXLiwvDUdwhLh6DL0+9bnmXK33n17L1JtBjir+Yyc0UUDDawul+qFnDfBl?=
 =?us-ascii?Q?g15365O+d0hMwcvvXzdOwVkk7ARdmt1yNloG/LX6xXcz0DZERHZS1WOrMG17?=
 =?us-ascii?Q?Xx30CYZMJS1oMQgcKDTkkeVfF+kM8EOVnSWNcVztt6JgO1ohycIHW0HMsp9W?=
 =?us-ascii?Q?/3Aa3jQPmRTXQG/gTAYLyh+M/wJe5tqiyc3yjUqfRokiCiUr01bUFLhXl/1J?=
 =?us-ascii?Q?uDN13srhm0Y4MkjPOFmLh6tNdlv7c2j6EgZpl3rHbMaY97Owpz5N718OwusX?=
 =?us-ascii?Q?HpwGdA2MdX/zVfKxELKGjBVZasPvGzKS7bDdi1dXM+RT9qh851eBaqp2wj2O?=
 =?us-ascii?Q?JSEVm+C0UjeRRyb/LY69cHFhumxqEPW5xQ06YgCBcnNY8UdujABt6qqHCpjK?=
 =?us-ascii?Q?szXrGd/J1MGHQa84qhNJZqE4tagnreS1uCkL0hivKxllG3lxBTam7tZQpISs?=
 =?us-ascii?Q?4nN9Ny7aimLlcCRtaMGn4uHDQS8Th5NsEIwYX3LJyHjRoDacwHabc0wMHQ1J?=
 =?us-ascii?Q?rDxMWq60SDBkUeYtcDvN1Xf51C4KGNDdcYbmgpYvoubu7pBc1tNsrtFr2iIs?=
 =?us-ascii?Q?ZEsBrsvsljBLFnTX6339tB6b+XTFBusVP9UemYFk43zdWFzFYwL7bkQmQz3C?=
 =?us-ascii?Q?ja7SJOtiPk+hg1HcboSugH6sPoYFTAXaq4QgtL8z5cMMcjri6nY0/6uQq6bP?=
 =?us-ascii?Q?GwTus7Nk3TO27USg0RXM4LGgC31KNDiy0Ry2ElEpNAnhMtQJatBcvBZEPRZI?=
 =?us-ascii?Q?VBId/CTHySDxgxtf9FAkRwy1lWfOmvWWWdHMjeaQOc1AU/KR1zs/44TwWw3d?=
 =?us-ascii?Q?NGgNYjBbBBwaxPrC4TGa4Q4cKU5COBTEipn8UaAa/u1SUkp4/BBC71ku5s0B?=
 =?us-ascii?Q?Th+3YN5foLcfmyuCJngeaLaIYJC9FTSVOCmBpI/ZbjuFUOiPxpNSTEPOpWUM?=
 =?us-ascii?Q?osrJlaKzQ1eALrLUWS2P4oJPzu/bWZjBIJzlJW5pQduURdMbknzm7/piWJ2+?=
 =?us-ascii?Q?DTqf8o7x/n9trc4fRxiDcZ761aS2SvuyxdhfblLMlU6Em+j9qs6COQTHhiPN?=
 =?us-ascii?Q?1FfRd4yH9+fy6QdZkURxx0xT+FA5J27ha5KyKTajN3K8ViLetszBlDKfQN/l?=
 =?us-ascii?Q?9TOT2pX7/38cak/Xft49SY9V3X5QIxFjwqq0eMZ16nsw+qV8kR1OfY8fMrSy?=
 =?us-ascii?Q?k5451v3N/Bxxb2IzAAh9tHjFB87Ioy4r21p4/7jAoxjkHHLxRde5puN+fq7k?=
 =?us-ascii?Q?yB8LMj7bMiU7DX3qOqJblHto/tisgy68+KeKw4LxxZvd6hLectjX96o8yTaD?=
 =?us-ascii?Q?jOkTMJZkwAjJo4RiRLl2LQd7T4kewRzGCfMrleCVLS74DZdZC4EodR0xdDEk?=
 =?us-ascii?Q?eO2HmMVMt/lo6I2v78tPFQqtcpmTkYnpARdkvNoo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b360ed-7ba5-4326-1541-08db98e0dce2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:59:35.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ygy1OWeTpmP/Hgh6IWM2visz4ZgXPcoxPTaAUScdsf3quNRpTnr+uLbeYvHgxng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:49:41PM +0100, Will Deacon wrote:

> > @@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> >  		    !master->stall_enabled)
> >  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> >  
> > -		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> > -			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> > +		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > +		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > +		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
> > +				  cd_table->max_cds_bits) |
> > +		       FIELD_PREP(STRTAB_STE_0_S1FMT,
> > +				  cd_table->l1_desc ?
> > +					  STRTAB_STE_0_S1FMT_64K_L2 :
> > +					  STRTAB_STE_0_S1FMT_LINEAR);
> 
> magically know that we're using 64k tables.
> 
> Why is this an improvement to the driver?

Put the above in a function 

arm_smmu_get_cd_ste(struct arm_smmu_ctx_desc_cfg *cdtab, void *ste)

And it makes more sense.

We don't need the driver to precompute the "s1_cfg" parameters and
store them in a redundant struct along side the ctx_desc_cfg when we
can compute those same values on the fly with no cost.

Jason

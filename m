Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2218073A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379127AbjLFP0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbjLFP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:26:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A58DE;
        Wed,  6 Dec 2023 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701876385; x=1733412385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VYa0ZDlIMVAoQMoxkAf8Y4pXmPf3kmVBe03izWuXRX4=;
  b=ChT85hbqAUSg2lVX6wcxbUNERwLbnJ+IgYDSj1H65Y1rnB66/SfNCB9p
   lMulh2OF8XUxk7SLEamwnUzxbOJojR9vZVICmkkhF3pKWak8wFp9zz8nX
   2H7v09FhDipJsCKyYk4zoYLpajGIDVk4bWWXXgRgu41umbQKjlpT+ESjR
   NoRYz46Q0LQ0j2q0KCkGRL9AksBbXKJG+CPn/kYddfPaPOrLIg6UuvD3P
   4w8nhllIfUm/iztK3nDuUtz+WXXc883fikXiYOuGvFCFZ80l9Jhc+HWEb
   g2468Xoyavhu/Xcqv97g/mxNTVm7WKSWQsVDW8Po8uA+Krki/iJDSf73L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="460567510"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="460567510"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="12739784"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 07:22:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 07:22:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 07:22:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 07:22:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPM4OfxPn6ZtUhZWhJguBZJKe/GovOswr3Vw2M3cIG2fvgrBsimbPwbSzukm0G9qRFABdUP+KLj7iv3xpS7BIT3iBiTYzQdGuhwMKHD2MeBgsUMh5QBeLbySuS3XuWeWlxoH/ZU3kFyaaY0PGy29lJ/IkRn5jIGtmvuNf9MS3+IfCWcDqlmjCddutHPPHWIroGAIzkm+a4PMok3RCQT/U21sbhZRT/K1TeCs1xAgdtoS8gJd32YeatuXLI62ToOlVXvA1nlaxfJba/xO/GyzStCfOOIB3CM22M0IU3MOFWtdzv2TdOTUUbxafI0UvPUv0nif+B+22r8OTdduQ+ubeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRMZYWF2KIy14I0ToVxWVQlhz7FZtV59bKIDbjis2Wk=;
 b=Ou12rjqoODJRYCEdA6Pco/uxt3u8GdcRv/onVrhfO5OtmvqJT6TXJxepxNZcGKNl63p5GciAmMg+JJAfsWs+3GjfU4vYqFbhn4wpeFyrh+XspDs2yBJTDt3dxnOSQq3ohPq6S2ogrw0TDCR3lzLeQXNY5UuumhnV6DyXzL0D2M8EX+YQi2xiA8qLaZQDrDsIpYUfr0hU1f+TmLKA5XEJCb5JYE9XFJ/3uwrI95TqCOIAErRcHyc+0zilYim4wt72vJKX8RQhcfFewMxH88epXQZooRPKvX7z0OCoFmyrL22LU4BUAspXYUHxRRGkT3jtPFdNsg2hFgXiWYwYiUzjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA2PR11MB4924.namprd11.prod.outlook.com (2603:10b6:806:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.37; Wed, 6 Dec
 2023 15:22:15 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7046.033; Wed, 6 Dec 2023
 15:22:15 +0000
Date:   Wed, 6 Dec 2023 09:22:13 -0600
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
CC:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kmod: Add FIPS 202 SHA-3 support
Message-ID: <ltdfl4l32ht2oimlppyml22q7dst35i6m4foklamapoykkl3ql@u7qmh2aa4abh>
References: <20231022180928.180437-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20231022180928.180437-1-dimitri.ledkov@canonical.com>
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA2PR11MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fa2e45-8a7a-43ee-e0f7-08dbf66f20ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMKfPdyfCSiMTEfUqXuIvKbHmHSC6vLqn9WlYN2oO7hfxBvOTU6BpVxnT44V3L6DxNwmsPOyjGZbZtrO5TP19w0rfZiMDYVVOfckQRhtVEBmhmE1wfnZeVld0b/pyszbB9I78AwFKW4Xo4m8GO8VRxmVzCqVHX2/e4X6PGGZzLE/y46imaO1F1Whp7sjuA1vYSzbeE+afLZG4doYBABp8FQeF69qL9+AP4YOeBwTVoOR9jHEDjvbja8PMyhTXqBPwi01aubGEkp5q4JZERgxLCmgLoubdmgTxjhkEsB6oBxCBFCdcODV2ksjjpTgs0gMCxVaAf/x2hgZ9s2P0dm1ywQL+nO8VQ3jvoWVeSuUDbjfVncoJHiiGYvcCmpYwIY0w+luyTiGm7haspv53+IsXxt3QFreXDX25yTAnrx50aVAUJwNaGEu763DB2dE9MBlo9B9nXWe0KBrqIeiCWFF+0EkXhpREbsh2GiKFjQv/N0BR6vPs6KVse9Zc5McKnmoghrSzw4umFMs8mvmSKBow3U/a0xiBO5PrfSmxEZjQ1vvw5LyqlDn472oFv1R4KA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(82960400001)(26005)(6506007)(478600001)(6486002)(9686003)(6512007)(33716001)(316002)(66556008)(66476007)(66946007)(6916009)(86362001)(8936002)(4326008)(8676002)(2906002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/Y/iAcbvhrX8xe4myc2/G9oVBRF63nnrM35oaZ9eF9iG8CnUlawWPcHr7X3?=
 =?us-ascii?Q?vfBFEEOi7tqRmtsyFT6BCLtKiyKa639XpUtRytWb8wRUUWjW6CndsYpixyJ8?=
 =?us-ascii?Q?8vB2bIuxYTigwBDqkqNZYGZwFwa1SRksBPe7Oa9SWevMtpOiXXTU08NS52qd?=
 =?us-ascii?Q?JX14tz9D2a86DETrsstMoO8KRZ6yzZmQvRulIKq9dlStjGdq1TaJiNfJBag8?=
 =?us-ascii?Q?LGCJJcKAljED7sUD9m+SN75bCyBlukSqGiCpUnSKoUVpZBLVjqbHKXeied4W?=
 =?us-ascii?Q?5fls4qcHwhdFdKWM9ODUQZQ1L+x/cX5WwbtjId6TjgyZzpdFLHvfmyvL708I?=
 =?us-ascii?Q?n2nQOsC6ABPur1Ue4iPEr+CL10ThX3GrYr/LlgcMUE8sgfe5A+ENWzS6se+m?=
 =?us-ascii?Q?JZ7sCKGNT0EPfs4I1L2Vk8XF7Mu0eSdFm3vAmfDz8cDMqiRh1eDUqauTS4kY?=
 =?us-ascii?Q?oeBXYYihQiNs+FvrGRDHWdmku6LcEtxxqAKrXD4T3aTDj7Zz8sbm3zDICiKf?=
 =?us-ascii?Q?fMy6Nf4rFfq1EzBI6FmRjWK6wR2RDKF/CScov5NZpQL14tyBF/yPbXJGQ9XN?=
 =?us-ascii?Q?2M9/gt1b4UZhuDayyIvvTi3rQytS35e2puQ0jiE5HmVNQp9Lyv9A+gSJdXCe?=
 =?us-ascii?Q?wUCqLXnLUTW2FI+T+T6J33+ON6jzwcbvQfGbbJZYtm5Hd/UUlJLiHhAIF7+v?=
 =?us-ascii?Q?24kYKotgVujQRDKnQNPsxnEQ812ZL8mLOEtTOBZSeGXH7JxWe55uo4LUhU/9?=
 =?us-ascii?Q?C8YPOSeos1NGvfaCGpCnsO5aVRa1Mmsm2bMOxqfhDwgxLjyQo2xW7PCd75Xd?=
 =?us-ascii?Q?W9IhFN0DxuOqbMSBuA7n3SJvFlgEXkgNh78X0urRGVbglIZ1ZedZtARTrmWb?=
 =?us-ascii?Q?Rz+/h5VLkDA5bz5VJc5fBQrWS00SfBQ2osveAaseGBXSdzQ/ABwi5hJr63PT?=
 =?us-ascii?Q?GHytXRY131WF4MyVorjX5wD+cko8IGhQZCEy/WpRl9ZmkGdoj4aqoPvM+wY1?=
 =?us-ascii?Q?rtVyHCOAdw7M7NqN8t4MnEQ299i47LxBWDq53PbrMxgUqhrhNX2dBEOYKmGo?=
 =?us-ascii?Q?gW4UFwdXg5Xi5wEbpbhinRjt1Bz2Kko/iAG0KDjS07vus+9zjtimKoYkYK4v?=
 =?us-ascii?Q?x0I6LrrV61yRy3tLkkkzLVydcZ+65+M5U34FS1il8Gr/8nULnvyq5REV6Hx6?=
 =?us-ascii?Q?l6FKycmpZw9Qmm5VGffIjH/6dNd3N0pYigBDzce+KtzFxLv415dm68HCAt/4?=
 =?us-ascii?Q?9P5OwCVRQO9TV/QkWt2I+0C60JkCvUjLgAp/KkTxQEYsiCravOeRaP+LsCo0?=
 =?us-ascii?Q?am+x/6mllsn9k1N6b/P5Asr8LHCIJ6NFxgxO7mquBblXf9Vt4o9/tBWl2PGs?=
 =?us-ascii?Q?aZFFRIWflXPI1fsCgQoTEA8AVtCO8NZ8l9eyCR1S9qahUtU0tf9I+0nQ7Hyz?=
 =?us-ascii?Q?4/If2uN0MnFOyUsDdKOiuWgqUKwvI2bqfW4KEhEMMom/NnuKrm9yGaIIKjxw?=
 =?us-ascii?Q?ZC5luy/4jubHm1WbmNWUwNCqhOECmuQFTfmDp6JoBNrbZzGjoseVIhPMKJJg?=
 =?us-ascii?Q?b3+i8u9zZXmQ5/tqVN4bwa36J4bTz9dAhSMIQiIErEJu2ut+FyDdtuh+PtPo?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fa2e45-8a7a-43ee-e0f7-08dbf66f20ce
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:22:15.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M68sVuaZnVQP5ktzOJnSTcGLipVf+NCibqlxiD0PNb41ikMNu2G+MMCfOgIETreTru1/qlFIkrLaUyKozKCdevHzSmGXnKlxkZDBXQ7eRFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4924
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 07:09:28PM +0100, Dimitri John Ledkov wrote:
>Add support for parsing FIPS 202 SHA-3 signature hashes. Separately,
>it is not clear why explicit hashes are re-encoded here, instead of
>trying to generically show any digest openssl supports.
>
>Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
>---
> libkmod/libkmod-signature.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
>index b749a818f9..a39059cd7c 100644
>--- a/libkmod/libkmod-signature.c
>+++ b/libkmod/libkmod-signature.c
>@@ -57,6 +57,9 @@ enum pkey_hash_algo {
> 	PKEY_HASH_SHA512,
> 	PKEY_HASH_SHA224,
> 	PKEY_HASH_SM3,
>+	PKEY_HASH_SHA3_256,
>+	PKEY_HASH_SHA3_384,
>+	PKEY_HASH_SHA3_512,
> 	PKEY_HASH__LAST
> };
>
>@@ -70,6 +73,9 @@ const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
> 	[PKEY_HASH_SHA512]	= "sha512",
> 	[PKEY_HASH_SHA224]	= "sha224",
> 	[PKEY_HASH_SM3]		= "sm3",
>+	[PKEY_HASH_SHA3_256]	= "sha3-256",
>+	[PKEY_HASH_SHA3_384]	= "sha3-384",
>+	[PKEY_HASH_SHA3_512]	= "sha3-512",
> };
>
> enum pkey_id_type {
>@@ -167,6 +173,12 @@ static int obj_to_hash_algo(const ASN1_OBJECT *o)
> 	case NID_sm3:
> 		return PKEY_HASH_SM3;
> # endif
>+	case NID_sha3_256:
>+		return PKEY_HASH_SHA3_256;
>+	case NID_sha3_384:
>+		return PKEY_HASH_SHA3_384;
>+	case NID_sha3_512:
>+		return PKEY_HASH_SHA3_512;


with your other patch, libkmod: remove pkcs7 obj_to_hash_algo(), this
hunk is not needed anymore. Do you want to send a new version of this
patch?

thanks
Lucas De Marchi

> 	default:
> 		return -1;
> 	}
>-- 
>2.34.1
>
>

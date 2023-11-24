Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB67F6F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjKXJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:19:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BAD6C;
        Fri, 24 Nov 2023 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700817590; x=1732353590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/zU12Syy0a5XuWwE9Iyug8Nyiv1DuTPWOIrerasOJZk=;
  b=asqcTc83bAWyT6WmiwIazVfBiufHutHckmVFcPYaOrpLC0j19BGhki79
   uExVLdyhBSvczVOIY5WoP6hKhBfUNEeOkGc3DvvfHsQobsfvdcWaLrCzq
   scfZr7c4AFdVWRzvZe6YxoEiv7nUQ+K+YSHbOcN1jd8YiZGe2MibJhAY/
   4dPLabLK/UMCTGxj33SIfd30NUwNR3bB/aXyDP5Dm8jJE00g7fmSPc6aT
   MK8DQ1S26ZGz/H6p165JX2PZfYS6SoWGDxVAZJXswOAYWn9UA9DCVAEab
   YOdX1ZzjLDNoBQn3CndPZTGccd4lGBdVD9QOmwWMLrMY+Y4Pg8cOKTUo0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389547531"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="389547531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="796537833"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="796537833"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Nov 2023 01:19:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 01:19:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 24 Nov 2023 01:19:48 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 24 Nov 2023 01:19:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+SOFJ22FuojpeEA69udjYSwvRo5GR61H/0+5udpDIiTvpEjPPStilqDSeorQtvjUJ29np/CJ3xb0wUHgAZCI6Yt6VKTEScw1Ur02guZu3iiaQiirWkxSwpu4fUN2Wk04UNHoI1SVVbGaYtuQHeXQQzo5RUfphDRMXH1f6xSoMeBBHkBbbHwEBedgZ/uXAE7BagydF8OfM//fcp+ZZ54V6RCdhBLLIvril0YteiSoOkkbB7xcCK2lSS0w1FPeTfkLXm5+uOQog86Gu4Bww3t7HjXURZd3jOXo/04EQ+/O6SCkEx/hHOYRXHOsfam3HMrkaWxgV3BLtEUaJFx8MalrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXvUXDHC9nDMUqTLb2vCTo/l5dBOpWUezu7eCywy0EA=;
 b=N5QkUE0H1pvww2sXbF0kYNKHXAFPolHvbotVq9l+T0kRmCcr/wJgxGKE3l6GMo3RpWDKV57R5/4/1047/TKFVtYC3dvXQsCQ17uF0KmLNQzifCmPYnsBwXccGKhqRsFfmxgchYT3U2ODgWyjYjfPu6d/yvItPMnLS3FzBiC1XUNu44ptBNpDGlPeqxkRPy3Zp1yZG3cyHAQA1iFzvlaRsG96kolSYg5+DPUYOHckKkTgvE+tLMggygBdO306Ed1uGYsfWLE1aZujU9Kks8oz6cxbGg8Ww47lTJpKEondWDSTQGgt8a3qY8itFhwfMmQH1ZepCwj+9RVLi+04WhKgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Fri, 24 Nov
 2023 09:19:46 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 09:19:46 +0000
Date:   Fri, 24 Nov 2023 10:19:37 +0100
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     Furong Xu <0x1207@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: xgmac: Disable FPE MMC interrupts
Message-ID: <ZWBqqXMOZ3jcBkqB@lzaremba-mobl.ger.corp.intel.com>
References: <20231124015433.2223696-1-0x1207@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231124015433.2223696-1-0x1207@gmail.com>
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA3PR11MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef63d50-8dc7-4b64-fc14-08dbecce8018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvLwb7FmhLr0rm6l2souVfq6X9EvO82pxnwMZ5GrvArUL5q4RDN6Gk92Q8aZTF+s+PvRG4waQRChSCp4WTrCRWbfQK1lpXbF1nUFCFgRKNNR26wiKxRWbwwJ0uKy8m3LMWeXTWd3CBMpOj1O4LhMuuEUFAfhrIlonR2W+gz7DT0PYrUqRjTkd2+q0PhBT6lLHMlEVgV99JnlwkC/Bs72zZ062/VlBas4s46k6cQKC6d7Ec7GGeAiMHKerJh2Yrk6ZCexarH+ZdxUS7mSbCXYtUS5Gj8kmXdtFuWCHF3TYVgz1GaYdXeovzhsh8JuA6uEj0VlXnvltfDY7N8kLdu+TftWHi6LzzIFv5b48kZkItS3QvxRvgBF3pfl7IRi+pqYEmMJ5d/ech1iOdf6P8iqV8YnPfcn7VpXZcfxTNCuH2ldwkpEt0rr1sGfFkRCJ8JNrJrEGOZnG/GWh6yi67QetWPr9xo/Ewkr0i/fwCOVs7aCJS6X8XFoDhXeqv3aaAS+uZIbIuK3PeE1C9eTZc7q1jxM9zYKzBVrCdzPU+51nQZPyH18tSP4UTj9yg/OdKD9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(7416002)(44832011)(8676002)(8936002)(5660300002)(82960400001)(26005)(478600001)(54906003)(316002)(66556008)(6666004)(6916009)(66476007)(66946007)(38100700002)(2906002)(86362001)(6486002)(6506007)(83380400001)(41300700001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qh+CPZsKuMlj6ScU9mfFVMuNWbxT5E3rVJLST0ckUvLz9fubo4AsdXRbDNA8?=
 =?us-ascii?Q?RCMkfyFa6ajhWo2cMUFCoGrnf9c/+KCBYCZbxGs5Xl3nScdYE7Bv7X7isB75?=
 =?us-ascii?Q?VZ+YPbVCnPr+2HBDVYfTvjiQ+p0qe7ZTTNbFzDS92SCb52AvuHqRE16YZrf9?=
 =?us-ascii?Q?voJaMDliz0B9vuNQvgMV13y5tKvGVDwRqc62QOKQ32596wVizbyhOiUQn47Q?=
 =?us-ascii?Q?IcUMewjC3g6D64TG2FBJSpbxCcmngdZBFRGlpPMLTnck4opUaKCyAnfusoKo?=
 =?us-ascii?Q?OQbw+If6dLxOCm1ja68SUKTDSkkzEr/Ib4Nhs/yDBYsKTD2bSHX+wRjRV/VX?=
 =?us-ascii?Q?rpINKGU1WNyJV3lOP6aa9Pq7eP3cGZHu5dXIJWxFKYoJzjFNj3L6afv3eYjq?=
 =?us-ascii?Q?fIJZVpt6aLHxB5tn+c+qI8QMd2GYnIeaqrGEHQM8oCYmD5vX5kdwN9jpTbhU?=
 =?us-ascii?Q?iDudr4f2meLSBoUP5aPTHZVmdnTV09C3YV6n/pb+oqmWn4uVubjCCdvFRLdI?=
 =?us-ascii?Q?qjZwSzKfMtoP6DbNb0wkY15LLfntY7OOcaKeXxF+UU8AhF1eT9dpfccB6tUy?=
 =?us-ascii?Q?b88xxGuMHyuvPNSmQJ46sF3wdoDA3AjtwDSc6Gd5P5p/eTCB6dyVPJbxFpf9?=
 =?us-ascii?Q?6+PrY0q/0+3VGppFLc2HMwLC9wbUpx0D+noReyQeqhgAACB+Sk/0HfE8zGo8?=
 =?us-ascii?Q?3wjGBsrB9ZoxvWGrNbeQWSvGsaVnKW7dRn1o2m3kHBy7vPRusnI66McqMHCQ?=
 =?us-ascii?Q?1cCn7NUn/jmfJ8uI0HyJrtyA2cT+AMjpf5Y1wXnMVLi3cSiBd9bQXXl8m2/g?=
 =?us-ascii?Q?UOZmH5OwbImbdIHeijK3R3if5gpeCsMtB8CE6ju2702CNmnkzO3GdIESvQEO?=
 =?us-ascii?Q?9e7rOME+fBafcAqac4r8OA4FZyfGSiSASsNuDZz4zYJFioyNTCi8dnk2ktwD?=
 =?us-ascii?Q?zg0cfZxjY6/9LniyAbJunAkTSl2lmAtGS0eJIcjqLnhSDNSGVe+PgolOQRIR?=
 =?us-ascii?Q?WRoNDnTm/K8PDJjkbpDx8m5BAz64KsfqZ2Ivp7AOaosSTmiHlWd3vVHfCFHn?=
 =?us-ascii?Q?IqmwqWbgls3qBUE4+ucnqshCght5M9ZzpN2ATH41EtcptPR50SWJNBQUC9CB?=
 =?us-ascii?Q?m2so6wcYqlwwGUTud0nHV6PpZvgOEAQGY0XzFnKVU09PMTgQfVVYKTxrYAWi?=
 =?us-ascii?Q?qm/u0YrUSIPLrg/7vpYSR5fb0q/nXa6HlnswNKFgGIoiDk81q8rRVfgHkHSB?=
 =?us-ascii?Q?uULEvXkMzGfROFOu1/kjY923idGSQKURiOGPAmUz9C9OjNVse8E7TLTWDqOe?=
 =?us-ascii?Q?5Wrqs/yUd849aYQhfVRcWLHIsEiQe4CHEcRY4U1cyLf4MMdxwXY3qoREeAfM?=
 =?us-ascii?Q?PsnzuflW0yUdTBcAV/w3E4Kyp0O7fLjIMKCuWNyCjVIOZkCM3bp1xUqJE6Qh?=
 =?us-ascii?Q?YozvmA8dfgbVL+oLvDs25sswMlmYcMzmsfRhGdABDjE2Z+vE+/RYIiD3/pOo?=
 =?us-ascii?Q?2zv/sY57iehiJz2mHtz8IuvIuJQkmuBgPrs1YbbjicR34yxdJswjM3vzwYJz?=
 =?us-ascii?Q?ndWqe8i2lEXOwGZYfiSfr3MxQIInsajfizKyH7cvp7tMpeNOX6ra9fRGZCvo?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef63d50-8dc7-4b64-fc14-08dbecce8018
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 09:19:46.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5rcuQHUlswZm52pqmPPkms/G+NOgG+z+0rw8vgyTWmNt78ojGXpE7Ateettn8QoOq6GvAlzRjTSm2LrouFcCuKPbT1bId467rOTjD6HrjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:54:33AM +0800, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") tries to disable MMC interrupts to avoid a storm of
> unhandled interrupts, but leaves the FPE(Frame Preemption) MMC
> interrupts enabled.

Now commit message is lacking something like "FPE MMC interrupts can cause the 
same problem", but I think it is good enough.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> Now we mask FPE TX and RX interrupts to disable all MMC interrupts.
> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v2:
>   - Update commit message, thanks Wojciech and Andrew.
> ---
>  drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> index ea4910ae0921..cdd7fbde2bfa 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
> @@ -177,8 +177,10 @@
>  #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
>  #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
>  
> +#define MMC_XGMAC_FPE_TX_INTR_MASK	0x204
>  #define MMC_XGMAC_TX_FPE_FRAG		0x208
>  #define MMC_XGMAC_TX_HOLD_REQ		0x20c
> +#define MMC_XGMAC_FPE_RX_INTR_MASK	0x224
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
>  #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
>  #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
> @@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
>  {
>  	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
>  	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_TX_INTR_MASK);
> +	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_FPE_RX_INTR_MASK);
>  	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
>  }
>  
> -- 
> 2.34.1
> 
> 

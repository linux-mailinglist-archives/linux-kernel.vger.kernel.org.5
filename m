Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087876B754
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHAOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjHAOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:25:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4310FA;
        Tue,  1 Aug 2023 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690899937; x=1722435937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fL6ZfUb/bWmsot10LPf/VL/L4/8LdokS3aBXRrlaPus=;
  b=mS2eFzItynN6p9tCbNsY1t7/P35/Aei62KFz9bt/sJY86jWPPWxwq9EQ
   q4q61NuZat3cn9MochWBiTV3mmj7SMTRTd4R25Su41rRUaeFhTy6Cyc/U
   JlVCOQJls+bXHVUn3qG0c2VjrGvrghglaEHq8NNf1MUF9Amc5rL8BvZOs
   lf1B+9gKzXiSB6xUdEqyVcZCHKo4p3HZ7sI3ZjOQDmcOpAFSfmM9Sh9ek
   A/S3/XU3otO1J/xtq5o3lx4beqKc757eF/rQuncR+BQwrF+156xCZ45Cs
   UVyYHlEKlcSlpUIlx+r4I4GwUHm7y7Pzirt9dsqH+TEA2zM+sUUZnzvqg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349604962"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="349604962"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 07:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852486552"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="852486552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 07:25:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:25:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:25:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 07:25:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 07:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+DQtZuwGouptrD16yooIc8sS1jh43bEY83AU+7Pplnum6D15H9Q7RtoTRFop37tQnXL3xwlp6ByFoAgXSbx+9zKqLSwlnpK6kr4eLZhamqc1DWbfIiZkRUNGwXwA+41rMm9vGqZVFfHozV6wCgTOBElAInCoc3i2gb8ntxf4pRwh9a6eNZlGhY0lklYnnROXSM6CDwRAMgz8WMWHa/o3frZ1caJFAk4swg9Xm0AXLATV5SWkWfCTycuFxVeg+YfCF4EOEF2a+6oHM6NJLc5+BkMSh/55LpvUajaIT5rZhIbLVjyhEzKBVzjj1KLNLEeGWrOV0GEyX/MOgTYn7DitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLowloLK5ZzWo+44MHny6eQPuI1zCcbXudkz11npUW8=;
 b=DMMiJsY9YpXJEPCecXb7aUSWZNrx9utbpfbe5TLbiMrOAT9bz608xLKJq3t8tQc0gPTWrRrczriJCxwMfZnwb6oXNf8DP6FN9D6/c8w/nTiVji3UR8Mswbxr4n6zRgJO2bQnySJfXYDWT9Cj5zzheKa5iOdgF0pVlYJwUXztYamW1y72ScRZ2/QQQKIvII78jYcj1I/HjpuYRmT5F4/yWfgxAlXRfMKfb263Qwo0dRoSXwyZ1QExwx4B9jZ7qTG3Y3e7PnHX1aKve+hh4/SaozTEXC5AOLplhm+vbXxjbJxWZ+Wh9r4GzhCZMdYgYouVG4ytMdkIV5xdH4BMrjXg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 14:25:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.026; Tue, 1 Aug 2023
 14:25:23 +0000
Date:   Tue, 1 Aug 2023 16:20:33 +0200
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     Daniel Golle <daniel@makrotopia.org>
CC:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net-next v2] net: ethernet: mtk_eth_soc: support per-flow
 accounting on MT7988
Message-ID: <ZMkUsZkxsU5mOOV+@lincoln>
References: <66032a4e2093ef82d2035966212c5a2ef2b6fdc9.1690762860.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66032a4e2093ef82d2035966212c5a2ef2b6fdc9.1690762860.git.daniel@makrotopia.org>
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|CY5PR11MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 42772ddb-43e6-4309-9cb1-08db929b2491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8p73adN2Htqy08Gqb8ugp4gcdq/KcZZMx/coGtje0Y+y4ZleNO9Ib39jJVi0oAiS4QGVnnASIXrzobKTGNzP9BxrjzXz9DktWPUKFWecChOdii+5XA1KwKrO3E56GvzvgWqs0SsDCqdUOAFm6pElUdyDZ30pvvvkpCnNtqnZu3StFFYYI0uKPBDz0QG23djG41C9CD9PZhxbb5simVKazZT31/W54aw8Qa4epxIfmmHWWjv0v2rfvVHovHCc2FXbUlKhI615rvzPqAG7YjoxRWcgmze2wQnfd/WaMOn/ajLox0LPxIxhwR/1rEGjLtBo2XnaJsH8/CmebWLNAgZT/Iw0z41RYnkvkKvHPwbPX4PTY0riRNjwyeG1OTM03tgDVo8uITQElmxQsxsiAY/xZ7lGij6HDWgIQxW7A7Q+DlQqptU1ruwFzN3HDjsTovnKnkeMRs/NWU/ra1R/2IoCQIayOVt/kyFiNQ0yH405ozhcG7gLk4zWThzKIK1KL+W3y+a0Vnuz0Hd8Nd8TJ7W1lMomns1vGsXXfwIS333wLtwQV3zpPdvLG48ahMWJihz4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(8936002)(8676002)(6486002)(41300700001)(33716001)(478600001)(2906002)(6666004)(26005)(44832011)(83380400001)(316002)(186003)(86362001)(6506007)(5660300002)(7416002)(38100700002)(6512007)(54906003)(9686003)(4326008)(6916009)(82960400001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bb68GPbQz3ULc3wZlCrIdNX8mh7CeE4bdUT2K4Jwh9s4S3Mh65T5jWPo9U9z?=
 =?us-ascii?Q?L9FKuMBxj6Si7hB5/vLFb/WWDNdYRnMMVILwGnYIRfwAY3noystvlzQCmLlV?=
 =?us-ascii?Q?eFFvmBdrgcPYqytl9u4PHRytK9X6V+LZn5fDsZC/nMawKRItXKV3a9y7SsaN?=
 =?us-ascii?Q?cfhvvjo96jzi/fh1RzCtW03P9/dTOoCFiK4JoILe2oHPiItqLAbCouy80yH5?=
 =?us-ascii?Q?HIXNyERYun1U7M5tY0aJVfz9VljJf7ded5zJDa2sHIq6GKO34mrk3SB/vorZ?=
 =?us-ascii?Q?qDE3xMA/f6mVz/jxgZrWNNUJe6tP++DK1EFktYhgUVk1Xl0XlA3qSxJwKgS8?=
 =?us-ascii?Q?hCJ8CRbIYO2E6USvjR+3/9R/B8npN30iCLZO3lxRIrnFkUEBU//tQHmV/qvF?=
 =?us-ascii?Q?vWHQWGWqwiQL2FzKyVp/KwAea1WvwSqmXdkDTP35+poLuNAPo9vQ2jI/MPFR?=
 =?us-ascii?Q?BeHTH0t/6PPnLsDGLoAsjXSb9xbj3EB+TRYsmMMiL9V6rvggNxw8sp9vi1e9?=
 =?us-ascii?Q?x8gft85GIsZF2B0CemorU2xKf+rp/q107W04grgaQ+tUcFTjGZa7/abflW37?=
 =?us-ascii?Q?wHOGUn9RLGZ2BObzMz8LOygMUKDwiqq7h//odheerPzDBJygoSc+RFkuK4tM?=
 =?us-ascii?Q?nVmkcUSFGn1rm/7S1bt8+sOISt1RjGJZQ7BdJK25A+HPNtV1+TxaoieBAl+g?=
 =?us-ascii?Q?xFfVy453zoCgAS9YHVhcg7s6xfT3mFimhOgxqsKLqsmXCF4/J1jf11wgm0MV?=
 =?us-ascii?Q?P24XCTBp9DyZCwUrt53xzWQOJB8C/IHfLYg6Ml/4usGM0L4+j0J88VjIvRaN?=
 =?us-ascii?Q?2m1b0OxwPArlpkFMqooaTaXaFQYxShw+tiCXmDjJ0RUS43yQ/O6WPcaLKyaG?=
 =?us-ascii?Q?N5mPkjBgMWZumPOCON7vSBehW3UAqbsyEO+MF+nuBRDuQ8BPBXeKI9YM+NlF?=
 =?us-ascii?Q?tSUcWI2PmdfFIs+p/OMAyTwI3wLgHFGMW9JqjrgRpEyj7XcdfkwkLoEW7k3d?=
 =?us-ascii?Q?8VICe2e4XIPtnacIUAehv2uGbb5JBhcyexhf/FgzBpXKH1+HltpcyeE8B82G?=
 =?us-ascii?Q?puMVc6AuKpm92EHro+1YCAczkXlzICclc0Ut7udUxV3uBK1SqnJslFPI/hCh?=
 =?us-ascii?Q?D0j3zGp7pLwCc+b0bTZVf2P6fgxA9df4NGNNu9moM0dKL/ZFY6Ok91VQhwzf?=
 =?us-ascii?Q?wsj7fpC1sMyzI0ZtdUKzUJFJUr9kEixvYkzCDPP0oLV0hHyLCnOdxKMtmGm0?=
 =?us-ascii?Q?95kRiAMdXjRdZ8JPiWsrMhQCfuSwEuyuinjwXuB3hd/MDYzX59HR/kxlG7J6?=
 =?us-ascii?Q?xOGZlT8JGVPlKk3ZJTcJSA9aAhJZbux+Ewm21GTchxpHtPpH9k5DLtqJOjUP?=
 =?us-ascii?Q?j3IfB70hNIeS50by0n2S+AFgjwD2ha7+7RxaSzkpFD8RP8UOdXPXFJYLLHU+?=
 =?us-ascii?Q?TACWtET5vOikj39mVpjsUtbGdTOE3abVNmx6MXHs80tk86dsVI3pN6UFlnhq?=
 =?us-ascii?Q?EKQ6qku6yVs7gA2T9pF9dGsMqd/Ip/imQbw740SGMVbZwmpdts7O1YkmP9dr?=
 =?us-ascii?Q?X6gMyWWiOp/vojRE5xMHeth32pRctykBhv7tC9pS25zn2lxVcADnXRjA68cq?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42772ddb-43e6-4309-9cb1-08db929b2491
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:25:23.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB7OoQIXO/TsNGsL1BquJTn5VrRwMFNySnIzsjKqQPJJX3aZSgPZMECSNNrQhGPcLd6XzTTmXCBx0FOXnuaHD08uEHJt/M8C0BCST7gIbvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:24:22AM +0100, Daniel Golle wrote:
> NETSYS_V3 uses 64 bits for each counters while older SoCs were using
> 48 bits for each counter.
> Support reading per-flow byte and package counters on NETSYS_V3.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> v2: fix typo bytes_cnt_* -> byte_cnt_*
> 
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c  |  1 +
>  drivers/net/ethernet/mediatek/mtk_ppe.c      | 18 ++++++++++++++----
>  drivers/net/ethernet/mediatek/mtk_ppe_regs.h |  2 ++
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 05be702f19c5e..1b89f800f6dff 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5064,6 +5064,7 @@ static const struct mtk_soc_data mt7988_data = {
>  	.version = 3,
>  	.offload_version = 2,
>  	.hash_offset = 4,
> +	.has_accounting = true,
>  	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
>  	.txrx = {
>  		.txd_size = sizeof(struct mtk_tx_dma_v2),
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index bf1ecb0c1c109..dd2df32b29c3b 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
> @@ -107,10 +107,20 @@ static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *bytes, u64 *p
>  	cnt_r1 = readl(ppe->base + MTK_PPE_MIB_SER_R1);
>  	cnt_r2 = readl(ppe->base + MTK_PPE_MIB_SER_R2);
>  
> -	byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
> -	byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
> -	pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
> -	pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
> +	if (mtk_is_netsys_v3_or_greater(ppe->eth)) {

Would be more readable with

u32 cnt_r3 = readl(ppe->base + MTK_PPE_MIB_SER_R3);

> +		/* 64 bit for each counter */
> +		byte_cnt_low = cnt_r0;
> +		byte_cnt_high = cnt_r1;
> +		pkt_cnt_low = cnt_r2;

and

pkt_cnt_high = cnt_r3;

But looks fine as it is.

> +		pkt_cnt_high = readl(ppe->base + MTK_PPE_MIB_SER_R3);
> +	} else {
> +		/* 48 bit for each counter */
> +		byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
> +		byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
> +		pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
> +		pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
> +	}
> +
>  	*bytes = ((u64)byte_cnt_high << 32) | byte_cnt_low;
>  	*packets = (pkt_cnt_high << 16) | pkt_cnt_low;
>  
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> index a2e61b3eb006d..3ce088eef0efd 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
> @@ -163,6 +163,8 @@ enum {
>  #define MTK_PPE_MIB_SER_R2			0x348
>  #define MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH		GENMASK(23, 0)
>  
> +#define MTK_PPE_MIB_SER_R3			0x34c
> +
>  #define MTK_PPE_MIB_CACHE_CTL			0x350
>  #define MTK_PPE_MIB_CACHE_CTL_EN		BIT(0)
>  #define MTK_PPE_MIB_CACHE_CTL_FLUSH		BIT(2)
> -- 
> 2.41.0
> 
> 

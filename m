Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A217F5CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjKWKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKWKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:53:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0301D44;
        Thu, 23 Nov 2023 02:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736845; x=1732272845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nqMfxzdliDnLfs7aSBYfos4/lvab557epVfPxgNdm2E=;
  b=cPMo73+Q6ubnksJhHN7bdgecUvNYybWhauSLMv4uh11Jg9lDdyhrti9N
   jxRVxUn9Y8VsDYCbW0nWBVY2MSRl0HY2Lyti193qcX8Q2u/GKIIal+iL8
   kVI/7nmDeTPA4lBGIHCHK+LfwccxfLdCOosLRm1fNjzDtwJxv9afmbj1h
   THimyNQ6pKOrBdJd0itRdkmIwtFR5cFhZqMb+M8SsU5cm4sMRjN9BUPTX
   1H8Qs5fjv5k2MHVJ5NUWQcjIqrSe/8TiwSoBi5kSo/bF1nWJTUff2pHRm
   4ZfKNoEjwXB7KpatyfbC11uUV/JtnJyWr4XJd/shpAKGcLNrJYUuGCrNH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371599203"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="371599203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:54:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="884944829"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="884944829"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:54:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:54:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:54:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:54:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i18NQhhMWebSFDS4H9DSursib1IGqcZ4KirK2aIAQBt/Fu4c/p01ZJ8LfejBm27byiBHgz3pCgmb3iXOt7s49Sqmiy4842zkTR9sUiVjv+9uvRjE1B2eCNR4eDhFZ0AhCk3KXqaIO90yrUtEaueD1DQHQrip4Aa0K3xS1Ydr8Wa6A2jSC+zQJpxWfsXJ0kA78wa029a9f0PoFZ3nKCp0jUA0574VsbVYImPiu9LZTpfqdP49R1/MBCf2PllHY39znzOynz/fhnw4aGlGpc6fEMQU/MAlPpfl501IrC7sIvgPZjt+SQ97jmz8lW2lZR7BbJgQr6VUMStEKKhJzkbtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31Tp837vIHB9RaAcgDUCA7YnZisp2NceZQ6UB4yaElA=;
 b=cDJ6987LfAm/ju9EWRuR4cbPhHd4DlATfmOmvoHB9iJkB97FoWVUPr42VDoBe90EQS2gnhwKW+xt0xafcKruI3cGjrqhFWdg4e5kX4ZB7BmbUimX1ZDVVxipilGPCTGvZnwBwAn7cC7G77AhvlSUxArcTJdIXmZAHQfSmlJebDZJfj/uLrgh3LWbMV81rIveb6qrWq5D7C4Iv7sE1BqaYSePaUozSvjQk1yKAtHQCUFIyZ5OI0TSkLvq45NNkH4Bbmu/syOGNpzQgR3/5OM5pC9g6yl1KB7mXAWPXCdVw+10887y49pSzUwLCTwiPCoBbDvEuRXYtg2+oPvXEhB0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:54:01 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:54:01 +0000
Message-ID: <b84db4ac-eaa9-4fc8-9ce6-00da03ab711f@intel.com>
Date:   Thu, 23 Nov 2023 11:53:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 3/5] octeontx2-af: Fix mcs stats register address
Content-Language: en-US
To:     Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-4-gakula@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123055941.19430-4-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8f5ba-9283-4a3d-c227-08dbec128045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lQ6PUwR+hseDusBnU+zqa+0mCNt76NbMzhvSvoskPeeOCudGr02dOyvIjJ4t3xhQVtdY9yicE+DuXm/kf9/zEGFEK0EHhjkDqTCd3SrgazV9laATlRS0RGE1Vp7dnuqn19SLvgzaCnqCwvWiR+KydEgn3uv15XWBglHWj9UXokrT4dch5wr95BIv8pbbJhh9p2N/EpRWMTFKF25XXNSwELPkZ6tKx/xMHpINT4UxdV2eXR+8UerAuT0UaTYHxTN4B8yH09eP+2DBSNAo+f8lIqSWlFTe0xmTz5mvNgDWMpKc8wSEYXBA41j33Hfc40sQ5gwHhmwgL/jYuQstnRq8Va3WJ1Je3yQR75pGGq5Rz188BdGEwJnaeLhlvqb4WQPt7tpyRFoDLkh+BSSXAoapn4DGle8fihoxsPC2jYPP+QsDmxzNtdbVjSnFGSS5r2XAZiRY0jNtUV7CEuA3s5VdZLiknH1/N4XD8w9PUWw7pyCQ5gX2mKibyqvGS/KSsfGNWKnwqPP0k510DQhCPctgH7X3ghQRxSz/FTsheyWzbFQFIG3SklnrHVS/7OyFv54/hJ3vctUldbSIWKZ1Xn9ZJ0uz7BvmbaybmbEcnhmZKpRGoKEqQBguNpNGc7k8TiCgIfkQ4EK9ujBz9kQW6cbfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(53546011)(7416002)(6666004)(2906002)(6506007)(6486002)(478600001)(4326008)(8676002)(8936002)(44832011)(31696002)(66476007)(66556008)(66946007)(316002)(86362001)(41300700001)(83380400001)(26005)(82960400001)(38100700002)(36756003)(31686004)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdIZ1F1UFFmMFQ2ekJXdk91cVlvUytoajFEZTYweE1Ma0FYOGxTUjc5bkRp?=
 =?utf-8?B?b2h2dFcyYnJXdEkxbFN4bm1GeTYvVHp2VE1Gc252TXN5RVlVSGJOd0lndXlI?=
 =?utf-8?B?YmRoM2JDa3dIN25QTWlCbzhtVXJ3Q0hvVGFRcGdaWWc4ODRIMlpTYUFWOFYy?=
 =?utf-8?B?UU5sT09IOXQ2NDVkeHlTaDA0MFBGK0F4SngxQXdmUHVob0ozWDNJWVB5RGdH?=
 =?utf-8?B?N0RzN1o5N05xdUU4YTBMeXdQNW5FVmtHSmxlbjhyVHEzQW92MUplWU5PZm42?=
 =?utf-8?B?NGZLY09oQnltQ0tpRUhnVEZWU2hobVJwZHJSL0NyaGhVWExBMk1RWGNldXZM?=
 =?utf-8?B?aXpjTExSNzk2RmpvUHJKOERGdEVLU01KVXJuNUdESng2Q1RmWE5zcjZWbnJu?=
 =?utf-8?B?RmQ1WlROd0o2b1RrWE1heGRvdE1tV0loWVFvMTEwalA2Ukl0RTJkTGdNUXEv?=
 =?utf-8?B?SmpocGF0dGNCZDU5Yk5lMlFCUmRDa3Z2OWcxc2VWeHlnT0VJd2NqWWRHbWRF?=
 =?utf-8?B?WXRaSVd4aTJhc3RXYTgveG5rZ2pWZUZrVWV1MnllWjQvOWtjTDllR2Vnc3JO?=
 =?utf-8?B?elM4U3VZNm1MRnEwNDMxQjg4ZDhZbmpEa09YRktoUXZYeHhycDRaZHVCYi9r?=
 =?utf-8?B?M1F3Slc1aVlzNjZOem5zOGdDa1FHVzdtRkh6NVY1OGJkTXBneDFmZ2MvOVdS?=
 =?utf-8?B?ZHdsMC9qQm10T3YrUkVMdHFvYVBJZkF5dWxVdmRwSHJ6eGNzVlhyNzZtWG9C?=
 =?utf-8?B?ZFdGMndWcWJJZ3BLbVVhYWdYekVjMGMwc2ZYUElaUHdjcGw3QWpIYmVFbW9O?=
 =?utf-8?B?VGN0aVIvSXdKL0pQS0Z1ZnZuVnc2WkZuWnhPWFlsRklGVUhnT1hpenpTOEx3?=
 =?utf-8?B?QTJOTFdRRU8zcE41OGs1Q1hBSHRnZklFSmFtOFQ5a2pISjNrR1V2aDBUTEFs?=
 =?utf-8?B?alJFS1EvN1Y2Z2pIRWdDYWgxVkczeEV1OFB6VmZxb0pKQkVPVSs3QjNJUC9p?=
 =?utf-8?B?NERWVlFKTlZFdGhZT0lNeTVqck1yY25CK1RJeEdoMnRaVHJpNUh1VlcyTDVM?=
 =?utf-8?B?bG5uTDJDcnVXOGIyRllvOCs5Q3BCQ1VIOG9iWlhnOFl4cmFBQmR0RmhWTjIv?=
 =?utf-8?B?NS80VEN6WEFEQ2tkaU40L3Nqd0RZbjlyWmUva3VHbEp6c1JjRWpKdGQ0V1Bx?=
 =?utf-8?B?ZGF0NS9rZGNGRmt5Wmc4bzNJVWJ2WFFEZS96SkR0SkI3MVAxL2E5dEg1VFIr?=
 =?utf-8?B?NStBNnNKdTRVL3hVaGFtVzJ4VVVLbThLbU9hRWJpM2xpYmFyemZ4TzEvN0ow?=
 =?utf-8?B?WGZjdGxmTVlpMkZMYjFjdUVITm5ER1owTjNDQ2ZDUVdoU1RqNmpONTVqR1Vh?=
 =?utf-8?B?aUk3K0N0akd0M0pWUWpyWXJxK2swNWpYdVRmbVRWL0Vac0RvN1Jhd3c0aDgw?=
 =?utf-8?B?bW5XcFlwRUNpcGh5Z0VPZVNxS0U5QUFNRmhPWWZ5SWdyYzNvbjBRR0NGNjVM?=
 =?utf-8?B?Vk05YnNLbEFNbHd4aGVyZEZxMElVbkZKbjd5TVg0ZDgrUEY4dGt4MTVrYm1P?=
 =?utf-8?B?NHZjQzNlQkY5dE5OUERaVlB4am5rNFN5UjJzNFB4bFdnTmNHSUFnVHdUbmsy?=
 =?utf-8?B?dFFjTGllSktsS3AzYTBXL1htelRXNWtZNVg3M1Bmd1NEUXhDWUdrc3ZsNTcw?=
 =?utf-8?B?dzY2QXh2TEZsYkFzQUprTkdLU1M4RlFTblkyRnc5SndyMitvMTdCMStlZndW?=
 =?utf-8?B?SWZ2dzF4RzlkcXhaQkpGakhycnpvcTFZeU5FNURIYnhOL29GeDhFMUE2MGZ3?=
 =?utf-8?B?ZUppbWE2SFJUNFB4UmRsT2pmNEsrb3hGb1FRdmFWS3FOZERJZmx6NmJvODhV?=
 =?utf-8?B?eVl3NDJFZW9ienh3eFhGSXovR0FTNkl4V056UzZVbFE5WThBWEhJTWIyd1dH?=
 =?utf-8?B?a0RCTkpmMUFaNGN4WlNUditiaFNaUEliaTJlRFdlRmZVeTNPQzVzMTBsTjAv?=
 =?utf-8?B?VWlGOVo0UlFFczQ2UTBqWVpIR3hYT2VVT3NteTlvZmtjaDVzYU02T0xHNVRa?=
 =?utf-8?B?VzQ3bVhEYmNjVnlQaHVRUVhMNkdHdUJTQ1ZCM21wcGxENEZraHE2Z1FpcUNM?=
 =?utf-8?B?KytvV29IdmFQT2E2c1h2NjhRalNzWHBkejA0a2J3UTJacnVlWmI3SkQvUHlH?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8f5ba-9283-4a3d-c227-08dbec128045
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:54:01.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fx2cZL0b4CQAa4Mwvixmq0WIoX0HawF3b+KZN3eJv3GY6aGsUl69Ne4/N6cAwFctFoQhXVXPxA8VHGeFNOG8VMPaCGwiaKuEMMeSrez08DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 06:59, Geetha sowjanya wrote:
> This patch adds the miss mcs stats register
> for mcs supported platforms.
> 
> Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
>  .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> index d6effbe46208..d4a4e4c837ec 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
> @@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
>  	stats->pkt_tagged_ctl_cnt = mcs_reg_read(mcs, reg);
>  
> -	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
> +	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
>  	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
>  
>  	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
> @@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats,
>  		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
>  		stats->pkt_notvalid_cnt = mcs_reg_read(mcs, reg);
>  
> -		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
> +		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
>  		stats->pkt_unchecked_cnt = mcs_reg_read(mcs, reg);
>  
>  		if (mcs->hw->mcs_blks > 1) {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> index f3ab01fc363c..f4c6de89002c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
> @@ -810,14 +810,37 @@
>  		offset = 0x9d8ull;			\
>  	offset; })
>  
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xee80ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xe818ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })
> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
> +	u64 offset;					\
> +							\
> +	offset = 0xa680ull;				\
> +	if (mcs->hw->mcs_blks > 1)			\
> +		offset = 0xd018ull;			\
> +	offset += (a) * 0x8ull;				\
> +	offset; })
> +
> +#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({	\
> +	u64 offset;						\
> +								\
> +	offset = 0xf680ull;					\
> +	if (mcs->hw->mcs_blks > 1)				\
> +		offset = 0xe018ull;				\
> +	offset += (a) * 0x8ull;					\
> +	offset; })
> +
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)	(0xe680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)	(0xde80ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)	(0xa680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)	(0xd018ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)	(0xee80ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)		(0xb680ull + (a) * 0x8ull)
> -#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a) (0xf680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a) (0x15680ull + (a) * 0x8ull)
>  #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)	(0x13680ull + (a) * 0x8ull)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606DC7FE3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjK2XFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:05:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB43CD50;
        Wed, 29 Nov 2023 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299114; x=1732835114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+62qM3S3BjTWsNxe8NfXwkSUxFP5y4AvQgw59G0hzeU=;
  b=oHRWbc13GhzI9nM6043TpYAx4lg9xf3bpz7WB7htJWJ9sgZvYHjfLfYK
   QGx1s9ADwXUUINRHg3oHF3j+rh6MREmvZiNyoTXKpqIM/QbHj5SHo7UQV
   fmhTZLJ9Hw1WAn0Bk8jV6kBr8+0b01KCncG0KSHlu3hikQTyWkisYAuwg
   qMplfnbrksQyJ0unB393KWzwzuDW1oeBCabMJLKQyvKtEr02Lrtwf4UoD
   rxNrElYkvSNra98KMgaGpnQCWTlRO8UjJWqi2a4z7HT/cEk8OLCObIsr8
   hCuIjxVpVkmAzRmtf/esIZ/LHbnB9ymEwML0gSk3ugXGfDC1/dAZanZKQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="459731446"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="459731446"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887024347"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887024347"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 15:05:04 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 15:05:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 15:05:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 15:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/z6Rdqw0aSJaPckbTscNM0LgY68fruXR7bU90A3wL4hayI9wrNHsQJgA0OJ2PpSwGgEFFKy6rtP4DURUtTxfb8Dr8j+Ra859lkMbbaX7+QRCx/1b2T9oZF6lpdrm0bKEjREIyOae+PgBNtihRuEC/azwGb/dJV48NuQam4acNqqDID28x/kIHvw5AK5y5jLg7nqiI7m7W2J8gxYmacx8paR/A4KxKsLcxgOgs/2pMpsoCghEmNFNX1lhHwpa6sazn2ZEbvIPgF7vjeYKfGgKTgRD7hr5V3WvOUv8Sb9PRdIkVRvsSJwSCtflWqSvc0wzTtbq5B490um3edIlF9poQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEt/rE7eZKrWiRNFCjBWn0BmkotHg0baqDu7TetOIKE=;
 b=Yyqjh1+HXWn+c7KOrX7rwlIEYDQCYM4LnxOr81OgtP/dCZV/i04mqGW/jpw8m+3f8tGQWBN8OiPCXguxK4RaqQV13rFxUFSjAKRYtszQ61j4vnM+iIr0GQQ08/WK/vwrHOe9z37r0ONYp546R4uGscY0sY9+4lA+RyggIWp+qffVEVFXL4QjWdBdiStpgOz9auFGNsTizPNRsk1cZhZPsUQ8OMn49k6YdajvYkDO97BqCm+MtXbsogBbKt4J/MvjVw3T35RHvtiG7wCF0kGMAlqLInhmvElU3mei9pfubXbr8d6GMvCSBo6ViSHmujPO66DQvhH6yQ7I6R1kPPezEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 23:04:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 23:04:58 +0000
Message-ID: <4aeebf95-cf12-4462-80c7-dd1dafddb611@intel.com>
Date:   Wed, 29 Nov 2023 15:04:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
Content-Language: en-US
To:     ChunHao Lin <hau@realtek.com>, <hkallweit1@gmail.com>
CC:     <nic_swsd@realtek.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grundler@chromium.org>, <stable@vger.kernel.org>
References: <20231129155350.5843-1-hau@realtek.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231129155350.5843-1-hau@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9df4e5-afe4-48ed-e603-08dbf12f9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQqykFxtizCzgmGdE/6pAS33J4grF9Sm/+vZPpi3Gcz7p07PVGbQLCYyb+lSGeCJqREa47KxdnVk4mUqDV/CV3/nvJ6q86wAsuUYUTgC8kzli3sOBG6jAPBukUTuOMLc2VY3e3PmZCKq/LHuHAs/QIA3E4Y7+2szBbdSmBcrbfqbou/n3O4Xcy/Hw0H6jYB3c0ekLc2NMmkczff1wKf/R7/Yrh1SFF2Iyv2uy60E7Uq3Yfav+VH7LxoFJy2i/I3c3xoc6ngGX1FllIpJJyhmKLHCFdggp0cRWT2dYC8HC3gVVrveTvVJO15wgie0gkD2wrBZ3gUt1YiEdkWFtr84Lo4f7qtNMLhw7W2SUoHbnKoEkxeKjSuZ8sF7+omp0VEYKlacUz35+5N9rdh3URM12vEL2HN75bPY4CqwVMrwGEy/zYLWeY4TjoOiI3qz6JLx2AKR6E259lESnPKYVlxPN/GwSV38Jc1nUS0zPtDeX2v8jSmjzSlv21S4v8FNIWolPDseVO674V+FJVnDJNuN0e9gr1SES6EiedjmFQcr2jArznQqUSQ78X8YNhq0ZjB+F83yJcHptREoSL61o9wLaopi5AVj3KAThv1AwJmUwW7tf9nOxp27whN+DQXjqw4fhMFIOnS8QN/GfZkxeLZ+MTNxo1H3Ccf6uDE1vng7+/iXgLHk4jnZEe+3Zo301JL4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(7416002)(38100700002)(5660300002)(15650500001)(2906002)(36756003)(41300700001)(202311291699003)(86362001)(31696002)(26005)(66556008)(66574015)(66946007)(66476007)(316002)(2616005)(83380400001)(6506007)(53546011)(6512007)(6486002)(31686004)(478600001)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWlxc3pNS05vaEozcTgyME9QZzJHRzhYVytLNHdiUzczblYwV0t4MEh0M0dE?=
 =?utf-8?B?UjNOdnFQK1M5WDNXWjV5K2xIdG1RWDR5eTZnMUxyT09aTGtUYUpOR2tTWjFs?=
 =?utf-8?B?S0NDdGlwdjRYWXBFK0ZlRXJwOFE0YmpIcjRjV09GS3BPMzFaNXNTMTIva1Vw?=
 =?utf-8?B?VU5qYnBMeERvNVdCQzcyZ1dwT2YzblFKU3l5T0VTZ0JMVFd3WHBSWFgwMStq?=
 =?utf-8?B?M1YzamNLaDU0MUdlZlpReHBhWVE4STB4a2FJTEJDSERKdHN5TlpQMXpSY1VN?=
 =?utf-8?B?eERSaDluM0JFb1c4Ry9BTlRKbnAvaWRNTVhZOXNKUm1IdzYxd1VoSVpQU0JM?=
 =?utf-8?B?RWJ2b3p6Zk9JcGJlQmpGSnVEVHRUNFVtVlEvd1VQTHBmQzc0SzlQc20vR2xr?=
 =?utf-8?B?V0FySzExSkkyWlBZRjFEMW9sMkZtZk9MZG15YkVBZWlNRGJPNmhOeDY5UGll?=
 =?utf-8?B?aUE2ajVML2VYZG1adDBPU0liMU5RdjAvN1RESkQ3NEdnOWNPRkMrMTFmeGRy?=
 =?utf-8?B?WTl2TDVJK0IweEo4a1FhaTIzbEFQN0NCSi9zRDZBR2NsR0tjaVlUQ2krVzJP?=
 =?utf-8?B?MGE2aEtVV2U5MGFyZkt3cUU4ZEtnUlVxYTdPbUpBZHNobFVWTHFlVlRLQ1N1?=
 =?utf-8?B?NUF0NnN5dHd2VjM1KzhzNUlhckZwTVd3QVNrSW5JdnQyNjFzY2FpQTBiR2Rx?=
 =?utf-8?B?bmZYR2Nvc0lWN0hyZGZhNEdlcjNoUG9tVmJrUkk0S00zU3NoY3lwb0RwSmR1?=
 =?utf-8?B?TWdKQ2poZlNDbVVaZENTa24zWU01STJnbk5WblVlRyt1YVZIOXNRZ0FVTStT?=
 =?utf-8?B?OTcrMGVUd1V4NjRTUUZ1bFFRV2RHeUphREMyK2NWd3l4K09XRUxmbkV1RjVJ?=
 =?utf-8?B?ZGROblhXaG55QkptNUlCOVp2WVF1SEZvcTFzZWk0N0hEcGJzRGpDY3VYWVB5?=
 =?utf-8?B?RGdrb09Mci84TUtRQ01UczdPcURmUzhSM1FFT3RUWktQNXlHd0JuVmZSc2tn?=
 =?utf-8?B?MmpjVk52ZEpWTy9YZlNQcjZkWHE0UisxS0xHeHA4ZFl3MG4ycHMweVR3WGV4?=
 =?utf-8?B?Y3RXamZVT1dwemFmMDdMRk1GMUo0eTkyQm5TU0l4TDN4akFUeTRiU1hmUHdh?=
 =?utf-8?B?YU9SUms2OEx6VVE4cysyczhGTXZ6NjYvTGI4MDVhcnVBc2IzMWVVcmh2WXlj?=
 =?utf-8?B?STZ2ZGt2TGU5VWVoOWNTeCtDTDI1aVloZlFQSHlxcVRZcFowdU95UDBUMUxH?=
 =?utf-8?B?NEVRaGJCSkRWemxnSkYwR2lnSFVvWEE2dUhyTVdHdmxoeWMybmNnVlFjYWEw?=
 =?utf-8?B?dk1XVnBFQWluQktrS2tVTFRMd1VpQUNuZm9iWDBnVmY0TkZUTy9ENStzbzlt?=
 =?utf-8?B?c0IvdHlZZG1TQU5tU2x6UHJaM3JlQ3Zqb2g0U0lzSGZBSTZmVGdpLzNRU1pD?=
 =?utf-8?B?aHFLL1cvVjZoekZLMzNTMG9uM09XdzRTa1BFbU54NUg1WHR6OTRzY1BRNUxQ?=
 =?utf-8?B?b2NWQWhzK1d3R3B5aXpCY3RJQ3VOaEdnTEIxd2E5WjZteHFyRWRrNE9DbVhC?=
 =?utf-8?B?S1JvYWtIYU92VFpKamlENTVNV2hGcFFLU3hQMUNNSUo0c1BVa2NuKzNqSDZ1?=
 =?utf-8?B?R1FhOGdDeXk5NkhWNGFlTC9oTVlHUmdGYkhLSG5jTEUrWWJmMFpzZU5qS3pJ?=
 =?utf-8?B?WVdCVGpkNTA4K1lFTThPV3dSaUt0NGlqY1FLdUpCdTFOa1JvNzVzT3Z2ekZX?=
 =?utf-8?B?cU9uRjJ3ZE9UMHliZ1Q2c0orblVDV1hEMHJaWG1ETS9FWUN4ZVRTeTRhY1pM?=
 =?utf-8?B?TzRhT2dBUHo3UWtSSzhpdHpUdE8yYkxCb3IydFFmcXlTa045MGlqT08zVVNE?=
 =?utf-8?B?SzFTK0xVc3R1Q0ZBZFhnb3ZUbkZXcnBpS1k1bFBwKys1VTRTRndnMVRkNGR0?=
 =?utf-8?B?cVpKQnkxbWVYMGErVGxnZXY4Q0xtZU9mV0FFekNDWXFFdHU3RUVIcUZaZEJr?=
 =?utf-8?B?S3hlV0dmZ2s2SWRodzMybDNnRDNoa1lDRnkzY2lDWi84dUtxSUcxeW1xbitE?=
 =?utf-8?B?VWFkRmh5OVVRbTYrVEhzMHdnTlJ4Qko4WWRjMjA1eGIwcUxJUUdvTktQMEVk?=
 =?utf-8?B?aFJQSVFmc1dvZ1NFQ0hLSlBTSE9yVEV3S1VVcVlxdXRtTWdHM3F4ZkhRQnJ4?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9df4e5-afe4-48ed-e603-08dbf12f9be8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 23:04:58.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1wFKWK8Qc2buph5rRJZGiQH8Qh/mpJLW6dZmC24KVH9xVHBwBQRlfDI0uk7d3nqCvVV2mJlG720vKmYA2QHrXf0XnAllNXHLap+lmRCAaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
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



On 11/29/2023 7:53 AM, ChunHao Lin wrote:
> When FIFO reaches near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame only once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reaches near empty state.
> 
> When pause slot is disabled, if there is no one to handle receive
> packets, device FIFO will reach near full state and keep sending
> pause frames. That will impact entire local area network.
> 
> This issue can be reproduced in Chromebox (not Chromebook) in
> developer mode running a test image (and v5.10 kernel):
> 1) ping -f $CHROMEBOX (from workstation on same local network)
> 2) run "powerd_dbus_suspend" from command line on the $CHROMEBOX
> 3) ping $ROUTER (wait until ping fails from workstation)
> 
> Takes about ~20-30 seconds after step 2 for the local network to
> stop working.
> 
> Fix this issue by enabling pause slot to only send pause frame once
> when FIFO reaches near full state.
> 

Makes sense. Avoiding the spam is good. The naming is a bit confusing
but I guess that comes from realtek datasheet?

> Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> Reported-by: Grant Grundler <grundler@chromium.org>
> Tested-by: Grant Grundler <grundler@chromium.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v2:
> - update comment and title.
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 62cabeeb842a..bb787a52bc75 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -196,6 +196,7 @@ enum rtl_registers {
>  					/* No threshold before first PCI xfer */
>  #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
>  #define	RX_EARLY_OFF			(1 << 11)
> +#define	RX_PAUSE_SLOT_ON		(1 << 11)	/* 8125b and later */

This confuses me though: RX_EARLY_OFF is (1 << 11) as well.. Is that
from a different set of devices? We're writing to the same register
RxConfig here I think in both cases?

Can you clarify if these are supposed to be the same bit?

>  #define	RXCFG_DMA_SHIFT			8
>  					/* Unlimited maximum PCI burst. */
>  #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
> @@ -2306,9 +2307,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
>  		break;
> -	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
> +	case RTL_GIGA_MAC_VER_61:
>  		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>  		break;

I assume there isn't a VER_62 between these?

> +	case RTL_GIGA_MAC_VER_63:
> +		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
> +			RX_PAUSE_SLOT_ON);

We add RX_PAUSE_SLOT_ON now for RTL_GIGA_MAC_VER_63 in addition. Makes
sense.
> +		break;
>  	default:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
>  		break;

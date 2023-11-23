Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083C17F5C14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbjKWKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:17:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759092;
        Thu, 23 Nov 2023 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734648; x=1732270648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IXRF73O9rc9T97NWfG5rmiT8ZEXtuUNqrJz3pThVEvY=;
  b=CEfE+T3j/AM7zIV/gzh7gx4W9ebcFeVl9AFgFM5q106MaBcaHhkC0aus
   5qAiw7EiX+4GVwL8neTLPuLR+ZwNeHq8t7SFRS86c49sRQKkh4dIz3lhO
   DhbJKbnMsTev3nyifi21aan5Xnei1UlfObg9JUmJE9ZjpUeHYZ7ipgAX0
   ad6TxJpSfGcnHccpJ3WpgxB7QES+sBlWANP8z3IowRRvNXEMj28t/RwPe
   +MAy3BXeDcIgWbiHoioFMvzgGnPPq1gydKpNkGnfxBlZ4XuVCLh5LM/P9
   TpuRJ7rbo34KC+HA66ZRpiy7uCOpnzZUlvBCyCOCLqTGetK2HwMEjFOkh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377266901"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="377266901"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="15615449"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:17:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:17:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:17:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:17:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKySUSZqiHtLv0xuHdh9FIZjJje+/eGS/unVTXQam5bHEshORGgItjyy6mLbwCRvtlFf+iP7ksOVqxngiQwnsKKMCsyJtu7CiQ2ORoO/shidTJDYtvCSvAsTC6faK0o0sMAgAW7ezmsYvPOOqakU/vFna224sFyBDO3GhcRFYa+wyNe7RJJOMqYH+GYHAgpRPfELirkas5vXdF9M8llSsnUFfugyt8AuNsaiyaHjkMlV6P0kQYWkWuUfdWV7rCaQ3Zbal3+zcTJqrZ8+U9yi4XBRRK8A0xR9FFQ3IcrsMKAXlQ4ZDM5SyYJ68bBAGK1hoQ799NiEjYITBkb9KVCg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYAaIgdXtZU6+KBYYGUTKR5ROFVwvVEOmU8f+pkH+uA=;
 b=gtiNFY4C3QYXuahr3Cp3yCj8PNJYWfFRAG4yeSui1ZhqS4bDXTzE5xEMO7BopZFkPB8R3qlMpGPnwdJAnqssm+hXabg+9Y+uV9oECx+qYExYeyuvIiR4+dcTa458jrt1PtxdcPza4TSTKLpNvWTS9DCWRIsXQyPblU508hKEk394lgoYUab+Dukxi1KEOV4Qrq/QdUwYFbf0V3yfih1fqRNEe4yBP75LakP17+rHoVhS/OghN2YtZdqxUEj3DGrT4/dyzxYwKdozg1L+RPVd1Uw+DmOnRAuPDrCBLWRcQBbkIBlP8V1ksN7Lvl3B3JXIOOTRtxrVeb50oCGmnzHcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB6845.namprd11.prod.outlook.com (2603:10b6:806:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:17:25 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:17:24 +0000
Message-ID: <2c2d0641-002c-4ce6-9df4-bc633e602721@intel.com>
Date:   Thu, 23 Nov 2023 11:17:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: xgmac: Disable FPE MMC interrupts
To:     Furong Xu <0x1207@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xfr@outlook.com>,
        <rock.xu@nio.com>
References: <20231123093538.2216633-1-0x1207@gmail.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123093538.2216633-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 135f1670-20d8-4cd6-2106-08dbec0d633b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xsa1jjEzxEiKwKyR9taGsZqzsEy/ZMi1K+O33tiY1IWHIZMz5Bcl+E+2wfRZc1dK2T9LLXVQdRWOD5/DoANoJ6NjvzaJW5X9JwI4gHi/rKz+5tw4NNsbdYdj2Tz7sZeRQngQWzTlzgWejl4RUEucD/SUbw+AqYAuMZajuBFYSr7fGWkudwktcOkHfHdOwjft+5WBUUNeldO8uqsowFMIVJK76pnS9kJDbE4TW93VkF7SwfnCIZAclcM0aXz0BuRg8pkpSsLbnCla1U4np7e7ysdb3oJBzKVyaimK61BeKJw5bGQtO1X7YjPa647cgNCMILlIdyOaGsSY5BLz3zmz4MIoW971xJn7K/BZbbsOJRJ7n13KCMKAL4vAZgRwqyrSWxVXF/MfG8xFOxMQa5GJR8Z0Q1AGkzKgYWAKCwdvUged0zZCq47aZ9oX/U7dHxLjxLnNa+DFu45z2fvMHIoA5sNVToVKkJSH8gtQQH0mtBak5KlPSP0sFSeQMmJr4TJa2RPI0ilUGxIhWajpwLxSF77LjX6FHZVLrnGbgbNzraaeNtMAiwi4XTq7szm854pStJktsnaSyD3hcAqjwAX/H923prPS4xNdUzfvTRLeIzMJ0Jkhu1VCT2SB/hXxeB3lyGZiLJReLC58czcy0IWVyTvVuaW/YWHtuDc0dYNajCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(53546011)(6666004)(2616005)(6512007)(6506007)(44832011)(5660300002)(8676002)(41300700001)(4326008)(8936002)(2906002)(7416002)(478600001)(6486002)(316002)(66556008)(110136005)(66946007)(66476007)(31696002)(86362001)(36756003)(38100700002)(82960400001)(921008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmUzeGZ2eWJBd1l1YmVzS1YycUF1aXNmb0xXaDl5MUVkTmVTUHdKV3RnZGww?=
 =?utf-8?B?UmpqM3BmcHlCRGdYd29CUGxERWdlbm9TWkVCU0RLelNKTXQzWlpvMFN3ckZK?=
 =?utf-8?B?Zmo5emt0VXZaL0o2dE05NnpkU3d2alRJaVNTZDNXVXppdFRsZnZ3VTc5OFM4?=
 =?utf-8?B?SjlGMFM0TzNQZHBjRS8vZE1XWlhpdThiQXNWdEh0K25sQTlRMDlrSVFHcnVU?=
 =?utf-8?B?enZ2Rms2ZjlKRDMzeVdlem0vYUNRdjNsSU5hTTVjZ1BtUHF0RmlOeTJ5TTRO?=
 =?utf-8?B?ak9oUjdsaHo1UnlibS9sK2hXRk9jYzd4Y0FYYW1rdjVNMVBJeWhvelVLbHRu?=
 =?utf-8?B?VzFTR0RxMGhxeDVGRStQK21tSUtybVVLSU5wQ1RzcnZJTHlzQUluQjdJU2li?=
 =?utf-8?B?L3JvY0VnUTAvYmh1T0dKY1M3dHQ3UGU1RlRsSEFCMFpwMXNHRThXNkZEcTU1?=
 =?utf-8?B?Nno1Y1p4S1Q4a2lqRkd6VzdoUjhmQUZkbXhJeXJPV3QwdFFIMVJicEJxa2Iy?=
 =?utf-8?B?cmZtMzJLUzZ2RlJWaTQxamJUZThwQjF2L3VqTGg3bE5YWmVreHdNM2E2d1g5?=
 =?utf-8?B?YUZRSlVBb1RMbEVRUzBycWJaYTAvcm1XODJWU2U3UDU3R21QdnZudHh6MzZa?=
 =?utf-8?B?TzZKVGV5TVBTVlFhNnk2RHNMdDExeFpLcTdkMHN5bUlLV015dzEvTWR4SGF3?=
 =?utf-8?B?QW01SU1NZkk0TUJXdjdaQks4S1dWcWFnRjdwdC8xbUxITTdsdTJmLzViRHZY?=
 =?utf-8?B?L3NwalljWVBIbklnbmxiYUpLN0VRdzFYYjF3QythQXpsK2Vyb3lUUllSd095?=
 =?utf-8?B?RHczWThndURzcjU0d3A1UWR3dXFlT09JSG1KQ0gzQUpGRHNseXkydFNnWG1i?=
 =?utf-8?B?dVFhRGl4S2VNOWVjWDFOVjVMM3oxSlN3SFIxUllJaEZwc2Q3MEh5bFFDVjVI?=
 =?utf-8?B?RXhtTklJWHhIVkwxcG93Vm1zMjVOUUZoZmRTM3QwbUNJVDMveFh0NUJpS2RF?=
 =?utf-8?B?U3pCRU4xTlA2QjhISUVDRzM0L0NpekE0Z0NiMjU3NmFaOS9scUpZcGpxSmwv?=
 =?utf-8?B?dmdWQldndm1iYUNtWnV1NkxYcGtMWFJ5MjJiVkV2R3hqUHBDRG5VZ3V6Qkdh?=
 =?utf-8?B?TTl3MFZIdkd0QTkyUFRNa0svSlJaR0Y1V0orWVdIVDRsbzNKOGVvc3dUcHJB?=
 =?utf-8?B?YnZNTm9XZHFUVjBoMHQ5NHczK282ZzRNMFZmY1Q4VWtpdkl5Y21iWkJhYmFs?=
 =?utf-8?B?MHBiN3pJVVFHVHVhZ2xyYVhCV0hYQXVHWnV0bnE1bnROU1kycXQxRmNxZGVH?=
 =?utf-8?B?dUhRZ2s1RWtReHNTWW9IOE1pUC8rYXl4ZThmTmVtSGI3RVdyL3FOODBvVTVE?=
 =?utf-8?B?eDBKR2RVS2pUZTEwWlhmT1ZVZzY3R0RiZFB6MWhSeU9mc3M0YWVIZFU1ai93?=
 =?utf-8?B?TStsZ1l6S0FIMk5pSzdpMVhkVTB1NjFxb2tIclBMTk1OM2JMYmxpOHdLcEFC?=
 =?utf-8?B?aEkzMGkvalUxeSt5dXFDaWJ1MThsTmZmTlFMeE9kWnlwQ3U4VEZXMXBxSjNJ?=
 =?utf-8?B?SXBTT1JqMFlTR3hYbXpTQWdMN051eXBRMXE4RFJVR2JpN3M4R0Fmd2JrUElk?=
 =?utf-8?B?UFVkNDl2dktvZEtjVFVWWnVNaEsxVzdqcTJKd2RpY1JEZHdFVFB6NndwdFU4?=
 =?utf-8?B?ZEJ0eWs2TFhZQTI4M2htdDRFTnZhbWlpY3ArbXhxaEJEcFZQc3FRS2pvNkJs?=
 =?utf-8?B?YjV4dVNUMnpRZTNQcXM4ZlNSeU45eEhUcXBySXc5Mzlkc1ZndW15UHFCbTIy?=
 =?utf-8?B?bWRqWHlQTDVZZy82dW91TE1mRWNjbWJ2MVNUWHhSUFl6TXhNcnZmRXN6c0FZ?=
 =?utf-8?B?NVljekJRNi9vRjVOUGFGNFBtYmFnQkhJQUYvTzQ3dlQ2UlBjOVJoa2pqczZJ?=
 =?utf-8?B?eVFHajRmMmZsWEdLcndMR2RIMXVHNXNlblo2QzVVWmdFWmJScXI1WG9uUTRQ?=
 =?utf-8?B?NDFodVBTVEpGT3FyNEpnSlZzL3JkMjFDSVJvZklrNFRYUzdrUDJmOWUvc3Ey?=
 =?utf-8?B?dW5CdHJucVc5bFlVb2Y2Qk1DQzNDcS8wYkU2MENXR1pmUGRibDNjSEdncUdm?=
 =?utf-8?B?NU9vWTBkL28xY2toREJRK3Jid2hNUUduSWJhMjhGMUVpdWlkc0ZJemgrVnVG?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 135f1670-20d8-4cd6-2106-08dbec0d633b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:17:24.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gghMma4RwJviONGMh46UmCFluwWaVBpcNonR3VSxuVJ9WHN7CEGi2ZQNcFwIFOAM7mdN5DJ5u+pURT1tFJMzpsc9sIXXLCUe8vXGe41pgcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6845
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



On 23.11.2023 10:35, Furong Xu wrote:
> Commit aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts
> by default") leaves the FPE(Frame Preemption) MMC interrupts enabled.
> Now we disable FPE TX and RX interrupts too.

Hi,
Thanks for the patch, one question:
Why do we have to disable them?

> 
> Fixes: aeb18dd07692 ("net: stmmac: xgmac: Disable MMC interrupts by default")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
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

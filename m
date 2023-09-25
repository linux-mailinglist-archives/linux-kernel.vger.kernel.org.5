Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591247AE1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjIYW3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjIYW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:29:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849829C;
        Mon, 25 Sep 2023 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695680967; x=1727216967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8PypOCGoMrPok+L7rMhkomn18WRPydckIeBZ6owwxss=;
  b=kST938BKBOK0BNsuBGV87dzm29MYB3whlPdvkaNAyBO3oPKgmkmeKXou
   udzMEUYcY4VyscKgHD+bpIq/lVuiq7xkjsjmBw+k8Ao93R6gPKwmc59yx
   AXHJXlyPPTf9ZD8QEZO2lEuO1HxxPj9+w2o+/muWMA0i3uk9shxjEWalz
   c4ao6jefB54nOt40Q1dsAbAMw3R0NOZ50Yj+dF6cx39iTgFtV0aWu1ljv
   Tvsjxi11Ley04sk6qZo7fcvxWh/w3uD9Z9+ne+kLavTpRdwtydk2aQcLi
   KsUg8tfHPirpRYpCfaMT2fLuZ4/GtZYRNOqA0/lyIhv/yfD3Fwp5HauEC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467708992"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="467708992"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725196527"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="725196527"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:29:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:29:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:29:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:29:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iozin74epQ1viv9Stjfza4qGdZYrmMBbQIscf4B3vikrjo7UU3swIiGr0OUizGuT9/WbsLtyFdnd1Dbayb2PUSBJB/mK+0zC1ZBbFZj6VuJz4Al1V3eFbPhKufmxn7/Bxf4m1TuZABVzzV6r+KAt6ag5VPY/C1oC+l88LEivTiSWRh4Kcxp0OMeBqouRAEc1EHS1dkre1xAt/NkHRw7IOMf9yVuQCnYczD/+XWpai76m7GpBmdCbyQeUtL/woZxlHG+8t0BbWaO3ifa1i+cZ+mnbgzgJdgO8z2gLP3Y1l9DoITQWC3kaxqOdz0fDP285NlkfBFzpIscoeTxkwwBUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqqXodC/13716a8XRxFEvoIzn/fmR+CjrKnuXluO4GQ=;
 b=WQfY8bgYj+X9ZqkUneEuGGMtKY4lGEOhD+aETqhiS+2F39tryJ81wsKlCRBlydaB+R7fg8r9xpSxkntRjwK79f89qA2W+C7menVr68VKsK7GgUfGb8CKkUxKpEcdpEqrL4/DqTM+LESMzRATkP1ymudTVeJICZx+Loy0XH9EHnH72589PZVU/UkgfxC/6xEbvTQ0xQGIO0dt9Nw4e1dIVtuA7dk/ewcNqvgoWXMAB23KrCKNsRGdrcIIo2SoY+jRH1IWf8pVgz+e6kqojA/tYiddcK4TDeG6BCg1zVkYg0EE7zSSEgE29YcZx3o2u3DRFAgnV9ndvlBO1ee3c5+yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 22:29:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:29:17 +0000
Message-ID: <b109470b-99d1-441d-0648-7b8e4a8c86fd@intel.com>
Date:   Mon, 25 Sep 2023 15:29:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ixp4xx_eth: Support changing the MTU
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0104.namprd19.prod.outlook.com
 (2603:10b6:930:83::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c630ea2-8a85-490a-ffbb-08dbbe16dae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDB4TinFoqHthOigHC1sxW9BT8LTBAiOx465ye7wgNapFygmIBfGqGbMA0yPlFKTz7ZbEFMNEZfbqEW45BouWY24rUCvcVKYI8WJpsJxQAO+SA4Nie9GDesnwwBCG+Mdpovo3MSjBJw9g7PzeCX7x8utpWMzRGC/oVwmgiXcZASPMKolmYNPK50wTxIaTmVjj7SKOmrXyahk9rWx0lSnkjdZJeqUNIZBKqk5LlSYbIo6UrHuJY4M1uKJ7M0r27Tg29t7OHlDfAL4pXKHZxlCpaWQYepmVdZ6GRfajMu+kcE98ebENyf5kd8uWeHaa8CuSlkmy6jEpu6I9x+wGZ+HlMJOgCqjdmXnUt6JJY66h+BZ62wxkIx6ZRjhmRq19Kbqlbkbt/8KZEbUogCOMIJGMHO9N333R6+6fPEctv0M3oeshkx5OM8UFtVZy+o/bAxDB1hzq/l6zqfXog62UYwfPDqDXFRS+KJCJ78fjVQ5F5szAaMlqcou/ZNzALgUuZ1Gk18oYWVRHENGHGYHoOuuxzrtf9VhrkzEhVGaE4G8NliBRO+F6L2+ZiitGVzM2Gs1M6ikSM/D9/wQ4bhAJMz5X72LnWtllbsYUXa5SlAkqtFhJtiG0cTPuD+4Udq6MKAxs4rTd0iFfuHPCFxpCSdeKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(2616005)(6486002)(26005)(6506007)(6512007)(53546011)(82960400001)(38100700002)(86362001)(36756003)(31696002)(83380400001)(8936002)(316002)(4326008)(8676002)(41300700001)(66946007)(66476007)(66556008)(5660300002)(110136005)(31686004)(2906002)(6666004)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzZUSHk0T0txcHhCcjVDMTJ6K0hsVit3MDZqQ0xoYXlrQ3BrNldyaTdoTkdT?=
 =?utf-8?B?b3hzaUJBc0FsVU9hOFZaZ2RIUkdCZHBkMDM3TitQSlBiMmdHMnc4c1ZaMjYr?=
 =?utf-8?B?Rkg0amwrZ3RMYjhYVXAzTkI3RDFRaHduUklwVit6bnh3NFY2YnluZUFyT0My?=
 =?utf-8?B?SU1XMms3OWk3TUN6cHZTTG1hTGU3dEE1Z2xzcGFrcnFuYUY3UGRmb1hNS1BV?=
 =?utf-8?B?MWJhRWdsNlRJbytOZTVkZWRSZmdQVVFqWHR3ZWFKT0JuUVc0TTVmZGMrREdM?=
 =?utf-8?B?S0ljUW0xQzZ2eVhIRERmdXdDemJodE9MNWJHQ2xjUC9WSXcwK3Y1eEw5d2Rm?=
 =?utf-8?B?VmhRTzltdWxuSWlOL3d5NDFKSTNkdXhtNU9XNTlPNGgyNUd0MjBUN0pkOEZK?=
 =?utf-8?B?SzJ4MVArSm1RNFRHM3BRRzNmZGowKzR0cHV5YVhMWFV0eUJQVUFHSEFrL0dZ?=
 =?utf-8?B?N3Z6K0JaM3JtWW16TFlIR0U2QklaVEZxTUFtUGM4dlk1US9kNXpIbTFNRXRi?=
 =?utf-8?B?WkRFZE1YeC9TQ1E0alk2eGVXTHU0cHVnYktqcnBvYVBpb0xSNFdaSVEvQ0Ex?=
 =?utf-8?B?UVlIVmlPVGJxZWREQ3FudXNzUEhacFVVeU1NVUU1SDlHZmUwS2M0VWdlUDBV?=
 =?utf-8?B?L2Ric3E5TWprSXB3U0Q0L1kwQWJrWndNMXRuaHhvc2dLOFpkU2psbDJwQ2k3?=
 =?utf-8?B?aW9DZWNZdW81RXJMNlFpMWVPUHR3a2FiNGQvZ1Yxbk00TC9GcDZ4TDZ4dVQv?=
 =?utf-8?B?T01wekxGbzdUTjM2MnM3NkRzS1dEMmR5VjhoMEdtcUp5cVJ1OWVHQThHMXQ5?=
 =?utf-8?B?dHRTVWpNWEhHd3V6RmxxNVRWWUxVeXpvQ1ZZblI1bFBSc3Q1UlV6eTBpNUJ0?=
 =?utf-8?B?TWUxa3dzQktGS254NUtJdmZMajdUeVBQVUR5aGp1QUdSbXBlQVRhMGswQTdX?=
 =?utf-8?B?SzhGalNuVmt6VGZ2bWowQUZLV2dCdTVzUDl5cGhvUDVYSjgrOXVnUlBKWG5M?=
 =?utf-8?B?aG12L1NZVGpHNnhmN3Fub2Q4d3FDME1PdzF0YlA5UUFaU2gvcHJCbkFFTEkw?=
 =?utf-8?B?Y210OGNHZ01rcGVUZlZGVnkvL1l6NllQQzZqSVF6MHdjUGVuVmkzUk1jandP?=
 =?utf-8?B?UFFJRmVkSndXbGlNQlU5aXVmL1hzZFFVdjFwbnNzQXlEMXVFRFFnNW5NQ1lM?=
 =?utf-8?B?WFk5bUg1ZnI4dTFLbXI5VHlMdnZ2M0FuVVFBejREbkw2WDBCK21WaHgrWDlC?=
 =?utf-8?B?MFB6N0FZMDR1c0p4SlJiejZ4WGtCUllHR0xicVBPL3FuU3FoSWpPVzB2N0Vo?=
 =?utf-8?B?ZlZOelhtQlRhcUxDWmJpMjZGUzQ4ZHFtRW12QzJteEFFNFc4aG4xdGpJTGxJ?=
 =?utf-8?B?dHFTREc1eit2Y3g4UlVKamF5OXkyemttbjZTYTNMZXRiaWIvcmFJZC9PdGVT?=
 =?utf-8?B?ZHN1TXo2UUVBT25sNHIwUmFyWm10QzdyMUp2cSsvaVlDYkN2KzVWN0pMYWhz?=
 =?utf-8?B?K1pESW1qY1VNVTJpQk9DaVBmbTcrSVFGQnJHcGYrV0ZEakNsdFp5ZS81THYy?=
 =?utf-8?B?OENpdkpyMnEyNmhpSWhrQWNaUC9BbU1oTHdXRXNLQXdIcTBES1h4RXRhMWdL?=
 =?utf-8?B?dU1kRzd3OW9hYkJzSnlLbjFLQlBITkppMnUxMzV6c3l6UWtPZ0FiY2cyN2V3?=
 =?utf-8?B?WGVVZUwzMWlSU29wcTNXV283MWZLV3hJQTZTU0Nwcjh6a2dqZ090dkRSYXdR?=
 =?utf-8?B?eGJmbDlCMG9rLzhteXBOSVhKODlmSjg4WHM5WlptU3NEL1dEeHVUckcxVVg3?=
 =?utf-8?B?QlJFUzRORC9DcWFOZ3ZnY2lxUWp4dzhNRFBUS3hvV2MrNHhIKy9PZVlHMnA0?=
 =?utf-8?B?a2pMVitEb096cTZneTF5UGxER1BXNFZ5eTlGVndySnNnMnd4MkU2UWxBeDZx?=
 =?utf-8?B?cUNrRktFT0FuY0NHNGFWQXZydFRUSGVOQllYTUlSbURGUHJ4TG90S0xFZU5i?=
 =?utf-8?B?V2VBOEhKazNST2dabUhyS3BaVUhOR0R3WmUzQU4ySUx2RFdaanN2ellJQjFE?=
 =?utf-8?B?MDc0Znoza01SMXdJK2poWGYyN2hJRTJsUFVDWHRrVC9xYVpyRHlwTHE3dGRJ?=
 =?utf-8?B?YzdrRUNpREJ5SEY3TXVKZjBhV0pjNFcxcXRCbm45NjFxbjFMVEpkRTVIV3hM?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c630ea2-8a85-490a-ffbb-08dbbe16dae5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:29:17.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHcH07Yd72PpIgEF8PiSkdPLzFgJ5nMnZmUflpVXuK64rglanrgm7/75djdSlG6WBU03OHNshJgxLFglW/TXZUzQoupce4er+SCmhdcGhBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 12:09 AM, Linus Walleij wrote:
> As we don't specify the MTU in the driver, the framework
> will fall back to 1500 bytes and this doesn't work very
> well when we try to attach a DSA switch:
> 
>   eth1: mtu greater than device maximum
>   ixp4xx_eth c800a000.ethernet eth1: error -22 setting
>   MTU to 1504 to include DSA overhead
> 
> After locating an out-of-tree patch in OpenWrt I found
> suitable code to set the MTU on the interface and ported
> it and updated it. Now the MTU gets set properly.
> 

Nice!

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Don't just set min/max MTU: implement the interface for actually
>   changing it as well.
> - Link to v1: https://lore.kernel.org/r/20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org
> ---
>  drivers/net/ethernet/xscale/ixp4xx_eth.c | 64 +++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> index 3b0c5f177447..18e52abc005b 100644
> --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> @@ -24,6 +24,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmapool.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/net_tstamp.h>
> @@ -63,7 +64,15 @@
>  
>  #define POOL_ALLOC_SIZE		(sizeof(struct desc) * (RX_DESCS + TX_DESCS))
>  #define REGS_SIZE		0x1000
> -#define MAX_MRU			1536 /* 0x600 */
> +
> +/* MRU is said to be 14320 in a code dump, the SW manual says that
> + * MRU/MTU is 16320 and includes VLAN and ethernet headers.
> + * See "IXP400 Software Programmer's Guide" section 10.3.2, page 161.
> + *
> + * FIXME: we have chosen the safe default (14320) but if you can test
> + * jumboframes, experiment with 16320 and see what happens!
> + */


Ok, so you're choosing a conservative upper limit that is known to work
while leaving the higher 16320 value for later if/when someone cares?

> +#define MAX_MRU			(14320 - VLAN_ETH_HLEN)
>  #define RX_BUFF_SIZE		ALIGN((NET_IP_ALIGN) + MAX_MRU, 4)
>  
>  #define NAPI_WEIGHT		16
> @@ -1182,6 +1191,53 @@ static void destroy_queues(struct port *port)
>  	}
>  }
>  
> +static int ixp4xx_do_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct port *port = netdev_priv(dev);
> +	struct npe *npe = port->npe;
> +	struct msg msg;
> +	/* adjust for ethernet headers */
> +	int framesize = new_mtu + VLAN_ETH_HLEN;
> +	/* max rx/tx 64 byte chunks */
> +	int chunks = DIV_ROUND_UP(framesize, 64);
> +

netdev coding style wants all of the declarations in "reverse christmas
tree" ordering. Assign to the local variables after the block if
necessary. Something like:

	struct port *port = netdev_priv(dev);
	struct npe *npe = port->npe;
	int framesize, chunks;
	struct msg msg;

	/* adjust for ethernet headers */
	framesize = new_mtu + VLAN_ETH_HLEN;
	/* max rx/tx 64 byte chunks */
	chunks = DIV_ROUND_UP(framesize, 64);


> +	memset(&msg, 0, sizeof(msg));


You could also use "struct msg msg = {}" instead of memset here.

> +	msg.cmd = NPE_SETMAXFRAMELENGTHS;
> +	msg.eth_id = port->id;
> +
> +	/* Firmware wants to know buffer size in 64 byte chunks */
> +	msg.byte2 = chunks << 8;
> +	msg.byte3 = chunks << 8;
> +

I am not sure I follow the "<< 8" here.

> +	msg.byte4 = msg.byte6 = framesize >> 8;
> +	msg.byte5 = msg.byte7 = framesize & 0xff;
> +
> +	if (npe_send_recv_message(npe, &msg, "ETH_SET_MAX_FRAME_LENGTH"))
> +		return -EIO;
> +	netdev_dbg(dev, "set MTU on NPE %s to %d bytes\n",
> +		   npe_name(npe), new_mtu);
> +
> +	return 0;
> +}
> +
> +static int ixp4xx_eth_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	int ret;
> +
> +	/* MTU can only be changed when the interface is up. We also
> +	 * set the MTU from dev->mtu when opening the device.
> +	 */
> +	if (dev->flags & IFF_UP) {
> +		ret = ixp4xx_do_change_mtu(dev, new_mtu);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dev->mtu = new_mtu;
> +
> +	return 0;
> +}
> +
>  static int eth_open(struct net_device *dev)
>  {
>  	struct port *port = netdev_priv(dev);
> @@ -1232,6 +1288,8 @@ static int eth_open(struct net_device *dev)
>  	if (npe_send_recv_message(port->npe, &msg, "ETH_SET_FIREWALL_MODE"))
>  		return -EIO;
>  
> +	ixp4xx_do_change_mtu(dev, dev->mtu);
> +
>  	if ((err = request_queues(port)) != 0)
>  		return err;
>  
> @@ -1374,6 +1432,7 @@ static int eth_close(struct net_device *dev)
>  static const struct net_device_ops ixp4xx_netdev_ops = {
>  	.ndo_open = eth_open,
>  	.ndo_stop = eth_close,
> +	.ndo_change_mtu = ixp4xx_eth_change_mtu,
>  	.ndo_start_xmit = eth_xmit,
>  	.ndo_set_rx_mode = eth_set_mcast_list,
>  	.ndo_eth_ioctl = eth_ioctl,
> @@ -1488,6 +1547,9 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
>  	ndev->dev.dma_mask = dev->dma_mask;
>  	ndev->dev.coherent_dma_mask = dev->coherent_dma_mask;
>  
> +	ndev->min_mtu = ETH_MIN_MTU;
> +	ndev->max_mtu = MAX_MRU;
> +
>  	netif_napi_add_weight(ndev, &port->napi, eth_poll, NAPI_WEIGHT);
>  
>  	if (!(port->npe = npe_request(NPE_ID(port->id))))
> 

Functionality-wise the patch seems fine to me, and properly implementing
the MTU changing is a great addition.

Minor nits on the coding style, but not really a huge issue to me. I had
some question about how the chunks work but I don't know the hardware so
I can't really evaluate whether its correct or not.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932
> 

Curious what this change-id thing represents I've never seen it before..
I know base-commit is used by git. Would be interested in an explanation
if you happen to know! :D

> Best regards,

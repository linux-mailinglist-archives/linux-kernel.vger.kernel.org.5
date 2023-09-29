Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02A7B3A65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjI2THG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2THE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:07:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F236193;
        Fri, 29 Sep 2023 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696014422; x=1727550422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YhsLcmvuYenJsFLd3nU+z34rv58hqqrOrqFENq2bwd4=;
  b=QCfYFkIRTHcYilQ2Jw++4gTrOxMrXcT4e0X93mSsQ/aWEyKXGk3kFiI3
   hlO9P0S5DhpwfgwYo1iEgZIf/XOlyVw2aHF5Hm3WCOK/lTVqq5hZqAk9U
   VgYK9lL7o/YjUjlaCH+yFv1EpCM1EqPaQ6cPH1tCsXd0R4/3mvJurjYci
   Hhcbrjib4OwQcCbf4vvUkKPfi2bWjWqSqnWB0HtOS9gywueVaXWnXQO9L
   B3ZpalqVsYtXoU83NUaOTNzXljeeLj0y2kNVmZ+bDq1Phkb9VR+nToUcT
   vaml/7P8zje6NfRS4JWgUaLEaMpazPBrk3SQlCjwks6ORgb3wDbPvgHB5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468633207"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468633207"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="1081006484"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="1081006484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:48:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:48:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:48:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em341Bhne2GCIskcYw8SpAl69iM+urLSCCeM/zQiHuqJShiRxYzYPCpQetGlGjHVErnSo6Zlid27tQqs8zQ3rkY6qHd2qtO5feMiLHNK8l/Q8wI3my6XELbvyO1I5T627+LMQKn6dgulAJZXIqNNMGlezuFxLmLL/23gE8vH7cNwsjLKpz8x755E4w9jVFUhxrif2/bV8Z4T47QhsWK+PJ4HOkzGZzM4ayp68dcght8oG9ZiZ82WOJXQvehGz9fz8b9Gb/tKSVTWzpZ5ZyR7KkOg6vnGvbci30DLGsceRiHWXxMu6RKfH+Jk58QuVK7M68ouTRtjElgSaSkbkxfwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfDt6faCJM8la4p6Qd6g1bgYoy7QwnwjLsqFeFEjOxM=;
 b=nqBIsY0nXtozQ7++wjgkoZzy3KkA/eoa2CCNBDeDdj4T3lqeiOCMqPxpvDgaw4Z6HcfOGYTc22dHW6UGj1UBlBg7pZDk/sf5hm2oqFf3b64Xh5J6CzB+nlOYjblc7ENwPQYF5C2/WCaABqR3CSiF6Tyn+9Z+uB2HBzqFzsfgl/fuh/wVHpXrOHXDAsv46NG3oTwNZ5yAbUaTjJm1SZYejWmjD7JocTGnP+TZmHI6Br12JpycYJ/PNHEvVEnF92G3Kr9An9dSV5KEj+CFGYXWDGpqVGLfzcEvMjjQXhhcl7q+mEJUJjNxJGsTKhxedgPZZLr23iBQbKKY1bxNrNL+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 17:48:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:48:50 +0000
Message-ID: <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
Date:   Fri, 29 Sep 2023 10:48:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Content-Language: en-US
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Christophe Roullier" <christophe.roullier@st.com>
References: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef47757-769b-4fb5-3424-08dbc11456ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTho1RVEtdan+NyPxRnekDlxa6j63dzRT/Bbv9Wecjw2utORwpTL//toQ9i+crxHiK+SHnmmNUjyG1P+5a/g/aYCoExgCvaz4hlg70soNk5U5TS9eifKjIf+6fGR21js50KsDMTjyDBGWR0vsptnsJVOSP8x+xW1CYQMs+P4yDI+jEjdd3mtmslRmwKgDaqY/nbCah3SAhQYO1nd916TJKfgPqOVRvH610ykFGp5egq3urrOJSn5p38PPu2rBe81yl6q0KggHn7KOdaKzaECDVhu56Txe1EJh5OaQyJPst7IokIwW1LEY3lPKL3q/xDttKYRIPa5u901/iOTeNpHj3jk9pK80N0mDt6xrRgS9UeoK5S86gevNF9afwAwikC7E46fdcqZGm9iKRnO+UJEpoC+2/W6nXhVSUVfGqoEwOG6EMGSUbFAANsIuTI0dXb3zVumJdU8KzDVdWAdhb8NKQuoUzF5VjNtn9UmnxPas8FzAOvWVJfzU7gmO6388QFElsbfvA/qcN8OGLj0cPUMier5FJApIuL5x5WLcXxXt/Gm1s52qJv3LOFgdRhKPkisSRfWKB7HfYnecWOluILBd9wB1l5AnliVv6uhTB13UbnaU5Wx6WvVkbQUEc46zizfvexOFoaXnUGBexFeuBj2zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(41300700001)(31686004)(7416002)(316002)(83380400001)(8936002)(66946007)(8676002)(36756003)(2616005)(82960400001)(4326008)(5660300002)(53546011)(66556008)(6512007)(31696002)(6666004)(6506007)(54906003)(66476007)(86362001)(26005)(6486002)(2906002)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZ4VXFYNWRWczg2a3JOUlc2Z01OK1prYmN4MVFJVlREUmYvcFNwR3VQZ283?=
 =?utf-8?B?MEpDNktMSy80clp4alRMS1IxN3FjK0VCSngrZXFDNi94RkExa2RMU00zYzBP?=
 =?utf-8?B?RldPT3hqd1RPQXFhdklZUTdCN1RvK0QyWE9veVgxT3pwVDBlR3RKZzdQU0Yx?=
 =?utf-8?B?VHUxaWlTSHZ3bDlkVjNkem9UVXo2azlNNndLYUhaaFlCMTlxWW9vKzBXVWZw?=
 =?utf-8?B?K2RCTEpHSC9uU3h5b3NPYXVwRlVZQzl2dE9jNFlTOEgxL0tOZndsckZqV3Zk?=
 =?utf-8?B?aFJtc1MzQSt5YktuRHZNUVNpb0lZd3E5R0Y1YjFaYWNIam5sSENyd05lK010?=
 =?utf-8?B?dkNsUkdnK0R5elBTVzlWdTYxcGY1Qmx6L3RoTkdjWnowUVltbGtESU1mN3Iw?=
 =?utf-8?B?WEZ0N1ZSM1dNaDRjeGxHVzlBUWcvUG0yNW9HSjVlWVdaSmowV0ZKT1pidjRU?=
 =?utf-8?B?dzV2NTFpSGhFVTQ1T3BMTnRxaERWMFlMU1ZzdnFWVUpRbk0waXl0V1I2Mi9k?=
 =?utf-8?B?WUxWNmg4Smx2RElEdDRhZUxLNXRIdWdhTmYxY0kxRENDS0toZDNJK1BKOXlY?=
 =?utf-8?B?L1YrcG9oYXgxTlcrRHhlVDEvN3o3OVJvMm15aENWalo4WmlHQlhjUW5od0c4?=
 =?utf-8?B?dEljU3NJRVU0SUw2THhVdEVlT1NoL2dsL09TSHBpNDA2cWtMK2paV3dONmtG?=
 =?utf-8?B?SDJjenBObHpRQWZYREJabUh1K25VeXBwS3ZqUC9ibENEa0dpb2dSNTYrMGRm?=
 =?utf-8?B?cEYyTXlRcnRlcVJQM2t0RVZnVEc2Zk9BcDdNM1lpeGdBbFpZa2pMYnErbE40?=
 =?utf-8?B?amFEcXRPRnZpTENkeHg5bjZXd0RrTGtPWllZLytNQkhYMG14US84RzRHZVVV?=
 =?utf-8?B?QlhxQUJZMWRJZno2NFlrTGZQVHJ0c1RySkN3TVgxUkhGam5kaU5iV0x3ZVNn?=
 =?utf-8?B?bUZ6UjNrVnQwUlFXYTE4Z1JDbjRSRnBrdjVORmlPVWExNkxDdElhNFUzVVBm?=
 =?utf-8?B?QlNFNUpiQnZ4dWM1UlRyYlV6V3d4dk9wUlYvMXE2SGluRFdmRlU3ODhzMUVB?=
 =?utf-8?B?QzlFTi9ISWlzVHF0eE0rUkpZbEcya20wMTFOeTJUb25PTFp2TW5lSWJ2Mnpw?=
 =?utf-8?B?WkpSbisrUHFYamRXdXkzczgyNHcxK1NxcGdSZkswNENEa3puQkZvZjhacVJC?=
 =?utf-8?B?RnoySU5YSHFyOU1SamNNT28xYk9iYVZMM2lMWFNPdnU4bWlHbjFad3duQ2lq?=
 =?utf-8?B?K1c1bVMvVStUeUZncHl6Q1FrYVlqczh4Z0JvU0NMZXJyS3lxcUF2VWFoNmRR?=
 =?utf-8?B?QmM2Q2d6M3BKWndIenFaL3pzV0tadkVlUGFXSEtNWG11Q3I0YVdsendVSEtu?=
 =?utf-8?B?Unh2eDgyUDUrMzNXMnIzNVRSbWZxem1mMjg4cWx5VElpdG1tR2diK2d3NU9U?=
 =?utf-8?B?aUtTMHFJZC9XWkI4ODEzejFEK1VHdHpibDVrN3F6c2dBQjZxc0F2OTVqUTlq?=
 =?utf-8?B?VnBHOHdMLythcjhMb2RIcVVucVhjb0xuQTUrYkRad0NyS29CdWROWUd0Z2ZX?=
 =?utf-8?B?QzlzTWprbUcyVHNLaVZmcjZmZldkVHBJWjZOaTJQVjZTeFQwUm1EcGJjd0tH?=
 =?utf-8?B?d2RtZ3dycDhUREJWcnkzSTV5SHV3cGxIcmh0VHdEd0JHSERwaW9VMXMrVFpL?=
 =?utf-8?B?Y2UrQmpIQ0FwV0E5R2VnK0xnVlBhVzBUWEE1YUhGdjY2djR6OEM5d1BYbGxm?=
 =?utf-8?B?YmNiRU80UUNibWJCdWk4SWpIUUFkN2xIMG9rbGZFUjJqZWQ4VzU0L2xRaVZw?=
 =?utf-8?B?SnVKb0lEZkZ5MUhCejhmU2pYU3dHUUtoYzY1SDRWTjQ4aTNDdVVpQWZKZ1Jy?=
 =?utf-8?B?dVhlazh6enNZZk0zbHR1anZDT0NoazBZdzZ6OFhEY1ZWbmJkM1FXcnNKQmFG?=
 =?utf-8?B?ZGhLanlxSWZzU09jSmdMRFJWNW9QZVFaWmVYUnJPM0NtRUsxUXpsT041cGxX?=
 =?utf-8?B?SmI5WndmZ3pPM2txZWlFMmFxWURMcXVsOXFzdTJXQ0htMm9Dd1FrVGpleXVh?=
 =?utf-8?B?OEtDYy9xTlZhZFdJNmVwK1pzYzhBSDZ0MEc3RzVCSUwyMEtoWG5XdnM3U0kx?=
 =?utf-8?B?OHJTcE5LNjU4Zm5zR28vaC81RTFTeU82bVJkdFg1a2dJeXdUc0FLZkJ4SnJU?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef47757-769b-4fb5-3424-08dbc11456ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:48:50.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxvXz/701xxIUEjabqjbIYwzbcG71se3RE8CAQLIRIoCQ6qCGlqqxhlPXlWhYk8WnBO9ZtvJj/2UTSwuTDSAqCSsSx1tyFv/2PPw6qhPhWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 10:57 AM, Ben Wolsieffer wrote:
> The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
> driver does not enable the clock in stm32_dwmac_init() if the device was
> suspended. The problem is that this same code runs on STM32 MCUs, which
> do disable clk_rx during suspend, causing the clock to never be
> re-enabled on resume.
> 
> This patch adds a variant flag to indicate that clk_rx remains enabled
> during suspend, and uses this to decide whether to enable the clock in
> stm32_dwmac_init() if the device was suspended.
> 

Why not just keep clk_rx enabled unconditionally or unconditionally stop
it during suspend? I guess that might be part of a larger cleanup and
has more side effects?

> This approach fixes this specific bug with limited opportunity for
> unintended side-effects, but I have a follow up patch that will refactor
> the clock configuration and hopefully make it less error prone.
> 

I'd guess the follow-up refactor would target next?

> Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> ---

This seems pretty small and targeted so it does make sense to me as a
net fix, but it definitely feels like a workaround.

I look forward to reading the cleanup patch mentioned.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index bdb4de59a672..28c8ca5fba6c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -105,6 +105,7 @@ struct stm32_ops {
>  	int (*parse_data)(struct stm32_dwmac *dwmac,
>  			  struct device *dev);
>  	u32 syscfg_eth_mask;
> +	bool clk_rx_enable_in_suspend;
>  };
>  
>  static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
> @@ -122,7 +123,8 @@ static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
>  	if (ret)
>  		return ret;
>  
> -	if (!dwmac->dev->power.is_suspended) {
> +	if (!dwmac->ops->clk_rx_enable_in_suspend ||
> +	    !dwmac->dev->power.is_suspended) {
>  		ret = clk_prepare_enable(dwmac->clk_rx);
>  		if (ret) {
>  			clk_disable_unprepare(dwmac->clk_tx);
> @@ -514,7 +516,8 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>  	.suspend = stm32mp1_suspend,
>  	.resume = stm32mp1_resume,
>  	.parse_data = stm32mp1_parse_data,
> -	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
> +	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
> +	.clk_rx_enable_in_suspend = true
>  };
>  
>  static const struct of_device_id stm32_dwmac_match[] = {

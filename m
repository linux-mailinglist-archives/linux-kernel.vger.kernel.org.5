Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644E87B3B27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjI2USG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjI2USE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:18:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51456B4;
        Fri, 29 Sep 2023 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018681; x=1727554681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fw4Lzgs3kascHDLs4HexzjHzGeZojQLrTY9pUnbSNU0=;
  b=BhNgRr55Cj7FJVz2sYWhBVoFM19PZgOjYwif8/CD9Zo+D+efnSMh/z7s
   GqRTCkVkINW+MCErfrX5/R0ToH1MKi9gmPJ0oP2gYnooYXyZOzFczzLtI
   hQms/Au8p73BPRe6w3PkyHcxd1JfWebbCPFeml1K75Zr4TgBfqXg9dzT0
   YrHg0bTmtTsjVeLROHWRXWyY7gAZDlrSanvdjCnnXhc6F3vfIgUn5wu7E
   ZtH3nl0TTdmMXxxxHj9wbSvESP6i4+pQG03Td9YzaJthsGq1GQYNa1FTM
   wA50wp4ioYwKxT1YkO5w8iRqfxOQqwwUidUEp9+XYZtylIHNklP0PpcNu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381240301"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381240301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785169600"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785169600"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:29:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:29:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:29:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:29:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:29:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5KzTZCMhJ/GFeOBwJdio1Y8hN0PlAuIEDbUbJhr3gDuMl6IRVrObLGVNgT1ZP/AkeZ9EjOFtrNZQ23gQ9s8OXhoDlBBXOrP3yb/DBmas3TihECVtNcf11SXUx46beWVvgQyCVWE1s9Ss3n4m5sxO/FLTO8INNhJtRxevOQLjo1IIw6wmZ8F34+ZSGBK1fbPcjQgAmtGgzUuRja6tyrzcBEcowRUk+Hf8Qq0JZ3rYs+l6b5QyiZXnZU2DJ5Iegwf6o7aZpkgH+0oF9bS1+OHpzrDHiiSoD1F4YOGjB++GrdZF67H65v9caMDEga6KoCMzZ+v9JIfQ38RMS6dcjyklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSP+MpQQ7aw5exo6MR9wHMqSI+f5Zl0fmwBu7u9wW9k=;
 b=hxpiJoEtyXhbkTwsv8zah5y7TQGjM55uxvgpVI6Y3MlvKTiu5C/DL3b+giNdxwThxM+0GQ2qg95ezuI16EYmfxTUXJRxFxSlNy8VjNots/rVBS8Tf7D9YO6dXpr4gmUi8INchd+1AXcA76o/o2Nd6KqsirugeiersMqLOeiqYWnb3YpsisfPSnaU2cSDAANFZVzkWk55peo1wq1320Bntjce3ppp1TXrh93x6aJodI/DuB3FIgqd2BC2ZQD2qpnmlR6MobvVP2DMF9uhvZKCQNNSBqXQ05f0Sw+4UVZenmLJDIGpkc/hZvy8ryKg/60tPP67ht7/bYqC2AVfP7A3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Fri, 29 Sep
 2023 18:29:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:29:54 +0000
Message-ID: <0ce8658b-9b8a-923c-a5bd-c63284d2db96@intel.com>
Date:   Fri, 29 Sep 2023 11:29:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, <jmaloy@redhat.com>,
        <ying.xue@windriver.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20230927181414.59928-1-dg573847474@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd6ad2a-025e-451b-ca28-08dbc11a132e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSNLT/UDPzr0p6LpkRfCMeahWbTqmRGKjukgL8LTEXDApHbgP/pG58xV1HNZhiCvV6CGpgmYeZ4e61gk6gq7Wm3GQ2nmo01DnxzxOftsuWmOJiImg4cRmte+/jfd3+gU6ox3bbeZNFmOVQ4XsM7rw2Y6TkIfx7gffunppLcVFoxlYa9T0YdCtvazTApRqfUEe8IRq2r5HPxqoI42y8hOmMPKuupCruNME0MvfL5IBVSIAjTVh/AIof1cVrudum22/M2sgmYUpuNKmsYUZTlsCuyy2kZ5sMxsL6ntNAFqdKHHORAVYYHOUxBdZLNTv2XOpz2wajX1w5OTZ5pWauhBVjqh75S9OG3c6s46G56UKMviAl3mB4NEF6kmulQKJOgxgmyu7l+d2N5fqPQjLjHHxIlzwTzlgOTebR2WpySnFG2rzitvC3L6O6kEZb09Gz+zxEtq0mElsfsR4GhEn5lP6stHhoXA22CrX+Tog74KjpQzuNx0QkOpkOIFkyZ9feAgfH+MZRCqrFG38FaSsG2PzJv2QoPOZW7DTpU6KIDndp4G8I9kZiX1volrfZ8VkZQbXeU3MJ+wDYvkDbQu78SpbUXvbGWsZe0nmNdeVnDSG5mbePNVFNYX0IknBP5hvj9MR6sqWyxNOkkSCODp/fvN0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6666004)(5660300002)(2906002)(26005)(36756003)(2616005)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(7416002)(53546011)(6486002)(6506007)(6512007)(8676002)(4326008)(8936002)(31686004)(66946007)(66476007)(316002)(41300700001)(66556008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdCQU5qWkZrYjdxWDZ6MU92SXM3SW5oaEZSaXdKUkE4MHJRaDQ5bGlnbDFz?=
 =?utf-8?B?UlM2dFVZckFzVWFkbmJNQXF2U0tyUUZmMDFBVExSSjJyTk8remV0OVQvOHIw?=
 =?utf-8?B?dkNocnhPWVhLT2FsU1lYdTk3RGNKMThTWDdhWjNIK09JSkc3TFVaR0UyWjBH?=
 =?utf-8?B?VzU1L2NCQThrRnpTOEFKOXRtRG5PQ0E1d2xBaXFFTXJPdWlpK2hMdlZwTXpr?=
 =?utf-8?B?NlJUUmJjU2RidUQ5SE5DRWNVemxPVXVxMjlFQ1pNWmhNdUJjajVFWW5oQjdI?=
 =?utf-8?B?WTFMeGxRVjBuK3A0aDV5b1h6c2FSSmM0Zm9aYk5VR3h4bXloM1prNFVSODZZ?=
 =?utf-8?B?eVAvVVJLeURYeVdFYzIrNDhkUVdxeExkaTYwK2tiS0M3czVMbTJDSWlieVJj?=
 =?utf-8?B?ejdtWnJVWlBkQ3BXR1l3WlVVUEVHa3JoVG5zMVgrb3RhaTQ0cXZBNktYaGQr?=
 =?utf-8?B?WnIzNlFPU1VxUDlkdE1nR3BhNmFRQ0xSdUVxMitsM0dWQ2dxYXhZNHlzTkdp?=
 =?utf-8?B?MXdvdFhIc1V6V2FiVGRPWEMyUWlSRjBaUnVWKzQ0ZWdNSGRBZ1p1RVdOOUdH?=
 =?utf-8?B?Vkp1YWtvVERJZjRyWUxHQnhTMVU5STFBL0htT3BKZzhKekZHbnluVUNvU1g1?=
 =?utf-8?B?dDdManRjV2UrdzFhZVhqU0JGbHN1RGpzZmw3R01LUmk1NmQzaFhNQUF1T0RY?=
 =?utf-8?B?UGcyQjBBWmpMV1BVSU15OGU4bXBsd2hKZFJDYXVrYkJOM1BZVzQ1WjEvdENr?=
 =?utf-8?B?SG1GVkhaY1A1bFEwQjk4VEVzK0NudHpPNUpuazBIM1hwRStNTG5LOUhkWCt3?=
 =?utf-8?B?RHYyeTR2MkRyYmttOUtsVlNFQm5WQWxGSjhhZnkxNlp5d0xaNUh0R3FvQlVn?=
 =?utf-8?B?ejNCNFhmUUhoS1R3MDdxQUxueFdBaGtySXhvQUFLOWFpS0xBeVlrT0ljWXFP?=
 =?utf-8?B?dW9nM1JXTWhhbDlSY2NrRUFDSk0wQWRlY09xbzM3SHcxT2JTUDBJRzVrRGJG?=
 =?utf-8?B?RTNPOUt2b2Nubm5aVDc5ZUdiL1hBdThuTGo5ZStjY2U1THNObXlaaGtJcmdS?=
 =?utf-8?B?UFc3OWljcHZkN244a0U3eWhXYjk4MjRxUElMQnRuZ0w3Y0hvOXQ4T3RzTi9u?=
 =?utf-8?B?enNEWHdmN0JRWHN4bFhpaXNnYVdBam14eWYwWVlQMnhtQ1V6WXhBRjJ3di9t?=
 =?utf-8?B?SVZNTHJlM0RiMk5BckROVk9mQUN2M3NqZ0ZJMjNYSXNwN0hsemhtSWZxR2Vn?=
 =?utf-8?B?TnkveXdtWnRaYmR1eU4xWDdnWDhQc2Q3TGRTSDROOVYvc1BRRGRWZGgyYUxB?=
 =?utf-8?B?UytCQXpta3U4QkhTcEhUOHd2UU5zZS9pakllVEpLWlF6WnFxSjVVWEg2QlNN?=
 =?utf-8?B?TkRuZWFOS2RHTk1acVhEck1pcVJjRHRaWkJMeHJTd2NEek5kYkxzOG9DK1Av?=
 =?utf-8?B?Snh5dDhmbHJmQ0ZIRXVOMGszc2RMV0dNdnZicWdwVFhtZ1gxLzdqb0xJQ3o5?=
 =?utf-8?B?T2svMWlrREd2MkJWUHJZbXlTcXdYakJUYmlJdHI2RWJ1cWN3MU90UmdXc1Fk?=
 =?utf-8?B?c1B5K0EyR1pva2RPR1JHL2Z0SVRWUC91bTV6YjhsQUloVjFEWHlYVUNDb2xN?=
 =?utf-8?B?WE91SXNJQXdmSW5NMExoYmUwby9Jc25paW10TWtveWFsRW9nUndzWmNOMjFa?=
 =?utf-8?B?RWJSMmFKaS93dmt6dVNnWXM4cDNFaHUveDRvQU1GaGxCa0UxNHFZTnBBeENS?=
 =?utf-8?B?SmtpeFRPVGh6UVlrMEZqbDZEL3oyWnVJNDFyOGtONnkzNnY4R2Jnb204b0hC?=
 =?utf-8?B?cjZQUUZIZHlrYzE4RGh4WjhSWll3SzQwOGFXQktxeURkNk5SWEVTak01SVNV?=
 =?utf-8?B?c09palV3dndtVzVXVk5Kc1lCSTZyTk02TnRkM3dlWXJBUjZ4RUVTMUMyTFEw?=
 =?utf-8?B?Mlp5RHhyVFVPbmEzTVBsWkNNOGNjOTNkdCt2ek5qNktYQk45b09GeGdObUJv?=
 =?utf-8?B?RUFmaFMwb2llQ3JScnJESzlUM2F6OGZMRmlCbUE3d0N6OGQzbFVNZFQwZTl6?=
 =?utf-8?B?OVMzUkREbWVWODhHNHVWWC8wc3pUa0lNYlVPUUdZT3FOUStUa2FxMFB3dEJh?=
 =?utf-8?B?Mkg2QTdqaUgza3NldTdLU2t3SklUK2pkTzV3c1BPSTRGZnlFT0g5RnpiaEN2?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd6ad2a-025e-451b-ca28-08dbc11a132e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:29:53.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnFCSeR0Ll4AgMs2iTEG0Cd6M0OHB0roPwccrdnJ5HUK4GHLmr9kGT4vbInNC7YK0lCP7frcMlB3Yt6drBhW3E+UPFOA4kKb0ZwqVC1tlX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
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



On 9/27/2023 11:14 AM, Chengfeng Ye wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 

Interesting.

> tipc_crypto_work_rx() <workqueue>
> --> tipc_crypto_key_distr()
> --> tipc_bcast_xmit()
> --> tipc_bcbase_xmit()
> --> tipc_bearer_bc_xmit()
> --> tipc_crypto_xmit()
> --> tipc_ehdr_build()
> --> tipc_crypto_key_revoke()
> --> spin_lock(&tx->lock)
> <timer interrupt>
>    --> tipc_disc_timeout()
>    --> tipc_bearer_xmit_skb()
>    --> tipc_crypto_xmit()
>    --> tipc_ehdr_build()
>    --> tipc_crypto_key_revoke()
>    --> spin_lock(&tx->lock) <deadlock here>
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  net/tipc/crypto.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
> index 302fd749c424..43c3f1c971b8 100644
> --- a/net/tipc/crypto.c
> +++ b/net/tipc/crypto.c
> @@ -1441,14 +1441,14 @@ static int tipc_crypto_key_revoke(struct net *net, u8 tx_key)
>  	struct tipc_crypto *tx = tipc_net(net)->crypto_tx;
>  	struct tipc_key key;
>  
> -	spin_lock(&tx->lock);
> +	spin_lock_bh(&tx->lock);
>  	key = tx->key;
>  	WARN_ON(!key.active || tx_key != key.active);
>  
>  	/* Free the active key */
>  	tipc_crypto_key_set_state(tx, key.passive, 0, key.pending);
>  	tipc_crypto_key_detach(tx->aead[key.active], &tx->lock);
> -	spin_unlock(&tx->lock);
> +	spin_unlock_bh(&tx->lock);
>  
>  	pr_warn("%s: key is revoked\n", tx->name);
>  	return -EKEYREVOKED;

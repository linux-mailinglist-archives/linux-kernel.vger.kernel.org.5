Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8947B6F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbjJCROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjJCROR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:14:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377519B;
        Tue,  3 Oct 2023 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696353254; x=1727889254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hHAqYhqSwROKZJWbkSMqAKxJjmE0SImGGYt1jCmqaTQ=;
  b=LadnwuXIyudEkDnZKPONCQHmVXTg9ubdfkFHaLTYBRNgnZIPZk73ti2T
   GfLNN1ymSCxrR1TMyGUvUokxz5awJeRUt1tT1XPge1YXuNLU44sNZ68Ld
   dJj9coItN4gTIFsCZeiWTmtANghMmHrGq165FY4Mfy/QJAiVwV6BJIY9B
   1Q3ARwKfketje2SkaXx5GFEzqavGTPTvn5RvpiJ9FwMNRxEWO4EuMedsI
   3s7ehQkVlUAdwESABZqcI6CuTnhD/hHv4faMXd4iaX0HgT67z1oT1qy/Z
   yN414h/YzV3yPg0QOe3WwQ1eADeEzGbWuR+oBSHvCGZE5J4e8rDCZSN3q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469211512"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="469211512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 10:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="821336460"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="821336460"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 10:14:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 10:14:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 10:14:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 10:14:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 10:14:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkY/3+DAUu7PY1YyHAnfoUiLVcCEpQo2NpQicLZdrze0i9idFm7Fm5flQM3r3MbSw/ifyug2x3vlHYE2cl2+jkVpzf/g8S8w2wVFZ+3ZWANLBSkNcO1DfvS9PNs7ArGv7FmNj1JrazGm8z6LmjFUsyMGYajGCi0cSbw3bu12BESBSu2Mw4HO7vGpds43Rn8LpJparMnesSjQ+UyISwI1Fr+7AWnRuFLu0fu0og9E5zgu1DAKG1n9A++zzdMzsZP2AgRzOYQdEtY56L/gEb3iS7L/e4TTVPRAGzdWNYcYkieMWP84rjFWRj3wga7I+lf7eLxpNaDq5rK70MHxprTHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x48F0pPxAfc3kxWKEPqgvR3IXKYYfXMKaQa5xLgqk/U=;
 b=LJ733oQOYEmhPBZUfdm2k+DdrIKZXwMi2K4gh2ST4GFZDLwKlMyBXOcmD/W6u9B0eOA2WxHvWgSUIFTiIjTw9goX2ZqTK0Hw4Xz53Q+hae1GasdAdxULDnsICEnKvLV2sOd/5bU2pI9gm1/b+4ficS0x/557wczroP6AuKumw6e8qCdxaQeNP4SHi26G7yetTV2pMIzRcF3yJb8vYmi2C677QegOjc8GYEt+6zlmt3LeqkoYCTtUzHpU0hkSPjcGopFIp7GjerjlJXGi8B/cRKoXV4zjKBwGkDvR9fTgnMW9xsh9rDYyi/zGkBkXdQwhhQDG7WwohEvxpvzkO8yeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by BL3PR11MB6412.namprd11.prod.outlook.com (2603:10b6:208:3bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 17:14:08 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 17:14:07 +0000
Message-ID: <a5e933fe-4566-9ae6-9a5d-b3a4c186fe0b@intel.com>
Date:   Tue, 3 Oct 2023 10:14:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH net-next] iavf: Avoid a memory allocation in
 iavf_print_link_message()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:303:83::32) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|BL3PR11MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 13810e88-554a-42a4-f99c-08dbc434271f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMAYD3ZSHM76wZjFmzenHKlu4qeXI3eMMr0ZvsC5RHmdaT+3DiAT1mHQBG6TXfHCIZuRZ6fdtOYJ8d6kzW6ZnHRD1iN9+5FLIGzK4OSbePodIYYwa1TubTWdFZRA6uSOGgGuslhNy1pIjJ9vPEyVSGSPXdA/tx0vBveBLnjjt3VV84FltfSuqMBA9dof//bcsB7x0eQO9S3S4+ngyIGFpmIvLuev0d7gAjOhT2XFJ6TXKkPa/bZAwVZxKfBUDh1Vlmq/JV06zEc8VEDthpH3vqmUO3Jo7tGABAys3izHpbXZw32i/yT5BKB/Q3ALTegw5LsrsvCZq8cgVCfm7ZdP8ZFUknifrV6LM8OtQKw5qu2P5M9Yl0KIz0ZFypuJBakHlLj/tFLlZ/TOqNJNI6hYqedD3Z9miwFuZGVnjXaWHCpDVyOyI+ABoJ6yxJHfEaSkRxt6s3LPCKl7JVHQRP7PlY4Da04DnHTP3J2KxsVowLScjCl6nE1+/9bruiGwJaSdFKafUm5gDjYWCTlbD5P/RLH2Ad3P0b/EAjQv8SvE3j8bCIVBzvWDblEglrcuJUD1KvLbdHF9jFHMWxs7zMzndgVHoG1SNguTud3+J6bGxxOT5+unTsFCzhTAIm5d8DMH/VG/7b/QzaRZYhlU5p1XzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(316002)(66556008)(66476007)(41300700001)(66946007)(110136005)(83380400001)(31686004)(82960400001)(6506007)(8676002)(4326008)(8936002)(38100700002)(26005)(86362001)(2616005)(5660300002)(31696002)(6512007)(6486002)(53546011)(44832011)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGl0NkM2MlNrOEVBQnMyZEFMOWxSUUY0RitFTWg4ZUE1ZXBmeVJDMmdlSVpq?=
 =?utf-8?B?eldJb3ZyMElCMW03UnlIUVBpT0U2ckFxQXBuVzY2cGd3UVltZkdOZTJFR25t?=
 =?utf-8?B?M0ZYZlphWUQ0UE9CV2dYWHh2UlN6Vm8yMVdXT2ZnZEkrN1pHQlNRZllvZk5Z?=
 =?utf-8?B?bThOOVhkcFlMOW9TUjNLZ2JTNHloRzlkZTBhTnV2a0RJbUVvTDU0bHcrOSts?=
 =?utf-8?B?TkVGeldOdjB4cE55U2VaY29VVGMyZHVIbkpxWUdZRUd3ZFFGbTNhc2x3cTk0?=
 =?utf-8?B?V2lKa1dLZjQ5Uk9mL2tSVGN1dzRQRnVsQzN3Q2pTUStGYU9OcVNiTFBRVkpm?=
 =?utf-8?B?eEdrUXBycGdYZGlkajE4KzRYbjM2UjFRMzVZbkVJWmtaVXluZHJUdTd5d2c2?=
 =?utf-8?B?dTJ4MHBMZS8wUFI2Skk1aXBzRldOZmh6OEZSdkdOK3ZNSk8zNXlxbXFmSVFR?=
 =?utf-8?B?ZHRyVzdINkVXdU5LdlZnQkM0MlZmb1ZkU3k4T28yQkhEOUI4TThQSUQ4VnVx?=
 =?utf-8?B?SzBZT3J0a0lhU1ZXVFEva0FZRm4zaFE5b01VdG11M3FjQitGakhKdjlLVGgz?=
 =?utf-8?B?eUNFZHRHRGJ6eEFEN0doUDBVa21PZXIvV25TKzBBUjhFYWpEWklidUh5bzVa?=
 =?utf-8?B?bVN6QnNUMDU3b25uZ3BzQ2FtRWwzTVRNeXJqV0x4OWR0ZklNVi8zYi9lTnky?=
 =?utf-8?B?clNLS1pOQzJrTytvdFFvTFVQSEJ0YnhHeVNRYXk3Q0VmcW1aZTR2UE9zSXN0?=
 =?utf-8?B?b1JNQXBvMGd4MUxXdWVrVDR3L2ltSWgxUWJ2NXhtNitpVmtZeVJMMU0wTjJm?=
 =?utf-8?B?UlQ4SG9qOUk2NnZ5TStzRmFKRmNMUGJYWFZHQkQ4aUFPUzJ0SmhWV0FPZ2cr?=
 =?utf-8?B?QlpkWEZPM2FsSVVjc0lvYVF6dXFNdk9qalR5RjA1eWdJYVQwZjNGMFNVcmht?=
 =?utf-8?B?NUp2QXhVN25vUHA5VkgxaVJvWkI2clpSSVlYYVA0YU50UjdJYWMyTDZDam1S?=
 =?utf-8?B?QXBaVkM2MXVGUDh5UlltT3FWV0JVTzRjRW9iWnhDSFdwZnVWTnZ0MmVlRXpv?=
 =?utf-8?B?MFdTU3o5V3pPTlJmemlxZHZtbUJQeHBtUlViMVM4WlBHY3lyMUU1cm1WSkFw?=
 =?utf-8?B?V3pDektFanY5dnFxVysrNnp0bWVlRGhyamlEOHlaR3QwRnhZQ3gydlBWZUVa?=
 =?utf-8?B?bERRRCtZaDRPdStWWlh1VHVCQ1ZQczJHbjZJd1dlVGF5NWFWV2U4OGVqcFRw?=
 =?utf-8?B?VU1Cd1hQcWJXTm0vVW5zbVFYL01QMXYvblM0MEpXalFSdjNxRElJc09Ec0FV?=
 =?utf-8?B?NjZxeE00YllsUGVWbVQ3a2hCekVUeVJJWWx6bE5Vd1BRTlVRMHVLZVEybEVT?=
 =?utf-8?B?T1UvRElxdXRkWnF0VHo0d0wvZlUreE51bHE0QjZCMmhiZjNHL2c2VFdsM01X?=
 =?utf-8?B?RlpaejRnbnJTVlRhMTFqSEJBTTdIWS9kU1lqQXVXWDg5TXpWOHF1aWphT2xo?=
 =?utf-8?B?MSthY0NzRk9NNWZqSDFCYURMZzFEaHI2cFNCK3BEaTBNSHBxaWk3aWhkbSs5?=
 =?utf-8?B?aklKNUtCQ1I5TlkxbVFNbk52WVpicHNCOUJmUmNTY0MvSVdYZEUvMFF6S0Z0?=
 =?utf-8?B?VFdja1NsR29GRFU1YkphZXpOTVhzNXhmQ0hLOVZVR1pMOVF3ZGc1NnFGK1g2?=
 =?utf-8?B?MW9QV1VldzR5c2ZKSFAxS1JBNm9wQy9XNkx0cjJxamp6d0NMRlExWEtIbWlq?=
 =?utf-8?B?QUNmTWZkeHFoTFFOcDFFQnduOFdvQXUrcGwrK2p3NGRKMDVTY3N5eVQ3UzNZ?=
 =?utf-8?B?d2Vsam1GRmFiZ3RuYit1c3R6a3BDb0F6K21TUS9uVEJmVWJVS0hyQUgyNDJp?=
 =?utf-8?B?ZGFsN1Uva3VBRE9ZdHorTWI3QWUvOVNYMW44dDZEMVc3dXZrQktIb255bzRT?=
 =?utf-8?B?RkJXSjNZU0dYME9aSFNNbHRNdmx5dmNWUHhoSGRkWlg1bkJUVkxKT3JnRDJn?=
 =?utf-8?B?dVM1UmpVTlliRWg4RHlmZ2xzK2tYTHFmYnExaXZkVmNzcWtxMUQ3WHZFVWEv?=
 =?utf-8?B?amU3THJVSi84dktLc2c3akZ6WDhBdVdTSWdUTGNaSFpVaGJPdmtFU3NZSTlt?=
 =?utf-8?B?YlNOQVEwbStxSjVUL2lhZjF4eTFiYzVrZUU1REtWcU1pT09IeWs5ZC9FMmVW?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13810e88-554a-42a4-f99c-08dbc434271f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:14:07.8669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z+bYrcJGdaAl7gNv6dxY2sv4ttJvwnAocekxcBq7TFx/K2PeVewoZaAzoDuJk75q7+ko3gxmZ9Vc/bVwckDkvW2I/SElQn1zs5HyCLW/hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6412
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/2023 5:17 AM, Christophe JAILLET wrote:
> IAVF_MAX_SPEED_STRLEN is only 13 and 'speed' is allocated and freed within
> iavf_print_link_message().
> 
> 'speed' is only used with some snprintf() and netdev_info() calls.
> 
> So there is no real use to kzalloc()/free() it. Use the stack instead.
> This saves a memory allocation.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 8ce6389b5815..980dc69d7fbe 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1389,18 +1389,14 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
>  static void iavf_print_link_message(struct iavf_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
> +	char speed[IAVF_MAX_SPEED_STRLEN];
>  	int link_speed_mbps;
> -	char *speed;
>  
>  	if (!adapter->link_up) {
>  		netdev_info(netdev, "NIC Link is Down\n");
>  		return;
>  	}
>  
> -	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
> -	if (!speed)
> -		return;
> -
>  	if (ADV_LINK_SUPPORT(adapter)) {
>  		link_speed_mbps = adapter->link_speed_mbps;
>  		goto print_link_msg;
> @@ -1452,7 +1448,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
>  	}
>  
>  	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
> -	kfree(speed);
>  }
>  
>  /**

Hi Christophe!

I had a slightly different proposal that gets rid of all the -Wformat=2
warnings in this code by using kasprintf to handle the varying string
lengths.

any thoughts about this instead and drop yours? I'm less worried about
the "extra allocation" here in this function since it's slow path, and
the same comment applies to your patch as well.

your patch still shows these errors
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c: In function ‘iavf_virtchnl_completion’:
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1446:60: warning: ‘%s’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
>  1446 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>       |                                                            ^~
>  1447 |                          link_speed_mbps, "Mbps");
>       |                                           ~~~~~~
> In function ‘iavf_print_link_message’,
>     inlined from ‘iavf_virtchnl_completion’ at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1965:4:
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1446:17: note: ‘snprintf’ output between 7 and 17 bytes into a destination of size 13
>  1446 |                 snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1447 |                          link_speed_mbps, "Mbps");
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~


<my iavf patch pasted as a quote so my mail client won't wrap the lines...>


> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 8ce6389b5815..82b84a93bcc8 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -1378,8 +1378,6 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
>                                   VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2);
>  }
> 
> -#define IAVF_MAX_SPEED_STRLEN  13
> -
>  /**
>   * iavf_print_link_message - print link up or down
>   * @adapter: adapter structure
> @@ -1397,10 +1395,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
>                 return;
>         }
> 
> -       speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
> -       if (!speed)
> -               return;
> -
>         if (ADV_LINK_SUPPORT(adapter)) {
>                 link_speed_mbps = adapter->link_speed_mbps;
>                 goto print_link_msg;
> @@ -1438,17 +1432,17 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
> 
>  print_link_msg:
>         if (link_speed_mbps > SPEED_1000) {
> -               if (link_speed_mbps == SPEED_2500)
> -                       snprintf(speed, IAVF_MAX_SPEED_STRLEN, "2.5 Gbps");
> -               else
> +               if (link_speed_mbps == SPEED_2500) {
> +                       speed = kasprintf(GFP_KERNEL, "%s", "2.5 Gbps");
> +               } else {
>                         /* convert to Gbps inline */
> -                       snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
> -                                link_speed_mbps / 1000, "Gbps");
> +                       speed = kasprintf(GFP_KERNEL, "%d Gbps",
> +                                         link_speed_mbps / 1000);
> +               }
>         } else if (link_speed_mbps == SPEED_UNKNOWN) {
> -               snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%s", "Unknown Mbps");
> +               speed = kasprintf(GFP_KERNEL, "%s", "Unknown Mbps");
>         } else {
> -               snprintf(speed, IAVF_MAX_SPEED_STRLEN, "%d %s",
> -                        link_speed_mbps, "Mbps");
> +               speed = kasprintf(GFP_KERNEL, "%d Mbps", link_speed_mbps);
>         }
> 
>         netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);



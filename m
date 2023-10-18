Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C647CDBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjJRMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjJRMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:31:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314DE186;
        Wed, 18 Oct 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697632255; x=1729168255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61hT63srfJuPAjmgw+FKiZ+qdjjBz+sh5Robtgb5tHE=;
  b=IFLiLxM4GstozHok18hg6lQsNHemJqP3iA71Tsk8PtbK4GwRYuRIvEpt
   UAq7JoyRPOR4+wcC8tTaTM5PmLOXpI9n67/+fU386zIwGH9yJZ3FRdyHF
   U2rh28M3W9r1Kz7kAqSmkGLPelKV9Pn/Rnw9RvIzDUMCAiMdz7yshFiHL
   ukXVbcwfFg0S/AyF+idtpPyDFzReZxZRd0WqMy6/9NUxSfQe+6WBa1c1Y
   0HwW/qEvCZ0ZWBkk2Ho9cPdU1qnxXGPHgFmvHGhfBLuro3v9aecNS6Q10
   ki+Y8muNmDgST/8YUN5WkVjRdxhTF2t9pWGnehwD1EzF56yR1KgaDthCh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7552904"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="7552904"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826871804"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="826871804"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 05:30:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 05:30:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 05:30:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 05:30:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 05:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4NjvyAf1CN7BozVzPv6fwsXBv6FnIeulGHHbzCN1NC8+gmQ1t9RsmJdN/rjv0f06UgNHuDajKaHDnARubQXLrn7gwG/fw8YgDcE1x9ty28PQIlmFoXGkCZba4GTRonXfURzVxmCzT3inrU3l9fC2eJyBWwU41X7zY9Ae4v35Ml6MRuaXxL3YzPYp2sYHVEatu2YbGPHg+11ehzgSUlsQmBkbHgozEAMz1OliTblCeMxWKRvApLbv50pQDC4RyHbFJT+zladaKpY1g6A716rd7qyJGyoa3bA98qc/uCFTVUFhyZGztRZM/1gS/yPUmRVuU0tgZqYlbYCPiE1GAa2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOgKv9UVlYU9+LIwLBhroK0E1T8rxsMBvQ9ysg3FW8Y=;
 b=XUXM1ZMJt/6NJc/oxUFy/Iq8AQyf3QH9U8kXw+Lf2Wp4l1dK7PHscmVKVFChPbAYlLTgKsKhtkN9y167vTGB+KCNKsRzc31UqAFkFnkp1/Fp0F9IOeiaOEv4Dy6/ruuSTqfuo9PEtvC9k+U9Osoe8eaYHGmM3xBTMCOtLXEaz+nBTsK+Lqw6bCL4yV9mxmusW8mmme6gy+qSI+EUrN5cuje4E8w2p6thaxnCSUMv4hXXLLVox9/vBkPX+OyAhPN4ZANXtSCC4tnkfKUbmYjxR/bwvhLka1RMueTltB1K6PaA8lYw3RXZhfxNc8fn6gNDRbFTG0PL8hAmesUmP17n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 12:30:47 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 12:30:47 +0000
Message-ID: <4bedad2b-cdf6-471e-a8bd-51ba3564aa6a@intel.com>
Date:   Wed, 18 Oct 2023 14:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231018112621.463893-1-ivecera@redhat.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231018112621.463893-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ0PR11MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4fb637-11bb-4bd8-671a-08dbcfd60dd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KSbskBVHvRqRZPWLjF6/bCQhSuhABzBap/V3R+KeJnmZsYZXW2T6W1EucHx5J0MY0iSwLTPF6gxe/SrXSUAYN4Cj66918BIU8/e7N2CGZoadoSaN5xbkK3ZjG3zxZOfQW5FiHsds2Z18d/meKj6vN3R0eU5TqffnycXR4+KTiEadB3mzeAW62IqSipdRWNX+OFwlDrmOsT+c/lv+fVBRaew+lXECATFeHSSpKY4NJtPhcSeZqXP5GUI+81lSxQ3UBzwCjOD0uW2EYGMToC7uY3ALJ3zKAH1/f4HZkkv6r54OVgx63q8ZRpv1UMGR4iL966ONHNiHlNwgRHdf8Sr5v3eFiOHSpRQ70k7Y3K0EdQzMhTlhoGoFmfLz5IGP0g50II2sbL8uSaazonlZjgotoI/hZ0oQecrrUvboSW2mXyRnheuhZAfhhwOL5p02XamUlE9VhYAf58REf+7NRjBa7HFa0St47fc3sq5PqUuCbtcXX1tk8EnCf5vrsXeCmZaiZNna3fkC3/iZ43Y31gH4UksqdgdhLQFcQbajP6z0hrg+2EmqGOM0p39UfjZzau6rrwFMn5tO98kwY4LdWfmb1S2V6jcPbmFGCDbK6yaz7OTNeyHcTQK7/bLyqaHqs7W/b6Z4YkULURvJrcm/hKfeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(6666004)(6506007)(53546011)(6512007)(83380400001)(54906003)(66476007)(66556008)(66946007)(316002)(2906002)(41300700001)(4326008)(8676002)(8936002)(38100700002)(26005)(82960400001)(6486002)(478600001)(86362001)(31696002)(5660300002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajhMSTZGdDJoTFNEWXhlTmVEalovdW03aEZuclJKVUkyUm5RN1J2QXNENmU4?=
 =?utf-8?B?eWhWYVRoYlUrVnoxcmJBbldTK04xbFplcE5ibDFudk1CTUk3ck5sVTVVRHVX?=
 =?utf-8?B?MWdWOHJyYXdFV0E5S1JvVjJ0VVVnck5LOGsxcVEzUmJpN2E0VkF1eWRobDdM?=
 =?utf-8?B?UUhnWTByRWFmQ2JSY1V5TXcyTVF4VXBZcndkdDBVcVhyRnc4M2lST09lbnZX?=
 =?utf-8?B?ZkhMSm95dE9rVk56RXlHcGpzWWoxeW1xUlNUY2tFcVFBNnA4bW41M0ZuNWtl?=
 =?utf-8?B?MkltVjFLOHJJU1RQcUxRR0R0ZEJVYjU3Nm9jNnNOV0F5bENYa3dHWjFoL0tu?=
 =?utf-8?B?ZUh3S2JKYk53QW4xYWlxS2szNmdwcTZmZitVUGpkOFJSTHFad0s2QXEyTjVS?=
 =?utf-8?B?ckFPZHpoc05BMk1aZ2lrdVBrZDNYRE4yWW12Wk94dnBocjhacU9Wai96Szk2?=
 =?utf-8?B?ZjBOeUdTWThwUFdXVng3VVIxVDlHUVZxbU1tTnVvS1ROUUxLVnRIY29pNzZj?=
 =?utf-8?B?TExlVTE1eFFDeWlxVXFWWDlNQ1J2Lzg0S3dwQ1VmUU5OMS9EeVk2LzM3eW96?=
 =?utf-8?B?VWpYa3B0ZVc4Q25rS1FscXlXNGFmYXE4SUtGdWRqQlpXZG5vZ0RqUlR1TUpy?=
 =?utf-8?B?UEFyK2V5Ylg1VStjenpzRC81TGs5a3kyMU1ETGM4YVNiMVZ1SndjdDlHVWU0?=
 =?utf-8?B?d2RRMW5Qdm9zS1pyZFFKREIyZ1ZaSzVkRWx6b2p4UmxoSVZ5dGM4c01jdEJp?=
 =?utf-8?B?RFF3WEsrcFBBZGtkUXBHenNUN21ab1J2cXR4VndRc0VjZ0hKTklERXdKVXlQ?=
 =?utf-8?B?SmRUNWptYUE4RTFhcThUcEFrbktzTUpQSmJMcU9BME5zc0NKK3U5RXA2UnQ5?=
 =?utf-8?B?ZEFyUHZkUk5SZ3hYOXJUYVFNREhHZDBxNDZoZmFIM2xBcmE4TlVvR2hQUzNI?=
 =?utf-8?B?N2d4UE1Yd3NaQlNVNWJEOUdiSzhWM2ZBWU8yZmx0R2tpQ1AxT01za0dGcWVL?=
 =?utf-8?B?N2NVQUEvb1VuS2U1UnJyVjYzWUMwb28xdi9zZkJqWXZvZElLMlJoMjFaWmdI?=
 =?utf-8?B?L3lzSzA2bzAvNS9RUXMwMzJ1VXdkNU5yTm9QaEtQekk5cnoxMW9lUG5zbk5P?=
 =?utf-8?B?bVIxMEl1OVp6bWZCNGRId09RT1RCcWdsYUt3ZjR6bXE2cE81NnZKL0lwejFU?=
 =?utf-8?B?VDBLQTZaYllPeUl3NHlFZ2NzSjVwekVCNnJLbzJLQXBkZHRxdUVGMnlrRUVk?=
 =?utf-8?B?Q256d1JSZWVIbWJPY2J6a1pJYWs2b0swRDNJVTZyUlJ4dktQZ0toOHVYeEJp?=
 =?utf-8?B?SkJGRGVoRWgzTkpoWkwzVEVtd0ZvK21IaHB4cmN4Q0d4eFEwUkNoMFZ0RzE1?=
 =?utf-8?B?bW91WlJUeVJibk1HdjhxS3ZQMFpHUWZ6d3RqT2hDaFUzTVVvYTVrcHp4WDFV?=
 =?utf-8?B?ZFJiMjlvcGlWbGNxUEI2bWpGWUlpVG93QlMyUDU4Tlc0a3VDdFozVVpUOVhY?=
 =?utf-8?B?UlV2QzlMR3dNTmlXZW4zZXIvRFRqeXUxcXhpcjE0WUlXTVc2MDlvQzVDMkVl?=
 =?utf-8?B?ZFZId3VoakVnU0xGODdKRXgyR242TFg4TlFyZk0zSWVyRW14RTJITEdWaW90?=
 =?utf-8?B?cEp4YXRjNGF5QXlEKzl4a2NDU3Jjd09FbFpmeDhURFdraGtvaEFxaVQwRWZ1?=
 =?utf-8?B?YU44N3BDb0Ezb0U3Q3FtMFliM3lTOEZBODlrSTNkSU5BdmJaUVdac2ZqVWht?=
 =?utf-8?B?VExoWHFoeDdhTzZBWHoyY292ellGWmo0N2g1a0NobjlkOGlLak8zc1JTM0dK?=
 =?utf-8?B?Z1BkdWZETWxzVVRLaUxYU1E2Nm1tV3ZIcmJuMVVQTjVGWk1EdmtHbS9ZdHl4?=
 =?utf-8?B?S3NpczdiTm9nakxWSnBBS3pqdklSekJUdFIra1ZqSDI2andiNHBxaHZiREpp?=
 =?utf-8?B?K3BoeGxKUkRDcWJ1QXBIRDZDNWFwK3k4dExtUXo3VG1pbFhTOHJhdHR4dE5y?=
 =?utf-8?B?c1NJTVk4OVVkTVdlK2owdjJDNlZ1U1RBdnFodmlaaGo3ZnJUc0JUNzZuT3M2?=
 =?utf-8?B?d0M0ZkRhUkRvQXNQTDJsOXAyUDRuRENFb2F2L2w3bitIRFZueTIvekNnVTVY?=
 =?utf-8?B?SVlPL2UxSWlPTGhxemgwZE5TcGNsZE9icjVkUGZZSy8wbjRoR3IybFJIWmpn?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4fb637-11bb-4bd8-671a-08dbcfd60dd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:30:47.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61FaXDfQpZKuYFbF/oEhe6uTfEDz8ATJ7LRN0UkPbuNAl8g0Xs6/k/J/T7buRFFbr3hloqSTQOFGiBhyQK8Mdd+swPr83wEDSJ34fzJIGdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 13:26, Ivan Vecera wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 6e310a53946782..55bb0b5310d5b4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -580,7 +580,6 @@ struct i40e_pf {
>   #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
>   #define I40E_FLAG_RS_FEC			BIT(25)
>   #define I40E_FLAG_BASE_R_FEC			BIT(26)
> -#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
>   /* TOTAL_PORT_SHUTDOWN
>    * Allows to physically disable the link on the NIC's port.
>    * If enabled, (after link down request from the OS)
> @@ -603,6 +602,7 @@ struct i40e_pf {

such mistake happened only because list of flags is dispersed so much :/

>    *   in abilities field of i40e_aq_set_phy_config structure
>    */
>   #define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
> +#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
>   
>   	struct i40e_client_instance *cinst;
>   	bool stat_offsets_loaded;

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

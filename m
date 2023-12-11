Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB4580CC2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbjLKN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbjLKN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:56:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9C44BB;
        Mon, 11 Dec 2023 05:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702302941; x=1733838941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N/ewCaw46UUNc5L0lZNIt+qLKdTV97oTJ7Yb8tkON7I=;
  b=luh4ibTVkSTPrTInepZjRO1q8Ks2vVbzuCELZiIHNkyAvuieru/1LOXU
   V/a5q6f5B/KQD4rD3VATdJPJXnUEgc5Yz0Dyf2XpdeUMXjFbPn45GzL6Q
   Y7Z4hqlp+lsdGUKSvNKgFbAT+TUShA1nNTi+zZ6BLwh2W5TMWjgXX/cz3
   GynuXsShG6c6UIIn1PuNG6LkyM9n06YHbnXzgAhaUcd9SnCo03CmHRL84
   OlOOwQkI7gf7DA71x12jUmHq/q/jDeka7WNKMxFbY7tHpSz4KUTzkdqDu
   XgvlOR1LlZZ9ft3tjHIZYEJpTMfPWswmM7V3lc79KeQKJdjhRd9oTzl+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="458958620"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="458958620"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839048391"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="839048391"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 05:55:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 05:55:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 05:55:39 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 05:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQcr5WPwTOgaZuRJPNhgUY8Zeoy0sz1eaF3IjMrR/bdc6Yy8kw7PIMlsmj/huvh0HP+02OabRKZkcisTPvPSGJeJxM1vTSxLDdKFj6pM1y4Ywlnp41czA4xy/p3FruMYiri6SPD0YxAF8Uj2QypEOgM9JX4AqPK3AubvQOvQP3vsYObvbO6BuvBHIwWddFhla45RFo5p20phZC0hNyQnksaUEXojhrfRcRRWZV62MwGySLe99Sgiz9meduPkUBfOyo+KKQcCAnZmchDBO/iIKILMZHj/yrK44DAfALVVY9KNXCiDHlWEGr7vw8q9XPfDUNCo5aOdcPa4AbdO3DMBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV4PO7mXXEIFZI74YmZXUL7TMpu5Oo0znfshbLFnGbU=;
 b=ofrUWjw0KFbGAuQY7K6DGjve724FXA89EpUX4eKMtme3xnntlhNy8W7lfftp6TVl0yehfwv7+TD02KDa/aCemAUl0AasLSBR2FwAU+oLhuM3Ttn9sXCHr2ZG532p9NJQPbfx8Os483qvTwPZ73ZGePsFYjiUAc3IFbTaAYgiVVc0XvBExAMya0nKtSJ1A7pzmMR2ME6J9/us2TaIxxaBmV9PhvHMBlgxUpBEjEy2nQZo0y2KjdFH77HW91wdK7DaugunWzgImlk9xheraLi6HcfZ1xzPp5JO1Qz9q1R6nli8j6fCy/CQUs517k6MAXiAQzASIeUwfE4MiPrnYye37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:55:37 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:55:37 +0000
Message-ID: <75e6cded-f0f8-747d-d09e-995922f7a484@intel.com>
Date:   Mon, 11 Dec 2023 14:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next v5] ice: Add support for packet mirroring using
 hardware in switchdev mode
Content-Language: en-US
To:     Andrii Staikov <andrii.staikov@intel.com>,
        <intel-wired-lan@lists.osuosl.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Marcin Szycik <marcin.szycik@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231211133017.815891-1-andrii.staikov@intel.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231211133017.815891-1-andrii.staikov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8aa1ca-e895-4a6b-7314-08dbfa50d9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7dlDQFImWHjreuoe4oT23EmojLQxILoydwh+eJNHqEbLFbeGNd0GefqXRpYrSSl8sbb9nKzKKbHkWqnYscsz8ppfSABAOziSptUbiVb7bYvryrjN9CosdeRIBu9ON4DEKBtLJdM8hwYZU6oGp2KWpbPvo+foxZfdSr0zADQsT+AmeDJsglUF69dh8qDPj8cYZ85rsXJlzo/rqex/ceWwsqy9SHH0Rg856fisLom+hFFQHVOrrIEwlx+RE/dROm15hgEAv4l2+XIsgynscwmzwCbcikhxdTS4wAGL9JUBhxxdHqjo39swHNmODPUb+6YPkA6nYWkyrJaR53xzatw3Z8IK55Havw9kk2Efey90f3boRabtwMtBbA0C1IBGZ5mNkDLbDS9iSpLcogsa1OMoVdxaLOQ91hgbwTdRw1uRRm0yDRK0PqJU80WzTBgaM1NUw2c94fnS9koWRGK7B2xTUCoz8q5sa3gpGmWzWCXomob7joqx867aiqPwno4NwWP+3Eu74ZK0NuE+aLoHtYFglhtq03ezOA8kCapf0xh1gCyOY7yBsT0l3HCY4f2bHgxE+0An58yVx8u5Htly/nFpFhkd6r3QWWRSJzYnTPjifuHTg0x3Ydj4t+5LykTf9Qxh+jqEhwFJ9h99Lem2FFulA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(107886003)(26005)(2616005)(6666004)(6506007)(6512007)(53546011)(83380400001)(5660300002)(41300700001)(2906002)(478600001)(6486002)(66556008)(66946007)(8936002)(66476007)(4326008)(8676002)(316002)(54906003)(82960400001)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uzd1MXB5eVQzTXo4a1o1NGhiY3V4YnFxVkRraHY3YmdkWG5PYmZBd1hzZFcx?=
 =?utf-8?B?dm85NVpqdGdDbjcxQnNpYThreTRtTFFwSWFTbGRKNmhDRDNoc0Vab09JNERn?=
 =?utf-8?B?b1BPd0lhVUFGZHR6K096RVYrTE5kUUVncVR6VTE4aUZmbTN0bTkyMno2OFF1?=
 =?utf-8?B?TmhuRHdUaTVwcFhGU3BrbWhyRTNuS3F2MGJKa21rbEROM2haWHZJRnhvQXdN?=
 =?utf-8?B?ZzhwOE9DaFJ5TWRYYUNIVW5mWlQzajBKSFh1dERObzVlUmluSUpqSWgyUy9D?=
 =?utf-8?B?Y3dyMU9GMjdjY3Z3Zi9MZkdRQ0VvWUF0QzFlZmh3emI4bVFuRURnUlR4Mkw2?=
 =?utf-8?B?TnoyU2xEWFhaN0lnTVI5ODlpZE95YTVRaEtqV2d2NGlaam15QUFEZERpTlpD?=
 =?utf-8?B?M1M5eFJ0ZTlzWFNyN3NYV2d6RU0yR09PZmRpZUpQQ2FZMmc2TnN1RlJSc0JV?=
 =?utf-8?B?QWlra1JJUDFEZmZNL0J0Q3VUTURUeDhScHoyOTBob3ZFZmpnZjBGdEhSQ3NS?=
 =?utf-8?B?RmZqcXFKMjZlUXdVUW1lOC94MFF5SjBQQ0xwWUJBdVNIWTFmL3ZXNUo5ZWI2?=
 =?utf-8?B?amoxVE9YRFY3Y1hicmgzZzJHL2xVM09rdnlYNW5JRmVDNUtTZ09aTGRXSzVE?=
 =?utf-8?B?aEdSS09ZVzVIUVltOHV1a04rNmtuUFVKV2JaZ2ZHL2F5UWFPWkFOSTdPMUtU?=
 =?utf-8?B?Mk5QVCtEY0t3dUJOZU5XVEhkZzdjL0Noa3ZDZU9aSXF4ZGJBL2dMZ0lqV0pS?=
 =?utf-8?B?aElSK0R3UEdkbHhLVklaYm9KOVRDc1N1TTZqOERXK0toNUVtTFlRMHg5TUEy?=
 =?utf-8?B?OUtNcWR4OVpVRHBpS3MzZGZGMkd2QktKaHBZaUFycTR5dFc0TVJ0SjFGamdk?=
 =?utf-8?B?Ryt5cGQyK2cxMVR4Q2Y1RGZFRy9lUWRhN01ZU1VxM2xXT21jUGRqcktueWFs?=
 =?utf-8?B?aUkwVlM3cXRmMWVIUHk5eWVQL2NuMTRWOGlCSEdvVVlUVjlJZ3dCeW1jL1JB?=
 =?utf-8?B?NUU5SUtUZisxd3cvT1luMVRwMDBVUkdrakhYUGFzVzVLb01NMnNyR1VPKyt5?=
 =?utf-8?B?U2VVSHRSTUdjV2xFeXViRDNZSnlYeGdrVmZqTVowbktBd2lNN1l2U2ZHZXZS?=
 =?utf-8?B?RDJGOWtyTnN5WUV5VS80L1d0VGk0aStteHhxMjdrQkl4QVhrRitXSW81NmVV?=
 =?utf-8?B?L1I1YnFMMWVneHpwZjczYjhMMm50d3I0S25IL3JLdkIwdFZ1UUYveExpM3or?=
 =?utf-8?B?OVYwck9iMGNTclVNbWFXQ0gydk53dFNPL0VySUVzQVAxcUxydDR0VVUvUm0v?=
 =?utf-8?B?S1RjSVc5aS91UWtpUmZTQ2lFQW91TkJhUktvcjBaN3lWWlczYWFpUVJZUmg3?=
 =?utf-8?B?bDdMeUxYa1VFVXJqQVRRcytWdDRQQ0NncTVJSXQzUW84MEdMUXAxNjdQeGtp?=
 =?utf-8?B?c2JlRlRzbFFjMjVKQkxtQ1JjcnlHYUM3Z0xZMGY4SW1SWGpHeGhxVUY0cktr?=
 =?utf-8?B?OTFrUWxJMjh2WDNjOWlqeGY1UzFVL0lkZDVERUxzSisvMjZQdk9HMDBVN3dL?=
 =?utf-8?B?aHdTRzlscnowemtMRWQ4cld0ZXlTL1dkUUwxM0VLM0QrY1pxSFpKaEVtbFc2?=
 =?utf-8?B?N2dNck1TemY1K2F0OStabGg1d2JaM2JweEpKNFBINU1kMlRXMzR3Vi9DVllo?=
 =?utf-8?B?Nk5QYXdkd1IwdHNHaThEZFJTcTFqTnNtOGh0VUhzTU5NaUhDNUtwdXNTOTVt?=
 =?utf-8?B?RWJDQjFHUUp2RUhuUUI4ZWpyY1lvZ2JQR3RLWklIMVdPUzl4MDZPUVRmcGdI?=
 =?utf-8?B?KzhSNG9sMThBdEVQdGhlNG5TbittNTdwN05pM1gyZjIxWlUwcERhenVvZWxu?=
 =?utf-8?B?NjF2Z2tkeXdnMzlrbjF4Y2NyVXQ5TmFoRkVVclNpU1VyY09HYW1XdzdENE5X?=
 =?utf-8?B?enhQbmJadFREWVB2dnhLdDRtQUlGZWJUWjlqV3RKaHZrQ2lsVi9XN3hoblRC?=
 =?utf-8?B?bzhwTjhzb3BOclJObXlTT3YyM0tNWEJFNVA0aFFMbjdoelJsbVk4aUlKT1By?=
 =?utf-8?B?YTBuMXphQjEwQll5cysyTStyUlI2b0QxK212ZWtrRndNc3FZd0N5ZktBaUNX?=
 =?utf-8?B?SjE2MU02VjZrdG5mLy9ZU01wbG5obkZZc2VmdFppNmpYdTNCdkFlakUwR2R5?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8aa1ca-e895-4a6b-7314-08dbfa50d9da
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:55:36.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K76Embpxm3nhMz1EMp2885tVh0f8WXd8ZCBGg4buMGqrPX64C+1DDmn0apZxe/Ossx8sJwap0DpXRRoZHkxf6lLuyoJVN6/sXDRFqzdkzQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 14:30, Andrii Staikov wrote:
> Switchdev mode allows to add mirroring rules to mirror incoming and
> outgoing packets to the interface's port representor. Previously, this was
> available only using software functionality. Add possibility to offload
> this functionality to the NIC hardware.
> 
> Introduce ICE_MIRROR_PACKET filter action to the ice_sw_fwd_act_type enum
> to identify the desired action and pass it to the hardware as well as the
> VSI to mirror.
> 
> Example of tc mirror command using hardware:
>    tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower src_mac
>    b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth1
> 
> ens1f0np0 - PF
> b4:96:91:a5:c7:a7 - source MAC address
> eth1 - PR of a VF to mirror to
> 
> Co-developed-by: Marcin Szycik <marcin.szycik@intel.com>

Co-dev must come with Signoff

> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
> ---
> v1 -> v2: no need for changes in ice_add_tc_flower_adv_fltr()
> v2 -> v3: add another if branch for netif_is_ice(act->dev) ||
> ice_is_tunnel_supported(act->dev) for FLOW_ACTION_MIRRED action and
> add direction rules for filters
> v3 -> v4: move setting mirroring into dedicated function
> ice_tc_setup_mirror_action()
> v4 -> v5: Fix packets not mirroring from VF to VF by changing
> ICE_ESWITCH_FLTR_INGRESS to ICE_ESWITCH_FLTR_EGRESS where needed
> ---
>   drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++----
>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 41 +++++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
>   3 files changed, 60 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index ee19f3aa3d19..4af1ce2657ad 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -6065,6 +6065,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>   	      rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
>   	      rinfo->sw_act.fltr_act == ICE_FWD_TO_QGRP ||
>   	      rinfo->sw_act.fltr_act == ICE_DROP_PACKET ||
> +	      rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
>   	      rinfo->sw_act.fltr_act == ICE_NOP)) {
>   		status = -EIO;
>   		goto free_pkt_profile;
> @@ -6077,9 +6078,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>   	}
>   
>   	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
> -	    rinfo->sw_act.fltr_act == ICE_NOP)
> +	    rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
> +	    rinfo->sw_act.fltr_act == ICE_NOP) {
>   		rinfo->sw_act.fwd_id.hw_vsi_id =
>   			ice_get_hw_vsi_num(hw, vsi_handle);
> +	}
>   
>   	if (rinfo->src_vsi)
>   		rinfo->sw_act.src = ice_get_hw_vsi_num(hw, rinfo->src_vsi);
> @@ -6115,12 +6118,15 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>   		status = -ENOMEM;
>   		goto free_pkt_profile;
>   	}
> -	if (!rinfo->flags_info.act_valid) {
> -		act |= ICE_SINGLE_ACT_LAN_ENABLE;
> -		act |= ICE_SINGLE_ACT_LB_ENABLE;
> -	} else {
> -		act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
> -						ICE_SINGLE_ACT_LB_ENABLE);
> +
> +	if (rinfo->sw_act.fltr_act != ICE_MIRROR_PACKET) {
> +		if (!rinfo->flags_info.act_valid) {
> +			act |= ICE_SINGLE_ACT_LAN_ENABLE;
> +			act |= ICE_SINGLE_ACT_LB_ENABLE;
> +		} else {
> +			act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
> +							ICE_SINGLE_ACT_LB_ENABLE);
> +		}
>   	}
>   
>   	switch (rinfo->sw_act.fltr_act) {
> @@ -6147,6 +6153,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>   		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
>   		       ICE_SINGLE_ACT_VALID_BIT;
>   		break;
> +	case ICE_MIRROR_PACKET:
> +		act |= ICE_SINGLE_ACT_OTHER_ACTS;
> +		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
> +				  rinfo->sw_act.fwd_id.hw_vsi_id);
> +		break;
>   	case ICE_NOP:
>   		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
>   				  rinfo->sw_act.fwd_id.hw_vsi_id);
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 08d3bbf4b44c..b890410a2bc0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -689,6 +689,41 @@ ice_tc_setup_drop_action(struct net_device *filter_dev,
>   	return 0;
>   }
>   
> +static int ice_tc_setup_mirror_action(struct net_device *filter_dev,
> +				      struct ice_tc_flower_fltr *fltr,
> +				      struct net_device *target_dev)
> +{
> +	struct ice_repr *repr;
> +
> +	fltr->action.fltr_act = ICE_MIRROR_PACKET;
> +
> +	if (ice_is_port_repr_netdev(filter_dev) &&
> +	    ice_is_port_repr_netdev(target_dev)) {
> +		repr = ice_netdev_to_repr(target_dev);
> +
> +		fltr->dest_vsi = repr->src_vsi;
> +		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
> +	} else if (ice_is_port_repr_netdev(filter_dev) &&
> +		   ice_tc_is_dev_uplink(target_dev)) {
> +		repr = ice_netdev_to_repr(filter_dev);
> +
> +		fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;
> +		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
> +	} else if (ice_tc_is_dev_uplink(filter_dev) &&
> +		   ice_is_port_repr_netdev(target_dev)) {
> +		repr = ice_netdev_to_repr(target_dev);
> +
> +		fltr->dest_vsi = repr->src_vsi;
> +		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
> +	} else {
> +		NL_SET_ERR_MSG_MOD(fltr->extack,
> +				   "Unsupported netdevice in switchdev mode");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
>   				       struct ice_tc_flower_fltr *fltr,
>   				       struct flow_action_entry *act)
> @@ -710,6 +745,12 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
>   
>   		break;
>   
> +	case FLOW_ACTION_MIRRED:
> +		err = ice_tc_setup_mirror_action(filter_dev, fltr, act->dev);
> +		if (err)
> +			return err;
> +		break;
> +
>   	default:
>   		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in switchdev mode");
>   		return -EINVAL;
> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
> index 5a80158e49ed..20c014e9b6c0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_type.h
> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
> @@ -1055,6 +1055,7 @@ enum ice_sw_fwd_act_type {
>   	ICE_FWD_TO_Q,
>   	ICE_FWD_TO_QGRP,
>   	ICE_DROP_PACKET,
> +	ICE_MIRROR_PACKET,
>   	ICE_NOP,
>   	ICE_INVAL_ACT
>   };


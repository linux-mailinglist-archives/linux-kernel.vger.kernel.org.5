Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9B7F1342
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjKTM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjKTM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:29:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A661F2;
        Mon, 20 Nov 2023 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700483375; x=1732019375;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UwyQV4f/fDnSvw9WZJs3vHLql3w+FAk1hKqPH5yNU+4=;
  b=UQFjPVN7uYSh3ekzcpfTo3fKATXgujSDSCWsmiyzpsUHmsHJ4XC2L+L0
   CIrIdI3Jc6GUuQ5nqlCd4C9zXNdJs8z8h1NbdjDpNqQK/ujykI4fcRW+f
   +6RxqF97AYzyNg83CYs2QtqjB7U51nolAVjZoX83rHKm5A1WUV+0Veb4i
   Gre1yTtPY9f41/qXDBAog5PrfbfbPGJoKo5ArnMXPmtt8utmp3u4i552n
   Mn2Bz/5P1+/Q657qtRaMEXR0wMnUZ4gAhgOhhmvpzWNRMP+F7AJOmQsyV
   itBhURXqlIS4ni5dMl4C5Jand9A0xyM8BUrgz/Qq0gYyvkUY++kbweulZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381997421"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="381997421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="766262524"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="766262524"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 04:29:21 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 04:29:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 04:29:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 04:29:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCVUHbkxE+XWNEC8sRW6rNgGkLkFreuX07gkvhlpzPzKoSXi3QIKrj3X6kEnWy4dfawet2hSAhflil2ONJTwl9WKlvuhJU087Dj2kcEFt6tSgQ9wuZ2WvXbheTUGGfsWTWkGzfNQVO6FrUvZFwkTQ2VDyOTjnr2JG7tNvCNJTWb8Q0o68NI6CC2LbGQOtauruOCCyEqfFyZ1Sm1cf+lNicBnukRdL5y8OZlvgaRw3o9cmOEpRW3zV6GQa6FbSz03ha1PWAO3xjELLN0uw0w/gs0xttVHVYIbyPAIZI0YMc04RIjlqojfhbtg+dimG6pUXxHJI+cBnLj327k1Cdf39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BaMrD+wIqRcKfgHkbdDcRYApB7iK1xTgTl9E8q7kyE=;
 b=UKBf0AScpcV8MIK7Dz1KUvLm27N+vxk7PJqdSxJt6G7pKMnru67fcvXYMz6+cTATr4iI5kH+mqgRsYmPwUaueUlGONzLRbFv3kbI7pSisZTg1NKUuDKcAYcsf4yqlXzmrSTRRG617+/ew/Q6NeUF1Ju7ZQnGI0fIMJcKqjdmWUbAOlyVMRV/INp5PW8uYm0LT39qqGWOaoIMN4HgoaBElVoujFP1vb7FabHvP3gi/42b6zURVd1aeczQFYxZHmiZaYsrNv+TEwNqjT952JP+jJDcUny9CRZndGw9g4zVD9hSXVV7PZF4D6Lsy3HpffQK0X/GEXU5R1PTyRyThNxT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 12:29:18 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 12:29:17 +0000
Message-ID: <5ce53c5c-d80a-4bb3-83d5-e70317052ed0@intel.com>
Date:   Mon, 20 Nov 2023 13:29:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 2/2] octeontx2-pf: TC flower offload support
 for mirror
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
References: <20231118180157.3593084-1-sumang@marvell.com>
 <20231118180157.3593084-3-sumang@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231118180157.3593084-3-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA1PR11MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 4480fc9d-7fbd-45f4-8941-08dbe9c4505a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHpL4K3OEs8lxGRkpsr2V5I+WFfs8PC54DlGhi5kDiZW/Hy/sghsu9h+SD7cpPG5xUr/NeCSEsTZp7Z+8T29y/54uI2IvByoeQqHt+RmtqEJc4sNPIbBaYJLvx36rh5wxfdtDNqn+pVJbeix0wdBhUeWYUmaBUGsedKWy/cWJVgEzsV2ugTln3Xw/Tu2YZuLrkxSQnOJIvSvU0WsyTik78nhhV3kIL43Z3BBqCqxRR1YINS6AxlOvbT99fuJMhCzI0zbnkykCpDYzIysIbHMaRjpIcqDBxIVl+r8VABqtnQWEmaEx2GIjjTwcu7BhCY9USLx5spMJMft0ukvbY512nR6BrimSzfOPFfx7HdqGWNLil1dsPajJFeZtgGaqW+x/RuLP54a9PYA46OsMa/k8Cqj9tmNwYjkAvfv4ZHl44wc4MrEVUQ3Yyhzk+UVgZuvH8Z00itzO8p5dUjyHjmVB/KjSm9CMTJCQs9Z2NZQt9kWRxwQUeJOmHssn731/n4+N8KlA++uId14nMmqprHF9CfqL+cwqmlTgBHGRiCeV8Rj4s7ukjPatSLlDD4c3gMmPyDEO6tLco9FNcYLV95olK4676HkT8fr19HPYNz+cpuYdsNoyZGHSh8wKGzv62K0XYRnCt2anJhnTRdywc3fTZ0Sdn1e2Osm8hQeJZty/vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(8936002)(7416002)(82960400001)(44832011)(26005)(36756003)(38100700002)(31686004)(6666004)(2906002)(316002)(66476007)(66556008)(66946007)(86362001)(5660300002)(478600001)(6486002)(31696002)(6506007)(53546011)(2616005)(921008)(83380400001)(41300700001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3o3VjlVQmtocEcwZTJqMWk2L29JTWRQcFQ3cXZsZ2JxZnpMU0lMbWp4WlJ3?=
 =?utf-8?B?RExBNDQ4eWVsWW5JcENZanF6REw3aXllRlhOck8wdEFtek53dW95Q0JCQ1RS?=
 =?utf-8?B?eDN5OXlFYmZqNHF3cUhJRXA3N1AyVDZOQXc5Vm00RDNleDN0Q1BwMnQyVzR5?=
 =?utf-8?B?VjcvWmJzdzVaM3FhUDBiSzdtUi9za0RoakRHanBhelFQdTRHZk5rYzJ1Q1VV?=
 =?utf-8?B?ZFJyZjRma3JaQjF1ejlIc2NkSmxQMjluRExzYU1SK2dJK0tKV3FpeWd2Yzg5?=
 =?utf-8?B?TmxWalZFeC91VURTRGE2dEVxcVhqV0ZRNTZHU1RJZWxrWnBZNXdoNnlFbWxn?=
 =?utf-8?B?cktObHpJeUI1ckZNb1NvdDlxRjZJMEdOZWo1bjNpSTc2Z3Q4ZjFlQ0o2aGZK?=
 =?utf-8?B?OFJJcEhOb2Z4TU1Cd3R2NElMNCtob2xpNWUzNGFneEhtVWNsM0JGbW5kOTBD?=
 =?utf-8?B?RnppMzJRZnFUWGtJNVNtV0xnTVRkaFp0NzRhenFTTDZvK3RTbll2bDBkT2Vo?=
 =?utf-8?B?TTZ5QlpXM0hxa0E2WnBYSVZVanlxYTRiVlFqZjZ5cFdlekNUaVRVSjBzUXYz?=
 =?utf-8?B?clVQR0NzMU9VRmwvM2t4Z2hhVUtWamtMMGFNbEpOS3oveDhYaTdYekJIZlpY?=
 =?utf-8?B?WU9nOE5haTVaMjlZdUd1NE95Y1FCb1B4d0ZTWWVEY0VKUk5wUmZnNE1MZ1NX?=
 =?utf-8?B?WUNVN05hejVVVUtXTjlKLzRla2tvZE9nK1BuV2V4eXQ3SmY2clFXVkxKdGZ4?=
 =?utf-8?B?NU83RTdIbUxjcXhrRGxhbG9zREluVnNWOFU3c2ZtdXROUFIwcEdMeUYralkx?=
 =?utf-8?B?NjlGY3IyN0tlcEx4cEt5WGI0WGF5dlkyVHFHZm8rZ3NwcERWWDN5VnJCUEpw?=
 =?utf-8?B?aTFzVnFHZ2RxTU9WRzdDM2xMV1B5TG02ZXhGZ1V4VjFZSURhY3ZzbURyT0R4?=
 =?utf-8?B?dU8vZFo4QjNXbUhTUUVtdGRqQUlQcnlBMnpuN2JvU0x3ekVpWXZNdDcvbSt0?=
 =?utf-8?B?ZmI0YzZRN2ZwK0lRTWljSlNiR3libTZrVlRyUmNhSWlFTmNaMWNncGVXUGdm?=
 =?utf-8?B?MTUrSXhMSUhzcTVNcjR4dDR0aFhCbkVRQUM3Vjl0a2ZMaFdTb25JMjIrckVG?=
 =?utf-8?B?TkdvdWNZa0pEcy8wTkkzOUhSL2Nra3BGTmhWeVMwNDV6dHVrUGZaT1V2YzZr?=
 =?utf-8?B?V2FSeWhnY2xKTkpSdERMQkJXOHZ0cHljWWZOMVVCSXVKRVdYNGVkNUZGSjhP?=
 =?utf-8?B?bkVvUzRBMVllMUlxN1BXOGZEczhXLzdVNFNWRmN5U1cvUlRFanZYZjhKWVpF?=
 =?utf-8?B?WVk1RVlMaFM5YjM3dmszQUpzS1JpMWVYWFVTK0JHU3c0SFVMYjdYbWVKalQr?=
 =?utf-8?B?ajhaMXRLbHNVa211YXZCL3VQbEpTQTAwL21QZWl5Zlg5WnVnWDVqdTdKK0x6?=
 =?utf-8?B?YnE0aUY2QzdKNjRKTHBva1RWVk16eVpVclRHbnM5TlpieUN5ZG5mWnJ4QTM5?=
 =?utf-8?B?VEN1U1krZjlwZjZlSFQxNE84VnZXeW1WendGMEVqU3V4NDhaNXF4RmQrWFlN?=
 =?utf-8?B?QVRjMkZwRVBwcElsUm1lN2NObVlKZXpRZnRoSllUZ3ZmckMwMDFNSGl3YlJB?=
 =?utf-8?B?em90RG5DT1R3Nk82Um15QzNZMzE5Wi9wUjdmdDdYcHh6d09xNjZFS2hRczdx?=
 =?utf-8?B?RFlPdWhMU204RGtMc2dQL3ZvT0dCNHZxWEQyR1Facm44aVpBUGpwS0x6VDJa?=
 =?utf-8?B?eWc2ZVQzZnY4elRodnBpVDdQeXFNMytlMHI1Nlkzb0g4UXY5enJXYTRVcGNZ?=
 =?utf-8?B?c2h3UG1nNGlRS0YyWEV1dmNsaXprYXg3ckIxUmI0NHBZQUk2VW96VXNEOS8w?=
 =?utf-8?B?RUV5OTI4aS93eVlVbjk3angxRDhINHNDYTBJTDJ4MnZ5Q2ZmbVFGU3ppREpP?=
 =?utf-8?B?OTlPc1U2dTltSjZQMnNrU0l3QlF0aEplbUZWZWlXeW8rVGc5LzE2TVVYRHdH?=
 =?utf-8?B?ZlRNMG95S0tyT0pSbEc3Z2l1dWd0QzZXQUxsc0NJekRNRlNZeG11RHRqaG1q?=
 =?utf-8?B?UUc1SmNRMnZzcFk0Q3FUMVFIZXFLeHRLS0o0ajhFa0xGVE1DbG9IUFNFZUJS?=
 =?utf-8?B?cnptQlFTYXlJeWFxUXJQdFJtd2Y0MFhtejdhM3RGWkJGS2tKRzZmRURTWkRY?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4480fc9d-7fbd-45f4-8941-08dbe9c4505a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:29:17.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L02cQ8C1Kw7LjRLlRG5z2wH3TaGhgKBacz+bKGMt0ur/NyzMy20+z/F9yQDjMEjjuUVU7L44D/R1UylEYMWtaV3AwbzxmTyAArRHj2Q9jbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.11.2023 19:01, Suman Ghosh wrote:
> This patch extends TC flower offload support for mirroring ingress/egress
> traffic to a different PF/VF. Below is an example command,
> 
> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> skip_sw action mirred ingress mirror dev eth2'
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---

I already added my tag here, you can add it to the next versions.
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 +++++++++++++++++-
>  1 file changed, 110 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8a5e3987a482..17a8d9778193 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> @@ -29,6 +29,8 @@
>  
>  #define OTX2_UNSUPP_LSE_DEPTH		GENMASK(6, 4)
>  
> +#define MCAST_INVALID_GRP		(-1U)
> +
>  struct otx2_tc_flow_stats {
>  	u64 bytes;
>  	u64 pkts;
> @@ -47,6 +49,7 @@ struct otx2_tc_flow {
>  	bool				is_act_police;
>  	u32				prio;
>  	struct npc_install_flow_req	req;
> +	u32				mcast_grp_idx;
>  };
>  
>  static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
> @@ -336,22 +339,96 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
>  	return rc;
>  }
>  
> +static int otx2_tc_update_mcast(struct otx2_nic *nic,
> +				struct npc_install_flow_req *req,
> +				struct netlink_ext_ack *extack,
> +				struct otx2_tc_flow *node,
> +				struct nix_mcast_grp_update_req *ureq,
> +				u8 num_intf)
> +{
> +	struct nix_mcast_grp_update_req *grp_update_req;
> +	struct nix_mcast_grp_create_req *creq;
> +	struct nix_mcast_grp_create_rsp *crsp;
> +	u32 grp_index;
> +	int rc;
> +
> +	mutex_lock(&nic->mbox.lock);
> +	creq = otx2_mbox_alloc_msg_nix_mcast_grp_create(&nic->mbox);
> +	if (!creq) {
> +		rc = -ENOMEM;
> +		goto error;
> +	}
> +
> +	creq->dir = NIX_MCAST_INGRESS;
> +	/* Send message to AF */
> +	rc = otx2_sync_mbox_msg(&nic->mbox);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to create multicast group");
> +		goto error;
> +	}
> +
> +	crsp = (struct nix_mcast_grp_create_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +			0,
> +			&creq->hdr);
> +	if (IS_ERR(crsp)) {
> +		rc = PTR_ERR(crsp);
> +		goto error;
> +	}
> +
> +	grp_index = crsp->mcast_grp_idx;
> +	grp_update_req = otx2_mbox_alloc_msg_nix_mcast_grp_update(&nic->mbox);
> +	if (!grp_update_req) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to update multicast group");
> +		rc = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ureq->op = NIX_MCAST_OP_ADD_ENTRY;
> +	ureq->mcast_grp_idx = grp_index;
> +	ureq->num_mce_entry = num_intf;
> +	ureq->pcifunc[0] = nic->pcifunc;
> +	ureq->channel[0] = nic->hw.tx_chan_base;
> +
> +	ureq->dest_type[0] = NIX_RX_RSS;
> +	ureq->rq_rss_index[0] = 0;
> +	memcpy(&ureq->hdr, &grp_update_req->hdr, sizeof(struct mbox_msghdr));
> +	memcpy(grp_update_req, ureq, sizeof(struct nix_mcast_grp_update_req));
> +
> +	/* Send message to AF */
> +	rc = otx2_sync_mbox_msg(&nic->mbox);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to update multicast group");
> +		goto error;
> +	}
> +
> +	mutex_unlock(&nic->mbox.lock);
> +	req->op = NIX_RX_ACTIONOP_MCAST;
> +	req->index = grp_index;
> +	node->mcast_grp_idx = grp_index;
> +	return 0;
> +
> +error:
> +	mutex_unlock(&nic->mbox.lock);
> +	return rc;
> +}
> +
>  static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  				 struct flow_action *flow_action,
>  				 struct npc_install_flow_req *req,
>  				 struct flow_cls_offload *f,
>  				 struct otx2_tc_flow *node)
>  {
> +	struct nix_mcast_grp_update_req dummy_grp_update_req = { 0 };
>  	struct netlink_ext_ack *extack = f->common.extack;
> +	bool pps = false, mcast = false;
>  	struct flow_action_entry *act;
>  	struct net_device *target;
>  	struct otx2_nic *priv;
>  	u32 burst, mark = 0;
>  	u8 nr_police = 0;
> -	bool pps = false;
> +	u8 num_intf = 1;
> +	int err, i;
>  	u64 rate;
> -	int err;
> -	int i;
>  
>  	if (!flow_action_has_entries(flow_action)) {
>  		NL_SET_ERR_MSG_MOD(extack, "no tc actions specified");
> @@ -423,11 +500,30 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
>  			req->index = act->rx_queue;
>  			break;
>  
> +		case FLOW_ACTION_MIRRED_INGRESS:
> +			target = act->dev;
> +			priv = netdev_priv(target);
> +			dummy_grp_update_req.pcifunc[num_intf] = priv->pcifunc;
> +			dummy_grp_update_req.channel[num_intf] = priv->hw.tx_chan_base;
> +			dummy_grp_update_req.dest_type[num_intf] = NIX_RX_RSS;
> +			dummy_grp_update_req.rq_rss_index[num_intf] = 0;
> +			mcast = true;
> +			num_intf++;
> +			break;
> +
>  		default:
>  			return -EOPNOTSUPP;
>  		}
>  	}
>  
> +	if (mcast) {
> +		err = otx2_tc_update_mcast(nic, req, extack, node,
> +					   &dummy_grp_update_req,
> +					   num_intf);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (nr_police > 1) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "rate limit police offload requires a single action");
> @@ -1033,6 +1129,7 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  			    struct flow_cls_offload *tc_flow_cmd)
>  {
>  	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
> +	struct nix_mcast_grp_destroy_req *grp_destroy_req;
>  	struct otx2_tc_flow *flow_node;
>  	int err;
>  
> @@ -1064,6 +1161,15 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  		mutex_unlock(&nic->mbox.lock);
>  	}
>  
> +	/* Remove the multicast/mirror related nodes */
> +	if (flow_node->mcast_grp_idx != MCAST_INVALID_GRP) {
> +		mutex_lock(&nic->mbox.lock);
> +		grp_destroy_req = otx2_mbox_alloc_msg_nix_mcast_grp_destroy(&nic->mbox);
> +		grp_destroy_req->mcast_grp_idx = flow_node->mcast_grp_idx;
> +		otx2_sync_mbox_msg(&nic->mbox);
> +		mutex_unlock(&nic->mbox.lock);
> +	}
> +
>  	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
>  	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
>  	kfree_rcu(flow_node, rcu);
> @@ -1096,6 +1202,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	spin_lock_init(&new_node->lock);
>  	new_node->cookie = tc_flow_cmd->cookie;
>  	new_node->prio = tc_flow_cmd->common.prio;
> +	new_node->mcast_grp_idx = MCAST_INVALID_GRP;
>  
>  	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
>  

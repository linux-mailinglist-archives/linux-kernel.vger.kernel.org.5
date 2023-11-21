Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E345B7F318D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjKUOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjKUOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:48:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B799A;
        Tue, 21 Nov 2023 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700578106; x=1732114106;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=39LAPk7mmvs+GxMXeIfdd/+ifqdHf5Xjik5PViXvUCU=;
  b=a7fqzAxhRSGEi2U5FSzyZy7OhapL/pn/iibTRfujB8L2y3V+42FrTlqS
   PcxkQFPiMhWteqSUk1N3ULIazUwNHJYl7T+Gjxmcb2WJYpNCXoSs7KvV7
   9lvHtqfsDRloCS/GQ1sJM08axQQTVdxJ8ZyUIx4CJ5T4u1Tc2RdZx6bAm
   DtXAYAfjWTRvBQQzo05ubPpgXFj9bsA7eRTOtHWGzDZPhlHAW+LLpyLYE
   PIrV02azhxFadP4So8VOe0EHuDPQ1sEmTu9vZeqyVPo8HUFj9npS7jXAG
   YEZcI/hAGLnrMRTDoa+E796heIx7bG/nJ85mNV/m/V9wJ5wQGK4bvENwM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="389001933"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="389001933"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795812465"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795812465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 06:48:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 06:48:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 06:48:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 06:48:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 06:48:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLZfrzbHZXNd0dn6+DOoUe4JRlyMhnxIgtKP1G37eqlEcd64gYrmHCdabBjhIq5qP393CLkKiciXfPrZS4fzC9j716H+cBH46aEYR1oMcRb7s6ihRNQkgI2Avk8ObXVJo9jOC9QgmevUjDd9sI2lLtGuHidySAVtbycfdJwzq5OkDAaAVhW9FTd5N8B09hd+fCBEPBdyEQFny/WpIYQOoK73Mg6dCGyDPx8V4tCf4NjxIIijTgkgG6nbv81l8ooWDPsCzkLAfK8g7AvUjkE9d3tqmE16S/nPPtNIoxy9k/PahybkzRyMrHFGt2CeZ17l8lh6uX4F9tbgdam27UxdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plmsae/WN61II9KAbzVhKV40N8wqZBwFXBPQkXNj+WI=;
 b=aq1i9uEq/6KSw3uwNDf5zbEzNGqP8WxJGpQ+PSOiAeixrpDtlpyXfiwxUGxB9hR+5YVdJcFcmVIj8Xglx5yTrlROn4DELeSACEXUHHED5M6Btmp9jy7UJ7pMnKIeU13ehPLcr+xF9UTbUD09+DQRIOFILQMXAMxt/sH9nY/zmZ5l4eRtBJQNCkcZ+fjpymH5M3prUewmNwrJiwI6I+EcLA5zIOTY19Mv/N+JpuWo0Q9XrI9lilYyreeZBb1nzBK2dSx20hGGSkGNa8yr8mwJ9Z1catbJYQJE/fgAyYFaT5PhRLc5mEdM909h98O0RUoV8yE+088xQ1P5SXQNJZxmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 14:48:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 14:48:21 +0000
Message-ID: <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
Date:   Tue, 21 Nov 2023 15:48:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/2] octeontx2-pf: TC flower offload support
 for mirror
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <horms@kernel.org>
References: <20231121094346.3621236-1-sumang@marvell.com>
 <20231121094346.3621236-3-sumang@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121094346.3621236-3-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: f705f2c6-2e59-4b49-9638-08dbeaa0e854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkPjH4zf3D+uOHgiZmoDs35tN/Tx7z5dYWqnLg4bGTNgdHyXH9a4fXxVsMA/BiHAabXW/YoMn+8cOzOhOhxlUUoY1/7uvC1dpOCqjsO2PhjlM3PqF9bzawtIL2HRekLY0oq5FlyY9i1CYQ49c/I7aABAdxms9PCkSKXXBX7/YHZmavfJVn/YfcEspDTqtcfcdoh69eSFaL4u7jZlzf4E2JYykdhtn/Cc8W4NflbPRAfKS4FlnFEzguNvUSMIyFs39Lu3JlWWvoYbTNZ7IM+7HP74pzlgraLCmXRKfIYRAN1cYq+X+y6jpfIK9nm0Y4ZoZcff9de7AvgzeCZ5be27gBM2c6OyZTUULnrLpEinn1FaSD3xRIRFNjo1NOIjRqGDw/7/lEYrcYSaYOwKK8UuI8xo1SIqiMEp9U09w+hqqPQtcpJE+ullzLygMN+oldzlId15PGk5AgsH7IKFY8cnnUZXajfIil0FInNIOqR+vn+rMd6ho+FKnw5ox5ngtEsrwoSr9bXbDeD45iGNzXf6Wjy4s2FLCZ856cLDZwo8/NnbBJM32DcYBesDhB+Yz03nPWcGmjMMAPYu5pCZy2Ed8ay1UYiE1uPN7VfQE10YKiFlrVpeor2Mq4esqLxkeLLtC35jCJ3Q83hU3Ni7xTzZKFoLhzgBn8I9jHewe+9rEvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82960400001)(86362001)(31696002)(31686004)(2616005)(6486002)(6666004)(6506007)(66476007)(66556008)(66946007)(316002)(36756003)(921008)(6512007)(53546011)(26005)(83380400001)(7416002)(2906002)(44832011)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUI4WGRnM01LU1d5NjM5MnJNQ3hVTGIzMmQxOGY2RmIxY0FwZk9HaHVUYzJu?=
 =?utf-8?B?bFA2TDgrSFdzUnRYMHVpdHJqYlRkWVdvRzZIL25qdzA4WGpQUmtIOVM0Z1ZH?=
 =?utf-8?B?WjFVUjErNGl3TG05cHAvK3dQSXI5U1dGRXBpcWhRUzlWdFZNZ0tTblJXckda?=
 =?utf-8?B?VkFkajl2b3BrRzE3NDFmRnQyYUxrTE9zTVZlR1BQMDJCQ21EY0lBbHNwanBv?=
 =?utf-8?B?ejZOaEJkQ3hrRTVYRmt1UXZReUJKY1V6aWdJWnUrSVNhRllxQUdBTXlLNStY?=
 =?utf-8?B?S1A5VS95Z3g0T095U3dGbnMxQ2lGNlllUENQc0owVE9BemJRM0FVekxybnVn?=
 =?utf-8?B?WExuTzg1NnBvMmVIbGF0WlpkOTVEaEZKOGsrR01xajJsOHNtSHMreGR2YkFy?=
 =?utf-8?B?UlFLS3BORVIwKzhlbmtjNDFyZ1lLZStvbnlSbzAwdSt4R3Q3MU8xV1BOM1gz?=
 =?utf-8?B?Ty9FUVBJMEJ4UGo0dzY3c1pWY1J4d201Q2h2N2hHUTRDZ3dJcmJNZ3EyS2pp?=
 =?utf-8?B?aGwwNHVxQXZRcU9PYlFXY0k2bXlMNFRtbzNvd1BTQWUwckRlZzlYVTZpME9I?=
 =?utf-8?B?ZW1VQXV1WlMzUzVMaVNkbC9ET3lFV2RvaVhRcVdnZzlWUlF5dW8wQUtZaWNn?=
 =?utf-8?B?WGxlYnVWUkI1SFVuUmhtMEFsQ1FYaXZoZDRscnVtcTkzRmcvbFZwZWZtQTNN?=
 =?utf-8?B?T0xVM1FwcDJMeGNGdGZUN3JmRWZoWTZTVEtMQUNVeUVOOVdMMXpsSEhmd0pw?=
 =?utf-8?B?L0NYUmlrTTU2cGxENStnMFIxT0VnVVExam90blplbGlrYTNrTDdzQXF1K1kz?=
 =?utf-8?B?Ukpqa2oxKzEyUUhIVmZXaFpOQXMwbitKU1dBQ2NGU3NlM3ptV0RKK3VVRlVt?=
 =?utf-8?B?K01MWi9JMytiU1ZGTkRqL1BQZ0VGaHBWOXFlcnFlWVBrVFFzZTVxdDJ0Umha?=
 =?utf-8?B?QTRHZUJJcHIwb0pweVlxdXVqUU0yMHYrTHJXcTdlK04zQ3BlaTkzNDB0ZTdU?=
 =?utf-8?B?RGdHTlhVSmlpZEpFZndUZlgrYlZNc0QvTE9LZWhGRXBYbFNtOSttazNnYlhT?=
 =?utf-8?B?ZmdLbjMvd2xINkdkcmVoV0dQcWhQQXZVZDBFL2tuV3JWcFpoTEF1RU1RMHhL?=
 =?utf-8?B?bk1uSXRDSXk3cWxiM29PLzFpQTcxUTZNNmV6bHFHYWIxdXYySFh2VjhSNytO?=
 =?utf-8?B?UWh1Yk96c1FMTmZ4TDh0MU05eXJKQWhNWVdMRVgyNDVqSC93UlVjSkg2TlAw?=
 =?utf-8?B?TXB1ZG1VOFR4Q1Ryd2JwVmhzMTRObEptSTNxQWRlMzlpeUhISzF4VytzZjIv?=
 =?utf-8?B?aitpaTRuK01EK0llZnEvZXhFRUdtYlVoN0ljTmtnUndOdmFWY3p2VG40dTZz?=
 =?utf-8?B?Z3E2QWtIMVorOWNPUlUwdGR5L3pSelAyOGRnK3dqZzk5L25BcHg3OEtSVndZ?=
 =?utf-8?B?dndTWDlEU3BWUjQ5cnpqSHZ6SDlHUml4L1dUbmY3Sk8yUTU2d3FaTlNCYk9I?=
 =?utf-8?B?T0ZrclBwNzFDNDJMUU9mQm1TOGZOaTVWS0ZVZU81VFhDMm1XMUtOZnhrcG1u?=
 =?utf-8?B?eWdGSWg5QWltWXpCWDBxS1g0alJlSkNnb3dzanMrcGJsNG5kNnQ3M3hVNkZK?=
 =?utf-8?B?RUlxOWRHOUFxbFlLU0hVWnA0MHR1dldkTFREMktsV0JNb205Y1NSbGp1L0Ro?=
 =?utf-8?B?MnYvaUE4dkYxdURXOTFwcGwvZzR6aWZPOXFkd3hzZzlnTW5ib1BVb3NvMklo?=
 =?utf-8?B?cUVJUzRPRUQzMjV3SFEyK2xNemxUWC9qSlZmRld6dEhpUHdMS0ZiRDRCRXZ2?=
 =?utf-8?B?Tm8rMFAwVTY1UWxuOVRkdjN5b2FoUzF0b0xibVhGaW9EcGdQSlpKZlVGaVBP?=
 =?utf-8?B?cmI5NklJUkFoYnU4WEJJY0QrRnZselJhcThDU1lMa3M1Zzg5cVRQRHlwMVRY?=
 =?utf-8?B?c0xqc1I2aUJNTkRDcGZ2Zm5wYWZuVTEzc25pOHl1MnFzb044WVBIZjZmR0hk?=
 =?utf-8?B?dWFXZ1M4LzI2d0hRMHgyNVNxZmJMUzlDdHN6WFg5bE03dmV3RzMwUG9WU2Jr?=
 =?utf-8?B?VzBEQUo2b0ViNHJmU3JXOERWUFgxWnF5OEdSVHVPY0VKSG92OUNHRGlEdkJ5?=
 =?utf-8?B?cVFCelNxc2ZDYnR1OVJobU1Ndm1QYmZndERwTHh2U3JkVjVNaWVJVjg1cmJn?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f705f2c6-2e59-4b49-9638-08dbeaa0e854
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:48:21.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KOhuuWuhuYGX9QL8GFT5J9JbdB9wWwmtV5PCn7C/dFRuroBfc5IKZQwjodQljX+2bnpl3vrz3QnX1x2XAT4+NK64qEbe1dW7mkF6r7alZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.11.2023 10:43, Suman Ghosh wrote:
> This patch extends TC flower offload support for mirroring
> ingress/egress traffic to a different PF/VF. Below is an example
> command,
> 
> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> skip_sw action mirred ingress mirror dev eth2'
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> ---
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4997F2A42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKUKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjKUKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:23:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB131716;
        Tue, 21 Nov 2023 02:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700562197; x=1732098197;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=n9L2Z7hxtH76thMSJ8sge0eGAUVpaTfTNaM7+7rPOlw=;
  b=cbv+w45occ4SZ8VA/RANmAbB7cx37tPkNLq5Mk2Dz8OInRtZ5dslg6Qy
   JsjAP9r8aVFxWC4U0ElxS5L0XazSX/PHBHaCVJZzzjY7gIjleLwgkzWph
   7NNE4M/DBhHyE2r7Hueb+1vFSASxtecqHdoTWgRzVI+kVHW8JqsTLql0D
   d4gRF29hOt4BpWpQVQxElelyBMbeYPlouWZDEa3J0Ci/JZaUt5DTuyc54
   9V5Ru5rzHsIAJ1t3xADKSJqlLsRigEWpdg26sMnTbju04xEw6ezPS34zK
   ppMFxZrq52SmpB2T1peomn3tqnPXZmPwAe6lccgc8Pj9UyEMoBF/bFH21
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13353260"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13353260"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884160495"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884160495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 02:23:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 02:23:15 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 02:23:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 02:23:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 02:23:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFf72iid4hTJxAsal6K/iL6qxXPsx64gT7uK3u8dKM+dRbBZGDXHWB1y5K0ycIKab5PW/v05rhngDR9nouuV9KtKsYf4mPn0fXUSnwgCNhO615yqmPfkiNUTii7eW/dNVFO1kFT/8dQ9AXuHh6b44cIx7LJx0stXLofXK0wB8DbgROdD/KzfBgP7OypsVrK/PGeNFybcO35P9lLCxAx28U2PJHYjWA318EIERSw15bhyJm9opbElrf2gPKNTvzw8gA6B/h5Py1mSwX6GlRIcYQ1wSJkhEFGq1Wr8WAjI/eR/3n2jCNlYzhYSU3gKC/RTYyTiGgO/mGWn8GgotUqERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJ5dxuKmPAHNckdDcznty8XQd0ULaB8QIDHy19nUlxk=;
 b=EKvxLIFmy2pXXH1b9FjsmvngsRAppjhq92n+WhUaXDDdlMJzzQpSLhUjSPViJAAS0OaUBLgKrESx2CzOfYkas88HpClwFodQ41rcgTYu79kJBTtyEhM/BK9z2YyTac5XJRRZ0rwQz803upWIIWsU9xqLVuXhHGBGDVthQvPhcPN8GLySkOymGsW5tWNsViHWg/q0fuyMu82YgUbUwRnb2R82AGQ2RXSmjVCzpYQH9ADdQKM8OQrFq5O1jcWC/yF24EuqvuE7pEDNX37IqwaPIQeCugU+ICSO2S8UGnECzTefbKdIF26mF81Ps76ALbyzWnWcA64ri6dksbOMu91Q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB6404.namprd11.prod.outlook.com (2603:10b6:510:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 10:23:13 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 10:23:13 +0000
Message-ID: <8769b63d-f7b2-4bb6-8b91-ffe67805404d@intel.com>
Date:   Tue, 21 Nov 2023 11:23:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/2] octeontx2-pf: TC flower offload support
 for mirror
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <horms@kernel.org>
References: <20231121094346.3621236-1-sumang@marvell.com>
 <20231121094346.3621236-3-sumang@marvell.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121094346.3621236-3-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f664eec-444f-4921-ed23-08dbea7bddfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7MkMG49i8kc8xOdJpxJRsfbrNOWKDJKTJRPCGPoQJ5/8yckAKW9vORtdQbbi/ujj/dmQwWMvGbIClXQ0IH7QACzUDQInFq1H/2NGA5CRO7cwx+poLrzmBSGaCXDNGyZzRdDRRV37ajRHUuzkxk4+Akz+9q4z8dMz2CTxMZXqqn3mVkNSW6mdzhDW3l3kZTHdmlmRFhqMFrV/djws/CMYP8e83tNBligLlewH/VWjtUv57HclMl5JeFDL4jLGdeORH8g9YoBY0i5ypTez1OIkt5SGQdze6inxEfAioJovI+CSNFnK/dwlZqgrTUPtq5LJDIZ+X+NCqdk6RvcqNbhnPWyfCzOwl1jrvC0cn8kweZBrbirx7moqsVW9RubZhK2eBxwAnVb/Imu8sQP9S6kdXV35J83CUsBmLxv3PZvju9FYME/DLqt1lUjxUz+hCFPtchyP47EtMGiinF+wjoW5gRF3cOow2cUMKoSwOJs8XkQxC/DLqheESLWC9l+KmofWHchn4qmE4S/uvJGbSiwVoCBvM+E9xylTAgjyLiB4/0iFdDR5rHInsDH+Lh7pBdyBTiL1jEVk6FK5XsdAzHfvxOchW527h/KZxI4w+X84v/7HKk286mK21TJDY39N3F5q8IUxTK9ExjgHsIXOwlnq6REDbPEDsGfPz9BsP6LgV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(6486002)(6506007)(6512007)(478600001)(31686004)(2616005)(6666004)(26005)(82960400001)(53546011)(38100700002)(66946007)(316002)(66476007)(66556008)(44832011)(31696002)(86362001)(5660300002)(7416002)(2906002)(921008)(41300700001)(8936002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJCL0lJcTVBRGJid2FBdEs5NTY0KzlUbjZEajZ5RWp5R1JzT3dOUENKS1hC?=
 =?utf-8?B?MHkvc0paUXZ5elpLc2Y1OUVodXVBa1orVUFUNGhOMmhIOXkzWllNbFozL2Zx?=
 =?utf-8?B?VTVuN01pYUJlbnJzbHp6YkxUZ0VZU2VuZXBrKzdFN3Bvd1JKNDlRVkRRRDk0?=
 =?utf-8?B?V1JOYW9iU2I5SDA2dnhBNGU0U0hEamU1UC9HcXhpMzNIMGxNTEUvM0d2M1Bk?=
 =?utf-8?B?U21NRk5BS2N5RE5XZDJUQXlmSmFuUHhFL05mSGREZVBIVEhzM0hoWEl6SVNx?=
 =?utf-8?B?a3JHVGMrcGVHQ1g5cWovWGxlVlNSR0xPS0dWeW5qQUlWTERKOU94b3I5Yjly?=
 =?utf-8?B?Ym1oZ093NnJ2cGtJNHJzMlQxdUp2MnM4R1dvL2ZubUpNWUVwNU9KV1NwYjBv?=
 =?utf-8?B?N1B0K0UzenE2dGg3RW1PZzI3R3N1YlVKcW1sbnlNWDV4OUxGcCtLUUZaalVR?=
 =?utf-8?B?VDJtb0kxNUdWME9aLzBTVFNmb3BDbVdHRVFhWjkrMExEdG5MSmNQTlE0Y2xx?=
 =?utf-8?B?ODRnVTJabFBlRXlnbXd3RFpDQW5mV0xFcTlyWnRTOVppZWgyQ3BFMWVxZ0lR?=
 =?utf-8?B?S3MreWxtc0ZmSCs4V0krdEEzQlV0Q2dabUl4WVo4YWtnQ3g1RmFVb3dacVc2?=
 =?utf-8?B?TkNIZUxldmpDeDczQUdhVzdtYXJPU0pqSTNkMmVxV3h2OVdKZXdFVEkrbkc3?=
 =?utf-8?B?eWxJdkRuWlRaUmFSZm5zRmRScG1lR2VZMW8veXY5SElGMDNtNjYvYnh4bWNB?=
 =?utf-8?B?ellIL2V6WTc3MUtKVDI1RE84eUt4akNIV1ErVEk5TTY0MDlqaVFNamsraWRz?=
 =?utf-8?B?SVA5SFJnQ2FFRU00NmpBQUlVUHFrdjl1ZWY0aXlaMlcvYmhXajlsRXE2SlVJ?=
 =?utf-8?B?QmJDb2w5RklvWC85QUdvYkR0MkowWjc0M1NQQmd6c0pPbVFLdHlHZStNR1hP?=
 =?utf-8?B?LzRGWU1MeS94cTIrZWQxc3FVamtkOTZGZWFPTjhVOFpMNUwybHYvUS93Y050?=
 =?utf-8?B?K1QzTTRBM2FhOStQb1g1YnVpTXFVOU5YQXkwNmJQWEJkMlQxTkRiSzMvV0t5?=
 =?utf-8?B?OWJjbGJ5ZjlyS29VMitpQWNodFE1QU15UmUxVW12YVRvSlNCNENrYlJNYlNj?=
 =?utf-8?B?S2M5N2tSRHpvM1NUdTRzNlVWR3NXL1QvQ0RmUk5Wa1pmTVdiM1ZQaGp1S2Fj?=
 =?utf-8?B?L1p6OXE1VlA0RlpoRG10QUVYQlFTeXpjNXNpbU9pZ3hacHo5K0R4UUI2M0FC?=
 =?utf-8?B?L0g4ME82dzd6bStBM0JmWlNxYStLcGU5bURKdGhiemNIL1pvU0E4dEhXRkRW?=
 =?utf-8?B?QWhZd21SN2ozdGFXQXg5MDZjSFBhZjQvMnNWK2M1d1FvN0J0aVhySlZFQWs0?=
 =?utf-8?B?ZHptTCtEOXBkYVVZMkFudDI1ODV5azB6QS91YlY5dDNGYzF0TjVDdDZUWUpL?=
 =?utf-8?B?N2tLRTF4NHhuMEMvUERySmpOaDBLYU04ZUNhaTkreDZlTVNJeWpjMmM5NWVt?=
 =?utf-8?B?TVY5SnprTDFTeVdyK0MwK1dQYkJFWjZuRTJlZFRPTm4xSzFORXhjcVU1dFVj?=
 =?utf-8?B?OTc1ZGI2WUluNW9ERGtoYW1ZcWRaaWM5WU1OLzRnK1h1Z3NFN1Z3N0pJdDZj?=
 =?utf-8?B?YVFLNmQwcy9qblY5Z0lUZEozdW9xVzF3ZTJTN3Z4UGpNczhEc3hpQ29od2pR?=
 =?utf-8?B?ZUZkMzEwRFdDbk9QbWJkaXdTQUd5RW9pTVpTV2s2Z0E1ci9FOTdCTnZpTlFq?=
 =?utf-8?B?VG1aM2hTdDlkUWx3T3FTT2tGMFNpRG4vS3lCMzhWVVZhWGU1WGRGQlJJUEo0?=
 =?utf-8?B?a0RhVmNBU2Q5SlpIZHlLQnNpVUYydm1aUVdpR1I2ZzVweUVVcEQrZjN5dTVw?=
 =?utf-8?B?T2psd0MzZnRpWFVPUi8xZGVHMjcvYyttZGh1Q2JJNHdZTzVEVjdLc29QNWZ5?=
 =?utf-8?B?SUJTNVc1Y0tqTUF0NVQwZFozblQ3dlNNZFBsazgzRENlUmIwM0V4bmJEZ0ZF?=
 =?utf-8?B?cUZkbTZKbHFLQk9jSCtCOUFISkY2cmZwNWVNeW9hZmsvNlp6TEtzVGZLeEtG?=
 =?utf-8?B?b0ZFSUcyVGtxY1BRVnBzclU1T25pTG8wQmhDdVVCY0wrNm1sV3U5bDFSMnRj?=
 =?utf-8?B?SHk3dGdRb0VFUUUwM0Zqa1NvVFZCS3RPZUlMd0F0VERHTWFPY0ZDT1F5T3Bl?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f664eec-444f-4921-ed23-08dbea7bddfc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 10:23:13.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayt1A7GyUhZm2N+VvhVFjpP99YiDHpGRdJU0IO3JVs8xkFKohsSPti+OsQ5W5+j5wQP5nPGhArB3xI3Dq0tv+xElSdq+9ITaVB4ZZSYRfMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6404
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
> ---

If someone gave you you his tag, please add it to the next version.

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574B7EDF06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjKPK6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbjKPK6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:58:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6803D49;
        Thu, 16 Nov 2023 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700132312; x=1731668312;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rZMS/NNy7lHqYOxxF/59vM87XSamtgmvpuc2A47fyaM=;
  b=KCfZD1SCguNh4IFDL4IK7gDisP+Crcuj2hFD/EB8F8NJCw4KoJ/IR/Mr
   29VHj5Hsf3BLeMhu7w6vSjegExsep4aOD+QOFcEb6FHL4RRL+5MOWtyo2
   hv1rUi2fSiH41lJtKYNHwLUTAXTxjOAdRp1V+dgQGuBnGuFeRGJruZQmw
   fWkO2OSDmAIT+ZXhaCDoPSph91szDrCX9TfqG7Ih08C43RkZbnBKFPvqq
   tZMS5WxcgldkRicnHxjAO/Nx7+ZI94jhjg8QEpbjz69n9HA85YFbeKZAX
   62lZS3+FMiXmKOFttt41zZfdDRgr7ZdPU//qduIaDx4imb9gw9qJjQrCg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388231654"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="388231654"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 02:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768872126"
X-IronPort-AV: E=Sophos;i="6.03,308,1694761200"; 
   d="scan'208";a="768872126"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 02:58:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 02:58:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 02:58:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 02:58:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abnWJigwUZBSEKAtgihB3zXCJPw8paPFVVFMfvpNmHLw/yVGD6zgnfUMgbhLkQ8Go6LLzbPcl/cmOqs6dpVOCKwKzaQhQTKw1Vq9SE15+mEchenpRE6mug/rYCGi3+vyAAdQz/3kfM4sAX3aa7LqkPyZB2/8xiMSTj6njy74+HdTXueCMSr7yrASbdnK6EN56fnk2eEQypZJRN3APrqbt/3pquzmELTt1z2TbqxyoMP5Np7e7MdZBhaiew7tTv28RjehZKe3l7UsxopzEolLzHpaJkyRxk3bFlzpY4A0JasuhM1v2VrZl2W2/fKvHxptgueo/Ht9GJe73zzz+D4adQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOMHZEY6an8aAiWQMollydnkWV1eh6VMNyXlwK8nl/M=;
 b=QnaSreLvyOIE4XuCKPM73VrW7+6kQTGOUN3VRExD0jT9UpjXs68ttJ+8hReYwAArooNvgmbQLe9sUwPv2HgD4W1gZ6ZAon7BqUVWGYzqm9qao7EHN1SIzjcpebXetxntrE6Mu9Ku8O+BB1fx9SXIh/0kz/xdhnGV0uLH4C1BghaN0jIUm068OLLgGdIlNX1MNZp3BlwpmuCYtmSDr4Tm4b7IQtirXRzJKPhVKaXs4EsVmjC2vpXXUXiDO7rPB5Q63uimYuEacesMrAvM5jrmZDznKKcPLLXvGUspd9M9zUHjeH1zPJs2Wg6/m3yh5oSaATx7K+ovhHgOgeqBWRUxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7578.namprd11.prod.outlook.com (2603:10b6:8:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 10:58:29 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 10:58:29 +0000
Message-ID: <4767b8d1-a613-43ff-b511-b47e98e89f56@intel.com>
Date:   Thu, 16 Nov 2023 11:58:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 2/2] octeontx2-pf: TC flower offload support for
 mirror
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
References: <20231116101601.3188711-1-sumang@marvell.com>
 <20231116101601.3188711-3-sumang@marvell.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231116101601.3188711-3-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: d724eb05-424b-4a29-f66d-08dbe692f73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQmDQdGvafcQjGVq19wkxLAUipx7lSCb1Ea9PISg6nbobLb8ZP8On1zDJgXWwVqoHIYhf7bap37emjTQLNSLUCdgUZZifjnMRcjis0nOgfY19QKj9BxIx0DvCN7HVMzDGiD+wDgkH2y3jT1dSVFHEBejjT2YYnOHb3j7I1znVN0Ne9NZtyAYnoLmo+qwWPXKDn9DmPohlRiTjg0AW6h1q5rlF5oehxawe5ByNJEytu67S9yJd2TNm8MgV30KQTR+C7+xQ4qGSA3UnXF5pLCbIka69+nVEVIoVIi+aFGWmXDp4IJWJXX+DwMF/yFAwOVJF4KLtwMoh3E/PFuLfBdip4Sp5lNq8B3tABsExgOVnQ8jsfHfOrdzxYjz9RASExzxMoxlAMLoy2MWydlia09LZETaidIULQYZA9VFQYrnqvrZYedBqQZbUv9vaD6CaWCqk+uYC6geovFw/WMqq8W58EZEqS6GN4JhmoCNNt3tnkm3AMSbbp2uBL1ol83D5GY6Ls9trex74qsG8jQq0/AnuEMVE+gystXp7r1gNEbQlYHVfiRNjj2PhTCeoGpr51PEb/ssF77R0CB6mBul4sFjEoDLfQPWzi9NnYi5YGGTND5Sflsc6GKh9SXr8kWQwNrDhd0eQ4iJdV/4Gl81nr2qF0gbk7krDA0LCCg01E2002Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66476007)(44832011)(921008)(31686004)(5660300002)(2616005)(6512007)(26005)(7416002)(8676002)(41300700001)(66556008)(66946007)(2906002)(36756003)(83380400001)(316002)(8936002)(53546011)(6506007)(478600001)(31696002)(6486002)(82960400001)(86362001)(6666004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWpSSXlocDN5VFFJcUxiQklJV1lMdkRRc2hZYnB2UGtESkY1UDVRTUYraDVz?=
 =?utf-8?B?RDdMZXo4SlJ6cUNDMjJWdEo3aTZpTTduOFV6SEd5NVV4aHhCbjh6bG1ZRUlo?=
 =?utf-8?B?NDExSFh4bGZlZWFhZXBJN1greHgxRDlRQ2hFK1NiVkFKanhzbGI1Y2dYamow?=
 =?utf-8?B?bG1MdE9LQys1VTM0RG1iYmpUbTE4dFN4bVNpRHJ3ZlB2U3dONmYxVWpnTXBQ?=
 =?utf-8?B?Y3FsTjZ6bUVuRHB1c0lBaXZqSTNOa2I1ZzNLZGVkUzloQTEyMGI0VGp3Nno4?=
 =?utf-8?B?M3prazdMNjNCcDZhcjc0dG1jeG50N0ttMzI5N1orVFNKTndlOWdyb1NTZzhE?=
 =?utf-8?B?S2ZsalZjZXFEbnAxd1VNR1lENW1naXBaQnpVRzlFSnJWN1lBZU0zMEs3Tmd3?=
 =?utf-8?B?bzdHVlZDR25Dd01yNmJDa1lCc3dOU0o3b0RTbkE1RWl6V1hCeU50VDNiMmdn?=
 =?utf-8?B?Zks4eU04NVR1dkc1RFJOd2VNSkVYUlhQZThkL3BXa1A5WnlwVGRKdWhkVk8w?=
 =?utf-8?B?VU9sazAwemQwdU8za01LZEE3UTJjdG9aVytYVldpTGZ1TnNLY2hNYkRuSlg5?=
 =?utf-8?B?cm1GMTh5TkxVUnBPYklGeVVXbTVpbWF0cm1IaWVyS2VzRlBmUTg3NVJ5b1or?=
 =?utf-8?B?TGhORWRCTzR6aVoyckREeW5ycTE0UVJWZUpEcUExeTA3VmpZOUQ3SkNkR3pD?=
 =?utf-8?B?OGFKbTRFa0t2V0phUytJNkl5RkRWdUdQUHJjYzg3N3lzdFkrczBLUnZ0clpy?=
 =?utf-8?B?OTFiN0MzakMwY095TFc0aFhBMEFVMjRwMHZNUFlJem1sZi9UUnF5bWo1MHl2?=
 =?utf-8?B?enZMaytrM3kwYWZDSTdwMTN5N3ZHS3doMk1hcnB5akhVVGowclNWVm9najNF?=
 =?utf-8?B?Ny9jNEIveCs0ejRnOVdGZ1FsdTh6dWt2QnYyTzFWdjhlTTRqK0lPS2ZqTU5i?=
 =?utf-8?B?WEtqdHA2MURwZlVRa3EwWER4a2I5RE1mNG9yQjArZDA1Wkd5Z003UW54ZVp5?=
 =?utf-8?B?RS9CUjJJTVMwWXY1Z3JEQ3hLOUt2cDdDUTh6V2VKeUxRL2pwRXNSMVgxdmYz?=
 =?utf-8?B?N2ZoWkR2dVBUVkhQeFYyaHN4Q3hvOERFcEpOV090NDZPZ2FRTDJuaC9ZRTVz?=
 =?utf-8?B?U2lqZEEwc0pIY0Q2dDhGbUFRckpOSEhBQm9McFZMOWFGRTFKd3d2enhwK1ph?=
 =?utf-8?B?QXpZazhpNWg5akNwdzJDL2VESWk4TmpyNERscjhrODUzd3RBWXNWNkt3TDRX?=
 =?utf-8?B?V25JVEhUS3ZYcXVlQ2hFWnVsKzJOSEpQQS9hTGE3bDl1Y0ZNNGhaVDcvcDdr?=
 =?utf-8?B?UU4wVGFhMWo2N0JuYmh0aXA4YUVERzcwQ2tadXRyUkZCQjVxYUlvWGcwWEt5?=
 =?utf-8?B?NnRzYkRlY2IwSURZNEN0a3FKajBSckVxTS9jMk5ndFNNQ0dhMS9tdDZ1RTZm?=
 =?utf-8?B?Y1R0YTZLMkx1WmVQMFR5SVlDQTRJY2xVMVhBTXFFRE1hVWxxTlVqUzJDV2Mv?=
 =?utf-8?B?WmJCU2JYZkZYdC82M3kyVkJlR1JqaSsyaFRrMUJMNFFTdVk3TnVTR3U1NFF3?=
 =?utf-8?B?aXR0TlI3cmpMNGQ2YStwT2NDQmloYThhaVY1MWcwMnhzQlp1czF3VkdITGgw?=
 =?utf-8?B?SWFFaG1oaU5nQUlCUDBHWnBVaEZlVTA4UTRRR0JjNmVSbkUxSFEyVnpVdGxs?=
 =?utf-8?B?ZTJNcElkTGwwQlphTVNqRDV5SUNhR3RUeElSZnB1UGV5Zi9yb3JnRGVTRERo?=
 =?utf-8?B?WUxhVUxad25pcUdiVmh1ZHpIandhV3pVOUpNeDJhdWwreXdaMXlBVXJLeVpq?=
 =?utf-8?B?UElCS3FEbTByNUsxSkxLZm5nUmJvTC9ja1NkMjNTZGxqcW4yVmJxR29aRE5I?=
 =?utf-8?B?QXRmVnc1OFJyQWNOSy9wR2xnVkJMZFRUdEJlWFVIby9YSnhjZnpqMkVPaU1J?=
 =?utf-8?B?RlJFRis3aE40UEQ5Z1lHWUY1cWZ6cjFHOG81TU9sWmRGRURhbi9SQW1HZ3or?=
 =?utf-8?B?Y2thdXNyL1QyZTZ4bHB1c3l1YTZpMmtPMG15REFlbkNiNVduTGdTdGEycnpy?=
 =?utf-8?B?TUFoclZ1T1VXNS82S1lVR2I5TisrMXVTWjdldTlqam9PeTFpdHBCWVpWMitG?=
 =?utf-8?B?eGhRMUNFZFpjYUF1d0JlN2VRcHNLWGpmL0V2d29QbWN4ODRmN09lY0ZXVVA4?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d724eb05-424b-4a29-f66d-08dbe692f73e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:58:29.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krd8QP4n+9mqCUnpWwc/gxM30I16b9S1awaLlRYkTf0yF1YfDdxy8Aj8YebG7joeP/ySDsAZDf2l4y/sPL17KE9iwoQyQPvriBWmIwoIhpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7578
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



On 16.11.2023 11:16, Suman Ghosh wrote:
> This patch extends TC flower offload support for mirroring ingress/egress
> traffic to a different PF/VF. Below is an example command,
> 
> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> skip_sw action mirred ingress mirror dev eth2'
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---

Only small nits,
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 110 +++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
> index 8a5e3987a482..cfcf935b1003 100644
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
> @@ -336,22 +339,95 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
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
> +		mutex_unlock(&nic->mbox.lock);

I would put mutex_unlock at the end and use goto but it's up to you.

> +		return -ENOMEM;
> +	}
> +
> +	creq->dir = NIX_MCAST_INGRESS;
> +	/* Send message to AF */
> +	rc = otx2_sync_mbox_msg(&nic->mbox);
> +	if (rc) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to create multicast group");
> +		mutex_unlock(&nic->mbox.lock);
> +		return rc;
> +	}
> +
> +	crsp = (struct nix_mcast_grp_create_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
> +			0,
> +			&creq->hdr);
> +	if (IS_ERR(crsp)) {
> +		mutex_unlock(&nic->mbox.lock);
> +		return PTR_ERR(crsp);
> +	}
> +
> +	grp_index = crsp->mcast_grp_idx;
> +	grp_update_req = otx2_mbox_alloc_msg_nix_mcast_grp_update(&nic->mbox);
> +	if (!grp_update_req) {
> +		NL_SET_ERR_MSG_MOD(extack, "Failed to update multicast group");
> +		mutex_unlock(&nic->mbox.lock);
> +		return -ENOMEM;
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
> +		mutex_unlock(&nic->mbox.lock);
> +		return rc;
> +	}
> +
> +	mutex_unlock(&nic->mbox.lock);
> +	req->op = NIX_RX_ACTIONOP_MCAST;
> +	req->index = grp_index;
> +	node->mcast_grp_idx = grp_index;
> +	return 0;
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
> +	int rc, i;
>  	u64 rate;
>  	int err;
> -	int i;
>  
>  	if (!flow_action_has_entries(flow_action)) {
>  		NL_SET_ERR_MSG_MOD(extack, "no tc actions specified");
> @@ -423,11 +499,30 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
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
> +		rc = otx2_tc_update_mcast(nic, req, extack, node,
> +					  &dummy_grp_update_req,
> +					  num_intf);
> +		if (rc)
> +			return rc;

I think we can use err here, no need for new variable

> +	}
> +
>  	if (nr_police > 1) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "rate limit police offload requires a single action");
> @@ -1033,6 +1128,7 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
>  			    struct flow_cls_offload *tc_flow_cmd)
>  {
>  	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
> +	struct nix_mcast_grp_destroy_req *grp_destroy_req;
>  	struct otx2_tc_flow *flow_node;
>  	int err;
>  
> @@ -1064,6 +1160,15 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
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
> @@ -1096,6 +1201,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
>  	spin_lock_init(&new_node->lock);
>  	new_node->cookie = tc_flow_cmd->cookie;
>  	new_node->prio = tc_flow_cmd->common.prio;
> +	new_node->mcast_grp_idx = MCAST_INVALID_GRP;
>  
>  	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
>  

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319267F5CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbjKWKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjKWKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:47:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055AD59;
        Thu, 23 Nov 2023 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736443; x=1732272443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SqKT/flEMhC5dfBu/UHe/lbmotaslxqVKwDQiZaVVyM=;
  b=HXKjU9h6sQjSI8XJla7QGsYJ3ury0XccH7mkXW0Gc3r/TDTFEeO6F/V4
   gmRSg4/Ir4gJ0rgMc8KgEsXMxssML9dxTFIhVFrPcVA0soaQo20W6LIH1
   YMSztGVWph7PWHRq+SPrKVFMiiv0hpXuAmkA0TpZfDUWBtmV6cWd9K0+c
   zT9oqevw/bawUbcJ2bMxsNqR+D1GO0ux2mNpRO4K/oyFurvW5OFIMC1IM
   DETanjfeMbooOWu1i0AdqWZMRSmchdILp4KHatC9PMS6rbeKmfIHF6bQn
   BJ+mWT6SoyBiru7Wxu1itp+QLDZ8BO0iL3XXCB2QQmTy6e9eayLzNbjJm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="391124483"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="391124483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890757697"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890757697"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:47:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:47:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:47:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:47:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBOE/1u4QCuklUfMDUO9CVkVl555M2ZMSVqlDZUvI6ZgjHHSHHIZeRodrxMcGtVCgozfe6CTeirW05gWeoKIx4b7lyWZQEySfseCFWk8cgCa+hsGCI7vFaOuMDOPz58SLsesmK9I8GpG0W8iJAVmQTGD1hT/x080ZpE7wvpuO4pemS4jID4Ipi5U9YEauKtusHTXu34TsBqXk3zFlyurE1QlHqw+CTvqVFBYuX1lon2s1zYa2ZfjROEVEnQLI5kvHx7loViXvowQSxF3j1QMyxiRTHp3XnDdDzD/nX9LRlRqJ5F5vIN48eCpt0+0u5sr9vwIXk6cQXMocXr6pvqgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XysSS9SPK54EYOIvGKOqP4qsWv7naSvf8LcOU9juZIo=;
 b=E+clZjPiQ9PndkzRV0ZbxbwsXc18dBM8JaR9k0Ru5CCBYs4aHLK+fxClB9hHnMhbV02BPJlbOgKp7BihI6T0EsEQsHUuuhneuZjYTk+X2DocpxFqeFdL5jMIal3Ev/bIMXjaTj8mRRsHS3Y8cEvLNKLtT0+I+BeMXOj1WElglAGXuRiDgnWpP8hKHfYSlbmQXmX6NiMTUk6TAUjUbwBPEqB30x/6isI6vUhF495nGsL2jwxizlgXiSHEpnqZMHymOgLJohK/hAVnejhCkOPVMdihKfLhnnWniCXwFLnk6rmd86uGYJLqLz4ZHwGuIo7UvSiSvzTG0zdRprqgiXhvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:47:07 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:47:07 +0000
Message-ID: <ff97d821-be9f-4625-815a-d9a9d65d68f9@intel.com>
Date:   Thu, 23 Nov 2023 11:47:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 2/5] octeontx2-af: Fix mcs sa cam entries size
Content-Language: en-US
To:     Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-3-gakula@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123055941.19430-3-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e784e8-c1c1-473e-20df-08dbec1189ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD8NwBLjTUmXxRZHcqJaLBsyVCx4RIPxEMGhkORECzdPuJyKqiehrudVfEh134TP61UrtCb4Ywsm6K5pKzPRPpdttDJ0SHBFFLIp9lhhxjnlQA6+27gRs2/0Ul/Jm/7LF6v1wl0I1jtx979L2i8rs9GCDAHjKPTpEAZHKJ8m1SOO7uJ3aKnmUV9sufysQTHAZ8wNvew8NdjQGpj1vO4s0342oL2rnKlcwOa7P4utfPXbFqcXATFH1dnNtsvXaTjiUQYY973Q6DLDPXtwdUFyxIA2A90B3FZ0DwaoE5RaPZ3vHE6dN+TsK8Mht4xAiQ18fLdyXtbbD4ix323SalTaGc9gnOd00xibC+8SaLAr4+NMYYH1IG4989DcTjUQROmpykoTmPvj4y1x+1rq03nmy5o5vv9KpBUIhuEitmWOzpEtkxCYHtrc2k2mh8DURPtUoiCnPNtpkm+xa9krSnszncJ0vHQE+Pz4euy2Arbo412Bc259flB7TpeI8Z03Nt7nEwIgXL7UiKQqD27qP8JwSI+aRhtLIyqsdCvCeg/aApMSm29TQuPGwEqpKL1gzqbpehkP9647qxKNeF6Uzliy0XhueIvmztrCqbMBlrB6Bw5Z91gP2G7wwp1WgXxWoNhuayQ7tqY7+hLG7q5RRSOjXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(83380400001)(53546011)(6506007)(2616005)(6512007)(44832011)(5660300002)(41300700001)(6486002)(2906002)(478600001)(7416002)(4326008)(316002)(8936002)(8676002)(66476007)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhpMWQ5NFdOODhRTXQ5cUhJUmM0WFkwd2hSYUVzUWR0aFZubmRLRUFucTdE?=
 =?utf-8?B?azdwRkpUQVFTdm9CaHh1Nkd4VHRUdFQzb1pVUjc2MGMzMUl4ZnlZOEpraFhv?=
 =?utf-8?B?R3hsSVlRNUtGTEFoamxCTWt5eEdzdVZVbWFSdkRPdzFYQ1ZJbGlva2N6bDBl?=
 =?utf-8?B?dlA3ZDc4S0xLT1ZGSkg3RlBOc2NVTXQwNG1kMi9vMnk5ZmNEd1FXYi9INk1W?=
 =?utf-8?B?ckJ3dVJwd1ExOHJRY1hjd2I2NTNmekhMWGY2Mm5xT3FHOWZXaTZ2YlJWdThS?=
 =?utf-8?B?elpBVFZEZkd4Q01NUTl1WFlEdERzdGg0Q1AxTHVyU1BEWWZyaEZ5a0crbFFy?=
 =?utf-8?B?Y2hUQnBUK253eTVOWGloamNvbmdnam9lc2oyRXd3aTdKa1VwOTlZQjNldmJE?=
 =?utf-8?B?SytSSitrVXFOL1ZITUpGbFlNREdaaFI2eUhRVTAwdkJZSXgrVU4xR3hJVlM1?=
 =?utf-8?B?SnhOYkJIWEUremFPa08wZk15ci9KT1ZGc3I5MjgrZk1Oa2VEOGF5WDNLaWlQ?=
 =?utf-8?B?S3JSSHN6eG1OSFpWQnkyaEUvWXFTbUkrNnhDd293SS93Y1FubTl2Z243cXBO?=
 =?utf-8?B?akJkazdMRlZlNnRvM0dGTTFrRU9YWWRYZkdxWHBUUHAwak5kU2NXTlZkR04y?=
 =?utf-8?B?SzJSMllzZ3o0UVRXTTQyVnNNTkdVUXVNYVJJVlFoSkZSNGR3alkwM2FKNis5?=
 =?utf-8?B?b081RmcrdWovS2FkeUdrUjE1L0Z4S25QYkx2eUtTdy9WNndxc0RLRS9VRHdL?=
 =?utf-8?B?YUJIVHpMWDdKaXE2UVpMZmQxdHloaG9wR0FOZVR5eW9KMlIzWVpqZTJpN0Rv?=
 =?utf-8?B?MEswZU1YNitEVFI0a3c3MGdkUG9nOFpjMS9lZXNodWVQU1NLNGd1QXhWNkxC?=
 =?utf-8?B?NUZHOGE4NUFTT1BLMHNKTVFaWkNCQmxFcFVqa0RraUE3cEpFV3l4emNNVzNo?=
 =?utf-8?B?VDQ2VTdBNTlDa1J0bzU2c2ttc055Mjh1cDM4Tk9aNk45dW5xNWFwR2pDTy80?=
 =?utf-8?B?R1ZDL2RyY294NEtjRHZ6ZnJMa0tSM1l6a1hMM0taVkFFZkhmQ3RQd3ZKTUl1?=
 =?utf-8?B?eXhQRzJSa1lSMVo2YkxBaTg3Qm5LODY2anNIVmhmMGxPTlhPWDVRSXplU3Qv?=
 =?utf-8?B?ZXdndmQxMVlscTBhNkUzZXFyL0lmYWE2OEpqVG1EWTV0dVljbklOTksvWExS?=
 =?utf-8?B?TUNWamM5NnJGYjdyNFBDRGh6bjB2SjAwY2VFWjJYcG1Kck9JK3B2NnhaUjRl?=
 =?utf-8?B?anAzZGlIWDNnbVlUcFFURE9nQW5nL0ZrU24wc1VUWVVYOEh0N2YzR1NKVkxi?=
 =?utf-8?B?OE85M1RaVnlZU0tibFZUV0pyVWZBaTJGOW1Qa25JOXN1OXYrVWRzVzZJdlJS?=
 =?utf-8?B?UFBmVExTNHpxSVhIV1pTNTlDTEpzY2d4TmFmR2VqN2xqMUFwMXN5N1V1a0xT?=
 =?utf-8?B?ZTczOUozU3IzZGF6UE9RcFV5NTFUOHVrSVNsYVVhaW9PblViMXF3Z24zTU9o?=
 =?utf-8?B?elFhalhtRVRMNFVXakgyZWFXZUk0Z2J4OWEzcXVEUFI3cE9KeFpuRU1YVTZO?=
 =?utf-8?B?Y1hrdWZGNURRYnVKdUZSNmFHK2pDOUhQdWdkRVY0SXZrT3hPVmNWTjMxanE2?=
 =?utf-8?B?Zmx0RkpUdXZMeEFuRE1Lc1B3STN4M3drSmRtNGxQbVorV2RFdHozWTJqODNO?=
 =?utf-8?B?dDRjdTJHV2paM0FMY0tEVXJYTXM1V3F3NzBEV1NIZE1WVmgzek84ZWt0WmNN?=
 =?utf-8?B?YXQ4RnEwUWxHMFRXQXVwNzFyQkhtQW02TzM5ZzdMTDVUeUVrM1RpTDRWOElx?=
 =?utf-8?B?b1VvRndlRGpqN3JSZkprQWFpV1owS25CUk50Vm1aT1p3dWd1MXJRU05hNFpG?=
 =?utf-8?B?NXk2MTBKT01aT0dJWWdEUUN6bUpDY3NZV2NCTWxQSkZpMUE5NU1QRXozZDg1?=
 =?utf-8?B?MmFXaDl0TWk3ZkE1RkZXVmhLMkpkek5kaU5KUmc0alphYWFaSFNKWHVBd0cz?=
 =?utf-8?B?a0IxdTYrK2x0azAzRVdWb0NMdzZXc3FvY2RqK00vU0syL2l1VWJLeHJ5WGlM?=
 =?utf-8?B?NFFhZUhXdTFwclp1NS82QnBMeHVmK1cxRDdPQjVpZ2cycDhWbUhKY1NINmNQ?=
 =?utf-8?B?eHB6MXhZc09SQVl4ZE0zYVREenhZdjRVZEU2TjFvbHdpcGFOMWNzNUFSY1JE?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e784e8-c1c1-473e-20df-08dbec1189ef
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:47:07.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EtgRg2fkYTXl9jEQZwrpoovfj6yp1K5UkpNXVEhArN0vnUSD+odXoB664aTBdVBjhWMchyTeHKeHD7ss5bGdMh9z7CxdlNYbGoTVF/EZC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 06:59, Geetha sowjanya wrote:
> On latest silicon versions SA cam entries increased to 256.
> This patch fixes the datatype of sa_entries in mcs_hw_info
> struct to u16 to hold 256 entries.
> 
> Fixes: 080bbd19c9dd ("octeontx2-af: cn10k: mcs: Add mailboxes for port related operations")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/marvell/octeontx2/af/mbox.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 6845556581c3..5df42634ceb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -1945,7 +1945,7 @@ struct mcs_hw_info {
>  	u8 tcam_entries;	/* RX/TX Tcam entries per mcs block */
>  	u8 secy_entries;	/* RX/TX SECY entries per mcs block */
>  	u8 sc_entries;		/* RX/TX SC CAM entries per mcs block */
> -	u8 sa_entries;		/* PN table entries = SA entries */
> +	u16 sa_entries;		/* PN table entries = SA entries */
>  	u64 rsvd[16];
>  };
>  

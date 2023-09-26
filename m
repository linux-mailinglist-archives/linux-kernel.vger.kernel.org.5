Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459807AF34A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjIZSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjIZSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:50:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E9E192;
        Tue, 26 Sep 2023 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695754233; x=1727290233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NN7I/82AZ9PPsNQBf06ZHEYOuXdehtY+s15Yp35mQOI=;
  b=hT6T/XoeTf0YD3r79wvTIKirv+Hcse1x/jcgl8Gg57DCGV3ePM+iQCxC
   Sk6tAVaVypb3nBGtO5mexMU0VSua25TRzghRRK1bhorozQB6AMJoU/rdZ
   nRVMWBGmk08P6GJhhXCwzxXXUddPts7jZ3mcBLm9OgtLc5QwaoMKX5Wzl
   9UIXJd08NKKZYxmHuyFWWRalutGkVRPCRmVb1OyyMy65VeCqyHWBCoGvQ
   Zez97kaz383U5qGk9d70KWqpPFUg1BsT+GxDsZ4S7XfljMdu4121rCbD2
   yzPGLFrTIDJUPJQs5YA3hHoxs+dSu2EkLf1QvCsDEfLW8V2sU9pk6aoee
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381542384"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381542384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 11:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="253591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 11:50:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 11:50:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 11:50:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 11:50:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1qjEpn8zehtmK8e8cK3sgfbwSyn2tgXk/Jvch3eSsx+xg491AtnZ/XArsQby8vUyAb73AtVjjMPiQi09G1YpYoIaEiGKrNBZOJrRwo82T+xIpBYRVaGCqQv3NmlSnHF0S5AXY+ne7sLJ5iPhdA0ak5P/C3D9Pg10UlzGuWoOtQT6fh4mqqax/iaQcrwQaDvHSqCVCeQIK7cwvjcTr6xUW9BczNENmnieFzXqgZ8t5dfLl2QPB70NVt/EhsQske25jnFKke6GFQMNYxKoh645s1XXJ3AZl2uaNtaCzAzh5ThTCnlKRgjP5WN9qJucnswoOYel0qBljpCAS2tzX07MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1I0e91fY21lC9AVg7qv3IrDG65e6sA3z0pb1mL2i3s=;
 b=bDhXVaDMHC1TP39XZyU9VU0ibQKrdb2DcAF3WBlkfzqhCQeFu23zreSHhUGrJYcjpWLdC4nIBkb4cbHrQ1+tDhi5yJyC682CRRWj0N8hZYUrN+hzkfdHeTNdMgF/KT7m2sRgBpvWd43o6sOofgjNIKSTPoUPHF68aE+GniHlH2K9exVgU7/QF1Aq8R8Xirt0yGTirIzjFzm/CXOMk3SkpZkg6bycocL9II1HtS5whEsAmxdE41XIJO+/Wqga2kluknt65aTIBnsgWksd8urqcoj3RjvdchwDZ6oRMsdHhTumkSihCNA8oCnd/sUXQ/ORL++UOM4Xq0dREG5L2Iwhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 18:50:29 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 18:50:29 +0000
Message-ID: <ceebb128-91c4-33ea-5f2c-495bee270445@intel.com>
Date:   Tue, 26 Sep 2023 11:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v1 2/2] ACPI: NFIT: Use modern scope based rollback
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-3-michal.wilczynski@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230926184520.2239723-3-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: c03af9fe-0b6a-4cb3-ca32-08dbbec17460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCxjdxkDNV5BKZvzGrNx1JgYJsJj9/kGlOuAZ4uRTSSDSj46N/sUJPjoUIoNlS86igcfX4+8hd4PXvLSJTJQN3rwv4Ia7U6FC1ij8njDCPPl9WDfroStPKBZ4Gnk8QMK/+B0/NyoM/wrbS+rCL7MQkghYOoC1wubbbmrxweRMc7rE1qmq88a0bEC6NP4bjZxqn8Ltjj2ty5ifvWPKrkrDaui8J/+crLyzJjUlQ0E2gGLP0fwbp6CrAHrfTIhh5AkPa+IyuSzOblpaYgDv2s6G3XiCtdaCv1XU0xTZeDpO16D3GiryjQwP2ZhI/OmmH1yCcxSJfuSncoYPASQZ8e4/E0DnII3xMjxmdDXOFuy1xgrrpbf1RaDNPgm0uOYQzNrPPvbQMKpz06DuaLXz2PhDGLFQKraDRRzniheID2lhmGRg9gs4lOLZRc8YNRQ3f3z1kBpmF9X9PROgFa4G0efg5Uf1n0cwpT6ZZ3UkDADKxc7BFmSE3QTnSzM5QoEUFG+ps/rvlaHH2gCkJH48w3mPQorn6qrVyaV7GNg6a6cqL+zahsvxOG4STOoca/r5FSLlXDHAAiDBiCmSYN3gJPp43oMprc0jJ1la48bO6dup4JxEYj03G581r6IUmOzE50NjRN/FV4KYLlBbdK9IaoS2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(2906002)(86362001)(6486002)(36756003)(26005)(6666004)(83380400001)(38100700002)(82960400001)(2616005)(6512007)(6506007)(31696002)(53546011)(8936002)(41300700001)(8676002)(4326008)(316002)(44832011)(5660300002)(66946007)(31686004)(478600001)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZrTzhTR3BwUDhwQ21pVTNHUTVZUmJuMUxXR2VUaGhDckJITVVhMklEYVpm?=
 =?utf-8?B?UHdYM25sZy9qNTVqVWlKZ1VEQVlnd3RMa3ZHWFgzaGJ3N25kaUN2MjdhWndO?=
 =?utf-8?B?Zk54Vi8vdWI2TjV4SVRyV0k0YnVhcXNNOFA5dTh5Qkg2clliKzdESStHaCtB?=
 =?utf-8?B?Wi82b1I2cStqRWdOL1JsdXEzd1JPNlQ4K1VMLzB0YWs2dnhQQkZMMUVwVWhJ?=
 =?utf-8?B?TFFZc200YitVOUZxcnJobUt2OE03S3VydlRmMzhaNXd4RnJCc3VQQ0cxWmN5?=
 =?utf-8?B?YVR6cmszWlg5dTNCelNvUHJLZEdOZk5KSXR6d2kxTGZwUEFWVnFOL1c3NUwx?=
 =?utf-8?B?dG1SOUk3ZG14YTFUd3VNUFlwMFIyOXlNTVgrVUEyWUhEQWx2c0JQK0NXZGhm?=
 =?utf-8?B?dnNubFQxenVCM1BOTXdyK05GUGtQbm9ZV29KOU4rQ0hZMlBDMFRWUjNJYmRm?=
 =?utf-8?B?Sm9PR3BZVndQRjNoT2E5elA0Sk5zSDBKd2p0NGNYUHBTUlRKTjRKWkl2WEM1?=
 =?utf-8?B?Q1NrR0ltYmxUNEp4Vmg5cWZPaHBOWXBGRU9NcFdsRllFZVdDNzdob2RobVc5?=
 =?utf-8?B?cCs3bVUxb3ZnWWNTZnpEa3hDWVIwRU5zTDUyUjgreFppMDFhRTlMcEQ3T3lU?=
 =?utf-8?B?WXphZEk4eGswUGJjVXh4cVdaTFdsQ3h3NjBQUE9qaHU2YWxCY2tvZjJVNUxH?=
 =?utf-8?B?Rm95TGk3L1B1THhkZDIvOE5IRTZrV3A1cUE5T0loYzQ5SUV6Y0VtWDNSL21w?=
 =?utf-8?B?SGNTdTJXVXc1Zmt6L0plVERTVVhldDZVaWRTM2pyemlOdXJBeTRWTWtNTUE5?=
 =?utf-8?B?NTcvQThZdnBWT01KMGlWSkplZFp6WEhsWmI5RGtiMWgyWm9EMFlpNEowYnFn?=
 =?utf-8?B?b0tLS2FSSjdCSFRaNDJkRTEzOVZ6QWQ2S0k0RVMxWW1NMm15eWQ1VXY4OTlQ?=
 =?utf-8?B?MGhDWk1uL1BkRUd2V0V6Si9FeVRDNURJYzBwd2RmOWlrc2hsN21iVWVDZ3Zl?=
 =?utf-8?B?UXgvdlJyM2VPcmlWSVUrcHIrYURsRXdCdmRLeVlvdlZIOWN3dG1LOXNNdmtl?=
 =?utf-8?B?SnBlWDdGTkJWTEdZbnowaFY1cnFpbEdZd25Bb3FObUR0LzV4Y3VWeUVyWjM0?=
 =?utf-8?B?Y1NYbmpibEtOZzJmTkc3N1MwSzV4di9NN1hpbUQwQnVHMVppK2FneEp6WmJ0?=
 =?utf-8?B?Q2ZDMTg3dE9HTy9SWVo2eDdjZHhab09Ud0RSQkh3czl1alg0c0hjVlBzOUtw?=
 =?utf-8?B?c1BhaUF1YVAxUFhJd21CRGNJRlJ3WjNoNGZ3Q2p1dXlZZHJ6RVVkZ2tQdHZJ?=
 =?utf-8?B?OW4yRTl6K3BSWWQ1Z2JSQ2Vlbm05SzI4dnN6bkNraFh5eG8wMWNxUXhuSzBz?=
 =?utf-8?B?YllwRGt1VjBmaUhoNlNjbHFsR09NRFRmc3lFTzJwaUVEQ3c1RGsxaUpodHFH?=
 =?utf-8?B?dVJZY2xDNVQ4cDFLM1lUVnE0QVQzTTJtUExJQWU2NUFBcWJzNm8yUmI2L0dn?=
 =?utf-8?B?T09KT1FBQ3UwTUJaeVZaOEM0anY0ZXg1Z0l4QU14ZkFxRFR3RGM3ODZHdE9T?=
 =?utf-8?B?WGo2dWJtSlFzeWo5Ti9kQ01xWFBHRjVudlV3UCtNM0VKYWtvbHlTMVVEQmd4?=
 =?utf-8?B?V01UaW5qSU1IVkJ0Mm9YcmdpS0t1OUFrZUx3WWVGMXVwSEphMm1RZVB0dmY4?=
 =?utf-8?B?VWJiYURIU3BFWjlPZVdhUUhDZkIxOXhVcUJzSHRzNkdQWUJKQ2ZDbmJkK3NP?=
 =?utf-8?B?V1BpTlVBSlh0Um9UMHczVnFqeGhuZzlpcUh5ZDJuclhIZlJmK2Jwbmp0clJS?=
 =?utf-8?B?eHVIdEh1aTlRY00vNDRIcDIwTmRqZ2pGNEFFNXN3T2puQ25JWHNJN3pzVU5C?=
 =?utf-8?B?NzQwczRqRDRhWWZlSEJtZlFiMFFXY0dkMnNqVGRtT28xVzdhSHAyUW9oZ1Vz?=
 =?utf-8?B?YXppbzBDam1INU9ZYzcyb0tocFJoVmJMVGQwK2lRcW4zODRmUUl5T2FpTmZX?=
 =?utf-8?B?QjQ2cG9QaEFPK0xnU1FMaTZiR0NtM0l3dHRaWFM0QXk1eEVVOGgvM0psS3Uz?=
 =?utf-8?B?UHRzVkxLTUpYYzExTk1MV3paMWVkU2FGOXR1aFZsM3lzVlBzM1NHdEwra1BP?=
 =?utf-8?B?Mko2eGJiV0h3TlNQOWUyUXl6UmxibWV1MlRsTFYyazUxS29vUEk3bGJtNGJH?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c03af9fe-0b6a-4cb3-ca32-08dbbec17460
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 18:50:29.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yWhN0j8wBRnCJbgEyzwDSKHRicSqLcZmb/C10v+l6KMQ1MsTmzoQFUzb65FP6qG48ajWEsveQEfKIM7VtBrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 11:45, Michal Wilczynski wrote:
> Change rollback in acpi_nfit_init_interleave_set() to use modern scope
> based attribute __free(). This is similar to C++ RAII and is a preferred
> way for handling local memory allocations.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 32 ++++++++++----------------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 78f0f855c4de..079bd663495f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2257,29 +2257,23 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  		struct nd_region_desc *ndr_desc,
>  		struct acpi_nfit_system_address *spa)
>  {
> +	u16 nr = ndr_desc->num_mappings;
> +	struct nfit_set_info2 *info2 __free(kfree) =
> +		kcalloc(nr, sizeof(*info2), GFP_KERNEL);
> +	struct nfit_set_info *info __free(kfree) =
> +		kcalloc(nr, sizeof(*info), GFP_KERNEL);
>  	struct device *dev = acpi_desc->dev;
>  	struct nd_interleave_set *nd_set;
> -	u16 nr = ndr_desc->num_mappings;
> -	struct nfit_set_info2 *info2;
> -	struct nfit_set_info *info;
> -	int err = 0;
>  	int i;
>  
> +	if (!info || !info2)
> +		return -ENOMEM;
> +
>  	nd_set = devm_kzalloc(dev, sizeof(*nd_set), GFP_KERNEL);
>  	if (!nd_set)
>  		return -ENOMEM;
>  	import_guid(&nd_set->type_guid, spa->range_guid);
>  
> -	info = kcalloc(nr, sizeof(*info), GFP_KERNEL);
> -	if (!info)
> -		return -ENOMEM;
> -
> -	info2 = kcalloc(nr, sizeof(*info2), GFP_KERNEL);
> -	if (!info2) {
> -		err = -ENOMEM;
> -		goto free_info;
> -	}
> -
>  	for (i = 0; i < nr; i++) {
>  		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
>  		struct nvdimm *nvdimm = mapping->nvdimm;
> @@ -2292,8 +2286,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  
>  		if (!memdev || !nfit_mem->dcr) {
>  			dev_err(dev, "%s: failed to find DCR\n", __func__);
> -			err = -ENODEV;
> -			goto free_info2;
> +			return -ENODEV;
>  		}
>  
>  		map->region_offset = memdev->region_offset;
> @@ -2342,12 +2335,7 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
>  
>  	ndr_desc->nd_set = nd_set;
>  
> -free_info2:
> -	kfree(info2);
> -free_info:
> -	kfree(info);
> -
> -	return err;
> +	return 0;
>  }
>  
>  static int ars_get_cap(struct acpi_nfit_desc *acpi_desc,

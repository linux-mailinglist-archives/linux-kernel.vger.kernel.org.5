Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8757A7F1784
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjKTPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjKTPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:40:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262210E;
        Mon, 20 Nov 2023 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700494820; x=1732030820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SCDC/YDdgiD9ATTnbk6p822eBfkCUTTAy3E2dpnTnhY=;
  b=WZG6rmlWo5V4Lz+IRdMG6kWGfcTyR5wbl/Dt5N7+rvATh/ygxTbhI8DA
   Hn9WN/I7HBe1uJ8UUPSYFLceir/kiqhn00SJHz8LPOnjR4huAt8fp1vX/
   0+8c4p1IA1hGoZE79sC99+4lyAcydQKanTsaxZa5WNZxtFN9JO0O0SM3y
   EgRpuhy/twp3teU+gWkbsKaQ21V021er+FU1MnVbfFCg+jE6FvwR1IdSA
   Mznx2pllpxBjW6RtlZbad2OgSUDIlphezhbDyN6CV1KSIWAxgjrxvjFbr
   GWfM+23v9Rxghx8J4+QxyMqGMs8Xrs8lMA3y7fqbN+iEOFf/4u86OPrQv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4828820"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="4828820"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 07:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="14195315"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 07:40:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 07:40:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 07:40:19 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 07:40:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMa/2r/xHuZoAQIwhpStPDFHZD6+rQ2k63ya29yuDQRJrk7qQPV+j6dpDKo6XxYibCN+wZ/mJ38hlH+UPWg+m1Z/cbpcV6S4OR4vO4IJT3cCPGhdHE1CEP+o+fZCl4ZJiklWvRODTrWBlMoaI+/3MV/yT6EKkXvsWg51nkd2lKeVxnqVeBsaoqpkBnP4ygGCtg9o/k9qEiGckbXH+adz26ktPED9ucFK6482sC+WEHniJum0I0T5LMxpNYI9u7VoSP2XElRKzGWEgdRJcblPThX3giwQTRiVqbhlaZ4LWnIr10AMo6nEvspR/j7cQTu+h+VmnEBy61m56RWvSYDbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYDPZs71ynYexHnmhG3COX9cXOA4wdT6G2nZhxTKutc=;
 b=dOFqZswzQC1FISWrwLH6CY21sNR6+xuR5fts8bcQwRJIal2CJmSwOAcf7hhHKJ4qPKoeNIHGBisfXuSITc/5Ogpx+y5JZsFdd19tt5XEW52isbm7/J4IsB6/Sg5ieWJljkTHoxOA02gRc11TYHQ+JNjruqjs4G/VudMccImt+lB0Sb4zZKnB6SQHQx9gVSxaU798Aj5i3w1K31R0cFDOJ+oGykVC0/ArWBVzotMZsrKui8JLe2pjdHuYLr02Q8HK0M5Zlf3Q2DzLy29KPQVInYkHKl1pU/ADB0pvUfOblKwjMYjhUTeEpBLqXXVFqZhdTphpFzqRcs5iK7sDVp0Lhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 20 Nov
 2023 15:40:16 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 15:40:16 +0000
Message-ID: <b236e0d4-b8ab-49ca-99f3-364ea41cff49@intel.com>
Date:   Mon, 20 Nov 2023 08:40:13 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/2] cxl/cdat: Handle cdat table build errors
To:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
 <20231117-fix-cdat-cs-v1-1-ffc2b116ca6c@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v1-1-ffc2b116ca6c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 359bca11-9850-4f0d-5897-08dbe9defe75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r/MGGoH592Bgn6ekbmRUS11iNQrsFMxT8yoi9g3cl4RXt7w8zterXCE1LQXiH5cChyfpVOB5XSOdF8K91S0nntL9t11zmedbgKmfkKPQxTadPtKjZAS5yakj2XZwg+udt0Ry7vz2F7Tnuc+7P+noegmNtH5coMVMNafcdeNpLW9Uvl6SVd5/qtk0fVRzujNj7ZQcM9gNn/E/dAKDnqG00fgccCyPLM7ITUsasjpCT0VbSOVrAh0c84NpFb/cTTmU4qs8cka8XSrAhTTyMAnAMRaLcR9uqzXr5K+DEfEeZaZtxq1Ys4e/+SBf1HCgPsWG7NTtus3zctYhguMR6VS0yGwwGxTvRF8OzgucCfSvVLzDpLsibBZu1Dw/XHWTWEFGESkwbqVjf1AkylfzY5Rw/s5ma80FVPhPsh5lfwQ+9JIq7cn6ddKNnk2jMJQKZZOOhHjE5DhnguB+3TmKfl429VT4atlWxvLCPBnpjhqAI9cjtvZX2pJshVCo8OVkqLJacdFKrk98QhB5H66Ik9rKFzly2WGFDZd+hXdBl8fiVKtVx0ZCgzgqAmf69R3q3ciuO+TFOmGWVlBKoTpCCLG7jmIY/yy39w3E81iCUJ9mHFpxDU7kS/7Iseikm0dn6bc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2616005)(2906002)(6512007)(26005)(8676002)(478600001)(6486002)(31696002)(8936002)(36756003)(66556008)(86362001)(41300700001)(5660300002)(66946007)(316002)(44832011)(66476007)(110136005)(82960400001)(4326008)(6666004)(31686004)(53546011)(6506007)(38100700002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFXVHFzZFAraWFtMmZUSUdKeDYrWnR5TDRvVkdBMG5abTJ3NVd5MkJ0Rmt3?=
 =?utf-8?B?YjZKaDhOQjh5VldCNFZ3UFNUbS9sOUVaMG1CcXFoekVIcDYwNXZRR2N3S2h5?=
 =?utf-8?B?bzJwOER3Qjc5ZUpQRXVPZG1IaXgrMEN0MUJLOU5YOHhXa1c4c1lva3JRT2NM?=
 =?utf-8?B?WkIxTCtIc040OUwyWXA1NjJjTUtWdDVPUnFIS0gwZzRQcGVreXVsY3FRV1VG?=
 =?utf-8?B?SVlNSTZUUUV4R1pwKzRZY0lVMmdra2NxZklZSXA2K3oyNTB0WlBuaWkwYkQ5?=
 =?utf-8?B?aldvSERZVHc3dlRQWC95U2IxQy9DUnZkRXdtUXNzS0RHakdtOXAyQk1VMzhR?=
 =?utf-8?B?WGFuekVEeUgzQitDeUtsYllOMVRucDlSWTFvZG5vaWt1aXhXSkV5ZFZuRnA0?=
 =?utf-8?B?S2R2TjVvNEpyZ1RXd0tMN093T0pScjNZdFNEMXFkTWxSNkxGQUZGejgvVWlR?=
 =?utf-8?B?OUZLWUEyRHZJNlpFckQzbXpSWkRQSG1XaFNSM0pLWFAxRVhwVWdkUjMyVENN?=
 =?utf-8?B?WUxRdUdtQzNHc1Njc1ZMTW01TjdQcW9iYUlPNGFqTG56YVRzb2s1VGo0YnZx?=
 =?utf-8?B?dXhtSDQxdytJVVJnbFMzOTJFY0Q5dkJ3NlQrUCtmZmVkc3dFblhRZnBlSlN2?=
 =?utf-8?B?ZjNWR1hTeHNIdE55bThSaFNEZy8zTnBwZzg5VFpiVkJzN3F4L1JDRkdtTmI0?=
 =?utf-8?B?REZVQkR2aStYQXVQaHJtZzM5TXEvUXVTZDBVMWxlc1RiRzlPMWk0aUZsTThz?=
 =?utf-8?B?eHJMVUNLbUpmYy9MZm40QU9udjVZZkU4b1Q1ODhVanMzTTRFamlob2d5Y3dy?=
 =?utf-8?B?OUFEZ0w1ekNFcjBpTkk4SS9zd3Z5NG0wSnZURGszb2g5cCtvWUw2cUd6VnFD?=
 =?utf-8?B?My82RlAxM3R6SnN6NDdSQ2RKdlZidkVZYTFlWEFHR3p4WElVY20xRVY4NDhV?=
 =?utf-8?B?MUh1SmppclZlMk84T25PanRoVnF4WllYV21jUmJOUnNKVXkybnFOSWxVTk5j?=
 =?utf-8?B?aUhpcnVTZ2xjZXVYempPRFpVVFI4R1ZmMVJ2ai9oN29MNmVlbzFibDBsWCtM?=
 =?utf-8?B?SG84QlNLRm05RHlxUlBuU2xFd2sybjFRM0l1Y25zeHZ0Y0JvNFV0QTVXZ1Fl?=
 =?utf-8?B?K0Nra1IveitwT0pZalFRK2J3OFd4S0JQMkszVGtURzVJYjQ0dlZrUmtqUm44?=
 =?utf-8?B?QmtMTjFEN0ViZHVHWW0xNnk5UDdpSUxrYWIwUmtoTEMwNjRNRzdIVGxDWmhs?=
 =?utf-8?B?OHovRm14UHVnOVJFc3ppZmNuRUhJWHVubnJpa2hTNmU0RGxhcFJsbEJYT1JB?=
 =?utf-8?B?VXNkMG9nV1ZvelpTanBVN0N1T0pPUE9MY1k4QWdrOWY3VUluU0EvQ0NENWQ0?=
 =?utf-8?B?VTRHcWNYYVUyZEJ0OVh5NFhhTWYzeUppNlh3cUdDWG5YdS9ZbS93aEd5ZHVm?=
 =?utf-8?B?MlNhSXprYXVpbG1YQTc5K3cyc0ZPaGRQL2c5VjlHMVdKVDNkY2xrQjhHeFRk?=
 =?utf-8?B?b00ydW1mbFh6dGV5Q2EvVld6UUYzWkV6Nmp3ODdybzk4QkEyQmN6R1kxc0Z0?=
 =?utf-8?B?bWozMGl4cVQ1algwM3dGd2kwbHVUTUV4dWdXVERLOTlmMi9JY2l0TktQRkN2?=
 =?utf-8?B?dDNXMk40UHg1aWZDdGpzeWxTN2ZVSThRd01za2J1N1Z5b3orVVYyLysrNmVW?=
 =?utf-8?B?VjAvRDJCL3FuNzdGSWVXMktpci9EL0VxSDZJdDNidlc1QmlVTk5WemF0NThp?=
 =?utf-8?B?QXlPZ3BlVG1qbVBNRmJoT25VN0JzWTE4elFKWVdwL0x2Q3MzNlRNcmZySU9B?=
 =?utf-8?B?NjVRM2s5a2c3VmFFZ0VZQysrWFdjSks0U3N6Rk14MjhhVlBNSU5kZC9leTBj?=
 =?utf-8?B?cUlTNHNXa0UrTVdZeFBybFNzR2VLb1pvdUtDaW5FbHNpMU1DWlQyUnlmMDls?=
 =?utf-8?B?NUo1aW9mSlkyM0s5VzNwa01EN3dOemNNb2VodlU1a0JLdDVLVVFOSGZURjM3?=
 =?utf-8?B?dFpHdVZMZlRlRDFVZjNqbTRaTVpzMmM1SGljSzVCQXJtKy83MlRQMlBpbFpv?=
 =?utf-8?B?QUxSL1BjY0xGY2U0YXZWeEV5bm9DTlc1bEczZVBxQXRWdElpYWJ4QkIwTk9X?=
 =?utf-8?Q?5lPzRZtYuOpvgwnM5C9hhpxBW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 359bca11-9850-4f0d-5897-08dbe9defe75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:40:16.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Sje48FNTmSaPqYmxmKdmycoqUgWaqvwEDz4v6YZ0/1Fcw7OVcZJbU0wjnuWCDbnnMgDTi3o9fDjMvBkLdG4eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/23 18:14, Ira Weiny wrote:
> The callback for building CDAT tables may return negative error codes.
> This was previously unhandled and will result in potentially huge
> allocations later on in ct3_build_cdat()
> 
> Detect the negative error code and defer cdat building.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> This likely needs to have some more robust error handling in the event
> of errors.  But this at least prevents more errors down the line with
> invalid allocations.
> ---
>  hw/cxl/cxl-cdat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 639a2db3e17b..24829cf2428d 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
>                                                   cdat->private);
>  
> -    if (!cdat->built_buf_len) {
> +    if (cdat->built_buf_len <= 0) {
>          /* Build later as not all data available yet */
>          cdat->to_update = true;
>          return;
> 

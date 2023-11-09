Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C347E69EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjKILuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKILuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:50:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AB2D77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699530610; x=1731066610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gSDhZjyk5r1AjRtuf4zDI57bWiv6HpSEdqzLYyaIb+4=;
  b=ZQwkYTyH7zprOHP29r4OW3q3W3VI3J+RaMfS1zj2sr0L6NwmxWMCtGKd
   r8NgW95dXI2fw6lHdS0wRU0Me32OBjRzh/kMHlzZ7EM6mS9LfbXbxjlpp
   XGRUkFPjuoZaWtVqQ6C6+52Ld+59wKZHPfMDwMeMh5aItFXo6MKRSy891
   hM4qVaalaEupAzn+qpRwmaiWowdSs/+iaJB1XtEsZJChCnRIklbVFARRS
   tsBTNjE2We84Cxhbgx6T22jfQod25OLa2xrYzBX9OHPzvlnUZF4Ija0g9
   SksglkX+A3wShQ1lZgR15BbTINt3K54ds4QeBNiNW2xtbeR5niGR4NCoz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8619360"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8619360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:50:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="798302951"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="798302951"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 03:50:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 03:50:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 03:50:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 03:50:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+NqP5mpV/fDHHR9P8XE25lZkFO/WCx8XAzvA0B/jC4oKbE4cpWlCwzMgqFwzAOFyDtpRgF9fLtlYmOsurF28rZ5NXqqiSO1xIy1RDBjdlcfBFuERFIW+nViOSX1mnmJa6fFT3V5HsViHhz5WLXTv6KNEFJs7tDigZd/T5dt1+yiJlmWxNiwJI4bgS5IEEc3NxDpxM5gyOLa3gR6vBfJJj9zyeMIotDNoDM0SnisiZcjpYYuksOUdoOUuctdTP8LTpFw18gBe+JABsGPge2PVD//arCYpDdLeY3YXbKUvp7GN2YdNGuF30ojqmRwEm19mAXp1TxKo1zRYkICuA7IWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbFNe+oa+uCyQdau767q3Ftj0BViVF9WX8u8R/m8XZg=;
 b=iF0cNWQ9EG+sipgJSJObMrHWux72qpVTQOzmMpeSjhXk8aX/DB3C2fTuFeoacieNl4+hhpewNu3g2sIKCvwQrroNUzoUWdH78Arl33UEPAjL9i4kVYe+KR8AvxAg6IkRZGPdHA/tOtuZEtzX5wEpz1UYJPJly63kmK8mncCtbT1JwWdNa5sova1ktmZn11w0y+iCPcyCeoEwumvaJlFn1gdt/vDPP409WZA8DUCQETeT8cR90y0OsUDqJ/34X84BntptpVw6PbxQMZGiZL9VsXHtkkx9bO/XNYetu3QM1QeOU7FuN6V5A3HYXpDo1v5Wed2ix5J8Zrj8sT86z1X1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 11:50:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 11:50:01 +0000
Message-ID: <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com>
Date:   Thu, 9 Nov 2023 12:49:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Content-Language: en-US
To:     Alexander Potapenko <glider@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <pcc@google.com>,
        <andreyknvl@gmail.com>, <andriy.shevchenko@linux.intel.com>,
        <linux@rasmusvillemoes.dk>, <yury.norov@gmail.com>,
        <alexandru.elisei@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <eugenis@google.com>,
        <syednwaris@gmail.com>, <william.gray@linaro.org>
References: <20231030153210.139512-1-glider@google.com>
 <20231030153210.139512-2-glider@google.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231030153210.139512-2-glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0178.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::33) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 689a53b1-ad72-4a1d-2579-08dbe11a011b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAGzf8E/vAtRH4NKyZJmPh2shB9JSs/kfN0gv11wvW98ZjDTQ0m0rIFQ+XIVw5A9j9I8+dNcoGRnF74KZoXQipEIK/8my8lfkZmEQ8D0n20/U7WF2c0UTAHGWq02LnWwb6rOWPDGs+zyYTJTe9lsjHRLyWylQdpVsjcuYw8ciCFCNSUURVixWvcXTCu/cQAUy+WXnbbiOJ3bYqtSDPNpK/vI18tnDreKUolB5ri4UDcInLETmzC790WAUho1dCh9DP7bx79cpDzadmSoarTYecjUyyllZYhC6S/1bfi9sT1m7X9ZnoT+v45yfg7HcZJoSITq6Uf8QuxvucO/p91MaQLxg6YWd8/lJKKWGDnrCEQRp4WXmo70OUVgzLGgpIXrKoXQL5pYduG4/NQ0kMZJLjs1+XKRLG7exPL7v6iEle3OGRqfuCyYjyYJkG3Msu5Obh0qZ4CgRsF9FAQtnx/zwYmnBPar0IYU8TrnRGMIeRE11fK2MSZQiUVx236L/ByL8F8IePnDsJBE7R5adkcAODgn5ae3DRbtIwTVqSqYgshtUGV5pKRrkCU1SeO7AovNMbuGdCqL0+wwH5tIF61AY89e2ZZ8P45CD6itm3bz+1JuGOTBg6QZhBkAq62b5OFw34XrfV61m2FiTF1KYJiBKwRyFu7WHR/qkzgbpa5mra6LbLtGzz37ulCtlxL295h3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(2616005)(83380400001)(6666004)(6512007)(26005)(6506007)(478600001)(6486002)(31686004)(82960400001)(38100700002)(66476007)(8936002)(66556008)(8676002)(316002)(6916009)(66946007)(4326008)(7416002)(31696002)(5660300002)(86362001)(2906002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JZZ0t1SEtmTm9DSC9VTmkvckcyM0RGckwvMVhQTkNCRXdEb1VWWnIxUDV5?=
 =?utf-8?B?L1VjOWZXZWw2amJpVXJWdStuZHlmcVhFL3BscEh2V0ZkQlRIcEdtcjI2RWVJ?=
 =?utf-8?B?aWRydHl4bndwMTZiYk9hd0FCQm5NcVYyaTN6eFNDVTNhRXUyc3JrRHdEMU5t?=
 =?utf-8?B?cVhUQklWa3FSVWQvZFBlVDk0Mkd5RG00dFQweElQdDk5eStLT1BydWJTU2t4?=
 =?utf-8?B?dHhGU2pQUXRjK3NJRVJPdDN3ZzBIbDc5SUJZZG9FenBZR1VCSHAwaW5LVkVn?=
 =?utf-8?B?ZHQyaDVPUzcrR1RKb1Q0OUNKQVR0WXYzR1dBVzJnQU81U3U3VGV3WlBtRG1M?=
 =?utf-8?B?ckdqSWx4dS8rYmhrMjFJa1BING8vWWhqSWYyZG5PSlgwbTlsU0hrcXloMXB2?=
 =?utf-8?B?QzJRbnBoUWx2T1NSVXdMK3E0VWpybGx5eWx6Tlpybk45V3FqN294N3BGVitB?=
 =?utf-8?B?UXdQT2tSeU4reGdPOWdmeW9HenV2ZHl2dXdCRXRzbUllSzJKRXNobXBMVlpP?=
 =?utf-8?B?L3o2YkZ4ZkdhMXVUOE5QbG1BOG81ZmpZM21BMnIrU0dmWDdOZ0pxckhnN2Yy?=
 =?utf-8?B?Z3BucVRKbXhrcHFrMWFENEpBUDFIZDVUb0Q0Y290SS9va2dBT1U3UElFU2ta?=
 =?utf-8?B?Rm9RRlNUYStTMytabGRaR2lNSnJzRHorWlgvMGxMc3BlKzk0VzdLRi9DOS9P?=
 =?utf-8?B?SWlLT21UdHNmYTRTWWdTYkYyU0xFanh3bEIrQ1Arc1Awai8xa2NoSGgxK2Fz?=
 =?utf-8?B?UU5ZbWtjUFUxTFBYZnBkRzdiRUhyeUNVbDBnMmE5SXo2WXQvNUtUZnBrZFRn?=
 =?utf-8?B?SDU3QWFmTG9YYUhrNjRyekZKZm1TdzE0Tm9ieXNPVzQvUTlBZVdsQTg5UUln?=
 =?utf-8?B?c2xYSjQyenowdEcrSGRDT3ZmOVlXZFNUWDVjakp5cktNanhLRzB0NHBjYTIw?=
 =?utf-8?B?aHpJa2RWeUVpOXpDRHA4eXVscHVMTmxXZ0ZTa0pUQXo2YWhGN0ZCaERpZTVI?=
 =?utf-8?B?cFdaakhNMGJxY2U4OU51c3lUUGRqdnNWUk0vd2w5TCs3YlU1WDFleGZSVHRP?=
 =?utf-8?B?TWJDZ29waGVXMWVOWEV2MGlqZ1Y3MW1xRzNlZFRxMmJ4Q0YzUjV5KytlVVpt?=
 =?utf-8?B?MFRpUGRpSm5VaS9XeGJvaHJiL1ZMNkxVYldSVlRhVEdlblNFaXFwNzNCN0NJ?=
 =?utf-8?B?OFhrV3BqTlhJWVVYdy9kRXhuTWZtaEVqcEt3UW9KbGh6c0xiUFA3eHltZ0hY?=
 =?utf-8?B?aUpVaWxnUlBYRHdlc3d4RzRmWWU2VTdsQyt3UVZSUTNoVHUyZ0JDVXFlMXJl?=
 =?utf-8?B?RWNBRGtJaFkxMnc4M3A4b0tieFFtQmZyalVoZCtZMVNUOTlHU053UDZMNzRq?=
 =?utf-8?B?MzZjeFFrN1orYnNDSVl2WUdXeW5YaVFBNndNRUN4eXhNTHFaSzBHRDY4S0VW?=
 =?utf-8?B?dVp0MGtZZEpWdCtjQVRMNXdRUFZKalBxSUYydWgxaWdMYlJ2dVBlYkZ6SWM3?=
 =?utf-8?B?WGp3Q0o5dmF2SWxVeGFEcFFPYXJuOXlUeHJydzdBWGVVTUt5ajEyUXRIRDJ2?=
 =?utf-8?B?V3Q1TUlEOTFab1VpWHJpbWpRdndrQ1JOVFVLcVF3Mmtranp3S0liUkd5UXRn?=
 =?utf-8?B?SVlyOE9jSU40V2FYR0VaRjNNbVJPZGhUSFRmRjh1cEVVc1pxZkdqVTNSNFZP?=
 =?utf-8?B?eUVXcXFzMm9MaG4xNXVQV3ZLWVM5ZGo5eDlWSXZKbDlLMjVBbk01QTR1STh5?=
 =?utf-8?B?Y1BCbEZmOXFzTXdCTlR6V3k5QURVODh6MnhmdGJoQThPU3p6U0hNbmpNQkxY?=
 =?utf-8?B?c2lPUFZpdDYrcGFlUXJBWUFKTE52Z1RGQXEreEdCR09TNldCaVIxczdPbGUz?=
 =?utf-8?B?bTBxb1JNY2c2bE5XQzdSZUtFRkJEQnpkZldJZ0RKbE5na3NkMW10T2lTckRx?=
 =?utf-8?B?YmlRZ0RKaXZPSis0ZFp2VjIzbm9qaUdJMkp0QmE0dXNkWTNCSUZzWm1BODh1?=
 =?utf-8?B?YkFmUXV3MkdqRGp3bXl4NTRvT25ESXB0OVBBTkkrQVJnRXVOWFV4NDNZUWdm?=
 =?utf-8?B?K3Q4T01Ncm5MRmlQbDlNY0hVNFQzdmFQeWZNTmQ4TW1ONTRjekF4dFRXWW9S?=
 =?utf-8?B?eHp5VEdFZ0JXeHM4MEhSUUovM0NERjBKWEx3cGg5blpLNlRZUlVZRW42V3JT?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 689a53b1-ad72-4a1d-2579-08dbe11a011b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:50:00.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/a+wQqbI0/ZbODU8JdlONCBzO7gbR1sBaN2VedHA+Gqri4UwSyxQdwWu8T6eXPB7gSxdtCFBCWzy24izNYcb2YHZulYnRQ9+S4kqJHLvJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>
Date: Mon, 30 Oct 2023 16:32:10 +0100

> Add basic tests ensuring that values can be added at arbitrary positions
> of the bitmap, including those spanning into the adjacent unsigned
> longs.
> 
> Two new performance tests, test_bitmap_read_perf() and
> test_bitmap_write_perf(), can be used to assess future performance
> improvements of bitmap_read() and bitmap_write():
> 
> [    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
> [    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313
> 
> (numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
> QEMU).
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[...]

> +static bool __init
> +__check_eq_ulong(const char *srcfile, unsigned int line,
> +		 const unsigned long exp_ulong, unsigned long x)
> +{
> +	if (exp_ulong != x) {
> +		pr_err("[%s:%u] expected %lu, got %lu\n",
> +			srcfile, line, exp_ulong, x);
> +		return false;
> +	}
> +	return true;
> +}

Could we maybe rather extend __check_eq_uint to take ulongs? Doesn't
seem like they differ a lot.

>  
>  static bool __init
>  __check_eq_bitmap(const char *srcfile, unsigned int line,

[...]

> +static void __init test_bitmap_read_perf(void)
> +{
> +	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> +	unsigned int cnt, nbits, i;
> +	unsigned long val;
> +	ktime_t time;
> +
> +	bitmap_fill(bitmap, TEST_BIT_LEN);
> +	time = ktime_get();
> +	for (cnt = 0; cnt < 5; cnt++) {
> +		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
> +			for (i = 0; i < TEST_BIT_LEN; i++) {
> +				if (i + nbits > TEST_BIT_LEN)
> +					break;
> +				/*
> +				 * Prevent the compiler from optimizing away the
> +				 * bitmap_read() by using its value.
> +				 */
> +				WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
> +			}
> +		}
> +	}
> +	time = ktime_get() - time;
> +	pr_err("Time spent in %s:\t%llu\n", __func__, time);

pr_err() is for printing errors and is shown in red by some log readers.
Maybe use pr_info() or pr_notice()? Definitely not an error or even warning.

> +}
> +
> +static void __init test_bitmap_write_perf(void)
> +{
> +	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> +	unsigned int cnt, nbits, i;
> +	unsigned long val = 0xfeedface;
> +	ktime_t time;
> +
> +	bitmap_zero(bitmap, TEST_BIT_LEN);
> +	time = ktime_get();
> +	for (cnt = 0; cnt < 5; cnt++) {
> +		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
> +			for (i = 0; i < TEST_BIT_LEN; i++) {
> +				if (i + nbits > TEST_BIT_LEN)
> +					break;
> +				bitmap_write(bitmap, val, i, nbits);
> +			}
> +		}
> +	}
> +	time = ktime_get() - time;
> +	pr_err("Time spent in %s:\t%llu\n", __func__, time);

(same)

> +}
> +
> +#undef TEST_BIT_LEN
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -1237,6 +1411,9 @@ static void __init selftest(void)
>  	test_bitmap_cut();
>  	test_bitmap_print_buf();
>  	test_bitmap_const_eval();
> +	test_bitmap_read_write();
> +	test_bitmap_read_perf();
> +	test_bitmap_write_perf();
>  
>  	test_find_nth_bit();
>  	test_for_each_set_bit();

Thanks,
Olek

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC97E48C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjKGSwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjKGSwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:52:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C32599;
        Tue,  7 Nov 2023 10:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699383148; x=1730919148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5QzMD8flESCEK1iSVoCf+FjWV1WNqWQ6ME3EaluoyIs=;
  b=BG2FYhpnvP56fLMxDsH4n6pIfVv2Qn9O4xRaES3XITe95yXmMd1/5KX6
   heFya78jxCAlXEhWbKlfmOcWaYWr+7LLcZSpF1xmAmLAv39Kv+VUTF9cE
   SlPdokgnFN71/leZcRggWpKsiCE0FfTL4wRynd+MjVedMYM7QgDC7TvTd
   lTLepdOoSY3Yfjl7aZYRODYbjo+IHs2kP33gRdlDbVK+Fx6WMNm6QEsra
   HVA8J1i4e1QvvCjHcmJzQVA3daWtQBriwdcl/nOd5zrrkaC5kItgkiBFF
   jGwtUz+ZVou1YuDsyvFL9Y07skrskFsOyzNb/kQIlCud+WZoOFCmMWN4a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456072037"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="456072037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762794486"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="762794486"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 10:52:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 10:52:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 10:52:27 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 10:52:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odMGwfSWzkHOTuvGTwEDR4XZd52ws/sApsrb3UF0L6DEqtaKJFbGX+AiaXcH1WY7ryyTgmPUEfi8yyu8lkHMpK3er1IT8XFPXCpxk0Abs78LEmDkrLLCK+0NnG6xq+yBLIak1Sxr1li9B26P76v29UKHAJsxupmKu0wO0GacX35mFqkAkeHLKd+UjDzT3+GoHOZyHqr6xOMtvVHFfyfnaSXhmUJokBg/tbn96FCMFBgjon/leg93asjXCD4RZZHLlAjROZhdHU0j8LtQvGEz6n7JVCJPStApvr9mfilmMC/9B4SlXY/9e5kmmlv0SuLmDHSAKGTkLtlg+K2FVhVbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuDa7RaTvWRXCh5ME540ZmQzgtwdvQc8KaguV+WUYro=;
 b=HfdMgpbPKn32w7iuUcUsfWIlM814V8tU4F3n9DFplfAUmvmocnL6J3HNXMgo2S0zDqndrnBLDRpgVtBzGbp60lB6yB7zyej+eoc6djdywiPKKEjgdkcVnyuHqKuukhguGLLAxVJi38zLyHtX8CAOItMGdPf87KUeoGeR48r+w3fgbOnpkddtKMIPhh74CJSasWzGuyWayna/xZO2xVxxw7R5WSRRq14a+lDqUYgysGwbj1O5Mz7H/ai760owFsIZetSwnnepU8RYZ0u0rHLCg43yQRVdRxDDEaomcA1N0dMub7VRNppvaS+7Drtf0ULQ6meuuggJ7TWLCnl6Cb7KSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 7 Nov
 2023 18:52:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 18:52:24 +0000
Message-ID: <457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com>
Date:   Tue, 7 Nov 2023 19:52:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
To:     Yury Norov <yury.norov@gmail.com>
CC:     Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
 <e3b4b1a6-5383-4bfb-ba83-ab27d58dae29@intel.com>
 <ZUqCpmDgKFbscRgW@yury-ThinkPad>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZUqCpmDgKFbscRgW@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9ab2b2-889b-4c8e-d200-08dbdfc2ae3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: non4XRQ4FQX0M4gBRs0YA5cVnUyOfFTzZzXLSKyA43NzfxghraEXqlBdJ7Rfzk1ATGT0Rg3sWt+/YaM/6OGLbJgytKKl+joNvyLqpfLH+igUwGTCyPvVNy13SmB8k0gt+Ib+iiXDF4zjDgUmgVy1kajit8DHMK5c+IlkiTusIU+x7nJSCK6v2ohyCVGpliTMciJEQK29Cm2uxfd850U8vVVX3NPDJpx6xl1fuAq4hrORS9U/VhAr+OXHNM9SAPGpJRsllKLs6REwPBOZXb1cUgKALKmk96QXA27P97TjSZBLiDohjBqhukyej+NtUq3R6YmDPK9UXg+YUAEy89affgoFufBfhXOvfUwMsNGk1R+DSxIlfJ/WMrIo5Kt7JzfHjCqWyiEl18RjlZUmeAgkib2qoTfa3MUoxn6OBzHlWNqcxIW/V2XmVNDZduIOihKX6ZMKNVWm8+QDgGjL+101lWRp0E8tDurFL9ZgkRpc4/lfZOcXf1L6rAs3in0aTy2z29vPfKQTdTJuh2IZkt9ttNXPf3ZS2naTYN9uC5CcHcSn+kYwlqjKPEplye1TeQwm6QH6A8hk4BHDF4jYAIwavdlImHH1Q+S/K8B2pdg8QprC4ixx1PNKVNfVC/H5cHu3W0DmQd/WjKMN6W6oWpEruiq4ab3lPgVnRHGBzWEyi14u4724viCUj3BuBc+MVLRO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(230173577357003)(230273577357003)(1800799009)(451199024)(186009)(64100799003)(26005)(83380400001)(86362001)(31696002)(36756003)(82960400001)(31686004)(66899024)(6486002)(8936002)(66556008)(6512007)(4326008)(2906002)(41300700001)(8676002)(53546011)(316002)(2616005)(5660300002)(6916009)(66476007)(6506007)(66946007)(6666004)(38100700002)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG90dkVVOUhnSWEvV1JvWVlaTjg2b0JCOXAzT1BuSUYxUDg4V09oZmI2d3Jl?=
 =?utf-8?B?RTRyc3NuZ012Tkx6a2g1Wm9SKzdieUVWWDV1TUYxYXd4d3JSWFpWM0lreDA5?=
 =?utf-8?B?bzdyWEVJZ1ArcGttM0tmdWlaM2Z3OFZLZm5ZTVNQdDFzemxhblhiVk1FUWgy?=
 =?utf-8?B?aXlpaXhlTzRBckx6dXM0bW4yR01PODVMaEY2NjZKcWs4QkhPNTFHeWljcFpy?=
 =?utf-8?B?UjBGS3gwQURzYTlYQnZEOVVQSzcxVGl5dHkwek14eDkvZGY2dVNQZ2ZFZFY0?=
 =?utf-8?B?dnVBdlo2Ui9MREdYdmJ4RVJJa0RtemZFdWJNcVEvL0MvYWpaUU9OL0p6N2th?=
 =?utf-8?B?ZUt1TUprYmJpa1dDOFhkQ3ZEOWxTNmZjSGE3TkxsbzA5TEsvNUFrRUxuYnc2?=
 =?utf-8?B?RE0zVE5Gd2RuY0Q3dHVtUmVMQzloRUhxenhUVCtucGczbkd3T2oyNmZkVDlV?=
 =?utf-8?B?WmlsczFXZnc1WGpuUGRsWmYyREJOU1NSRTI1NWZOTnM5SXRUUmpzUEpON0NY?=
 =?utf-8?B?SkEyemZncXpQdjZxK3o1MVRSTm9UaE44bFFDWGpUR1RVT1FYMEI0L2E1UGdl?=
 =?utf-8?B?bVNrWG5pZ0pkdVRrTFNyYjdXZ3NPTVEvNzFzQ25UdWhrQ0k1ZG4yRDEvY0Ev?=
 =?utf-8?B?RkVPZ053OWhBSnFudlF6amMzcHNrQ0tPTklZcUd4Mzc1NFJ5VnpHOU1KbVM4?=
 =?utf-8?B?c092K0tGazR2SE5Edy9rSEV2eHlnUXVBb1NpdnFNYjlpVTJZTkc1Y3hvZEl0?=
 =?utf-8?B?a2h6dU5jaWhGbURNMXVyeXdRRklOKzZOYVhlQzdnbkVVdXdRWmVDK3FtZUZX?=
 =?utf-8?B?aXY3bmF1aExXaUJ6LzRPYzl4OGN4U295Y0VJZlE2S0ptSlo3cjRnWWdMVTNT?=
 =?utf-8?B?UmN1YXRidW9EV1lCMzZseDlpU0JRaGFWaC82LzN3cEN0dmVXZlJWT3JMQmNm?=
 =?utf-8?B?WUh0Tm9wcHRtNlZQNEo1R2p4ek5MU2thS040UDJGd0lIN2lTOXhzOTVnYmgy?=
 =?utf-8?B?WTFBQWNJZitpejJjeUVLdm81MDFIdk15QjQ4NFljSm5tK2UwWW9xOTE5MXFI?=
 =?utf-8?B?REpCcFljRThveVZEZHFuY0NLOEw1dlc0UUlrSXcveG5aaVdER3JtdE9LYzJw?=
 =?utf-8?B?OHM4VGRtY2gvUis4TXA2UjlKWEVBVVdBQ3RGOHMzUXlmZHJyRXRrem53R0tu?=
 =?utf-8?B?N2FLNjQvM1V6WitLTVl5UGFlanduTkJuNlRtM1hzM1RVWWVmN2c2SkxQaUMx?=
 =?utf-8?B?L3hCN2duYkRQZXJIRzdJcnFGam9hM0k5Mi9QdU1IdDROQk9lSXVBTXp2Mm01?=
 =?utf-8?B?cnRnL0NJcUs1aWF0NDhXWVNiK200MXZreFdnN2piNGtsdFZQckhiWnphQWhu?=
 =?utf-8?B?R3F0WmErUHkxN2cxUG9MdDFPbXZvUUxUTWphWW16OCtYS1NKTjVadWZmSEVV?=
 =?utf-8?B?Y1pjRVdIN1lhbFJKN0toMmd5OEczeXE3eE5YNWxidndGRXU4NmRXd3JmNTJ2?=
 =?utf-8?B?Z0laTTl0cFNGVXZCNEUwL29yZ1FNTFlRREx0WDJYNDNoaktOcUVFNDVkUWpE?=
 =?utf-8?B?ZXRSM0Zud09PNSttNDVSaXFVdEU0UnlwRVFJb2ZleENSRDY4RFZWWUxtWTZr?=
 =?utf-8?B?QUNDRURHOG9zdjR4eHl0VDRSTFpINjM3VW9LMTZiMzBWNnZJVUJhdGtSamZT?=
 =?utf-8?B?T0dGNGdhaXJhUjRZNDlZQzJ3Y3ZHMGtlQUN2MDBmdHh1eUQ2bGR4Skl3Q2kw?=
 =?utf-8?B?bEplUU9XRWlJSVhlaFZtK3lVUE9lTmh4a1RWRkswdmE5d25SNXVEL0xSSXpq?=
 =?utf-8?B?S21PVzk0aFJkbHdCMUZUbjlpRUlSZXlCUTRpbFVJdlQ3VW1ST2NkS3Q3WGc3?=
 =?utf-8?B?M3M4TTBKVGRsWlRJRlVxU2lQYzBDU3pMNHdmYXNsUGZ4cEZHSXpDaXZkV09Q?=
 =?utf-8?B?bFRkbnRlNERBbVVIZUxSSktzN3JPS2I4OFlOR0RGTUNsV0NOSWF2dHdDWktp?=
 =?utf-8?B?N1dyMU9lbVdINlNaaG9aZEEraHNZZ3pXVmwxWHhMeklwWkxSWndwdzBhcTJn?=
 =?utf-8?B?Y21KbEErSzE2K0NKQTFKU1ZkT3Q5dUk2UCszQ0NuNEtUK25waGVyNDZSUnd2?=
 =?utf-8?B?bHQ5bnZYUnk4c2VpeFVOWVJlNW93UzVaMnBrMXZZcmJBMWxTYzFYOFIzS2ho?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ab2b2-889b-4c8e-d200-08dbdfc2ae3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:52:24.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obuMkcBseNzBE0XZ+jqeIQHco1+QaXXEAolLcqENQdg50/+0f5/7jVg1O2c1ih34pNmEK+dyjMw7QYIdDcEHcOPcMbv5YoOPFdwyGTFJg5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 7 Nov 2023 10:32:06 -0800

> On Tue, Nov 07, 2023 at 06:24:04PM +0100, Alexander Lobakin wrote:
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Tue, 7 Nov 2023 17:44:00 +0100
>>
>>> From: Alexander Potapenko <glider@google.com>
>>> Date: Tue, 7 Nov 2023 17:33:56 +0100
>>>
>>>> On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
>>>> <aleksander.lobakin@intel.com> wrote:
>>
>> [...]
>>
>>> I tested it on GCC 9 using modified make.cross from lkp and it triggers
>>> on one more file:
>>>
>>> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
>>> ./include/linux/bitmap.h:601:18: error: array subscript [1,
>>> 288230376151711744] is outside array bounds of 'long unsigned int[1]'
>>> [-Werror=array-bounds]
>>>
>>>> to give the compiler some hints about the range of values passed to
>>>> bitmap_write() rather than suppressing the optimizations.
>>>
>>> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
>>> correctly, rather shuts up the compiler in cases like this one.
>>>
>>> I've been thinking of using __member_size() from fortify-string.h, we
>>> could probably optimize the object code even a bit more while silencing
>>> this warning.
>>> Adding Kees, maybe he'd like to participate in sorting this out as well.
>>
>> This one seems to work. At least previously mad GCC 9.3.0 now sits
>> quietly, as if I added OPTIMIZER_HIDE_VAR() as Yury suggested.
>  
> What's wrong with OPTIMIZER_HIDE_VAR()? The problem is clearly on GCC
> side, namely - it doesn't realize that the map[index+1] fetch is
> conditional.

It's totally fine for me to use it, this one is just an alternative
(well, a bit broken as per below).

> 
> And moreover, it's fixed in later stable builds. I tested 12 and 13,
> and both are silent.

Yeah, this happens only on GCC 9 on my side. I thought on older GCCs
`-Warray-bounds` is not enabled due to false-positives.

> 
>> Note that ideally @map should be marked as `POS` in both cases to help
>> Clang, but `POS` gets undefined at the end of fortify-string.h, so I
>> decided to not do that within this draft.
>>
>> Thanks,
>> Olek
>> ---
>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
>> index e8031a157db5..efa0a0287d7c 100644
>> --- a/include/linux/bitmap.h
>> +++ b/include/linux/bitmap.h
>> @@ -589,12 +589,14 @@ static inline unsigned long bitmap_read(const
>> unsigned long *map,
>>  	size_t index = BIT_WORD(start);
>>  	unsigned long offset = start % BITS_PER_LONG;
>>  	unsigned long space = BITS_PER_LONG - offset;
>> +	const size_t map_size = __member_size(map);
>>  	unsigned long value_low, value_high;
>>
>>  	if (unlikely(!nbits || nbits > BITS_PER_LONG))
>>  		return 0;
>>
>> -	if (space >= nbits)
>> +	if ((__builtin_constant_p(map_size) && map_size != SIZE_MAX &&
>> +	     index + 1 >= map_size / sizeof(long)) || space >= nbits)
>>  		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
> 
> This silences the compiler, but breaks the code logic and hides potential bugs.
> After the fix, the following code will become legit:
> 
>         DECLARE_BITMAP(bitmap, 64);
> 
>         bitmap_fill(bitmap, 64)
>         char ret = bitmap_read(bitmap, 60, 8); // OK, return 0b00001111
> 
> Before this change, the return value would be undef: 0xXXXX1111, and
> it would (should) trigger Warray-bounds on compile time, because it's
> a compile-time boundary violation.

Oh you're right, I didn't think about this. Your approach seems optimal
unless hardening folks have anything else.

I don't see bitmap_{read,write}() mini-series applied anywhere in your
tree, maybe Alex could incorporate your patch into it and resubmit?

> 
> On runtime KASAN, UBSAN and whatever *SAN would most likely be silenced
> too with your fix. So no, this one doesn't seem to work.
> 
>>  	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
>> @@ -620,6 +622,7 @@ static inline unsigned long bitmap_read(const
>> unsigned long *map,
>>  static inline void bitmap_write(unsigned long *map, unsigned long value,
>>  				unsigned long start, unsigned long nbits)
>>  {
>> +	const size_t map_size = __member_size(map);
>>  	size_t index;
>>  	unsigned long offset;
>>  	unsigned long space;
>> @@ -638,7 +641,9 @@ static inline void bitmap_write(unsigned long *map,
>> unsigned long value,
>>
>>  	map[index] &= (fit ? (~(mask << offset)) :
>> ~BITMAP_FIRST_WORD_MASK(start));
>>  	map[index] |= value << offset;
>> -	if (fit)
>> +
>> +	if ((__builtin_constant_p(map_size) && map_size != SIZE_MAX &&
>> +	     index + 1 >= map_size / sizeof(long)) || fit)
>>  		return;
>>
>>  	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);

Thanks,
Olek

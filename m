Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8C778538
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjHKCET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHKCER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:04:17 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9152D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:04:17 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37B20Chn019571;
        Fri, 11 Aug 2023 02:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=1bGobGXcKDpqVKdcJrdLSuX9mPviYGe3tnVp+v4ZPnc=; b=
        c7q0emS0mYIZQgiwTYE4B9K1/dpphwBwCUYPzffp/PnhQ3iG3pc15fPhcGnMGAI4
        UnZljtrkmPA7/1S0Omm7wu5agQNdfjCOXvntRza4PG+BpVUXKyhDkD8DuY/vE+cG
        /wRLxkJwfjcxZEngBLbWbquRIfIbIdYcxuBczv3gXlnFRxZ1Nb+WJs9VEI5OIhSe
        XN3NWjEWvr8hjbJH4cdDjJxMYxCFtvYQWHfXzYCYqExaeJawwUAJsZI8AtQ9KBt8
        JN6Kbfk1guPspT+1Gt7QaWwXhW0ODdUZH4a2mEOecUrfZXpE3ee5ixpYMiBg4Lce
        gsDGlMkXfxLRynkrmYB2Cg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sd926r3bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 02:03:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHSgRWnZ0wiBDAi1fR8jhjqfFdvOTouJ7r9XvrfZsbhjVUiGX9ujoi4qFlhYYP+wMK6CxhB5oB20Xa2jsxs1yKfLbrbKPgVHENVHdilXthYiu9P9o4xphsy3uxOawbmfN8ygiu+Y1c4z5TLLXeugw++3snd87RpeuO0bycYLj5Ke5xZdC/STHN6HsFZ5QM/NhEnxUrsJ8DF55fxks9EVO9yAqN+7iI9uYZhwROxPP6H8qK8T3wgVx+CMbIrfVTjh9KfCXXVr8VfGy4zWy64sY7yp9n0Xz0ZNL6E9cYIRIUMqgyphY+PFqbupMnHbDsE+CtEyx3MUrctvEOlttVFlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bGobGXcKDpqVKdcJrdLSuX9mPviYGe3tnVp+v4ZPnc=;
 b=V6wEa9tqr7vFQM+xRPOXQJtd5WdgyO1TbkQqukBhtO0H0LxpQON/7BqjQ4jdJs8rPbHYWwCH7HNzU2VS01VIJys4G2ut+6WbT4Dsr3AaIdrfBKwiNC+FJtQ5yBiCQnPF/UMeQqqgTc6H+udL955IuF7wVwrXIM0AaEOmYW6VkGI1PJWV0YX/G/Z2Os4f0aLhT3N7Q+f3MWXo8JyZBxbcYF7nTA6vB6/+jRKyCwaK+vW1INP/qCORWdD3UT8DPsVV6pNoDdost/tR8Ph77+ZDd+Xl9qJUjKyDc3rX/FAKdJtQID8ZhCSEnkD5WsRXqjxsgYKkOIEvIdiWfetmBhn56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 02:03:57 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 02:03:57 +0000
Message-ID: <e401350a-1e23-dae9-97be-fe659665e22d@windriver.com>
Date:   Fri, 11 Aug 2023 13:03:45 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized in
 set_track_prepare()
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, catalin.marinas@arm.com,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-3-xiaolei.wang@windriver.com>
 <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
 <79deae0c-eeef-2370-9d8a-b2746389d38c@suse.cz>
From:   wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <79deae0c-eeef-2370-9d8a-b2746389d38c@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 702563c7-20a3-4387-2ed7-08db9a0f38db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nT8bgdsBEuLEJEh01scUpBTo4JX4MIl+WG9p2lIhYSQ7bD0M7nXSIHW0gIawhNxmYrUrwmX6uG653NQ6D/HaROWWdi1+b59cvlh1GJhH77te5wqMRF0rR1RpJ/fkZlJIjl8lIM7JWTt4savoSMUO/22BrV28dqN5oF7Ie5Z4RtCl6PujDDqhiG/3rlx9x4IL8f+sGSgKBDp6NrsRK5S3Cc0Btkc54as0yAxnOWELzODMXYOfrw/IgVDzaDLA/aAeS9EZuH83NBnMpzOLz4JBHfbN6GsTFwl3xGJryRM5aMTWbKcriUDH99m2wyq494wDMqx/ZmGD6k06KURfKbCmpsRDMOeqdXxmtjHoE4PXGPdx6NbT/LhdJP7LZbLKh5SVrN+LzjSZQ4Vm/yobJ58MgLFt/mhIhvwB3EqjHsO/N0DusxirRgYGA6T69U3/eiZ50Zko1yLxpNpNU28evYDFuyKN2fnw7Kn3P/8mC14wBygt+yWW0/0jHB1Y003DJZlt5nVpFvOZ68S7MstEZR+lH9rfRxJ9iWs693Qt9XTQOryz1ead43pbyix4DcpX21Uwr8YMWGRP6hu8CHoOLVk4s5xkneH6PMie7a0ZJy4kaa4ORHMfLOUDDzqPwHKF9oNadKc4xNMtK7Itvsxc2+Nm0VrQ8/MedRkENEAa6HGzCslCq72GWBAa7nT35w/CQOoL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39850400004)(376002)(346002)(136003)(186006)(1800799006)(451199021)(6486002)(2616005)(478600001)(86362001)(6666004)(6506007)(53546011)(36756003)(6512007)(5660300002)(31686004)(38100700002)(66476007)(4326008)(66556008)(66946007)(316002)(2906002)(31696002)(8936002)(8676002)(41300700001)(83380400001)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkJReC9lZUI0SExvSE1MbExXYWM2c0JqYXFyMllZenljTlR2QXFWcXlpQklz?=
 =?utf-8?B?RG1uRWozcXpIRDlGekZqa2R5V0dKaS9UWnRhdVdGNEJscU9qWFNpN1JWT1hR?=
 =?utf-8?B?UXBJanVoY2hMekNBeTRUM0Z2RGUzTlZLcU5HZFd0cUxsQ2c1ZW56cERxZjFu?=
 =?utf-8?B?QWJXV2NLRk5QdWlpNUZOKy93cXFEbXplVXRxdmFDNlJSZGg4OTVCQnZiTE8v?=
 =?utf-8?B?WG0razE1R3o1eC90dU5OSzQyNVhKWElOdEVGNm5aYWM4VDhaeksrZElsbWQ2?=
 =?utf-8?B?ZHFwWmVsNmpNbWtNNGNRdnJnbFh3UEJRbzNqSXdTaVd1MXJHcTBqbUlqanI5?=
 =?utf-8?B?c3dacWNKYlZCay9IdXhvWVBsWkZxNlBmSGxkVFhraGhGSTMxMTUzaVJaaUhv?=
 =?utf-8?B?Y0dXY0Q3bGJTZDBIMzdCYWcxQVJxU2cxbmZOaURCb3BxNzFDdUZ5SExOL3Vm?=
 =?utf-8?B?SUo1U3h3UTdWK0VCd1RYUEtNZ3lXNTlrMnRjTUc0RmRRNzBQcE5WWnNJVDlo?=
 =?utf-8?B?SStLMEV4emdzeUFVNTg2RS83c1RzQTR1enlMMjhkbzJFb3hqZ1dUbGY5aEp5?=
 =?utf-8?B?bGw4cElVd2lTdm9Xcjl3a0VyQ0ZCbitaWGx3N1J1bmRsVlN6Z3Z6cWRMRnhF?=
 =?utf-8?B?b3RNVVkvbUtSOVU3Z3gzUmlYK1VpYW1JeHlwL0p0VWh4NVZpUG8yTlFTWjJq?=
 =?utf-8?B?eTUySDltMGxEWXlPUjFTN1orcHRUSVFtQXNGWmxNMWFqa2xqODFXK0hmRW1E?=
 =?utf-8?B?NGtDbExYZXdyenFqVDI4a0pDSnJqdGo4cEFHcERadnFWL2lDN1NJbS9kVWFI?=
 =?utf-8?B?TXpoM2lKa3gwZDdEU1dMdy9zSkQ3YXJSL1A2MGpLUTlSdUZSSWJzMW02eWZq?=
 =?utf-8?B?eThXUlNteEk3RFpQdVMySmwyM2Z4VVZBNzlQMDRHNUoxOVFydDFjV1BKcFZ0?=
 =?utf-8?B?c2U3S3dyVkVnM0piSG05aFBwVTh2MXBRYzkzQTN6WkZ5dm5iQUpTSWo0U0NX?=
 =?utf-8?B?Ynl1WjhaL0ZVRzdETVhNWjdsZXoxVG5QMEdUWHJaZVkrU1diOXhWTzRQSDdu?=
 =?utf-8?B?MUpLT2xPWUk0NjFuelkzM1lXOGFBU0VVZTV6UjNyall0UW00S0tjM0xxUCtB?=
 =?utf-8?B?OWcvZmZiWjJKYjJickZiZHFEUjAvZVZHbEJwa2Zwb25IUkpJa3VyQTVIbFY4?=
 =?utf-8?B?STFIS0Nyc2VEOExjWks2aG1qVzNRK2hQdEZzTldVcFloaUh0NG1TU01KTDJx?=
 =?utf-8?B?cWhIZThQd0VNaEpGQ3VUY2JGT2lac2M5VWZDeUxJRmRkUW8xajRqTDdkZ2Fw?=
 =?utf-8?B?S0VSVGhlc1hZMFAwL0lQRGdDOTg3OVR0OE5pVzZDL3NTb25VbU15eHNOWFlj?=
 =?utf-8?B?Y0dHcTdHZkJaSlJiTkQrRm5OeHU3L2s0RHNTb0NDb0xkZHRqU0NOZytiUExU?=
 =?utf-8?B?dEVSVks5dEZxc2JWenhhdmtOM2ZjdU1YUWRIbVV2eXU5QUYzNG5vaDNyOUls?=
 =?utf-8?B?cy9Kb2F3ZHVqV1YwWDZpeTM5b3NVZ2MvOERaS21FeGV6NVZhdysvMXhsS2ZH?=
 =?utf-8?B?UnRJcnZQa0lBRnVNWHFPUG9Tdlk4Witzd285Qlpnak1xM1Jkamg1eTZmRWlV?=
 =?utf-8?B?S3BEc0c4dFYrS1daMHNMRTlIamxQanFqZHloRTNZdjYvNExacWlUbmc0ems2?=
 =?utf-8?B?M1ZudmpFclBHVWVpWkRkUUlnSXhFNlZidzBtZFBxK1ExQW1uNFlDbHhmQkR1?=
 =?utf-8?B?RkJKQXhGc2VIdUZLNDBGZFRtUUFHOXVNdGJOSXQwUWdBb0RFYmZkTGRod2Rv?=
 =?utf-8?B?SU1PV3AvYzM0MmU3V0lwaUVUbE9BNTcyeW44ajJ1RUpOODhzRE1wWDA4eCta?=
 =?utf-8?B?RzF3U0p4M2lQUVh5SFozbWZYSmlzcCs3S2lXWXliTVVGd1JKVFJRbVlBYUg3?=
 =?utf-8?B?S1hwdXFpekRDTmRRL3JnSWhRcFhnZVcxNm1QUHpETlpZc2FKdEgyWjloeDZN?=
 =?utf-8?B?dDZDTnpScFR5QU5yNEFmQ1Z4dmxHbGlSRU50ZnA2Z2RnQmpYS01lUStSdU84?=
 =?utf-8?B?ZzJoV3BKMTB6clE1YzJYWXB1dEFjOTF0MndpV3c0d2IydnU2ZVh5cnhpWEJw?=
 =?utf-8?B?UEtnc1BTVlZYMmpWOHFmUXA4ME5wWTUrZGRLNkZUbVZlclFTa05GMG5mQ0Nx?=
 =?utf-8?B?Y1B0bmd0M09QY1ptcXdKWStHcFdTMTdOVVFtVEtQMi9mYUZWWlRibGlpSWF4?=
 =?utf-8?B?Q2JIYlFsdWpqaUlpN3MvSjQrd0ZnPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702563c7-20a3-4387-2ed7-08db9a0f38db
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 02:03:57.2860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuNQIqR5VLgIit2MijzAeHKxw85nr17lavCDm8aX2SFLZwR3R1ImNLOaamitEG+NTFIuFFfbwxrp1iqgR7db0WVFNQT2QJwlkBkmnpWOj5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-Proofpoint-GUID: NTiXM0RUCLe7JfQkLTl8vyKBwWXUTnBr
X-Proofpoint-ORIG-GUID: NTiXM0RUCLe7JfQkLTl8vyKBwWXUTnBr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308110017
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/23 9:16 PM, Vlastimil Babka wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 8/10/23 12:03, Vlastimil Babka wrote:
>> On 8/10/23 09:47, Xiaolei Wang wrote:
>>> The kmemleak_late_init() is defined as a late_initcall. The current
>>> implementation of set_track_prepare() depends on the kmemleak init.
>>> That also means there is no call trace for the memory leak which object
>>> is created before the kmemleak_late_init().
>> So if I understand correctly, we have the following sequence of events durin
>> boot
>>
>> ...
>> A: stack_depot is initialized
>> ...
>> B: kmemleak is initialized
>> ...
>>
>> before this patchset, we can miss allocations before B, aftewards only
>> before A (which can't be helped), so we now have between A and B.
>>
>> That's nice, but it's weird that can record kmemleak when
>> !kmemleak_initialized. Why can't it be initialized sooner in that case?
> Looking closer, I think what you want could be achieved by kmemleak_init()
> setting a variable that is checked in kmemleak_initialized() instead of the
> kmemleak_initialized that's set too late.
>
> I think this should work because:
> - I assume kmemleak can't record anything before kmemleak_init()
> - stack depot early init is requested one way or the other
> - mm_core_init() calls stack_depot_early_init() before kmemleak_init()
>
> But I also wonder how kmemleak can even reach set_track_prepare() before
> kmemleak_init(), maybe that's the issue?

Before kmemleak_init, many places also need to allocate kmemleak_object,

and also need to save stack in advance, but kmemleak_object is allocated

in the form of an array, after kmemleak_init 'object_cache = 
KMEM_CACHE(kmemleak_object, SLAB_NOLEAKTRACE);'


I think there is still some memory not recorded on the backtrace before

stack_depot_early_init(), does anyone have a better suggestion?


thanks

xiaolei

>
>>> In a previous patch, we have fixed a bug in stack_depot_save() so that
>>> it can be invoked even before stack depot is initialized. So there is
>>> no reason to check the kmemleak_initialized in set_track_prepare().
>>> So delete the kmemleak_initialized judgment in set_track_prepare()
>>>
>>> unreferenced object 0xc674ca80 (size 64):
>>>    comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
>>>    hex dump (first 32 bytes):
>>>      80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
>>>      00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........
>>>
>>> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
>>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>>> ---
>>>   mm/kmemleak.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>> index a2d34226e3c8..c9f2f816db19 100644
>>> --- a/mm/kmemleak.c
>>> +++ b/mm/kmemleak.c
>>> @@ -610,8 +610,6 @@ static noinline depot_stack_handle_t set_track_prepare(void)
>>>       unsigned long entries[MAX_TRACE];
>>>       unsigned int nr_entries;
>>>
>>> -    if (!kmemleak_initialized)
>>> -            return 0;
>>>       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>>>       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A380F79FFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjINJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjINJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:14:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5F1A8;
        Thu, 14 Sep 2023 02:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5yzPktL5BoBdWnWXG1xRuKMMclmXXVZGkGMU9GEZ+UYHCjV0Ae+fqEGl33IDFYIoNH1wDTo7MRyYvDVZOc79spjV8phJbGI9d3fNyDxT9UsGFi4VfdtfN2WipGeSbOvT3j7Kn5OTfyn5fK4egZlnLutFVU9qOxUGVqjHVjXM/SYHhHZvnq2ePjpB/AHA7mw2HP6nUvDztKV82lda5PxQDRlBcpw+mJ+BQNju6wXCvOcBI1qkypVBexTP9HY/t/IOOJmsn4QX58BT+Zcrb4ZEzoI/VQDaEeMQMSoKVjiKs+WXhNUtanN0hFEGQLoBTgj4VUS/iDhngtO7FZjJMdeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmDGPgwwONcaHCoWXoZJvZVu9m9wc65jxWZcBsUgbIc=;
 b=X4GKZBgX9+XH8ymbzFntmdoN46ctfkLVuDOuxKm+fGBBkwMwvjucvD/g86WF5+RVxP9DOIvZWY+teK/dyJ72himwI0lzNf51mc4UtkteLr9zE6xCodmocfLzuewDWmayaVNFFbDAFkuFWo8ZO4RDxVRPNE3uzvtnDL+pTCgDxJNG8Z6OHetKXVeJ1yEEc++ZD6B4Hn1aNEz2R8Rz0+7TgNbmlSZbg8EdveWPJGv8X/qE6ylt4CrJJBqGE/BnHIIZwLzo/9BpxZl2dAY8sRDB9IVCZGTjT0Gng3SBLe6ZI57xOe7aFwLcD13Y6XFQhQNU9p11aXqN/m5Wjfb4fmDKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmDGPgwwONcaHCoWXoZJvZVu9m9wc65jxWZcBsUgbIc=;
 b=pYOTeD5/KybCIE0xjqJpKlqYJQBhfqpnGzJkqM+SiD2pUIg9HW0wiWIw9/fJU1fhHQAEUU5M+uL88c2n0W+cL+k5q/595Lc/N6UukOOCwogIaLeqdos3aGBVZcueuYNlZgNzOdRVTFN7jo8NS+56SmmDp+HuuO+XkVCIJ3kGBig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 09:14:28 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 09:14:28 +0000
Message-ID: <b5095128-2b10-4bd2-98aa-d5b04f412fc9@amd.com>
Date:   Thu, 14 Sep 2023 14:44:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Breno Leitao <leitao@debian.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230914091234.GE16631@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::28) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce60b05-d963-4000-107f-08dbb502ff61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzrsvVwlhEM12heQ96+ZBeM0MFNNND0vLp52K4z4sayIgzTaIpTkLzqQXV1fDCrL2X+IsWbag6OSm0mcefzDgmsLs8uwNgmYBZ7sQnxEwmkttQxTDrp4Nk/ciNqF9KwvoPK+eEDAMGHtlPB7CyyTLC5rYORS3gOU6tPM/Ntb0drxUvQq8Z4lOfWHU3O9ZWFXV6v2bk84xps5hEqh88XuBjy7OafV+k1y3yvJ8l2jqvY/BowgCmbhibsawk8Ud5t9ox4JbUNPQIej1W2XGWIC4qE4OmtI0YAQBe4+I/QQCI/rHI0vXaMjSXCHnbHKSHDHOn1mgsRHJ+9/UhutTLgjpDA4mCBnjizRNm5FCffewjDSUlcrRWkBourTtMuNT0ZAGSxcN0ZuAmTde6s5xngmo2nV8i0Q/VGwY6oiLMRudGsHZ2j1hoSyXjjhqei4h0S7MqMF9PXTbiZy35FIIFr+HB9W4/0KHmFONwZUlZKztkk4dDf6/CnoONBloRqXPLFVk9WCi0y/uvakPXZbHvabyzX+16vhedUwmMs6Nn9jWDBITG9WWsM0M5ZHn+soL2cHkj5OallhZ7OKGVLa2Hh2Izr5h+jwBzMBXdSiO1hmGd7xphAAYgy9ya/NmtDYesBIz4lnFgaK+D4XykJtufBFGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(4744005)(31686004)(38100700002)(2906002)(54906003)(6916009)(6512007)(4326008)(66556008)(316002)(41300700001)(36756003)(8936002)(8676002)(66476007)(44832011)(5660300002)(6666004)(7416002)(6506007)(53546011)(31696002)(6486002)(2616005)(26005)(86362001)(66946007)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJJengvVkFOSFJ5OGxtalNiWHpjS0lvRkpseEFFWnNtd0tyUHFlZm13TE4w?=
 =?utf-8?B?QzhuYjQvNFltTXR0SzlIdWpUbTVsbFV3KzBhVzVQVGVPUWFaQlY2RXk2dmRL?=
 =?utf-8?B?YmE4WEJmQ2ltWXhxOWFUUEhMRzJja3h0RGNrcWF3Q1lVQ1ROMmc1Y3J6OXZl?=
 =?utf-8?B?WW9FM3FTMExOdGRtMy9VcXZ2d3dUd0l1MXlTS3g3d1Yvd21ON1ZzTTZUa054?=
 =?utf-8?B?RkQ1Mm9vK1l5V3c5WXNYMUZHaTloWGZVd3VQTEU4cGhyTXJsbTFzY0htSENP?=
 =?utf-8?B?aU5Wc0R0MWFrQTJUbVdkT0ZZZEdMdFBhTllVcnRyL1BvaVhFUlV1S0lmSnVR?=
 =?utf-8?B?V2g5dFNtT2VQeHZOOWhEVjNBY1hyOHU0Nzh1K3huVnpoVE5pSjBLK2xRZVF5?=
 =?utf-8?B?ZSs2WEJZOUNMRUxTVHhMaWxoMTdZaElXUWtwMXF1TUtXdmp6UTNXbHMwM0lL?=
 =?utf-8?B?bFJaYXZscFJsZXhzamE2aGxrMmtucFpXUVNxNG9ZakdFZDRCcTZNaytMZDI0?=
 =?utf-8?B?dW5wWi9RZndNTmJrUS9xeGh1a0k4clVyVUF6WjlvUWZ5Ui9HSGtkSXc1WTMx?=
 =?utf-8?B?QVlHWXlEUXZ1NlVKclVtOFkrSDZPR25oYzV5VVU3UWI5SXVpWFBlV1FtUURN?=
 =?utf-8?B?TXNkTkYzd0RuL2JLTGpPYkhDaGJBNzAweWJIMXZMMlBxQ2F2QkM4Y2pMcjQz?=
 =?utf-8?B?ZTBla2xSYnBNYm1kayszRU1oSHpKYlhUb0pDN3p6bmFTVktieGpVQ1h2ODJm?=
 =?utf-8?B?UmRKdHFFd3YxYnQ3Z1NWTGMxby9JUzVnWXJGQmN5WXp2Ync3bEt3cjBsTFNn?=
 =?utf-8?B?dWgxcit6cWZOOEQ1UEVwdmplVDhobE93UVZ5cTl1NTVNNUN1SkIzekpGdnZt?=
 =?utf-8?B?eFkwWG9Nd0tjdnQ3NWdwS0xXbitneGlZQWN0M3JlaWliUm1wMVJCaWdwcGNE?=
 =?utf-8?B?cDRiajVQM1lEOWI5K0x2c0dCMHRwbzl2TGhScFQ2VXk2ZHdiZStiSFV4bUVT?=
 =?utf-8?B?djZtZm9JZVJwc3UwUlBGZEhUdXIzcHFrRFNjS0E3SXJsMjVPaXdJbklIY3N6?=
 =?utf-8?B?TVF6VFFqQSsxREphK3MxeTVsbWNFQm1zbzk2YThrUjJ6SC85SWVSdWhUSUV0?=
 =?utf-8?B?RlpWT0xZc1lnbVhoU3FWQTBIK0tpb3RGMTRpYW5JUGcrK0Rpd3IydVVIQy9Y?=
 =?utf-8?B?UHR3S1l4NVUwKzBRelZ0b2VZZ2o4ZmhmTkpBUkM1VzRPelJ3bWJoU21mSWZY?=
 =?utf-8?B?VGFwTUgvelZ6Zy9iUzkvT1hndWoyMG9va3RiM0NCRTUxbGJkM1cvSVhPZ1hT?=
 =?utf-8?B?UjJETTUyUnBXemhrVTZrT1NXaFhJckVqYVRjM2t2WGVaTzZVOGRVUEh1SHlM?=
 =?utf-8?B?c1ByRjlTQ1FFZzBUQ01qdTI4THpUSEsvM21RSHBNMlJ1UGNyWXQvZjU3blpM?=
 =?utf-8?B?ckhiY3kvdlV0QVcvR1N6VjJYeFRjVzh1amZvWE01L1luYVpGRDFFNmZTclBG?=
 =?utf-8?B?T0VnMUx5OXp6RFFlWDhncmJYU1haZXBUT3UxbnE0dWljUzQwSjRrU3M3TGxE?=
 =?utf-8?B?cFFFNVUzWjMxSHN2WmFuUVJmd053ZS9NZjl0Z2ovak5oTjZSbVVWTGlJWFFo?=
 =?utf-8?B?dElLakFHenVCRVgzVjhNNzUzdnp2cCtKVE85emV0ZWxIYUVIT1huT0FRbk0r?=
 =?utf-8?B?Tkh6clVMWjQzRURXazBqRjhLc3Vqa1RkanlDUzZEM1RMdTRGamVsekRaajZt?=
 =?utf-8?B?SFFpV1J2Y1ZjVTJlaElicTAyWXJuTlJZU0E2ODRPQi9UYS9rZ1NyVGsyY1Jw?=
 =?utf-8?B?M0VIRDZSOVEzMThGQWlDeE1SclJzYmNoQXM0Nm8wc2RaYldCdWVDVHp0WWFK?=
 =?utf-8?B?M0hRUnQ3MFZhcUsrUnhybm53cGVHRG44SmN6UVZWNXQyZ3U5QThxUk1zdktD?=
 =?utf-8?B?Skx1STcxWXVTb093UmhUbmJ2dmRrSXpiWFZ6VVplMStZVXZ5b25hUHRUZFlq?=
 =?utf-8?B?ZVNqMWt3cjlEajk2aHh0VHk2QkdxSXRzdE1DVlJWN05zRlBVN2MzaXdDNHZw?=
 =?utf-8?B?TndqRkFxTFFmNzk4aXdRTFhJMjVvT05DRlY2a0djU1lEZTR2SEpLTVQzWmR6?=
 =?utf-8?Q?Zno3CdyojzhTxn5tr2UWGvxAo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce60b05-d963-4000-107f-08dbb502ff61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 09:14:28.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DldQjigqLo67EC9KAiE9FwynzMFgrXnWuVcsirHr16uVopb5tjBZPJJ/XQHuKQQOav+b6q8V3VM/FRpJbIUg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2023 2:42 PM, Peter Zijlstra wrote:
> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
>> Hi Breno, Jirka,
>>
>> On 9/14/2023 2:15 PM, Jirka Hladky wrote:
>>> Hi Breno,
>>>
>>> I'm definitively voting for using WARN_ON_ONCE - in the current
>>> implementation, we are getting thousands of the same warnings and Call
>>> Traces, causing the system to become unusable.
>>>
>>>> Anyway, please let me know whatever is your preferred way and I will submit a v2.
>>> @Peter Zijlstra and @Sandipan - could you please comment on the
>>> preferred implementation of the patch?
>>>
>>
>> I agree with using WARN_ON_ONCE() to make this less intrusive.
> 
> Could you send a patch that AMD is happy with? I think you wrote this
> was a firmware bug and is sorted with a new firmware, so perhaps make it
> WARN_ONCE() and tell the users to upgrade their firmware to $ver ?

Sure. Will do.

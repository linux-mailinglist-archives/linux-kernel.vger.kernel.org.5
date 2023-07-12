Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988EF7511CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjGLUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGLUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:22:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2F21FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:22:25 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CCdNDm027054;
        Wed, 12 Jul 2023 13:21:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6DdH7KjGnNDvIIXTAjMQxa/v+Ou0C6JdNvSJxUmIQGw=;
 b=NiSoKKq9jrGtfdcRrpy8r9cS09wdpFdX8YO6QLcIJWMFYooq3ke1gDCmHZuOvY+w0Gme
 /m6avQIIYCNVjl/XlPl96P/uIe8CFwDuw3zCTgVYc20Ujymn25ym1NGj2rTKLlQqHUtR
 PQhlLeDtK/Y6hevYJHMecfVpE3i4AyaekYlV14gQ2+MktmF9plxB+8VNZGNh/pkTkXcl
 eI5/7EQhyz51OmEKJo1gDQhcsShyeOs7lN3W9CeFHRbt5IPqIDa8tszu1/MHwJEbso45
 lC8EB3PYKhbcCkPdfxWeZprxPkBvaBzh4SMS6MXEFx+QPLXmU0KjjnTBBMO0c5ssOTV+ sw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsfwkfwuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 13:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEjgVORbImTdmAz2p6PYmZ0AXnK8yr3V3NFfpOO1DTphK00vX6eoDMa+tRAK+ZQAvys05wRiwotAahNGcb7DRXUpnyBMo4Ge265s8EsjHhtplJlOuxY5Jk1UXToLDE9sTV2K58ZikSg0B5gNZWs5DSJdgqLCP+BUC5POn5CD38FZOLQqrSEoSR+pbgGv4YPtEzWBeaNL6ex4wvZegIrVDQEIurDVQs17SQSJStndUn/mPsyctdzAiR6OWpzwX2WN5t6N7oDHHTm5CThTKWDt9bu3xVy0VsOC9CNcC/YjNNWSEQ0/925UrfyPDXN7WES5RJDi1mpzlhCPWt/2Y/IFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DdH7KjGnNDvIIXTAjMQxa/v+Ou0C6JdNvSJxUmIQGw=;
 b=hGOyCxkUMYghz6EsBgI0GCqNJ68adQGeKuNtKeEUTEvjEpgXxVxJ/qdgc2uwpEGeDCpLyN/jhSYdGnMHn9yWaAxHs07GlNjZYzWz5r1J3jp4S/KYxjviQQZ0mDgimeavwRtEaWDKJjOOE7DpgfO0m5Xsg8lY+KzLvju5fZ8oHV+UuHDMGlhybcDvf/0hqGshCc6enqArrAiKutSPGYzICKV9WKQBuoLKww/XwCOykAhE/BpD0IL2yH3RDKurvLFb7wmRyN2VKNRJE1TyZJNxKbnmdHeIXo+M4NkyYVLqsRSYBYJc1eizv0o6N+ut6pXCN37bEvKuthhqChG+8DgSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4341.namprd15.prod.outlook.com (2603:10b6:a03:380::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 20:21:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1%4]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 20:21:56 +0000
Message-ID: <41375c87-f367-3632-051f-64c8b283737c@meta.com>
Date:   Wed, 12 Jul 2023 13:21:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global
 functions
From:   Yonghong Song <yhs@meta.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>,
        "KE . LI" <like1@oppo.com>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
References: <20230628181926.4102448-1-yhs@fb.com>
 <CAKwvOdm_Cp9dF1yseTXvOOtFMsOPzCBWhfszAt0k5SXXyFyjtw@mail.gmail.com>
 <233802b0-7404-1f79-39ae-385da567f657@meta.com>
Content-Language: en-US
In-Reply-To: <233802b0-7404-1f79-39ae-385da567f657@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edb8ecd-af66-47d3-8769-08db8315a34e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJ/y4HpbsfOWasJvks4mGiJXEdoqLvhAAOuqfMrNOmtLi1fOtkGJVoVYFvbdm+efkRaPnIE4/nueU31jq/tyMDhxfDGyvfDtsn8J+1wv7EkCtR6fy2D8+GQu061srgeXQeNxI7DbRnxqG76wNU8q/j8Yt3DJFLlHPxO3gXwSk4ogJ5e2ewkNqUBwFIipYksXB32oQNE+iptEVa1qI+uFU+HTEzUeZKzTMMOZabdHx/NVO8s1Sqg06jZwYxbJnroV2I87Wrq0zHg76Gvd+3QHkBtdSHngcrUoJ53OtI6sjfnrIlnic0cjYqx+xNntMMX+YxSsY+JYaXt11qtRPrSztchdK0oZ9ce28ip2jT6vBzti3cStcs9bn5UInLIf8Q4KtL2+1Y5gZmeSzzTdr+Lcpz7BbNDCSfzfng3PPjpVbfOiAFWUyCk/VXJjh7d6PGoGXwFE/az8IlkHm6ozpXM09ZUC/ey3EprevkD4+3nPhDl2RySu7ElWSjSvbRV/UUwuITP+CoELx8tZi18E2K5nf4SrVwaQaUjZJg7pqySfyD2ADVmAYkjRePAdKfcmd2ljubyucsjMF0pKtLUunTutVUP3q50jjXreueMLhtArTF2FfoJ7OzBs2CR6XYlA0yE0DfrKuNgcmBZ9ixhTamvUaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(7416002)(4326008)(66946007)(66556008)(66476007)(316002)(2906002)(41300700001)(478600001)(8676002)(8936002)(110136005)(31686004)(54906003)(5660300002)(6666004)(6486002)(6512007)(966005)(53546011)(6506007)(186003)(36756003)(83380400001)(38100700002)(2616005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFIvcnc0a0F2Mml2RVFhSlYxZWdiTDN3RmYzR0ZLM3VISUc4WHRRT0g3TGJW?=
 =?utf-8?B?eWVlY1JkT08xbG1PbkdiMDJwNFlVWnJtM3NaWDdUTzBqU1dyNHFNNjhscWZC?=
 =?utf-8?B?RGp1SnpXZGNQRE5OeUY2cFQwclMyUXdoSGVBTGhiRDF2L0xQQWJEQkdid01y?=
 =?utf-8?B?MEs4V2d3OFRrZ21zTmdwcUR6SEhHcTZzdkpXUGRvdWw2MDJFZFlLbTk2a1pq?=
 =?utf-8?B?WHlEUGl5Q3krT1NGMTVRSlZjeURPZGp3Y2FDVUNQWCtmZW5MQi8vcXc2RENH?=
 =?utf-8?B?YU9GWjNLTDUyZXZWdTdDQVF5azcvTTlHOEdMRVpEM25XcGhPWnhKbVFXZkIw?=
 =?utf-8?B?OFNzMENLeUYrSXROTE5yOE9aZ2JxT3QwV0FpOFhWMzU3S1YzZlRDUnBtRUZi?=
 =?utf-8?B?cGVKMlBmOWdaeVdwZ01DNkhHdFVRM2FRbFEyaElOZ3hzSG5iUzJkUFc2WGlR?=
 =?utf-8?B?cGRyRWN1Y2d3THFiUTlkLys5NE5TNjlNNDhreGdJa29GL09rZHBCM2hWUkt4?=
 =?utf-8?B?WVRyTEhxem5sbHh5eXdKVUhlQVlVT0xpMTE3UFU0bVplbFgxQm1zYkRXQlUz?=
 =?utf-8?B?SnYzdGsvcG9tdmlyYy9xVzFxOE1NeXB3Q2Jmekt6YUFwV0k1RFFQWlhkTHdP?=
 =?utf-8?B?YXdVVEtOaklrSmlYTENoUGprTW5TUmRQMlZPazljaUdWbnNFSWJOY1dHSm9G?=
 =?utf-8?B?RGJTOTBGcHg3MDU0Rmp3bFptSmgwV3M1YjlCbUNVU2R0Yk82ajRpZ0thbWJs?=
 =?utf-8?B?R25kQkRYWXRmVWNVbVY4SGsyTVVFdHQ0eHl3MFVoRUZONU5XSk14RWs1Q0Ey?=
 =?utf-8?B?V25BN0lRNWluUW91YysvbzZFNDgvdGpVVjN5Qkp0cXUxWXc2dHZmOSthTUJI?=
 =?utf-8?B?RTRaWGxZTEs5MUhDMmhGYVJ6L2JxTkVUMzRGRlZQVmNTLy9PNE03ZzVLd2hJ?=
 =?utf-8?B?c1B4aWhCYjk1VFlBbjBuVVJzVlNqMGNrWnd0NHNrMGxrQXZQVEZlK0ora2t4?=
 =?utf-8?B?YlpEM1FTaGtUTWJqTUR4K3lEZktPdGMreVZ2T05jd0tyOUtjNDhuTlh3VW5j?=
 =?utf-8?B?VXdsYTlveS9kV29DTDFOeGYvZk9DNi9aNng0d0dzNEplcitHcERQTHI4Y1Bx?=
 =?utf-8?B?dS9qeVRtZUJtZ2VaWlBCeWxWbUpQMm4ya3I0Q0JmR0pOajY3VnNIRVZ0TGpa?=
 =?utf-8?B?YUJXamtzMUtCeUYyVXh2TFg1TWg0K0FrcytHY0tkdHRUa2NHQ25hWEFjNVRs?=
 =?utf-8?B?eUtVWnFuaGlEUFpPOTk1TEMvTUlER2hqampPdTRUM2M3OUloQS82Vzg1WjJi?=
 =?utf-8?B?aHY0SDdmeUdDSit5RE9KaFIyeGUrMkk2WFBTWk43cWJoOFRwUnpUckltR2ov?=
 =?utf-8?B?RW1kckpadFpJZTBRb3hza0NKZTlGSjNXa3NFQmZOaFBNRzRyU2tVc3dlcDRl?=
 =?utf-8?B?QW1aTkpnSWhlcFB1a25lV2hodW1xbzZtREJCdzRsNXQ4dll4Z2RvNEk3ME1P?=
 =?utf-8?B?K0QwcytSc3FYZi9DS2tweTZPdENHL1kycmcwNC9BWmlCTFJVR2s5ckFxVHZi?=
 =?utf-8?B?NlEyOG9TNDhTZjN5cFRxSGpPVkdVTWlZcmNDUmRwelBtY2lqYStSbzR3aXg3?=
 =?utf-8?B?REo4OER5WWMrdkpYU2MySzZ3dzI1SkoyaW8vRW1SQjRZZmhCQlBGbXZwdU9E?=
 =?utf-8?B?aXd1b2FvaVVLZnVmN0ZublBsY001MTRMVXNBaXZqQ014YVoxTHV6R2h0cDhp?=
 =?utf-8?B?d2t6MXY5S0phbW5qdVpGQkJIZ1dTU1kxRGlGdkZFcXJXeXVzRkdjZ2xPWVhF?=
 =?utf-8?B?K3VBanFmQWJOWXhkcFp6SThkUGtKOUlzeUV0VUpmMmo0eU93QlNJdFNFZ3Ir?=
 =?utf-8?B?Zk1MUVR6TXE4SHZsc3pjaFVVY216d0lRa1ZkcGxJRnpTL3o2SFNkckY1bG9r?=
 =?utf-8?B?aUlWenMza0JPc1UzTllsV1NYcGpieGNKVDVuQlRITFU3Y0NjZkFER2V2VzBr?=
 =?utf-8?B?T1JLeXVEY1M2QTFqcXJzdWREdWtUQXBoNG54d1BLMjE5VGVYbUM0NWNuUW15?=
 =?utf-8?B?SmtTNXhMNHRQTHVpbktFaW5JSTVLVGp0cVFyR1hwSXJhZTBBeUVmMDBjT1gw?=
 =?utf-8?B?NWx0MnJGRGVoV2YrdHdNY0NGc2htaUh5WFlFRG4wWCtuT2NQRExWNzdUSFZR?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edb8ecd-af66-47d3-8769-08db8315a34e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 20:21:56.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTUp7Jh4PbjBpKIl+f6zPwqRoXGtGOr3+Do6rt6CAHbfLmKm0ngtl9CkwbcwfV0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4341
X-Proofpoint-GUID: X49DNP_Ytk07ixz8e1fnHLWQ25l_fRFM
X-Proofpoint-ORIG-GUID: X49DNP_Ytk07ixz8e1fnHLWQ25l_fRFM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_15,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 5:23 PM, Yonghong Song wrote:
> 
> 
> On 7/7/23 3:27 PM, Nick Desaulniers wrote:
>> On Wed, Jun 28, 2023 at 11:19 AM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static 
>>> functions")
>>> stripped all function/variable suffixes started with '.' regardless
>>> of whether those suffixes are generated at LTO mode or not. In fact,
>>> as far as I know, in LTO mode, when a static function/variable is
>>> promoted to the global scope, '.llvm.<...>' suffix is added.
>>>
>>> The existing mechanism breaks live patch for a LTO kernel even if
>>> no <symbol>.llvm.<...> symbols are involved. For example, for the 
>>> following
>>> kernel symbols:
>>>    $ grep bpf_verifier_vlog /proc/kallsyms
>>>    ffffffff81549f60 t bpf_verifier_vlog
>>>    ffffffff8268b430 d bpf_verifier_vlog._entry
>>>    ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>>>    ffffffff82e12a1f d bpf_verifier_vlog.__already_done
>>> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
>>> '__already_done' are static variables used inside 'bpf_verifier_vlog',
>>> so llvm promotes them to file-level static with prefix 
>>> 'bpf_verifier_vlog.'.
>>> Note that the func-level to file-level static function promotion also
>>> happens without LTO.
>>>
>>> Given a symbol name 'bpf_verifier_vlog', with LTO kernel, current 
>>> mechanism will
>>> return 4 symbols to live patch subsystem which current live patching
>>> subsystem cannot handle it. With non-LTO kernel, only one symbol
>>> is returned.
>>>
>>> In [1], we have a lengthy discussion, the suggestion is to separate two
>>> cases:
>>>    (1). new symbols with suffix which are generated regardless of 
>>> whether
>>>         LTO is enabled or not, and
>>>    (2). new symbols with suffix generated only when LTO is enabled.
>>>
>>> The cleanup_symbol_name() should only remove suffixes for case (2).
>>> Case (1) should not be changed so it can work uniformly with or 
>>> without LTO.
>>>
>>> This patch removed LTO-only suffix '.llvm.<...>' so live patching and
>>> tracing should work the same way for non-LTO kernel.
>>> The cleanup_symbol_name() in scripts/kallsyms.c is also changed to 
>>> have the same
>>> filtering pattern so both kernel and kallsyms tool have the same
>>> expectation on the order of symbols.
>>>
>>>   [1] 
>>> https://lore.kernel.org/live-patching/20230615170048.2382735-1-song@kernel.org/T/#u
>>>
>>> Fixes: 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static 
>>> functions")
>>> Reported-by: Song Liu <song@kernel.org>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>
>> Thanks for the patch and improving live patch with LTO.  Looking back
>> at the internal report that resulted in
>> commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static 
>> functions")
>> your version was what I originally had.  I did not leave a comment as
>> to why I changed it when I sent it 2 years ago, and no longer recall
>> the reason.
>>
>>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Nick, thanks for the review. I am not sure how this patch could
> be merged into the mainline. I checked your patch
>     6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
> and it looks like the patch was merged by Kees Cook.
> 
> I added Kees in the 'To' list. Kees, could you help merge
> this patch if you are okay with the change?

Looks like Kees might be on vacation. Nick, Petr, do you
have any suggestions who could take this patch? Thanks!

> 
> Thanks!
> 
> Yonghong
> 
>>
>>> ---
>>>   kernel/kallsyms.c  | 5 ++---
>>>   scripts/kallsyms.c | 6 +++---
>>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> Changelogs:
>>>    v1 -> v2:
>>>      . add 'Reported-by: Song Liu <song@kernel.org>'
>>>      . also fix in scripts/kallsyms.c.
>>>
>>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>>> index 77747391f49b..4874508bb950 100644
>>> --- a/kernel/kallsyms.c
>>> +++ b/kernel/kallsyms.c
>>> @@ -174,11 +174,10 @@ static bool cleanup_symbol_name(char *s)
>>>           * LLVM appends various suffixes for local functions and 
>>> variables that
>>>           * must be promoted to global scope as part of LTO.  This 
>>> can break
>>>           * hooking of static functions with kprobes. '.' is not a valid
>>> -        * character in an identifier in C. Suffixes observed:
>>> +        * character in an identifier in C. Suffixes only in LLVM LTO 
>>> observed:
>>>           * - foo.llvm.[0-9a-f]+
>>> -        * - foo.[0-9a-f]+
>>>           */
>>> -       res = strchr(s, '.');
>>> +       res = strstr(s, ".llvm.");
>>>          if (res) {
>>>                  *res = '\0';
>>>                  return true;
>>> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
>>> index 0d2db41177b2..13af6d0ff845 100644
>>> --- a/scripts/kallsyms.c
>>> +++ b/scripts/kallsyms.c
>>> @@ -346,10 +346,10 @@ static void cleanup_symbol_name(char *s)
>>>           * ASCII[_]   = 5f
>>>           * ASCII[a-z] = 61,7a
>>>           *
>>> -        * As above, replacing '.' with '\0' does not affect the main 
>>> sorting,
>>> -        * but it helps us with subsorting.
>>> +        * As above, replacing the first '.' in ".llvm." with '\0' 
>>> does not
>>> +        * affect the main sorting, but it helps us with subsorting.
>>>           */
>>> -       p = strchr(s, '.');
>>> +       p = strstr(s, ".llvm.");
>>>          if (p)
>>>                  *p = '\0';
>>>   }
>>> -- 
>>> 2.34.1
>>>
>>
>>

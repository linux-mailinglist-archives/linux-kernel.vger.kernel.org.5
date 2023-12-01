Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9998007E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378135AbjLAKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377992AbjLAKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:06:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458A7C7;
        Fri,  1 Dec 2023 02:06:53 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17e3EP010711;
        Fri, 1 Dec 2023 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tUAP8wCFyJh9BD59PB2im9kCmmk+FkPAweHCMGjBBAA=;
 b=L4OYvJMxY0y25H+jtTuhS7h0sWK2U5YQSki6oRr8C3ONybbtOZ6wFxY9GbD0ZHQxlL/p
 0eI2ToF/jOFNYC+fnijq0AqJbpjpKEpmM4Pc/rGW34ATtvaO77TKT7sC26JP9s+dIN5c
 C8ll+0bnc5tYs692NEPUh57S3Q8hwmgn4Qmi6ZUPB/iYOEhih85/ynUWk//+Bnp0lDW8
 tENu6LB5pY0pb3W7Cqis+LgK6myWyTeyre62XnyEebXTWWsNmxvx+xdqrNhrioNWFURw
 wvvGcihktvajBxvhQsJ/RyNztMtOQkz78W54KTAdXYo616q//JnAOvt2g/f3qoDffVQc 3g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq3f7s7hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 10:06:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1A6kOI027353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Dec 2023 10:06:46 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 02:06:44 -0800
Message-ID: <9714f76f-0cf3-4f54-8e0d-fe3ca2990eed@quicinc.com>
Date:   Fri, 1 Dec 2023 18:06:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Pin control fixes for v6.7
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
 <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
 <CACRpkdZRf7bNVmJCgsVD0uheD1VLkLKG13d1oS-kbT8BFyRKQw@mail.gmail.com>
 <e703c87e-32b9-4dce-b232-89c0e909c35e@quicinc.com>
 <CACRpkdZtCxwLZCY4autrTvonmZ3XcVzH6iXqXanS97VKCZ+ERw@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CACRpkdZtCxwLZCY4autrTvonmZ3XcVzH6iXqXanS97VKCZ+ERw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6VN6YwDyKRyki-DpCrDpO4bclbAQUFCp
X-Proofpoint-GUID: 6VN6YwDyKRyki-DpCrDpO4bclbAQUFCp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=964 bulkscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/2023 4:10 PM, Linus Walleij wrote:
> Hi Nathan, Nick,
> 
> (just picking some LLVM compiler people I know of... and trust)
> 
> Context is this patch:
> https://lore.kernel.org/linux-gpio/20231115102824.23727-1-quic_aiquny@quicinc.com/
> 
> On Thu, Nov 30, 2023 at 6:37 AM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>> On 11/29/2023 11:08 PM, Linus Walleij wrote:
>>> On Wed, Nov 29, 2023 at 3:56 PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>> On Wed, 29 Nov 2023 at 04:09, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>
>>>>> The most interesting patch is the list iterator fix in the core by Maria
>>>>> Yu, it took a while for me to realize what was going on there.
>>>>
>>>> That commit message still doesn't explain what the problem was.
>>>>
>>>> Why is p->state volatile there? It seems to be a serious locking bug
>>>> if p->state can randomly change there, and the READ_ONCE() looks like
>>>> a "this hides the problem" rather than an actual real fix.
>>
>> This is indeed an interesting issue. Thx for the comment, Linus.
>> **Let me explain how: "p->state becomes volatile in the list iterator",
>> and "why READ_ONCE is suggested".
>>
>> The current critical code is:
>>     list_for_each_entry(setting, &p->state->settings, node)
>>
>> after elaborating the define list_for_each_entry, so above critical code
>> will be:
>>     for (setting = list_head(&p->state->settings, typeof(*setting), node); \
>> &setting->node != (&p->state->settings); \
>> setting = list_next(setting , node))
>>
>> The asm code(refer result from Clang version 10.0) can cleared explain
>> the step of p->state reload actions:
>> loop:
>> ldr x22,[x22] ; x22=list_next(setting , node))
>> add x9,x8,#0x18 ; x9=&p->state->setting
>> cmp x22,x9 ; setting,x9
>> b.eq 0xFFFFFF9B24483530
>>
>> ldr w9,[x22,#0x10] ; w9,[setting,#16]
>> cmp w9,#0x2 ; w9,#2
>> b.ne 0xFFFFFF9B24483504
>>
>> mov x0,x22 ; x0,setting
>> bl 0xFFFFFF9B24486048 ; pinmux_disable_setting
>>
>> ldr x8,[x19,#0x28] ; x19=p, x8=[p->state], *reload p->state*
>> b loop
>>
>> The *reload p->state* inside the loop for checking is not needed and can
>> cause possible infinite loop. So READ_ONCE is highly suggested even if
>> p->state is not randomly changed. And then unnecessary "ldr
>> x8,[x19,#0x28]" can be removed from above loop code.
>>
>> **Comments about the locking bug:
>> currently pinctrl_select_state is an export symbol and don't have
>> effective reentrance protect design. That's why current infinite loop
>> issue was observed with customer's multi thread call with
>> pinctrl_select_state without lock protection. pinctrl_select_state
>> totally rely on driver module user side to ensure the reentrant state.
>>
>> Usually the suggested usage from driver side who are using pinctrl would be:
>> LOCK;
>> pinctrl_select_state();
>> gpio pulling;
>> udelay();
>> check state;
>> other hardware behaviors;
>> UNLOCK;
>>
>> So the locking bug fix I have told customer side to fix from their own
>> driver part. Since usually not only a simple pinctrl_select_state call
>> can finish the hardware state transaction.
>>
>> I myself also is fine to have a small per pinctrl lock to only protect
>> the current pinctrl_select_state->pinctrl_commit_state reentrance
>> issues. Pls any pinctrl maintainer help to comment to suggest or not and
>> I can prepare a change as well.
> 
> Luckily I am the pin control maintainer :D
> And I also ha my morning coffee and looked over the patch again.
> 
> So tilting the compiler to generate code that is less prone to race
> conditions with READ_ONCE() isn't really the solution is it? We need
> to introduce a proper lock that stops this from happening if it is
> a problem people are facing.
> 
> Can you try to make a patch that removes READ_ONCE()
> and introduce a lock instead?
> 
> Racing is rarely an issue in pin control for reasons explained
> in another context here:
> https://lore.kernel.org/linux-gpio/CACRpkdZ0cnJpYuzU=47-oW-7N_YGMo2vXpKOeXeNi5PhPY7QMA@mail.gmail.com/
> 
> ...but if people still manage to run into it, we better have a lock
> there. Just make sure it is not just an issue with outoftree code,
> but a real problem?
> 
> The change that changes the code to use the old_state variable
> should stay in, it makes the code more readable, it's just the
> READ_ONCE() macro which is dubious.
Thx for confirm. I am preparing the new change now. :)

READ_ONCE can only avoid the possible infinite loop and not crash the 
whole kernel, while the lock is needed to protect the multi parallel 
call of pinctrl_commit_state api have a consistent atomic hardware 
result as well.
> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Aiqun(Maria) Yu


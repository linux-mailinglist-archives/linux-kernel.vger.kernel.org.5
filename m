Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1792A7FE8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbjK3FiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjK3Fh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:37:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1F198;
        Wed, 29 Nov 2023 21:38:02 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AU4rmH0004391;
        Thu, 30 Nov 2023 05:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IQ9Dg6khK07xMiIBzuk7297S9BV6a1vgqK58LceC2J0=;
 b=JuJD0AIy9kdSpuImpU6k2rr8CK+cbVAyuRRQ/tNs4XOLIE1n334jag0BpMgJ+XRbF4G4
 QdczhBW8Hi76mvmq+aqARxHfNVSihOAPiICkl40ayz/dUnwD/q6nEFHUOOxwpjI7q7ay
 NpRdj7do3XWhXlA7Q1uREhLNQ4Fza6dSex/Hu+3FQ/t3dsnbEC9MuHpYHN20u5H0viTw
 m1j4QCLwHl/iU13K9K1yK1bwlbuuxS4lank1+hmurht2S4zs/3Peu5udp7XYGUlpvkfL
 9tpT/Otu3k0mR1zS6Q0XgqLMVZZjkjhmgm6mD7AratuB65vW63TiIjYuoXDSe0G8UEXp bg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up5e8t99b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:37:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU5bt4G004641
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 05:37:55 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 21:37:54 -0800
Message-ID: <e703c87e-32b9-4dce-b232-89c0e909c35e@quicinc.com>
Date:   Thu, 30 Nov 2023 13:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Pin control fixes for v6.7
To:     Linus Walleij <linus.walleij@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chester Lin <clin@suse.com>
References: <CACRpkdZtVNZFWSUgb4=gUE2mQRb=aT_3=zRv1U71Vsq0Mm34eg@mail.gmail.com>
 <CAHk-=whk4oNQazgpzkujc2=ntVQMhU5ko7Canp2Uuq6CpyGzmA@mail.gmail.com>
 <CACRpkdZRf7bNVmJCgsVD0uheD1VLkLKG13d1oS-kbT8BFyRKQw@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CACRpkdZRf7bNVmJCgsVD0uheD1VLkLKG13d1oS-kbT8BFyRKQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Uv19rQtdR-Dh05KVC5dC-5hsS6i6MBx
X-Proofpoint-ORIG-GUID: 3Uv19rQtdR-Dh05KVC5dC-5hsS6i6MBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_03,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=933 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2023 11:08 PM, Linus Walleij wrote:
> On Wed, Nov 29, 2023 at 3:56 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, 29 Nov 2023 at 04:09, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>
>>> The most interesting patch is the list iterator fix in the core by Maria
>>> Yu, it took a while for me to realize what was going on there.
>>
>> That commit message still doesn't explain what the problem was.
>>
>> Why is p->state volatile there? It seems to be a serious locking bug
>> if p->state can randomly change there, and the READ_ONCE() looks like
>> a "this hides the problem" rather than an actual real fix.
This is indeed an interesting issue. Thx for the comment, Linus.
**Let me explain how: "p->state becomes volatile in the list iterator", 
and "why READ_ONCE is suggested".

The current critical code is:
   list_for_each_entry(setting, &p->state->settings, node)

after elaborating the define list_for_each_entry, so above critical code 
will be:
   for (setting = list_head(&p->state->settings, typeof(*setting), node); \
&setting->node != (&p->state->settings); \
setting = list_next(setting , node))

The asm code(refer result from Clang version 10.0) can cleared explain 
the step of p->state reload actions:
loop:
ldr x22,[x22] ; x22=list_next(setting , node))
add x9,x8,#0x18 ; x9=&p->state->setting
cmp x22,x9 ; setting,x9
b.eq 0xFFFFFF9B24483530

ldr w9,[x22,#0x10] ; w9,[setting,#16]
cmp w9,#0x2 ; w9,#2
b.ne 0xFFFFFF9B24483504

mov x0,x22 ; x0,setting
bl 0xFFFFFF9B24486048 ; pinmux_disable_setting

ldr x8,[x19,#0x28] ; x19=p, x8=[p->state], *reload p->state*
b loop

The *reload p->state* inside the loop for checking is not needed and can 
cause possible infinite loop. So READ_ONCE is highly suggested even if 
p->state is not randomly changed. And then unnecessary "ldr 
x8,[x19,#0x28]" can be removed from above loop code.

**Comments about the locking bug:
currently pinctrl_select_state is an export symbol and don't have 
effective reentrance protect design. That's why current infinite loop 
issue was observed with customer's multi thread call with 
pinctrl_select_state without lock protection. pinctrl_select_state 
totally rely on driver module user side to ensure the reentrant state.

Usually the suggested usage from driver side who are using pinctrl would be:
LOCK;
pinctrl_select_state();
gpio pulling;
udelay();
check state;
other hardware behaviors;
UNLOCK;

So the locking bug fix I have told customer side to fix from their own 
driver part. Since usually not only a simple pinctrl_select_state call 
can finish the hardware state transaction.

I myself also is fine to have a small per pinctrl lock to only protect 
the current pinctrl_select_state->pinctrl_commit_state reentrance 
issues. Pls any pinctrl maintainer help to comment to suggest or not and 
I can prepare a change as well.
> 
> Thanks for looking into it Linus, Maria can you look closer at this and
> try to pinpoint exactly what happens? 
Sure, I am trying to explain from my end. If there is other thoughts pls 
feel free to chime in.
> 
> Is the bug never manifesting with GCC for example?
> 
> In the meantime I'll cook a fixes branch without this one commit.
> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Aiqun(Maria) Yu


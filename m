Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F96F7783FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjHJXN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjHJXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:13:28 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98F2690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:13:27 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64189370a63so4480616d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691709207; x=1692314007;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py3LrB1MojN9Q2t6wr+fe06uk+Tis0628n4bR/uEwyM=;
        b=N+pAbOwOSmF3txoS+QlmFeuPQEhKcFVTBKZEh0ZpZtQsXosceQFVYKB6A0hwMyZV0f
         pe1Us7nQEImCPgsqlOCeOmZlIuPM5AlSkjs2kRbxDWvnb9CF0w9GN6F7LaWyCEb4Lj0Y
         OoviF08n58C+POC9jqtliEnc4PFxhUJscMnSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709207; x=1692314007;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py3LrB1MojN9Q2t6wr+fe06uk+Tis0628n4bR/uEwyM=;
        b=Gzz7WPkLjLzpdHMAA6I6NlLitd3MLXIpG8rLYligGrU6E37PABuhhNY4Q2qgybalib
         5PFQ1zA8nOiskqBx+5pApdmlbaE2nDLU333wHqHLrasLL62ua+yANT9J9HYblB1JrfZx
         MrkVTSbbZUi6jcDI6ESCzfBw74NvQiRBlYNSYo2efEXbkd13uTZNRG+IOMilw7g4qDdn
         Ovc/WflDGEMOYivH9tsXnv4w/no2zxnrm1IfeVbXz1iiWHi0Su+Oaz8jGL+k9QuOWPkj
         bYT+iwC0bXwmN99bO4mLB1MKXbU3Rfrxp+8fz2Ap3c/PU9OT/aF72od7iVmkdGHhwKCm
         XAfA==
X-Gm-Message-State: AOJu0YzN0YLzAYB4kjPOry/UhgS/omFR1YxYTFP/9qtCPuNB8XeW/v1Y
        cd4xz8bm+f09YyL6VGnhZOC9cA==
X-Google-Smtp-Source: AGHT+IFXJCmYVsCyFqaIWobn36Jaq8H6Kr7C2eyE60K3klPhT+DWUcg3ramk31+qD1u9fBO18wk6JA==
X-Received: by 2002:a0c:b218:0:b0:63d:4a1:2f82 with SMTP id x24-20020a0cb218000000b0063d04a12f82mr141758qvd.16.1691709206739;
        Thu, 10 Aug 2023 16:13:26 -0700 (PDT)
Received: from smtpclient.apple ([45.85.144.224])
        by smtp.gmail.com with ESMTPSA id i28-20020a0cab5c000000b0063d35954291sm815512qvb.117.2023.08.10.16.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 16:13:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Date:   Thu, 10 Aug 2023 19:13:14 -0400
Message-Id: <C45ECBF0-6573-47BC-B127-0B2BEF3E4425@joelfernandes.org>
References: <3d23da0b-696b-5ace-0ea7-5ac4a38cd46b@roeck-us.net>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
In-Reply-To: <3d23da0b-696b-5ace-0ea7-5ac4a38cd46b@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2023, at 6:55 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> =EF=BB=BFOn 8/10/23 14:54, Joel Fernandes wrote:
>>> On Thu, Aug 10, 2023 at 10:55:16AM -0700, Paul E. McKenney wrote:
>>> On Wed, Aug 09, 2023 at 02:45:44PM -0700, Guenter Roeck wrote:
>>>> On 8/9/23 13:39, Joel Fernandes wrote:
>>>>> On Wed, Aug 9, 2023 at 4:38=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
>>>>>>=20
>>>>>> On 8/9/23 13:14, Joel Fernandes wrote:
>>>>>>> On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
>>>>>>>> On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
>>>>>>>>> On Wed, Aug 9, 2023 at 12:18=E2=80=AFPM Guenter Roeck <linux@roeck=
-us.net> wrote:
>>>>>>>>>>=20
>>>>>>>>>> On 8/9/23 06:53, Joel Fernandes wrote:
>>>>>>>>>>> On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wro=
te:
>>>>>>>>>>>> This is the start of the stable review cycle for the 5.15.126 r=
elease.
>>>>>>>>>>>> There are 92 patches in this series, all will be posted as a re=
sponse
>>>>>>>>>>>> to this one.  If anyone has any issues with these being applied=
, please
>>>>>>>>>>>> let me know.
>>>>>>>>>>>>=20
>>>>>>>>>>>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>>>>>>>>>>>> Anything received after that time might be too late.
>>>>>>>>>>>>=20
>>>>>>>>>>>> The whole patch series can be found in one patch at:
>>>>>>>>>>>>        https://www.kernel.org/pub/linux/kernel/v5.x/stable-revi=
ew/patch-5.15.126-rc1.gz
>>>>>>>>>>>> or in the git tree and branch at:
>>>>>>>>>>>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/lin=
ux-stable-rc.git linux-5.15.y
>>>>>>>>>>>> and the diffstat can be found below.
>>>>>>>>>>>=20
>>>>>>>>>>> Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture=
 scenarios
>>>>>>>>>>> hang with this -rc: TREE04, TREE07, TASKS03.
>>>>>>>>>>>=20
>>>>>>>>>>> 5.15 has a known stop machine issue where it hangs after 1.5 hou=
rs with cpu
>>>>>>>>>>> hotplug rcutorture testing. Me and tglx are continuing to debug t=
his. The
>>>>>>>>>>> issue does not show up on anything but 5.15 stable kernels and n=
either on
>>>>>>>>>>> mainline.
>>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> Do you by any have a crash pattern that we could possibly use to f=
ind the crash
>>>>>>>>>> in ChromeOS crash logs ? No idea if that would help, but it could=
 provide some
>>>>>>>>>> additional data points.
>>>>>>>>>=20
>>>>>>>>> The pattern shows as a hard hang, the system is unresponsive and a=
ll CPUs
>>>>>>>>> are stuck in stop_machine. Sometimes it recovers on its own from t=
he
>>>>>>>>> hang and then RCU immediately gives stall warnings. It takes 1.5 h=
our
>>>>>>>>> to reproduce and sometimes never happens for several hours.
>>>>>>>>>=20
>>>>>>>>> It appears related to CPU hotplug since gdb showed me most of the C=
PUs
>>>>>>>>> are spinning in multi_cpu_stop() / stop machine after the hang.
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Hmm, we do see lots of soft lockups with multi_cpu_stop() in the ba=
cktrace,
>>>>>>>> but not with v5.15.y but with v5.4.y. The actual hang is in stop_ma=
chine_yield().
>>>>>>>=20
>>>>>>> Interesting. It looks similar as far as the stack dump in gdb goes, h=
ere are
>>>>>>> the stacks I dumped with the hang I referred to:
>>>>>>> https://paste.debian.net/1288308/
>>>>>>>=20
>>>>>>=20
>>>>>> That link gives me "Entry not found".
>>>>>=20
>>>>> Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1k=
H2
>>>>=20
>>>> I found a couple of crash reports from chromeos-5.10, one of them compl=
aining
>>>> about RCU issues. I sent you links via IM. Nothing from 5.15 or later, t=
hough.
>>>=20
>>> Is the crash showing the eternally refiring timer fixed by this commit?
>>>=20
>>> 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ e=
ntry")
>> Ah I was just replying, I have been seeing really good results after appl=
ying
>> the following 3 commits since yesterday:
>> 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ e=
ntry")
>> 5417ddc1cf1f ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res hand=
ler when the tick is stopped")
>> a1ff03cd6fb9 ("tick: Detect and fix jiffies update stall")
>=20
> Would those also apply to v5.10.y, or just 5.15.y ?

All apply to 5.10 but one. I am currently testing with it more and will post=
 to stable for 5.10 as well.

Thanks,

 - Joel



>=20
> Thanks,
> Guenter
>=20
>> 5417ddc1cf1f also mentioned a "tick storm" which is exactly what I was
>> seeing.
>> I did a lengthy test and everything is looking good. I'll send these out t=
o
>> the stable list.
>> thanks,
>>  - Joel
>=20

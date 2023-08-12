Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509B77A03B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjHLOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHLOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:02:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82D198B;
        Sat, 12 Aug 2023 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691848930; x=1692453730; i=deller@gmx.de;
 bh=AeSNKvyEnVBzyAV9VKdJ3kwSqc+TTxTkUDwOevXtomQ=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=s4PEtfYcBS6SI68lpLAq85GfaoEwbXqXeMYlbtLmDYm3qn7SNNgfCG7ukd6Xa1muRL5dISV
 gsRQC1XSUMlpvrnCjyT8DZOSEAhTA+h9FAVmNcx8LORU+00/1UEwknXL6X7MSgZmAgD8aBJhg
 wJOsfj6yYn0gUUM456UYZ1laCtlsbcdrutdt8DOG3jRxxWKpyauCOrWkGIlr64d+J4ObCtut7
 YZAx6LnRxtn9xo5HNwLiW9ikBpiq01Zgu6J0d7bLDGbWobbCwRat4bxR/9DbSQT28dIA1DXaz
 s9QeERhSNP6jGFweOz60axD1IyCawYIQbij2GAR6R03CAHSnJXBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZTqW-1qG4G42aOc-00WW9C; Sat, 12
 Aug 2023 16:02:10 +0200
Message-ID: <1210dbf6-8bfe-9ea5-ba31-77c99e170817@gmx.de>
Date:   Sat, 12 Aug 2023 16:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] init: Add lockdep annotation to kthreadd_done completer
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
References: <ZNZcBkiVkm87+Tvr@p100>
 <20230811094359.ae44c1081b52f69baad8e651@linux-foundation.org>
 <180865b8-cba9-5676-ca7f-0865005f8af5@gmx.de>
In-Reply-To: <180865b8-cba9-5676-ca7f-0865005f8af5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZ66bV7hRgLmWiA4BxA/MZuuqGqx5CejM8Sq4eeQZfjZrRenAct
 hDw/WhVLhvJw+UEDCWMoT8xatoyaluwuNbkWbhdlAy/dsGmSzsduekmquiAb5KVLrJ9Ksal
 HtVPoy8MYU8lwncburHlV3VrTTdM9vmrdSLuOJKGLSBXJR2qCJu5/BSZfiIcNL4MMBRqVvD
 q/IMKDmZE+qih3j9PQRJg==
UI-OutboundReport: notjunk:1;M01:P0:ydNhk0s+2Hc=;Fx7ZQII5phYAWhJH28MjwsYuMsL
 DVRM3Qft+h/UexPXpqKcmT9iOQryAKP0rJ8UAU597aJJFPkcph4ChUkMJOdnO21l3nj39umUn
 ao53v12e5w+6/WM/G5lXzjLHnZIS+mqGMVy79nY7F1g+bQMAKWl5P3VbfWnhvnH4mK7I2VdPs
 ycIsSm+ZURUnBP5KK0i8ytbiK0FuoCO8SFO2KyB7lpv72COeAhbABB1FdT9KEJe7ByfW3Wr1r
 YjP4Sqmu/fbfgOmBncuSSENT1NEKoYqZZbbzrTPciJIp6AO5FQjgTJgNW+nrGTDjb2NZH6ZdP
 dbr/JD1BbQKg8ONG0fes4BMopjnJjWQUN/1jGl/FApJXOtobW2NjHF+d9DuH3Q4sPQmVivy3b
 JTdlgZzhhR3ogx5aOaSSZO/MpQB1I4RpUQmSlfz7xVC20zLzMD8ASMAI8hYRRiJB5De+3of2P
 U4bNS8nff1LfBXvGP0jLwsvmKKtz5iKDvTnfH2UcV4da/qIFXkD0pxNY+kFP+sBh+V8gp/Ah9
 lsz3fxWyWphf8lcUJr2gtCw28Z7b913a1KIeV/I/yLUoEOY8Pa9nUGFmzaYCmYluVo1y6Bchh
 SXtO3ZdXTt6TspsMTdJXHNc8cVLOJSMnVoUV58OeLhtYaViqGeboBIKX6Y2o+N9W9ojMmOPry
 7/N1F2hRTXPX5Y0yygJ0uZ0SzOOzFJzB6a6CLrz/nrH4yWIouJ0ztCbZigHBFiUNsZjkn8fvg
 yE2s9GfS529NqypKyi2K75qO6rRugJxjJA8ZQ6ZoTQUdHhQX/21FbOHGkwZM9+oWFt7U3QN48
 bdoTenpKUc9Kz78fErvs1PevNAB6On4rHPO2/D9wxdytKYa5abNeeWSULkCEGuRiu2jn7xrSF
 4F/WAZ8mhgIfAfH+Za1gdATthywrrv6hhb0bEbaAEYq1cPryTOep44zxTZtcmjKqwFfkXhzTp
 r//2rtsbHs9D1SueFV0q/rCGtHk=
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 8/11/23 19:44, Helge Deller wrote:
> On 8/11/23 18:43, Andrew Morton wrote:
>> On Fri, 11 Aug 2023 18:04:22 +0200 Helge Deller <deller@gmx.de> wrote:
>>
>>> Add the missing lockdep annotation to avoid this warning:
>>>
>>> =C2=A0 INFO: trying to register non-static key.
>>> =C2=A0 The code is fine but needs lockdep annotation, or maybe
>>> =C2=A0 you didn't initialize this object before use?
>>> =C2=A0 turning off the locking correctness validator.
>>> =C2=A0 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #681
>>> =C2=A0 Hardware name: 9000/785/C3700
>>> =C2=A0 Backtrace:
>>> =C2=A0=C2=A0 [<000000004030bcd0>] show_stack+0x74/0xb0
>>> =C2=A0=C2=A0 [<0000000041469c7c>] dump_stack_lvl+0x104/0x180
>>> =C2=A0=C2=A0 [<0000000041469d2c>] dump_stack+0x34/0x48
>>> =C2=A0=C2=A0 [<000000004040e5b4>] register_lock_class+0xd24/0xd30
>>> =C2=A0=C2=A0 [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
>>> =C2=A0=C2=A0 [<000000004040cd60>] lock_acquire+0x130/0x298
>>> =C2=A0=C2=A0 [<000000004146df54>] _raw_spin_lock_irq+0x60/0xb8
>>> =C2=A0=C2=A0 [<0000000041472044>] wait_for_completion+0xa0/0x2d0
>>> =C2=A0=C2=A0 [<000000004146b544>] kernel_init+0x48/0x3a8
>>> =C2=A0=C2=A0 [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
>>>
>>> ...
>>>
>>> --- a/init/main.c
>>> +++ b/init/main.c
>>> @@ -682,6 +682,8 @@ noinline void __ref __noreturn rest_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct task_struct *tsk;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int pid;
>>>
>>> +=C2=A0=C2=A0=C2=A0 init_completion(&kthreadd_done);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_scheduler_starting();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We need to spawn init first so =
that it obtains pid 1, however
>>
>> This is pretty old code, as is the page_alloc_init_late() change.=C2=A0=
 Do
>> we know why this warning has just turned up lately?

[dropped Helge's assumptions that it's related to parisc's unusual
__ARCH_SPIN_LOCK_UNLOCKED_VAL value. It turned out to be wrong.

Now I was able to trace down why I see those lockdep warnings on parisc.
The short answer is:
On parisc the _initdata section lies outside of the usual kernel
_stext ... _end range. Lockdep calls static_obj() which currently assumes
that __initdata is inside that range and thus returns "false".
That's why lockdep then reports
	INFO: trying to register non-static key.
which is wrong.

Please drop those 3 lockdep patches from your mm-queue:

mm-add-lockdep-annotation-to-pgdat_init_all_done_comp-completer.patch
init-add-lockdep-annotation-to-kthreadd_done-completer.patch
watchdog-fix-lockdep-warning.patch

I'll send one single patch which fixes static_obj() instead.

Thanks,
Helge

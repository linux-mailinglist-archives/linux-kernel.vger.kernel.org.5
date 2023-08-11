Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D26779666
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjHKRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjHKRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:44:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6E30E2;
        Fri, 11 Aug 2023 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691775884; x=1692380684; i=deller@gmx.de;
 bh=ZdL5MMAkWuiuhnJ2ligepk1HZ1QYDFmdvB9VvduSOe8=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=cNwFYL8cjpG4C5w/PUqSSEwl91EB0D0J/qLhdpKcjPu/szAuRw0BKLsQtbeM8FCljchgwwn
 2gUgoD9tcEGv1cHqv5KF/hzP0c9psX14abipaqPh4tUNn/FDhd4VeMpTfDPDtuXsSQ+CQop2k
 4Hr9vg7EEzDCKgy4xgWY/6hYPjb+pzlKBuech/aQi19FGHVRC7pUMrZgh70krwEQ+Mhkw6Kmu
 k1tVmDbSEvOhNWBZrH8PpI58E1HmdZToR/M5k+GlnZ25CCcUOPzm1ImIIWPPBgqfs9ITjrrAC
 rw3F0g1HHmo2OVetX+ZVsLnrJREHX6lqQkDPDHF+iDI8z95tTxvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.87]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1qTQG816vc-00186b; Fri, 11
 Aug 2023 19:44:44 +0200
Message-ID: <180865b8-cba9-5676-ca7f-0865005f8af5@gmx.de>
Date:   Fri, 11 Aug 2023 19:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
References: <ZNZcBkiVkm87+Tvr@p100>
 <20230811094359.ae44c1081b52f69baad8e651@linux-foundation.org>
From:   Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] init: Add lockdep annotation to kthreadd_done completer
In-Reply-To: <20230811094359.ae44c1081b52f69baad8e651@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QBV+V8CSHYmtbcv4vmczYhavc1aYMJqa5jRIubehnZpjzNL5jeL
 ts1VNaBTBMyuNRgLbFdjPiNHmEoQgW7y139Cc/MHLfn/Os2sZEwlf+CRcOZxfBykw42JlLA
 LSnNFgokk8na0GBbFSm8/s+mHHHGqH+LYF/OiPlLCjRxwMF3lrxKEU/UDmneu394gfIbw66
 34pfaVTWJSZpgJ1oRRNSQ==
UI-OutboundReport: notjunk:1;M01:P0:xep/wim5jkc=;aAJ6n5Xap+XnwGrRk592KMsAnaa
 0ZrlJgItK+fvwSkjKDR7NSAw56wAo9L5AXkMmenSJAb13ZfLI2C5ZNNMcChhZUFrXmQwrYTuv
 k3FPqRQnbb+kSTotwE9jLhU0OQQierpUfEbeoDeW5t4yjFxjK0nZdjSQd2DALpwGUm2AP5TdT
 9l2PuiUzYR8UGmPAKh6vp4sNW21t/pfBnnhWYk9YiCm9XQy1ZW0J/kGJ6JFz3UGloDOefnlnc
 hxG8couOdM9ygeTw+6Vpha2jkIIRrf8mbeNkoM3VGxt607deCsD03xbegM7GegPAWMlPtd4wO
 MFjb9+H4mAH9KlfulvQUM06lIWQ71dJoUeBbIFRri19K+CcXicZD/pbcfiAzz+il3uv41qiqe
 gbWsDF3nx3NKpdq3F3JoW0pUXbQXQQlZQmArE5j+qNJuNsOCsEKZu55UbKhfZ7MyclrOm8NVb
 NBY9asmlL/KCHq8Dt+08t8jQTUbnvZVf0w/jlB08WE7yftJHnJbDXUpqy3jrIQhwQydIQEboO
 /ail2Cx1TSeiJD+md/0PlJLyymtQoaOZEYqUGkaQV/sADutMT/l0hCbMgub258X/UgXgezkdc
 IKZ3VrVT5cgHKymRu/g60GWAlPHdJ7GbcpA/BqCUfik/LXMA0U7bpjhukmnZ/o4xm1Bg6gHAd
 GBv05u0666KSqdWY+wAAti5GoxeYtAuaofDZsRhyiKWzPVG+WTKM6NUycxJlQdnAiSE0XH50B
 gnigI9QE4yfXTy13D7q8sPwb740ySSI81Rq6JYpuBKMTy8K0TllkfSizBMQqypJbu/yU4em5r
 H9yz+PgWdHSGvJmouJKeUJjHXqas739voxb+BjA2+4+7r5E7qP+BXRkmimFSqMQr0RyTxtzSO
 DK82ZvBw9gYsiv99TdaXoVPJWRvGR9dwDXgYz6rDbQPyiYOzKO7gDS+RmDZbrn6HZD+BQiga1
 bY4wirtMeq/3DV35FaGDEgcrYa8=
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

On 8/11/23 18:43, Andrew Morton wrote:
> On Fri, 11 Aug 2023 18:04:22 +0200 Helge Deller <deller@gmx.de> wrote:
>
>> Add the missing lockdep annotation to avoid this warning:
>>
>>   INFO: trying to register non-static key.
>>   The code is fine but needs lockdep annotation, or maybe
>>   you didn't initialize this object before use?
>>   turning off the locking correctness validator.
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5+ #681
>>   Hardware name: 9000/785/C3700
>>   Backtrace:
>>    [<000000004030bcd0>] show_stack+0x74/0xb0
>>    [<0000000041469c7c>] dump_stack_lvl+0x104/0x180
>>    [<0000000041469d2c>] dump_stack+0x34/0x48
>>    [<000000004040e5b4>] register_lock_class+0xd24/0xd30
>>    [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
>>    [<000000004040cd60>] lock_acquire+0x130/0x298
>>    [<000000004146df54>] _raw_spin_lock_irq+0x60/0xb8
>>    [<0000000041472044>] wait_for_completion+0xa0/0x2d0
>>    [<000000004146b544>] kernel_init+0x48/0x3a8
>>    [<0000000040302020>] ret_from_kernel_thread+0x20/0x28
>>
>> ...
>>
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -682,6 +682,8 @@ noinline void __ref __noreturn rest_init(void)
>>   	struct task_struct *tsk;
>>   	int pid;
>>
>> +	init_completion(&kthreadd_done);
>> +
>>   	rcu_scheduler_starting();
>>   	/*
>>   	 * We need to spawn init first so that it obtains pid 1, however
>
> This is pretty old code, as is the page_alloc_init_late() change.  Do
> we know why this warning has just turned up lately?

I haven't debugged in depth yet, but here is what I believe is the reason
why I do see those lockdep warnings and others not.

I'm building & testing on the parisc platform.
Just recently I added lockdep support to parisc for kernel 6.4 and backpor=
ted
it to v6.0+. Since then I've seen the warnings.

And I think the main reason why I see those warnings on parisc and
others on other platforms don't, is that parisc is the only architecture
where __ARCH_SPIN_LOCK_UNLOCKED_VAL is NOT zero (0x1a46 actually).
The reason is that parisc offers only one assembler instruction which
operates atomicly on memory, and which we use to lock spinlocks:
ldcw ("load and clear word").
So, a "zero" spinlock word means the lock is locked, while non-zero means
it's unlocked.
For other platforms it's the other way around.

So, for a structure in e.g. __initdata[] which is pre-initialized by the c=
ompiler,
the spinlocks are locked by default (lockword =3D 0) on parisc, if they ha=
ven't
been initialized correctly, and thus the kernel will complain at runtime.

Now, maybe lockdep doesn't use spinlocks per se. I have't checked in depth=
 yet,
but I'm sure it's somehow related to the odd __ARCH_SPIN_LOCK_UNLOCKED_VAL=
 value
of parisc.

I wonder if the same bug appears if you use a non-zero __ARCH_SPIN_LOCK_UN=
LOCKED_VAL
on other platforms too (if it's possible).

> I'll add cc:stable to these, but might take that away again if we can
> answer the above.

Thanks for adding the patches.
I did sent two other patches as well: for watchdog and devtmpfs..

> btw, please don't forget the "^---$" between changelog and patch.

Ok.

Helge

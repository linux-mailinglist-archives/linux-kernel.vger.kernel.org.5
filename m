Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54D79D78B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjILRaI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjILRaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:30:06 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F65510F6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:30:02 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:47822)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg7D6-00DEsK-2D; Tue, 12 Sep 2023 11:30:00 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49320 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg7D4-00GZkw-Ow; Tue, 12 Sep 2023 11:29:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <CAAhV-H7D85NTS+8VP6ELiiMVrFkarhjBFbHERLbA9azaK9=XcQ@mail.gmail.com>
        (Huacai Chen's message of "Tue, 12 Sep 2023 23:31:12 +0800")
References: <20230615121016.3731983-1-chenhuacai@loongson.cn>
        <CAAhV-H49AyrG-sH2SXLNg_cX-Wv8vS4Qno_2N4v6ccGGciv-+A@mail.gmail.com>
        <ZJ9kWqhRCWkLcYyv@bombadil.infradead.org>
        <CAAhV-H7qk8wSFt=ZMUSUt4cAmH+-5AsGqszXNW9w+u6Y8vDN+A@mail.gmail.com>
        <CAAhV-H7RgkZJ2hfmNmJXKqcYeE1q11V4-2Ni0j-FLJ0b5fc=Sg@mail.gmail.com>
        <CAAhV-H5pwHQTQ6wGXC2NELHmC4JM8rQUViR3RJj8hQLBygb00w@mail.gmail.com>
        <87cyyo9moz.fsf@email.froward.int.ebiederm.org>
        <CAAhV-H7D85NTS+8VP6ELiiMVrFkarhjBFbHERLbA9azaK9=XcQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 12 Sep 2023 12:29:37 -0500
Message-ID: <87a5tr1eri.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qg7D4-00GZkw-Ow;;;mid=<87a5tr1eri.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/VRuXmD+cQvfb6998nbgH8mw/DVUFjwqY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_Unicode shortcircuit=no
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4725]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Huacai Chen <chenhuacai@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 661 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 0.96 (0.1%),
         extract_message_metadata: 12 (1.9%), get_uri_detail_list: 2.9 (0.4%),
        tests_pri_-2000: 11 (1.6%), tests_pri_-1000: 2.2 (0.3%),
        tests_pri_-950: 1.04 (0.2%), tests_pri_-900: 0.83 (0.1%),
        tests_pri_-200: 0.70 (0.1%), tests_pri_-100: 3.3 (0.5%),
        tests_pri_-90: 139 (21.1%), check_bayes: 134 (20.2%), b_tokenize: 9
        (1.4%), b_tok_get_all: 73 (11.0%), b_comp_prob: 6 (0.9%),
        b_tok_touch_all: 42 (6.3%), b_finish: 1.20 (0.2%), tests_pri_0: 451
        (68.1%), check_dkim_signature: 0.78 (0.1%), check_dkim_adsp: 3.4
        (0.5%), poll_dns_idle: 1.09 (0.2%), tests_pri_10: 4.7 (0.7%),
        tests_pri_500: 21 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai Chen <chenhuacai@kernel.org> writes:

> Hi, Eric,
>
> On Tue, Sep 12, 2023 at 9:59 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Huacai Chen <chenhuacai@kernel.org> writes:
>>
>> > Hi, all,
>> >
>> > Friendly ping again?
>> >
>> >
>> > Huacai
>> >
>> > On Sun, Jul 23, 2023 at 10:13 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>> >>
>> >> Hi, Eric,
>> >>
>> >> On Tue, Jul 18, 2023 at 8:43 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>> >> >
>> >> > Hi, Luis,
>> >> >
>> >> > On Sat, Jul 1, 2023 at 7:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> >> > >
>> >> > > On Sun, Jun 25, 2023 at 04:55:33PM +0800, Huacai Chen wrote:
>> >> > > > Friendly ping?
>> >> > >
>> >> > > You want to cc the folks who Nacked your patch. Until then, this
>> >> > > probably can't go further.
>> >> > Thank you very much. Eric and Andrew are already in the CC list, so
>> >> > add Thomas now.
>> >> >
>> >> > My brain is a little old-fashioned so I insisted that "a thread
>> >> > without mm_struct should be a kernel thread" in the previous patch.
>> >> > Unfortunately this makes Eric and Thomas unhappy, I'm very sorry for
>> >> > that.
>> >> >
>> >> > During the discussion of the previous patch I know I made some
>> >> > mistakes about some basic concepts, but I also found the name
>> >> > "user_mode_thread()" is somewhat confusing. I think rename it to
>> >> > kmuser_thread() is better, because:
>> >> > 1, it identify init and umh as user threads;
>> >> > 2, it points out that init and umh are special user threads that run
>> >> > in kernel mode before loading a user program.
>> >> >
>> >> > Sorry for my rudeness again.
>> >> Excuse me, but could you please tell me what your opinion is. In my
>> >> opinion a typical user thread is created by
>> >> pthread_create()/sys_clone(), it is better to distinguish typical user
>> >> threads from init and umh.
>>
>> If we want to emphasize that it is a kernel concept I am happy with
>> renaming user_mode_thread to user_mode_task.  That is more accurate.
>>
>> But all threads from the kernel perspective are tasks.  Further
>> all threads have times when they run code in the kernel (aka system
>> calls) and times when they run code in userspace.
>>
>> Linux kernel tasks created with user_mode_thread() are exactly like
>> other user mode tasks, and have all treated exactly the same was by the
>> system as any the tasks created by pthread_create() and sys_clone().
>>
>> The only oddity is that there is no user mode code to execute until
>> after execve is called.
>>
>> When running code in the kernel, user space threads never logically
>> do not use the user space page tables.
>>
>> They are different in some significant ways from tasks created with
>> kernel_thread().  Tasks created with kernel_thread do not support
>> calling execve, among other things.
>>
>> But deeply and fundamentally I think you are trying to make a
>> distinction that is not there.  All user space threads run code
>> in the kernel before they run code in userspace.  Most often
>> it is from the system calls fork/clone/exec.  For init and umh it
>> is effectively a special dedicated system call that includes
>> an execve.
>>
>> Let me ask what difference are you trying to high light that callers
>> of user_mode_thread need to be aware of?  What problem in thinking
>> do you think that the name user_mode_thread creates?  I am asking
>> because I might just be missing your point.
> 1, My first key point is “intuition”, by intuition
> sys_clone()/pthread_create() creates a user thread, but init and umh
> are more or less different (special user thread).

My point is the entire point of the name is to point out your intuition
is probably wrong in this context.

> 2, My second key point is "symmetry", for symmetry ‘kernel_thread’ is
> a counterpart of ‘user_thread’, while ‘user_mode_thread’ is a
> counterpart of ‘kernel_mode_thread’. If we keep the ‘kernel_thread’
> name, then we can only rename the ‘user_mode_thread’.

Frankly they could just as well be named user_mode_process,
and user_mode_task.  All are equally accurate.

kernel_thread is a bit different.  Strictly speaking they are all
processes that share the same address space.  But because they
all share the same address space and userspace can't touch them
thread is a perfectly adequate term.

> As discussed
> before, init and umh are user threads, but they are special user
> threads run in kernel mode before kernel_execve, so I want to rename
> it to ‘user_thread’ with a 'km' prefix, so ‘kmuser_thread’.

My deep and fundamental question to you is what technically makes umh
and init special?

What are you trying to point out to the rest of us with an improved
name?

I want to point out that people need to treat umh and init as user space
processes, and very much not as kernel threads.  That none of the
kernel_thread infrastructure works on them.

Eric

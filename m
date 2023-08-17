Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADA77EFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbjHQEif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348012AbjHQEiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:38:24 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74A610E6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:38:23 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59270)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWUm6-00BWSz-1C; Wed, 16 Aug 2023 22:38:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48170 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWUm4-00BuI6-WB; Wed, 16 Aug 2023 22:38:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Petr Skocik <pskocik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
        <878rai7u0l.fsf@email.froward.int.ebiederm.org>
        <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
        <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
        <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
        <20230814140652.GA30596@redhat.com> <20230814154351.GA4203@redhat.com>
        <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
        <20230815151149.GA29072@redhat.com>
        <87fs4ig23p.fsf@email.froward.int.ebiederm.org>
        <20230816210634.GA10130@redhat.com>
        <87r0o2cs8w.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 16 Aug 2023 23:37:37 -0500
In-Reply-To: <87r0o2cs8w.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 16 Aug 2023 21:33:35 -0500")
Message-ID: <871qg28esu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qWUm4-00BuI6-WB;;;mid=<871qg28esu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+vKokMd1zDk4qATdXV830GJq8ifxuY9VI=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 414 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.9%), b_tie_ro: 10 (2.5%), parse: 1.23
        (0.3%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.95
        (0.5%), tests_pri_-2000: 12 (2.8%), tests_pri_-1000: 2.5 (0.6%),
        tests_pri_-950: 1.22 (0.3%), tests_pri_-900: 1.04 (0.3%),
        tests_pri_-200: 0.85 (0.2%), tests_pri_-100: 3.4 (0.8%),
        tests_pri_-90: 130 (31.3%), check_bayes: 125 (30.2%), b_tokenize: 7
        (1.6%), b_tok_get_all: 6 (1.5%), b_comp_prob: 2.2 (0.5%),
        b_tok_touch_all: 106 (25.6%), b_finish: 1.07 (0.3%), tests_pri_0: 221
        (53.3%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 3.0
        (0.7%), poll_dns_idle: 1.21 (0.3%), tests_pri_10: 3.2 (0.8%),
        tests_pri_500: 9 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Fix the error return of kill -1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Oleg Nesterov <oleg@redhat.com> writes:
>
>> On 08/16, Eric W. Biederman wrote:
>>>
>>> Oleg Nesterov <oleg@redhat.com> writes:
>>>
>>> > On 08/15, David Laight wrote:
>>> >>
>>> >> or maybe even:
>>> >> 	} else {
>>> >> 		struct task_struct * p;
>>> >> 		int err;
>>> >> 		ret = -ESRCH;
>>> >>
>>> >> 		for_each_process(p) {
>>> >> 			if (task_pid_vnr(p) > 1 &&
>>> >> 					!same_thread_group(p, current)) {
>>> >> 				err = group_send_sig_info(sig, info, p,
>>> >> 							  PIDTYPE_MAX);
>>> >> 				if (ret)
>>> >> 					ret = err;
>>> >
>>> > Hmm, indeed ;)
>>> >
>>> > and "err" can be declared inside the loop.
>>>
>>> We can't remove the success case, from my posted patch.
>>>
>>> A signal is considered as successfully delivered if at least
>>> one process receives it.
>>
>> Yes.
>>
>> Initially ret = -ESRCH.
>>
>> Once group_send_sig_info() succeeds at least once (returns zero)
>> ret becomes 0.
>>
>> After that
>>
>> 	if (ret)
>> 		ret = err;
>>
>> has no effect.
>>
>> So if a signal is successfully delivered at least once the code
>> above returns zero.
>
> Point.
>
> We should be consistent and ensure  __kill_pgrp_info uses
> the same code pattern, otherwise it will be difficult to
> see they use the same logic.
>
> Does "if (ret) ret = err;" generate better code than "success |= !err"?
>

I just looked at the assembly output and at least on x86 with cmov
"if (ret) ret = err;" generates the better assembly even in
the inner loop.

> I think for both patterns the reader of the code is going to have to
> stop and think about what is going on to understand the logic.
>
> We should probably do something like:
>
> 	/* 0 for success or the last error */
> 	if (ret)
>         	ret = err;
>

Even with that comment it feels awkward to me.

Does anyone have any idea how to make that idiom more obvious
what is happening?

Eric


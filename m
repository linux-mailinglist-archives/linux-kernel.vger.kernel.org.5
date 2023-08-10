Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8B777DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjHJQRW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Aug 2023 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbjHJQRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:17:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BBBE7F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:17:19 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59948)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qU8Ld-000s5c-Ee; Thu, 10 Aug 2023 10:17:17 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:52834 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qU8Lb-000sjS-U8; Thu, 10 Aug 2023 10:17:17 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
        <202211220913.AF86992@keescook>
        <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
Date:   Thu, 10 Aug 2023 11:16:10 -0500
In-Reply-To: <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com> (Petr Skocik's
        message of "Wed, 9 Aug 2023 14:27:27 +0200")
Message-ID: <878rai7u0l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qU8Lb-000sjS-U8;;;mid=<878rai7u0l.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19xvo/WCv+oBLqmecjrU04+eLNmP3M3hRc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Petr Skocik <pskocik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 935 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.5%), b_tie_ro: 3.2 (0.3%), parse: 1.38
        (0.1%), extract_message_metadata: 6 (0.6%), get_uri_detail_list: 3.1
        (0.3%), tests_pri_-2000: 3.6 (0.4%), tests_pri_-1000: 1.98 (0.2%),
        tests_pri_-950: 1.05 (0.1%), tests_pri_-900: 0.83 (0.1%),
        tests_pri_-200: 0.71 (0.1%), tests_pri_-100: 4.4 (0.5%),
        tests_pri_-90: 73 (7.8%), check_bayes: 71 (7.6%), b_tokenize: 9 (1.0%),
         b_tok_get_all: 12 (1.2%), b_comp_prob: 2.5 (0.3%), b_tok_touch_all:
        45 (4.8%), b_finish: 0.76 (0.1%), tests_pri_0: 381 (40.7%),
        check_dkim_signature: 0.45 (0.0%), check_dkim_adsp: 3.5 (0.4%),
        poll_dns_idle: 439 (46.9%), tests_pri_10: 1.77 (0.2%), tests_pri_500:
        447 (47.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Skocik <pskocik@gmail.com> writes:

> Hi.
>
> Is there anything else I can do to help get this (or some other equivalent
> change that results in kill(-1,s) returning -ESRCH when it has nothing to kill
> (like it does on the BSDs),
> as opposed to the current return value of 0 in that case) incorporated into
> mainline Linux?

I think you are talking about a rare enough case that we can safely
change the error handling behavior  without real risk of trouble.

I think there is room for cleanup here.

I don't think we can change the set of processes signaled.  The linux
man page should be updated to note that we skip sending a signal
to ourselves in the event of -1.

Reading the code the error handling logic is dubious.

POSIX provides some guidance it says:

If pid is -1, sig shall be sent to all processes (excluding an
unspecified set of system processes) for which the process has
permission to send that signal.

[EINVAL]
    The value of the sig argument is an invalid or unsupported signal number.
[EPERM]
    The process does not have permission to send the signal to any receiving process.
[ESRCH]
    No process or process group can be found corresponding to that specified by pid. 

>                 if (err != -EPERM)
>                     ret = err; /*either all 0 or all -EINVAL*/

The comment in your proposed patch is wrong:
  -EAGAIN an be returned in the case of real time signals.
  -ENOMEM can be returned due to linux audit.
  -EINVAL can be returned, but arguably it should be caught
          before we even go into the loop.

Given that the comment is wrong I don't like what you have done with the
error handling logic.  It just adds confusion.

My question: What would a good and carefully implemented version
of kill(2) return?

Today for -pgrp we return 0 if any signal delivery succeeds and
the error from the last process in the signal group otherwise.

For -1 we return -EINVAL if the signal is invalid.
For -1 we return -ESRCH only if we are the init process and
there are no other processes in the system, aka never except
when we are the init process in a pid namespace.
For -1 otherwise we return the return value of the last
process signaled.

I would argue that what needs to happen for -1 is:
- Return 0 if the signal was sent to any process successfully.
- Return -EINVAL for invalid signals.
- When everything errors return some error value and not 0.

What error value should we return when everything errors?
Especially what error value should we return when everything
says -EPERM?

Should we follow BSD and return ESRCH?
Should we follow Posix and return EPERM?
Should we follow SYSV unix?

Looking at FreeBSD aka:
https://cgit.freebsd.org/src/tree/sys/kern/kern_sig.c?id=9e283cf9a2fe2b3aa6e4a47a012fd43b4e49ebec
kill(2) aka killpg1 only returns 0 or ESRCH when sending a signal
to multiple processes (after passing the EINVAL) check.

The man pages for AIX and Solaris suggest that -EPERM is returned when
things don't work.

So what should Linux do?

Historically Linux signaling is very SysV unix with a some compatibility
flags for BSD where it matters.  So I am not convinced that return
ESRCH in this case is the right answer.

Basing the logic off of __kill_pgrp_info I would do:

diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..369499ebb8e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1602,7 +1602,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 		ret = __kill_pgrp_info(sig, info,
 				pid ? find_vpid(-pid) : task_pgrp(current));
 	} else {
-		int retval = 0, count = 0;
+		bool found = false, success = false;
+		int retval = 0;
 		struct task_struct * p;
 
 		for_each_process(p) {
@@ -1610,12 +1611,12 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 					!same_thread_group(p, current)) {
 				int err = group_send_sig_info(sig, info, p,
 							      PIDTYPE_MAX);
-				++count;
-				if (err != -EPERM)
-					retval = err;
+				found = true;
+				success |= !err;
+				retval = err;
 			}
 		}
-		ret = count ? retval : -ESRCH;
+		ret = success ? 0 : (found ? retval : -ESRCH);
 	}
 	read_unlock(&tasklist_lock);
 
I think that fits in better with Linux, and doesn't have any surprising
behavior.

> It would rather help some of the user software I'm developing, and the slightly
> new semantics are IMO definitely reasonable (BSDs have them).

Would my proposal above work for the software you are developing?

The behavior your patch was implementing was:
	ret = success ? 0 : ((retval == -EINVAL)? -EINVAL : -ESRCH);

Which gives less information.  So I am not thrilled by it.

Eric




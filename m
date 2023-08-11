Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8885779A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbjHKWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjHKWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:16:37 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F62112
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:16:28 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:34070)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qUaQl-0037p0-4T; Fri, 11 Aug 2023 16:16:27 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:42938 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qUaQj-003oV7-Nd; Fri, 11 Aug 2023 16:16:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Petr Skocik <pskocik@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
        <202211220913.AF86992@keescook>
        <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
        <878rai7u0l.fsf@email.froward.int.ebiederm.org>
        <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
        <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
Date:   Fri, 11 Aug 2023 17:16:18 -0500
In-Reply-To: <87pm3t2rvl.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 11 Aug 2023 16:25:50 -0500")
Message-ID: <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qUaQj-003oV7-Nd;;;mid=<87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18DjyPlypQ643EArgQZBkBz5xoxhpgM0d8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Petr Skocik <pskocik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 793 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.8 (0.6%), b_tie_ro: 3.4 (0.4%), parse: 1.27
        (0.2%), extract_message_metadata: 15 (1.9%), get_uri_detail_list: 2.7
        (0.3%), tests_pri_-2000: 11 (1.4%), tests_pri_-1000: 1.87 (0.2%),
        tests_pri_-950: 1.04 (0.1%), tests_pri_-900: 0.83 (0.1%),
        tests_pri_-200: 0.67 (0.1%), tests_pri_-100: 5 (0.7%), tests_pri_-90:
        106 (13.3%), check_bayes: 94 (11.9%), b_tokenize: 8 (1.1%),
        b_tok_get_all: 10 (1.3%), b_comp_prob: 2.2 (0.3%), b_tok_touch_all: 70
        (8.9%), b_finish: 0.78 (0.1%), tests_pri_0: 336 (42.4%),
        check_dkim_signature: 0.43 (0.1%), check_dkim_adsp: 2.2 (0.3%),
        poll_dns_idle: 292 (36.9%), tests_pri_10: 2.4 (0.3%), tests_pri_500:
        304 (38.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] signal: Fix the error return of kill -1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I dug through posix[1], the FreeBSD version of kill(2), and the Illumos
version of kill(2).  Common sense, the documentation and the other
implemnetations of kill(2) agree that an error should be returned if no
signal is delivered.

What is up in the air is which error code should be returned.  FreeBSD
uses ESRCH for all errors.  Illumos will return EPERM for some errors,
and ESRCH for others.  According to the rationale POSIX allows both.

The current Linux behavior of reporting success even when no signal
was delivered dates back to Linux 0.1 with the introduction of
returning ESRCH when there were no processes being added in Linux 1.0.

Since the current behavior is buggy and user-space cares[2][3] change
the behavior to match the behavior when Linux sends signals to process
groups.

Petr Skocik <pskocik@gmail.com> wrote:
> The code sample below demonstrates the problem, which gets fixed by the
> patch:
>
>     #define _GNU_SOURCE
>     #include <assert.h>
>     #include <errno.h>
>     #include <signal.h>
>     #include <stdio.h>
>     #include <sys/wait.h>
>     #include <unistd.h>
>     #define VICTIM_UID 4200 //check these are safe to use on your system!
>     #define UNUSED_UID 4300
>     int main(){
>         uid_t r,e,s;
>         if(geteuid()) return 1; //requires root privileges
>
>         //pipe to let the parent know when the child has changed ids
>         int fds[2]; if(0>pipe(fds)) return 1;
>         pid_t pid;
>         if(0>(pid=fork())) return 1;
>         else if(0==pid){
>             setreuid(VICTIM_UID,VICTIM_UID);
>             getresuid(&r,&e,&s); printf("child: %u %u %u\n", r,e,s);
>             close(fds[0]); close(fds[1]); //let the parent continue
>             for(;;) pause();
>         }
>         close(fds[1]);
>         read(fds[0],&(char){0},1); //wait for uid change in the child
>
>         #if 1
>         setreuid(VICTIM_UID,(uid_t)-1); seteuid(VICTIM_UID);
>         #else
>         setresuid(UNUSED_UID,VICTIM_UID,0);
>         #endif
>         getresuid(&r,&e,&s); printf("parent: %u %u %u\n", r,e,s); //4200 4200 0
>
>         int err = kill(-1,-111); (void)err; //test -EINVAL
>         assert(err < 0 &&  errno == EINVAL);
>
>         int rc = kill(-1,SIGTERM); //test 0
>         if(rc>=0) wait(0);
>         int rc2 = kill(-1,SIGTERM); //test -ESCHR
>         printf("1st kill ok==%d; 2nd kill ESRCH==%d\n", rc==0, rc2<0&& errno==ESRCH);
>     }

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/kill.html
[2] https://lkml.kernel.org/r/336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com
[3] https://lkml.kernel.org/r/20221122161240.137570-1-pskocik@gmail.com
Reported-by: Petr Skocik <pskocik@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..731c6e3b351d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1582,8 +1582,9 @@ EXPORT_SYMBOL_GPL(kill_pid_usb_asyncio);
 /*
  * kill_something_info() interprets pid in interesting ways just like kill(2).
  *
- * POSIX specifies that kill(-1,sig) is unspecified, but what we have
- * is probably wrong.  Should make it like BSD or SYSV.
+ * POSIX allows the error codes EPERM and ESRCH when kill(-1,sig) does
+ * not deliver a signal to any process.  For consistency use the same
+ * logic in kill_something_info and __kill_pgrp_info.
  */
 
 static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
@@ -1602,7 +1603,8 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
 		ret = __kill_pgrp_info(sig, info,
 				pid ? find_vpid(-pid) : task_pgrp(current));
 	} else {
-		int retval = 0, count = 0;
+		bool found = false, success = false;
+		int retval = 0;
 		struct task_struct * p;
 
 		for_each_process(p) {
@@ -1610,12 +1612,12 @@ static int kill_something_info(int sig, struct kernel_siginfo *info, pid_t pid)
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
 
-- 
2.35.3


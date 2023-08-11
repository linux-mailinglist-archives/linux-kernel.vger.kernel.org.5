Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155DE779968
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjHKV1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjHKV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:27:53 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3E171F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:27:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38562)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qUZfh-00Ai59-Dh; Fri, 11 Aug 2023 15:27:49 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:51010 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qUZfg-00FE5H-8a; Fri, 11 Aug 2023 15:27:49 -0600
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
Date:   Fri, 11 Aug 2023 16:25:50 -0500
In-Reply-To: <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com> (Petr Skocik's
        message of "Thu, 10 Aug 2023 23:30:44 +0200")
Message-ID: <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qUZfg-00FE5H-8a;;;mid=<87pm3t2rvl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/6lhk1B0Fv7Aw/ileChWjpM9+bdhP7HUs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Petr Skocik <pskocik@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 484 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.07
        (0.2%), extract_message_metadata: 14 (3.0%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-2000: 4.1 (0.9%), tests_pri_-1000: 2.4 (0.5%),
        tests_pri_-950: 1.52 (0.3%), tests_pri_-900: 1.25 (0.3%),
        tests_pri_-200: 0.94 (0.2%), tests_pri_-100: 4.1 (0.9%),
        tests_pri_-90: 80 (16.6%), check_bayes: 79 (16.3%), b_tokenize: 7
        (1.5%), b_tok_get_all: 8 (1.6%), b_comp_prob: 2.7 (0.5%),
        b_tok_touch_all: 57 (11.8%), b_finish: 0.87 (0.2%), tests_pri_0: 278
        (57.4%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.3
        (0.5%), poll_dns_idle: 68 (14.1%), tests_pri_10: 2.2 (0.4%),
        tests_pri_500: 79 (16.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Skocik <pskocik@gmail.com> writes:

> Thanks for the detailed analysis, Eric W. Biederman.
>
> All my software really cares about is that I get some indication that a
> kill(-1,s) run from a non-root pid no longer had anything left to kill, 
> which on Linux is currently being masked by a return value of 0 whereas BDSs
> nicely provide an ESRCH. -EPERM would work too (and would still be more useful
> to me than the current behavior), but I will still object to it because I'm
> convinced you're misreading POSIX here and ESRCH, not EPERM, is the error that
> should be returned here.

Thank you for saying any error return is good enough for your
application.  It is definitely a bug that Linux reports success when no
signal has been delivered.

I dug into this a little bit more and found that Illumos and it's
ancestor OpenSolaris can return EPERM, even when sending to all
processes, by reading the Illumos source code.

Reading through the rational of kill it says that it is sometimes
desirable to hide the existence of one process from another so that the
existence of a process will not be an information leak.  To accommodate
that POSIX allows ESRCH instead of EPERM as an error code.

If you want you can read it for yourself here:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/kill.html


To sum up.

The function kill(2) should always report success when it has delivered
a signal and not otherwise.

The Linux version of kill(2) is buggy because it reports success when it
has not delivered a signal.

Different implementations of kill(2) do different things in this
situation and POSIX appears to allow the variation, so there is no
strong argument for any specific behavior (other than returning an
error) from a compatibility standpoint.

From my perspective making the implementation of sending a signal to all
processes (-1) handle errors the same as sending a signal to a process
group (-pgrp) seems like the most sensible way to fix this bug in Linux.

I can see an argument for hiding the existence of processes and
returning ESRCH but if/when we go down that road I would just ask that
we be consistent and update all of the signal sending functions at the
same time.

I will see about writing a commit message and posting a final patch in
just a little bit.

Eric

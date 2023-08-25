Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611F67887FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbjHYNA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244860AbjHYNAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:00:53 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC691BE2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:00:50 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46396)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qZWQj-008Bg8-BI; Fri, 25 Aug 2023 07:00:49 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54132 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qZWQh-003b2o-T9; Fri, 25 Aug 2023 07:00:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterz@redhat.com,
        linux-kernel@vger.kernel.org
References: <20230824143112.GA31208@redhat.com>
        <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
Date:   Fri, 25 Aug 2023 08:00:19 -0500
In-Reply-To: <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 24 Aug 2023 08:02:51 -0700")
Message-ID: <87y1hzs2e4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qZWQh-003b2o-T9;;;mid=<87y1hzs2e4.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/Fu5GH+AD9ivwUhyvPr8FDQlZtjWUgNIo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 834 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.5%), b_tie_ro: 2.8 (0.3%), parse: 0.71
        (0.1%), extract_message_metadata: 9 (1.1%), get_uri_detail_list: 1.22
        (0.1%), tests_pri_-2000: 3.9 (0.5%), tests_pri_-1000: 1.82 (0.2%),
        tests_pri_-950: 1.02 (0.1%), tests_pri_-900: 0.78 (0.1%),
        tests_pri_-200: 0.66 (0.1%), tests_pri_-100: 2.9 (0.3%),
        tests_pri_-90: 152 (18.3%), check_bayes: 144 (17.3%), b_tokenize: 5
        (0.6%), b_tok_get_all: 10 (1.2%), b_comp_prob: 1.44 (0.2%),
        b_tok_touch_all: 126 (15.1%), b_finish: 0.67 (0.1%), tests_pri_0: 235
        (28.2%), check_dkim_signature: 0.38 (0.0%), check_dkim_adsp: 2.8
        (0.3%), poll_dns_idle: 407 (48.9%), tests_pri_10: 1.65 (0.2%),
        tests_pri_500: 418 (50.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] introduce __next_thread(), change next_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 24 Aug 2023 at 07:32, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> After document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
>> in mm tree + this series
>
> Looking at your patch 2/2, I started looking at users ("Maybe we
> *want* NULL for the end case, and make next_thread() and __next_thread
> be the same?").
>
> One of the main users is while_each_thread(), which certainly wants
> that NULL case, both for an easier loop condition, but also because
> the only user that uses the 't' pointer after the loop is
> fs/proc/base.c, which wants it to be NULL.

Sort of.

I have found 3 loops that want to loop through all of the threads of
a process starting with the current thread. 

The loop in do_wait.
The loop finding the thread to signal in complete_signal.
The loop in retarget_shared_pending finding which threads
to wake up.

For the signal case that is just quality of implementation,
and starting somewhere else would just decrease that quality.

For the loop in do_wait it is a correctness issue that the code
starts first with the threads own children before looking for
children of other threads.


There are 4 users of next_thread outside of while_each_thread.
- next_tid -- wants NULL
- task_group_seq_get_next -- same as next_tid
- __exit_signal -- wants any thread on the list after __unhash_process
- complete_signal -- wants the same loop as do_wait.

> And kernel/bpf/task_iter.c seems to *expect* NULL at the end?
>
> End result: if you're changing next_thread() anyway, please just
> change it to be a completely new thing that returns NULL at the end,
> which is what everybody really seems to want, and don't add a new
> __next_thread() helper. Ok?

So I would say Oleg please build the helper that do_wait wants
and use it in do_wait, complete_signal, and retarget_shared_pending.

Change the rest of the loops can use for_each_thread (skipping
the current task if needed) or for_each_process_thread.

Change __exit_signal to use signal->group_leader instead of next_thread.

Change next_thread to be your __next_thread, and update the 2 callers
appropriately.

Eric

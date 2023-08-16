Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D260777EAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbjHPUdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346247AbjHPUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:33:09 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B26126BB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:33:04 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51116)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWNCP-001osj-Ga; Wed, 16 Aug 2023 14:33:01 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:40368 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qWNCO-00B6Ui-Ma; Wed, 16 Aug 2023 14:33:01 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Petr Skocik <pskocik@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221122161240.137570-1-pskocik@gmail.com>
        <202211220913.AF86992@keescook>
        <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
        <878rai7u0l.fsf@email.froward.int.ebiederm.org>
        <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
        <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
        <87jzu12pjh.fsf_-_@email.froward.int.ebiederm.org>
        <20230814140652.GA30596@redhat.com> <20230814154351.GA4203@redhat.com>
        <3b14ae8091e3403bbc4ef1bee6dcf4f6@AcuMS.aculab.com>
        <20230815151149.GA29072@redhat.com>
Date:   Wed, 16 Aug 2023 15:32:26 -0500
In-Reply-To: <20230815151149.GA29072@redhat.com> (Oleg Nesterov's message of
        "Tue, 15 Aug 2023 17:11:50 +0200")
Message-ID: <87fs4ig23p.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qWNCO-00B6Ui-Ma;;;mid=<87fs4ig23p.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/03hSznMFp9LtVGdXJGlIQ7ZUXkm5I7t0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 221 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.7%), b_tie_ro: 2.6 (1.2%), parse: 0.73
        (0.3%), extract_message_metadata: 2.1 (0.9%), get_uri_detail_list:
        0.56 (0.3%), tests_pri_-2000: 2.9 (1.3%), tests_pri_-1000: 1.99 (0.9%),
         tests_pri_-950: 1.04 (0.5%), tests_pri_-900: 0.81 (0.4%),
        tests_pri_-200: 0.72 (0.3%), tests_pri_-100: 2.5 (1.1%),
        tests_pri_-90: 48 (21.8%), check_bayes: 47 (21.3%), b_tokenize: 4.0
        (1.8%), b_tok_get_all: 6 (2.5%), b_comp_prob: 1.20 (0.5%),
        b_tok_touch_all: 33 (15.1%), b_finish: 0.78 (0.4%), tests_pri_0: 143
        (64.4%), check_dkim_signature: 0.39 (0.2%), check_dkim_adsp: 3.8
        (1.7%), poll_dns_idle: 1.78 (0.8%), tests_pri_10: 1.66 (0.7%),
        tests_pri_500: 6 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Fix the error return of kill -1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 08/15, David Laight wrote:
>>
>> or maybe even:
>> 	} else {
>> 		struct task_struct * p;
>> 		int err;
>> 		ret = -ESRCH;
>>
>> 		for_each_process(p) {
>> 			if (task_pid_vnr(p) > 1 &&
>> 					!same_thread_group(p, current)) {
>> 				err = group_send_sig_info(sig, info, p,
>> 							  PIDTYPE_MAX);
>> 				if (ret)
>> 					ret = err;
>
> Hmm, indeed ;)
>
> and "err" can be declared inside the loop.

We can't remove the success case, from my posted patch.

A signal is considered as successfully delivered if at least
one process receives it.

That is something the current code for kill -1 actually gets
wrong (but hides because it ignores -EPERM).

Otherwise yes I expect we can simplify the use of variables as
suggested.

Eric


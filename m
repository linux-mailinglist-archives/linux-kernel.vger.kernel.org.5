Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017217C865A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjJMNEH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 09:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJMNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:04:05 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93738BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:04:03 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51400)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qrHpe-004kKO-NP; Fri, 13 Oct 2023 07:03:58 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:60040 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qrHpd-00GEuo-Bj; Fri, 13 Oct 2023 07:03:58 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     yunhui cui <cuiyunhui@bytedance.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, rongtao@cestc.cn,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
References: <20231011065446.53034-1-cuiyunhui@bytedance.com>
        <87sf6gcyb3.fsf@email.froward.int.ebiederm.org>
        <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
Date:   Fri, 13 Oct 2023 08:03:27 -0500
In-Reply-To: <CAEEQ3wm8oE1dXo7AuU3gY90oF_G21OqNZwnkqhhd1-_j4wWbYQ@mail.gmail.com>
        (yunhui cui's message of "Fri, 13 Oct 2023 10:44:45 +0800")
Message-ID: <87r0lyad40.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qrHpd-00GEuo-Bj;;;mid=<87r0lyad40.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18XjmovimnXJhc/c58GwdkiGPUaBlB1duc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;yunhui cui <cuiyunhui@bytedance.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 800 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 20 (2.5%), b_tie_ro: 19 (2.3%), parse: 1.64
        (0.2%), extract_message_metadata: 44 (5.5%), get_uri_detail_list: 2.7
        (0.3%), tests_pri_-2000: 62 (7.7%), tests_pri_-1000: 8 (1.0%),
        tests_pri_-950: 1.94 (0.2%), tests_pri_-900: 1.62 (0.2%),
        tests_pri_-200: 1.31 (0.2%), tests_pri_-100: 6 (0.8%), tests_pri_-90:
        224 (28.0%), check_bayes: 201 (25.2%), b_tokenize: 11 (1.4%),
        b_tok_get_all: 20 (2.5%), b_comp_prob: 4.2 (0.5%), b_tok_touch_all:
        160 (20.0%), b_finish: 1.91 (0.2%), tests_pri_0: 408 (51.0%),
        check_dkim_signature: 0.91 (0.1%), check_dkim_adsp: 4.7 (0.6%),
        poll_dns_idle: 0.42 (0.1%), tests_pri_10: 2.5 (0.3%), tests_pri_500:
        13 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [External] Re: [PATCH] pid_ns: support pidns switching between
 sibling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yunhui cui <cuiyunhui@bytedance.com> writes:

> Hi Eric,
>
> On Thu, Oct 12, 2023 at 11:31 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> The check you are deleting is what verifies the pid namespaces you are
>> attempting to change pid_ns_for_children to is a member of the tasks
>> current pid namespace (aka task_active_pid_ns).
>>
>>
>> There is a perfectly good comment describing why what you are attempting
>> to do is unsupportable.
>>
>>         /*
>>          * Only allow entering the current active pid namespace
>>          * or a child of the current active pid namespace.
>>          *
>>          * This is required for fork to return a usable pid value and
>>          * this maintains the property that processes and their
>>          * children can not escape their current pid namespace.
>>          */
>>
>>
>> If you pick a pid namespace that does not meet the restrictions you are
>> removing the pid of the new child can not be mapped into the pid
>> namespace of the parent that called setns.
>>
>> AKA the following code can not work.
>>
>> pid = fork();
>> if (!pid) {
>>         /* child */
>>         do_something();
>>         _exit(0);
>> }
>> waitpid(pid);
>
> Sorry, I don't understand what you mean here.

What I mean is that if your simple patch was adopted,
then the classic way of controlling a fork would fail.

	pid = fork()
        ^--------------- Would return 0 for both parent and child
        ^--------------- Look at pid_nr_ns to understand.
        if (!pid() {
		/* child */
		do_something();
		_exit(0);
	}
	waitpid(pid);

For your use case there are more serious problems as well.  The entire
process hierarchy built would be incorrect.   Which means children
signaling parents when they exit would be incorrect, and that parents
would not be able to wait on their children.

I do understand the desire to want to cow the memory space of all of the
processes.  That can potentially save a lot of resources.

In other checkpoint/restart scenarios people have been using userfaultfd
to get a similar benefit.

I suggest you look at the CRIU project.

Eric



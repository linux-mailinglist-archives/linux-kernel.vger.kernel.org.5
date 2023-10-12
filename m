Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF87C6394
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbjJLD6Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 23:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347131AbjJLD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:57:59 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411C2729
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 20:53:17 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56104)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqml9-009i31-KW; Wed, 11 Oct 2023 21:53:15 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38256 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqml7-00DSbT-RC; Wed, 11 Oct 2023 21:53:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230929174442.1635558-1-bgeffon@google.com>
        <202309291304.9AC4F5CFB@keescook>
        <CADyq12xRZfafeu1PVxB1G9zTgThB0W5nok2eXPFLC+T28-b-Bg@mail.gmail.com>
Date:   Wed, 11 Oct 2023 22:53:05 -0500
In-Reply-To: <CADyq12xRZfafeu1PVxB1G9zTgThB0W5nok2eXPFLC+T28-b-Bg@mail.gmail.com>
        (Brian Geffon's message of "Fri, 29 Sep 2023 20:25:42 -0400")
Message-ID: <87pm1kbiou.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qqml7-00DSbT-RC;;;mid=<87pm1kbiou.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18FbFxIJLvSei2HA/9FSWuGtNs1D3ZCROs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Brian Geffon <bgeffon@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1100 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5.0 (0.5%), b_tie_ro: 3.4 (0.3%), parse: 1.26
        (0.1%), extract_message_metadata: 17 (1.5%), get_uri_detail_list: 3.2
        (0.3%), tests_pri_-2000: 10 (0.9%), tests_pri_-1000: 1.96 (0.2%),
        tests_pri_-950: 1.09 (0.1%), tests_pri_-900: 0.82 (0.1%),
        tests_pri_-200: 0.69 (0.1%), tests_pri_-100: 3.6 (0.3%),
        tests_pri_-90: 139 (12.7%), check_bayes: 133 (12.1%), b_tokenize: 7
        (0.6%), b_tok_get_all: 8 (0.7%), b_comp_prob: 2.4 (0.2%),
        b_tok_touch_all: 112 (10.2%), b_finish: 0.77 (0.1%), tests_pri_0: 302
        (27.5%), check_dkim_signature: 0.40 (0.0%), check_dkim_adsp: 4.9
        (0.4%), poll_dns_idle: 597 (54.3%), tests_pri_10: 2.6 (0.2%),
        tests_pri_500: 611 (55.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid ns
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Geffon <bgeffon@google.com> writes:

> On Fri, Sep 29, 2023 at 4:09 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Fri, Sep 29, 2023 at 01:44:42PM -0400, Brian Geffon wrote:
>> > When the system has a frozen userspace, for example, during hibernation
>> > the child reaper task will also be frozen. Attmepting to deliver a
>> > signal to it to handle the reboot(2) will ultimately lead to the system
>> > hanging unless userspace is thawed.
>> >
>> > This change checks if the current task is the suspending task and if so
>> > it will allow it to proceed with a reboot from the non-init pid ns.
>>
>> I don't know the code flow too well here, but shouldn't init_pid_ns
>> always be doing the reboot regardless of anything else?
>
> I think the point of this is, normally the reaper is runnable and so
> an appropriate signal will be delivered allowing them to also clean up
> [2]. In our case, they won't be runnable and doing this wouldn't make
> sense.

The entire reboot_pid_ns thing is just a polite way of keeping
applications like /sbin/reboot working inside a pid namespace.

Ordinarily the process calling reboot (inside the container) won't
have the privileges to request an entire system reboot.  So I don't
see anything making sense to promote that reboot into a system-wide
reboot.

Which leads me to the question.  What is actually happening with
hibernation that we want something inside a pid namespace to somehow
have the permissions to reboot the entire machine?

>> Also how is this syscall running if current is frozen? This feels weird
>> to me... shouldn't the frozen test be against pid_ns->child_reaper
>> instead of current?
>
> The task which froze the system won't be frozen to make sure this
> happens it will have the flag PF_SUSPEND_TASK added, so we know if we
> have this flag we're the only running user space task [1].

Someone has a task inside a container that is successfully suspending
the entire system?

I don't see how that makes sense.

But on the level that it somehow does I would put a test in
kernel/reboot.c something like:

/*
 * If the caller can't perform a normal reboot call
 * reboot_pid_ns
 */
if ((pid_ns != &init_pid_ns) &&
    !((current->flags & PF_SUSPEND_TASK) && capable(CAP_SYS_BOOT))) {
	return reboot_pid_ns(pid_ns, cmd);
}

Making reboot_pid_ns responsible for the logic that should be bypassing
it is quite confusing.

> I hope my understanding is correct and it makes sense. Thanks for
> taking the time to review.
>
> Brian
>
> 1. https://elixir.bootlin.com/linux/latest/source/kernel/power/process.c#L130
> 2. https://elixir.bootlin.com/linux/latest/source/kernel/pid_namespace.c#L327


I really don't know if allowing PF_SUSPEND_TASK so that hibernation and
the like can work from inside a container makes any sense at all.

But the above is roughly how I would make it work.

Eric


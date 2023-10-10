Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F57C420E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJJVIO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbjJJVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:08:12 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35622C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:08:09 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33772)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqJxV-008n5l-AY; Tue, 10 Oct 2023 15:08:05 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:58340 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qqJxU-00B8ud-5z; Tue, 10 Oct 2023 15:08:04 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
References: <20230929021213.2364883-1-joel@joelfernandes.org>
        <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
        <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
        <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
        <87il7fzusf.fsf@email.froward.int.ebiederm.org>
        <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
Date:   Tue, 10 Oct 2023 16:07:56 -0500
In-Reply-To: <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
        (Joel Fernandes's message of "Tue, 10 Oct 2023 16:37:30 -0400")
Message-ID: <87fs2ii3tf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qqJxU-00B8ud-5z;;;mid=<87fs2ii3tf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19fQVsZIQFBvLass6Dx9AXn4t9Jez/iWB0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Joel Fernandes <joel@joelfernandes.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 535 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.5%), b_tie_ro: 11 (2.1%), parse: 1.75
        (0.3%), extract_message_metadata: 25 (4.7%), get_uri_detail_list: 3.4
        (0.6%), tests_pri_-2000: 18 (3.5%), tests_pri_-1000: 2.8 (0.5%),
        tests_pri_-950: 1.68 (0.3%), tests_pri_-900: 1.41 (0.3%),
        tests_pri_-200: 1.24 (0.2%), tests_pri_-100: 4.0 (0.7%),
        tests_pri_-90: 163 (30.5%), check_bayes: 153 (28.6%), b_tokenize: 8
        (1.5%), b_tok_get_all: 11 (2.1%), b_comp_prob: 4.0 (0.7%),
        b_tok_touch_all: 124 (23.1%), b_finish: 1.47 (0.3%), tests_pri_0: 287
        (53.6%), check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 3.4
        (0.6%), poll_dns_idle: 0.66 (0.1%), tests_pri_10: 2.2 (0.4%),
        tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Fernandes <joel@joelfernandes.org> writes:

> On Mon, Oct 9, 2023 at 11:30 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Joel Fernandes <joel@joelfernandes.org> writes:
>>
>> > On Mon, Oct 2, 2023 at 2:18 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>> > [..]
>> >> > > Such freezing is already being done if kernel supports KEXEC_JUMP and
>> >> > > kexec_image->preserve_context is true. However, doing it if either of these are
>> >> > > not true prevents crashes/races.
>> >> >
>> >> > The KEXEC_JUMP case is something else entirely.  It is supposed to work
>> >> > like suspend to RAM.  Maybe reboot should as well, but I am
>> >> > uncomfortable making a generic device fix kexec specific.
>> >>
>> >> I see your point of view. I think regular reboot should also be fixed
>> >> to avoid similar crash possibilities. I am happy to make a change for
>> >> that similar to this patch if we want to proceed that way.
>> >>
>> >> Thoughts?
>> >
>> > Just checking how we want to proceed, is the consensus that we should
>> > prevent kernel crashes without relying on userspace stopping all
>> > processes? Should we fix regular reboot syscall as well and not just
>> > kexec reboot?
>>
>> It just occurred to me there is something very fishy about all of this.
>>
>> What userspace do you have using kexec (not kexec on panic) that doesn't
>> preform the same userspace shutdown as a normal reboot?
>>
>> Quite frankly such a userspace is buggy, and arguably that is where you
>> should start fixing things.
>
> It is a simple unit test that tests kexec support by kexec-rebooting
> the kernel. I don't think SIGSTOP/SIGKILL'ing during kexec-reboot is
> ideal because in a real panic-on-kexec type crash, that may not happen
> and so does not emulate the real world that well. I think we want the
> kexec-reboot to do a *reboot* without crashing the kernel while doing
> so. Ricardo/Steve can chime on what they feel as well.

This is confusing.  You have a unit test that, that tests kexec on
panic using a the full kexec reboot.

The two are fundamentally similar but you aren't going to have a valid
test case if you mix them.

There is a whole kernel module that tests more interesting cases,
for the simple case you probably just want to do:

	echo 'p' > /proc/sysrq-trigger

At least I think it is p that causes a kernel-panic.

That will ensure you are exercising the kexec on panic code path.  That
performs the minimal shutdown in the kernel.

>> That way you can get the orderly shutdown
>> of userspace daemons/services along with an orderly shutdown of
>> everything the kernel is responsible for.
>
> Fixing in userspace is an option but people are not happy that the
> kernel can crash like that.

In a kexec on panic scenario the kernel needs to perform that absolute
bare essential shutdown before calling kexec (basically nothing).
During kexec-on-panic nothing can be relied upon because we don't know
what is broken.  If that is what you care about (as suggested by the
unit test) you need to fix the device initialization.

In a normal kexec scenario the whole normal reboot process is expected.
I have no problems with fixing the kernel to handle that scenario,
but in the real world the entire orderly shutdown both, kernel
and userspace should be performed.

>> At the kernel level a kexec reboot and a normal reboot have been
>> deliberately kept as close as possible.  Which is why I say we should
>> fix it in reboot.
>
> You mean fix it in userspace?

No.  I mean in the kernel the orderly shutdown for a kexec reboot and an
ordinary reboot are kept as close to the same as possible.

It should be the case that the only differences between the two is that
in once case system firmware takes over after the orderly shutdown,
and in the other case a new kernel takes over after the orderly shutdown.

Eric


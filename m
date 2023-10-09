Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E507BE4C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbjJIPaw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376424AbjJIPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:30:49 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB2A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:30:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:38198)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qpsDU-0060Yb-3i; Mon, 09 Oct 2023 09:30:44 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38624 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qpsDQ-007a4Q-RL; Mon, 09 Oct 2023 09:30:43 -0600
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
Date:   Mon, 09 Oct 2023 10:21:04 -0500
In-Reply-To: <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com>
        (Joel Fernandes's message of "Sat, 7 Oct 2023 21:30:42 -0400")
Message-ID: <87il7fzusf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qpsDQ-007a4Q-RL;;;mid=<87il7fzusf.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/05uh69me2MdpVapboGWSZ9mJiUasho74=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Joel Fernandes <joel@joelfernandes.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2656 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (0.4%), b_tie_ro: 10 (0.4%), parse: 1.77
        (0.1%), extract_message_metadata: 23 (0.9%), get_uri_detail_list: 3.0
        (0.1%), tests_pri_-2000: 7 (0.3%), tests_pri_-1000: 3.7 (0.1%),
        tests_pri_-950: 1.83 (0.1%), tests_pri_-900: 1.44 (0.1%),
        tests_pri_-200: 1.19 (0.0%), tests_pri_-100: 4.7 (0.2%),
        tests_pri_-90: 2370 (89.2%), check_bayes: 2360 (88.9%), b_tokenize: 9
        (0.3%), b_tok_get_all: 8 (0.3%), b_comp_prob: 3.0 (0.1%),
        b_tok_touch_all: 2336 (88.0%), b_finish: 1.19 (0.0%), tests_pri_0: 215
        (8.1%), check_dkim_signature: 0.56 (0.0%), check_dkim_adsp: 4.1 (0.2%),
         poll_dns_idle: 0.40 (0.0%), tests_pri_10: 2.0 (0.1%), tests_pri_500:
        7 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Fernandes <joel@joelfernandes.org> writes:

> On Mon, Oct 2, 2023 at 2:18 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> [..]
>> > > Such freezing is already being done if kernel supports KEXEC_JUMP and
>> > > kexec_image->preserve_context is true. However, doing it if either of these are
>> > > not true prevents crashes/races.
>> >
>> > The KEXEC_JUMP case is something else entirely.  It is supposed to work
>> > like suspend to RAM.  Maybe reboot should as well, but I am
>> > uncomfortable making a generic device fix kexec specific.
>>
>> I see your point of view. I think regular reboot should also be fixed
>> to avoid similar crash possibilities. I am happy to make a change for
>> that similar to this patch if we want to proceed that way.
>>
>> Thoughts?
>
> Just checking how we want to proceed, is the consensus that we should
> prevent kernel crashes without relying on userspace stopping all
> processes? Should we fix regular reboot syscall as well and not just
> kexec reboot?

It just occurred to me there is something very fishy about all of this.

What userspace do you have using kexec (not kexec on panic) that doesn't
preform the same userspace shutdown as a normal reboot?

Quite frankly such a userspace is buggy, and arguably that is where you
should start fixing things.  That way you can get the orderly shutdown
of userspace daemons/services along with an orderly shutdown of
everything the kernel is responsible for.

At the kernel level a kexec reboot and a normal reboot have been
deliberately kept as close as possible.  Which is why I say we should
fix it in reboot.

Eric

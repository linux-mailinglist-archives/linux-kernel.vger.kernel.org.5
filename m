Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1817F8856
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKYEcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 23:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYEcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 23:32:43 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D932170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 20:32:49 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:56176)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r6kLR-00HAXs-59; Fri, 24 Nov 2023 21:32:41 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:43464 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r6kLP-00Eszi-T0; Fri, 24 Nov 2023 21:32:40 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
        <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
        <CADWks+aY0jOq6erApu7i0wNVX3uXPbs=Zj7o3XHPMudOkYyeVA@mail.gmail.com>
        <CADWks+YUm+kCfZZkrCHE+x1ygdqLawyk+h4_ahac9+7b_AvbUw@mail.gmail.com>
Date:   Fri, 24 Nov 2023 22:31:53 -0600
In-Reply-To: <CADWks+YUm+kCfZZkrCHE+x1ygdqLawyk+h4_ahac9+7b_AvbUw@mail.gmail.com>
        (Dimitri John Ledkov's message of "Fri, 24 Nov 2023 18:06:01 +0000")
Message-ID: <877cm6tpvq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r6kLP-00Eszi-T0;;;mid=<877cm6tpvq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/Ig8I5jQfPGB2EF67P9+pe8TLh/rPUNG8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Dimitri John Ledkov <dimitri.ledkov@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 13 (2.5%), b_tie_ro: 11 (2.2%), parse: 2.0 (0.4%),
         extract_message_metadata: 43 (8.2%), get_uri_detail_list: 4.6 (0.9%),
        tests_pri_-2000: 38 (7.3%), tests_pri_-1000: 4.4 (0.8%),
        tests_pri_-950: 1.75 (0.3%), tests_pri_-900: 1.42 (0.3%),
        tests_pri_-90: 82 (15.8%), check_bayes: 77 (14.7%), b_tokenize: 19
        (3.6%), b_tok_get_all: 10 (1.9%), b_comp_prob: 6 (1.1%),
        b_tok_touch_all: 38 (7.3%), b_finish: 1.16 (0.2%), tests_pri_0: 269
        (51.7%), check_dkim_signature: 0.73 (0.1%), check_dkim_adsp: 14 (2.6%),
         poll_dns_idle: 39 (7.5%), tests_pri_10: 2.0 (0.4%), tests_pri_500: 56
        (10.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/5] remove the last bits of a.out support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:

> On Fri, 24 Nov 2023 at 14:36, Dimitri John Ledkov
> <dimitri.ledkov@canonical.com> wrote:
>>
>> On Fri, 24 Nov 2023 at 06:01, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:
>> >
>> > > I was working on how linux-libc-dev headers are shipped in Ubuntu and
>> > > stumbled upon seemingly unused and useless linux/a.out.h header. It
>> > > seems like it is an accidental leftover at this point.
>> >
>> > How do you see that they are unused?
>
> When I did my code search the only and last remaining userspace code
> that imports linux/a.out.h it is the objtool that is patched in these
> patch series.
> It is also vendored as copy in aboot tool, which has been patched in
> many downstreams to use a.out.h instead of linux/a.out.h.

It sounds like you have done your homework.

Please just document (as you in your reply to me) in your cover letter
or elsewhere in the changes so that it is clear that due diligence has
been performed and userspace should not break with this change.

[snip]

> Was your search
> https://codesearch.debian.net/search?q=linux%2Fa.out.h&literal=1&perpkg=1
> ?

Pretty much.  I didn't have the perpkg=1.

Debian code search is the most comprehensive code search I am aware
of so I took a quick look.

Since it appears the only users are vendored versions of linux/a.out.h
then it should be possible to make this change without breaking
userspace.  If it turns that is wrong the changes can be reverted.

Eric

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1B80BDC4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjLJW7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJW7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:59:12 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D148E8;
        Sun, 10 Dec 2023 14:59:17 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:52474)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rCSlV-005rO9-G9; Sun, 10 Dec 2023 15:59:13 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:53806 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1rCSlU-00CZ52-9k; Sun, 10 Dec 2023 15:59:13 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
        <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
        <c4233c97-306c-4db8-9667-34fc31ec4aed@p183>
        <87edp7jyu4.fsf@meer.lwn.net>
        <88d3f1bb-f4e0-4c40-9304-3843513a1262@p183>
        <202312061456.2103DA1@keescook>
        <874jgugilq.fsf@email.froward.int.ebiederm.org>
        <57f5aa9d-79c5-4f65-b90f-204600edfb80@p183>
Date:   Sun, 10 Dec 2023 16:58:50 -0600
In-Reply-To: <57f5aa9d-79c5-4f65-b90f-204600edfb80@p183> (Alexey Dobriyan's
        message of "Sun, 10 Dec 2023 14:45:18 +0300")
Message-ID: <87edftbr6d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rCSlU-00CZ52-9k;;;mid=<87edftbr6d.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18nVuD+PRK7RFCBnf6/BI6snLlX9HWTiUQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Dobriyan <adobriyan@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 590 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 11 (1.8%), parse: 1.29
        (0.2%), extract_message_metadata: 14 (2.4%), get_uri_detail_list: 3.3
        (0.6%), tests_pri_-2000: 12 (2.0%), tests_pri_-1000: 2.4 (0.4%),
        tests_pri_-950: 1.21 (0.2%), tests_pri_-900: 0.97 (0.2%),
        tests_pri_-90: 87 (14.8%), check_bayes: 84 (14.2%), b_tokenize: 11
        (1.8%), b_tok_get_all: 11 (1.9%), b_comp_prob: 3.4 (0.6%),
        b_tok_touch_all: 55 (9.3%), b_finish: 0.82 (0.1%), tests_pri_0: 437
        (74.0%), check_dkim_signature: 0.67 (0.1%), check_dkim_adsp: 2.6
        (0.4%), poll_dns_idle: 0.45 (0.1%), tests_pri_10: 3.2 (0.5%),
        tests_pri_500: 15 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] ELF: document some de-facto PT_* ABI quirks
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Thu, Dec 07, 2023 at 09:03:45AM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > *thread necromancy* Question below...
>> >
>> > On Sat, Apr 15, 2023 at 08:37:29PM +0300, Alexey Dobriyan wrote:
>> >> Turns out rules about PT_INTERP, PT_GNU_STACK and PT_GNU_PROPERTY
>> >> program headers are slightly different.
>> >> 
>> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> >> ---
>> >> 
>> >> 	v3: move to Documentation/userspace-api/
>> >> 	v2: integrate into documentation build system
>> >> 
>> >>  Documentation/userspace-api/ELF.rst   |   34 ++++++++++++++++++++++++++++++++++
>> >>  Documentation/userspace-api/index.rst |    1 +
>> >>  2 files changed, 35 insertions(+)
>> >> 
>> >> new file mode 100644
>> >> --- /dev/null
>> >> +++ b/Documentation/userspace-api/ELF.rst
>> >> @@ -0,0 +1,34 @@
>> >> +.. SPDX-License-Identifier: GPL-2.0
>> >> +
>> >> +=================================
>> >> +Linux-specific ELF idiosyncrasies
>> >> +=================================
>> >> +
>> >> +Definitions
>> >> +===========
>> >> +
>> >> +"First" program header is the one with the smallest offset in the file:
>> >> +e_phoff.
>> 
>> Confusing e_phoff is the defined location of the array of program
>> headers.
>> 
>> Perhaps the "First" in that array with the lowest e_phnum?
>> 
>> >> +"Last" program header is the one with the biggest offset in the file:
>> >> +e_phoff + (e_phnum - 1) * sizeof(Elf_Phdr).
>> 
>> Ditto the "Last" in the array with the largest array index.
>> 
>> I nit pick this because it sounded at first like you were talking about
>> p_offset.  Which is a value contained in the program header entry.
>> 
>> >> +PT_INTERP
>> >> +=========
>> >> +
>> >> +First PT_INTERP program header is used to locate the filename of ELF
>> >> +interpreter. Other PT_INTERP headers are ignored (since Linux 2.4.11).
>> >> +
>> >> +PT_GNU_STACK
>> >> +============
>> >> +
>> >> +Last PT_GNU_STACK program header defines userspace stack executability
>> >> +(since Linux 2.6.6). Other PT_GNU_STACK headers are ignored.
>> >> +
>> >> +PT_GNU_PROPERTY
>> >> +===============
>> >> +
>> >> +ELF interpreter's last PT_GNU_PROPERTY program header is used (since
>> >> +Linux 5.8). If interpreter doesn't have one, then the last PT_GNU_PROPERTY
>> >> +program header of an executable is used. Other PT_GNU_PROPERTY headers
>> >> +are ignored.
>> 
>> A more interesting property to document is that PT_GNU_PROPERTY must
>> precede PT_INTERP in the linux implementation, otherwise we ignore it.
>> 
>> > Should we perhaps solve some of these in some way? What would folks
>> > prefer the behaviors be? (I like to have things been "as expected", but
>> > it's not very obvious here for redundant headers...)
>> 
>> All of these are really headers that should appear only once.
>
> Yes.
>
>> Quite frankly if we are going to do something with this my sense is that
>> we should fail the execve with a clear error code as userspace should
>> not be doing this, and accepting a malformed executable will hide
>> errors, and perhaps hide someone causing problems.
>
> Maybe do it for PT_GNU_PROPERTY which is relatively new.
>
>> I really don't think having multiple copies of these headers with
>> different values is something we should encourage.
>> 
>> It looks like -ELIBBAD is the documented way to fail and report
>> a bad file format.
>
> It is obvious you don't know how much will break.

My assumption is frankly that nothing will break.  My quick examination
of userspace binaries suggests that nothing is silly enough to duplicate
such headers.

Do you know of a binaries in userspace that duplicate these headers?

Without a documented ordering arguably anything that results in
these headers being duplicated is already buggy, and broken.

I can think of no use for duplicating these headers other than
as some kind of gadget in an exploit.  I don't see how such
a gadget would be useful currently.

>
>> For PT_GNU_PROPTERTY perhaps we should accept it anywhere, instead of
>> silently ignoring it depending upon it's location?
>> 
>> I thinking change the code to talk one pass through the program headers
>> to identify the interesting headers, and then with the interesting
>> headers all identified we go do something with them.
>> 
>> Anyway just my opinion, but that is what it feels like to me.
>
> _Not_ checking for duplicates will result in the simplest and fastest exec.
> which is what current code does.

Given that I/O is involved taking a pre-pass through the headers is
in the noise, and it might even make the code faster as it would
prime the code for the other passes.

The fastest of course would be to have the elf loader only look
at the first of any of these headers.

What got you wanting to document how we handle duplicates?

Eric

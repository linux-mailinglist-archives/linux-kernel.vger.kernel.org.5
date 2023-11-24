Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508AE7F6BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjKXGAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXGAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:00:52 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921DCD6C;
        Thu, 23 Nov 2023 22:00:58 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:39710)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r6PFB-005ba8-Kx; Thu, 23 Nov 2023 23:00:49 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:60692 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1r6PFA-00DCbd-Ih; Thu, 23 Nov 2023 23:00:49 -0700
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
Date:   Fri, 24 Nov 2023 00:00:15 -0600
In-Reply-To: <20231123180246.750674-1-dimitri.ledkov@canonical.com> (Dimitri
        John Ledkov's message of "Thu, 23 Nov 2023 18:02:40 +0000")
Message-ID: <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1r6PFA-00DCbd-Ih;;;mid=<87plzzu1w0.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18y8s90sAMWqqBRxivL9OmnWIytNbRgPXg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Dimitri John Ledkov <dimitri.ledkov@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 427 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.3%), parse: 0.84
        (0.2%), extract_message_metadata: 12 (2.7%), get_uri_detail_list: 1.58
        (0.4%), tests_pri_-2000: 10 (2.3%), tests_pri_-1000: 3.0 (0.7%),
        tests_pri_-950: 1.19 (0.3%), tests_pri_-900: 1.02 (0.2%),
        tests_pri_-90: 73 (17.1%), check_bayes: 72 (16.8%), b_tokenize: 9
        (2.0%), b_tok_get_all: 8 (1.9%), b_comp_prob: 2.3 (0.5%),
        b_tok_touch_all: 49 (11.4%), b_finish: 1.04 (0.2%), tests_pri_0: 296
        (69.2%), check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 2.8
        (0.7%), poll_dns_idle: 1.09 (0.3%), tests_pri_10: 2.4 (0.6%),
        tests_pri_500: 14 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/5] remove the last bits of a.out support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:

> I was working on how linux-libc-dev headers are shipped in Ubuntu and
> stumbled upon seemingly unused and useless linux/a.out.h header. It
> seems like it is an accidental leftover at this point.

How do you see that they are unused?

Are they never exported to userspace?

Are there any userspace programs that care?

Performing a quick debian code search I see chromium, qt6, ruby-rogue, hurd,
bazel_bootstrap, aboot, cde.

I can imagine all kinds of reasons old code could be using headers for a
historical format.  Some of them are quite legitimate, and some of them
are quite silly.  If it is old code like aboot it may be that it is
difficult to test any changes.  If memory serves you have to flash your
firmware to change/test aboot.

Because showing userspace does not care about the definitions in a file
is a completely different problem then showing the kernel does not care
about the definitions I left them, last time I was working in this area.
Keeping headers that will never change is not cost to the kernel so it
doesn't hurt us to be nice to historical userspace.

My quick debian code search suggests that there are pieces of userspace
that still use linux/a.out.h.  Are you seeing something I am not?
Do all of those pieces of code compile just fine with a.out.h missing?

Eric


> Dimitri John Ledkov (5):
>   alpha: remove a.out support from tools/objstrip
>   alpha: stop shipping a.out.h uapi headers
>   m68k: stop shipping a.out.h uapi headers
>   x86: stop shipping a.out.h uapi headers
>   uapi: remove a.out.h uapi header
>
>  arch/alpha/boot/tools/objstrip.c    |  52 +-----
>  arch/alpha/include/uapi/asm/a.out.h |  92 ----------
>  arch/m68k/include/uapi/asm/a.out.h  |  21 ---
>  arch/x86/include/uapi/asm/a.out.h   |  21 ---
>  include/uapi/Kbuild                 |   4 -
>  include/uapi/linux/a.out.h          | 251 ----------------------------
>  6 files changed, 6 insertions(+), 435 deletions(-)
>  delete mode 100644 arch/alpha/include/uapi/asm/a.out.h
>  delete mode 100644 arch/m68k/include/uapi/asm/a.out.h
>  delete mode 100644 arch/x86/include/uapi/asm/a.out.h
>  delete mode 100644 include/uapi/linux/a.out.h

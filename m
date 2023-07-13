Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B377527DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGMP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjGMP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:57:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AC1BEF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:57:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8b2a2e720so4224515ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689263874; x=1691855874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFX53kSavsL1a2FIZBbiPM4LW9j7JVHlnHpgm79wVNs=;
        b=VYxI8KW9P49Nt1ZOOA4OJXIhA7PwWpb5cfTu2P2WSPndxtYYqjTx/ENH4KlKOob6dq
         M55dPMG+LjO8ff1xmgbnF/xi0AdD1X7mK06g1MsEZu7qoA2X2J9JkjjfJg+bPIx/3Kr8
         k+jpfU0vyYRVKzIT9unz9YMUCKiipHcT5G7WEYBioj4lBskBi4BvngzIdhPwDSVklkHn
         8UQIhyj2YJbfsUGKW757Eis11utPRuCq9p2Kud5GqwhbRiZVm1LqaICeLj1m0e2CmUcI
         39gChoqVCwE996vYgdFR8q4YHyMOqZCeJcstimy0WuEXkpKPSAdtFcCtkl/hToJgTEwa
         LFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263874; x=1691855874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFX53kSavsL1a2FIZBbiPM4LW9j7JVHlnHpgm79wVNs=;
        b=KgyqmonU+uAXgwuAO+h/b7f9qK/0zqq1tJ2MP8H+s7mfTAJe6fM+tzkN+OaMp2xhd7
         8y8kvQaOx5YFAxFUIhumXaekDhOslmBpoCSP0mdJUTJqUSKFx1gK7n8S5iWWLK0DgMaf
         Nfj91D/iSBf5Au5qd/NGoN1ow1ZAD3SVsL1yxfbFG+iSAX1FDP4lDTt4bpK0AbMwKJ76
         5iqmTljLFBysObANq8nc0wOngFYjNv+NyR++2+c9QD+ZPO30EkxgfuEzP/JUx5XUorbO
         9ewhZLn1FgYUI6C40p9ZsLQVirfLS5wr4Rr/IyXwwl9Vc2dJndLjqFH/FG6oPQOpnNBs
         zkBw==
X-Gm-Message-State: ABy/qLZtNMPwVAQcO6anmCu9l3bzdYsYbtZw7703Re3IrabJbwsUaOnG
        fcset+vYRAlV6QZqI+zS3RupuIBr+Iw=
X-Google-Smtp-Source: APBJJlFLId1YfJc/eB5exj6JBdS8/WO5NefgZuUKIdhmTCBDzkp/COurOvZZnoSNA1ZWLUPaB2R4tX3mIT4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:eccd:b0:1b5:2b14:5f2c with SMTP id
 a13-20020a170902eccd00b001b52b145f2cmr6656plh.4.1689263874203; Thu, 13 Jul
 2023 08:57:54 -0700 (PDT)
Date:   Thu, 13 Jul 2023 08:57:52 -0700
In-Reply-To: <000000000000a531410600582572@google.com>
Mime-Version: 1.0
References: <000000000000a531410600582572@google.com>
Message-ID: <ZLAfAF+kQ1HE44QI@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __load_segment_descriptor
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+5234e75fb68b86fe89e3@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected orde..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=106f1664a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
> dashboard link: https://syzkaller.appspot.com/bug?extid=5234e75fb68b86fe89e3
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146864a8a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134a32bca80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7eb52a4d9cf3/disk-1c7873e3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b9aa9a9e09e8/vmlinux-1c7873e3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/782d5e4196e2/bzImage-1c7873e3.xz
> 
> The issue was bisected to:
> 
> commit 65966aaca18a5cbf42ac22234cb9cbbf60a4d33c
> Author: Sean Christopherson <seanjc@google.com>
> Date:   Thu Feb 16 20:22:54 2023 +0000
> 
>     KVM: x86: Assert that the emulator doesn't load CS with garbage in !RM
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c70f4ca80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c70f4ca80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c70f4ca80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5234e75fb68b86fe89e3@syzkaller.appspotmail.com
> Fixes: 65966aaca18a ("KVM: x86: Assert that the emulator doesn't load CS with garbage in !RM")
> 
> kvm_intel: set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5022 at arch/x86/kvm/emulate.c:1648 __load_segment_descriptor+0xf89/0x1200 arch/x86/kvm/emulate.c:1648

This is the caused by the bug where KVM doesn't check the incoming CR0 provided
by userspace via KVM_SET_SREGS, and ultimately ends up with KVM being confused
about whether the vCPU is in Real Mode.  The new WARN is just the messenger, i.e.
detects that KVM is confused.

#syz dup: WARNING in kvm_arch_vcpu_ioctl_run (5)

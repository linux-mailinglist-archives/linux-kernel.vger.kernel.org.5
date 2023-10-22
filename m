Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71F7D2449
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjJVQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:19:04 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FFF98
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:19:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB2CD40E0187;
        Sun, 22 Oct 2023 16:18:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uGWOHsC76Pxy; Sun, 22 Oct 2023 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697991536; bh=KUPqqMMyydidujKyNArM6KnKGmOIjUR9NehlIqSG/GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8RaXBeTKtkLyhFm096+m4gS9rHlifJqAto0TIIrYQXWLIYUPLsoJtpzRlho055jP
         +tRMv7spj5CasjxdMcFnexDrOZ98fkmKvDQaHPoZzdruy9p1DFNUva40A/sluU3Qyz
         Ei29cZdjFzBkDulAHvYAxFlEbVeUnYKs0ff0/2C6GOrUvQw1i85jjNrAUp5q/NUVMZ
         3RbQkCx70h6TXCTA1YH5CPiRuc/+EBt1NkD7qqNidqmTNvpwPR3Q+WxSmgDUb6dEJf
         +JiWZiJ+Dgb7IWm3B+m7TZNmok2QJOafP6sDls7SBV6MX8bpb+V9MPLqMRMZv89m7P
         jrQE/IcLFde9KfNNSjRuC1HkmiHfjpdG3YOyrQ/Xy8E3mdHUhCHLy7RieVhu+CzWUE
         g9fsOYZ1lKtaCe8eo9Tz/EVo9OWM8FPV6zblCLxf5/628x7j0oOiCJTtVy3hKauWKT
         TRaa6yonMoNBSIgzYBEkTE+sUcLSCZHDVTbcT24bDsSEag4HpUdGB5vKOsqs07Kg3i
         NnAuST7DRdsY7LD8gsRKO0G/O5IpCFOVEywmd+pJ1coBVSZDMJXMPMurfZ+Ze2BQr8
         coQt2DUFgg3BCbsBDfO5eKdLHia2X9BkQqYgkN1u/AL9krINr5pute1/dimaN9YFM3
         20afDuVcncjHnR7ZtVEss0L4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A6ED340E0177;
        Sun, 22 Oct 2023 16:18:53 +0000 (UTC)
Date:   Sun, 22 Oct 2023 18:18:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Julian Wollrath <jwollrath@web.de>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Oops with v6.6-rc6+
Message-ID: <20231022161847.GAZTVLZ74T8B79v87p@fat_crate.local>
References: <20231022172700.48c515cf@mayene>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231022172700.48c515cf@mayene>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-scsi

On Sun, Oct 22, 2023 at 05:27:00PM +0200, Julian Wollrath wrote:
> Dear maintainers,
> 
> on v6.6-rc6+ (git commit hash 1acfd2bd3f0d) I got the following oops:
> 
> BUG: unable to handle page fault for address: fffffffffffffff8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 343212067 P4D 343212067 PUD 343214067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 2 PID: 13243 Comm: colord-sane Not tainted 6.6.0-rc6+ #9
> Hardware name: LENOVO 21K4S07400/21K4S07400, BIOS R2FET31W (1.11 ) 08/03/2023
> RIP: 0010:klist_next+0x6e/0x150
> Code: 18 83 f8 01 0f 84 84 00 00 00 85 c0 0f 8e ce 00 00 00 48 8b 45 00 45 31 ed 48 c7 45 08 00 00 00 00 48 39 c3 0f 84 cc 00 00 00 <f6> 03 01 75 7d 48 8d 7b 18 b8 01 00 00 00 f0 0f c1 43 18 85 c0 0f
> RSP: 0018:ffffb8b907f6fcc8 EFLAGS: 00010002
> RAX: ffff9c0aaba218a0 RBX: fffffffffffffff8 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffb8b907f6fcf8 RDI: ffff9c0aaba218a0
> RBP: ffffb8b907f6fcf8 R08: ffffb8b907f6fce0 R09: 0000000000000000
> R10: 0000000000030680 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000246 R15: 0000000000000000
> FS:  00007f12a5c77940(0000) GS:ffff9c10fec80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff8 CR3: 00000001cb102000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x181/0x4b0
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? exc_page_fault+0x11c/0x130
>  ? asm_exc_page_fault+0x26/0x30
>  ? klist_next+0x6e/0x150
>  ? klist_next+0x1f/0x150
>  ? device_match_devt+0x20/0x20
>  bus_find_device+0x75/0xe0
>  scsi_seq_start+0x42/0x60 [scsi_mod]
>  seq_read_iter+0xfc/0x480
>  seq_read+0xd4/0x100
>  proc_reg_read+0x59/0xa0
>  vfs_read+0xaa/0x370
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? __do_sys_newfstatat+0x4e/0x80
>  ? srso_alias_return_thunk+0x5/0x7f
>  ? __fget_light+0x99/0x100
>  ksys_read+0x6f/0xf0
>  do_syscall_64+0x3c/0x90
>  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> RIP: 0033:0x7f12a680fa9c
> Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 d9 cf f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f d0 f8 ff 48
> RSP: 002b:00007ffd3ea95490 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 000055c0b2164cb0 RCX: 00007f12a680fa9c
> RDX: 0000000000000400 RSI: 000055c0b214f4a0 RDI: 000000000000000c
> RBP: 00007f12a68e8600 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000001000 R11: 0000000000000246 R12: 000000000000000a
> R13: 0000000000000a68 R14: 00007f12a68e7d00 R15: 0000000000000a68
>  </TASK>
> CR2: fffffffffffffff8
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:klist_next+0x6e/0x150
> Code: 18 83 f8 01 0f 84 84 00 00 00 85 c0 0f 8e ce 00 00 00 48 8b 45 00 45 31 ed 48 c7 45 08 00 00 00 00 48 39 c3 0f 84 cc 00 00 00 <f6> 03 01 75 7d 48 8d 7b 18 b8 01 00 00 00 f0 0f c1 43 18 85 c0 0f
> RSP: 0018:ffffb8b907f6fcc8 EFLAGS: 00010002
> RAX: ffff9c0aaba218a0 RBX: fffffffffffffff8 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffb8b907f6fcf8 RDI: ffff9c0aaba218a0
> RBP: ffffb8b907f6fcf8 R08: ffffb8b907f6fce0 R09: 0000000000000000
> R10: 0000000000030680 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000246 R15: 0000000000000000
> FS:  00007f12a5c77940(0000) GS:ffff9c10fec80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff8 CR3: 00000001cb102000 CR4: 0000000000750ee0
> PKRU: 55555554
> 
> 
> 
> Best regards,
> Julian Wollrath
> 
> --
>  ()  ascii ribbon campaign - against html e-mail
>  /\                        - against proprietary attachments

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

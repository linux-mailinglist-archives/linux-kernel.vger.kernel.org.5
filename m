Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7DD75EC64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGXHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjGXHWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:22:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDDD90;
        Mon, 24 Jul 2023 00:22:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44884227A2;
        Mon, 24 Jul 2023 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690183324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+gui/W/WHJzu3QhStO9btHWOQO+wy1PQ5vDD5Fv4HM=;
        b=BP7Nqf8yYimkRFqSgSxfhV1hBOIi1Cq5yPvx+67svnLiQFmpztO1ao9j+aYzXMLlPBYvVc
        niTzb5KEkbNNuCjmuYEc05fIrog20dQ0nvHvjtZpv5j9YqvkUKpQSSZPQLow8+eqZ8XtG3
        VOvgmQe9e3ElzMP3S2Hv1eCvcdn/Azg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690183324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+gui/W/WHJzu3QhStO9btHWOQO+wy1PQ5vDD5Fv4HM=;
        b=DApkk9dGjQfujDwMM7xoA27Yc7WVIjSb0v9rmf1HLwcuLD5bEAni91HhpwMjpDwJs4dOOw
        u8wilupHYwXczaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D67713476;
        Mon, 24 Jul 2023 07:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UB6kBJwmvmS6XgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 24 Jul 2023 07:22:04 +0000
Message-ID: <dc25af5c-b170-2a6e-3da4-d3ad39cab7cc@suse.de>
Date:   Mon, 24 Jul 2023 09:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: WARNING: CPU: 1 PID: 67 at drivers/ata/libata-core.c:1688
 ata_read_log_page+0x173/0x1f0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, linux-ide@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 17:56, Borislav Petkov wrote:
> Hi,
> 
> this is with Linus' tree from Thursday, top commit:
> 
> commit f7e3a1bafdea735050dfde00523cf505dc7fd309 (refs/remotes/origin/master, refs/remotes/origin/HEAD, refs/heads/master)
> Merge: 12a5088eb138 28801cc85906
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Jul 20 20:35:38 2023 -0700
> 
>      Merge tag 'drm-fixes-2023-07-21' of git://anongit.freedesktop.org/drm/drm
> 
> and tip/master merged ontop:
> 
> ...
> [    3.435419] AVX version of gcm_enc/dec engaged.
> [    3.436188] AES CTR mode by8 optimization enabled
> [    4.181733] EXT4-fs (sdb2): mounted filesystem 1f347a17-b4a7-4d1c-bb60-5391961e8945 ro with ordered data mode. Quota mode: disabled.
> [    4.311786] ------------[ cut here ]------------
> [    4.312952] WARNING: CPU: 1 PID: 67 at drivers/ata/libata-core.c:1688 ata_read_log_page+0x173/0x1f0
> [    4.314124] Modules linked in: aesni_intel crypto_simd cryptd serio_raw thermal
> [    4.315296] CPU: 1 PID: 67 Comm: scsi_eh_2 Not tainted 6.5.0-rc2+ #1
> [    4.316483] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
> [    4.317653] RIP: 0010:ata_read_log_page+0x173/0x1f0
> [    4.318783] Code: ed 48 85 db 88 54 24 18 88 44 24 25 44 88 64 24 22 66 89 6c 24 20 44 88 74 24 1b 48 c7 44 24 10 07 00 00 00 0f 85 ee fe ff ff <0f> 0b e9 e7 fe ff ff 41 8b 4f 0c 81 e1 00 00 80 00 89 c8 f7 d8 18
> [    4.321370] RSP: 0018:ffffc90000cbbbc0 EFLAGS: 00010246
> [    4.322714] RAX: 0000000000000047 RBX: 0000000000000000 RCX: 0000000000000000
> [    4.324069] RDX: 0000000000000002 RSI: 000000000000000f RDI: 0000000000000400
> [    4.325401] RBP: 0000000000000f02 R08: 0000000000000002 R09: 0000000000000001
> [    4.326700] R10: 0000000000000000 R11: ffff888103cca290 R12: 0000000000000000
> [    4.328012] R13: 0000000000000001 R14: 0000000000000000 R15: ffff888104c02680
> [    4.329333] FS:  0000000000000000(0000) GS:ffff888211e80000(0000) knlGS:0000000000000000
> [    4.330652] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.331979] CR2: 00007f66683d99f0 CR3: 0000000002434005 CR4: 00000000001706e0
> [    4.333134] Call Trace:
> [    4.334239]  <TASK>
> [    4.335323]  ? ata_read_log_page+0x173/0x1f0
> [    4.336434]  ? __warn+0x81/0x170
> [    4.337364]  ? ata_read_log_page+0x173/0x1f0
> [    4.338270]  ? report_bug+0x18d/0x1c0
> [    4.339170]  ? handle_bug+0x3c/0x70
> [    4.340083]  ? exc_invalid_op+0x13/0x60
> [    4.340917]  ? asm_exc_invalid_op+0x16/0x20
> [    4.341732]  ? ata_read_log_page+0x173/0x1f0
> [    4.342538]  ? find_held_lock+0x2b/0x80
> [    4.343343]  ata_eh_read_sense_success_ncq_log+0x3f/0x1c0
> [    4.344179]  ata_eh_link_autopsy+0x7cd/0xc50
> [    4.344909]  ata_eh_autopsy+0x26/0xd0
> [    4.345612]  sata_pmp_error_handler+0x1e/0xa90
> [    4.346322]  ? lock_acquire+0xb9/0x290
> [    4.347036]  ? ata_wait_register+0x3f/0x90
> [    4.347779]  ahci_error_handler+0x3e/0x70
> [    4.348435]  ata_scsi_port_error_handler+0x37e/0x7e0
> [    4.349089]  ? __pfx_scsi_error_handler+0x10/0x10
> [    4.349743]  ata_scsi_error+0x93/0xc0
> [    4.350390]  scsi_error_handler+0xb0/0x570
> [    4.351031]  ? preempt_count_sub+0x9f/0xe0
> [    4.351685]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
> [    4.352271]  ? __pfx_scsi_error_handler+0x10/0x10
> [    4.352835]  kthread+0xf0/0x120
> [    4.353395]  ? __pfx_kthread+0x10/0x10
> [    4.353949]  ret_from_fork+0x30/0x50
> [    4.354502]  ? __pfx_kthread+0x10/0x10
> [    4.355053]  ret_from_fork_asm+0x1b/0x30
> [    4.355596] RIP: 0000:0x0
> [    4.356089] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [    4.356570] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
> [    4.357053] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    4.357530] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [    4.358000] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    4.358462] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    4.358882] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    4.359262]  </TASK>
> [    4.359632] irq event stamp: 1563
> [    4.359975] hardirqs last  enabled at (1573): [<ffffffff81130652>] __up_console_sem+0x52/0x60
> [    4.360320] hardirqs last disabled at (1582): [<ffffffff81130637>] __up_console_sem+0x37/0x60
> [    4.360664] softirqs last  enabled at (1010): [<ffffffff81bc6652>] __do_softirq+0x302/0x409
> [    4.361009] softirqs last disabled at (1001): [<ffffffff8109f8cf>] irq_exit_rcu+0x8f/0xf0
> [    4.361349] ---[ end trace 0000000000000000 ]---
> 
Does this help?

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 85e279a12f62..db1334d04d9c 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1492,6 +1492,10 @@ int ata_eh_read_sense_success_ncq_log(struct 
ata_link *link)
                         continue;
                 }

+               if (WARN_ON(!qc->scsicmd)) {
+                       qc->result_tf.status &= ~ATA_SENSE;
+                       continue;
+               }
                 /* Set sense without also setting scsicmd->result */
                 scsi_build_sense_buffer(dev->flags & ATA_DFLAG_D_SENSE,
                                         qc->scsicmd->sense_buffer, sk,


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


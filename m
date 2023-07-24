Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4179A75F577
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGXLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:51:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1FE59;
        Mon, 24 Jul 2023 04:51:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so6409592e87.1;
        Mon, 24 Jul 2023 04:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690199482; x=1690804282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F79hstkaIPK+hgj0WzRGJEtfg0dsetPw1/97mrZ36Bs=;
        b=LcZSqQ2s4ywBo1bFZjbGpYO2x/hgXdDCOt+ac+EMCREIMfA7kKr0pG79gOAsSI1kM9
         8+1U1/C11HPJse/8gi/G+KbAZ4WJGE4YtywkfgKdwM1g2UpaVg9Q9NCAHko838de18ZD
         phJOzFYUWLDsNyhqyRQbNLgZk8s9Fmh9iE9JY39bUZCN0zoaDqCqCD5MWeUxWTBPAnVj
         3pyvGA5wn3FCIU5k9fl4EY75lys54Sl+HYUE76o0gEw1RIrYLxy1+Epwj4a/sJTozxhZ
         P6E7URQJuFmz9vYHsTZ3pr/6KCWUP3Jj/ghmTPW3r5Lk2/C11FKGTbsGOhna7AQqHuxG
         byCA==
X-Gm-Message-State: ABy/qLZOKDflOwqc+nQiQzkMkKmjDduNEUwX8nyj4jyDOHDNKoOoQNiO
        bvN9FSrC9eeyvexpuEz8L9o=
X-Google-Smtp-Source: APBJJlFA68RDeTLu3xJmupwUgQmSuZSCbekItBIDHDtrwmmD5MEGCzd7fROoL/cz/qgyP6jaWsbB1w==
X-Received: by 2002:ac2:5dd2:0:b0:4f8:7781:9870 with SMTP id x18-20020ac25dd2000000b004f877819870mr4649817lfq.60.1690199481362;
        Mon, 24 Jul 2023 04:51:21 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id r10-20020ac252aa000000b004f1400630d3sm2185346lfm.35.2023.07.24.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:51:20 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 1001)
        id 8A5893F69; Mon, 24 Jul 2023 13:51:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1690199479; bh=3JI/wR3LJeXqLGzQVFjAZ5ybs2ZRBZ94cO6BqW0liFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTT91brZRRdu1ZZdV8Jug0Nik3wo9Fw1j4L9WEMKDeF0tEOa9XDh5s2QqMr9upnkU
         k1mstZMb5Vw/2DCYU3zVyptxcrfZrid2DeygRDJkeKTcPbZEVABJgDEkshIuR4CMOB
         +ZIcJBwWzZjOxRugmoDC5ZIy3oJLE1Iz2rZKCfSI=
Date:   Mon, 24 Jul 2023 13:51:19 +0200
From:   Niklas Cassel <nks@flawful.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 67 at drivers/ata/libata-core.c:1688
 ata_read_log_page+0x173/0x1f0
Message-ID: <ZL5lt+9jo1KrnW9b@flawful.org>
References: <20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722155621.GIZLv8JbURKzHtKvQE@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 05:56:21PM +0200, Borislav Petkov wrote:
> Hi,
> 
> this is with Linus' tree from Thursday, top commit:
> 
> commit f7e3a1bafdea735050dfde00523cf505dc7fd309 (refs/remotes/origin/master, refs/remotes/origin/HEAD, refs/heads/master)
> Merge: 12a5088eb138 28801cc85906
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Jul 20 20:35:38 2023 -0700
> 
>     Merge tag 'drm-fixes-2023-07-21' of git://anongit.freedesktop.org/drm/drm
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

Hello Boris,

this is a null pointer dereference,
because ap->ncq_sense_buf buffer is only allocated when CDL is enabled.

We are not supposed to fetch sense data for successful NCQ commands when
CDL is not enabled.

This is my bad.
Could you please test and see if this patch solves your problem:
https://lore.kernel.org/linux-ide/20230723130315.427513-1-nks@flawful.org/


Kind regards,
Niklas

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5587550D2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGPTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:06:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577C9F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:06:52 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3e1152c23so2761786b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689534412; x=1692126412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2EJe7w5jbMWQu8It0Umpap5mz11OkZDUZVRBPS5DT8=;
        b=BjH28TL0yayN1QLQTzVZ7G+eab5w4mB0Flqwd6JhGMiffhLmBsq8zm77412UsdEua3
         YVQA4QhIePcNlZS5sAdOJNLXVtX4JYLUcPZ4SfLMKMVlDeYfoqwzv1hw4mL/puPEjRC3
         98yyev6szVQ+zf23p7WEHB4V+/2okuA4+9Ot30/n12a104zvWjIbX7LhEO0GQ4TKExh5
         kweLZ+/6jC8SZa4f5T9aGIL2KV2mImoSBoz9WVgd3xagaqv9MIEU1iBlEKM8cdxBULki
         e6YLzSbYdzcrnxIv1xe48Zuqwc5gnbyXZTTdfyPeOXGjHd0bBEU7XiRZz4gItkqOjw3U
         uFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689534412; x=1692126412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2EJe7w5jbMWQu8It0Umpap5mz11OkZDUZVRBPS5DT8=;
        b=PZjMrx5fXoBK4/U5i/mDnI9m2kszsKCNGV4gHQk8OXN8FfZZP+d9z4ZCZSX/zH4y2X
         vw6P6XK8nMPcHZwfOkDX/6KMYVN1m8Tmo63U3atJtMhLmNz0QZIWJFBjd9Amfo3sbSB+
         NZRMsBd3YBAHC4H/fwb2QbFR9DGz+zWtRpCPf7UuJEn3CGmCJn2xSe54eN8KiM/NLKTL
         yoH5nPyqui3TRqLk/qXkRLQ90zG85Mo55qo+F0uRvmoep4vZ3Vzz9QgvtQi+bOXfT9tx
         j4WslrcSziY9js04tfXZRqL4XKe77WjKR3XMEFrEta9IId4C7dFtlGNJ1Epj8pJAqga4
         QIWw==
X-Gm-Message-State: ABy/qLYd12EQ7+K8XhqAQDkKtOjtiEJakkjeo3356SxKI4aljDKGTwan
        VIxpW2Z7Bv8OwrH19L89PJs=
X-Google-Smtp-Source: APBJJlFfIbmqytyP90M456/Aj4+BiCISQVlOFJgEdIplC5uM+smDVuZ1Hd77bXUq1Y83x/PAGh4i6w==
X-Received: by 2002:a05:6808:20aa:b0:3a1:eb0e:ddc6 with SMTP id s42-20020a05680820aa00b003a1eb0eddc6mr10834019oiw.29.1689534411744;
        Sun, 16 Jul 2023 12:06:51 -0700 (PDT)
Received: from geday ([2804:7f2:8006:6f85:a102:899f:bf55:3c0a])
        by smtp.gmail.com with ESMTPSA id 7-20020a4a0307000000b00565ef8db270sm6192456ooi.9.2023.07.16.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 12:06:51 -0700 (PDT)
Date:   Sun, 16 Jul 2023 16:06:52 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Subject: Re: [syzbot] [alsa?] memory leak in snd_seq_create_port
Message-ID: <ZLQ/zKgTGMHy/6Jn@geday>
References: <00000000000098ed3a0600965f89@google.com>
 <87v8ekattg.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8ekattg.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 03:07:23PM +0200, Takashi Iwai wrote:
> On Sun, 16 Jul 2023 10:21:49 +0200,
> syzbot wrote:
> > 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14b07344a80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=75da4f0a455bdbd3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cf8e7fa4eeec59b3d485
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15877dc2a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12905004a80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/441fb7ea58b8/disk-3f01e9fe.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/8fa7790ba0c3/vmlinux-3f01e9fe.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/5e7a6471dadf/bzImage-3f01e9fe.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com
> > 
> > Warning: Permanently added '10.128.1.1' (ED25519) to the list of known hosts.
> > executing program
> > executing program
> > BUG: memory leak
> > unreferenced object 0xffff888100877000 (size 512):
> >   comm "syz-executor257", pid 5012, jiffies 4294941742 (age 12.790s)
> >   hex dump (first 32 bytes):
> >     80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
> >     [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
> >     [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
> >     [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > BUG: memory leak
> > unreferenced object 0xffff888106742c00 (size 512):
> >   comm "syz-executor257", pid 5013, jiffies 4294942276 (age 7.450s)
> >   hex dump (first 32 bytes):
> >     80 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff83d29e28>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff83d29e28>] kzalloc include/linux/slab.h:703 [inline]
> >     [<ffffffff83d29e28>] snd_seq_create_port+0x78/0x300 sound/core/seq/seq_ports.c:135
> >     [<ffffffff83d1f681>] snd_seq_ioctl_create_port+0xe1/0x2a0 sound/core/seq/seq_clientmgr.c:1324
> >     [<ffffffff83d20e5e>] snd_seq_ioctl+0x13e/0x290 sound/core/seq/seq_clientmgr.c:2327
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Likely a forgotten kfree() at the error path.
> The patch below should fix it.
> 
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq: Fix memory leak at error path in
>  snd_seq_create_port()
> 
> We forgot to release a newly allocated item at the error path in
> snd_seq_create_port().  This patch fixes it.

Thanks for the clarification and quick proposed resolution Takashi. As
an ALSA novice these bots always stunt me, personally. I understand how
helpful they are however, even if cryptic.

But shouldn't this be reported to security? It's always prone to bad
stuff when we forget a kfree()

Thanks,
Geraldo Nascimento

> 
> Reported-by: syzbot+cf8e7fa4eeec59b3d485@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000098ed3a0600965f89@google.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_ports.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/core/seq/seq_ports.c b/sound/core/seq/seq_ports.c
> index 9b80f8275026..f3f14ff0f80f 100644
> --- a/sound/core/seq/seq_ports.c
> +++ b/sound/core/seq/seq_ports.c
> @@ -149,6 +149,7 @@ int snd_seq_create_port(struct snd_seq_client *client, int port,
>  	write_lock_irq(&client->ports_lock);
>  	list_for_each_entry(p, &client->ports_list_head, list) {
>  		if (p->addr.port == port) {
> +			kfree(new_port);
>  			num = -EBUSY;
>  			goto unlock;
>  		}
> -- 
> 2.35.3
> 

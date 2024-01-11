Return-Path: <linux-kernel+bounces-24045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A078882B5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C950B226D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52FE57886;
	Thu, 11 Jan 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uci4Xiaf"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106E5786A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so2989a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705005147; x=1705609947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7yqo8/vxPgdEZ20op4hQCP5wjF+VvptZnYD5LL2VHs=;
        b=Uci4XiafPqWDUyu0bxTx0E3qqDpDm1UWlOVtF8eGQBmnB/dgFQcQhu2V32OZqBzwKX
         XKPFXZKH2GHPfLTx8JbTTVN1dQR67cf3I+YEaMEwWNOgBVce2+6cugfk7ZgxUKCbEjlp
         LBfVG/BXLiKj80UUXW0gFHMPeSDhS+UftzJgpaH+nE47Pn5gh6f1gpfyfzuxHX+DU+Dx
         nBlRPrU2qJAfn+fc236Mz2zLM413O2JHdEjFmzPq2mCttRfZG/di0yWWqJy2DEo0ylud
         TZSdlmJ+Fl4MA32iNZcW9+McwEzlDN2RMvH/dZDDfZWZXBDihlXURc8qargpsnrKEmWw
         XIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005147; x=1705609947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7yqo8/vxPgdEZ20op4hQCP5wjF+VvptZnYD5LL2VHs=;
        b=aSRl8SfFxkB0bNMqYgVg2vAQH3IKuL15gPdn8KLpYmIpF3oBSNIR5uo7O3h3poe26J
         EakpZJbDMb8mUdVOf8LUiKBKanCZjbFEayq6g9iU4wRr/EE0UnMLZ1dAuic7vrWKRp+5
         nelgkpZoQTQa/7SgoxVnjoyxbj7ARb0B/O4RnuDj39lZKbGCg70cKOEC+/revsrFnZmi
         4UhwawVuiwg+rr1drVeYQWmhEkyB+aiCHdJTAiOuLghB6ZM8LFMv40ni4Zll3y1/ffQ4
         0lw72GcGR6IhUbuYLjMl5SqMgtz6CO5/Yezbhq109w2C3IHEBhkPo5X7rg3fIWlja68E
         WPSg==
X-Gm-Message-State: AOJu0YyVwYswYccWcNwnJNFf3dQ2c4xuIDK81AWO08We9UhzN8jMeKzJ
	7zFoVsVtMaJ2izkVa/HnLJpM/7efIlf8NPaBmb5Jcq8hNyZU
X-Google-Smtp-Source: AGHT+IE1dMC7MW4IB308dzQ3R9rW2x2xjDVCAGLyb3kOP2BrzTaNAQYBFTBx9/8B07pS+3nqvaFRQlk6mpvi8btloyY=
X-Received: by 2002:a05:6402:3587:b0:557:1142:d5bb with SMTP id
 y7-20020a056402358700b005571142d5bbmr183566edc.4.1705005147398; Thu, 11 Jan
 2024 12:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005abd7b060eb160cd@google.com>
In-Reply-To: <0000000000005abd7b060eb160cd@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jan 2024 21:32:13 +0100
Message-ID: <CANn89i+QhjV-C0kwNePnAj1YD+hx9mptaN8wjPoWG46SXcVTqQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in validate_xmit_skb
To: syzbot <syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:27=E2=80=AFPM syzbot
<syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1135ab95e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6b901=
aa3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7f4d0ea3df4d4fa=
9a65f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15e15379e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D170f6981e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/dis=
k-fbafc3e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinu=
x-fbafc3e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/b=
zImage-fbafc3e6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline]
> BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev.=
c:3629
>  skb_gso_segment include/net/gso.h:83 [inline]
>  validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
>  __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
>  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
>  packet_alloc_skb net/packet/af_packet.c:2936 [inline]
>  packet_snd net/packet/af_packet.c:3030 [inline]
>  packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-00=
003-gfbafc3e621c3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

```
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 27cc1d4643219a44c01a2404124cd45ef46f7f3d..4dfa9b69ca8d95d43e44831bc16=
6eadbe5715d3c
100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -3,6 +3,8 @@
 #define _LINUX_VIRTIO_NET_H

 #include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
@@ -49,6 +51,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *s=
kb,
                                        const struct virtio_net_hdr *hdr,
                                        bool little_endian)
 {
+       unsigned int nh_min_len =3D sizeof(struct iphdr);
        unsigned int gso_type =3D 0;
        unsigned int thlen =3D 0;
        unsigned int p_off =3D 0;
@@ -65,6 +68,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *s=
kb,
                        gso_type =3D SKB_GSO_TCPV6;
                        ip_proto =3D IPPROTO_TCP;
                        thlen =3D sizeof(struct tcphdr);
+                       nh_min_len =3D sizeof(struct ipv6hdr);
                        break;
                case VIRTIO_NET_HDR_GSO_UDP:
                        gso_type =3D SKB_GSO_UDP;
@@ -100,7 +104,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
                if (!skb_partial_csum_set(skb, start, off))
                        return -EINVAL;

-               p_off =3D skb_transport_offset(skb) + thlen;
+               nh_min_len =3D max_t(u32, nh_min_len, skb_transport_offset(=
skb));
+               p_off =3D nh_min_len + thlen;
                if (!pskb_may_pull(skb, p_off))
                        return -EINVAL;
        } else {
@@ -140,7 +145,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,

                        skb_set_transport_header(skb, keys.control.thoff);
                } else if (gso_type) {
-                       p_off =3D thlen;
+                       p_off =3D nh_min_len + thlen;
                        if (!pskb_may_pull(skb, p_off))
                                return -EINVAL;
                }
```


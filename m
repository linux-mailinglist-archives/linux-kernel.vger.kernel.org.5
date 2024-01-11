Return-Path: <linux-kernel+bounces-24046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D182B5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99651F25A07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D25789D;
	Thu, 11 Jan 2024 20:32:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCC57872
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc3dd97ddaso489095739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005149; x=1705609949;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwcO6jK5sgiSqaPGUzvXeIkEGbr3q6ZhWT7qbHBUtHg=;
        b=qqQdmiXq2f6XRXmQU+ro6Wg3IdEww8R52CFzU6Qa21TBaknNl/rn+2VPF8o5PbIZmq
         W2F0Y260x6Nen98lhKI8qnmWW1SPFGgz7B/EVm3hExnYp0i1bLcq3Ti9rrfGP4fO6biY
         ohWaO7rpBZaUEYa7sWmgpwFlOlTgd8KWEa7nFdgxsbWdxGL/kA0dwRWxwTKQv+T7sn8d
         1JIBm0anMV+pluEEkUldqIVJJEirDo8Bty9AtXD9nh1EwjWyJDZDpqWjXZ+xC7TS+uA4
         hMwc04jrKbUWmlBiuZPMclRIBYGDN+H4zIHdgfmjH+6ZdgUIdnUxZscomuqZvsTbEX/9
         6aLA==
X-Gm-Message-State: AOJu0Yw2PiGkW7VqZ/quyrz+8gNVq8enxolno4eMQ6+NAbyG5IIxtwxW
	Gi5b7+8Nohkw4J0+qPcnphml1vhYudK1lDrA1fYHU6xvLvbY
X-Google-Smtp-Source: AGHT+IGNm58p/PHn7Z2EADAwGuymLKHlAEYFV5vSqrX8l6LrbIvt/2gNfxbYcWLJDa7ddDrAPzgA6xPAxyFVLCKT561e+parrxK6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3791:b0:46e:5dfe:42af with SMTP id
 w17-20020a056638379100b0046e5dfe42afmr8688jal.0.1705005148780; Thu, 11 Jan
 2024 12:32:28 -0800 (PST)
Date: Thu, 11 Jan 2024 12:32:28 -0800
In-Reply-To: <CANn89i+QhjV-C0kwNePnAj1YD+hx9mptaN8wjPoWG46SXcVTqQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bc37c060eb172c5@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in validate_xmit_skb
From: syzbot <syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Thu, Jan 11, 2024 at 9:27=E2=80=AFPM syzbot
> <syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.o=
rg..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1135ab95e800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6b90=
1aa3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7f4d0ea3df4d4f=
a9a65f
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15e15379e8=
0000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D170f6981e800=
00
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/di=
sk-fbafc3e6.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlin=
ux-fbafc3e6.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/=
bzImage-fbafc3e6.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+7f4d0ea3df4d4fa9a65f@syzkaller.appspotmail.com
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> BUG: KMSAN: uninit-value in skb_gso_segment include/net/gso.h:83 [inline=
]
>> BUG: KMSAN: uninit-value in validate_xmit_skb+0x10f2/0x1930 net/core/dev=
c:3629
>>  skb_gso_segment include/net/gso.h:83 [inline]
>>  validate_xmit_skb+0x10f2/0x1930 net/core/dev.c:3629
>>  __dev_queue_xmit+0x1eac/0x5130 net/core/dev.c:4341
>>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>>  packet_snd net/packet/af_packet.c:3087 [inline]
>>  packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg net/socket.c:745 [inline]
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>>  __sys_sendmsg net/socket.c:2667 [inline]
>>  __do_sys_sendmsg net/socket.c:2676 [inline]
>>  __se_sys_sendmsg net/socket.c:2674 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>>
>> Uninit was created at:
>>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>>  slab_alloc_node mm/slub.c:3478 [inline]
>>  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
>>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>>  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
>>  alloc_skb include/linux/skbuff.h:1286 [inline]
>>  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
>>  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
>>  packet_alloc_skb net/packet/af_packet.c:2936 [inline]
>>  packet_snd net/packet/af_packet.c:3030 [inline]
>>  packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg net/socket.c:745 [inline]
>>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>>  __sys_sendmsg net/socket.c:2667 [inline]
>>  __do_sys_sendmsg net/socket.c:2676 [inline]
>>  __se_sys_sendmsg net/socket.c:2674 [inline]
>>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>>
>> CPU: 0 PID: 5025 Comm: syz-executor279 Not tainted 6.7.0-rc7-syzkaller-0=
0003-gfbafc3e621c3 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 11/17/2023
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t

want either no args or 2 args (repo, branch), got 1

> master
>
> ```
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 27cc1d4643219a44c01a2404124cd45ef46f7f3d..4dfa9b69ca8d95d43e44831bc=
166eadbe5715d3c
> 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -3,6 +3,8 @@
>  #define _LINUX_VIRTIO_NET_H
>
>  #include <linux/if_vlan.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
>  #include <linux/udp.h>
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
> @@ -49,6 +51,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
>                                         const struct virtio_net_hdr *hdr,
>                                         bool little_endian)
>  {
> +       unsigned int nh_min_len =3D sizeof(struct iphdr);
>         unsigned int gso_type =3D 0;
>         unsigned int thlen =3D 0;
>         unsigned int p_off =3D 0;
> @@ -65,6 +68,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
>                         gso_type =3D SKB_GSO_TCPV6;
>                         ip_proto =3D IPPROTO_TCP;
>                         thlen =3D sizeof(struct tcphdr);
> +                       nh_min_len =3D sizeof(struct ipv6hdr);
>                         break;
>                 case VIRTIO_NET_HDR_GSO_UDP:
>                         gso_type =3D SKB_GSO_UDP;
> @@ -100,7 +104,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>                 if (!skb_partial_csum_set(skb, start, off))
>                         return -EINVAL;
>
> -               p_off =3D skb_transport_offset(skb) + thlen;
> +               nh_min_len =3D max_t(u32, nh_min_len, skb_transport_offse=
t(skb));
> +               p_off =3D nh_min_len + thlen;
>                 if (!pskb_may_pull(skb, p_off))
>                         return -EINVAL;
>         } else {
> @@ -140,7 +145,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>
>                         skb_set_transport_header(skb, keys.control.thoff)=
;
>                 } else if (gso_type) {
> -                       p_off =3D thlen;
> +                       p_off =3D nh_min_len + thlen;
>                         if (!pskb_may_pull(skb, p_off))
>                                 return -EINVAL;
>                 }
> ```


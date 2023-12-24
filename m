Return-Path: <linux-kernel+bounces-10626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6514E81D7A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 03:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380E61F21C79
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 02:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A7EC4;
	Sun, 24 Dec 2023 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVA1WCi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37EA2C;
	Sun, 24 Dec 2023 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb968c02baso490405b6e.0;
        Sat, 23 Dec 2023 18:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703385397; x=1703990197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRrYAnSVA6RcfNCL+xsfzjFK9MoMvD679RpYA4s/J0k=;
        b=bVA1WCi9vI0gTfFpdxAm8K76JlIe6NMPuaOKHoawyuf+YE6oQjN8ptjHCY2tmyM80e
         4PP4owfOc0BkHsiXaS22r3uilySB2ZwAvWkltsyfKdCm8gBgtu6jZwIt+vbd5FAklXd/
         5SzfS6Rbv6WFkRrTo5AS7VuGIV8tqC4Sf2nkd6WjoFPnRa5rIWJF8v4hyRCA05ZNuRLA
         FcQEj/kxtst4s7D7Y1dBmtR7M9knxc9iHAXX3jumxk48KmrdS3Cw0i2hqk3/UPOES2qB
         hsoIZqhteG7q1G4l5AwayzXm7pyI9EiBbPG+5/vNqfTMpLyzswN/ZL5gTmAwN9XuC0tD
         JzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703385397; x=1703990197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRrYAnSVA6RcfNCL+xsfzjFK9MoMvD679RpYA4s/J0k=;
        b=g8NNMvTkTS22vNvAD57binSvjMDledzw8i2nKBqxjTVGhXNBflsHkzNslShF43GCBL
         EMc7bDsQoPrjQusV3Z40n2eHRAWpkfRmmGohJ8+r/AmSM70O6C2YrJ6CMzdRmGM50F/k
         0y431A0D6H9re2ourhnBo7CBqEN+c9nnS0FRD/KD/paUCt/ZnmoNM9qeGm5HQvfqfFxY
         lWUAl87OpNwXp/a4NDFIFlfcwvEt0ADwzN2LXSGAO4w6q5rvp0YC8zPDspg09+EmTIio
         GU9xiZIz5EPB6qZbdGUpzEsFaheYuiZRTjM3MA7g6g/bv8yclbH4dh1Q/MLKe1jXc2cy
         Nedg==
X-Gm-Message-State: AOJu0YxbcjjhwoN2GSCSibAMWNHr+sn2vdOCjh0OtZJHPPPkVIyIO0Zp
	Z84G9d/yeIVzvSSc+pCNRZz9yO1yZNVEogQScm0oSz8P8J4=
X-Google-Smtp-Source: AGHT+IEIYiCeyVVXrOMszQi9GUDhESdxB456yNTdzZrGJScEaVWZlbsT7890CUhZH8Q6kZy8Bja3sqtUb3Itq8wKJzE=
X-Received: by 2002:a05:6808:1a0d:b0:3b9:dab0:dea3 with SMTP id
 bk13-20020a0568081a0d00b003b9dab0dea3mr3880570oib.3.1703385397059; Sat, 23
 Dec 2023 18:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Sun, 24 Dec 2023 10:36:24 +0800
Message-ID: <CABOYnLxzB8udOY0Dm2zpgS6gNP0vA4mYLoyA4-CYkxM+mtYc1A@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in IP6_ECN_decapsulate
To: syzbot+bf7e6250c7ce248f3ec9@syzkaller.appspotmail.com
Cc: davem@davemloft.net, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yoshfuji@linux-ipv6.org, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug and comfired in the latest net tree.
Since I notice this is no stable reproducer in the syzbot dashboard.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel: net 7c5e046bdcb2513f9decb3765d8bf92d604279cf
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D4a=
65fa9f077ead01
with KMSAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

BUG: KMSAN: uninit-value in __INET_ECN_decapsulate
include/net/inet_ecn.h:253 [inline]
BUG: KMSAN: uninit-value in INET_ECN_decapsulate
include/net/inet_ecn.h:275 [inline]
BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7e0/0x1e10
include/net/inet_ecn.h:321
__INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
IP6_ECN_decapsulate+0x7e0/0x1e10 include/net/inet_ecn.h:321
ip6ip6_dscp_ecn_decapsulate+0x16f/0x1b0 net/ipv6/ip6_tunnel.c:727
__ip6_tnl_rcv+0xce4/0x1540 net/ipv6/ip6_tunnel.c:845
ip6_tnl_rcv+0xc0/0x100 net/ipv6/ip6_tunnel.c:888
gre_rcv+0x1493/0x18f0
ip6_protocol_deliver_rcu+0xc97/0x2970 net/ipv6/ip6_input.c:438
ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
NF_HOOK include/linux/netfilter.h:314 [inline]
ip6_input+0x14c/0x450 net/ipv6/ip6_input.c:492
ip6_mc_input+0x76a/0xc90 net/ipv6/ip6_input.c:586
dst_input include/net/dst.h:461 [inline]
ip6_rcv_finish+0x57f/0x860 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:314 [inline]
ipv6_rcv+0xf1/0x3b0 net/ipv6/ip6_input.c:310
__netif_receive_skb_one_core net/core/dev.c:5532 [inline]
__netif_receive_skb+0x1a9/0x5d0 net/core/dev.c:5646
netif_receive_skb_internal net/core/dev.c:5732 [inline]
netif_receive_skb+0x57/0x680 net/core/dev.c:5791
tun_rx_batched+0x1dd/0x980 drivers/net/tun.c:1555
tun_get_user+0x52d2/0x66c0 drivers/net/tun.c:2002
tun_chr_write_iter+0x3bf/0x5c0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:2020 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x92c/0x13f0 fs/read_write.c:584
ksys_write+0x1f3/0x4a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x97/0xf0 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Uninit was created at:
slab_post_alloc_hook+0x103/0x9e0 mm/slab.h:768
slab_alloc_node mm/slub.c:3478 [inline]
kmem_cache_alloc_node+0x5f7/0xb50 mm/slub.c:3523
kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:560
__alloc_skb+0x2fd/0x770 net/core/skbuff.c:651
alloc_skb include/linux/skbuff.h:1286 [inline]
alloc_skb_with_frags+0xcc/0x990 net/core/skbuff.c:6334
sock_alloc_send_pskb+0xa65/0xbe0 net/core/sock.c:2780
tun_alloc_skb drivers/net/tun.c:1531 [inline]
tun_get_user+0x1f8b/0x66c0 drivers/net/tun.c:1846
tun_chr_write_iter+0x3bf/0x5c0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:2020 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x92c/0x13f0 fs/read_write.c:584
ksys_write+0x1f3/0x4a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x97/0xf0 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
CPU: 0 PID: 8668 Comm: 6fe Not tainted 6.7.0-rc6-00157-g7c5e046bdcb2 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

=3D* repro.c =3D*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] =3D 0;
 int len =3D strlen(buf);
 int fd =3D open(file, O_WRONLY | O_CLOEXEC);
 if (fd =3D=3D -1) return false;
 if (write(fd, buf, len) !=3D len) {
   int err =3D errno;
   close(fd);
   errno =3D err;
   return false;
 }
 close(fd);
 return true;
}

struct nlmsg {
 char* pos;
 int nesting;
 struct nlattr* nested[8];
 char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
                        const void* data, int size) {
 memset(nlmsg, 0, sizeof(*nlmsg));
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_type =3D typ;
 hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
 memcpy(hdr + 1, data, size);
 nlmsg->pos =3D (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
                        int size) {
 struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
 attr->nla_len =3D sizeof(*attr) + size;
 attr->nla_type =3D typ;
 if (size > 0) memcpy(attr + 1, data, size);
 nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ) {
 struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
 attr->nla_type =3D typ;
 nlmsg->pos +=3D sizeof(*attr);
 nlmsg->nested[nlmsg->nesting++] =3D attr;
}

static void netlink_done(struct nlmsg* nlmsg) {
 struct nlattr* attr =3D nlmsg->nested[--nlmsg->nesting];
 attr->nla_len =3D nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t reply_t=
ype,
                           int* reply_len, bool dofail) {
 if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting) exit(1=
);
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
 struct sockaddr_nl addr;
 memset(&addr, 0, sizeof(addr));
 addr.nl_family =3D AF_NETLINK;
 ssize_t n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                    (struct sockaddr*)&addr, sizeof(addr));
 if (n !=3D (ssize_t)hdr->nlmsg_len) {
   if (dofail) exit(1);
   return -1;
 }
 n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 if (reply_len) *reply_len =3D 0;
 if (n < 0) {
   if (dofail) exit(1);
   return -1;
 }
 if (n < (ssize_t)sizeof(struct nlmsghdr)) {
   errno =3D EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 if (hdr->nlmsg_type =3D=3D NLMSG_DONE) return 0;
 if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
   *reply_len =3D n;
   return 0;
 }
 if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
   errno =3D EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 if (hdr->nlmsg_type !=3D NLMSG_ERROR) {
   errno =3D EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 errno =3D -((struct nlmsgerr*)(hdr + 1))->error;
 return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock) {
 return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg, int sock,
                                  const char* family_name, bool dofail) {
 struct genlmsghdr genlhdr;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd =3D CTRL_CMD_GETFAMILY;
 netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
              strnlen(family_name, GENL_NAMSIZ - 1) + 1);
 int n =3D 0;
 int err =3D netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
 if (err < 0) {
   return -1;
 }
 uint16_t id =3D 0;
 struct nlattr* attr =3D (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                        NLMSG_ALIGN(sizeof(genlhdr)));
 for (; (char*)attr < nlmsg->buf + n;
      attr =3D (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) =
{
   if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
     id =3D *(uint16_t*)(attr + 1);
     break;
   }
 }
 if (!id) {
   errno =3D EINVAL;
   return -1;
 }
 recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 return id;
}

static int netlink_next_msg(struct nlmsg* nlmsg, unsigned int offset,
                           unsigned int total_len) {
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)(nlmsg->buf + offset);
 if (offset =3D=3D total_len || offset + hdr->nlmsg_len > total_len) return=
 -1;
 return hdr->nlmsg_len;
}

static void netlink_add_device_impl(struct nlmsg* nlmsg, const char* type,
                                   const char* name, bool up) {
 struct ifinfomsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 if (up) hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
 netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
              sizeof(hdr));
 if (name) netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
 netlink_nest(nlmsg, IFLA_LINKINFO);
 netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg, int sock, const char* t=
ype,
                              const char* name) {
 netlink_add_device_impl(nlmsg, type, name, false);
 netlink_done(nlmsg);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_veth(struct nlmsg* nlmsg, int sock, const char* nam=
e,
                            const char* peer) {
 netlink_add_device_impl(nlmsg, "veth", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_nest(nlmsg, VETH_INFO_PEER);
 nlmsg->pos +=3D sizeof(struct ifinfomsg);
 netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_xfrm(struct nlmsg* nlmsg, int sock, const char* nam=
e) {
 netlink_add_device_impl(nlmsg, "xfrm", name, true);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 int if_id =3D 1;
 netlink_attr(nlmsg, 2, &if_id, sizeof(if_id));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_hsr(struct nlmsg* nlmsg, int sock, const char* name=
,
                           const char* slave1, const char* slave2) {
 netlink_add_device_impl(nlmsg, "hsr", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 int ifindex1 =3D if_nametoindex(slave1);
 netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
 int ifindex2 =3D if_nametoindex(slave2);
 netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_linked(struct nlmsg* nlmsg, int sock, const char* t=
ype,
                              const char* name, const char* link) {
 netlink_add_device_impl(nlmsg, type, name, false);
 netlink_done(nlmsg);
 int ifindex =3D if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_vlan(struct nlmsg* nlmsg, int sock, const char* nam=
e,
                            const char* link, uint16_t id, uint16_t proto) =
{
 netlink_add_device_impl(nlmsg, "vlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
 netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex =3D if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_macvlan(struct nlmsg* nlmsg, int sock, const char* =
name,
                               const char* link) {
 netlink_add_device_impl(nlmsg, "macvlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 uint32_t mode =3D MACVLAN_MODE_BRIDGE;
 netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex =3D if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_geneve(struct nlmsg* nlmsg, int sock, const char* n=
ame,
                              uint32_t vni, struct in_addr* addr4,
                              struct in6_addr* addr6) {
 netlink_add_device_impl(nlmsg, "geneve", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
 if (addr4) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
 if (addr6) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6))=
;
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

#define IFLA_IPVLAN_FLAGS 2
#define IPVLAN_MODE_L3S 2
#undef IPVLAN_F_VEPA
#define IPVLAN_F_VEPA 2

static void netlink_add_ipvlan(struct nlmsg* nlmsg, int sock, const char* n=
ame,
                              const char* link, uint16_t mode,
                              uint16_t flags) {
 netlink_add_device_impl(nlmsg, "ipvlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
 netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex =3D if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock,
                                 const char* name, bool up, const char* mas=
ter,
                                 const void* mac, int macsize,
                                 const char* new_name) {
 struct ifinfomsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 if (up) hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
 hdr.ifi_index =3D if_nametoindex(name);
 netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
 if (new_name) netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name))=
;
 if (master) {
   int ifindex =3D if_nametoindex(master);
   netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
 }
 if (macsize) netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static int netlink_add_addr(struct nlmsg* nlmsg, int sock, const char* dev,
                           const void* addr, int addrsize) {
 struct ifaddrmsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 hdr.ifa_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
 hdr.ifa_prefixlen =3D addrsize =3D=3D 4 ? 24 : 120;
 hdr.ifa_scope =3D RT_SCOPE_UNIVERSE;
 hdr.ifa_index =3D if_nametoindex(dev);
 netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
              sizeof(hdr));
 netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
 netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
 return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg, int sock, const char* de=
v,
                             const char* addr) {
 struct in_addr in_addr;
 inet_pton(AF_INET, addr, &in_addr);
 int err =3D netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
 if (err < 0) {
 }
}

static void netlink_add_addr6(struct nlmsg* nlmsg, int sock, const char* de=
v,
                             const char* addr) {
 struct in6_addr in6_addr;
 inet_pton(AF_INET6, addr, &in6_addr);
 int err =3D netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr)=
);
 if (err < 0) {
 }
}

static struct nlmsg nlmsg;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name, const char* dev_=
name,
                                    const char* netdev_prefix) {
 struct genlmsghdr genlhdr;
 int len, total_len, id, err, offset;
 uint16_t netdev_index;
 int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
 if (sock =3D=3D -1) exit(1);
 int rtsock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (rtsock =3D=3D -1) exit(1);
 id =3D netlink_query_family_id(&nlmsg, sock, DEVLINK_FAMILY_NAME, true);
 if (id =3D=3D -1) goto error;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd =3D DEVLINK_CMD_PORT_GET;
 netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1=
);
 netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1=
);
 err =3D netlink_send_ext(&nlmsg, sock, id, &total_len, true);
 if (err < 0) {
   goto error;
 }
 offset =3D 0;
 netdev_index =3D 0;
 while ((len =3D netlink_next_msg(&nlmsg, offset, total_len)) !=3D -1) {
   struct nlattr* attr =3D (struct nlattr*)(nlmsg.buf + offset + NLMSG_HDRL=
EN +
                                          NLMSG_ALIGN(sizeof(genlhdr)));
   for (; (char*)attr < nlmsg.buf + offset + len;
        attr =3D (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))=
) {
     if (attr->nla_type =3D=3D DEVLINK_ATTR_NETDEV_NAME) {
       char* port_name;
       char netdev_name[IFNAMSIZ];
       port_name =3D (char*)(attr + 1);
       snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
                netdev_index);
       netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
                             netdev_name);
       break;
     }
   }
   offset +=3D len;
   netdev_index++;
 }
error:
 close(rtsock);
 close(sock);
}

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void netdevsim_add(unsigned int addr, unsigned int port_count) {
 write_file("/sys/bus/netdevsim/del_device", "%u", addr);
 if (write_file("/sys/bus/netdevsim/new_device", "%u %u", addr, port_count)=
) {
   char buf[32];
   snprintf(buf, sizeof(buf), "netdevsim%d", addr);
   initialize_devlink_ports("netdevsim", buf, "netdevsim");
 }
}

#define WG_GENL_NAME "wireguard"
enum wg_cmd {
 WG_CMD_GET_DEVICE,
 WG_CMD_SET_DEVICE,
};
enum wgdevice_attribute {
 WGDEVICE_A_UNSPEC,
 WGDEVICE_A_IFINDEX,
 WGDEVICE_A_IFNAME,
 WGDEVICE_A_PRIVATE_KEY,
 WGDEVICE_A_PUBLIC_KEY,
 WGDEVICE_A_FLAGS,
 WGDEVICE_A_LISTEN_PORT,
 WGDEVICE_A_FWMARK,
 WGDEVICE_A_PEERS,
};
enum wgpeer_attribute {
 WGPEER_A_UNSPEC,
 WGPEER_A_PUBLIC_KEY,
 WGPEER_A_PRESHARED_KEY,
 WGPEER_A_FLAGS,
 WGPEER_A_ENDPOINT,
 WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
 WGPEER_A_LAST_HANDSHAKE_TIME,
 WGPEER_A_RX_BYTES,
 WGPEER_A_TX_BYTES,
 WGPEER_A_ALLOWEDIPS,
 WGPEER_A_PROTOCOL_VERSION,
};
enum wgallowedip_attribute {
 WGALLOWEDIP_A_UNSPEC,
 WGALLOWEDIP_A_FAMILY,
 WGALLOWEDIP_A_IPADDR,
 WGALLOWEDIP_A_CIDR_MASK,
};

static void netlink_wireguard_setup(void) {
 const char ifname_a[] =3D "wg0";
 const char ifname_b[] =3D "wg1";
 const char ifname_c[] =3D "wg2";
 const char private_a[] =3D
     "\xa0\x5c\xa8\x4f\x6c\x9c\x8e\x38\x53\xe2\xfd\x7a\x70\xae\x0f\xb2\x0f\=
xa1"
     "\x52\x60\x0c\xb0\x08\x45\x17\x4f\x08\x07\x6f\x8d\x78\x43";
 const char private_b[] =3D
     "\xb0\x80\x73\xe8\xd4\x4e\x91\xe3\xda\x92\x2c\x22\x43\x82\x44\xbb\x88\=
x5c"
     "\x69\xe2\x69\xc8\xe9\xd8\x35\xb1\x14\x29\x3a\x4d\xdc\x6e";
 const char private_c[] =3D
     "\xa0\xcb\x87\x9a\x47\xf5\xbc\x64\x4c\x0e\x69\x3f\xa6\xd0\x31\xc7\x4a\=
x15"
     "\x53\xb6\xe9\x01\xb9\xff\x2f\x51\x8c\x78\x04\x2f\xb5\x42";
 const char public_a[] =3D
     "\x97\x5c\x9d\x81\xc9\x83\xc8\x20\x9e\xe7\x81\x25\x4b\x89\x9f\x8e\xd9\=
x25"
     "\xae\x9f\x09\x23\xc2\x3c\x62\xf5\x3c\x57\xcd\xbf\x69\x1c";
 const char public_b[] =3D
     "\xd1\x73\x28\x99\xf6\x11\xcd\x89\x94\x03\x4d\x7f\x41\x3d\xc9\x57\x63\=
x0e"
     "\x54\x93\xc2\x85\xac\xa4\x00\x65\xcb\x63\x11\xbe\x69\x6b";
 const char public_c[] =3D
     "\xf4\x4d\xa3\x67\xa8\x8e\xe6\x56\x4f\x02\x02\x11\x45\x67\x27\x08\x2f\=
x5c"
     "\xeb\xee\x8b\x1b\xf5\xeb\x73\x37\x34\x1b\x45\x9b\x39\x22";
 const uint16_t listen_a =3D 20001;
 const uint16_t listen_b =3D 20002;
 const uint16_t listen_c =3D 20003;
 const uint16_t af_inet =3D AF_INET;
 const uint16_t af_inet6 =3D AF_INET6;
 const struct sockaddr_in endpoint_b_v4 =3D {
     .sin_family =3D AF_INET,
     .sin_port =3D htons(listen_b),
     .sin_addr =3D {htonl(INADDR_LOOPBACK)}};
 const struct sockaddr_in endpoint_c_v4 =3D {
     .sin_family =3D AF_INET,
     .sin_port =3D htons(listen_c),
     .sin_addr =3D {htonl(INADDR_LOOPBACK)}};
 struct sockaddr_in6 endpoint_a_v6 =3D {.sin6_family =3D AF_INET6,
                                      .sin6_port =3D htons(listen_a)};
 endpoint_a_v6.sin6_addr =3D in6addr_loopback;
 struct sockaddr_in6 endpoint_c_v6 =3D {.sin6_family =3D AF_INET6,
                                      .sin6_port =3D htons(listen_c)};
 endpoint_c_v6.sin6_addr =3D in6addr_loopback;
 const struct in_addr first_half_v4 =3D {0};
 const struct in_addr second_half_v4 =3D {(uint32_t)htonl(128 << 24)};
 const struct in6_addr first_half_v6 =3D {{{0}}};
 const struct in6_addr second_half_v6 =3D {{{0x80}}};
 const uint8_t half_cidr =3D 1;
 const uint16_t persistent_keepalives[] =3D {1, 3, 7, 9, 14, 19};
 struct genlmsghdr genlhdr =3D {.cmd =3D WG_CMD_SET_DEVICE, .version =3D 1}=
;
 int sock;
 int id, err;
 sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
 if (sock =3D=3D -1) {
   return;
 }
 id =3D netlink_query_family_id(&nlmsg, sock, WG_GENL_NAME, true);
 if (id =3D=3D -1) goto error;
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_a, strlen(ifname_a) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_a, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_a, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
              sizeof(endpoint_b_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[0], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v6,
              sizeof(endpoint_c_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[1], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err =3D netlink_send(&nlmsg, sock);
 if (err < 0) {
 }
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_b, strlen(ifname_b) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_b, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_b, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
              sizeof(endpoint_a_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[2], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v4,
              sizeof(endpoint_c_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[3], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err =3D netlink_send(&nlmsg, sock);
 if (err < 0) {
 }
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_c, strlen(ifname_c) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_c, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_c, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
              sizeof(endpoint_a_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[4], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
              sizeof(endpoint_b_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[5], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err =3D netlink_send(&nlmsg, sock);
 if (err < 0) {
 }

error:
 close(sock);
}

static void initialize_netdevices(void) {
 char netdevsim[16];
 sprintf(netdevsim, "netdevsim%d", (int)procid);
 struct {
   const char* type;
   const char* dev;
 } devtypes[] =3D {
     {"ip6gretap", "ip6gretap0"}, {"bridge", "bridge0"}, {"vcan", "vcan0"},
     {"bond", "bond0"},           {"team", "team0"},     {"dummy", "dummy0"=
},
     {"nlmon", "nlmon0"},         {"caif", "caif0"},     {"batadv", "batadv=
0"},
     {"vxcan", "vxcan1"},         {"veth", 0},           {"wireguard", "wg0=
"},
     {"wireguard", "wg1"},        {"wireguard", "wg2"},
 };
 const char* devmasters[] =3D {"bridge", "bond", "team", "batadv"};
 struct {
   const char* name;
   int macsize;
   bool noipv6;
 } devices[] =3D {
     {"lo", ETH_ALEN},
     {"sit0", 0},
     {"bridge0", ETH_ALEN},
     {"vcan0", 0, true},
     {"tunl0", 0},
     {"gre0", 0},
     {"gretap0", ETH_ALEN},
     {"ip_vti0", 0},
     {"ip6_vti0", 0},
     {"ip6tnl0", 0},
     {"ip6gre0", 0},
     {"ip6gretap0", ETH_ALEN},
     {"erspan0", ETH_ALEN},
     {"bond0", ETH_ALEN},
     {"veth0", ETH_ALEN},
     {"veth1", ETH_ALEN},
     {"team0", ETH_ALEN},
     {"veth0_to_bridge", ETH_ALEN},
     {"veth1_to_bridge", ETH_ALEN},
     {"veth0_to_bond", ETH_ALEN},
     {"veth1_to_bond", ETH_ALEN},
     {"veth0_to_team", ETH_ALEN},
     {"veth1_to_team", ETH_ALEN},
     {"veth0_to_hsr", ETH_ALEN},
     {"veth1_to_hsr", ETH_ALEN},
     {"hsr0", 0},
     {"dummy0", ETH_ALEN},
     {"nlmon0", 0},
     {"vxcan0", 0, true},
     {"vxcan1", 0, true},
     {"caif0", ETH_ALEN},
     {"batadv0", ETH_ALEN},
     {netdevsim, ETH_ALEN},
     {"xfrm0", ETH_ALEN},
     {"veth0_virt_wifi", ETH_ALEN},
     {"veth1_virt_wifi", ETH_ALEN},
     {"virt_wifi0", ETH_ALEN},
     {"veth0_vlan", ETH_ALEN},
     {"veth1_vlan", ETH_ALEN},
     {"vlan0", ETH_ALEN},
     {"vlan1", ETH_ALEN},
     {"macvlan0", ETH_ALEN},
     {"macvlan1", ETH_ALEN},
     {"ipvlan0", ETH_ALEN},
     {"ipvlan1", ETH_ALEN},
     {"veth0_macvtap", ETH_ALEN},
     {"veth1_macvtap", ETH_ALEN},
     {"macvtap0", ETH_ALEN},
     {"macsec0", ETH_ALEN},
     {"veth0_to_batadv", ETH_ALEN},
     {"veth1_to_batadv", ETH_ALEN},
     {"batadv_slave_0", ETH_ALEN},
     {"batadv_slave_1", ETH_ALEN},
     {"geneve0", ETH_ALEN},
     {"geneve1", ETH_ALEN},
     {"wg0", 0},
     {"wg1", 0},
     {"wg2", 0},
 };
 int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (sock =3D=3D -1) exit(1);
 unsigned i;
 for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
   netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
 for (i =3D 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
   char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
   sprintf(slave0, "%s_slave_0", devmasters[i]);
   sprintf(veth0, "veth0_to_%s", devmasters[i]);
   netlink_add_veth(&nlmsg, sock, slave0, veth0);
   sprintf(slave1, "%s_slave_1", devmasters[i]);
   sprintf(veth1, "veth1_to_%s", devmasters[i]);
   netlink_add_veth(&nlmsg, sock, slave1, veth1);
   sprintf(master, "%s0", devmasters[i]);
   netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL);
   netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL);
 }
 netlink_add_xfrm(&nlmsg, sock, "xfrm0");
 netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NULL)=
;
 netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NULL)=
;
 netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
 netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
 netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
 netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
 netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
 netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
 netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0",
                    "veth1_virt_wifi");
 netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
 netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_8021Q=
));
 netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_8021A=
D));
 netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
 netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
 netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L2, =
0);
 netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L3S,
                    IPVLAN_F_VEPA);
 netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
 netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap");
 netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
 char addr[32];
 sprintf(addr, DEV_IPV4, 14 + 10);
 struct in_addr geneve_addr4;
 if (inet_pton(AF_INET, addr, &geneve_addr4) <=3D 0) exit(1);
 struct in6_addr geneve_addr6;
 if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <=3D 0) exit(1);
 netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
 netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
 netdevsim_add((int)procid, 4);
 netlink_wireguard_setup();
 for (i =3D 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
   char addr[32];
   sprintf(addr, DEV_IPV4, i + 10);
   netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
   if (!devices[i].noipv6) {
     sprintf(addr, DEV_IPV6, i + 10);
     netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
   }
   uint64_t macaddr =3D DEV_MAC + ((i + 10ull) << 40);
   netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macaddr,
                         devices[i].macsize, NULL);
 }
 close(sock);
}
static void initialize_netdevices_init(void) {
 int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (sock =3D=3D -1) exit(1);
 struct {
   const char* type;
   int macsize;
   bool noipv6;
   bool noup;
 } devtypes[] =3D {
     {"nr", 7, true},
     {"rose", 5, true, true},
 };
 unsigned i;
 for (i =3D 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
   char dev[32], addr[32];
   sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
   sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
   netlink_add_addr4(&nlmsg, sock, dev, addr);
   if (!devtypes[i].noipv6) {
     sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
     netlink_add_addr6(&nlmsg, sock, dev, addr);
   }
   int macsize =3D devtypes[i].macsize;
   uint64_t macaddr =3D 0xbbbbbb +
                      ((unsigned long long)i << (8 * (macsize - 2))) +
                      (procid << (8 * (macsize - 1)));
   netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macaddr,
                         macsize, NULL);
 }
 close(sock);
}

#define MAX_FDS 30

static void setup_common() {
 if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
 }
}

static void setup_binderfs() {
 if (mkdir("/dev/binderfs", 0777)) {
 }
 if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
 }
 if (symlink("/dev/binderfs", "./binderfs")) {
 }
}

static void loop();

static void sandbox_common() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setsid();
 struct rlimit rlim;
 rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
 setrlimit(RLIMIT_AS, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
 setrlimit(RLIMIT_MEMLOCK, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
 setrlimit(RLIMIT_FSIZE, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
 setrlimit(RLIMIT_STACK, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 128 << 20;
 setrlimit(RLIMIT_CORE, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 256;
 setrlimit(RLIMIT_NOFILE, &rlim);
 if (unshare(CLONE_NEWNS)) {
 }
 if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
 }
 if (unshare(CLONE_NEWIPC)) {
 }
 if (unshare(0x02000000)) {
 }
 if (unshare(CLONE_NEWUTS)) {
 }
 if (unshare(CLONE_SYSVSEM)) {
 }
 typedef struct {
   const char* name;
   const char* value;
 } sysctl_t;
 static const sysctl_t sysctls[] =3D {
     {"/proc/sys/kernel/shmmax", "16777216"},
     {"/proc/sys/kernel/shmall", "536870912"},
     {"/proc/sys/kernel/shmmni", "1024"},
     {"/proc/sys/kernel/msgmax", "8192"},
     {"/proc/sys/kernel/msgmni", "1024"},
     {"/proc/sys/kernel/msgmnb", "1024"},
     {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
 };
 unsigned i;
 for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
   write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
 if (pid < 0) exit(1);
 int status =3D 0;
 while (waitpid(-1, &status, __WALL) !=3D pid) {
 }
 return WEXITSTATUS(status);
}

static void drop_caps(void) {
 struct __user_cap_header_struct cap_hdr =3D {};
 struct __user_cap_data_struct cap_data[2] =3D {};
 cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
 cap_hdr.pid =3D getpid();
 if (syscall(SYS_capget, &cap_hdr, &cap_data)) exit(1);
 const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
 cap_data[0].effective &=3D ~drop;
 cap_data[0].permitted &=3D ~drop;
 cap_data[0].inheritable &=3D ~drop;
 if (syscall(SYS_capset, &cap_hdr, &cap_data)) exit(1);
}

static int do_sandbox_none(void) {
 if (unshare(CLONE_NEWPID)) {
 }
 int pid =3D fork();
 if (pid !=3D 0) return wait_for_loop(pid);
 setup_common();
 sandbox_common();
 drop_caps();
 initialize_netdevices_init();
 if (unshare(CLONE_NEWNET)) {
 }
 write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
 initialize_netdevices();
 setup_binderfs();
 loop();
 exit(1);
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i =3D 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid) return;
   usleep(1000);
 }
 DIR* dir =3D opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent =3D readdir(dir);
     if (!ent) break;
     if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=
=3D 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd =3D open(abort, O_WRONLY);
     if (fd =3D=3D -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) !=3D pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds() {
 for (int fd =3D 3; fd < MAX_FDS; fd++) close(fd);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter =3D 0;
 for (;; iter++) {
   int pid =3D fork();
   if (pid < 0) exit(1);
   if (pid =3D=3D 0) {
     setup_test();
     execute_one();
     close_fds();
     exit(0);
   }
   int status =3D 0;
   uint64_t start =3D current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid) break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000) continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void) {
 intptr_t res =3D 0;
 memcpy((void*)0x20000080, "/dev/net/tun\000", 13);
 res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0x2=
0000080ul,
               /*flags=3D*/0x88002ul, /*mode=3D*/0ul);
 if (res !=3D -1) r[0] =3D res;
 memcpy((void*)0x20000040, "syzkaller1\000\000\000\000\000\000", 16);
 *(uint16_t*)0x20000050 =3D 0x5001;
 syscall(__NR_ioctl, /*fd=3D*/r[0], /*cmd=3D*/0x400454ca, /*arg=3D*/0x20000=
040ul);
 res =3D syscall(__NR_socket, /*domain=3D*/0x10ul, /*type=3D*/3ul, /*proto=
=3D*/0);
 if (res !=3D -1) r[1] =3D res;
 memcpy((void*)0x20000140, "syzkaller1\000\000\000\000\000\000", 16);
 *(uint16_t*)0x20000150 =3D 7;
 *(uint16_t*)0x20000152 =3D htobe16(0);
 *(uint32_t*)0x20000154 =3D htobe32(0);
 syscall(__NR_ioctl, /*fd=3D*/r[1], /*cmd=3D*/0x8914, /*arg=3D*/0x20000140u=
l);
 memcpy(
     (void*)0x20002580,
     "\x07\x03\x00\x00\x00\x04\x00\x00\x00\x00\x60\x2d\x2a\xe1\x0f\x98\x2f\=
x00"
     "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\=
x02"
     "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x88\=
x3e"
     "\x00\x00\x02\x00\x00\x00\x00\x00\x68\x00\x00\x00\x00\xcf\x00\x00\x00\=
x00"
     "\x00\x00\x00\xd1\x14\xb1\x39\x16\x5a\xf3\x20\x91\xba\x89\x0f\x11\x43\=
x69"
     "\x7d\x60\xff\x6f\xbf\x67\x4d\xa1\x99\x5e\x0c\xd4\x90\x05\x05\xf2\xce\=
xb4"
     "\x4d\xcd\x98\x20\x9d\x1d\x99\x47\xfc\x39\x6b\xfb\x08\x71\xe6\x49\x13\=
x13"
     "\xcf\xe0\x78\x8a\x50\x74\xe8\x9e\x8a\xe3\xba\x8d\xf7\xe6\x87\x7d\x0b\=
x40"
     "\xee\xec\x0e\x36\x2d\x17\xeb\x2f\x71\x80\x2b\xb6\x0e\xa9\x7b\x5a\xfc\=
x81"
     "\x0d\x37\xd1\x54\xe4\x7b\x04\x4a\xb8\x0e\x72\x38\x58\x8f\xbf\x37\xde\=
xc7"
     "\x82\xb8\xb1\xbc\xc0\x95\x01\x73\x79\x14\x56\x95\x9f\x80\x3d\x61\xb0\=
x56"
     "\x31\xef\xbb\xfc\xce\xbe\xaf\xef\x57\xbd\x95\x63\xc2\x7e\xc7\xe5\x0d\=
xdb"
     "\x67\x18\xb4\xa2\xac\xa7\x20\xfd\x86\x62\xc6\x71\x3d\x50\x7f\x08\xb8\=
xed"
     "\x95\x62\x2e\xbe\xbe\x3a\x02\xb9\x76\x44\xe2\x40\xf3\x04\x23\xfb\xaa\=
x33"
     "\x9c\x43\x3d\x6b\x41\xf6\xdb\x76\x70\xa5\xaf\x4b\x2f\x17\x2e\x64\xc2\=
xe5"
     "\xb4\x0b\x8f\x6b\x37\xc2\xe6\x44\x21\xd0\x33\x1a\xff\x52\xb9\xc9\x10\=
xff"
     "\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x01\=
x00"
     "\x00\x01\x00\x00\x8c\xb3\x7d\x45\x18\xd6\xae\x13\xad\xdd\x27\x1c\xa3\=
x9d"
     "\x04\x8e\xd6\xd8\x30\xfc\x13\x40\x62\x36\xe5\xb6\x7f\x4c\xda\xd0\x86\=
x7d"
     "\xff\x7a\x4d\x54\x4a\x31\xa8\x95\xf0\xe9\x67\xa2\xaa\x3a\xaa\x21\x95\=
xcd"
     "\x11\x81\x1a\x8e\x0c\x3b\x78\xa3\x01\xb1\xd4\xcf\xcf\xf4\xa6\x9f\xac\=
x54"
     "\x6d\xb9\xf8\x17\x07\xb4\x2c\x40\x98\xb6\x79\x46\x9e\xfe\x5b\x8e\xe7\=
x1c"
     "\x87\x96\xbb\x12\xe3\xe2\x64\x1e\xf4\x0d\xa6\x63\xe4\x02\xc9\x62\xf7\=
xe1"
     "\xd9\x95\x3e\x53\x64\x5f\x6f\xfd\xa6\x98\x7d\xb8\x4b\x9a\x80\x6c\x7c\=
x2f"
     "\xe0\xa6\x9d\x4d\xb3\xfd\x31\x4b\x37\x41\x0f\xa0\xe6\x5c\x56\x14\x9b\=
xde"
     "\x13\xbd\xf8\x92\x42\x41\x1d\xc1\x97\xea\xfa\xfd\x76\xa0\x7e\x83\xf3\=
xc8"
     "\xb2\xab\x12\x61\xcc\x75\x63\x16\x5e\x38\x0b\xc3\x9c\xc4\xe8\x8d\x70\=
xb8"
     "\x63\xce\x00\x7e\x71\x6d\x86\x09\x2f\xd1\xec\x17\xdb\xd2\x41\x81\xa6\=
x4e"
     "\x28\x32\xc8\x39\x07\x49\xf2\x7f\x89\x89\xa9\x4a\x94\xb4\xd6\x9d\xd3\=
xbd"
     "\xb0\xd3\x96\xc7\xd5\x8f\x79\x77\xe1\xc0\x1c\xbd\xfb\xe7\xad\xf0\x7a\=
x80"
     "\xaf\x96\x22\x5c\xff\xad\x1d\xcb\xd2\xc6\x17\x21\x6b\xf8\x9b\x8a\xe7\=
xcd"
     "\x0e\x41\x63\x83\x0a\xcc\x2f\x1c\x95\x4c\x75\x44\x8d\x27\xa8\x91\x89\=
xf4"
     "\x91\xf6\x69\x7c\xed\xed\xb9\x5d\xe0\xf0\x23\x1c\x57\x31\x7f\x61\x0a\=
x52"
     "\xfe\xd4\x4e\xbb\xa1\x1b\xe4\x0e\x36\x56\x89\x50\xb4\x7c\x18\x7c\x86\=
xdb"
     "\x3e\xba\x66\xe3\x21\xb5\xa9\x0d\x0f\xa5\xc4\x48\x4a\xca\x6e\x66\xd9\=
xc0"
     "\xa8\x9f\x4a\x70\xc0\xe9\x2a\x24\x64\x5a\x89\x67\xd6\x88\xdc\xcd\x14\=
x8d"
     "\x79\x43\x65\xae\x67\x2f\x69\xfe\xf7\xf4\x2c\x97\x4d\x44\x46\x43\xdf\=
xa5"
     "\xbf\x84\x2a\xbf\x60\x80\x5c\xcf\x13\xd6\x0f\x93\x88\x5e\x9e\x36\xea\=
xbc"
     "\xaf\x12\x97\xa9\x34\x3e\x4f\x7a\x31\x84\xae\xdf\xae\xd8\xab\x6c\x2c\=
x3a"
     "\xf6\x8c\x40\x23\x10\x1a\xae\xb3\x6c\xf1\xb2\x85\xe3\xa8\xfe\xf3\x31\=
xe6"
     "\x19\xa1\xd0\xe2\x71\x45\x5f\xda\x62\xba\xde\x30\x32\xf7\x36\xe1\x9c\=
x86"
     "\xf4\xd9\x12\xc6\xbf\xe2\x41\x45\xff\xb4\x8a\x46\xd6\x95\xa7\x57\x52\=
xdf"
     "\x73\xf7\x36\x6e\x0f\xef\x6b\x7f\xa4\xb4\x21\x1b\x00\x5d\x97\x07\x89\=
x4f"
     "\x2b\x22\xa8\x25\xb3\xd6\x71\xd9\x9e\xd7\xfb\x8d\xd3\x61\x58\x07\xec\=
x2e"
     "\x2d\x92\xf4\x8f\x9a\x19\x7f\x86\x4c\x39\x0d\xe2\x34\x96\xd1\x51\x7d\=
x4d"
     "\x71\xb7\xe1\x5f\xec\x54\x4c\xba\xaa\xeb\x89\x81\xb6\x6f\xde\x00\x5c\=
x5d"
     "\x09\xaf\xb2\x1b\x1c\xcb\x9c\xbe\x6f\xdc\xc4\xb5\x49\xfb\xa7\x54\x99\=
xe6"
     "\xe1\x08\xfd\x4a\xe4\xfe\xdf\x1b\xab\x77\x98\xe2\xa9\x99\x61\x3a\x72\=
x73"
     "\x65\x2e\x4e\xa9\x07\xeb\xff\xdf\x87\x25\x04\x12\xcd\xfa\xf6\x63\xc7\=
x47"
     "\x93\xb4\x40\x01\x9f\x1b\xef\xb1\x21\xe1\xcf\xf5\xe9\xe6\x18\x7d\xe4\=
x6d"
     "\xb8\x92\x20\x0f\xc2\xaf\x9e\xe2\x36\xfc\xee\xfc\xdb\x1a\x61\xc6\x56\=
x51"
     "\x80\x91\xd3\x91\x1a\x14\xc1\x15\x0d\x91\x1b\x9b\x92\x31\x26\x24\x1d\=
x77"
     "\x3f\xf2\xe6\x22\xbb\x10\x76\xdf\xcc\x37\xa0\x99\x54\x0f\x0d\xd6\xb3\=
xe9"
     "\x68\x92\x51\xa0\xfb\xfe\x4c\xde\x79\xf9\x9b\x3a\xac\xc6\x51\xc0\x61\=
xc9"
     "\x66\xb7\xa7\xa5\xde\xf7\x3e\x14\xf2\xdf\x0e\x54\x52\x18\x46\x20\x3e\=
xdb"
     "\xc0\x06\xa7\x5d\x27\xb2\x57\x4a\x28\x0f\x44\xbb\x68\x4a\xd7\x66\xc6\=
xee"
     "\x09\x1a\xc4\x00\xa5\xe9\xe7\xb8\x2a\xa3\xe4\x0a\xa8\xf6\x95\x63\xdc\=
x14"
     "\xe9\x0c\xb7\xc2\xdd\x1a\x8f\xb3\x26\x5a\x89\xeb\xec\x21\xe3\x01\xc2\=
x9d"
     "\xab\x4b\x04\xba\x9a\x62\x63\xb8\xc5\x9a\x32\xc7\xed\x3a\xb6\x0e\x4a\=
xcb"
     "\xf4\x9b\x48\x09\xef\xc4\x7d\xef\x8c\x11\xba\xfe\x0a\x3f\x02\xc0\x8d\=
x46"
     "\xf7\x9e\xc6\xe0\x63\xcf\xef\xed\x23\x89\x18\x34\x48\x1a\xa4\xec\x50\=
xb7"
     "\xee\x50\x6e\xe3\x67\x39\x80\x9f\x33\xf8\x9d\xdd\x40\x15\x2a\xec\xe7\=
x12"
     "\x35\xae\x9d\x8b\x65\x6b\x92\xa6\x94\x79\xb3\xb5\xb9\x7f\x35\x49\xb5\=
x40"
     "\x61\x36\xca\xeb\xeb\x46\xee\x6a\x66\x03\xd3\xac\xd0\x01\xa6\xb3\xa9\=
xef"
     "\x56\xf5\x11\xe5\x12\x66\x7a\x57\x22\x0a\x13\x8a\x3c\x09\xae\xdd\x37\=
x4d"
     "\x69\x22\x4a\x14\x8a\x4d\xdf\x95\x53\x4f\xd6\x46\x73\xc0\xf1\x80\xf3\=
x44"
     "\x96\x4f\xb3\x0f\xae\x60\x82\xf6\xae\x71\x46\x41\x76\x17\xe3\x19\x6f\=
xe1"
     "\xec\xc7\x40\x02\x85\x76\x49\x6f\x73\x6f\x8c\x8e\x5c\x52\x13\xdf\x54\=
xba"
     "\xf2\x2f\x8b\x5d\xf6\x77\x37\x16\xe8\x46\xc9\xbb\x44\x52\xba\x44\x65\=
x9c"
     "\x30\x22\xb3\x91\xdc\x0c\xff\x68\x5f\x15\x9c\xcf\xac\x22\xe2\xcc\x5c\=
xac"
     "\xce\xa6\x0b\x29\x05\x9f\x52\x54\x49\xa5\x8f\x6f\x53\x24\x61\x28\xcf\=
x01"
     "\x26\x26\x6e\x66\xea\xd7\xd7\xb5\x7c\x70\x17\xc8\xda\xcf\xc7\x58\x09\=
x2c"
     "\x0d\x10\x52\x39\x86\xe8\x46\x8b\xfa\x3e\x8c\xd1\xc6\xb5\x26\xe2\xad\=
x23"
     "\x25\xd2\xb7\x59\xfe\x70\xab\x4d\xe7\x46\x61\xc4\x8d\x64\xae\x07\xdb\=
x86"
     "\xf0\xbc\x11\x53\x75\xab\xc4\xce\xf4\xaf\xe6\xc3\xf2\x57\x84\xff\x19\=
x15"
     "\x86\x4c\x28\x39\xe4\xc6\x94\xed\x16\xc5\x83\xca\xe1\x6b\x14\xbb\x11\=
xda"
     "\x5a\x5f\xa6\x59\xcf\x12\x98\x89\x54\x81\xfc\xca\xff\x26\x2d\x6b\x38\=
xd3"
     "\x12\x9b\xe8\xa6\x88\x3b\x63\x60\xf8\x65\x08\xed\x80\x9f\xe3\xe6\x11\=
x2a"
     "\xd8\x50\x59\xe0\xbd\x16\x24\xf9\x28\x22\x00\x38\x55\x51\xfa\x41\xb9\=
x88"
     "\x13\x96\x44\xa2\xb0\xbb\xd0\x9b\xe7\x30\xc6\x01\x0a\x70\xe8\x46\xb8\=
x61"
     "\xf9\x53\x18\x06\xe1\xba\xf0\x4e\x03\x29\x91\xfb\xa3\x6f\x2c\x55\xc9\=
xee"
     "\xca\xd7\x43\x75\x6a\x5f\x87\x46\x42\x2b\x90\x0f\xac\xb8\xb4\xdb\x46\=
x32"
     "\xc2\x77\xcd\xec\xa7\xc7\x28\x8a\x88\x16\x69\x6a\xd3\x54\xd5\xf0\x07\=
x53"
     "\xe0\xf3\xd6\xe1\xe1\xad\x3e\xc6\x6d\x21\xfc\x01\xc4\xae\x29\xfd\xe5\=
xdb"
     "\x53\x27\x4c\xcf\x04\xea\x8d\xca\x09\xdb\x82\xc1\xdb\xf3\x20\x2c\xb4\=
xb6"
     "\x5d\x76\xc0\x8f\xbb\x18\xba\x20\x3b\xe4\x85\x6f\xc9\xac\xe6\x92\x16\=
x47"
     "\x4b\x8a\x12\x9c\x06\x3b\x9d\x8a\x71\x2b\xc4\x89\x46\xcb\xb2\x43\x62\=
x19"
     "\xf9\x05\x2a\x5a\xee\xcb\x33\x22\xae\x98\x4c\x5b\x07\xf2\x89\x6e\x5a\=
x05"
     "\xda\xeb\x38\x18\xb2\xc6\xae\x51\x89\xf1\x6d\x26\x22\x21\xcb\x35\xc2\=
xd6"
     "\xb9\x33\xd1\x19\xcc\x55\x0f\xde\xf6\x9c\x34\xbb\x9d\xf0\xdd\xb7\x57\=
x2a"
     "\xe8\x01\xce\xb1\xf0\x0c\x44\x8d\xbc\x2a\x51\xf2\xda\x6c\xd6\x99\x2d\=
xf1"
     "\xd6\xa1\x8e\x81\xba\x2f\x44\xbb\x33\x7b\x8a\x16\x1f\xa8\x16\x04\xe1\=
xc8"
     "\xce\x9b\x8c\xd8\x35\x1b\x6e\x75\x75\x19\x6f\x43\x31\xfc\x88\xc9\xa9\=
xd3"
     "\xab\x8f\x1a\x64\x61\x14\xdf\xc7\x55\x27\xb9\xb6\x69\xf8\xd6\x1c\x32\=
x5d"
     "\x11\xa8\x75\x37\x20\x5c\xd7\xf8\xd6\x75\x88\x37\xe7\xb4\x51\x79\x53\=
x4f"
     "\x7f\x38\x00\x2c\x4c\xb5\xe3\x22\xd0\x1b\x3b\xeb\x3b\xc6\xaa\x41\xfb\=
x91"
     "\xc0\x5c\x94\x5f\x50\xf6\x2a\x23\xde\xbd\x8f\xf8\x6b\xf2\x45\x76\xa3\=
xa0"
     "\x21\x35\x9d\x28\x7b\xa1\x99\x77\xc9\xce\x3d\x31\x05\xc0\x5f\xe4\x39\=
xe8"
     "\x56\x82\xaa\x03\xfd\xea\x6b\x1d\xb6\xed\xa4\xa4\x6e\x66\x24\x0e\xc2\=
xb3"
     "\x4b\xc4\x71\xa7\x77\x23\x15\x78\xaa\x7e\x4b\xfc\x1f\x18\x10\x8f\x03\=
xcf"
     "\x8c\x36\xac\x0b\xe8\x06\xd0\x31\x30\x9e\x39\xab\xc6\x72\x37\x0a\xae\=
x6c"
     "\x09\x60\xb6\xbe\xf9\x9e\x2a\x62\x8e\xb1\x69\xc5\xe6\xb6\xb8\xd2\x28\=
xa9"
     "\xba\x9a\x2f\xe1\x4c\xf3\x15\x33\x1e\xee\x67\x14\x35\x7d\x7e\xbb\x84\=
x66"
     "\x7b\x5a\x6d\x39\x00\xd4\xe7\x5e\xe8\x91\x1d\xe5\x9d\x3b\xcc\x2d\x4b\=
xd0"
     "\xd5\x14\x2a\x02\xd8\x60\x88\x1f\x7a\x71\x06\xc5\x9e\x5a\xe1\x0c\x56\=
xc8"
     "\x8e\x2f\xdf\x64\x71\xe5\x79\xcb\xdc\x0b\xe5\xc6\x56\x5e\x02\x2c\xa6\=
x5d"
     "\x81\x73\x7c\xd0\xdf\x1a\x53\x81\xe5\x6a\x9e\xe0\x9f\xaf\xe9\xd6\x02\=
x15"
     "\x74\x8c\x15\xb5\xe2\xed\x9c\xc3\x7f\x1c\x7d\x51\xa0\x5f\x00\x43\x50\=
xfe"
     "\x74\x6d\xa1\x9f\x3f\x01\x27\x54\x6b\x63\xc6\x6f\x3c\x40\x03\x91\x32\=
xbb"
     "\xe2\xc7\x4b\x28\x6e\xf8\x01\x01\xc8\xeb\xb4\xe8\x4f\xe3\x97\x8e\x0e\=
x20"
     "\x8b\xeb\xd8\xd3\xb9\xfd\xf7\x4b\xdc\x10\x8d\x08\xef\x4d\x86\x23\x6d\=
x32"
     "\x7c\x5f\xf1\xb9\xc2\x9d\x4c\xd0\x95\x0e\x09\xf0\xe8\x68\x48\xc5\xd3\=
x02"
     "\x8d\xc7\x99\x4a\x58\x9e\x60\xd0\xf2\x93\xb9\x82\x56\x51\xc8\x49\x62\=
x10"
     "\xa0\x0a\x84\x3d\xb3\x71\x04\x08\x5a\x53\x64\x6e\x4f\x9e\xf8\x87\x6c\=
x06"
     "\xc9\xb3\x01\x4e\xed\x02\xa2\x1a\x93\x41\xce\x74\x6c\x15\xd3\x63\x8e\=
x7a"
     "\xee\x8a\x16\xcf\x62\x3d\x1a\x94\xbe\x85\x0d\x77\xd0\xfc\x22\x93\x5e\=
xde"
     "\xd1\xd6\xf6\x91\x76\x20\x29\xcd\xf3\x00\x53\x95\x04\x4a\xb8\xbc\x98\=
x9a"
     "\x7f\x67\x6f\x28\xbc\x2c\xe3\x10\xa1\x3e\x30\x03\xc9\xba\x3b\x81\x4c\=
x82"
     "\xa5\x11\x31\x84\x35\xf0\xfa\xdc\xc7\x08\x8b\x9d\x47\x7b\x5b\x5e\xcb\=
x88"
     "\x45\x05\xf0\x10\xf9\xb0\x72\xa2\x0d\x6f\xb2\x91\xb8\x52\x4f\xb0\xf6\=
xe8"
     "\x47\xf4\x52\xff\x5b\xa3\xee\xb8\xb1\x2c\x0e\x3e\x25\xde\xcc\x81\xb8\=
xf1"
     "\xf8\xd9\x80\x30\x0c\xc9\x2c\xe7\x0c\xdc\xf0\x3f\x70\x78\xcc\xd7\xc7\=
x9b"
     "\x9d\xb1\x67\xfe\x7e\x82\xdc\x04\x0e\x68\xf9\x41\xf3\x36\x84\x72\x79\=
xcc"
     "\x99\x60\xdc\x6b\x0a\xd6\x5a\xdc\xf1\x05\x0b\xc2\x8e\xaf\x70\x0a\xf1\=
xf3"
     "\x9e\x76\x48\x9f\xf1\x9c\x1a\x48\x65\xd8\x9b\xf5\xdc\x8a\x89\xdd\x64\=
x51"
     "\xbd\x52\xdc\xbf\x67\x63\xea\xd8\xa6\x0e\x4f\xbd\xd8\x5c\xa3\x7b\x25\=
xbc"
     "\x3e\xdc\xa8\xf2\x78\x60\xfd\xf3\x9a\xd5\x99\x3e\xe1\xb4\x7f\x02\xcc\=
xaa"
     "\xd9\xb2\xca\xe3\xef\x53\x00\xc1\x96\x37\xec\x24\xf0\xcb\x2a\xcc\x88\=
xe8"
     "\xa6\x39\x08\x77\x7f\x0c\x75\x9b\x26\x55\x81\xae\xa3\xe3\xa7\x4f\xcb\=
x44"
     "\x3d\x4f\x28\x99\xcf\x3c\x3a\x28\xc9\x4d\x5b\x8e\xd2\x8f\xd0\x01\x74\=
x24"
     "\x59\xb9\x9d\xcd\x48\xa6\xc7\xcd\x30\x60\x0b\x61\x26\x2e\xac\x6d\x24\=
x9e"
     "\x34\xf7\x56\x9a\xa5\x34\xc3\x7b\xe0\x88\xb1\x2c\xe8\xa9\x17\xaf\x4d\=
xb6"
     "\xa6\x03\xb7\x35\x54\x14\xcc\x2a\x92\x07\x1f\x64\xf1\x7b\xc7\x3a\x62\=
xb2"
     "\xa4\x61\xfb\x4f\x90\x7c\x81\x55\x09\x0a\x6c\xca\xd7\x18\xd3\xf4\x86\=
x44"
     "\x65\x9c\xba\x76\xa4\x2a\xbb\xbf\x22\xa9\xac\xbc\xdc\xbb\xf1\x6f\x11\=
x49"
     "\x4f\x21\x4b\xd6\xa5\xbc\xc5\x41\x5a\xa7\x8a\xd9\xd5\xc9\xd9\x55\xc0\=
x18"
     "\x74\xce\x24\x16\xc7\xe7\x44\x41\x46\xaa\xa2\x91\x43\x6b\x9a\xdd\xb2\=
xcd"
     "\xac\xaf\xfa\x85\x42\x84\xe3\x1c\xbe\xa9\x31\x5a\x39\xcf\x56\x1d\x39\=
x5c"
     "\xd2\x02\xeb\x13\xd1\xe3\x30\xa8\x30\x3c\xe9\x48\xcd\x9a\xf2\x6d\x14\=
xe2"
     "\xf0\x6b\xbf\x7a\x82\x2e\x65\x47\xfb\x1d\x75\x0b\x36\x1c\x68\x59\x5b\=
x68"
     "\xf7\xb7\xd3\xa2\xbd\x7a\xa0\x07\x13\xd4\xaf\xa8\x23\xc4\x4a\xee\x12\=
x85"
     "\x68\xc2\x80\xbe\xf9\x25\x43\x19\xc0\xfd\x37\xea\xd3\x0e\xac\x83\x54\=
xbe"
     "\x03\xf4\xff\x44\x16\x90\x52\x2b\x94\x03\x53\xc9\xf3\xcf\xeb\x3c\xf3\=
x99"
     "\xc5\x8a\xea\x6e\x25\xbc\x5f\xce\xef\x0c\x29\x34\x76\x0d\x9a\x7c\xb7\=
x61"
     "\x4d\xc3\x90\x19\x60\xb6\xa1\xbe\x8a\xc1\x4c\x36\x7f\xd8\xee\xc4\x48\=
x92"
     "\x9f\xc1\xf5\xef\xc8\xa7\xbd\x30\x0e\x10\x92\x03\x62\x98\x29\xbf\x79\=
x05"
     "\x0b\x85\x6f\x26\x8a\x10\x1c\xfb\x85\x8b\xc5\x43\x98\x52\x36\x6c\xe7\=
xca"
     "\x20\x51\xbf\x01\x57\x1c\xa4\xa3\xb2\xc5\xb2\xfe\x0d\xe8\x18\xf3\xca\=
xb4"
     "\x3d\x05\xcd\x38\xa2\xca\xc4\xfd\x92\x55\xb8\x97\x85\x5b\x55\xee\xe8\=
x35"
     "\x32\xa0\xd8\x24\x21\xc7\xed\x74\x26\xde\x53\x81\x88\x7d\x92\xd2\x4c\=
x67"
     "\x8f\x3a\x16\x42\x21\x9e\x6b\xaa\x06\x7e\xfe\xf2\x41\x0a\x40\x45\xf1\=
x95"
     "\x81\xa3\x28\x16\x0c\x55\x19\x91\xa2\x80\xc2\x92\x2d\x47\xa2\x74\xf0\=
xd0"
     "\xce\xac\xa9\x74\xb7\x86\x23\x8a\xff\x3f\x7b\x89\x31\x77\x5f\x2a\xdf\=
x50"
     "\xce\xac\xfe\xdf\x71\x9d\xa4\x89\x35\x80\x59\x27\x25\x31\x3c\x20\x9a\=
x4d"
     "\x11\x02\x9a\xa1\x98\xcd\xb9\xa8\x0d\x31\xc8\xb4\x0e\x6d\xe5\xb7\x4d\=
x75"
     "\x22\x87\x50\x04\x94\xc3\xe2\x2d\xf3\x6c\xdf\xdb\x6f\x4d\x5a\x8a\xc2\=
xc8"
     "\x71\xee\x89\x77\x2a\x7a\x00\xec\x5c\xc7\x8b\x39\xc9\xd0\x4b\xb0\x79\=
xb7"
     "\x59\xaf\x9b\xf5\xf9\x0a\x07\xa4\x3f\xc2\x36\x86\xf7\xf1\x3f\x3c\x6e\=
xdc"
     "\xd8\x0e\xe1\x2a\x63\x85\x64\x01\x47\xe8\xac\x54\x5e\xe6\x87\x53\xcc\=
x01"
     "\xdf\xa2\x3a\xf4\xd1\xe0\xd6\x39\x12\x45\x3a\xaf\x7d\x8b\x12\x27\xca\=
x67"
     "\x25\x45\x86\x39\x97\x8e\x2e\xa9\x5c\x3d\x32\xdb\xba\x6b\xb5\x2c\x7b\=
x19"
     "\x13\x79\xc6\xa2\xbd\x5c\x4b\x7b\xdc\x47\xc7\x0e\x73\x6c\x7d\xa1\xc9\=
xb6"
     "\x79\x5c\x65\x47\xa7\x41\xaf\xfb\xff\x4b\xf3\x7d\x09\xef\x4d\x36\x82\=
xe7"
     "\x30\x04\xdd\x06\x52\x29\xc6\x75\x59\x94\xff\x06\x79\x12\x51\x23\x28\=
x9d"
     "\x94\xaf\x03\x62\x01\xe4\x85\x47\xf5\x99\xe2\x4b\x7d\x87\x78\xde\x18\=
x38"
     "\x07\x10\xe3\x70\xc3\xc8\x6f\x0a\x48\x83\x59\x54\x34\xa5\xf6\xf9\x3f\=
x95"
     "\x5a\xbd\xc0\x13\xab\x48\x7a\xfe\xd0\xe1\xcb\x05\x32\x67\xf3\x29\x97\=
x33"
     "\xf1\x71\x25\xd7\xb7\x15\x3f\x8f\x9e\xf7\x7f\x86\x83\xe0\x26\xeb\xed\=
x04"
     "\x54\x9b\x0f\xf1\x55\xab\x9b\x4d\x59\x95\xf9\x46\xc9\xa8\x48\x70\x07\=
xe2"
     "\xdd\x5f\x8f\x6b\xaa\x25\x7b\x6d\x96\x93\xfd\xcd\x4a\x3d\x82\x33\x84\=
xac"
     "\x9e\x92\xb6\x68\x31\xf2\x95\xd7\x2f\x7c\x0b\xa5\x39\x8b\x8a\x6a\xd3\=
x9d"
     "\x0f\xa6\xe5\x30\x97\xbb\xd1\x63\x49\x57\x0a\x96\x24\x5e\x3b\xb5\xe4\=
x1c"
     "\x93\xaa\x60\x89\xec\x85\x3d\xc7\xa4\xf9\x11\x53\xa5\x26\xf1\xb6\x6c\=
xc2"
     "\x6a\xd4\x24\xd3\x2b\x57\x36\x9a\xa2\xcd\x5a\xa2\x51\xa4\x0b\x31\x89\=
x44"
     "\xcd\x6c\x09\xf2\x76\xea\x9c\xf5\xa4\x21\x27\x24\xcb\xa3\x71\xfe\x49\=
x0b"
     "\x4d\x0e\x80\xe6\x43\xbd\x23\x6a\x9d\xdb\x2d\xb1\xfc\x36\xcf\xb9\xb0\=
xcc"
     "\xbd\xce\x44\xa7\x7d\x1a\x6b\xb0\x2b\x37\xb7\xcf\xe0\x8c\x99\x5d\xdb\=
xa2"
     "\x5e\x29\x84\x69\x69\x8e\x7b\x1e\x4f\x49\x77\xb7\xac\x41\x40\x9a\x08\=
xae"
     "\xec\x23\xa6\xba\xc5\x29\x3d\xd2\x02\xb5\x3a\xa2\x27\x9e\xc8\x6e\x02\=
x19"
     "\xca\xe6\xce\xa3\xc0\x96\x66\x63\x7c\xaf\x07\x6e\x9e\xed\xd0\xec\xae\=
x03"
     "\xef\x34\x33\x8d\x9b\xa9\xb3\x5c\x1b\xa6\x77\x2f\x4e\x7a\xa6\xf4\xa6\=
x4d"
     "\x15\xe3\x39\x0c\x82\x72\x12\xb9\x31\x92\xf1\x9a\x96\x09\x0a\x00\x9f\=
x96"
     "\xf3\x5b\x31\x83\xc6\xde\x6f\x3d\x70\x94\x7d\x86\x2d\xb1\x27\x5c\x04\=
x47"
     "\xb2\xda\x78\x7b\x7a\x63\x72\xde\x28\x2e\x20\xa6\xfc\x88\x80\xe0\xea\=
x6a"
     "\x0f\x73\x8c\xe4\xdd\x8e\x5d\xeb\x2f\xbc\xb3\x87\x28\x7f\x71\x73\x53\=
x8e"
     "\x89\x9e\x3d\x40\x12\x79\xfa\x5f\x3a\x38\x4c\x1f\x4c\xd9\x51\xe3\x00\=
x42"
     "\xf0\xf6\x27\x0f\xe6\x60\xba\xc9\x32\x31\x8e\x29\xa7\xd8\x42\x23\x3d\=
xad"
     "\x53\x88\xa6\xc8\x2a\xb9\xb1\x11\xb6\x7a\xe7\x3f\x47\x22\x56\x3f\xc8\=
x89"
     "\x83\x25\x6a\x77\x06\xed\x88\x3a\xc4\x1b\x51\xef\x42\x7c\x2a\xa1\xa8\=
xa0"
     "\xf5\x6b\x72\xc0\xd9\xe8\xce\xe6\x37\xf7\x7f\x67\xe9\x99\x13\x55\x1a\=
x9c"
     "\x78\x49\xf8\xa9\xd5\x0b\x20\x0c\x8e\x6e\x1b\x16\x92\x86\x60\x98\x2b\=
xc8"
     "\xc4\xb7\x70\xfd\x90\x7a\x2d\x74\x0b\xab\xec\x99\x13\x90\xdd\xc2\xb7\=
xfc"
     "\xe2\x3f\xa3\xa6\x11\x31\xbd\xc8\x75\x02\x71\x1b\x4b\x57\x59\xe6\x35\=
x12"
     "\x7a\xdf\xe7\xfe\x69\xe0\x6a\x43\xb4\x50\xf9\xcc\x1c\x60\xe7\xae\xd7\=
x5f"
     "\xfd\x30\xc3\x27\x24\x01\x7e\x7a\x02\x1c\x90\xf8\xc8\x1a\xe8\x65\x90\=
x8d"
     "\x48\xfa\x7f\xcb\x7c\xfb\x9b\x0f\x15\x30\xfd\xe5\x5c\xf0\x8c\xb3\xc1\=
x4d"
     "\x36\x56\x49\x15\x2f\x2c\x8a\x8c\x61\x5f\xef\xb3\x7a\x21\x9f\x73\x0f\=
x5d"
     "\x2a\x66\x0c\x4c\xf0\x30\x8a\x40\xf0\xc0\x60\x99\x32\x11\x36\x30\x14\=
x28"
     "\x40\x8a\x8f\xa8\x73\x5b\xc6\xf7\xea\xeb\xbd\x40\x67\x28\xb6\xe0\xf9\=
x43"
     "\xa8\x59\x75\x57\xf6\xe5\x38\x12\x33\x53\xe5\x6e\x52\x0d\x45\xe9\x93\=
x1d"
     "\xbb\xce\x8c\x5a\x7f\x09\x46\x45\xe1\xed\x88\xd1\x6c\x3d\x91\x72\xb1\=
x09"
     "\xf9\x3f\xd1\x8f\xed\xa6\x95\x69\x41\xe0\xb4\x1f\x35\xe2\xc5\xb7\xc9\=
x97"
     "\xce\xd9\xfb\xac\x1e\x9f\x0f\xf3\x61\xfa\x81\xbe\x5c\xc5\x9e\xd7\x8e\=
x00"
     "\x64\x44\xf7\x1a\xb8\x68\x45\x50\x2a\x0a\x6e\x49\xc8\xef\x81\xf8\xe4\=
x5c"
     "\x94\x3e\x78\x24\xe8\x7e\x65\x13\x74\x58\x50\x0a\xb1\x8f\x0e\xcf\xc9\=
xaa"
     "\x10\xec\x00\xc2\xa1\x02\x3f\xf9\x69\x5c\xc2\x72\x8b\xae\xc1\xf2\x10\=
x4c"
     "\x1d\x69\x90\x69\xb1\x82\x51\x35\xa1\x1f\x2b\x77\x6d\x57\x6e\x38\x64\=
x09"
     "\x19\xed\x96\x85\x0c\xfd\x48\x63\xd5\xc9\xfa\xfe\x47\x3e\x88\x54\x4a\=
xd0"
     "\xd1\xd2\x07\x1e\x00\x0f\x23\x34\x83\xdb\x41\xfe\x5c\x46\xda\x9c\x47\=
x2b"
     "\x6c\xfb\xca\x9a\x0b\xf0\xd8\x20\x37\x4d\x34\xb2\xe8\x4e\xc6\x0d\xc2\=
x65"
     "\x7f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\x0d\xb5\x04\x6f\x39\x00\=
xc1"
     "\x8c\xf0\xa1\x2f\x17\xc4\xb1\xbe\xa9\xd0\xb3\x66\x7c\x76\x15\x94\xcb\=
x2e"
     "\x4c\x0c\xb0\xca\xc5\x43\x43\x7b\x6d\x75\x78\x0d\xb9\x19\x76\x3f\x59\=
x21"
     "\x2d\x9c\x4d\xae\x0e\xb9\xe7\x30\xd2\x38\xf4\x0f\xf2\x6b\x34\x3a\x3e\=
x19"
     "\x06\x55\x48\xa4\x10\x6c\x98\xfa\x5e\x5c\x45\xbf\x20\x55\x1f\x7b\x90\=
x87"
     "\x2b\x5a\x88\xd3\x3a\x85\xfe\xe6\x08\xf3\x8f\x90\xff\xfd\xa8\x8b\xc7\=
xd3"
     "\xf7\x0f\xdc\xda\x4c\x9e\xe6\xd6\x24\x0e\xb9\x7c\x76\x6d\xfb\xd4\xec\=
x13"
     "\x89\x4b\x4f\x19\x1d\xe6\x83\xc5\xf9\xae\xfc\xc5",
     3918);
 *(uint32_t*)0x200034ce =3D 0x41424344;
 *(uint32_t*)0x200034d2 =3D 0x41424344;
 syscall(__NR_write, /*fd=3D*/r[0], /*buf=3D*/0x20002580ul, /*count=3D*/0xf=
caul);
}
int main(void) {
 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 do_sandbox_none();
 return 0;
}

=3D* repro.txt =3D*
r0 =3D openat$tun(0xffffffffffffff9c, &(0x7f0000000080), 0x88002, 0x0)
ioctl$TUNSETIFF(r0, 0x400454ca, &(0x7f0000000040)=3D{'syzkaller1\x00',
0x420000015001})
r1 =3D socket$netlink(0x10, 0x3, 0x0)
ioctl$sock_inet_SIOCSIFADDR(r1, 0x8914,
&(0x7f0000000140)=3D{'syzkaller1\x00', {0x7, 0x0, @empty}})
write$tun(r0, &(0x7f0000002580)=3DANY=3D[@ANYBLOB=3D"0703000000040000000060=
2d2ae10f982f0000000000000000000000000000000000ff020000000000000000000000000=
0010000883e00000200000000006800000000cf00000000000000d114b139165af32091ba89=
0f1143697d60ff6fbf674da1995e0cd4900505f2ceb44dcd98209d1d9947fc396bfb0871e64=
91313cfe0788a5074e89e8ae3ba8df7e6877d0b40eeec0e362d17eb2f71802bb60ea97b5afc=
810d37d154e47b044ab80e7238588fbf37dec782b8b1bcc0950173791456959f803d61b0563=
1efbbfccebeafef57bd9563c27ec7e50ddb6718b4a2aca720fd8662c6713d507f08b8ed9562=
2ebebe3a02b97644e240f30423fbaa339c433d6b41f6db7670a5af4b2f172e64c2e5b40b8f6=
b37c2e64421d0331aff52b9c910ff010000000000000000000000000001000100000100008c=
b37d4518d6ae13addd271ca39d048ed6d830fc13406236e5b67f4cdad0867dff7a4d544a31a=
895f0e967a2aa3aaa2195cd11811a8e0c3b78a301b1d4cfcff4a69fac546db9f81707b42c40=
98b679469efe5b8ee71c8796bb12e3e2641ef40da663e402c962f7e1d9953e53645f6ffda69=
87db84b9a806c7c2fe0a69d4db3fd314b37410fa0e65c56149bde13bdf89242411dc197eafa=
fd76a07e83f3c8b2ab1261cc7563165e380bc39cc4e88d70b863ce007e716d86092fd1ec17d=
bd24181a64e2832c8390749f27f8989a94a94b4d69dd3bdb0d396c7d58f7977e1c01cbdfbe7=
adf07a80af96225cffad1dcbd2c617216bf89b8ae7cd0e4163830acc2f1c954c75448d27a89=
189f491f6697cededb95de0f0231c57317f610a52fed44ebba11be40e36568950b47c187c86=
db3eba66e321b5a90d0fa5c4484aca6e66d9c0a89f4a70c0e92a24645a8967d688dccd148d7=
94365ae672f69fef7f42c974d444643dfa5bf842abf60805ccf13d60f93885e9e36eabcaf12=
97a9343e4f7a3184aedfaed8ab6c2c3af68c4023101aaeb36cf1b285e3a8fef331e619a1d0e=
271455fda62bade3032f736e19c86f4d912c6bfe24145ffb48a46d695a75752df73f7366e0f=
ef6b7fa4b4211b005d9707894f2b22a825b3d671d99ed7fb8dd3615807ec2e2d92f48f9a197=
f864c390de23496d1517d4d71b7e15fec544cbaaaeb8981b66fde005c5d09afb21b1ccb9cbe=
6fdcc4b549fba75499e6e108fd4ae4fedf1bab7798e2a999613a7273652e4ea907ebffdf872=
50412cdfaf663c74793b440019f1befb121e1cff5e9e6187de46db892200fc2af9ee236fcee=
fcdb1a61c656518091d3911a14c1150d911b9b923126241d773ff2e622bb1076dfcc37a0995=
40f0dd6b3e9689251a0fbfe4cde79f99b3aacc651c061c966b7a7a5def73e14f2df0e545218=
46203edbc006a75d27b2574a280f44bb684ad766c6ee091ac400a5e9e7b82aa3e40aa8f6956=
3dc14e90cb7c2dd1a8fb3265a89ebec21e301c29dab4b04ba9a6263b8c59a32c7ed3ab60e4a=
cbf49b4809efc47def8c11bafe0a3f02c08d46f79ec6e063cfefed23891834481aa4ec50b7e=
e506ee36739809f33f89ddd40152aece71235ae9d8b656b92a69479b3b5b97f3549b5406136=
caebeb46ee6a6603d3acd001a6b3a9ef56f511e512667a57220a138a3c09aedd374d69224a1=
48a4ddf95534fd64673c0f180f344964fb30fae6082f6ae7146417617e3196fe1ecc7400285=
76496f736f8c8e5c5213df54baf22f8b5df6773716e846c9bb4452ba44659c3022b391dc0cf=
f685f159ccfac22e2cc5caccea60b29059f525449a58f6f53246128cf0126266e66ead7d7b5=
7c7017c8dacfc758092c0d10523986e8468bfa3e8cd1c6b526e2ad2325d2b759fe70ab4de74=
661c48d64ae07db86f0bc115375abc4cef4afe6c3f25784ff1915864c2839e4c694ed16c583=
cae16b14bb11da5a5fa659cf1298895481fccaff262d6b38d3129be8a6883b6360f86508ed8=
09fe3e6112ad85059e0bd1624f9282200385551fa41b988139644a2b0bbd09be730c6010a70=
e846b861f9531806e1baf04e032991fba36f2c55c9eecad743756a5f8746422b900facb8b4d=
b4632c277cdeca7c7288a8816696ad354d5f00753e0f3d6e1e1ad3ec66d21fc01c4ae29fde5=
db53274ccf04ea8dca09db82c1dbf3202cb4b65d76c08fbb18ba203be4856fc9ace69216474=
b8a129c063b9d8a712bc48946cbb2436219f9052a5aeecb3322ae984c5b07f2896e5a05daeb=
3818b2c6ae5189f16d262221cb35c2d6b933d119cc550fdef69c34bb9df0ddb7572ae801ceb=
1f00c448dbc2a51f2da6cd6992df1d6a18e81ba2f44bb337b8a161fa81604e1c8ce9b8cd835=
1b6e7575196f4331fc88c9a9d3ab8f1a646114dfc75527b9b669f8d61c325d11a87537205cd=
7f8d6758837e7b45179534f7f38002c4cb5e322d01b3beb3bc6aa41fb91c05c945f50f62a23=
debd8ff86bf24576a3a021359d287ba19977c9ce3d3105c05fe439e85682aa03fdea6b1db6e=
da4a46e66240ec2b34bc471a777231578aa7e4bfc1f18108f03cf8c36ac0be806d031309e39=
abc672370aae6c0960b6bef99e2a628eb169c5e6b6b8d228a9ba9a2fe14cf315331eee67143=
57d7ebb84667b5a6d3900d4e75ee8911de59d3bcc2d4bd0d5142a02d860881f7a7106c59e5a=
e10c56c88e2fdf6471e579cbdc0be5c6565e022ca65d81737cd0df1a5381e56a9ee09fafe9d=
60215748c15b5e2ed9cc37f1c7d51a05f004350fe746da19f3f0127546b63c66f3c40039132=
bbe2c74b286ef80101c8ebb4e84fe3978e0e208bebd8d3b9fdf74bdc108d08ef4d86236d327=
c5ff1b9c29d4cd0950e09f0e86848c5d3028dc7994a589e60d0f293b9825651c8496210a00a=
843db37104085a53646e4f9ef8876c06c9b3014eed02a21a9341ce746c15d3638e7aee8a16c=
f623d1a94be850d77d0fc22935eded1d6f691762029cdf3005395044ab8bc989a7f676f28bc=
2ce310a13e3003c9ba3b814c82a511318435f0fadcc7088b9d477b5b5ecb884505f010f9b07=
2a20d6fb291b8524fb0f6e847f452ff5ba3eeb8b12c0e3e25decc81b8f1f8d980300cc92ce7=
0cdcf03f7078ccd7c79b9db167fe7e82dc040e68f941f336847279cc9960dc6b0ad65adcf10=
50bc28eaf700af1f39e76489ff19c1a4865d89bf5dc8a89dd6451bd52dcbf6763ead8a60e4f=
bdd85ca37b25bc3edca8f27860fdf39ad5993ee1b47f02ccaad9b2cae3ef5300c19637ec24f=
0cb2acc88e8a63908777f0c759b265581aea3e3a74fcb443d4f2899cf3c3a28c94d5b8ed28f=
d001742459b99dcd48a6c7cd30600b61262eac6d249e34f7569aa534c37be088b12ce8a917a=
f4db6a603b7355414cc2a92071f64f17bc73a62b2a461fb4f907c8155090a6ccad718d3f486=
44659cba76a42abbbf22a9acbcdcbbf16f11494f214bd6a5bcc5415aa78ad9d5c9d955c0187=
4ce2416c7e7444146aaa291436b9addb2cdacaffa854284e31cbea9315a39cf561d395cd202=
eb13d1e330a8303ce948cd9af26d14e2f06bbf7a822e6547fb1d750b361c68595b68f7b7d3a=
2bd7aa00713d4afa823c44aee128568c280bef9254319c0fd37ead30eac8354be03f4ff4416=
90522b940353c9f3cfeb3cf399c58aea6e25bc5fceef0c2934760d9a7cb7614dc3901960b6a=
1be8ac14c367fd8eec448929fc1f5efc8a7bd300e109203629829bf79050b856f268a101cfb=
858bc5439852366ce7ca2051bf01571ca4a3b2c5b2fe0de818f3cab43d05cd38a2cac4fd925=
5b897855b55eee83532a0d82421c7ed7426de5381887d92d24c678f3a1642219e6baa067efe=
f2410a4045f19581a328160c551991a280c2922d47a274f0d0ceaca974b786238aff3f7b893=
1775f2adf50ceacfedf719da4893580592725313c209a4d11029aa198cdb9a80d31c8b40e6d=
e5b74d752287500494c3e22df36cdfdb6f4d5a8ac2c871ee89772a7a00ec5cc78b39c9d04bb=
079b759af9bf5f90a07a43fc23686f7f13f3c6edcd80ee12a6385640147e8ac545ee68753cc=
01dfa23af4d1e0d63912453aaf7d8b1227ca6725458639978e2ea95c3d32dbba6bb52c7b191=
379c6a2bd5c4b7bdc47c70e736c7da1c9b6795c6547a741affbff4bf37d09ef4d3682e73004=
dd065229c6755994ff0679125123289d94af036201e48547f599e24b7d8778de18380710e37=
0c3c86f0a4883595434a5f6f93f955abdc013ab487afed0e1cb053267f3299733f17125d7b7=
153f8f9ef77f8683e026ebed04549b0ff155ab9b4d5995f946c9a8487007e2dd5f8f6baa257=
b6d9693fdcd4a3d823384ac9e92b66831f295d72f7c0ba5398b8a6ad39d0fa6e53097bbd163=
49570a96245e3bb5e41c93aa6089ec853dc7a4f91153a526f1b66cc26ad424d32b57369aa2c=
d5aa251a40b318944cd6c09f276ea9cf5a4212724cba371fe490b4d0e80e643bd236a9ddb2d=
b1fc36cfb9b0ccbdce44a77d1a6bb02b37b7cfe08c995ddba25e298469698e7b1e4f4977b7a=
c41409a08aeec23a6bac5293dd202b53aa2279ec86e0219cae6cea3c09666637caf076e9eed=
d0ecae03ef34338d9ba9b35c1ba6772f4e7aa6f4a64d15e3390c827212b93192f19a96090a0=
09f96f35b3183c6de6f3d70947d862db1275c0447b2da787b7a6372de282e20a6fc8880e0ea=
6a0f738ce4dd8e5deb2fbcb387287f7173538e899e3d401279fa5f3a384c1f4cd951e30042f=
0f6270fe660bac932318e29a7d842233dad5388a6c82ab9b111b67ae73f4722563fc8898325=
6a7706ed883ac41b51ef427c2aa1a8a0f56b72c0d9e8cee637f77f67e99913551a9c7849f8a=
9d50b200c8e6e1b16928660982bc8c4b770fd907a2d740babec991390ddc2b7fce23fa3a611=
31bdc87502711b4b5759e635127adfe7fe69e06a43b450f9cc1c60e7aed75ffd30c32724017=
e7a021c90f8c81ae865908d48fa7fcb7cfb9b0f1530fde55cf08cb3c14d365649152f2c8a8c=
615fefb37a219f730f5d2a660c4cf0308a40f0c06099321136301428408a8fa8735bc6f7eae=
bbd406728b6e0f943a8597557f6e538123353e56e520d45e9931dbbce8c5a7f094645e1ed88=
d16c3d9172b109f93fd18feda6956941e0b41f35e2c5b7c997ced9fbac1e9f0ff361fa81be5=
cc59ed78e006444f71ab86845502a0a6e49c8ef81f8e45c943e7824e87e65137458500ab18f=
0ecfc9aa10ec00c2a1023ff9695cc2728baec1f2104c1d699069b1825135a11f2b776d576e3=
8640919ed96850cfd4863d5c9fafe473e88544ad0d1d2071e000f233483db41fe5c46da9c47=
2b6cfbca9a0bf0d820374d34b2e84ec60dc2657f000000000000000000670db5046f3900c18=
cf0a12f17c4b1bea9d0b3667c761594cb2e4c0cb0cac543437b6d75780db919763f59212d9c=
4dae0eb9e730d238f40ff26b343a3e19065548a4106c98fa5e5c45bf20551f7b90872b5a88d=
33a85fee608f38f90fffda88bc7d3f70fdcda4c9ee6d6240eb97c766dfbd4ec13894b4f191d=
e683c5f9aefcc5",
@ANYRES32=3D0x41424344, @ANYRES32=3D0x41424344, @ANYBLOB], 0xfca)


and see also in
https://gist.github.com/xrivendell7/cb92d91813377419faaacb1c2ee47c46

I hope it helps.

Best regards.
xingwei Lee


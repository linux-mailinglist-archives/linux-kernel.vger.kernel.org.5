Return-Path: <linux-kernel+bounces-52114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D335A849444
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E2B22B95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B610A13;
	Mon,  5 Feb 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc9uF83G"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47F101DE;
	Mon,  5 Feb 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117391; cv=none; b=u06uYPvpuSgbI2/NkDwNcKb2XneGc+aeTL1kkzzh3zltsQp0yrNZXRrIZQkjbpvvfcqLRlJR+6lSQs/H6L+DB0anxWO4U3Zh4w6m7smYSEOZxDm1mM2fbUE0wnG05NLeriKUQqSLW+73NqvXy5fjb3pOW6tj3txuJbAipDsVMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117391; c=relaxed/simple;
	bh=uaH/cAgaohelnDwRL1H29FPuRBvSVgJhOtIiHAbLIyM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YsDK8A895uo2WqjXNrLo2LMwinh9exMu2OfASNdcYS8t5BxioDqSfV2tWLYXY1BS+kqIkOk8zmopgQsDSP3bG9QidOkGOS2Q0muKXUVAW+F4upOFH5IsiKIFL7ugfKandqq4LD1pb9CG83jR3i/P1pbXMY4PFJBgd67aG5yOzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc9uF83G; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e03bc0755bso206556b3a.0;
        Sun, 04 Feb 2024 23:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707117388; x=1707722188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3c+YHGw3udbtER6fE6pOxSxSISK/cMYNf0CEUUrhBw=;
        b=Gc9uF83G2tQMc60/bjRLUDqSW0eYs3kkINWJ/Gq/6o4rQK4NtF8FuGNi9ixXTP0a42
         Mu0+Q+a0KxvxVwTZayJaDcWkWMOWIFnESXOEN8TW6Wlbi9mYKNKlYji+CzJKl1wbWZRF
         HdKqh3K9i65k8HIfk0mec4KjtotlMGNeIdxgesWe4om6B2+PQcOGjjmGULF09MQAfAc1
         NbkWw51bfuLXTToznuyaumAvWl87v+U852nARKPheMJJtySV1Te3uoWFdikWVdf7Vz43
         MQvYtKJNd4Z6Im9iOMZoanQuGiAi0CGi1Kff0rCknKCjMrtMCePnYLBnpq14tURaUmPc
         Emwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117388; x=1707722188;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3c+YHGw3udbtER6fE6pOxSxSISK/cMYNf0CEUUrhBw=;
        b=qwWA5kOqKlQpKlHp8PgPTn99fmTJ9TX/i9GpsWfnlEhFwmSOR1IocxPxpYY+T/3rEc
         1kNmfBHAtPDh+nw05o8+VG6RR+twrk4LzDQ+LprrZ3L2rT/LITJFTraBFpN4GwyP8jgp
         u/XhlASHoFVWKyEeqkLFLtLAAMYxrWI9QKG8xKoTTeyM1vEiOHR//qmIW9afzTOCVnSu
         efDaLwPW310pBJHtZHJPbijrDWCA//Xug/qFe+DeyOWSHKu5HVBja1UBYJJ6kyVNogUB
         7/BLitMcn+WoNo7zaXTXX03p3qhEtkHkc0lTgKoq0f8LJ0Q4lQjNez8/paVwZxe5cAOh
         Fvxg==
X-Gm-Message-State: AOJu0YxarxFG72rvh1tQpO/r5gG3lypf6vRvltMP+TouGF/McdSB0lHk
	cfbkMPB62V0UcBuUmFMRkgQ5TDtlcOOyteDReRJtrpQUuGWZ12azvZ8C13dpomJ1Uqh+vB/01lo
	cwYSuChaFEAzjayltwII4zhtbf4w=
X-Google-Smtp-Source: AGHT+IFAjbsAOnelYg7Mm6Ofuq9W1Us/+pTa8paWeEtjK7QxvsrZ7JSmxjqJwVKW11+IsSvJB0ay0v94mNgmnDPJE10=
X-Received: by 2002:a05:6a00:6ca4:b0:6e0:4b47:8216 with SMTP id
 jc36-20020a056a006ca400b006e04b478216mr960059pfb.16.1707117388247; Sun, 04
 Feb 2024 23:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 5 Feb 2024 15:16:17 +0800
Message-ID: <CABOYnLxtm2_q2854v0fxqu3JbBvYTn6HQ+UOT2v7u3GBDy8ggw@mail.gmail.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rsp_packet
To: syzbot+685805de744584f4d24b@syzkaller.appspotmail.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug with the following report.

=====================================================
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet_v2
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:107
[inline]
BUG: KMSAN: uninit-value in nci_core_init_rsp_packet
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:131
[inline]
BUG: KMSAN: uninit-value in nci_rsp_packet+0x2c0d/0x2c70
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:376
nci_core_init_rsp_packet_v2
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:107
[inline]
nci_core_init_rsp_packet
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:131
[inline]
nci_rsp_packet+0x2c0d/0x2c70
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/rsp.c:376
nci_rx_work+0x207/0x560
home/dubbo/foobar/685805de-running/kernel/net/nfc/nci/core.c:1518
process_one_work
home/dubbo/foobar/685805de-running/kernel/kernel/workqueue.c:2633
[inline]
process_scheduled_works+0x12bc/0x2060
home/dubbo/foobar/685805de-running/kernel/kernel/workqueue.c:2706
worker_thread+0x1062/0x1630
home/dubbo/foobar/685805de-running/kernel/kernel/workqueue.c:2787
kthread+0x422/0x5a0
home/dubbo/foobar/685805de-running/kernel/kernel/kthread.c:388
ret_from_fork+0x7f/0xa0
home/dubbo/foobar/685805de-running/kernel/arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20
home/dubbo/foobar/685805de-running/kernel/arch/x86/entry/entry_64.S:242
Uninit was created at:
slab_post_alloc_hook+0x129/0xa70
home/dubbo/foobar/685805de-running/kernel/mm/slab.h:768
slab_alloc_node
home/dubbo/foobar/685805de-running/kernel/mm/slub.c:3478 [inline]
kmem_cache_alloc_node+0x5e9/0xb10
home/dubbo/foobar/685805de-running/kernel/mm/slub.c:3523
kmalloc_reserve+0x14d/0x500
home/dubbo/foobar/685805de-running/kernel/net/core/skbuff.c:560
__alloc_skb+0x34e/0x7d0
home/dubbo/foobar/685805de-running/kernel/net/core/skbuff.c:651
alloc_skb home/dubbo/foobar/685805de-running/kernel/./include/linux/skbuff.h:1286
[inline]
virtual_ncidev_write+0x78/0x2c0
home/dubbo/foobar/685805de-running/kernel/drivers/nfc/virtual_ncidev.c:120
vfs_write+0x4d3/0x1330
home/dubbo/foobar/685805de-running/kernel/fs/read_write.c:588
ksys_write+0x273/0x510
home/dubbo/foobar/685805de-running/kernel/fs/read_write.c:643
__do_sys_write home/dubbo/foobar/685805de-running/kernel/fs/read_write.c:655
[inline]
__se_sys_write home/dubbo/foobar/685805de-running/kernel/fs/read_write.c:652
[inline]
__x64_sys_write+0x9e/0xe0
home/dubbo/foobar/685805de-running/kernel/fs/read_write.c:652
do_syscall_x64 home/dubbo/foobar/685805de-running/kernel/arch/x86/entry/common.c:52
[inline]
do_syscall_64+0x6d/0x140
home/dubbo/foobar/685805de-running/kernel/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
CPU: 1 PID: 11 Comm: kworker/u8:0 Not tainted 6.7.0-00562-g92
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 4
Workqueue: nfc2_nci_rx_wq nci_rx_work

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

I use the same configuration with the syzbot instances.
HEAD commit: 9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree: upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b0f30180000
kernel config: https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=685805de744584f4d24b
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

=* repro.c =*
// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/futex.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_link.h>
#include <linux/in6.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/veth.h>

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg) {
 pthread_t th;
 pthread_attr_t attr;
 pthread_attr_init(&attr);
 pthread_attr_setstacksize(&attr, 128 << 10);
 int i = 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) == 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno == EAGAIN) {
     usleep(50);
     continue;
   }
   break;
 }
 exit(1);
}

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)     \
 *(type*)(addr) =                                                   \
     htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
           (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

typedef struct {
 int state;
} event_t;

static void event_init(event_t* ev) {
 ev->state = 0;
}

static void event_reset(event_t* ev) {
 ev->state = 0;
}

static void event_set(event_t* ev) {
 if (ev->state)
   exit(1);
 __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
 syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
 while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
 return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
 uint64_t start = current_time_ms();
 uint64_t now = start;
 for (;;) {
   uint64_t remain = timeout - (now - start);
   struct timespec ts;
   ts.tv_sec = remain / 1000;
   ts.tv_nsec = (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
     return 1;
   now = current_time_ms();
   if (now - start > timeout)
     return 0;
 }
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] = 0;
 int len = strlen(buf);
 int fd = open(file, O_WRONLY | O_CLOEXEC);
 if (fd == -1)
   return false;
 if (write(fd, buf, len) != len) {
   int err = errno;
   close(fd);
   errno = err;
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

static void netlink_init(struct nlmsg* nlmsg,
                        int typ,
                        int flags,
                        const void* data,
                        int size) {
 memset(nlmsg, 0, sizeof(*nlmsg));
 struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_type = typ;
 hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
 memcpy(hdr + 1, data, size);
 nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg,
                        int typ,
                        const void* data,
                        int size) {
 struct nlattr* attr = (struct nlattr*)nlmsg->pos;
 attr->nla_len = sizeof(*attr) + size;
 attr->nla_type = typ;
 if (size > 0)
   memcpy(attr + 1, data, size);
 nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static int netlink_send_ext(struct nlmsg* nlmsg,
                           int sock,
                           uint16_t reply_type,
                           int* reply_len,
                           bool dofail) {
 if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
   exit(1);
 struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
 struct sockaddr_nl addr;
 memset(&addr, 0, sizeof(addr));
 addr.nl_family = AF_NETLINK;
 ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                    (struct sockaddr*)&addr, sizeof(addr));
 if (n != (ssize_t)hdr->nlmsg_len) {
   if (dofail)
     exit(1);
   return -1;
 }
 n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 if (reply_len)
   *reply_len = 0;
 if (n < 0) {
   if (dofail)
     exit(1);
   return -1;
 }
 if (n < (ssize_t)sizeof(struct nlmsghdr)) {
   errno = EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type == NLMSG_DONE)
   return 0;
 if (reply_len && hdr->nlmsg_type == reply_type) {
   *reply_len = n;
   return 0;
 }
 if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
   errno = EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type != NLMSG_ERROR) {
   errno = EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 errno = -((struct nlmsgerr*)(hdr + 1))->error;
 return -errno;
}

static int netlink_query_family_id(struct nlmsg* nlmsg,
                                  int sock,
                                  const char* family_name,
                                  bool dofail) {
 struct genlmsghdr genlhdr;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd = CTRL_CMD_GETFAMILY;
 netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
              strnlen(family_name, GENL_NAMSIZ - 1) + 1);
 int n = 0;
 int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
 if (err < 0) {
   return -1;
 }
 uint16_t id = 0;
 struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                        NLMSG_ALIGN(sizeof(genlhdr)));
 for (; (char*)attr < nlmsg->buf + n;
      attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
   if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
     id = *(uint16_t*)(attr + 1);
     break;
   }
 }
 if (!id) {
   errno = EINVAL;
   return -1;
 }
 recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 return id;
}

const int kInitNetNsFd = 201;

static long syz_init_net_socket(volatile long domain,
                               volatile long type,
                               volatile long proto) {
 return syscall(__NR_socket, domain, type, proto);
}

static long syz_genetlink_get_family_id(volatile long name,
                                       volatile long sock_arg) {
 int fd = sock_arg;
 if (fd < 0) {
   fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
   if (fd == -1) {
     return -1;
   }
 }
 struct nlmsg nlmsg_tmp;
 int ret = netlink_query_family_id(&nlmsg_tmp, fd, (char*)name, false);
 if ((int)sock_arg < 0)
   close(fd);
 if (ret < 0) {
   return -1;
 }
 return ret;
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i = 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) == pid)
     return;
   usleep(1000);
 }
 DIR* dir = opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent = readdir(dir);
     if (!ent)
       break;
     if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd = open(abort, O_WRONLY);
     if (fd == -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) != pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
 struct thread_t* th = (struct thread_t*)arg;
 for (;;) {
   event_wait(&th->ready);
   event_reset(&th->ready);
   execute_call(th->call);
   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
   event_set(&th->done);
 }
 return 0;
}

static void execute_one(void) {
 int i, call, thread;
 for (call = 0; call < 7; call++) {
   for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th = &threads[thread];
     if (!th->created) {
       th->created = 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done))
       continue;
     event_reset(&th->done);
     th->call = call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter = 0;
 for (;; iter++) {
   int pid = fork();
   if (pid < 0)
     exit(1);
   if (pid == 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status = 0;
   uint64_t start = current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[4] = {0xffffffffffffffff, 0x0, 0xffffffffffffffff, 0x0};

void execute_call(int call) {
 intptr_t res = 0;
 switch (call) {
   case 0:
     memcpy((void*)0x20000080, "/dev/virtual_nci\000", 17);
     res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul,
                   /*file=*/0x20000080ul, /*flags=*/2ul, /*mode=*/0ul);
     if (res != -1)
       r[0] = res;
     break;
   case 1:
     res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0, /*arg=*/0x200000c0ul);
     if (res != -1)
       r[1] = *(uint32_t*)0x200000c0;
     break;
   case 2:
     res = -1;
     res = syz_init_net_socket(/*domain=*/0x10, /*type=*/3, /*proto=*/0x10);
     if (res != -1)
       r[2] = res;
     break;
   case 3:
     memcpy((void*)0x20000100, "nfc\000", 4);
     res = -1;
     res = syz_genetlink_get_family_id(/*name=*/0x20000100, /*fd=*/r[2]);
     if (res != -1)
       r[3] = res;
     break;
   case 4:
     *(uint64_t*)0x20000140 = 0;
     *(uint32_t*)0x20000148 = 0;
     *(uint64_t*)0x20000150 = 0x20000180;
     *(uint64_t*)0x20000180 = 0x200001c0;
     *(uint32_t*)0x200001c0 = 0x1c;
     *(uint16_t*)0x200001c4 = r[3];
     *(uint16_t*)0x200001c6 = 1;
     *(uint32_t*)0x200001c8 = 0;
     *(uint32_t*)0x200001cc = 0;
     *(uint8_t*)0x200001d0 = 2;
     *(uint8_t*)0x200001d1 = 0;
     *(uint16_t*)0x200001d2 = 0;
     *(uint16_t*)0x200001d4 = 8;
     *(uint16_t*)0x200001d6 = 1;
     *(uint32_t*)0x200001d8 = r[1];
     *(uint64_t*)0x20000188 = 0x1c;
     *(uint64_t*)0x20000158 = 1;
     *(uint64_t*)0x20000160 = 0;
     *(uint64_t*)0x20000168 = 0;
     *(uint32_t*)0x20000170 = 0;
     syscall(__NR_sendmsg, /*fd=*/r[2], /*msg=*/0x20000140ul, /*f=*/0ul);
     break;
   case 5:
     memcpy((void*)0x20000280, "\x40\x00\x00\x00\xe7", 5);
     syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000280ul, /*len=*/6ul);
     break;
   case 6:
     STORE_BY_BITMASK(uint8_t, , 0x20000a80, 0, 0, 4);
     STORE_BY_BITMASK(uint8_t, , 0x20000a80, 0, 4, 1);
     STORE_BY_BITMASK(uint8_t, , 0x20000a80, 2, 5, 3);
     *(uint8_t*)0x20000a81 = 1;
     *(uint8_t*)0x20000a82 = 0;
     *(uint8_t*)0x20000a83 = 0;
     *(uint32_t*)0x20000a84 = 0;
     *(uint8_t*)0x20000a88 = 0;
     *(uint8_t*)0x20000a89 = 0;
     *(uint16_t*)0x20000a8a = 0;
     *(uint8_t*)0x20000a8c = 0;
     *(uint16_t*)0x20000a8d = 0;
     *(uint8_t*)0x20000a8f = 0;
     *(uint32_t*)0x20000a90 = 9;
     syscall(__NR_write, /*fd=*/r[0], /*data=*/0x20000a80ul, /*len=*/0x14ul);
     break;
 }
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
         /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
         /*offset=*/0ul);
 loop();
 return 0;
}


Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt and wait for about 1minus, the bug triggered very
steady.
=* repro.txt =*
r0 = openat$nci(0xffffffffffffff9c, &(0x7f0000000080), 0x2, 0x0)
ioctl$IOCTL_GET_NCIDEV_IDX(r0, 0x0, &(0x7f00000000c0)=<r1=>0x0)
r2 = syz_init_net_socket$nl_generic(0x10, 0x3, 0x10)
r3 = syz_genetlink_get_family_id$nfc(&(0x7f0000000100), r2)
sendmsg$NFC_CMD_DEV_UP(r2, &(0x7f0000000140)={0x0, 0x0,
&(0x7f0000000180)={&(0x7f00000001c0)={0x1c, r3, 0x1, 0x0, 0x0, {},
[@NFC_ATTR_DEVICE_INDEX={0x8, 0x1, r1}]}, 0x1c}}, 0x0)
write$nci(r0, &(0x7f0000000280)=ANY=[@ANYBLOB="40000000e7"], 0x6)
write$nci(r0, &(0x7f0000000a80)=@NCI_OP_CORE_INIT_RSP={0x0, 0x0, 0x2,
0x1, 0x0, {{}, {0x0, 0x0, 0x0, 0x0, 0x0, 0x9}}}, 0x14)

and see also in
https://gist.github.com/xrivendell7/3c9698f97a9418451c49aa9e275f7c51

BTW, in the reproducing progress, I found this bug maybe very close to
the KMSAN: uninit-value in
nci_rx_work(https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534)
and KMSAN: uninit-value in
nci_ntf_packet(https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534),
since the console_log can also generate this two bugs.

I hope it helps.

Best regards
xingwei Lee


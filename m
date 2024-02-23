Return-Path: <linux-kernel+bounces-78554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC9F8614EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6501F22250
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C4225CF;
	Fri, 23 Feb 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMe/DAk1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F837C;
	Fri, 23 Feb 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700177; cv=none; b=INIY1DLlNf3fu5YS8JgFUCulg2PHHnMEg2PAQK1ASaUx3YHn4Mi6Sd/mUxgCPi/H2W0dKEOao5nPcIDjeg1VsHbvrYZ64qiJvBmHnzXcauvmItKsj23Aiyg6wdrCAVr+WLvNw1H9y66U5gTLUfw/GyS0aPdf5lEt6EvVcKI3jMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700177; c=relaxed/simple;
	bh=LxDt/wewfMs4rdm3Spu/VxQp8UnCgHgUG2SfONayW4A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QRCQ3jblFDNnmkAJtGeUP2ZSvYV51zoZ6AN3TjCuX+dV7doXO/e1Pu0YqSxqr0xmIBrHutwAXm8T12WdsNLcJY6ag4WuRN3JkbYDZgqlycdGbV9o7alcu5DowHsAiWKHr87plfgQyCbw8hGnaWIC4XeFaf2OKTqD3EqHZe1g1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMe/DAk1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29996cc6382so262701a91.3;
        Fri, 23 Feb 2024 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700175; x=1709304975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg3BLWjny4LSUOsBe3HU6vhfBpDPlMpZ368tY0RgQiA=;
        b=VMe/DAk13BpLpsxR9xDJHvztgAT6fHxpGjyZD41IkIDInl5g/4h6G3nTcBuOMPqieY
         DRcdzVzPyw23ePyxrfAoL4hUOi0tNVUWpBKnHz3ggoXm/BhmJs32yuq66IdSpgDMmc2t
         19o2sgsuss5KqZOjdmWIZUKjDUOP9Jcl/Szy42ch/0F+FACFw2aqZpVmTmXZe2C8jfXT
         RHxG//TpGbIpCzMxrNRg/JkOmbZ5c6jbANKNpvpKLfwfji++CRo75gmmJo+oE+JLTHXx
         OqvpOy0PO48bYEN3j6ZIs76hbIbzeODS2ZQWtdxh09ZM01xIkwiVyknYNzO5zpvjXK1q
         hMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700175; x=1709304975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lg3BLWjny4LSUOsBe3HU6vhfBpDPlMpZ368tY0RgQiA=;
        b=wJnWSToK9nSZo3J/wVI/CfubnIymqU+DGB+pHJll3W1ApqUh4i2PDiDftANwWnscjj
         eU/idA/zbcfAnWE7UDGlkJPpNMglkt583+5KNQonbMETSM6elnzfYH0vgEdXBfFtzyR4
         +/lIzEX61KQfOX3q3DqwQj7IJpfNiF0ka0sw4K53HK0WQTJ5k8ZLRIfq+iwZKHZLw/Em
         v8NUTX/V4ieX/3g0NfPi1mFhK7wU4DgHMIMN9dicCIKHzUpJWdZNeVXxKjJnTGk6BYIC
         TG7svTm+IPWU3mm5+w5eDi0ji2WIJvhqQpMsfcKWvJhMze6QxA7fNATKRvfI8epcV+j/
         lUkw==
X-Forwarded-Encrypted: i=1; AJvYcCXWYcVt+Qa1B6za07tQgwPKrGBEAfWRw7JbPQyjdCOtBtit5thi/sMdHiFMY3M7XK8U6wBMonCGpRHI0U21eoxix0c9M1+3EHzwziNO1oX4eXfdwUSEdM0RZMe9oc+8Uro2d4XJdv9gVFE8
X-Gm-Message-State: AOJu0Yx84AgM0KWY6ZivKfs93k1ght/xfWe+Pb9O0uyEqJMzcXHADtZ7
	4QxaD6wzbXBFbIhjzPD9JjHnNu5CLtM+W4AaEaW+5H7PqqNygNhmc8SLTutpMVLOyAJOmoBQigJ
	bSrCML/o7KogcANlZnTortQPhB2/PC7ZI
X-Google-Smtp-Source: AGHT+IGV6EZiZMA5Km+71/vmwDQoY7BLwzyQRAYpIoesImoUUt4bev3m+4b+C/SOD3+AKftBZgQiziWUSDmuJrT86Ro=
X-Received: by 2002:a17:90a:d497:b0:299:11e4:619d with SMTP id
 s23-20020a17090ad49700b0029911e4619dmr23214pju.33.1708700174684; Fri, 23 Feb
 2024 06:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Fri, 23 Feb 2024 22:56:03 +0800
Message-ID: <CABOYnLwxSKJkGLDEOA=H7b6UBH4C77GOVVHc3dTunJ37L7kD0A@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in des3_ede_decrypt
To: syzbot+b90b904ef6bdfdafec1d@syzkaller.appspotmail.com
Cc: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug in the upstream linux.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

Notice: I use the same config with syzbot dashboard.
kernel version: 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3De3=
dd779fba027968
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

BTW, I notice the frist patch apply in this bug:
https://lore.kernel.org/all/ZdW9YBgTtaXo7DGQ@gondor.apana.org.au/T/
and git apply this patch in the kernel. Since the reproducer is an
infinite loop, I run the reproducer for about 20minus it doesn=E2=80=99t
trigger the same issue.

Anyway, the reproducer I=E2=80=99ll provided as below.

=3D* repro.c =3D*
// autogenerated by syzkaller (https://github.com/google/syzkaller)
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
 int i =3D 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno =3D=3D EAGAIN) {
     usleep(50);
     continue;
   }
   break;
 }
 exit(1);
}

typedef struct {
 int state;
} event_t;

static void event_init(event_t* ev) {
 ev->state =3D 0;
}

static void event_reset(event_t* ev) {
 ev->state =3D 0;
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
 uint64_t start =3D current_time_ms();
 uint64_t now =3D start;
 for (;;) {
   uint64_t remain =3D timeout - (now - start);
   struct timespec ts;
   ts.tv_sec =3D remain / 1000;
   ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
     return 1;
   now =3D current_time_ms();
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
 buf[sizeof(buf) - 1] =3D 0;
 int len =3D strlen(buf);
 int fd =3D open(file, O_WRONLY | O_CLOEXEC);
 if (fd =3D=3D -1)
   return false;
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

static void netlink_init(struct nlmsg* nlmsg,
                        int typ,
                        int flags,
                        const void* data,
                        int size) {
 memset(nlmsg, 0, sizeof(*nlmsg));
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_type =3D typ;
 hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
 memcpy(hdr + 1, data, size);
 nlmsg->pos =3D (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg,
                        int typ,
                        const void* data,
                        int size) {
 struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
 attr->nla_len =3D sizeof(*attr) + size;
 attr->nla_type =3D typ;
 if (size > 0)
   memcpy(attr + 1, data, size);
 nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
}

static int netlink_send_ext(struct nlmsg* nlmsg,
                           int sock,
                           uint16_t reply_type,
                           int* reply_len,
                           bool dofail) {
 if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
   exit(1);
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
 struct sockaddr_nl addr;
 memset(&addr, 0, sizeof(addr));
 addr.nl_family =3D AF_NETLINK;
 ssize_t n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                    (struct sockaddr*)&addr, sizeof(addr));
 if (n !=3D (ssize_t)hdr->nlmsg_len) {
   if (dofail)
     exit(1);
   return -1;
 }
 n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 if (reply_len)
   *reply_len =3D 0;
 if (n < 0) {
   if (dofail)
     exit(1);
   return -1;
 }
 if (n < (ssize_t)sizeof(struct nlmsghdr)) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type =3D=3D NLMSG_DONE)
   return 0;
 if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
   *reply_len =3D n;
   return 0;
 }
 if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type !=3D NLMSG_ERROR) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 errno =3D -((struct nlmsgerr*)(hdr + 1))->error;
 return -errno;
}

static int netlink_query_family_id(struct nlmsg* nlmsg,
                                  int sock,
                                  const char* family_name,
                                  bool dofail) {
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

static long syz_genetlink_get_family_id(volatile long name,
                                       volatile long sock_arg) {
 int fd =3D sock_arg;
 if (fd < 0) {
   fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
   if (fd =3D=3D -1) {
     return -1;
   }
 }
 struct nlmsg nlmsg_tmp;
 int ret =3D netlink_query_family_id(&nlmsg_tmp, fd, (char*)name, false);
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
 for (int i =3D 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
     return;
   usleep(1000);
 }
 DIR* dir =3D opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent =3D readdir(dir);
     if (!ent)
       break;
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

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
 struct thread_t* th =3D (struct thread_t*)arg;
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
 for (call =3D 0; call < 7; call++) {
   for (thread =3D 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th =3D &threads[thread];
     if (!th->created) {
       th->created =3D 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done))
       continue;
     event_reset(&th->done);
     th->call =3D call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter =3D 0;
 for (;; iter++) {
   int pid =3D fork();
   if (pid < 0)
     exit(1);
   if (pid =3D=3D 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status =3D 0;
   uint64_t start =3D current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
 intptr_t res =3D 0;
 switch (call) {
   case 0:
     res =3D syscall(__NR_socket, /*domain=3D*/0x26ul, /*type=3D*/5ul, /*pr=
oto=3D*/0);
     if (res !=3D -1)
       r[0] =3D res;
     break;
   case 1:
     *(uint16_t*)0x20000000 =3D 0x26;
     memcpy((void*)0x20000002, "skcipher\000\000\000\000\000\000", 14);
     *(uint32_t*)0x20000010 =3D 0;
     *(uint32_t*)0x20000014 =3D 0;
     memcpy((void*)0x20000018,
            "cts(cbc(des3_ede))"
            "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00"
            "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0=
00"
            "\000\000\000\000\000\000\000\000\000\000\000\000\000\000",
            64);
     syscall(__NR_bind, /*fd=3D*/r[0], /*addr=3D*/0x20000000ul,
             /*addrlen=3D*/0x58ul);
     break;
   case 2:
     memcpy((void*)0x20c18000,
            "\xad\x56\xb6\xc5\x82\x0f\xae\x9d\x6d\xcd\x32\x92\xea\x54\xc7\x=
be"
            "\xef\x91\x5d\x56\x4c\x90\xc2\x00",
            24);
     syscall(__NR_setsockopt, /*fd=3D*/r[0], /*level=3D*/0x117, /*opt=3D*/1=
,
             /*key=3D*/0x20c18000ul, /*keylen=3D*/0x18ul);
     break;
   case 3:
     res =3D syscall(__NR_accept4, /*fd=3D*/r[0], /*peer=3D*/0ul, /*peerlen=
=3D*/0ul,
                   /*flags=3D*/0ul);
     if (res !=3D -1)
       r[1] =3D res;
     break;
   case 4:
     memcpy((void*)0x20000100, "nl80211\000", 8);
     syz_genetlink_get_family_id(/*name=3D*/0x20000100, /*fd=3D*/r[1]);
     break;
   case 5:
     *(uint64_t*)0x200001c0 =3D 0;
     *(uint32_t*)0x200001c8 =3D 0;
     *(uint64_t*)0x200001d0 =3D 0x20000180;
     *(uint64_t*)0x20000180 =3D 0x20000140;
     *(uint32_t*)0x20000140 =3D 0x28;
     *(uint16_t*)0x20000144 =3D 0;
     *(uint16_t*)0x20000146 =3D 0;
     *(uint32_t*)0x20000148 =3D 0;
     *(uint32_t*)0x2000014c =3D 0;
     *(uint8_t*)0x20000150 =3D 0x35;
     *(uint8_t*)0x20000151 =3D 0;
     *(uint16_t*)0x20000152 =3D 0;
     *(uint16_t*)0x20000154 =3D 8;
     *(uint16_t*)0x20000156 =3D 3;
     *(uint32_t*)0x20000158 =3D 0;
     *(uint16_t*)0x2000015c =3D 0xc;
     *(uint16_t*)0x2000015e =3D 0x99;
     *(uint32_t*)0x20000160 =3D 0;
     *(uint32_t*)0x20000164 =3D 0;
     *(uint64_t*)0x20000188 =3D 0x28;
     *(uint64_t*)0x200001d8 =3D 1;
     *(uint64_t*)0x200001e0 =3D 0;
     *(uint64_t*)0x200001e8 =3D 0;
     *(uint32_t*)0x200001f0 =3D 0;
     syscall(__NR_sendmsg, /*fd=3D*/r[1], /*msg=3D*/0x200001c0ul, /*f=3D*/0=
x8000ul);
     break;
   case 6:
     *(uint64_t*)0x20003fc0 =3D 0;
     *(uint32_t*)0x20003fc8 =3D 0;
     *(uint64_t*)0x20003fd0 =3D 0x20000080;
     *(uint64_t*)0x20000080 =3D 0x20000380;
     memcpy((void*)0x20000380,
            "\x05\xe2\x7d\x49\x1f\xdb\x75\x96\x99\x7a\xf6\xa7", 12);
     *(uint64_t*)0x20000088 =3D 0xc;
     *(uint64_t*)0x20003fd8 =3D 1;
     *(uint64_t*)0x20003fe0 =3D 0;
     *(uint64_t*)0x20003fe8 =3D 0;
     *(uint32_t*)0x20003ff0 =3D 0;
     *(uint32_t*)0x20003ff8 =3D 0;
     syscall(__NR_sendmmsg, /*fd=3D*/r[1], /*mmsg=3D*/0x20003fc0ul, /*vlen=
=3D*/1ul,
             /*f=3D*/0ul);
     break;
 }
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
 loop();
 return 0;
}

Remember to run this repro.txt with the command: syz-execprog -repeat
0 ./repro.txt and wait, the bug triggered very steady.

=3D* repro.txt =3D*
r0 =3D socket$alg(0x26, 0x5, 0x0)
bind$alg(r0, &(0x7f0000000000)=3D{0x26, 'skcipher\x00', 0x0, 0x0,
'cts(cbc(des3_ede))\x00'}, 0x58)
setsockopt$ALG_SET_KEY(r0, 0x117, 0x1,
&(0x7f0000c18000)=3D"ad56b6c5820fae9d6dcd3292ea54c7beef915d564c90c200",
0x18)
r1 =3D accept4(r0, 0x0, 0x0, 0x0)
syz_genetlink_get_family_id$nl80211(&(0x7f0000000100), r1)
sendmsg$NL80211_CMD_DEL_PMKSA(r1, &(0x7f00000001c0)=3D{0x0, 0x0,
&(0x7f0000000180)=3D{&(0x7f0000000140)=3D{0x28, 0x0, 0x0, 0x0, 0x0, {{},
{@val=3D{0x8}, @val=3D{0xc}}}}, 0x28}}, 0x8000)
sendmmsg$unix(r1, &(0x7f0000003fc0)=3D[{{0x0, 0x0,
&(0x7f0000000080)=3D[{&(0x7f0000000380)=3D"05e27d491fdb7596997af6a7",
0xc}], 0x1}}], 0x1, 0x0)

and see also in
https://gist.github.com/xrivendell7/caa81fc506c57143468d8df12e099831.

I hope it helps.
Best regards!
xingwei Lee


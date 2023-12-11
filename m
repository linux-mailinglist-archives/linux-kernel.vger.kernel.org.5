Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5F80CE48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbjLKOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjLKOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:24:40 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CD10E6;
        Mon, 11 Dec 2023 06:16:07 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so2635271b3a.1;
        Mon, 11 Dec 2023 06:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304167; x=1702908967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O2d8lubJvLF9yel9cqzf7PbDW3sW0A++qP/08Y9f2Bc=;
        b=XaaROK+sFT+3+ZTVa2n2EaAp7xnPCAaQ297ZYBMmNAsVvZAt1vdtXim1kJFCfUfx/H
         cXEFjteHgm7t5Al7JRhlKiCN+9+BR96ltw4Qg49iEvWmA6fVGom0dN1LgBNEbcRvMds9
         t1JL1ZuysqbLQm2eKQSGRK15eW+nbTjxL6D+T6MiLu3lNqUpR+0gHQQchLNtD8+esfS5
         Bnmz/Tgj8z80H0ICgGPwxBp4HwoAYlnpFBurfQqm9vEKBOLIf57htGgVX6gwDNdSdx4x
         f5iuAp9UTtRqIOmNuIGtP7ASVNwIynwvbL4jsVcnBlk49e7fg4/vaTKtulUmDszS2QBc
         eAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304167; x=1702908967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2d8lubJvLF9yel9cqzf7PbDW3sW0A++qP/08Y9f2Bc=;
        b=nSBs8UL9tCBCAyZ68iz0rva9CcC6eVDyB2FBWDhK8T/k/tIPZ9LrSWsRHNxKOSa0r0
         bMtKZWyC2B9uz3Ahsun+TxwH0+IPxMZFf5Co0PgyfQBHz+KJrrhI8/ghFz8SL2uznJgu
         hopXvAHQie70K6gZWKRAZeqO9wfK5z12a9IYpVVSfVhIbb52RyEoCU5H34oV3UHz0A9U
         k7AQ63/q4IwUVJryEkKaVKJUjQki/EvRwoIkGB2VjgB+Ag08P7DsrZn3NEwsWCb6phgp
         gpmMPxoHqXPzKaJSUqDlP+vuaQZ8uJHdiaUJX9h5ZxeczhfrrXWNglzxOX8EpeBTqvNj
         mWgg==
X-Gm-Message-State: AOJu0YzGm4WmyDjk/y2oIfjWDdSIprMJmTl7ujSKXbycrKpVk4eCocKg
        NnK4cpYF9gy4mJHX8ozrVs+moSLBBe60QtLZofypZasrMeTiMFtYiR0=
X-Google-Smtp-Source: AGHT+IF2jCKnuOzm/K4321gX8AKu6jz0D2T75kzbfpAd8IyER0R14Wgb2ioi3uajlAG8pJj7Ok/h9A5CT3qYkxjpa/8=
X-Received: by 2002:a05:6a21:3297:b0:18f:97c:8245 with SMTP id
 yt23-20020a056a21329700b0018f097c8245mr2397546pzb.79.1702304166626; Mon, 11
 Dec 2023 06:16:06 -0800 (PST)
MIME-Version: 1.0
From:   xingwei lee <xrivendell7@gmail.com>
Date:   Mon, 11 Dec 2023 22:15:53 +0800
Message-ID: <CABOYnLzNbUf5P2Pcz6snqTbutcfebPRPunPT6Oom8VmQ=mHZaA@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] WARNING: refcount bug in sco_sock_timeout (2)
To:     syzbot+c689847e27e0fa3e7a5d@syzkaller.appspotmail.com,
        syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com,
        syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Notice this bug haven=E2=80=99t reproduce, I try my efforts reproduce this
with repro.c and repro.txt and I confirmed it crashed in the lastest
net tree.
kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.g=
it/commit/?id=3De307b5a845c5951dabafc48d00b6424ee64716c4
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3Df8=
715b6ede5c4b90
However, this repro.c executed in the lastest net tree crashed titled
KASAN: slab-use-after-free Write in sco_sock_timeout
https://syzkaller.appspot.com/bug?extid=3D4c0d0c4cde787116d465

However, I submit 3 repro.c maybe related to this bug:
https://lore.kernel.org/all/CABOYnLwbz-Es5A+aa28yv-ApQ-X8Dr0E8FzCpLWm-4Vt4D=
KS1Q@mail.gmail.com/T/

This repro.c seems different from the above three and so I feel it is
necessary to inform.
I don=E2=80=99t analysis deeply and I also don=E2=80=99t know if these two =
bugs are
the same or related or not.
Hope it helps.

=3D* repro.c =3D*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <linux/futex.h>
#include <linux/rfkill.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/epoll.h>
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

#ifndef __NR_finit_module
#define __NR_finit_module 313
#endif
#ifndef __NR_landlock_create_ruleset
#define __NR_landlock_create_ruleset 444
#endif

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
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

static void event_init(event_t* ev) { ev->state =3D 0; }

static void event_reset(event_t* ev) { ev->state =3D 0; }

static void event_set(event_t* ev) {
 if (ev->state) exit(1);
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
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE)) return 1;
   now =3D current_time_ms();
   if (now - start > timeout) return 0;
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

const int kInitNetNsFd =3D 201;

#define MAX_FDS 30

static long syz_init_net_socket(volatile long domain, volatile long type,
                               volatile long proto) {
 int netns =3D open("/proc/self/ns/net", O_RDONLY);
 if (netns =3D=3D -1) return netns;
 if (setns(kInitNetNsFd, 0)) return -1;
 int sock =3D syscall(__NR_socket, domain, type, proto);
 int err =3D errno;
 if (setns(netns, 0)) exit(1);
 close(netns);
 errno =3D err;
 return sock;
}

#define BTPROTO_HCI 1
#define ACL_LINK 1
#define SCAN_PAGE 2

typedef struct {
 uint8_t b[6];
} __attribute__((packed)) bdaddr_t;

#define HCI_COMMAND_PKT 1
#define HCI_EVENT_PKT 4
#define HCI_VENDOR_PKT 0xff

struct hci_command_hdr {
 uint16_t opcode;
 uint8_t plen;
} __attribute__((packed));

struct hci_event_hdr {
 uint8_t evt;
 uint8_t plen;
} __attribute__((packed));

#define HCI_EV_CONN_COMPLETE 0x03
struct hci_ev_conn_complete {
 uint8_t status;
 uint16_t handle;
 bdaddr_t bdaddr;
 uint8_t link_type;
 uint8_t encr_mode;
} __attribute__((packed));

#define HCI_EV_CONN_REQUEST 0x04
struct hci_ev_conn_request {
 bdaddr_t bdaddr;
 uint8_t dev_class[3];
 uint8_t link_type;
} __attribute__((packed));

#define HCI_EV_REMOTE_FEATURES 0x0b
struct hci_ev_remote_features {
 uint8_t status;
 uint16_t handle;
 uint8_t features[8];
} __attribute__((packed));

#define HCI_EV_CMD_COMPLETE 0x0e
struct hci_ev_cmd_complete {
 uint8_t ncmd;
 uint16_t opcode;
} __attribute__((packed));

#define HCI_OP_WRITE_SCAN_ENABLE 0x0c1a

#define HCI_OP_READ_BUFFER_SIZE 0x1005
struct hci_rp_read_buffer_size {
 uint8_t status;
 uint16_t acl_mtu;
 uint8_t sco_mtu;
 uint16_t acl_max_pkt;
 uint16_t sco_max_pkt;
} __attribute__((packed));

#define HCI_OP_READ_BD_ADDR 0x1009
struct hci_rp_read_bd_addr {
 uint8_t status;
 bdaddr_t bdaddr;
} __attribute__((packed));

#define HCI_EV_LE_META 0x3e
struct hci_ev_le_meta {
 uint8_t subevent;
} __attribute__((packed));

#define HCI_EV_LE_CONN_COMPLETE 0x01
struct hci_ev_le_conn_complete {
 uint8_t status;
 uint16_t handle;
 uint8_t role;
 uint8_t bdaddr_type;
 bdaddr_t bdaddr;
 uint16_t interval;
 uint16_t latency;
 uint16_t supervision_timeout;
 uint8_t clk_accurancy;
} __attribute__((packed));

struct hci_dev_req {
 uint16_t dev_id;
 uint32_t dev_opt;
};

struct vhci_vendor_pkt_request {
 uint8_t type;
 uint8_t opcode;
} __attribute__((packed));

struct vhci_pkt {
 uint8_t type;
 union {
   struct {
     uint8_t opcode;
     uint16_t id;
   } __attribute__((packed)) vendor_pkt;
   struct hci_command_hdr command_hdr;
 };
} __attribute__((packed));

#define HCIDEVUP _IOW('H', 201, int)
#define HCISETSCAN _IOW('H', 221, int)

static int vhci_fd =3D -1;

static void rfkill_unblock_all() {
 int fd =3D open("/dev/rfkill", O_WRONLY);
 if (fd < 0) exit(1);
 struct rfkill_event event =3D {0};
 event.idx =3D 0;
 event.type =3D RFKILL_TYPE_ALL;
 event.op =3D RFKILL_OP_CHANGE_ALL;
 event.soft =3D 0;
 event.hard =3D 0;
 if (write(fd, &event, sizeof(event)) < 0) exit(1);
 close(fd);
}

static void hci_send_event_packet(int fd, uint8_t evt, void* data,
                                 size_t data_len) {
 struct iovec iv[3];
 struct hci_event_hdr hdr;
 hdr.evt =3D evt;
 hdr.plen =3D data_len;
 uint8_t type =3D HCI_EVENT_PKT;
 iv[0].iov_base =3D &type;
 iv[0].iov_len =3D sizeof(type);
 iv[1].iov_base =3D &hdr;
 iv[1].iov_len =3D sizeof(hdr);
 iv[2].iov_base =3D data;
 iv[2].iov_len =3D data_len;
 if (writev(fd, iv, sizeof(iv) / sizeof(struct iovec)) < 0) exit(1);
}

static void hci_send_event_cmd_complete(int fd, uint16_t opcode, void* data=
,
                                       size_t data_len) {
 struct iovec iv[4];
 struct hci_event_hdr hdr;
 hdr.evt =3D HCI_EV_CMD_COMPLETE;
 hdr.plen =3D sizeof(struct hci_ev_cmd_complete) + data_len;
 struct hci_ev_cmd_complete evt_hdr;
 evt_hdr.ncmd =3D 1;
 evt_hdr.opcode =3D opcode;
 uint8_t type =3D HCI_EVENT_PKT;
 iv[0].iov_base =3D &type;
 iv[0].iov_len =3D sizeof(type);
 iv[1].iov_base =3D &hdr;
 iv[1].iov_len =3D sizeof(hdr);
 iv[2].iov_base =3D &evt_hdr;
 iv[2].iov_len =3D sizeof(evt_hdr);
 iv[3].iov_base =3D data;
 iv[3].iov_len =3D data_len;
 if (writev(fd, iv, sizeof(iv) / sizeof(struct iovec)) < 0) exit(1);
}

static bool process_command_pkt(int fd, char* buf, ssize_t buf_size) {
 struct hci_command_hdr* hdr =3D (struct hci_command_hdr*)buf;
 if (buf_size < (ssize_t)sizeof(struct hci_command_hdr) ||
     hdr->plen !=3D buf_size - sizeof(struct hci_command_hdr))
   exit(1);
 switch (hdr->opcode) {
   case HCI_OP_WRITE_SCAN_ENABLE: {
     uint8_t status =3D 0;
     hci_send_event_cmd_complete(fd, hdr->opcode, &status, sizeof(status));
     return true;
   }
   case HCI_OP_READ_BD_ADDR: {
     struct hci_rp_read_bd_addr rp =3D {0};
     rp.status =3D 0;
     memset(&rp.bdaddr, 0xaa, 6);
     hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
     return false;
   }
   case HCI_OP_READ_BUFFER_SIZE: {
     struct hci_rp_read_buffer_size rp =3D {0};
     rp.status =3D 0;
     rp.acl_mtu =3D 1021;
     rp.sco_mtu =3D 96;
     rp.acl_max_pkt =3D 4;
     rp.sco_max_pkt =3D 6;
     hci_send_event_cmd_complete(fd, hdr->opcode, &rp, sizeof(rp));
     return false;
   }
 }
 char dummy[0xf9] =3D {0};
 hci_send_event_cmd_complete(fd, hdr->opcode, dummy, sizeof(dummy));
 return false;
}

static void* event_thread(void* arg) {
 while (1) {
   char buf[1024] =3D {0};
   ssize_t buf_size =3D read(vhci_fd, buf, sizeof(buf));
   if (buf_size < 0) exit(1);
   if (buf_size > 0 && buf[0] =3D=3D HCI_COMMAND_PKT) {
     if (process_command_pkt(vhci_fd, buf + 1, buf_size - 1)) break;
   }
 }
 return NULL;
}
#define HCI_HANDLE_1 200
#define HCI_HANDLE_2 201

#define HCI_PRIMARY 0
#define HCI_OP_RESET 0x0c03

static void initialize_vhci() {
 int hci_sock =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 if (hci_sock < 0) exit(1);
 vhci_fd =3D open("/dev/vhci", O_RDWR);
 if (vhci_fd =3D=3D -1) exit(1);
 const int kVhciFd =3D 202;
 if (dup2(vhci_fd, kVhciFd) < 0) exit(1);
 close(vhci_fd);
 vhci_fd =3D kVhciFd;
 struct vhci_vendor_pkt_request vendor_pkt_req =3D {HCI_VENDOR_PKT, HCI_PRI=
MARY};
 if (write(vhci_fd, &vendor_pkt_req, sizeof(vendor_pkt_req)) !=3D
     sizeof(vendor_pkt_req))
   exit(1);
 struct vhci_pkt vhci_pkt;
 if (read(vhci_fd, &vhci_pkt, sizeof(vhci_pkt)) !=3D sizeof(vhci_pkt)) exit=
(1);
 if (vhci_pkt.type =3D=3D HCI_COMMAND_PKT &&
     vhci_pkt.command_hdr.opcode =3D=3D HCI_OP_RESET) {
   char response[1] =3D {0};
   hci_send_event_cmd_complete(vhci_fd, HCI_OP_RESET, response,
                               sizeof(response));
   if (read(vhci_fd, &vhci_pkt, sizeof(vhci_pkt)) !=3D sizeof(vhci_pkt)) ex=
it(1);
 }
 if (vhci_pkt.type !=3D HCI_VENDOR_PKT) exit(1);
 int dev_id =3D vhci_pkt.vendor_pkt.id;
 pthread_t th;
 if (pthread_create(&th, NULL, event_thread, NULL)) exit(1);
 int ret =3D ioctl(hci_sock, HCIDEVUP, dev_id);
 if (ret) {
   if (errno =3D=3D ERFKILL) {
     rfkill_unblock_all();
     ret =3D ioctl(hci_sock, HCIDEVUP, dev_id);
   }
   if (ret && errno !=3D EALREADY) exit(1);
 }
 struct hci_dev_req dr =3D {0};
 dr.dev_id =3D dev_id;
 dr.dev_opt =3D SCAN_PAGE;
 if (ioctl(hci_sock, HCISETSCAN, &dr)) exit(1);
 struct hci_ev_conn_request request;
 memset(&request, 0, sizeof(request));
 memset(&request.bdaddr, 0xaa, 6);
 *(uint8_t*)&request.bdaddr.b[5] =3D 0x10;
 request.link_type =3D ACL_LINK;
 hci_send_event_packet(vhci_fd, HCI_EV_CONN_REQUEST, &request,
                       sizeof(request));
 struct hci_ev_conn_complete complete;
 memset(&complete, 0, sizeof(complete));
 complete.status =3D 0;
 complete.handle =3D HCI_HANDLE_1;
 memset(&complete.bdaddr, 0xaa, 6);
 *(uint8_t*)&complete.bdaddr.b[5] =3D 0x10;
 complete.link_type =3D ACL_LINK;
 complete.encr_mode =3D 0;
 hci_send_event_packet(vhci_fd, HCI_EV_CONN_COMPLETE, &complete,
                       sizeof(complete));
 struct hci_ev_remote_features features;
 memset(&features, 0, sizeof(features));
 features.status =3D 0;
 features.handle =3D HCI_HANDLE_1;
 hci_send_event_packet(vhci_fd, HCI_EV_REMOTE_FEATURES, &features,
                       sizeof(features));
 struct {
   struct hci_ev_le_meta le_meta;
   struct hci_ev_le_conn_complete le_conn;
 } le_conn;
 memset(&le_conn, 0, sizeof(le_conn));
 le_conn.le_meta.subevent =3D HCI_EV_LE_CONN_COMPLETE;
 memset(&le_conn.le_conn.bdaddr, 0xaa, 6);
 *(uint8_t*)&le_conn.le_conn.bdaddr.b[5] =3D 0x11;
 le_conn.le_conn.role =3D 1;
 le_conn.le_conn.handle =3D HCI_HANDLE_2;
 hci_send_event_packet(vhci_fd, HCI_EV_LE_META, &le_conn, sizeof(le_conn));
 pthread_join(th, NULL);
 close(hci_sock);
}

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
 int netns =3D open("/proc/self/ns/net", O_RDONLY);
 if (netns =3D=3D -1) exit(1);
 if (dup2(netns, kInitNetNsFd) < 0) exit(1);
 close(netns);
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
 initialize_vhci();
 sandbox_common();
 drop_caps();
 if (unshare(CLONE_NEWNET)) {
 }
 write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
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
 for (call =3D 0; call < 15; call++) {
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
     if (!event_isset(&th->done)) continue;
     event_reset(&th->done);
     th->call =3D call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     if (call =3D=3D 1 || call =3D=3D 4 || call =3D=3D 5) break;
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
 close_fds();
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

uint64_t r[1] =3D {0xffffffffffffffff};

void execute_call(int call) {
 intptr_t res =3D 0;
 switch (call) {
   case 0:
     res =3D -1;
     res =3D syz_init_net_socket(/*fam=3D*/0x1f, /*type=3D*/5, /*proto=3D*/=
2);
     if (res !=3D -1) r[0] =3D res;
     break;
   case 1:
     *(uint16_t*)0x200002c0 =3D 0x1f;
     memset((void*)0x200002c2, 0, 6);
     syscall(__NR_connect, /*fd=3D*/r[0], /*addr=3D*/0x200002c0ul,
             /*addrlen=3D*/8ul);
     break;
   case 2:
     *(uint16_t*)0x20000500 =3D 0x1f;
     memset((void*)0x20000502, 170, 5);
     *(uint8_t*)0x20000507 =3D 0x11;
     syscall(__NR_connect, /*fd=3D*/r[0], /*addr=3D*/0x20000500ul,
             /*addrlen=3D*/8ul);
     break;
   case 3:
     syscall(__NR_shutdown, /*fd=3D*/-1, /*how=3D*/0ul);
     break;
   case 4:
     syscall(__NR_open, /*file=3D*/0ul, /*flags=3D*/0x6143c2ul, /*mode=3D*/=
0x19ul);
     break;
   case 5:
     syscall(__NR_mkdirat, /*fd=3D*/-1, /*path=3D*/0ul, /*mode=3D*/8ul);
     {
       int i;
       for (i =3D 0; i < 32; i++) {
         syscall(__NR_mkdirat, /*fd=3D*/-1, /*path=3D*/0ul, /*mode=3D*/8ul)=
;
       }
     }
     break;
   case 6:
     *(uint64_t*)0x20000400 =3D 0x2081;
     *(uint64_t*)0x20000408 =3D 1;
     syscall(__NR_landlock_create_ruleset, /*attr=3D*/0x20000400ul,
             /*size=3D*/0x10ul, /*flags=3D*/0ul);
     break;
   case 7:
     syscall(__NR_ioctl, /*fd=3D*/-1, /*cmd=3D*/0x708, /*arg=3D*/0ul);
     break;
   case 8:
     syscall(__NR_getsockopt, /*fd=3D*/-1, /*level=3D*/1, /*optname=3D*/0x1=
1,
             /*optval=3D*/0ul, /*optlen=3D*/0ul);
     break;
   case 9:
     syscall(__NR_getsockopt, /*fd=3D*/-1, /*level=3D*/0x10f, /*opt=3D*/0x8=
4,
             /*val=3D*/0ul, /*len=3D*/0ul);
     break;
   case 10:
     syscall(__NR_accept, /*fd=3D*/-1, /*peer=3D*/0ul, /*peerlen=3D*/0ul);
     break;
   case 11:
     syscall(__NR_write, /*fd=3D*/-1, /*buf=3D*/0x20000a00ul, /*count=3D*/0=
ul);
     break;
   case 12:
     syscall(__NR_sendfile, /*fdout=3D*/-1, /*fdin=3D*/-1, /*off=3D*/0ul,
             /*count=3D*/0xef82ul);
     break;
   case 13:
     *(uint16_t*)0x20000080 =3D 0x1f;
     memset((void*)0x20000082, 255, 6);
     syscall(__NR_connect, /*fd=3D*/-1, /*addr=3D*/0x20000080ul, /*addrlen=
=3D*/8ul);
     break;
   case 14:
     syscall(__NR_finit_module, /*fd=3D*/-1, /*args=3D*/0ul, /*flags=3D*/1u=
l);
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
 do_sandbox_none();
 return 0;
}

=3D* repro.txt =3D*

r0 =3D syz_init_net_socket$bt_sco(0x1f, 0x5, 0x2)
connect$bt_sco(r0, &(0x7f00000002c0), 0x8) (async)
connect$bt_sco(r0, &(0x7f0000000500)=3D{0x1f,
@fixed=3D{'\xaa\xaa\xaa\xaa\xaa', 0x11}}, 0x8)
shutdown(0xffffffffffffffff, 0x0)
open(0x0, 0x6143c2, 0x19) (async)
mkdirat(0xffffffffffffffff, 0x0, 0x8) (async, rerun: 32)
landlock_create_ruleset(&(0x7f0000000400)=3D{0x2081, 0x1}, 0x10, 0x0)
ioctl$I2C_RDWR(0xffffffffffffffff, 0x708, 0x0)
getsockopt$sock_cred(0xffffffffffffffff, 0x1, 0x11, 0x0, 0x0)
getsockopt$TIPC_SOCK_RECVQ_DEPTH(0xffffffffffffffff, 0x10f, 0x84, 0x0, 0x0)
accept$alg(0xffffffffffffffff, 0x0, 0x0)
write(0xffffffffffffffff, &(0x7f0000000a00), 0x0)
sendfile(0xffffffffffffffff, 0xffffffffffffffff, 0x0, 0xef82)
connect$bt_sco(0xffffffffffffffff, &(0x7f0000000080)=3D{0x1f, @none}, 0x8)
finit_module(0xffffffffffffffff, 0x0, 0x1)

and see also https://gist.github.com/xrivendell7/c42e214061ed917254f0725d55=
64cec6

Best regards
xingwei Lee

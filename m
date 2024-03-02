Return-Path: <linux-kernel+bounces-89365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719B86EF6F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349231C2195C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF2B12E4F;
	Sat,  2 Mar 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn5lgc7N"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97726FBE;
	Sat,  2 Mar 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709366920; cv=none; b=cv2ShRC3LgB38t2h7euQ/XK6jMFnKaaQCuUocWWvTtwKBsgmD/KhYdiJTsGjdgNwM/ZMpu6fXDAoPPy0SyqDuaVHz62QbHn4RUZLf0rv8gIP90FMJtj87rdQZgfnvi0UEf1WhNbAkNo+63jGg2tITh4avSTHZBcX/C6M6fnjvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709366920; c=relaxed/simple;
	bh=AsTmKxPu9wgrL4hn3AfQzpyNkX5VCjVliiXP5Dd7V7U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XwLdulq1dGQlVuPlkPRR9ia9/HAb7vpS/u8n85NJA1q7BzOkZ6RVEluiAnUb7RUOC1w9Qrn5kAAoip8q86iLY5GUZ0M7khdWD9KZ/BB2PM51Sksi9U+m7o/eC0D60Jf24E041sJ7Q3ZYdYo3JMUQXrWhoVVC551WjxbX++XaEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn5lgc7N; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2109621a12.3;
        Sat, 02 Mar 2024 00:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709366917; x=1709971717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+aXkdFaA9UrvGjEPfzrsY8dae6YJJ0f1wW9XnHtGLI4=;
        b=Dn5lgc7NA0NwBfpVCBXwp66g3ksu8YsAL24jcMgGR8fEOvPs/IlHfW950xYmkmvSfn
         alyiTyRSSYfokvulyBzN2bElBgMLpI18Q0+EH7Crk7k6WdndQus6lPhshU3APk2W/f5+
         vMViK8iYJVIlypvUEzkmbrAi7VUmoEH6GA9N/H2ZP+UKp5RnZjOIW+/vZ2TLMXAGx8gh
         G4oqIaU9GsiG9jDlMg+9i5TuH/dxr12CGg6xuCYEe5Yq463iu4G0l9S0UcwdxsQKKzfq
         j53ExDt1fbaOcN595A09iC2ErJfxOHG/QPtblo49pflKl9SeJwIivYrLVo+r7/U5PBIO
         aDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709366917; x=1709971717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aXkdFaA9UrvGjEPfzrsY8dae6YJJ0f1wW9XnHtGLI4=;
        b=DRQn2lNZE1n3DyhMvA4ymgO86P70rzeTDZeJrRuB+lvD2ra242x0XWo5LeoIQ7dt8r
         0luo89X7HHSWd5PjKMvZuTENA1sWHCpyoh+1nUSd96I1QSVNMonY906YFM5obXJJ5JUz
         mujKAXHOpeJH02M+1O3JFmIyi/jARMhdzYTAYBjWavxb0IqB9rw4kGrTc8HmuSIS89fJ
         WnK9YtaXbSw57h0cRXZAQ8FWWTkhKjYxq3tOVED6/Hna6cWB8cASJ8Qhh/B30wUpua8e
         L34NLRzdiyrBkccZOPhOUJzHG7su/AD3lY3WQOZHI1W9kOTw4RfqHpF3Ek/4o60gV1D2
         eT6g==
X-Gm-Message-State: AOJu0YydZdiLzQQCrBrJsTah1ZMzJDKoe1GxR+tfbIGkIzK7FruxDNCp
	EC2XVdNGkPIqGajsRF09HyuJoDTOKUa1khxHWoiWWR5AN4xru2hMVBKa1J86oRzRwwHHTlirXns
	tQTpOrI2a0FOEFJizvYoiP9DuvElpWJSVux8=
X-Google-Smtp-Source: AGHT+IFqmtnBQ2vs/87SRDmjrpgb4VmbrxAUn8Dt5jVMYkxnvw+Iu6LsptdN0NsvPTOrL2SqBNPLxWavvXlZ15XhRTE=
X-Received: by 2002:a05:6a21:3285:b0:1a0:81ec:27b9 with SMTP id
 yt5-20020a056a21328500b001a081ec27b9mr4272608pzb.28.1709366916577; Sat, 02
 Mar 2024 00:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Sat, 2 Mar 2024 16:08:22 +0800
Message-ID: <CABOYnLzoHasSPPgQoSPyMwawJm5N9WytFxYhjGbwvGSH3_um6Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in v4l2_fh_open
To: linux-media@vger.kernel.org, mchehab@kernel.org, 
	syzkaller-bugs@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello I found a bug in latest upstream tree titled "KASAN:
slab-use-after-free Read in v4l2_fh_open" and aslo titled "KASAN:
slab-use-after-free Read in em28xx_release_resources=E2=80=9D.
I believe both of them are the same bug, and I found the bugs with the
same name reported by syzbot:
https://syzkaller.appspot.com/bug?extid=3Db2391895514ed9ef4a8e and
https://syzkaller.appspot.com/bug?extid=3D99d6c66dbbc484f50e1c, and I
believe this not the same bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel: lastest 5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D4a=
65fa9f077ead01
with KMSAN enabled
compiler: gcc (GCC) 12.2.0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in v4l2_fh_init+0x278/0x2c0
drivers/media/v4l2-core/v4l2-fh.c:25
Read of size 8 at addr ffff888053f9a738 by task v4l_id/21260
CPU: 0 PID: 21260 Comm: v4l_id Not tainted 6.8.0-rc6-00238-g5ad3cb0ed525 #1=
7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x5c/0xb0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:377 [inline]
print_report+0xc4/0x620 mm/kasan/report.c:488
kasan_report+0xda/0x110 mm/kasan/report.c:601
v4l2_fh_init+0x278/0x2c0 drivers/media/v4l2-core/v4l2-fh.c:25
v4l2_fh_open+0x7c/0xb0 drivers/media/v4l2-core/v4l2-fh.c:63
em28xx_v4l2_open+0x1ea/0x6a0 drivers/media/usb/em28xx/em28xx-video.c:2155
v4l2_open+0x1ed/0x400 drivers/media/v4l2-core/v4l2-dev.c:427
chrdev_open+0x215/0x610 fs/char_dev.c:414
do_dentry_open+0x5da/0x14f0 fs/open.c:953
do_open fs/namei.c:3645 [inline]
path_openat+0x1983/0x2740 fs/namei.c:3802
do_filp_open+0x1bc/0x400 fs/namei.c:3829
do_sys_openat2+0x12c/0x170 fs/open.c:1404
do_sys_open fs/open.c:1419 [inline]
__do_sys_openat fs/open.c:1435 [inline]
__se_sys_openat fs/open.c:1430 [inline]
__x64_sys_openat+0x134/0x1d0 fs/open.c:1430
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x78/0x1c0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f30564a0e01
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d ea 27 0e
00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b5
RSP: 002b:00007ffffe493a00 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f30564a0e01
RDX: 0000000000000000 RSI: 00007ffffe493f05 RDI: 00000000ffffff9c
RBP: 00007ffffe493f05 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffffe493c30 R14: 0000560ca266fbf8 R15: 00007f30565c1020
</TASK>
Allocated by task 15533:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
__kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:387
kmalloc include/linux/slab.h:590 [inline]
kzalloc include/linux/slab.h:711 [inline]
em28xx_v4l2_init+0xe6/0x3b00 drivers/media/usb/em28xx/em28xx-video.c:2534
em28xx_init_extension+0x10a/0x1c0 drivers/media/usb/em28xx/em28xx-core.c:11=
16
process_one_work+0x789/0x12a0 kernel/workqueue.c:2633
process_scheduled_works kernel/workqueue.c:2706 [inline]
worker_thread+0x6fb/0x1170 kernel/workqueue.c:2787
kthread+0x2ed/0x3d0 kernel/kthread.c:388
ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243
Freed by task 15533:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:589
poison_slab_object mm/kasan/common.c:240 [inline]
__kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
kasan_slab_free include/linux/kasan.h:184 [inline]
slab_free_hook mm/slub.c:2121 [inline]
slab_free mm/slub.c:4299 [inline]
kfree+0x124/0x360 mm/slub.c:4409
em28xx_free_v4l2 drivers/media/usb/em28xx/em28xx-video.c:2120 [inline]
kref_put include/linux/kref.h:65 [inline]
em28xx_v4l2_init+0x1d6c/0x3b00 drivers/media/usb/em28xx/em28xx-video.c:2903
em28xx_init_extension+0x10a/0x1c0 drivers/media/usb/em28xx/em28xx-core.c:11=
16
process_one_work+0x789/0x12a0 kernel/workqueue.c:2633
process_scheduled_works kernel/workqueue.c:2706 [inline]
worker_thread+0x6fb/0x1170 kernel/workqueue.c:2787
kthread+0x2ed/0x3d0 kernel/kthread.c:388
ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243



=3D* repro.c =3D*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/usb/ch9.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
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

#define MAX_FDS 30

#define USB_MAX_IFACE_NUM 4
#define USB_MAX_EP_NUM 32
#define USB_MAX_FDS 6

struct usb_endpoint_index {
 struct usb_endpoint_descriptor desc;
 int handle;
};

struct usb_iface_index {
 struct usb_interface_descriptor* iface;
 uint8_t bInterfaceNumber;
 uint8_t bAlternateSetting;
 uint8_t bInterfaceClass;
 struct usb_endpoint_index eps[USB_MAX_EP_NUM];
 int eps_num;
};

struct usb_device_index {
 struct usb_device_descriptor* dev;
 struct usb_config_descriptor* config;
 uint8_t bDeviceClass;
 uint8_t bMaxPower;
 int config_length;
 struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];
 int ifaces_num;
 int iface_cur;
};

struct usb_info {
 int fd;
 struct usb_device_index index;
};

static struct usb_info usb_devices[USB_MAX_FDS];

static struct usb_device_index* lookup_usb_index(int fd) {
 for (int i =3D 0; i < USB_MAX_FDS; i++) {
   if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) =3D=3D fd)
     return &usb_devices[i].index;
 }
 return NULL;
}

static int usb_devices_num;

static bool parse_usb_descriptor(const char* buffer,
                                size_t length,
                                struct usb_device_index* index) {
 if (length < sizeof(*index->dev) + sizeof(*index->config))
   return false;
 memset(index, 0, sizeof(*index));
 index->dev =3D (struct usb_device_descriptor*)buffer;
 index->config =3D (struct usb_config_descriptor*)(buffer + sizeof(*index->=
dev));
 index->bDeviceClass =3D index->dev->bDeviceClass;
 index->bMaxPower =3D index->config->bMaxPower;
 index->config_length =3D length - sizeof(*index->dev);
 index->iface_cur =3D -1;
 size_t offset =3D 0;
 while (true) {
   if (offset + 1 >=3D length)
     break;
   uint8_t desc_length =3D buffer[offset];
   uint8_t desc_type =3D buffer[offset + 1];
   if (desc_length <=3D 2)
     break;
   if (offset + desc_length > length)
     break;
   if (desc_type =3D=3D USB_DT_INTERFACE &&
       index->ifaces_num < USB_MAX_IFACE_NUM) {
     struct usb_interface_descriptor* iface =3D
         (struct usb_interface_descriptor*)(buffer + offset);
     index->ifaces[index->ifaces_num].iface =3D iface;
     index->ifaces[index->ifaces_num].bInterfaceNumber =3D
         iface->bInterfaceNumber;
     index->ifaces[index->ifaces_num].bAlternateSetting =3D
         iface->bAlternateSetting;
     index->ifaces[index->ifaces_num].bInterfaceClass =3D iface->bInterface=
Class;
     index->ifaces_num++;
   }
   if (desc_type =3D=3D USB_DT_ENDPOINT && index->ifaces_num > 0) {
     struct usb_iface_index* iface =3D &index->ifaces[index->ifaces_num - 1=
];
     if (iface->eps_num < USB_MAX_EP_NUM) {
       memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,
              sizeof(iface->eps[iface->eps_num].desc));
       iface->eps_num++;
     }
   }
   offset +=3D desc_length;
 }
 return true;
}

static struct usb_device_index* add_usb_index(int fd,
                                             const char* dev,
                                             size_t dev_len) {
 int i =3D __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);
 if (i >=3D USB_MAX_FDS)
   return NULL;
 if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index))
   return NULL;
 __atomic_store_n(&usb_devices[i].fd, fd, __ATOMIC_RELEASE);
 return &usb_devices[i].index;
}

struct vusb_connect_string_descriptor {
 uint32_t len;
 char* str;
} __attribute__((packed));

struct vusb_connect_descriptors {
 uint32_t qual_len;
 char* qual;
 uint32_t bos_len;
 char* bos;
 uint32_t strs_len;
 struct vusb_connect_string_descriptor strs[0];
} __attribute__((packed));

static const char default_string[] =3D {8, USB_DT_STRING, 's', 0, 'y', 0, '=
z', 0};

static const char default_lang_id[] =3D {4, USB_DT_STRING, 0x09, 0x04};

static bool lookup_connect_response_in(
   int fd,
   const struct vusb_connect_descriptors* descs,
   const struct usb_ctrlrequest* ctrl,
   struct usb_qualifier_descriptor* qual,
   char** response_data,
   uint32_t* response_length) {
 struct usb_device_index* index =3D lookup_usb_index(fd);
 uint8_t str_idx;
 if (!index)
   return false;
 switch (ctrl->bRequestType & USB_TYPE_MASK) {
   case USB_TYPE_STANDARD:
     switch (ctrl->bRequest) {
       case USB_REQ_GET_DESCRIPTOR:
         switch (ctrl->wValue >> 8) {
           case USB_DT_DEVICE:
             *response_data =3D (char*)index->dev;
             *response_length =3D sizeof(*index->dev);
             return true;
           case USB_DT_CONFIG:
             *response_data =3D (char*)index->config;
             *response_length =3D index->config_length;
             return true;
           case USB_DT_STRING:
             str_idx =3D (uint8_t)ctrl->wValue;
             if (descs && str_idx < descs->strs_len) {
               *response_data =3D descs->strs[str_idx].str;
               *response_length =3D descs->strs[str_idx].len;
               return true;
             }
             if (str_idx =3D=3D 0) {
               *response_data =3D (char*)&default_lang_id[0];
               *response_length =3D default_lang_id[0];
               return true;
             }
             *response_data =3D (char*)&default_string[0];
             *response_length =3D default_string[0];
             return true;
           case USB_DT_BOS:
             *response_data =3D descs->bos;
             *response_length =3D descs->bos_len;
             return true;
           case USB_DT_DEVICE_QUALIFIER:
             if (!descs->qual) {
               qual->bLength =3D sizeof(*qual);
               qual->bDescriptorType =3D USB_DT_DEVICE_QUALIFIER;
               qual->bcdUSB =3D index->dev->bcdUSB;
               qual->bDeviceClass =3D index->dev->bDeviceClass;
               qual->bDeviceSubClass =3D index->dev->bDeviceSubClass;
               qual->bDeviceProtocol =3D index->dev->bDeviceProtocol;
               qual->bMaxPacketSize0 =3D index->dev->bMaxPacketSize0;
               qual->bNumConfigurations =3D index->dev->bNumConfigurations;
               qual->bRESERVED =3D 0;
               *response_data =3D (char*)qual;
               *response_length =3D sizeof(*qual);
               return true;
             }
             *response_data =3D descs->qual;
             *response_length =3D descs->qual_len;
             return true;
           default:
             break;
         }
         break;
       default:
         break;
     }
     break;
   default:
     break;
 }
 return false;
}

typedef bool (*lookup_connect_out_response_t)(
   int fd,
   const struct vusb_connect_descriptors* descs,
   const struct usb_ctrlrequest* ctrl,
   bool* done);

static bool lookup_connect_response_out_generic(
   int fd,
   const struct vusb_connect_descriptors* descs,
   const struct usb_ctrlrequest* ctrl,
   bool* done) {
 switch (ctrl->bRequestType & USB_TYPE_MASK) {
   case USB_TYPE_STANDARD:
     switch (ctrl->bRequest) {
       case USB_REQ_SET_CONFIGURATION:
         *done =3D true;
         return true;
       default:
         break;
     }
     break;
 }
 return false;
}

#define UDC_NAME_LENGTH_MAX 128

struct usb_raw_init {
 __u8 driver_name[UDC_NAME_LENGTH_MAX];
 __u8 device_name[UDC_NAME_LENGTH_MAX];
 __u8 speed;
};

enum usb_raw_event_type {
 USB_RAW_EVENT_INVALID =3D 0,
 USB_RAW_EVENT_CONNECT =3D 1,
 USB_RAW_EVENT_CONTROL =3D 2,
};

struct usb_raw_event {
 __u32 type;
 __u32 length;
 __u8 data[0];
};

struct usb_raw_ep_io {
 __u16 ep;
 __u16 flags;
 __u32 length;
 __u8 data[0];
};

#define USB_RAW_EPS_NUM_MAX 30
#define USB_RAW_EP_NAME_MAX 16
#define USB_RAW_EP_ADDR_ANY 0xff

struct usb_raw_ep_caps {
 __u32 type_control : 1;
 __u32 type_iso : 1;
 __u32 type_bulk : 1;
 __u32 type_int : 1;
 __u32 dir_in : 1;
 __u32 dir_out : 1;
};

struct usb_raw_ep_limits {
 __u16 maxpacket_limit;
 __u16 max_streams;
 __u32 reserved;
};

struct usb_raw_ep_info {
 __u8 name[USB_RAW_EP_NAME_MAX];
 __u32 addr;
 struct usb_raw_ep_caps caps;
 struct usb_raw_ep_limits limits;
};

struct usb_raw_eps_info {
 struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor=
)
#define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)
#define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
#define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)
#define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)
#define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)
#define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)

static int usb_raw_open() {
 return open("/dev/raw-gadget", O_RDWR);
}

static int usb_raw_init(int fd,
                       uint32_t speed,
                       const char* driver,
                       const char* device) {
 struct usb_raw_init arg;
 strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));
 strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));
 arg.speed =3D speed;
 return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);
}

static int usb_raw_run(int fd) {
 return ioctl(fd, USB_RAW_IOCTL_RUN, 0);
}

static int usb_raw_configure(int fd) {
 return ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);
}

static int usb_raw_vbus_draw(int fd, uint32_t power) {
 return ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, power);
}

static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io) {
 return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);
}

static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io) {
 return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);
}

static int usb_raw_event_fetch(int fd, struct usb_raw_event* event) {
 return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);
}

static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc) =
{
 return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
}

static int usb_raw_ep_disable(int fd, int ep) {
 return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
}

static int usb_raw_ep0_stall(int fd) {
 return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
}

#define USB_MAX_PACKET_SIZE 4096

struct usb_raw_control_event {
 struct usb_raw_event inner;
 struct usb_ctrlrequest ctrl;
 char data[USB_MAX_PACKET_SIZE];
};

struct usb_raw_ep_io_data {
 struct usb_raw_ep_io inner;
 char data[USB_MAX_PACKET_SIZE];
};

static void set_interface(int fd, int n) {
 struct usb_device_index* index =3D lookup_usb_index(fd);
 if (!index)
   return;
 if (index->iface_cur >=3D 0 && index->iface_cur < index->ifaces_num) {
   for (int ep =3D 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) {
     int rv =3D usb_raw_ep_disable(
         fd, index->ifaces[index->iface_cur].eps[ep].handle);
     if (rv < 0) {
     } else {
     }
   }
 }
 if (n >=3D 0 && n < index->ifaces_num) {
   for (int ep =3D 0; ep < index->ifaces[n].eps_num; ep++) {
     int rv =3D usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
     if (rv < 0) {
     } else {
       index->ifaces[n].eps[ep].handle =3D rv;
     }
   }
   index->iface_cur =3D n;
 }
}

static int configure_device(int fd) {
 struct usb_device_index* index =3D lookup_usb_index(fd);
 if (!index)
   return -1;
 int rv =3D usb_raw_vbus_draw(fd, index->bMaxPower);
 if (rv < 0) {
   return rv;
 }
 rv =3D usb_raw_configure(fd);
 if (rv < 0) {
   return rv;
 }
 set_interface(fd, 0);
 return 0;
}

static volatile long syz_usb_connect_impl(
   uint64_t speed,
   uint64_t dev_len,
   const char* dev,
   const struct vusb_connect_descriptors* descs,
   lookup_connect_out_response_t lookup_connect_response_out) {
 if (!dev) {
   return -1;
 }
 int fd =3D usb_raw_open();
 if (fd < 0) {
   return fd;
 }
 if (fd >=3D MAX_FDS) {
   close(fd);
   return -1;
 }
 struct usb_device_index* index =3D add_usb_index(fd, dev, dev_len);
 if (!index) {
   return -1;
 }
 char device[32];
 sprintf(&device[0], "dummy_udc.%llu", procid);
 int rv =3D usb_raw_init(fd, speed, "dummy_udc", &device[0]);
 if (rv < 0) {
   return rv;
 }
 rv =3D usb_raw_run(fd);
 if (rv < 0) {
   return rv;
 }
 bool done =3D false;
 while (!done) {
   struct usb_raw_control_event event;
   event.inner.type =3D 0;
   event.inner.length =3D sizeof(event.ctrl);
   rv =3D usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
   if (rv < 0) {
     return rv;
   }
   if (event.inner.type !=3D USB_RAW_EVENT_CONTROL)
     continue;
   char* response_data =3D NULL;
   uint32_t response_length =3D 0;
   struct usb_qualifier_descriptor qual;
   if (event.ctrl.bRequestType & USB_DIR_IN) {
     if (!lookup_connect_response_in(fd, descs, &event.ctrl, &qual,
                                     &response_data, &response_length)) {
       usb_raw_ep0_stall(fd);
       continue;
     }
   } else {
     if (!lookup_connect_response_out(fd, descs, &event.ctrl, &done)) {
       usb_raw_ep0_stall(fd);
       continue;
     }
     response_data =3D NULL;
     response_length =3D event.ctrl.wLength;
   }
   if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD &=
&
       event.ctrl.bRequest =3D=3D USB_REQ_SET_CONFIGURATION) {
     rv =3D configure_device(fd);
     if (rv < 0) {
       return rv;
     }
   }
   struct usb_raw_ep_io_data response;
   response.inner.ep =3D 0;
   response.inner.flags =3D 0;
   if (response_length > sizeof(response.data))
     response_length =3D 0;
   if (event.ctrl.wLength < response_length)
     response_length =3D event.ctrl.wLength;
   response.inner.length =3D response_length;
   if (response_data)
     memcpy(&response.data[0], response_data, response_length);
   else
     memset(&response.data[0], 0, response_length);
   if (event.ctrl.bRequestType & USB_DIR_IN) {
     rv =3D usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
   } else {
     rv =3D usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
   }
   if (rv < 0) {
     return rv;
   }
 }
 sleep_ms(200);
 return fd;
}

static volatile long syz_usb_connect(volatile long a0,
                                    volatile long a1,
                                    volatile long a2,
                                    volatile long a3) {
 uint64_t speed =3D a0;
 uint64_t dev_len =3D a1;
 const char* dev =3D (const char*)a2;
 const struct vusb_connect_descriptors* descs =3D
     (const struct vusb_connect_descriptors*)a3;
 return syz_usb_connect_impl(speed, dev_len, dev, descs,
                             &lookup_connect_response_out_generic);
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

void execute_one(void) {
 *(uint8_t*)0x20000040 =3D 0x12;
 *(uint8_t*)0x20000041 =3D 1;
 *(uint16_t*)0x20000042 =3D 0;
 *(uint8_t*)0x20000044 =3D 0x42;
 *(uint8_t*)0x20000045 =3D 0x21;
 *(uint8_t*)0x20000046 =3D 0x7a;
 *(uint8_t*)0x20000047 =3D 0x40;
 *(uint16_t*)0x20000048 =3D 0x413;
 *(uint16_t*)0x2000004a =3D 0x6023;
 *(uint16_t*)0x2000004c =3D 0xc128;
 *(uint8_t*)0x2000004e =3D 0;
 *(uint8_t*)0x2000004f =3D 0;
 *(uint8_t*)0x20000050 =3D 0;
 *(uint8_t*)0x20000051 =3D 1;
 *(uint8_t*)0x20000052 =3D 9;
 *(uint8_t*)0x20000053 =3D 2;
 *(uint16_t*)0x20000054 =3D 0xdb;
 *(uint8_t*)0x20000056 =3D 1;
 *(uint8_t*)0x20000057 =3D 0;
 *(uint8_t*)0x20000058 =3D 0;
 *(uint8_t*)0x20000059 =3D 0;
 *(uint8_t*)0x2000005a =3D 0;
 *(uint8_t*)0x2000005b =3D 9;
 *(uint8_t*)0x2000005c =3D 4;
 *(uint8_t*)0x2000005d =3D 0x44;
 *(uint8_t*)0x2000005e =3D 0;
 *(uint8_t*)0x2000005f =3D 0xf;
 *(uint8_t*)0x20000060 =3D 0x2b;
 *(uint8_t*)0x20000061 =3D 0xb6;
 *(uint8_t*)0x20000062 =3D 0x34;
 *(uint8_t*)0x20000063 =3D 0;
 *(uint8_t*)0x20000064 =3D 9;
 *(uint8_t*)0x20000065 =3D 5;
 *(uint8_t*)0x20000066 =3D 0x40;
 *(uint8_t*)0x20000067 =3D 8;
 *(uint16_t*)0x20000068 =3D 0x10;
 *(uint8_t*)0x2000006a =3D 0x7f;
 *(uint8_t*)0x2000006b =3D 0x80;
 *(uint8_t*)0x2000006c =3D 0xdb;
 *(uint8_t*)0x2000006d =3D 2;
 *(uint8_t*)0x2000006e =3D 0x22;
 *(uint8_t*)0x2000006f =3D 7;
 *(uint8_t*)0x20000070 =3D 0x25;
 *(uint8_t*)0x20000071 =3D 1;
 *(uint8_t*)0x20000072 =3D 0x80;
 *(uint8_t*)0x20000073 =3D 7;
 *(uint16_t*)0x20000074 =3D 9;
 *(uint8_t*)0x20000076 =3D 9;
 *(uint8_t*)0x20000077 =3D 5;
 *(uint8_t*)0x20000078 =3D 0x82;
 *(uint8_t*)0x20000079 =3D 4;
 *(uint16_t*)0x2000007a =3D 0x200;
 *(uint8_t*)0x2000007c =3D 0x2c;
 *(uint8_t*)0x2000007d =3D 0x33;
 *(uint8_t*)0x2000007e =3D 9;
 *(uint8_t*)0x2000007f =3D 7;
 *(uint8_t*)0x20000080 =3D 0x25;
 *(uint8_t*)0x20000081 =3D 1;
 *(uint8_t*)0x20000082 =3D 3;
 *(uint8_t*)0x20000083 =3D 0x3f;
 *(uint16_t*)0x20000084 =3D 0xf49;
 *(uint8_t*)0x20000086 =3D 7;
 *(uint8_t*)0x20000087 =3D 0x25;
 *(uint8_t*)0x20000088 =3D 1;
 *(uint8_t*)0x20000089 =3D 2;
 *(uint8_t*)0x2000008a =3D 7;
 *(uint16_t*)0x2000008b =3D 0x400;
 *(uint8_t*)0x2000008d =3D 9;
 *(uint8_t*)0x2000008e =3D 5;
 *(uint8_t*)0x2000008f =3D 0xa;
 *(uint8_t*)0x20000090 =3D 4;
 *(uint16_t*)0x20000091 =3D 0x20;
 *(uint8_t*)0x20000093 =3D 4;
 *(uint8_t*)0x20000094 =3D 3;
 *(uint8_t*)0x20000095 =3D 0x80;
 *(uint8_t*)0x20000096 =3D 9;
 *(uint8_t*)0x20000097 =3D 5;
 *(uint8_t*)0x20000098 =3D 0xf;
 *(uint8_t*)0x20000099 =3D 0;
 *(uint16_t*)0x2000009a =3D 0x200;
 *(uint8_t*)0x2000009c =3D 0xbb;
 *(uint8_t*)0x2000009d =3D 0x17;
 *(uint8_t*)0x2000009e =3D 1;
 *(uint8_t*)0x2000009f =3D 9;
 *(uint8_t*)0x200000a0 =3D 5;
 *(uint8_t*)0x200000a1 =3D 0xb;
 *(uint8_t*)0x200000a2 =3D 0x10;
 *(uint16_t*)0x200000a3 =3D 8;
 *(uint8_t*)0x200000a5 =3D 5;
 *(uint8_t*)0x200000a6 =3D 0x3f;
 *(uint8_t*)0x200000a7 =3D 0;
 *(uint8_t*)0x200000a8 =3D 7;
 *(uint8_t*)0x200000a9 =3D 0x25;
 *(uint8_t*)0x200000aa =3D 1;
 *(uint8_t*)0x200000ab =3D 0x80;
 *(uint8_t*)0x200000ac =3D 0x81;
 *(uint16_t*)0x200000ad =3D 0xa62b;
 *(uint8_t*)0x200000af =3D 9;
 *(uint8_t*)0x200000b0 =3D 5;
 *(uint8_t*)0x200000b1 =3D 4;
 *(uint8_t*)0x200000b2 =3D 0;
 *(uint16_t*)0x200000b3 =3D 0x200;
 *(uint8_t*)0x200000b5 =3D 1;
 *(uint8_t*)0x200000b6 =3D 4;
 *(uint8_t*)0x200000b7 =3D 0x1f;
 *(uint8_t*)0x200000b8 =3D 9;
 *(uint8_t*)0x200000b9 =3D 5;
 *(uint8_t*)0x200000ba =3D 0xb;
 *(uint8_t*)0x200000bb =3D 4;
 *(uint16_t*)0x200000bc =3D 0x10;
 *(uint8_t*)0x200000be =3D 0x12;
 *(uint8_t*)0x200000bf =3D 0xea;
 *(uint8_t*)0x200000c0 =3D 0xc;
 *(uint8_t*)0x200000c1 =3D 2;
 *(uint8_t*)0x200000c2 =3D 0x21;
 *(uint8_t*)0x200000c3 =3D 2;
 *(uint8_t*)0x200000c4 =3D 0xb;
 *(uint8_t*)0x200000c5 =3D 9;
 *(uint8_t*)0x200000c6 =3D 5;
 *(uint8_t*)0x200000c7 =3D 0xc;
 *(uint8_t*)0x200000c8 =3D 0xc;
 *(uint16_t*)0x200000c9 =3D 0x40;
 *(uint8_t*)0x200000cb =3D 6;
 *(uint8_t*)0x200000cc =3D 0xa4;
 *(uint8_t*)0x200000cd =3D 8;
 *(uint8_t*)0x200000ce =3D 9;
 *(uint8_t*)0x200000cf =3D 5;
 *(uint8_t*)0x200000d0 =3D 0xb;
 *(uint8_t*)0x200000d1 =3D 0x10;
 *(uint16_t*)0x200000d2 =3D 0x10;
 *(uint8_t*)0x200000d4 =3D 4;
 *(uint8_t*)0x200000d5 =3D 0x20;
 *(uint8_t*)0x200000d6 =3D 7;
 *(uint8_t*)0x200000d7 =3D 7;
 *(uint8_t*)0x200000d8 =3D 0x25;
 *(uint8_t*)0x200000d9 =3D 1;
 *(uint8_t*)0x200000da =3D 3;
 *(uint8_t*)0x200000db =3D 3;
 *(uint16_t*)0x200000dc =3D 0xff34;
 *(uint8_t*)0x200000de =3D 9;
 *(uint8_t*)0x200000df =3D 5;
 *(uint8_t*)0x200000e0 =3D 2;
 *(uint8_t*)0x200000e1 =3D 0xc;
 *(uint16_t*)0x200000e2 =3D 0x10;
 *(uint8_t*)0x200000e4 =3D 2;
 *(uint8_t*)0x200000e5 =3D 1;
 *(uint8_t*)0x200000e6 =3D -1;
 *(uint8_t*)0x200000e7 =3D 7;
 *(uint8_t*)0x200000e8 =3D 0x25;
 *(uint8_t*)0x200000e9 =3D 1;
 *(uint8_t*)0x200000ea =3D 0x80;
 *(uint8_t*)0x200000eb =3D 4;
 *(uint16_t*)0x200000ec =3D 6;
 *(uint8_t*)0x200000ee =3D 7;
 *(uint8_t*)0x200000ef =3D 0x25;
 *(uint8_t*)0x200000f0 =3D 1;
 *(uint8_t*)0x200000f1 =3D 0x82;
 *(uint8_t*)0x200000f2 =3D 1;
 *(uint16_t*)0x200000f3 =3D 9;
 *(uint8_t*)0x200000f5 =3D 9;
 *(uint8_t*)0x200000f6 =3D 5;
 *(uint8_t*)0x200000f7 =3D 0xa;
 *(uint8_t*)0x200000f8 =3D 0;
 *(uint16_t*)0x200000f9 =3D 0x40;
 *(uint8_t*)0x200000fb =3D 0x80;
 *(uint8_t*)0x200000fc =3D 0x7f;
 *(uint8_t*)0x200000fd =3D 0xf9;
 *(uint8_t*)0x200000fe =3D 7;
 *(uint8_t*)0x200000ff =3D 0x25;
 *(uint8_t*)0x20000100 =3D 1;
 *(uint8_t*)0x20000101 =3D 0x80;
 *(uint8_t*)0x20000102 =3D 0x40;
 *(uint16_t*)0x20000103 =3D 0x800;
 *(uint8_t*)0x20000105 =3D 9;
 *(uint8_t*)0x20000106 =3D 5;
 *(uint8_t*)0x20000107 =3D 5;
 *(uint8_t*)0x20000108 =3D 0xc;
 *(uint16_t*)0x20000109 =3D 0x20;
 *(uint8_t*)0x2000010b =3D 6;
 *(uint8_t*)0x2000010c =3D 0;
 *(uint8_t*)0x2000010d =3D 5;
 *(uint8_t*)0x2000010e =3D 2;
 *(uint8_t*)0x2000010f =3D 5;
 *(uint8_t*)0x20000110 =3D 2;
 *(uint8_t*)0x20000111 =3D 7;
 *(uint8_t*)0x20000112 =3D 9;
 *(uint8_t*)0x20000113 =3D 5;
 *(uint8_t*)0x20000114 =3D 7;
 *(uint8_t*)0x20000115 =3D 3;
 *(uint16_t*)0x20000116 =3D 0x10;
 *(uint8_t*)0x20000118 =3D 0xfd;
 *(uint8_t*)0x20000119 =3D 4;
 *(uint8_t*)0x2000011a =3D 0x40;
 *(uint8_t*)0x2000011b =3D 9;
 *(uint8_t*)0x2000011c =3D 5;
 *(uint8_t*)0x2000011d =3D 7;
 *(uint8_t*)0x2000011e =3D 7;
 *(uint16_t*)0x2000011f =3D 8;
 *(uint8_t*)0x20000121 =3D 0;
 *(uint8_t*)0x20000122 =3D 9;
 *(uint8_t*)0x20000123 =3D 0x81;
 *(uint8_t*)0x20000124 =3D 9;
 *(uint8_t*)0x20000125 =3D 5;
 *(uint8_t*)0x20000126 =3D 0xe;
 *(uint8_t*)0x20000127 =3D 0x10;
 *(uint16_t*)0x20000128 =3D 0x400;
 *(uint8_t*)0x2000012a =3D 1;
 *(uint8_t*)0x2000012b =3D 8;
 *(uint8_t*)0x2000012c =3D 0x20;
 syz_usb_connect(/*speed=3D*/0, /*dev_len=3D*/0xed, /*dev=3D*/0x20000040,
                 /*conn_descs=3D*/0);
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


=3D* repro.txt =3D*
syz_usb_connect(0x0, 0x432, &(0x7f0000000040)=3D{{0x12, 0x1, 0x0, 0x42,
0x21, 0x7a, 0x40, 0x413, 0x6023, 0xc128, 0x0, 0x0, 0x0, 0x1,
[{{0x9,0x2, 0x420, 0x1, 0x0, 0x0, 0x0, 0x0, [{{0x9, 0x4, 0x44, 0x0,
0xf, 0x2b, 0xb6, 0x34, 0x0, [], [{{0x9, 0x5, 0x65268aa22f44d640, 0x8,
0x10, 0x7f, 0x80, 0xdb, [@generic=3D{0x57, 0x22,
"6842ca7bf31d0143618a52cac09b83bff3f60fa0736b77c6eccaf7eb500c0ec59af07a8ce8=
0cef3c2c0d57a13d8171c83cddcf772e53cdd9c1c10b732a821410d572c5528ac48f055a384=
4538aada94f2d8702fab1"},
@uac_iso=3D{0x7, 0x25, 0x1, 0x80, 0x7, 0x9}]}}, {{0x9, 0x5, 0x82, 0x4,
0x200, 0x2c, 0x33, 0x9, [@uac_iso=3D{0x7, 0x25, 0x1, 0x3, 0x3f, 0xf49},
@uac_iso=3D{0x7, 0x25, 0x1, 0x2, 0x7, 0x400}]}}, {{0x9, 0x5, 0xa, 0x4,
0x20, 0x4, 0x3, 0x80}}, {{0x9, 0x5, 0xf, 0x0, 0x200, 0xbb, 0x17,
0x1}}, {{0x9, 0x5, 0xb, 0x10, 0x8, 0x5, 0x3f, 0x0, [@uac_iso=3D{0x7,
0x25, 0x1, 0x80, 0x81, 0xa62b}]}}, {{0x9, 0x5, 0x4, 0x0, 0x200, 0x1,
0x4, 0x1f}}, {{0x9, 0x5, 0xb, 0x4, 0x10, 0x12, 0xea, 0xc,
[@generic=3D{0xed, 0x21,
"08127f0f4f83fec83e08741a32c7e58422f72562136cd7b9d82db0c264c2fc37abfca1db64=
6e6be411deadb2b650255eac8917df8f3f36c97efef0d23c90c281df73c0c07a5f3cdd23b12=
49a7465827a62acb89f43161251f496e961b2bada6e06551dafd2a52c93cc8685180dc1eca1=
24e289ba9f1deddbb6ad0cf34b8a36d61937c472ae928155ca9943bc2b6eb3c3a8169951a8e=
8c6e9bc1b4eaa236e90b9694fc42b1a0712581cfd2ad60c63017370e0cc354856748351a049=
eb031b63d4539aa4cea7e62b4ab706d01ed6947263c2453a87e4d288df723b76f2481ef425d=
c2799ff3816d5095a9835"},
@generic=3D{0xf9, 0xb,
"dce59870ed7c15d59e2f62353374609704da54e4b507d263b09deb7c3c01236058718d9192=
38a938221dc97681d20c639a5ebcd2dfe08c2c20672e3afd1121783144061974eb7d8185365=
15d97db0cc1983cfa4de27b9ac3f8363a7da644886592f39a00d799c8887bc3300bb508a62a=
fd0fc9a5f366b06fd04ede53b62cec94845eab41b138fffb86e04ed868592e463119faf7453=
c77b4b1f12c01d94c187279a5e3f673105824531de3cc89b127a03843e874f051ab35af668d=
61efc294cfe8c8726fc1d0ec4754fea52c35b61682af3d6c722edb819128cb95320e6e72a74=
073fcb14bfada62a389d25d0cce2fdaa4922b8d167f89"}]}},
{{0x9, 0x5, 0xc, 0xc, 0x40, 0x6, 0xa4, 0x8}}, {{0x9, 0x5, 0xb, 0x10,
0x10, 0x4, 0x20, 0x7, [@uac_iso=3D{0x7, 0x25, 0x1, 0x3, 0x3, 0xff34}]}},
{{0x9, 0x5, 0x2, 0xc, 0x10, 0x2, 0x1, 0xff, [@uac_iso=3D{0x7, 0x25, 0x1,
0x80, 0x4, 0x6}, @uac_iso=3D{0x7, 0x25, 0x1, 0x82, 0x1, 0x9}]}}, {{0x9,
0x5, 0xa, 0x0, 0x40, 0x80, 0x7f, 0xf9, [@uac_iso=3D{0x7, 0x25, 0x1,
0x80, 0x40, 0x800}]}}, {{0x9, 0x5, 0x5, 0xc, 0x20, 0x6, 0x0, 0x5,
[@generic=3D{0x7a, 0x5,
"e39ae978b524cf1a138e7d85bbb05621f8bb638e46c34283cbd6133b287a2d0fdca0a81b5b=
f5844913d5b648914f94cc9c7fafb04471e90e5aab900141c5ba31a10afefa666446c570700=
e0a324ab93f48eb9c2ea15970f19ecec27fa412f8c549bad2cd378512dbd4820973d7fd56ec=
1f0ef6003187ca18"},
@generic=3D{0x98, 0x7,
"1d595e30b5dd2d17a99443dba7bd307a99e0018050c69bbdaa0917291dd754ef39acd49ecb=
e36f9e8086f0d7ec384ba81f18056b4f4cb4c08189589e63a0e7366681d16d77837b9961f34=
c5e1e162c51d51f848edda2c9a81d696383e11cc7ee3bca076aeadf60b158cf17084872b168=
377c928b5dd80c2612de496483e06076cf4d456e8d26dca9b1dbc42d89ef8518e4f6457ae8d=
7"}]}},
{{0x9, 0x5, 0x7, 0x3, 0x10, 0xfd, 0x4, 0x40}}, {{0x9, 0x5, 0x7, 0x7,
0x8, 0x0, 0x9, 0x81}}, {{0x9, 0x5, 0xe, 0x10, 0x400, 0x1, 0x8,
0x20}}]}}]}}]}}, 0x0)

and the bug titled "KASAN: slab-use-after-free Read in
em28xx_release_resources=E2=80=9D also have a repro.prog

=3D* repro1.txt =3D*
executing program 0:
syz_usb_connect(0x0, 0xed, &(0x7f0000000040)=3D{{0x12, 0x1, 0x0, 0x42,
0x21, 0x7a, 0x40, 0x413, 0x6023, 0xc128, 0x0, 0x0, 0x0, 0x1, [{{0x9,
0x2, 0xdb, 0x1, 0x0, 0x0, 0x0, 0x0, [{{0x9, 0x4, 0x44, 0x0, 0xf, 0x2b,
0xb6, 0x34, 0x0, [], [{{0x9, 0x5, 0x65268aa22f44d640, 0x8, 0x10, 0x7f,
0x80, 0xdb, [@generic=3D{0x2, 0x22}, @uac_iso=3D{0x7, 0x25, 0x1, 0x80,
0x7, 0x9}]}}, {{0x9, 0x5, 0x82, 0x4, 0x200, 0x2c, 0x33, 0x9,
[@uac_iso=3D{0x7, 0x25, 0x1, 0x3, 0x3f, 0xf49}, @uac_iso=3D{0x7, 0x25,
0x1, 0x2, 0x7, 0x400}]}}, {{0x9, 0x5, 0xa, 0x4, 0x20, 0x4, 0x3,
0x80}}, {{0x9, 0x5, 0xf, 0x0, 0x200, 0xbb, 0x17, 0x1}}, {{0x9, 0x5,
0xb, 0x10, 0x8, 0x5, 0x3f, 0x0, [@uac_iso=3D{0x7, 0x25, 0x1, 0x80, 0x81,
0xa62b}]}}, {{0x9, 0x5, 0x4, 0x0, 0x200, 0x1, 0x4, 0x1f}}, {{0x9, 0x5,
0xb, 0x4, 0x10, 0x12, 0xea, 0xc, [@generic=3D{0x2, 0x21}, @generic=3D{0x2,
0xb}]}}, {{0x9, 0x5, 0xc, 0xc, 0x40, 0x6, 0xa4, 0x8}}, {{0x9, 0x5,
0xb, 0x10, 0x10, 0x4, 0x20, 0x7, [@uac_iso=3D{0x7, 0x25, 0x1, 0x3, 0x3,
0xff34}]}}, {{0x9, 0x5, 0x2, 0xc, 0x10, 0x2, 0x1, 0xff,
[@uac_iso=3D{0x7, 0x25, 0x1, 0x80, 0x4, 0x6}, @uac_iso=3D{0x7, 0x25, 0x1,
0x82, 0x1, 0x9}]}}, {{0x9, 0x5, 0xa, 0x0, 0x40, 0x80, 0x7f, 0xf9,
[@uac_iso=3D{0x7, 0x25, 0x1, 0x80, 0x40, 0x800}]}}, {{0x9, 0x5, 0x5,
0xc, 0x20, 0x6, 0x0, 0x5, [@generic=3D{0x2, 0x5}, @generic=3D{0x2,
0x7}]}}, {{0x9, 0x5, 0x7, 0x3, 0x10, 0xfd, 0x4, 0x40}}, {{0x9, 0x5,
0x7, 0x7, 0x8, 0x0, 0x9, 0x81}}, {{0x9, 0x5, 0xe, 0x10, 0x400, 0x1,
0x8, 0x20}}]}}]}}]}}, 0x0)

please run it with syz-execprog -repeat 0 ./repro.txt, it will trigger the =
bug.

See aslo https://gist.github.com/xrivendell7/65437409377f91fc28a04867956fa9=
e0.
I hope it helps.

Best regards.
xingwei Lee


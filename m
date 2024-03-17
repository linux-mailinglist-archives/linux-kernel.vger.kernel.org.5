Return-Path: <linux-kernel+bounces-105355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB8E87DC95
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75B21C209A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22E714A82;
	Sun, 17 Mar 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxG7Xvn9"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AB33DF;
	Sun, 17 Mar 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664277; cv=none; b=k9MBuQxFKJoy8cetmzkP5uBggdOJ+LRrlU7G0loFXC2GagfgIRh9R0E1dmorsqENQ4WoYj9pEImalBy3KGlD4Y2hJQXZGJs7+lvsE/qs9L7an9jxDRpFL6RV4e1oh3o0pFoIsFkCccP/Z/leLwImiR9oupB//pB5KL6G2krFTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664277; c=relaxed/simple;
	bh=8J4ZwR0nweU7Au93nYqQaUmbAbOmaZGOef/ek6uy09s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EN5HZz0cZiJ1ODWpIaXaq4g0D9922up5ayA7DVqk+h2c8guju/kzJf6Yi8gp43L4n1NxGfA+ib174cNR9zJiUPYWXnhKzXR6lO9OwAbL6qgkvMH7LVR+VNtK0xuNxzjXndT4kYtVtgwF+rH1hRx+FgJfZDFIp+hVRSegD0Qc5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxG7Xvn9; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4716cfbbcso1552766eaf.2;
        Sun, 17 Mar 2024 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710664274; x=1711269074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub0qXUSX6WD/xX0rMFX+T7L/U+3gkCsIMVktiAaLcXA=;
        b=WxG7Xvn922qyGI8pZDX4/VzsIbvlfCMvx5+MqdGQGQStH5YkjywR/J2rDJlmeADewL
         fKHe/uP8eP6WzQKXGzkr2cP3uo3H5fTbR7xe4tgX25m/dzwmd6BX6CVm1wVsBvBFRsU/
         h0ya6uP+78NyorcyHMaPIa8UJ8bGX6V3/4MqAnVHgfDeSN0lq0GaQpxdMKaRcDGda9We
         0t4miwn9vYO6rtwnrI7spnKn9VUQVYaa02PfV+71BLh4mQtoPMTipTV/IlEdCoIHgfqf
         z9nK+mQKz0UMp3/CJYZGJ3PTW5bRgqFl+pmagfdmEGOxWRcqYoEqWNeazixqVFaXsV/C
         Ycgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710664274; x=1711269074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ub0qXUSX6WD/xX0rMFX+T7L/U+3gkCsIMVktiAaLcXA=;
        b=JhUcVd3mrGW7s6jGOMhNDMfSZAswN7PUkEF+TQhxL9YiYhiAW54w5eGMBErW38+v+Y
         brpUSE/AQ79cpm3rArQYkQMwbh3JN9zE9BoDiT3WJoW652BDYpelJj9fU29MGPrLw59r
         LAKWWSYrFbeRgoBflxfa636nfTRaSYuvu3B2v0DIoKkklGe3TrpzJrBxxE49+Ty023d8
         zdkIA2c+t3silbjglkGHHno5Z80q1Bj3zOLqwmCI+yOBwkd4upHJkLne3xeU3JPIk+pE
         2FDxd5bP3KRFB8EsTIx16EPIvMZZ3I0vgq5cSHiqh/ILH3e5yTUCUUTFAH36yiiZOU2P
         LllQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1VBbG+so4OD8DLsYN1Uf9YxkXsOOG/3BkOggTwDPUzHUcCOSvCU0k8irwTxFrvCGso7TvM69b+e0hOvce/vpIXrhs3F88I70P
X-Gm-Message-State: AOJu0YzdHIwEzsgiKk0Egkeo6QL96OoYGfADY12vHHV9PH4AXrIF3PKd
	vK4eOwu5xk6aUmiJ7ZBuyuspa983zc99PQhmeglJfjqZTC0Gxu+Q/Zd1MdvFd1eNJG0U5GmgiEp
	pcGGBYigY6NnLsRTvMDfUqbk8Spk=
X-Google-Smtp-Source: AGHT+IHLMrzeSq8fxf4olYUHN/fM+6xcKu4l5e36UW6isK83pLWkSxMdG3g/ERRqzR/HiDsz0tlaU49SHkkRM/P+0l8=
X-Received: by 2002:a05:6358:9146:b0:17b:759:65c2 with SMTP id
 r6-20020a056358914600b0017b075965c2mr12558747rwr.10.1710664273689; Sun, 17
 Mar 2024 01:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Sun, 17 Mar 2024 16:31:01 +0800
Message-ID: <CABOYnLw8=VM4LxgBsrwTi3HzdvGV7cYJU=4t7MMYTnrDCaDKAQ@mail.gmail.com>
Subject: divide error in alauda_transport
To: gregkh@linuxfoundation.org, usb-storage@lists.one-eyed-alien.net, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello I found a bug in latest upstream titled "divide error in
alauda_transport", and maybe is realted with usb.
I comfired in the latest upstream the poc tree can trigger the issue.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel: upstream 9187210eee7d87eea37b45ea93454a88681894a4
config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D1c6662240=
382da2
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 PID: 8229 Comm: usb-storage Not tainted 6.8.0-05202-g9187210eee7d #2=
0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:954 [inline]
RIP: 0010:alauda_transport+0xcaf/0x3830 drivers/usb/storage/alauda.c:1184
Code: 24 18 01 00 00 00 00 00 00 48 c1 e8 03 85 f6 48 89 44 24 30 0f
84 af 01 00 00 4c 89 54 24 70 4d 89 dc 31 d2 44 89 f0 4c 89 e7 <f7> 74
24 48 89 c5 41 89 d5 89 ee e8 e1 c1 ff ff 66 44 30
RSP: 0018:ffffc90010ccfa60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024f12cb8
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed10049e25ad
R10: ffff888024f13088 R11: ffff888024f12cb8 R12: ffff888024f12cb8
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055679a87dd88 CR3: 000000000c774000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 usb_stor_invoke_transport+0xea/0x13d0 drivers/usb/storage/transport.c:611
 usb_stor_control_thread+0x5d6/0x980 drivers/usb/storage/usb.c:368
 kthread+0x2eb/0x3d0 kernel/kthread.c:388
 ret_from_fork+0x2f/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:alauda_read_data drivers/usb/storage/alauda.c:954 [inline]
RIP: 0010:alauda_transport+0xcaf/0x3830 drivers/usb/storage/alauda.c:1184
Code: 24 18 01 00 00 00 00 00 00 48 c1 e8 03 85 f6 48 89 44 24 30 0f
84 af 01 00 00 4c 89 54 24 70 4d 89 dc 31 d2 44 89 f0 4c 89 e7 <f7> 74
24 48 89 c5 41 89 d5 89 ee e8 e1 c1 ff ff 66 44 30
RSP: 0018:ffffc90010ccfa60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888024f12cb8
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed10049e25ad
R10: ffff888024f13088 R11: ffff888024f12cb8 R12: ffff888024f12cb8
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055679a875010 CR3: 0000000023588000 CR4: 0000000000750ef0
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 24 18                 and    $0x18,%al
   2: 01 00                 add    %eax,(%rax)
   4: 00 00                 add    %al,(%rax)
   6: 00 00                 add    %al,(%rax)
   8: 00 48 c1             add    %cl,-0x3f(%rax)
   b: e8 03 85 f6 48       call   0x48f68513
  10: 89 44 24 30           mov    %eax,0x30(%rsp)
  14: 0f 84 af 01 00 00     je     0x1c9
  1a: 4c 89 54 24 70       mov    %r10,0x70(%rsp)
  1f: 4d 89 dc             mov    %r11,%r12
  22: 31 d2                 xor    %edx,%edx
  24: 44 89 f0             mov    %r14d,%eax
  27: 4c 89 e7             mov    %r12,%rdi
* 2a: f7 74 24 48           divl   0x48(%rsp) <-- trapping instruction
  2e: 89 c5                 mov    %eax,%ebp
  30: 41 89 d5             mov    %edx,%r13d
  33: 89 ee                 mov    %ebp,%esi
  35: e8 e1 c1 ff ff       call   0xffffc21b
  3a: 66                   data16
  3b: 44                   rex.R
  3c: 30                   .byte 0x30


=3D* repro.c =3D*
#define _GNU_SOURCE

#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#include <linux/usb/ch9.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms) {
  usleep(ms * 1000);
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
  index->config =3D (struct usb_config_descriptor*)(buffer + sizeof(*index-=
>dev));
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
      index->ifaces[index->ifaces_num].bInterfaceClass =3D iface->bInterfac=
eClass;
      index->ifaces_num++;
    }
    if (desc_type =3D=3D USB_DT_ENDPOINT && index->ifaces_num > 0) {
      struct usb_iface_index* iface =3D &index->ifaces[index->ifaces_num - =
1];
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
                qual->bNumConfigurations =3D index->dev->bNumConfigurations=
;
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

struct vusb_descriptor {
  uint8_t req_type;
  uint8_t desc_type;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_descriptors {
  uint32_t len;
  struct vusb_descriptor* generic;
  struct vusb_descriptor* descs[0];
} __attribute__((packed));

struct vusb_response {
  uint8_t type;
  uint8_t req;
  uint32_t len;
  char data[0];
} __attribute__((packed));

struct vusb_responses {
  uint32_t len;
  struct vusb_response* generic;
  struct vusb_response* resps[0];
} __attribute__((packed));

static bool lookup_control_response(const struct vusb_descriptors* descs,
                                    const struct vusb_responses* resps,
                                    struct usb_ctrlrequest* ctrl,
                                    char** response_data,
                                    uint32_t* response_length) {
  int descs_num =3D 0;
  int resps_num =3D 0;
  if (descs)
    descs_num =3D (descs->len - offsetof(struct vusb_descriptors, descs)) /
                sizeof(descs->descs[0]);
  if (resps)
    resps_num =3D (resps->len - offsetof(struct vusb_responses, resps)) /
                sizeof(resps->resps[0]);
  uint8_t req =3D ctrl->bRequest;
  uint8_t req_type =3D ctrl->bRequestType & USB_TYPE_MASK;
  uint8_t desc_type =3D ctrl->wValue >> 8;
  if (req =3D=3D USB_REQ_GET_DESCRIPTOR) {
    int i;
    for (i =3D 0; i < descs_num; i++) {
      struct vusb_descriptor* desc =3D descs->descs[i];
      if (!desc)
        continue;
      if (desc->req_type =3D=3D req_type && desc->desc_type =3D=3D desc_typ=
e) {
        *response_length =3D desc->len;
        if (*response_length !=3D 0)
          *response_data =3D &desc->data[0];
        else
          *response_data =3D NULL;
        return true;
      }
    }
    if (descs && descs->generic) {
      *response_data =3D &descs->generic->data[0];
      *response_length =3D descs->generic->len;
      return true;
    }
  } else {
    int i;
    for (i =3D 0; i < resps_num; i++) {
      struct vusb_response* resp =3D resps->resps[i];
      if (!resp)
        continue;
      if (resp->type =3D=3D req_type && resp->req =3D=3D req) {
        *response_length =3D resp->len;
        if (*response_length !=3D 0)
          *response_data =3D &resp->data[0];
        else
          *response_data =3D NULL;
        return true;
      }
    }
    if (resps && resps->generic) {
      *response_data =3D &resps->generic->data[0];
      *response_length =3D resps->generic->len;
      return true;
    }
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

static int lookup_interface(int fd,
                            uint8_t bInterfaceNumber,
                            uint8_t bAlternateSetting) {
  struct usb_device_index* index =3D lookup_usb_index(fd);
  if (!index)
    return -1;
  for (int i =3D 0; i < index->ifaces_num; i++) {
    if (index->ifaces[i].bInterfaceNumber =3D=3D bInterfaceNumber &&
        index->ifaces[i].bAlternateSetting =3D=3D bAlternateSetting)
      return i;
  }
  return -1;
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
    for (int ep =3D 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) =
{
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
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD =
&&
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

static volatile long syz_usb_control_io(volatile long a0,
                                        volatile long a1,
                                        volatile long a2) {
  int fd =3D a0;
  const struct vusb_descriptors* descs =3D (const struct vusb_descriptors*)=
a1;
  const struct vusb_responses* resps =3D (const struct vusb_responses*)a2;
  struct usb_raw_control_event event;
  event.inner.type =3D 0;
  event.inner.length =3D USB_MAX_PACKET_SIZE;
  int rv =3D usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
  if (rv < 0) {
    return rv;
  }
  if (event.inner.type !=3D USB_RAW_EVENT_CONTROL) {
    return -1;
  }
  char* response_data =3D NULL;
  uint32_t response_length =3D 0;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    if (!lookup_control_response(descs, resps, &event.ctrl, &response_data,
                                 &response_length)) {
      usb_raw_ep0_stall(fd);
      return -1;
    }
  } else {
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD =
||
        event.ctrl.bRequest =3D=3D USB_REQ_SET_INTERFACE) {
      int iface_num =3D event.ctrl.wIndex;
      int alt_set =3D event.ctrl.wValue;
      int iface_index =3D lookup_interface(fd, iface_num, alt_set);
      if (iface_index < 0) {
      } else {
        set_interface(fd, iface_index);
      }
    }
    response_length =3D event.ctrl.wLength;
  }
  struct usb_raw_ep_io_data response;
  response.inner.ep =3D 0;
  response.inner.flags =3D 0;
  if (response_length > sizeof(response.data))
    response_length =3D 0;
  if (event.ctrl.wLength < response_length)
    response_length =3D event.ctrl.wLength;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && !event.ctrl.wLength) {
    response_length =3D USB_MAX_PACKET_SIZE;
  }
  response.inner.length =3D response_length;
  if (response_data)
    memcpy(&response.data[0], response_data, response_length);
  else
    memset(&response.data[0], 0, response_length);
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    rv =3D usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
  } else {
    rv =3D usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
  }
  if (rv < 0) {
    return rv;
  }
  sleep_ms(200);
  return 0;
}

uint64_t r[1] =3D {0xffffffffffffffff};

int main(void) {
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  intptr_t res =3D 0;
  memcpy((void*)0x20000000,
         "\x12\x01\x00\x00\xbc\x61\xb4\x08\xb4\x07\x0a\x01\x02\x01\x00\x00\=
x00"
         "\x01\x09\x02\x24\x00\x01\x00\x00\x00\x5b\x09\x04\x00\x00\x02\x19\=
xa4"
         "\xb4\x00\x09\x05\x0e\x02\x00\x1b\xc4\x00\x00\x09\x05\x82\x02",
         49);
  res =3D -1;
  res =3D syz_usb_connect(/*speed=3D*/0, /*dev_len=3D*/0x36, /*dev=3D*/0x20=
000000,
                        /*conn_descs=3D*/0);
  if (res !=3D -1)
    r[0] =3D res;
  *(uint32_t*)0x20000840 =3D 0x84;
  *(uint64_t*)0x20000844 =3D 0x20000440;
  *(uint8_t*)0x20000440 =3D 0x20;
  *(uint8_t*)0x20000441 =3D 7;
  *(uint32_t*)0x20000442 =3D 0xba;
  memcpy((void*)0x20000446,
         "\x26\x15\x91\x55\x33\xe9\x67\xd6\x3c\x01\xba\x52\xb0\x88\xd8\x2d\=
x33"
         "\x31\x9a\x3e\xe5\x79\x49\x03\xde\xd3\xff\x0b\xae\xa8\xb5\xdc\x7b\=
xbf"
         "\x28\x50\x84\x2d\x6c\xcd\xcd\x31\xf7\xfb\xbd\x78\xf4\xac\x80\x16\=
xc7"
         "\xfc\xb6\xb4\xca\x77\x5e\x60\x83\xd1\x1b\x74\x14\x44\x19\xdd\x07\=
xf6"
         "\x9a\x2e\x65\xa5\x57\x1a\xd0\x33\x15\x63\x7a\x0a\x29\x31\x75\x3c\=
x25"
         "\x7f\x8c\x22\x0f\xdb\x24\xdd\x1c\xb8\x66\xaa\xfc\xac\x61\xe7\x84\=
x10"
         "\x33\x27\x12\xaa\x5c\x6a\x21\xbe\xdd\x0b\x2f\x06\x29\xdc\x6c\xe2\=
x8c"
         "\x9a\x1b\xfd\xdf\x71\x15\x31\x5d\x4c\x5a\x1c\x29\x73\x01\x69\x9e\=
x67"
         "\xc3\x27\xa7\x55\xd5\x4a\xe7\xdd\x85\xcc\x1b\xfb\xdf\xba\xa7\x1f\=
xad"
         "\x59\xdb\xde\x04\xc2\xe6\x6a\x52\x9b\x9b\x2d\x47\x59\xf8\x44\xd5\=
xdd"
         "\x37\x52\x31\x4f\x35\xe2\x65\x5b\x78\x6a\x1d\xcd\x9c\xa0\x38\xe8"=
,
         186);
  *(uint64_t*)0x2000084c =3D 0;
  *(uint64_t*)0x20000854 =3D 0;
  *(uint64_t*)0x2000085c =3D 0;
  *(uint64_t*)0x20000864 =3D 0;
  *(uint64_t*)0x2000086c =3D 0;
  *(uint64_t*)0x20000874 =3D 0;
  *(uint64_t*)0x2000087c =3D 0;
  *(uint64_t*)0x20000884 =3D 0;
  *(uint64_t*)0x2000088c =3D 0;
  *(uint64_t*)0x20000894 =3D 0;
  *(uint64_t*)0x2000089c =3D 0;
  *(uint64_t*)0x200008a4 =3D 0;
  *(uint64_t*)0x200008ac =3D 0;
  *(uint64_t*)0x200008b4 =3D 0;
  *(uint64_t*)0x200008bc =3D 0;
  syz_usb_control_io(/*fd=3D*/r[0], /*descs=3D*/0, /*resps=3D*/0x20000840);
  {
    int i;
    for (i =3D 0; i < 64; i++) {
      syz_usb_control_io(/*fd=3D*/r[0], /*descs=3D*/0, /*resps=3D*/0x200008=
40);
    }
  }
  return 0;
}


=3D* repro.txt =3D*
r0 =3D syz_usb_connect(0x0, 0x36,
&(0x7f0000000000)=3DANY=3D[@ANYBLOB=3D"12010000bc61b408b4070a01020100000001=
09022400010000005b090400000219a4b40009050e02001bc4000009058202"],
0x0)
syz_usb_control_io(r0, 0x0, &(0x7f0000000840)=3D{0x84,
&(0x7f0000000440)=3D{0x20, 0x7, 0xba,
"2615915533e967d63c01ba52b088d82d33319a3ee5794903ded3ff0baea8b5dc7bbf285084=
2d6ccdcd31f7fbbd78f4ac8016c7fcb6b4ca775e6083d11b74144419dd07f69a2e65a5571ad=
03315637a0a2931753c257f8c220fdb24dd1cb866aafcac61e78410332712aa5c6a21bedd0b=
2f0629dc6ce28c9a1bfddf7115315d4c5a1c297301699e67c327a755d54ae7dd85cc1bfbdfb=
aa71fad59dbde04c2e66a529b9b2d4759f844d5dd3752314f35e2655b786a1dcd9ca038e8"}=
,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0}) (rerun: 64)

See aslo https://gist.github.com/xrivendell7/e2dd691a52c379bbbc3db81fb3f8e0=
fc.

I hope it helps.
Best regards.
xingwei Lee


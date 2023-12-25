Return-Path: <linux-kernel+bounces-10934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20A281DEE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A671C21725
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020851877;
	Mon, 25 Dec 2023 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6PtIFij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784F15A8;
	Mon, 25 Dec 2023 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso666953b3a.0;
        Sun, 24 Dec 2023 23:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703490951; x=1704095751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bW/etHQfo2ZQ4CDdKi/ww+ThXpWmUVMmI9RA+nlZLe8=;
        b=D6PtIFijHI2fuKD5G8X6fzq6AiegyFsN44gVbmqS1QMxacwRXem8v/V5g/yal+mMw4
         w6owrvzBNPmZ3BJzgscTxtgyC0xXcsqtcu+6ICV8qAibKu+A0mVNbMZt9m2S6uJBbb3A
         vVPsGdRnGYlu0VLogZGxVcDfnCHcJaXM5wyYrFDphlXC460iy9zVyjh3FMvjcFnswP1D
         Xwi3BgxufGTq5kP6H5XoJVGDuxFaz577ZtRn20cxpj2RVtstejwoYakldCLlq1iHUpzf
         XVVPn9maxe2UHHtdThDGBLwf0USgSVHfsj16yjCg8AnSh/g+xhl0zRUluofFfF7HASOg
         GHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703490951; x=1704095751;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bW/etHQfo2ZQ4CDdKi/ww+ThXpWmUVMmI9RA+nlZLe8=;
        b=aMSe/dRvZ4ALOCj0OYFMx8MYCjXHb3Vvx7EUdKmzqwcl/rrXUPN4x1XfmBlpCZ3WA9
         /6W0/cUk9/V00D8fFgio+hoPeeVYPFwCK9l6P84vCgj7FxGV6ilZKiiCR7x01MDcV+p/
         KDW97n1XxkWhRkPDBTAVyKIQteYk4z1zxUl5NqwPGH1cf6GzsZKDEgs86qMYsdbd4FwN
         5UAnBoW/PFHNCSxADRu+eG4uq4Vwxcg5YW2fZQxYc58t4HQ9vJcC3T+WDGVnYTc5MMHy
         1yAfLsBJww0N8+rqb/GVYMyo9IMOyaju4vxBpWjW/L0A1FfP1McnXJZBdkxWWevE1LTy
         /liA==
X-Gm-Message-State: AOJu0YzZV9/VQEZpxNOZLAPGVTYx5Ss9PssIS+TY5YN8wtnV09OVoOj+
	hEfqbCdAqMbOFzcERf5Gzuo9vfo0X7Ugb+w/N5o=
X-Google-Smtp-Source: AGHT+IGGa7z5hWujX7+4iXhKvR8VFOmLA33h2LyWiwq1MdXZjq+xd2l3Wz1rbDybk3NFfcvT4IY64XNyX8mRIFLDrkA=
X-Received: by 2002:a05:6a00:9388:b0:6d9:8576:7771 with SMTP id
 ka8-20020a056a00938800b006d985767771mr5837558pfb.2.1703490951390; Sun, 24 Dec
 2023 23:55:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 25 Dec 2023 15:55:40 +0800
Message-ID: <CABOYnLwg4Y1N2VwZ1-m9MRyMUEKhcyQAkZRkKcaBNYcNM7Rdkw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in input_unregister_device
To: syzbot+96f19ddb26662d2cd6f5@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired it still existed in the
latest net tree.
Since I found there are no stable reproducer so far, I can confrim the
repro.c and repro.txt can trigger the bug steadily.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel version: net 7c5e046bdcb2513f9decb3765d8bf92d604279cf
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=298e57794135adf0
compiler: gcc-12

syzkaller login: root
Linux syzkaller 6.7.0-rc6-00157-g7c5e046bdcb2 #9 SMP PREEMPT_DYNAMIC
Sat Dec 23 16:03:42 CST 2023 x86_64
TITLE: WARNING in __input_unregister_device
------------[ cut here ]------------
add_uevent_var: buffer size too small
WARNING: CPU: 0 PID: 4483 at lib/kobject_uevent.c:671
add_uevent_var+0x200/0x210 lib/kobject_uevent.c:671
Modules linked in:
CPU: 0 PID: 4483 Comm: kworker/0:3 Tainted: G        W
6.7.0-rc6-00157-g7c5e046bdcb2 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: usb_hub_wq hub_event
RIP: 0010:add_uevent_var+0x200/0x210 lib/kobject_uevent.c:671
Code: d6 b7 9a fb 48 c7 c7 40 60 d6 86 e8 1a 8a 7e fb 0f 0b bb f4 ff
ff ff eb af e8 bc b7 9a fb 48 c8
RSP: 0018:ffff88800df5f3b0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffff888028394000 RCX: ffffffff811f42a6
RDX: ffff88800e72b700 RSI: ffffffff811f42b0 RDI: 0000000000000001
RBP: ffff88800df5f480 R08: 0000000000000001 R09: ffffed10175850d9
R10: 0000000000000000 R11: 000000005f646461 R12: 1ffff11001bebe79
R13: 0000000000000022 R14: ffff888028394a1c R15: 00000000000007de
FS:  0000000000000000(0000) GS:ffff8880bac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561cd67ae020 CR3: 000000000c8c5000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 kobject_uevent_env+0x803/0xc20 lib/kobject_uevent.c:605
 kobject_uevent+0x23/0x30 lib/kobject_uevent.c:642
 device_del+0x4a1/0x670 drivers/base/core.c:3832
 __input_unregister_device+0x21c/0x280 drivers/input/input.c:2232
 input_unregister_device+0x99/0xd0 drivers/input/input.c:2440
 hidinput_disconnect+0xc8/0x1f0 drivers/hid/hid-input.c:2388
 hid_disconnect+0xdf/0x110 drivers/hid/hid-core.c:2280
 hid_hw_stop+0x1b/0x50 drivers/hid/hid-core.c:2329
 ms_remove+0x1b/0x70 drivers/hid/hid-microsoft.c:409
 hid_device_remove+0x96/0x150 drivers/hid/hid-core.c:2689
 device_remove+0x7d/0xd0 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x319/0x3c0 drivers/base/dd.c:1295
 device_release_driver+0x1d/0x30 drivers/base/dd.c:1318
 bus_remove_device+0x163/0x1c0 drivers/base/bus.c:574
 device_del+0x2b7/0x670 drivers/base/core.c:3814
 hid_remove_device drivers/hid/hid-core.c:2867 [inline]
 hid_destroy_device+0x99/0xc0 drivers/hid/hid-core.c:2887
 usbhid_disconnect+0x7f/0xb0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x12c/0x500 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0xb9/0xd0 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x319/0x3c0 drivers/base/dd.c:1295
 device_release_driver+0x1d/0x30 drivers/base/dd.c:1318
 bus_remove_device+0x163/0x1c0 drivers/base/bus.c:574
 device_del+0x2b7/0x670 drivers/base/core.c:3814
 usb_disable_device+0x1f5/0x350 drivers/usb/core/message.c:1416
 usb_disconnect+0x1df/0x530 drivers/usb/core/hub.c:2237
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x161a/0x30d0 drivers/usb/core/hub.c:5822
 process_one_work+0x391/0x5f0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x4c2/0x7f0 kernel/workqueue.c:2781
 kthread+0x1d6/0x230 kernel/kthread.c:388
 ret_from_fork+0x4e/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>



=* repro.c =*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/usb/ch9.h>
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
  buf[sizeof(buf) - 1] = 0;
  int len = strlen(buf);
  int fd = open(file, O_WRONLY | O_CLOEXEC);
  if (fd == -1) return false;
  if (write(fd, buf, len) != len) {
    int err = errno;
    close(fd);
    errno = err;
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
  for (int i = 0; i < USB_MAX_FDS; i++) {
    if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) == fd)
      return &usb_devices[i].index;
  }
  return NULL;
}

static int usb_devices_num;

static bool parse_usb_descriptor(const char* buffer, size_t length,
                                 struct usb_device_index* index) {
  if (length < sizeof(*index->dev) + sizeof(*index->config)) return false;
  memset(index, 0, sizeof(*index));
  index->dev = (struct usb_device_descriptor*)buffer;
  index->config = (struct usb_config_descriptor*)(buffer + sizeof(*index->dev));
  index->bDeviceClass = index->dev->bDeviceClass;
  index->bMaxPower = index->config->bMaxPower;
  index->config_length = length - sizeof(*index->dev);
  index->iface_cur = -1;
  size_t offset = 0;
  while (true) {
    if (offset + 1 >= length) break;
    uint8_t desc_length = buffer[offset];
    uint8_t desc_type = buffer[offset + 1];
    if (desc_length <= 2) break;
    if (offset + desc_length > length) break;
    if (desc_type == USB_DT_INTERFACE &&
        index->ifaces_num < USB_MAX_IFACE_NUM) {
      struct usb_interface_descriptor* iface =
          (struct usb_interface_descriptor*)(buffer + offset);
      index->ifaces[index->ifaces_num].iface = iface;
      index->ifaces[index->ifaces_num].bInterfaceNumber =
          iface->bInterfaceNumber;
      index->ifaces[index->ifaces_num].bAlternateSetting =
          iface->bAlternateSetting;
      index->ifaces[index->ifaces_num].bInterfaceClass = iface->bInterfaceClass;
      index->ifaces_num++;
    }
    if (desc_type == USB_DT_ENDPOINT && index->ifaces_num > 0) {
      struct usb_iface_index* iface = &index->ifaces[index->ifaces_num - 1];
      if (iface->eps_num < USB_MAX_EP_NUM) {
        memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,
               sizeof(iface->eps[iface->eps_num].desc));
        iface->eps_num++;
      }
    }
    offset += desc_length;
  }
  return true;
}

static struct usb_device_index* add_usb_index(int fd, const char* dev,
                                              size_t dev_len) {
  int i = __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);
  if (i >= USB_MAX_FDS) return NULL;
  if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index)) return NULL;
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

static const char default_string[] = {8, USB_DT_STRING, 's', 0, 'y', 0, 'z', 0};

static const char default_lang_id[] = {4, USB_DT_STRING, 0x09, 0x04};

static bool lookup_connect_response_in(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, struct usb_qualifier_descriptor* qual,
    char** response_data, uint32_t* response_length) {
  struct usb_device_index* index = lookup_usb_index(fd);
  uint8_t str_idx;
  if (!index) return false;
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
    case USB_TYPE_STANDARD:
      switch (ctrl->bRequest) {
        case USB_REQ_GET_DESCRIPTOR:
          switch (ctrl->wValue >> 8) {
            case USB_DT_DEVICE:
              *response_data = (char*)index->dev;
              *response_length = sizeof(*index->dev);
              return true;
            case USB_DT_CONFIG:
              *response_data = (char*)index->config;
              *response_length = index->config_length;
              return true;
            case USB_DT_STRING:
              str_idx = (uint8_t)ctrl->wValue;
              if (descs && str_idx < descs->strs_len) {
                *response_data = descs->strs[str_idx].str;
                *response_length = descs->strs[str_idx].len;
                return true;
              }
              if (str_idx == 0) {
                *response_data = (char*)&default_lang_id[0];
                *response_length = default_lang_id[0];
                return true;
              }
              *response_data = (char*)&default_string[0];
              *response_length = default_string[0];
              return true;
            case USB_DT_BOS:
              *response_data = descs->bos;
              *response_length = descs->bos_len;
              return true;
            case USB_DT_DEVICE_QUALIFIER:
              if (!descs->qual) {
                qual->bLength = sizeof(*qual);
                qual->bDescriptorType = USB_DT_DEVICE_QUALIFIER;
                qual->bcdUSB = index->dev->bcdUSB;
                qual->bDeviceClass = index->dev->bDeviceClass;
                qual->bDeviceSubClass = index->dev->bDeviceSubClass;
                qual->bDeviceProtocol = index->dev->bDeviceProtocol;
                qual->bMaxPacketSize0 = index->dev->bMaxPacketSize0;
                qual->bNumConfigurations = index->dev->bNumConfigurations;
                qual->bRESERVED = 0;
                *response_data = (char*)qual;
                *response_length = sizeof(*qual);
                return true;
              }
              *response_data = descs->qual;
              *response_length = descs->qual_len;
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
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done);

static bool lookup_connect_response_out_generic(
    int fd, const struct vusb_connect_descriptors* descs,
    const struct usb_ctrlrequest* ctrl, bool* done) {
  switch (ctrl->bRequestType & USB_TYPE_MASK) {
    case USB_TYPE_STANDARD:
      switch (ctrl->bRequest) {
        case USB_REQ_SET_CONFIGURATION:
          *done = true;
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
  int descs_num = 0;
  int resps_num = 0;
  if (descs)
    descs_num = (descs->len - offsetof(struct vusb_descriptors, descs)) /
                sizeof(descs->descs[0]);
  if (resps)
    resps_num = (resps->len - offsetof(struct vusb_responses, resps)) /
                sizeof(resps->resps[0]);
  uint8_t req = ctrl->bRequest;
  uint8_t req_type = ctrl->bRequestType & USB_TYPE_MASK;
  uint8_t desc_type = ctrl->wValue >> 8;
  if (req == USB_REQ_GET_DESCRIPTOR) {
    int i;
    for (i = 0; i < descs_num; i++) {
      struct vusb_descriptor* desc = descs->descs[i];
      if (!desc) continue;
      if (desc->req_type == req_type && desc->desc_type == desc_type) {
        *response_length = desc->len;
        if (*response_length != 0)
          *response_data = &desc->data[0];
        else
          *response_data = NULL;
        return true;
      }
    }
    if (descs && descs->generic) {
      *response_data = &descs->generic->data[0];
      *response_length = descs->generic->len;
      return true;
    }
  } else {
    int i;
    for (i = 0; i < resps_num; i++) {
      struct vusb_response* resp = resps->resps[i];
      if (!resp) continue;
      if (resp->type == req_type && resp->req == req) {
        *response_length = resp->len;
        if (*response_length != 0)
          *response_data = &resp->data[0];
        else
          *response_data = NULL;
        return true;
      }
    }
    if (resps && resps->generic) {
      *response_data = &resps->generic->data[0];
      *response_length = resps->generic->len;
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
  USB_RAW_EVENT_INVALID = 0,
  USB_RAW_EVENT_CONNECT = 1,
  USB_RAW_EVENT_CONTROL = 2,
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
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor)
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

static int usb_raw_open() { return open("/dev/raw-gadget", O_RDWR); }

static int usb_raw_init(int fd, uint32_t speed, const char* driver,
                        const char* device) {
  struct usb_raw_init arg;
  strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));
  strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));
  arg.speed = speed;
  return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);
}

static int usb_raw_run(int fd) { return ioctl(fd, USB_RAW_IOCTL_RUN, 0); }

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

static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc) {
  return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
}

static int usb_raw_ep_disable(int fd, int ep) {
  return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
}

static int usb_raw_ep0_stall(int fd) {
  return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
}

static int lookup_interface(int fd, uint8_t bInterfaceNumber,
                            uint8_t bAlternateSetting) {
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return -1;
  for (int i = 0; i < index->ifaces_num; i++) {
    if (index->ifaces[i].bInterfaceNumber == bInterfaceNumber &&
        index->ifaces[i].bAlternateSetting == bAlternateSetting)
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
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return;
  if (index->iface_cur >= 0 && index->iface_cur < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) {
      int rv = usb_raw_ep_disable(
          fd, index->ifaces[index->iface_cur].eps[ep].handle);
      if (rv < 0) {
      } else {
      }
    }
  }
  if (n >= 0 && n < index->ifaces_num) {
    for (int ep = 0; ep < index->ifaces[n].eps_num; ep++) {
      int rv = usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
      if (rv < 0) {
      } else {
        index->ifaces[n].eps[ep].handle = rv;
      }
    }
    index->iface_cur = n;
  }
}

static int configure_device(int fd) {
  struct usb_device_index* index = lookup_usb_index(fd);
  if (!index) return -1;
  int rv = usb_raw_vbus_draw(fd, index->bMaxPower);
  if (rv < 0) {
    return rv;
  }
  rv = usb_raw_configure(fd);
  if (rv < 0) {
    return rv;
  }
  set_interface(fd, 0);
  return 0;
}

static volatile long syz_usb_connect_impl(
    uint64_t speed, uint64_t dev_len, const char* dev,
    const struct vusb_connect_descriptors* descs,
    lookup_connect_out_response_t lookup_connect_response_out) {
  if (!dev) {
    return -1;
  }
  int fd = usb_raw_open();
  if (fd < 0) {
    return fd;
  }
  if (fd >= MAX_FDS) {
    close(fd);
    return -1;
  }
  struct usb_device_index* index = add_usb_index(fd, dev, dev_len);
  if (!index) {
    return -1;
  }
  char device[32];
  sprintf(&device[0], "dummy_udc.%llu", procid);
  int rv = usb_raw_init(fd, speed, "dummy_udc", &device[0]);
  if (rv < 0) {
    return rv;
  }
  rv = usb_raw_run(fd);
  if (rv < 0) {
    return rv;
  }
  bool done = false;
  while (!done) {
    struct usb_raw_control_event event;
    event.inner.type = 0;
    event.inner.length = sizeof(event.ctrl);
    rv = usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
    if (rv < 0) {
      return rv;
    }
    if (event.inner.type != USB_RAW_EVENT_CONTROL) continue;
    char* response_data = NULL;
    uint32_t response_length = 0;
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
      response_data = NULL;
      response_length = event.ctrl.wLength;
    }
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD &&
        event.ctrl.bRequest == USB_REQ_SET_CONFIGURATION) {
      rv = configure_device(fd);
      if (rv < 0) {
        return rv;
      }
    }
    struct usb_raw_ep_io_data response;
    response.inner.ep = 0;
    response.inner.flags = 0;
    if (response_length > sizeof(response.data)) response_length = 0;
    if (event.ctrl.wLength < response_length)
      response_length = event.ctrl.wLength;
    response.inner.length = response_length;
    if (response_data)
      memcpy(&response.data[0], response_data, response_length);
    else
      memset(&response.data[0], 0, response_length);
    if (event.ctrl.bRequestType & USB_DIR_IN) {
      rv = usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
    } else {
      rv = usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
    }
    if (rv < 0) {
      return rv;
    }
  }
  sleep_ms(200);
  return fd;
}

static volatile long syz_usb_connect(volatile long a0, volatile long a1,
                                     volatile long a2, volatile long a3) {
  uint64_t speed = a0;
  uint64_t dev_len = a1;
  const char* dev = (const char*)a2;
  const struct vusb_connect_descriptors* descs =
      (const struct vusb_connect_descriptors*)a3;
  return syz_usb_connect_impl(speed, dev_len, dev, descs,
                              &lookup_connect_response_out_generic);
}

static volatile long syz_usb_control_io(volatile long a0, volatile long a1,
                                        volatile long a2) {
  int fd = a0;
  const struct vusb_descriptors* descs = (const struct vusb_descriptors*)a1;
  const struct vusb_responses* resps = (const struct vusb_responses*)a2;
  struct usb_raw_control_event event;
  event.inner.type = 0;
  event.inner.length = USB_MAX_PACKET_SIZE;
  int rv = usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
  if (rv < 0) {
    return rv;
  }
  if (event.inner.type != USB_RAW_EVENT_CONTROL) {
    return -1;
  }
  char* response_data = NULL;
  uint32_t response_length = 0;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    if (!lookup_control_response(descs, resps, &event.ctrl, &response_data,
                                 &response_length)) {
      usb_raw_ep0_stall(fd);
      return -1;
    }
  } else {
    if ((event.ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD ||
        event.ctrl.bRequest == USB_REQ_SET_INTERFACE) {
      int iface_num = event.ctrl.wIndex;
      int alt_set = event.ctrl.wValue;
      int iface_index = lookup_interface(fd, iface_num, alt_set);
      if (iface_index < 0) {
      } else {
        set_interface(fd, iface_index);
      }
    }
    response_length = event.ctrl.wLength;
  }
  struct usb_raw_ep_io_data response;
  response.inner.ep = 0;
  response.inner.flags = 0;
  if (response_length > sizeof(response.data)) response_length = 0;
  if (event.ctrl.wLength < response_length)
    response_length = event.ctrl.wLength;
  if ((event.ctrl.bRequestType & USB_DIR_IN) && !event.ctrl.wLength) {
    response_length = USB_MAX_PACKET_SIZE;
  }
  response.inner.length = response_length;
  if (response_data)
    memcpy(&response.data[0], response_data, response_length);
  else
    memset(&response.data[0], 0, response_length);
  if ((event.ctrl.bRequestType & USB_DIR_IN) && event.ctrl.wLength) {
    rv = usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
  } else {
    rv = usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
  }
  if (rv < 0) {
    return rv;
  }
  sleep_ms(200);
  return 0;
}

static void kill_and_wait(int pid, int* status) {
  kill(-pid, SIGKILL);
  kill(pid, SIGKILL);
  for (int i = 0; i < 100; i++) {
    if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
    usleep(1000);
  }
  DIR* dir = opendir("/sys/fs/fuse/connections");
  if (dir) {
    for (;;) {
      struct dirent* ent = readdir(dir);
      if (!ent) break;
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

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
  int iter = 0;
  for (;; iter++) {
    int pid = fork();
    if (pid < 0) exit(1);
    if (pid == 0) {
      setup_test();
      execute_one();
      exit(0);
    }
    int status = 0;
    uint64_t start = current_time_ms();
    for (;;) {
      if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
      sleep_ms(1);
      if (current_time_ms() - start < 5000) continue;
      kill_and_wait(pid, &status);
      break;
    }
  }
}

uint64_t r[1] = {0xffffffffffffffff};

void execute_one(void) {
  intptr_t res = 0;
  memcpy((void*)0x20000040,
         "\x12\x01\x00\x00\x00\x00\x18\x10\x5e\x04\xda\x07\x07\x00\x00\x00\x00"
         "\x01\x09\x02\x24\x00\x01\x00\x00\x00\x00\x09\x04\x00\x00\x09\x03\x00"
         "\x00\x00\x09\x21\x00\x00\x00\x01\x22\x22\x00\x09\x05\x81\x03\x08",
         50);
  res = -1;
  res = syz_usb_connect(/*speed=*/0, /*dev_len=*/0x36, /*dev=*/0x20000040,
                        /*conn_descs=*/0);
  if (res != -1) r[0] = res;
  syz_usb_control_io(/*fd=*/r[0], /*descs=*/0, /*resps=*/0);
  *(uint32_t*)0x200001c0 = 0x24;
  *(uint64_t*)0x200001c4 = 0;
  *(uint64_t*)0x200001cc = 0;
  *(uint64_t*)0x200001d4 = 0x20000080;
  memcpy((void*)0x20000080,
         "\x00\x22\x22\x00\x00\x00\x96\x23\x13\x06\xe5\x3f\x07\x0c\xad\x00\x00"
         "\x2a\x90\x01\x07\x09\x00\xde\x00\x83",
         26);
  *(uint64_t*)0x200001dc = 0;
  syz_usb_control_io(/*fd=*/r[0], /*descs=*/0x200001c0, /*resps=*/0);
}
int main(void) {
  syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
          /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
  for (procid = 0; procid < 4; procid++) {
    if (fork() == 0) {
      loop();
    }
  }
  sleep(1000000);
  return 0;
}


=* repro.txt =*
r0 = syz_usb_connect$hid(0x0, 0x36,
&(0x7f0000000040)=ANY=[@ANYBLOB="12010000000018105e04da070700000000010902240001000000000904000009030000000921000000012222000905810308"],
0x0)
syz_usb_control_io$hid(r0, 0x0, 0x0)
syz_usb_control_io$hid(r0, &(0x7f00000001c0)={0x24, 0x0, 0x0,
&(0x7f0000000080)=ANY=[@ANYBLOB="00222200000096231306e53f070cad00002a9001070900de0083"],
0x0}, 0x0)


and see also in
https://gist.github.com/xrivendell7/89889ed8dd8565675b11816a6aa1fbc3

I hope it helps.
Merry Christmas!

xingwei Lee


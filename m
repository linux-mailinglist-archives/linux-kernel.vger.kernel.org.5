Return-Path: <linux-kernel+bounces-15633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D5822F39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2B1B212F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54AF1A58C;
	Wed,  3 Jan 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCfMsXtl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593711A28A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55590da560dso5020401a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704291172; x=1704895972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPFQzU4Gx91zpYQVdqRMxfCw/fsuh+WrmQI32qDeNkg=;
        b=BCfMsXtlQ5VsO3yX9ley+Z2DRcGg8oiQaMqyPOoSfPecpBN+O7jFHcGK9vUaBssHO9
         Jatdw5/Xe4UaiWmWwdVMoq6nZ+5+7/zi+LUKpLGMJeoAv5Vpj1/gx4YnTl4LoC0Ij5Up
         eZ+f9gSf7oDRlHhSsAlrk8tU4eKCZz9FWaUwrfn17OfDk9FzOLea7Z+lGTyJQGL8Zi03
         SaJak8yfoh3q1a6jxcZtaW66jZLRwfK7nyvNg1SoNTnaO0T+DISvkbVrVqCmjguHaHC9
         lOYy5gG5AW0/V93zlPKLC2/f4+xy1Gn7x69kpD5+Pv18meXWqsYi8BnQvhsa+L57n+D1
         xBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291172; x=1704895972;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPFQzU4Gx91zpYQVdqRMxfCw/fsuh+WrmQI32qDeNkg=;
        b=UYxNzU2f+KrPTBgKutXIEeZSpEbau5t/2eAZgGR83EX3oKqA3FZ0+bGgn1KhzE/IuV
         YfUAqylqEdIoMZz+NKS+vLlenMCG6kmoemd8bKWdew+vsyhWCMHWBFf1yhgLom1k3Izu
         qlILtPmPxL78Eat4+/WZhsgveQz80QNSyUKVqh+9cs34UMqCYi/JBbNFhtDcKv4eQOkb
         brav79JbF0x4LoBmfhwBTw3kL2hX7AIkzTPV3mUQ33b+VWOMkgJDzQ5pHnyQnnvEf4PT
         br2QxC9nxpAQ3vuMslvXkP5PLUi1ycaSz9qoqZRTEdm1ExNSE3EGTWkDnkTkEwsX+Z8+
         yNlA==
X-Gm-Message-State: AOJu0Yy4BdPYNHK9d1eWcGIusfAXOiA+Qufir384Vl4vOCKUTH48Rl5y
	tS8FvA6D3i/2vafFK9FLVuWeEqFWQ36s1Q==
X-Google-Smtp-Source: AGHT+IGBp6+obC5gx63YLD3UqKoRxqolP5HgflYweK8tKJyZIf3MrQ4UEjPpjy8bhFnE3Xa+DJ5R3A==
X-Received: by 2002:a05:6402:516e:b0:555:59f:1743 with SMTP id d14-20020a056402516e00b00555059f1743mr7961183ede.54.1704291172572;
        Wed, 03 Jan 2024 06:12:52 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7db92000000b00554d6b46a3dsm12631963edt.46.2024.01.03.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:12:52 -0800 (PST)
Date: Wed, 3 Jan 2024 17:12:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usbhid: fix array-index-out-of-bounds in usbhid_parse
 UBSAN warning
Message-ID: <5e68be46-caab-40f4-8e0f-543566fd7c28@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009ae37b060d32c643@google.com>

Hi syzbot,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/usbhid-fix-array-index-out-of-bounds-in-usbhid_parse-UBSAN-warning/20231225-153341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/0000000000009ae37b060d32c643%40google.com
patch subject: [PATCH] usbhid: fix array-index-out-of-bounds in usbhid_parse UBSAN warning
config: x86_64-randconfig-161-20231225 (https://download.01.org/0day-ci/archive/20231226/202312260900.gRDPofL9-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312260900.gRDPofL9-lkp@intel.com/

smatch warnings:
drivers/hid/usbhid/hid-core.c:1026 usbhid_parse() warn: curly braces intended?
drivers/hid/usbhid/hid-core.c:1029 usbhid_parse() warn: inconsistent indenting

vim +1026 drivers/hid/usbhid/hid-core.c

c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   979  static int usbhid_parse(struct hid_device *hid)
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   980  {
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   981  	struct usb_interface *intf = to_usb_interface(hid->dev.parent);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   982  	struct usb_host_interface *interface = intf->cur_altsetting;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   983  	struct usb_device *dev = interface_to_usbdev (intf);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   984  	struct hid_descriptor *hdesc;
2eb5dc30eb87aa drivers/hid/usbhid/hid-core.c Paul Walmsley      2007-04-19   985  	u32 quirks = 0;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   986  	unsigned int rsize = 0;
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15   987  	char *rdesc;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16   988  	int ret, n;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28   989  	int num_descriptors;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28   990  	size_t offset = offsetof(struct hid_descriptor, desc);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   991  
d5d3e202753cc0 drivers/hid/usbhid/hid-core.c Benjamin Tissoires 2017-11-20   992  	quirks = hid_lookup_quirk(hid);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16   993  
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   994  	if (quirks & HID_QUIRK_IGNORE)
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   995  		return -ENODEV;
6f4303fb2ec680 drivers/hid/usbhid/hid-core.c Jiri Kosina        2009-01-29   996  
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   997  	/* Many keyboards and mice don't like to be polled for reports,
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   998  	 * so we will always set the HID_QUIRK_NOGET flag for them. */
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15   999  	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1000  		if (interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_KEYBOARD ||
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1001  			interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1002  				quirks |= HID_QUIRK_NOGET;
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1003  	}
0f28b55db54300 drivers/usb/input/hid-core.c  Alan Stern         2006-05-15  1004  
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15  1005  	if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
c5b7c7c395a34f drivers/usb/input/hid-core.c  Dmitry Torokhov    2005-09-15  1006  	    (!interface->desc.bNumEndpoints ||
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1007  	     usb_get_extra_descriptor(&interface->endpoint[0], HID_DT_HID, &hdesc))) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1008  		dbg_hid("class descriptor not present\n");
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1009  		return -ENODEV;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1010  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1011  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1012  	if (hdesc->bLength < sizeof(struct hid_descriptor)) {
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1013  		dbg_hid("hid descriptor is too short\n");
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1014  		return -EINVAL;
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1015  	}
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1016  
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1017  	hid->version = le16_to_cpu(hdesc->bcdHID);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1018  	hid->country = hdesc->bCountryCode;
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1019  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1020  	num_descriptors = min_t(int, hdesc->bNumDescriptors,
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1021  	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1022  
f043bfc98c193c drivers/hid/usbhid/hid-core.c Jaejoong Kim       2017-09-28  1023  	for (n = 0; n < num_descriptors; n++)

This for loop needs curly braces now.

d3e0d5b253c73b drivers/hid/usbhid/hid-core.c syzbot             2023-12-23  1024  		if (n >= ARRAY_SIZE(hdesc->desc))
d3e0d5b253c73b drivers/hid/usbhid/hid-core.c syzbot             2023-12-23  1025  			break;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16 @1026  		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1027  			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1028  
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16 @1029  	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
58037eb961f859 drivers/hid/usbhid/hid-core.c Jiri Kosina        2007-05-30  1030  		dbg_hid("weird size of report descriptor (%u)\n", rsize);
c500c9714011ed drivers/hid/usbhid/hid-core.c Jiri Slaby         2008-05-16  1031  		return -EINVAL;
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1032  	}
^1da177e4c3f41 drivers/usb/input/hid-core.c  Linus Torvalds     2005-04-16  1033  
52150c78270db5 drivers/hid/usbhid/hid-core.c Joe Perches        2017-03-01  1034  	rdesc = kmalloc(rsize, GFP_KERNEL);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30823804CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjLEIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:54:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25ED3;
        Tue,  5 Dec 2023 00:54:10 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso18672581fa.1;
        Tue, 05 Dec 2023 00:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701766449; x=1702371249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzuEowndp5MzEuD04TXU4L/5V+8Wpk0WEsNBMfJL7bo=;
        b=TmI/EfYV/I73mUtrQoR9NH2QWzUUMYPzzcewQd3A/qQJkBLoQyB3YSMM3/JR+zyecE
         jc6KvaHG+TUEJBoVLpwrz50iQXIJFvj9b+7RcMyu1w3smmAX9umZBBdkvY2OMfK9VxQI
         1uXW5Y0m0VFVXDc4OZC4LX9mntDWu1FwwSrmiS0vYk7vX535XZdfOifLuz6a0ZOrzW5r
         A34xQ/YHzA0gjJDR0UOQOVr171kfMPaSmDzt7kRCcOOrgy2m26+tfbrxOXzF7471naf5
         j+JdOs467b0jOtTjtazoO22u9PHKMbqzx5g4gJXRteJXTvjLlTfn8xSDfknT4c2Lfnv7
         V+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766449; x=1702371249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzuEowndp5MzEuD04TXU4L/5V+8Wpk0WEsNBMfJL7bo=;
        b=VEbMA19zak1zUgKSrYEhmKz8t1euFzXXuKIWLCd5NzDYLCPTlFl1lPwPzIyFLVnNhg
         ynvxtefAC3ODeC8Mbvcn8I5tL7zDeTH0Ffz1ougplDhgekkCRKqpw3vceQfZ582Q2YtT
         nZLrF4jUDRyosbtVCnU2paFu7V7vX8VyCl0f9nP3DTWFpJmKdNG1aK4Ugz+g/LINPZsP
         cPB2NGJBZvyMU/gT3ZImLRtoLjYbxSR1lpZnjr9beNuf+LrK9IQfXcWh5XF0c7SM965/
         iPKaNFfwqsRSZphZvlxynmUu9BY9R+q0bVifFw1IeLB293t0FVOeJAQFNL/4LvKFIKvG
         DqxQ==
X-Gm-Message-State: AOJu0Yx4wnXDIyM4R7RjIjO7/1oK1wKG07ivq/M3t4adHZFYTwE3oFza
        dF4WSYsYXjAo+XvFxwqpZ8sqd/jgiDpYzdgE
X-Google-Smtp-Source: AGHT+IFsoAxUqz05fKiZ8myNzNhOvgFTClSdlmk52EsAtrDRjuSoubkg5fJ+CQ/jcgGZ1ynVvvnPQg==
X-Received: by 2002:a2e:98da:0:b0:2c9:f8c2:574f with SMTP id s26-20020a2e98da000000b002c9f8c2574fmr1895426ljj.103.1701766448805;
        Tue, 05 Dec 2023 00:54:08 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id y33-20020a05651c222100b002ca0ed22a22sm274879ljq.63.2023.12.05.00.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:54:08 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     gregkh@linuxfoundation.org, benjamin.tissoires@redhat.com,
        aladyshev22@gmail.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@keeping.me.uk, lee@kernel.org
Subject: [PATCH 0/1] usb: gadget: f_hid: fix report descriptor allocation
Date:   Tue,  5 Dec 2023 11:54:02 +0300
Message-Id: <20231205085404.175-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "usb: gadget: f_hid: fix f_hidg lifetime vs cdev"
(89ff3dfac604614287ad5aad9370c3f984ea3f4b) has introduced a bug
that leads to hid device corruption after the replug operation.

The usb gadget driver bug was observed in the KVM functionality of the
OpenBMC distribution. In the test environment BMC provides KVM
functionality for the host (i.e. virtual USB keyboard) via the USB
gadget device.

The bug occurs when the KVM page is refreshed (i.e. USB device is
replugged).

Before the 89ff3dfac6 this opeartion was working without any issues.
Log messages from the host for this operation:
```
kernel: usb 1-7.4: USB disconnect, device number 3
kernel: usb 1-7.4: new high-speedUSB device number 4 using xhci_hcd
kernel: usb 1-7.4: New USB device found, idVendor=1d6b, idProduct=0104,
  bcdDevice= 1.00
kernel: usb 1-7.4: New USB device strings: Mfr=1, Produt=2, SerialNumber=3
kernel: usb 1-7.4: Product: Virtual Keyboard and Mouse
kernel: usb 1-7.4: Manufacturer: OpenBMC
kernel: usb 1-7.4: SerialNumber: OBMC0001
kernel: input: OpenBMC Virtual Keyboard and Mouse as /devices/pci0000:
  00/0000:00:140/usb1/1-7/1-7.4/1-7.4:1.0/0003:1D6B:0104.0003/input/input3
kernel: hid-generic 0003:1D6B:0104.0003: inputhidraw0: USB HID v1.01
  Keyboard [OpenBMC Virtual Keyboard and Mouse] on usb-0000:00:14.0-7.4/input0
kernel: input: OpenBMC Virtual Keyboard and Mouse as /devices/pci0000:
  00/0000:00:14.0/sb1/1-7/1-7.4/1-7.4:1.1/0003:1D6B:0104.0004/input/input4
kernel: hid-generic 0003:1D6B:0104.0004: input,hidraw1: USB HID v1.01
  Mouse [OpenBMC Virtual Keyboard and Mouse] on usb-0000:00:14.0-7.4/input1
```

After the 89ff3dfac6 the KVM page refresh (i.e. USB device replug) results
to the USB device corruction and the following messages from the driver:
```
kernel: usb 1-7.4: USB disconnect, device number 3
hid-generic 0003:1D6B:0104.0003: item fetching failed at offset 18/63
hid-generic 0003:1D6B:01040004: item fetching failed at offset 32/76
kernel: usb 1-7.4: new high-speed USB device number 4 using xhci_hcd
kernel: usb 1-7.4: New USB device found, idVendor=1d6b, idProduct=0104,
  bcdDevice= 1.00
kernel: usb 1-7.4:New USB device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 1-7.4: Product: Virual Keyboard and Mouse
kernel: usb 1-7.4: Manufacturer: OpenBMC
kernel: usb 1-7.4: SerialNumber: OBMC0001
kernel: id-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item tag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: unknown main item ag 0x0
kernel: hid-generic 0003:1D6B:0104.0003: item fetching failed at offset 18/63
kernel: hid-eneric: probe of 0003:1D6B:0104.0003 failed with error -22
kernel: hid-generic 0003:1D6B:0104.0004: item fetching failed at offset 32/76
kernel hid-generic: probe of 0003:1D6B:0104.0004 failed with error -22
```

Reverse device managed memory allocation for the report descriptor
to fix the issue.



Konstantin Aladyshev (1):
  usb: gadget: f_hid: fix report descriptor allocation

 drivers/usb/gadget/function/f_hid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1


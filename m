Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639107DC36C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjJaAE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjJaAEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:04:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BBA6;
        Mon, 30 Oct 2023 17:04:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9d242846194so324404866b.1;
        Mon, 30 Oct 2023 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698710691; x=1699315491; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhbBMCmRj1nNpNlm143E93iRGLt6PISYmrSgpHo8H30=;
        b=JrmZ/PQ0wXvVPtEe0KRr8pieZRAlXpQrd+OgJ/W4fCt9GtKKdJ/rJj5U4MZCKraD+A
         r/YwO7GBUYSlBLOO00P1eSPHhgB2XJ+i0Fd5D2nkPakGVhRdlsSN60P2BZrM00vETzZs
         /PhI0ZsL/qmM1uChYuSuLrgscSlSAZHVcFrIv+AxdxnOMiTknH+rTh/4tpvB+3WA5+wp
         HIoOSTu4OI+wptpWwN9jV7i2aADhxRofVGQD5X0ROgLyNU9oJZ9CS2jeLciMpsejRBf0
         0vFxXAfb3lIFz0d7qFanbJW71dCVpIBpr8VhG7RGYzH5o/jAWgZKV5dMmXOJPTj3Rlqe
         K8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698710691; x=1699315491;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VhbBMCmRj1nNpNlm143E93iRGLt6PISYmrSgpHo8H30=;
        b=cEB5YJpgQpounuKO90ltUkLSEcaFh2QBf0dxkNzmlXEMpyFhr2DSVg5cWtyy4r4Q8R
         r5Kd0+Wj6mQKXxVss/5eyeDjn5EyspRtep+CNbRyi2mFSpwE0SY0xh1kS/EY7CTj2/i1
         Lcs8rBqwNRxyTqqBqff4okdgXZDjS08qHEyyw405Il0i50v/H5uzVeP+yaOvIQ5X3FiC
         RSrX0VM8h1xU+fhFfbdpcWRxnkGVXVYkyP62KC6v5TDjGlWLS1Of6HU60bvJTSiyeccu
         k612rBLK7yLVp1PVdBFeT8/zSiRpte+M8mHXJ1ejaifKLpPOTHRW9PAzs3c9Ohgb1x2G
         6Tvw==
X-Gm-Message-State: AOJu0YwhfMSBFe02fSgpJ1nQar1q6pcwWhP+36nstdBQ7G0ViZB1HdIS
        4ONJM4q4tQPf9GhPxmXPU3V39/PFRTzvWD/H8LKTatzYE4I=
X-Google-Smtp-Source: AGHT+IGk1JkYjOS1c7IgqiA50RSU8Y7VxChpt1g2S3lD1oP9suI41ONMr65njR0XQon+YvBrhLScInRqypREs7IMxnA=
X-Received: by 2002:a17:907:3f8b:b0:9bd:fa48:83c5 with SMTP id
 hr11-20020a1709073f8b00b009bdfa4883c5mr7735638ejc.70.1698710690771; Mon, 30
 Oct 2023 17:04:50 -0700 (PDT)
MIME-Version: 1.0
From:   Mario Marietto <marietto2008@gmail.com>
Date:   Tue, 31 Oct 2023 01:04:14 +0100
Message-ID: <CA+1FSiiPqYuycAa8rLFzKVDzvJC3BQBwRW7E0Ki4CXEFwhRASA@mail.gmail.com>
Subject: exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR*
 Device 14450000.mixer lacks support for IOMMU
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are a team of linux enthusiasts who are trying to boot Xen on a
Samsung XE303C12 Chromebook aka "snow"
following the suggestions in the slide show presentation here:

https://www.slideshare.net/xen_com_mgr/xpds16-porting-xen-on-arm-to-a-new-soc-julien-grall-arm

This device uses an exynos5250 SOC dual core 1.7 GHz with 2 MB RAM, it is
a Samsung armv7 chip with virtualization extensions.

In particular, we have it working fairly well both on the bare metal with
a recent 6.1.59 Linux LTS kernel and also with a recent 5.4.257 LTS
kernel with KVM, the older LTS kernel version is used to test KVM because
support for KVM on arm v7 was removed from Linux around kernel version
5.7. So we know we have the hypervisor mode enabled because we were able
to use it with KVM.

For Xen, we are using the latest Debian build of Xen 4.17 for the Debian
armhf architecture:

(XEN) Xen version 4.17.2-pre (Debian 4.17.1+2-gb773c48e36-1)
(pkg-xen-devel@xxxxxxxxxxxxxxxxxxxxxxx) (arm-linux-gnueabihf-gcc (Debian
12.2.0-14) 12.2.0) debug=n Thu May 18 19:26:30 UTC 2023

The Linux kernel is a custom build that adds the Xen config kernel
options (CONFIG_XEN_DOM0, etc) on top of a kernel that works well on the
same Chromebook model on the bare metal. I can provide the config options
of the kernel that was used if that is helpful.

Our method of booting is to have u-boot boot the Xen hypervisor and load
the device tree after adding the dom0 to the otherwise unaltered device
tree from the Linux kernel using u-boot fdt commands to add a /chosen
node, as described on the Xen wiki and in the pages linked from there. We
have also tried adding and loading an initrd.img using the device tree
/chosen node but that made no difference in our tests.

We actually have the Linux LTS kernel version 6.1.59 working as dom0 with
Xen using the same version of u-boot that we used for KVM, but with a big
problem.

The problem we see is that when booting the 6.1.59 kernel version as dom0
with Xen, the screen is totally dark and the only way to access the
system is remotely through ssh. Logs indicate most everything else is
working, such as the wifi card so we can access it remotely via ssh and a
USB optical mouse lights up when connected so USB is also working.
Obviously, the disk is also working. The Chromebook is configured to boot
from the device's SD card slot by turning on Chrome OS developer mode
options to enable booting from the SD card slot.

The mystery is that when booting the exact same 6.1.59 kernel on the bare
metal instead of booting it as dom0 on Xen, it boots up with full access
to the screen and we can interact with the system using the X.org windows
system. But booting as dom0 with Xen, the screen is totally dark and the
only access we have to the system is through the network via ssh. Also,
when booting the 5.4.257 kernel with KVM in hypervisor mode, the screen
works and we can interact with the system through the X.org windows
system.

Exploring the log file,we have seen the errors below :


With Xen (or in bare metal):

devuan-bunsen kernel: [drm] Exynos DRM: using 14400000.fimd device for
DMA mapping operations
devuan-bunsen kernel: exynos-drm exynos-drm: bound 14400000.fimd (ops
0xc0d96354)
devuan-bunsen kernel: exynos-drm exynos-drm: bound 14450000.mixer (ops
0xc0d97554)
devuan-bunsen kernel: exynos-drm exynos-drm: bound
145b0000.dp-controller (ops 0xc0d97278)
devuan-bunsen kernel: exynos-drm exynos-drm: bound 14530000.hdmi (ops
0xc0d97bd0)
...
devuan-bunsen kernel: Console: switching to colour frame buffer device 170x48
devuan-bunsen kernel: exynos-drm exynos-drm: [drm] fb0: exynosdrmfb
frame buffer device
devuan-bunsen kernel: [drm] Initialized exynos 1.1.0 20180330 for
exynos-drm on minor 0

In this case,the kernel is able to use the exynos-drm kernel to start
the fb0 device. But with Xen we get this error with exynos-drm:

devuan-bunsen kernel: [drm] Exynos DRM: using 14400000.fimd device for
DMA mapping operations
devuan-bunsen kernel: exynos-drm exynos-drm: bound 14400000.fimd (ops
0xc0d96354)
devuan-bunsen kernel: exynos-mixer 14450000.mixer:
[drm:exynos_drm_register_dma] *ERROR* Device 14450000.mixer lacks
support for IOMMU
devuan-bunsen kernel: exynos-drm exynos-drm: failed to bind
14450000.mixer (ops 0xc0d97554): -22
devuan-bunsen kernel: exynos-drm exynos-drm: adev bind failed: -22
devuan-bunsen kernel: exynos-dp: probe of 145b0000.dp-controller
failed with error -22


Any ideas why booting the same Linux kernel that results in a working
X.org display on the bare metal instead as dom0 on Xen would cause the
display to remain dark, but most other basic functions would work, such
as network, disk, and USB ? thanks.

-- 
Mario.

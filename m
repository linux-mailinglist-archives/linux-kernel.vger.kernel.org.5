Return-Path: <linux-kernel+bounces-6285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B001B8196C4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F481F230C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A621883C;
	Wed, 20 Dec 2023 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQdRoJR+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372D79D8;
	Wed, 20 Dec 2023 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5c875ee4f10so5390937b3.1;
        Tue, 19 Dec 2023 18:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703038811; x=1703643611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7wnJmKZPNq4/mxy+en/Y2MYRkaPw7M3y1oFd6Iwnst4=;
        b=ZQdRoJR+41K5vYT+28aU2T3Vj3iH26G5IfA4rP3Pem5lKged7I3pI/91KlSHaaqB9X
         Nq3nRL2dTKFFudVtdwuhzob6PoJnyMIqZbFcUDSAQmn35WzajjgxtY0wbXmKUHjdnabk
         B2Q9dGbBwp+1KTOiFcFbwM9fNYASepvfSU+Qjan2ExeoZ9G2UY1dlZm2HnAU35hXjPLL
         7uUMcwW3yc+dCJAMdW7xH6jmmvL8vMjFyA7eU6H8J1m/BEW7Ua3Z/GS/kS84jlYPj+N1
         gKaJ5PGZkL5Vqv1Q5V21czBQF4GpEVLrMhVg9U4QcMr6zIUXXfPozKSfBweSly2l8W2H
         adjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703038811; x=1703643611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wnJmKZPNq4/mxy+en/Y2MYRkaPw7M3y1oFd6Iwnst4=;
        b=CIHi62kMZ2yjWfWRw4w3I3yTS2Iv11jjy40RggaV6Dchz9PTdPiOGD8mgRHDg9Ysbk
         x7MdiJRWT8camuzpaDVUWCb0OxXR1BBtiQZA4atfAF5V4t2EcrPeJqkyY71kILZETegh
         +vowD3SDs/xFyRzoFQnjAS6f9uRulVVoMfNXHKAPu7Utco6rAwiZCdu5hrLqY19RcL5+
         Z8HRTrgYRkfyLgkihJ4lw/8guM5X+NoDDjUw/clqeYln6PKh7hwKeP4EZ6OVQhMDG9BS
         5sqWHIscBww0ynBRdZhcKWQdbXozDcqxQVGbfY15UYgXk4EZHfMAmTFVR1J+1aDD2uYl
         dlHw==
X-Gm-Message-State: AOJu0YyOgQHD04WCdiaA3gncCGBbXmZ7+vNlFiGYisR1JMV/XGSJAeOF
	cflE1G3t3DSw50T3h859IrF/BUhPrYhXnsYlSOwLH4Dqw38TGA==
X-Google-Smtp-Source: AGHT+IFLy/FjAO+dVGqTImgUyEFZTWld45sPwQ8hSeCfhu5lLyEFKFfMpq56I71Eb41GD3pjoC4Bg/VgJpTGXfppOlI=
X-Received: by 2002:a25:d111:0:b0:dbd:7407:21f4 with SMTP id
 i17-20020a25d111000000b00dbd740721f4mr1699573ybg.0.1703038810881; Tue, 19 Dec
 2023 18:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 20 Dec 2023 05:19:25 +0300
Message-ID: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: stefanb@linux.ibm.com
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rob@landley.net, stable@vger.kernel.org, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 19, 2023 at 08:12:48PM -0500, Stefan Berger wrote:
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
>
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.
>
> This currently does not work when root= is provided since then
> saved_root_name contains a string and rootfstype= is ignored. Therefore,
> ramfs is currently always chosen when root= is provided.

Maybe it is a good idea to just fully remove ramfs? initramfs will
always be tmpfs. And tmpfs will always be enabled.

As well as I understand, ramfs was originally introduced, because
tmpfs seemed too big. So, it seemed to be a good idea to have small fs
(ramfs), which is always enabled.

I just did an experiment. I compiled the kernel with a very small
config. And without TMPFS and SHMEM. I got 1059440 bytes image. Then I
enabled TMPFS and SHMEM, and I got 1072976 bytes. So tmpfs adds 13536
bytes, i. e. 14k, which is a very small amount. It adds 1.3 % to the
kernel even with very small config.

So I propose to remove ramfs and always enable tmpfs. This will
decrease complexity.

Here are my configs (x86_64). Just enough to run busybox in "qemu -serial stdio"

make KCONFIG_ALLCONFIG="$FILE" allnoconfig

CONFIG_64BIT=y
CONFIG_PRINTK=y
CONFIG_SERIAL_8250=y
CONFIG_TTY=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_EMBEDDED=y
CONFIG_EXPERT=y
CONFIG_TMPFS=n # Try to change this to "y"
CONFIG_SHMEM=n # Try to change this to "y"

Here is full docker reproducer:

# Reproducible
# 20230227 = 20230227T000000Z = 20230226T090712Z
FROM debian:sid-20230227
ENV LC_ALL C.UTF-8
RUN sed -i 's~^URIs:.*$~URIs:
http://snapshot.debian.org/archive/debian/20230226T090712Z~'
/etc/apt/sources.list.d/debian.sources
RUN echo 'Acquire::Check-Valid-Until "false";' >
/etc/apt/apt.conf.d/02acquire-check-valid-until
RUN apt-get update && apt-get install -y apt-utils whiptail
RUN apt-get update && apt-get install -y busybox-static
qemu-system-x86 make gcc git flex bison bc libelf-dev less nano cpio
RUN git clone --depth=1 -b v6.2
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
RUN : > /.config
# See Linux f8f0d06438e5c810d1e13b5f8c2fed501fe36e9c
RUN echo 'CONFIG_64BIT=y' >> /.config
RUN echo 'CONFIG_PRINTK=y' >> /.config
RUN echo 'CONFIG_SERIAL_8250=y' >> /.config
RUN echo 'CONFIG_TTY=y' >> /.config
RUN echo 'CONFIG_SERIAL_8250_CONSOLE=y' >> /.config
RUN echo 'CONFIG_BLK_DEV_INITRD=y' >> /.config
RUN echo 'CONFIG_RD_GZIP=y' >> /.config
RUN echo 'CONFIG_BINFMT_ELF=y' >> /.config
RUN echo 'CONFIG_EMBEDDED=y' >> /.config
RUN echo 'CONFIG_EXPERT=y' >> /.config
RUN echo 'CONFIG_TMPFS=y' >> /.config # try "n"
RUN echo 'CONFIG_SHMEM=y' >> /.config # try "n"
RUN cd linux && make KCONFIG_ALLCONFIG=/.config allnoconfig
RUN cd linux && make -j4
RUN mkdir /initramfs && cp /bin/busybox /initramfs && cd /initramfs &&
ln -s busybox sh && find . | cpio --create --format=newc --quiet |
gzip > /initramfs.cpio.gz
RUN echo "qemu-system-x86_64 -M microvm -m 64M -serial stdio -display
none -kernel /linux/arch/x86/boot/bzImage -initrd /initramfs.cpio.gz
-append 'quiet console=ttyS0 earlyprintk=ttyS0 rdinit=/sh' -nodefaults
-no-user-config" > /root/.bash_history

-- 
Askar Safin


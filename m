Return-Path: <linux-kernel+bounces-98833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4344878009
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2222807BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EDC25755;
	Mon, 11 Mar 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNc0GFNt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4F1E4A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160367; cv=none; b=CYJNNj9L/6xq4Mma9s5dsMZ/y9qY1olwU4Ni6HJHJCN2CHvJchA+7zDkiDbuZn2CFbx9X9Tt8iJOQrlO1U8T2RW86NBApS16ThNTr/9U2YzyupphNNDvh+t7Hn17Zs619Zm7C4Uf68CehR1fmLE4sEWX+DVg1w8wtaKiO/PuYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160367; c=relaxed/simple;
	bh=EYHxpgQx2dHxrLJ/aFBCaoUIoGsqVPLv2Q+vy437STo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SEl/qqIx7FzJ6hzPE7r/K1KSKMGMldEZIP/gLCh+r0MBSLSuDSTgCVRXoGcm4nD4Z3M0XeU85b8l+mk7nt1b7Skw0tIL8/QYK9bhey4kiuWJr9SXPyTQAsT7weSXCDX6eLxzlk7THoouDifjH1ocWwZ/6cgfuSDuQCwrRIzDemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNc0GFNt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131c0691feso5598366e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710160364; x=1710765164; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1iggp2auZNl6Zn5njSGop2EAyZqvh9RsE4p54dz7AyM=;
        b=bNc0GFNt9O3+ekFACF1gr6W6z7dk0D9q4d6QEiHp9/9EMqJXHw/zbaopZu9EkNOLUC
         empBYMc/VvqPjhue3zj7fnoffw97lPEEFXYzHaJd86HWCRj3EAGhhHyYqqBUYLQmwMlL
         6iCcqpj515+KaBSGrDi8sDer0tY4l9uwyRMwRlJTqX9jtrWzBiUAHyA8WWKEnfOfw5sp
         QmvZ7MzDmVVKhclL9UI8Q4ENOUNwbmj6g0yd3PERySFXXuk5t9c5KfxC1gX4hjJw5HCI
         VDO/NHReCHgDviGBW4GGV+TURgmdv619Me+QT+SVWWqmywWF9NQooUjuyZKZLvi9prjv
         mrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160364; x=1710765164;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iggp2auZNl6Zn5njSGop2EAyZqvh9RsE4p54dz7AyM=;
        b=bGn1R2kkKGvFU8lZvT6UlRaitv/TQZ9AiEqfzNydomuh1XP91OM6M4iO5WxuhuupVH
         +l7Zg2X9dkI4wmEDSVjT5khnAed2u3K/rbdhjFpSI8PBXxeyvV9RmQtdTdU6ilEuh5T5
         1RvA1+MT+BQ+oaSrx3O1S175GLqCQr/2wmrVXaLo17Y2yir2g2ReSsNRhCQOCqYPQD1u
         CQ64X3ERpZH7ILFCIiVyC7eP6P2GMrzgraS3QAGcqhA6WXt5yGAbLe7yL17JiXEaw5NI
         27Vow0q7PDtieqQyN0TwyzeL2dExCyHf5frod9uAWp3oJmz2bXsph9KKCMcHiRyA3AlH
         tLwA==
X-Gm-Message-State: AOJu0Yydkvpzh27fDUpGBO+auwbpnVWjjcfyD6WUN8rtPAt+TBbS0RwU
	XLwTxhS9SrjJWUYAW9JBymtaMajMGSzZKjJ7cTWwZrSrK7THLc8zK0XXv9LXXw0=
X-Google-Smtp-Source: AGHT+IGrtWjtzyvj+Hm22LPx5bBVA0U04s7bVW5RkMynb/rKr3pASx+y7bLB0PWoE782ZxNBvdLU/g==
X-Received: by 2002:ac2:48a7:0:b0:513:9f13:b3a1 with SMTP id u7-20020ac248a7000000b005139f13b3a1mr3286442lfg.56.1710160363495;
        Mon, 11 Mar 2024 05:32:43 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id fa5-20020a05600c518500b00413298e9c8esm3741892wmb.35.2024.03.11.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:32:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 13:32:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/build changes for v6.9
Message-ID: <Ze756cuF2NTFxH3/@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-03-11

   # HEAD: 103bf75fc928d16185feb216bda525b5aaca0b18 x86: Do not include <asm/bootparam.h> in several files

x86/build changes for v6.9:

- Reduce <asm/bootparam.h> dependencies
- Simplify <asm/efi.h>
- Unify *_setup_data definitions into <asm/setup_data.h>
- Reduce the size of <asm/bootparam.h>

 Thanks,

	Ingo

------------------>
Thomas Zimmermann (4):
      x86/setup: Move UAPI setup structures into setup_data.h
      x86/setup: Move internal setup_data structures into setup_data.h
      x86/efi: Implement arch_ima_efi_boot_mode() in source file
      x86: Do not include <asm/bootparam.h> in several files


 arch/x86/Makefile                      |  3 ++
 arch/x86/boot/compressed/acpi.c        |  2 +
 arch/x86/boot/compressed/cmdline.c     |  2 +
 arch/x86/boot/compressed/efi.c         |  2 +
 arch/x86/boot/compressed/efi.h         |  9 ----
 arch/x86/boot/compressed/pgtable_64.c  |  1 +
 arch/x86/boot/compressed/sev.c         |  1 +
 arch/x86/include/asm/efi.h             | 14 ++----
 arch/x86/include/asm/kexec.h           |  1 -
 arch/x86/include/asm/mem_encrypt.h     |  2 +-
 arch/x86/include/asm/pci.h             | 13 ------
 arch/x86/include/asm/setup_data.h      | 32 +++++++++++++
 arch/x86/include/asm/sev.h             |  3 +-
 arch/x86/include/asm/x86_init.h        |  2 -
 arch/x86/include/uapi/asm/bootparam.h  | 72 +----------------------------
 arch/x86/include/uapi/asm/setup_data.h | 83 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/crash.c                |  1 +
 arch/x86/kernel/sev-shared.c           |  2 +
 arch/x86/platform/efi/efi.c            |  5 ++
 arch/x86/platform/pvh/enlighten.c      |  1 +
 arch/x86/xen/enlighten_pvh.c           |  1 +
 arch/x86/xen/vga.c                     |  1 -
 22 files changed, 143 insertions(+), 110 deletions(-)
 create mode 100644 arch/x86/include/asm/setup_data.h
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h


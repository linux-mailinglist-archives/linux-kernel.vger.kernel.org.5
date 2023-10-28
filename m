Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699D7DA721
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjJ1NLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjJ1NLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:11:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D3EDE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:11:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so5013278a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698498663; x=1699103463; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xIsnpE2JOsuVctEfi+f518i8m+i4X0nllufFkwGJDhQ=;
        b=IIC7EFflAoWtLb0GqtbLuqfBesuC2uK4VYJ5D/7e8SpGWUCr9K6OvOBcMX4vRJMq8L
         okR5qT1UDw+LM7xbwm9JoGZFRfFFDG91uxFibrsV+2wRmDSoyNTOhogSw85Qx7SO8yg5
         SOm+ZlnCXIuj8ebKXlvDgd6745PYq6sLjBks1gsfbl4qhnMBub25wGyt2uQrCiYi4ttg
         fnzJNVlFYUGtLUP2APmtaVTwHyWZSlTdjeM9FLqIuiW5oGTNFc1tE0mAQ0sPUiqKF5fk
         aYDfhhtfhnm0ZG44JIFcDt0yPDZrc/eCI4eJRCXl4Uo/sUEQQq+wcDKyfETr4UEHLA5w
         fnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698498663; x=1699103463;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIsnpE2JOsuVctEfi+f518i8m+i4X0nllufFkwGJDhQ=;
        b=ggCgopDI1od/byY860MwgyTjoO1afKwUbGauCwVwApVdJ/JBxFrj9WDXl29ml5BehX
         hPqwTrfHnxF2Yq5K8MDw4+fufK6Jc+7Qyq3rTD13lk2nBiID53w2mBxdYWM8ZYKRGd4o
         DE4x/UZey46QK6twUN5Xr6z1UKW1DkXdwtgEC3Jfxi8Aqr6kkifPLMoNkVkYpGfrK+3d
         sLH5Huss5xe0WCBcKSRg5ihYxZmh/mwq9b8IJtNI8FNpkgVhZacVwlD48ueybP4QE9qT
         Xvu6UzEBmJKJJUNtky9gKyWEBb5ljoJ19/wthTxOqW041KAPyzSp98DuerwslbRlznhS
         ueGQ==
X-Gm-Message-State: AOJu0YxlwQdcKGUBdb2dC0fxv7+ek/HEuCuemGa4yv9KI/aI8Pfl/gbp
        YmzebyVnNgnCUwIHHnf+CjhacfWSblY=
X-Google-Smtp-Source: AGHT+IFNaKXZEcQlcZYO8E+YMWxI+SYYpiPAFA4cLCGzapdSCRKGP7Ap831jBbNf3LiJwkf9IkgqPA==
X-Received: by 2002:a17:907:c293:b0:9be:d55a:81ba with SMTP id tk19-20020a170907c29300b009bed55a81bamr4560937ejc.65.1698498662741;
        Sat, 28 Oct 2023 06:11:02 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090613ca00b00992b8d56f3asm2769682ejc.105.2023.10.28.06.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:11:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:10:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] x86/boot changes for v6.7
Message-ID: <ZT0IY1INe8Jls7EC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-10-28

   # HEAD: 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52 x86/boot: efistub: Assign global boot_params variable

MERGE NOTE:

 - Pulling this tree will generate a conflict in 
   drivers/firmware/efi/libstub/x86-stub.c, due to a fix we wanted upstream 
   without related cleanups, which is resolved by picking this resolution:

        boot_params_ptr = boot_params;

Changes to the x86 boot code in v6.7:

 - Rework PE header generation, primarily to generate a modern, 4k aligned
   kernel image view with narrower W^X permissions.

 - Further refine init-lifetime annotations

 - Misc cleanups & fixes

 Thanks,

	Ingo

------------------>
Alexey Dobriyan (1):
      x86/boot: Compile boot code with -std=gnu11 too

Ard Biesheuvel (17):
      x86/efi: Drop EFI stub .bss from .data section
      x86/efi: Disregard setup header of loaded image
      x86/efi: Drop alignment flags from PE section headers
      x86/boot: Remove the 'bugger off' message
      x86/boot: Omit compression buffer from PE/COFF image memory footprint
      x86/boot: Drop redundant code setting the root device
      x86/boot: Drop references to startup_64
      x86/boot: Grab kernel_info offset from zoffset header directly
      x86/boot: Set EFI handover offset directly in header asm
      x86/boot: Define setup size in linker script
      x86/boot: Derive file size from _edata symbol
      x86/boot: Construct PE/COFF .text section from assembler
      x86/boot: Drop PE/COFF .reloc section
      x86/boot: Split off PE/COFF .data section
      x86/boot: Increase section and file alignment to 4k/512
      x86/boot: Rename conflicting 'boot_params' pointer to 'boot_params_ptr'
      x86/boot: efistub: Assign global boot_params variable

Hou Wenlong (3):
      x86/head/64: Mark 'startup_gdt[]' and 'startup_gdt_descr' as __initdata
      x86/head/64: Add missing __head annotation to startup_64_load_idt()
      x86/head/64: Move the __head definition to <asm/init.h>

Wang Jinchao (1):
      x86/boot: Harmonize the style of array-type parameter for fixup_pointer() calls

Yuntao Wang (1):
      x86/boot: Fix incorrect startup_gdt_descr.size


 arch/x86/Makefile                       |   2 +-
 arch/x86/boot/Makefile                  |   2 +-
 arch/x86/boot/compressed/acpi.c         |  14 +-
 arch/x86/boot/compressed/cmdline.c      |   4 +-
 arch/x86/boot/compressed/ident_map_64.c |   7 +-
 arch/x86/boot/compressed/kaslr.c        |  26 +--
 arch/x86/boot/compressed/mem.c          |   6 +-
 arch/x86/boot/compressed/misc.c         |  24 +--
 arch/x86/boot/compressed/misc.h         |   1 -
 arch/x86/boot/compressed/pgtable_64.c   |   9 +-
 arch/x86/boot/compressed/sev.c          |   2 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +-
 arch/x86/boot/header.S                  | 213 ++++++++++---------------
 arch/x86/boot/setup.ld                  |  14 +-
 arch/x86/boot/tools/build.c             | 273 ++------------------------------
 arch/x86/include/asm/boot.h             |   2 +
 arch/x86/include/asm/init.h             |   2 +
 arch/x86/kernel/head64.c                |  17 +-
 drivers/firmware/efi/libstub/Makefile   |   7 -
 drivers/firmware/efi/libstub/x86-stub.c |  48 +-----
 20 files changed, 175 insertions(+), 504 deletions(-)

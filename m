Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26E7EA8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjKNDC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:02:26 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCD7C5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:23 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7eef0b931so59737107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699930942; x=1700535742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MxRfexvdTG0ppUiwHVD4kW4+CfwUo1gfUnj1LiwzgF0=;
        b=fkoIROk8wlohEg4FXWzBcDIIWSD3IVpDOI/x97KfcB4FTfsNxzyTiEActwRKMgiPZQ
         YvNCUMBDFmJc12tzybZT9Nm470CR4ki21SOnQJpxybNsNbFpVfiEQyKBTruAe6eGG2gb
         O4PgJJHGtFt17mAhmg4gBnLQ3u6Gk2Pxiyp6foPjqQphcjNrzMrSymwOx7X4OZJGh/LA
         nwFCgJRhXtu+bewW6QAJuaYHBPForSnLSAEpiVUHGd9UHCcU7fk1O3/ZJ13PUdF5w5nG
         CRdizjx9hmSk0rHhmodEjpxrZpSmBKUjRJ/qmT9f5tpu2fxO3YnGsmeuctCRyiWJhgd/
         1gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930942; x=1700535742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxRfexvdTG0ppUiwHVD4kW4+CfwUo1gfUnj1LiwzgF0=;
        b=Wi79kL1vlhQRF5UU9hIzS8gLvrgOiUKFcBp5EK3JTFpuR8N6Zj9Hcz8WLna1+RKguS
         XlVGyXjgN0yt8HmGDkJYBFv2t7MMGTzc8wRUso1JAe0gYCOUGcP4OmfytsYXXkBlX/53
         gzDXM7Lz73eZk2NDbp9jupE4+RszQP3D0fJC28lUyqTschqKsiNQoInZ5afNLI4OjkKM
         B+fNVZl6mQDPsM6MDYUczk8qaE8Upi+t7YuefS2BpqLJM7daChjli/2bmfaUj4A2deBA
         oLk+ZPTiA9MbYGabb6zGlKb/AXVzRZNZTqyVhMC1AMojQEG+XDAK1vK3Ns47NvdRFI8A
         KE7g==
X-Gm-Message-State: AOJu0YzWIMtr77j6fDmBT2dPIhtZBD8cyru926Ihy7mJYdgOtjd4Mpm6
        UiKaQCIUeQLy9nRDHnx/EP8SPw==
X-Google-Smtp-Source: AGHT+IFC3tpIR4sj7RNXgZigkVbpZ5ErE6mGenHyxA0FQbGMhLj1TiFAeySkioIuCtraqID4ZNCcNw==
X-Received: by 2002:a25:aa24:0:b0:d9b:4f28:f6ce with SMTP id s33-20020a25aa24000000b00d9b4f28f6cemr7822239ybi.1.1699930942434;
        Mon, 13 Nov 2023 19:02:22 -0800 (PST)
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::4174])
        by smtp.gmail.com with ESMTPSA id x6-20020a25a006000000b00daf78e2e63dsm1403315ybh.27.2023.11.13.19.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 19:02:22 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, ardb@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v3 1/2] docs: admin-guide: Update bootloader and installation instructions
Date:   Mon, 13 Nov 2023 22:02:07 -0500
Message-ID: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the bootloader and installation instructions in
admin-guide/README.rst to align with modern practices.

Details of Changes:

 - Added guidance on using EFISTUB for UEFI/EFI systems.
 - Noted that LILO is no longer in active development and provides
   alternatives.
 - Kept LILO instructions but marked as Legacy LILO Instructions.
   Suggest removal in future patch.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 Documentation/admin-guide/README.rst | 69 ++++++++++++++++++----------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 9a969c0157f1..ad53f4245379 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -262,9 +262,11 @@ Compiling the kernel
  - Make sure you have at least gcc 5.1 available.
    For more information, refer to :ref:`Documentation/process/changes.rst <changes>`.
 
- - Do a ``make`` to create a compressed kernel image. It is also
-   possible to do ``make install`` if you have lilo installed to suit the
-   kernel makefiles, but you may want to check your particular lilo setup first.
+ - Do a ``make`` to create a compressed kernel image. It is also possible to do
+   ``make install`` if you have lilo installed or if your distribution has an
+   install script recognised by the kernel's installer. Most popular
+   distributions will have a recognized install script. You may want to
+   check your distribution's setup first.
 
    To do the actual install, you have to be root, but none of the normal
    build should require that. Don't take the name of root in vain.
@@ -301,32 +303,51 @@ Compiling the kernel
    image (e.g. .../linux/arch/x86/boot/bzImage after compilation)
    to the place where your regular bootable kernel is found.
 
- - Booting a kernel directly from a floppy without the assistance of a
-   bootloader such as LILO, is no longer supported.
-
-   If you boot Linux from the hard drive, chances are you use LILO, which
-   uses the kernel image as specified in the file /etc/lilo.conf.  The
-   kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
-   /boot/bzImage.  To use the new kernel, save a copy of the old image
-   and copy the new image over the old one.  Then, you MUST RERUN LILO
-   to update the loading map! If you don't, you won't be able to boot
-   the new kernel image.
-
-   Reinstalling LILO is usually a matter of running /sbin/lilo.
-   You may wish to edit /etc/lilo.conf to specify an entry for your
-   old kernel image (say, /vmlinux.old) in case the new one does not
-   work.  See the LILO docs for more information.
-
-   After reinstalling LILO, you should be all set.  Shutdown the system,
+ - Booting a kernel directly from non-volatile memory (e.g. a hard drive)
+   without the assistance of a bootloader such as LILO or GRUB, is no longer
+   supported in BIOS (non-EFI systems). On UEFI/EFI systems, however, you can
+   use EFISTUB which allows the motherboard to boot directly to the kernel.
+   On modern workstations and desktops, it's generally recommended to use a
+   bootloader as difficulties can arise with multiple kernels and secure boot.
+   For more details on EFISTUB,
+   see :ref:`Documentation/admin-guide/efi-stub.rst <efi_stub>`.
+
+ - It's important to note that as of 2016 LILO (LInux LOader) is no longer in
+   active development, though as it was extremely popular, it often comes up
+   in documentation. Popular alternatives include GRUB2, rEFInd, Syslinux,
+   systemd-boot, or EFISTUB. For various reasons, it's not recommended to use
+   software that's no longer in active development.
+
+ - Chances are your distribution includes an install script and running
+   ``make install`` will be all that's needed. Should that not be the case
+   you'll have to identify your bootloader and reference its documentation or
+   configure your EFI.
+
+Legacy LILO Instructions
+------------------------
+
+
+ - If you use LILO the kernel images are specified in the file /etc/lilo.conf.
+   The kernel image file is usually /vmlinuz, /boot/vmlinuz, /bzImage or
+   /boot/bzImage. To use the new kernel, save a copy of the old image and copy
+   the new image over the old one. Then, you MUST RERUN LILO to update the
+   loading map! If you don't, you won't be able to boot the new kernel image.
+
+ - Reinstalling LILO is usually a matter of running /sbin/lilo. You may wish
+   to edit /etc/lilo.conf to specify an entry for your old kernel image
+   (say, /vmlinux.old) in case the new one does not work. See the LILO docs
+   for more information.
+
+ - After reinstalling LILO, you should be all set. Shutdown the system,
    reboot, and enjoy!
 
-   If you ever need to change the default root device, video mode,
-   etc. in the kernel image, use your bootloader's boot options
-   where appropriate.  No need to recompile the kernel to change
-   these parameters.
+ - If you ever need to change the default root device, video mode, etc. in the
+   kernel image, use your bootloader's boot options where appropriate. No need
+   to recompile the kernel to change these parameters.
 
  - Reboot with the new kernel and enjoy.
 
+
 If something goes wrong
 -----------------------
 
-- 
2.42.1


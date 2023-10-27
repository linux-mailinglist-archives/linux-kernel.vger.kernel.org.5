Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A87D8F50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbjJ0HMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbjJ0HMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:12:14 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4B1B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:12:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7a80a96dbso25256497b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1698390729; x=1698995529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+6JYgipUnQgerpfSAZJhJWQAoUFv0R8N4KbRED7JZQ=;
        b=TFCD76bJTTOalpacrGDiroB5VMGipJfvRCcoS4KeINJS5TTgbXmohr2oxib0cAi0ei
         a8pbdhf69J58NSrguYPHt7rIXNWYGLER5LVSZ2CyNM7kKT6biCY2/Zf4nMQp0tcjzwww
         A/D3KmEhev2iOCkXX2KJcEM96XGM6TTXKWtAlNWtrpTs0tkGqOQIp2FH5A83ZdkgvXRF
         Fzy7efg0DNjlVE3aWFLDLDTdizbr2dXXerI7cVO2mf2aTSaZnLxvNvNgminGoWCJJvZV
         lAQ65zckZMURRRH3ojmqZI9Tioq6vC5wfNKU6WHt8Kv3dStRa3c4UP3bP6PuBH6aTIPj
         UMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698390729; x=1698995529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+6JYgipUnQgerpfSAZJhJWQAoUFv0R8N4KbRED7JZQ=;
        b=kr0WHmm6Zaha7mWd/gJ2gKOCDpzw2WCLcP20TlOp4eRyVyLYQfhes/zXjgUFs1YdoO
         4X29aJoc8dlDme2c2/ddUBdqLHTWCkYgswIwZUrGvXA9AkqtMljTttogJLzkTkciFaQ8
         fh2/yVWHmlW+kNF1sCxF5ruWZd1nu90gGE/+86Q9BmCMhsSbN4yaBCGIQoMSly2jZxJQ
         6ZeUc1uYZk3fUx+JTRjWrw9jV5mXi2d+iGzBn472I4jUgOGV58oS3Jwkn9Xxb+Khg2Nn
         C/AjdsG6qO0lkIRtThMIoARORUoKFIILuh9Ww0va9HOlSOflvEHpiO3wfyy4gH6j5v/g
         sa0Q==
X-Gm-Message-State: AOJu0YxVT1B9alKXKMb/grf8Gp91LmTt/4d0f4vEL0gACKvRiIPLzyVt
        Th9T1mYHyug8eidFvdw5nkw+Kw==
X-Google-Smtp-Source: AGHT+IHvdAkBZzWU1B2W3UZIJe4fOzPtPabGLh4BLEloqyWPxNLz0AqTXTb8jdpqdBuef0Rj8uzHkg==
X-Received: by 2002:a81:98d0:0:b0:5a7:fb66:61ff with SMTP id p199-20020a8198d0000000b005a7fb6661ffmr3214326ywg.21.1698390729204;
        Fri, 27 Oct 2023 00:12:09 -0700 (PDT)
Received: from fedora.hsd1.fl.comcast.net ([2601:580:8201:d0::6331])
        by smtp.gmail.com with ESMTPSA id w5-20020a0dd405000000b005a7ba08b2acsm477230ywd.0.2023.10.27.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 00:12:08 -0700 (PDT)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v2] docs: admin-guide: Update bootloader and installation instructions
Date:   Fri, 27 Oct 2023 03:12:02 -0400
Message-ID: <20231027071202.60888-1-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the bootloader and installation instructions in admin-guide/README.rst
to align with modern practices.

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
index 9a969c0157f1..eb25a0e0e741 100644
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
+   see :ref:`Documentation/admin-guide/efi-stub.rst`.
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
2.41.0


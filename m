Return-Path: <linux-kernel+bounces-6749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1A819CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435D1288747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A21A20B1C;
	Wed, 20 Dec 2023 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDa17dwM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665920B04
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4646139276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703068395; x=1703673195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qtNcAO0ppjHzZIU/hLis0rkAchUbEqDdoUufrmlDX0=;
        b=mDa17dwMLTzXf77SHxXF9lgsZws9smAt1eOg5Ns607VYvwVwZ+4XMHf0iBcGRHUyvq
         Lveo7h/fVsOQiqo0djpoblWhY82lSyTGybrYCzNjUgEIXmLNbh66lek4locd3uPGJWLe
         H0Y1eHP5l4W71B3DTRmFVq5++a1+pB7o9mWet5XaudDT/ubjqxXR3rNO1afpmc7r0mOG
         dJ0MBDPt1QPpri4Owzb7tHwGL6/DxJ4eXdIuFXLqPgwjGVyW8RYV6jCXQYCz6nxFvenZ
         VKoO6++UcBhrZgdYFUXOHQiMOO5T2QGYLz9MY5xkXXiFdBdT6zyDXvH1wDVlnF5Ar02t
         l5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703068395; x=1703673195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qtNcAO0ppjHzZIU/hLis0rkAchUbEqDdoUufrmlDX0=;
        b=M+PCiZB0y9ujKdFtTWpoMakPPVBc9+NrvFHXWoI7Bsk/9aG114mczhDyNUSbJMY/nF
         tASElb0+shRd1IOswdL/uFvXHMw2KPnZlqtFOaKPD+ffli4xSQ7Y5I3hxzL49vl5tkBk
         Rih7O5ueMdTZVtHBTcW5azFdHNzTZ1d5NjHWP7V5LYfwZpsR3/IU2slKBggHyTIixm/x
         wm1jeIeuLg5sDEaeuR9ghaMaRWzEds/Nwlc99OGdgUoU1X/JNRY4XjtBYQjUbM3BsN/x
         ykrx8mbMLQB/kh7Sou+JP+nb+X62uPaznNdCRG7FDUqvXIFuRzW+GLZbrfHHdrEOS3nx
         /5Mg==
X-Gm-Message-State: AOJu0YwZ73p4XsyUz08DcYATDd9cVbSxDtoRyyC9uDVbDzBX7kJfbRV0
	nS0MHnVH0omZaAMLTbwJ4bs=
X-Google-Smtp-Source: AGHT+IGltqE3mhfDTpX2ZubomA1b4Gz5wqV0QU/3fPg57T0EDcXEp34TAlIlxzW1ghHYw+jsi8BlCw==
X-Received: by 2002:a25:ab86:0:b0:dbd:4fae:cf79 with SMTP id v6-20020a25ab86000000b00dbd4faecf79mr1977544ybi.129.1703068395043;
        Wed, 20 Dec 2023 02:33:15 -0800 (PST)
Received: from localhost ([185.215.181.26])
        by smtp.gmail.com with ESMTPSA id t49-20020a25aab4000000b00dbd15c3b753sm345116ybi.46.2023.12.20.02.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:33:14 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: kevinmbecause@gmail.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firmware_loader: Enable compressed files in EXTRA_FIRMWARE
Date: Wed, 20 Dec 2023 05:29:33 -0500
Message-ID: <cd370037f8c21dc851a2a33a07250459c9c98708.1703042082.git.kevinmbecause@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1703042081.git.kevinmbecause@gmail.com>
References: <cover.1703042081.git.kevinmbecause@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-firmware packages on Gentoo, Fedora, Arch, and others compress
the firmware files. This works well with CONFIG_FW_LOADER_COMPRESS, but
does not work with CONFIG_EXTRA_FIRMWARE. This patch allows the build
system to decompress firmware files specified by CONFIG_EXTRA_FIRMWARE.
Uncompressed files are used first, then the compressed files are used.

Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
---
 drivers/base/firmware_loader/Kconfig          |  5 ++++-
 drivers/base/firmware_loader/builtin/Makefile | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5ca00e02f..b7a908bff 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -76,7 +76,10 @@ config EXTRA_FIRMWARE
 	  image since it combines both GPL and non-GPL work. You should
 	  consult a lawyer of your own before distributing such an image.
 
-	  NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
+	  NOTE: Compressed files are supported by EXTRA_FIRMWARE. The build
+	  system will look for uncompressed files first then fall back to
+	  searching for compressed files in a similar way to
+	  CONFIG_FW_LOADER_COMPRESS.
 
 config EXTRA_FIRMWARE_DIR
 	string "Firmware blobs root directory"
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 6c067dedc..cc60eb441 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -20,7 +20,7 @@ filechk_fwbin = \
 	echo "    .section .rodata"				;\
 	echo "    .p2align 4"					;\
 	echo "_fw_$(FWSTR)_bin:"				;\
-	echo "    .incbin \"$(fwdir)/$(FWNAME)\""		;\
+	echo "    .incbin \"$(obj)/$(FWNAME)\""		;\
 	echo "_fw_end:"						;\
 	echo "    .section .rodata.str,\"aMS\",$(PROGBITS),1"	;\
 	echo "    .p2align $(ASM_ALIGN)"			;\
@@ -36,7 +36,15 @@ $(obj)/%.gen.S: FORCE
 	$(call filechk,fwbin)
 
 # The .o files depend on the binaries directly; the .S files don't.
-$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(fwdir)/%
+$(addprefix $(obj)/, $(firmware)): $(obj)/%.gen.o: $(obj)/%
 
-targets := $(patsubst $(obj)/%,%, \
-                                $(shell find $(obj) -name \*.gen.S 2>/dev/null))
+$(obj)/% : $(fwdir)/% FORCE
+	$(call if_changed,copy)
+
+$(obj)/% : $(fwdir)/%.xz FORCE
+	$(call if_changed,xzdec)
+
+$(obj)/% : $(fwdir)/%.zst FORCE
+	$(call if_changed,zstddec)
+
+targets := $(patsubst %.gen.o, %.gen.S, $(firmware)) $(CONFIG_EXTRA_FIRMWARE)
-- 
2.41.0



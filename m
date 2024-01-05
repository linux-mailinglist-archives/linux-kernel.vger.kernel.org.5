Return-Path: <linux-kernel+bounces-17503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E78824E87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B931F23613
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CA8C1C;
	Fri,  5 Jan 2024 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/HV0Tu1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20120B18;
	Fri,  5 Jan 2024 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f0629e67f4so13210907b3.3;
        Thu, 04 Jan 2024 22:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704435062; x=1705039862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/8wADJCHmKaP0nscCPSIHPeX/XbN8JppbCl8vTI+Hc=;
        b=X/HV0Tu1DNS7VgOpfFEywHBHAA9Y2gFgi8t/Cl5CjPZkPAuAYCW0smHDHgsdVwRB26
         r6NT183UcS8C7fvrI1Q+RB5v1z0XPMxuE8L8PXW96P9KlW51CPSBXZB7TxQMIyhu3u/N
         z2rD0y/MajC6jOyzaNkJvEpd1Yz7ak47+WmZmSz5tGKdcvt3H4U+k8wgZzyucj6552gU
         W7V7KGEA7VS688EsKgtrbSLJA5nqsN/NGspaT3RlXmbuRV2tTsbi7ALRu8vTpa4tusBq
         P1uhRNHyf0e4qwHJQose+i0t5EHcaeH92EvVVDiXY+tkRNd4df1cC7M5Ky5N1pjZ9lgH
         30XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704435062; x=1705039862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/8wADJCHmKaP0nscCPSIHPeX/XbN8JppbCl8vTI+Hc=;
        b=SKnKrlq3PDXyhW2Fn+c9+X4Ow1rTkMo7yjrNpb+nna17tAAIWRkJu+SkkSHypnGkDl
         lKRbEXVwHwrq07bkmAvQnO1YH7WHyW2oyfWGeChEhwNUNVm/k6CEQRuHQ+UfClAhU7oR
         kf056slPZBXLSsbEvGVKZeATe9rw2KDEWHzWf3NUpt6bvYKlVotu+suo1DRJozUaWL2L
         qV8Us0+znM4U819bLDcD6tUHL6oa8jhCi1UbLpsmMtFiUEUL4RYzlXt4YdlKQHskSBCu
         aUd9K818OGW/tX0w3iPmVukSesc53WCJJuxPjhNMcewlTlhEUQBa4yAy/pXv8llzJyIo
         f5zg==
X-Gm-Message-State: AOJu0YwTxAdCh8uNwYjHO1CSVsSeEg7FNhlqpUJhIMyl9vDWjj6id9QP
	mZNbokkcXxKWuAf/pci1ljm+7gZy8vWkFg==
X-Google-Smtp-Source: AGHT+IFQ/pOTdieaV63j+OiSy0l8zP9+yVfQTdlRrZJJGPYwkChwOgfSJTbgrxOQTqFKKIRf1Q25jQ==
X-Received: by 2002:a0d:d145:0:b0:5e7:6526:91da with SMTP id t66-20020a0dd145000000b005e7652691damr1766599ywd.23.1704435062364;
        Thu, 04 Jan 2024 22:11:02 -0800 (PST)
Received: from localhost ([185.215.181.31])
        by smtp.gmail.com with ESMTPSA id q1-20020a0dce01000000b005f134299392sm409764ywd.52.2024.01.04.22.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 22:11:02 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Martin <kevinmbecause@gmail.com>
Subject: [PATCH v2 1/2] kbuild: Enable decompression for use by EXTRA_FIRMWARE
Date: Fri,  5 Jan 2024 01:10:01 -0500
Message-ID: <941a566eb114701685dc44f708f81891b3bd085b.1704353568.git.kevinmbecause@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1704353568.git.kevinmbecause@gmail.com>
References: <cover.1704353568.git.kevinmbecause@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The build system can currently only compress files. This patch adds the
functionality to decompress files. Decompression is needed for building
firmware files into the kernel if those files are compressed on the
filesystem. Compressed firmware files are in use by Gentoo, Fedora, Arch,
and others.

Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
---
Changes in v2:
- Skipped running 'cat' and now just pass the file names directly.
- Added '--quiet' since 'zstd' started printing the status of each file
now that it knows the file names.

 scripts/Makefile.lib | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68..d043be3dc 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -523,6 +523,9 @@ quiet_cmd_xzkern_with_size = XZKERN  $@
 quiet_cmd_xzmisc = XZMISC  $@
       cmd_xzmisc = cat $(real-prereqs) | $(XZ) --check=crc32 --lzma2=dict=1MiB > $@
 
+quiet_cmd_xzdec = XZDEC   $@
+      cmd_xzdec = $(XZ) --decompress --stdout $< > $@
+
 # ZSTD
 # ---------------------------------------------------------------------------
 # Appends the uncompressed size of the data using size_append. The .zst
@@ -548,6 +551,9 @@ quiet_cmd_zstd22 = ZSTD22  $@
 quiet_cmd_zstd22_with_size = ZSTD22  $@
       cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
 
+quiet_cmd_zstddec = ZSTDDEC $@
+      cmd_zstddec = $(ZSTD) --decompress --force --quiet -o $@ $<
+
 # ASM offsets
 # ---------------------------------------------------------------------------
 
-- 
2.41.0



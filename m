Return-Path: <linux-kernel+bounces-6740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9AB819CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706731F26ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E32031D;
	Wed, 20 Dec 2023 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNQmNImu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D22031F;
	Wed, 20 Dec 2023 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e76948cda7so19978727b3.3;
        Wed, 20 Dec 2023 02:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703068015; x=1703672815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G9gIUzWq3S9DwN1F69m6K2FJSCQp0rMkcWT18Ovi08=;
        b=eNQmNImu26BPPuBy/6X19L7Xisfn+azCSQHpzTUjJXh07vZMx38bF4uEYCiUuNBbKl
         Ga0YSuptMrTKMNbiCdIVZp2cWQj+vWX54UxXNIcXchUlraQNC45R4J9FHa7h/POa3QhE
         Vls2SAvJzlecr9SdmF8HGwczSP4ScUHDm6SS76yWZmslIVU0I8UHKeplrouz4m+/bekh
         5Aaaj13FcnSBIam9h2/etYD7H+a1EkPBZZRH3d9UUoxlVjyxd7F1aLl/+oiFw8lZtA3C
         f/CcYpjldIl5/DfIo6axfGbWAKBeN4TjG7AeIjcZqbsi6ffqEvT2pAPx9xQTyFyJPf6K
         YFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703068015; x=1703672815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G9gIUzWq3S9DwN1F69m6K2FJSCQp0rMkcWT18Ovi08=;
        b=AcCMQoQA7catzKdwoKn4i0KJqAwyDt+51twcjPWNfJMrsZWHVH1YKhfYueFYz7O9o5
         KA9qjkYRruxQjaSvnlHY2QJnOZ+qxRt/ogA1hdbIjIxxZhOXRVdHA27pS0DqQYE2QI4v
         TxFOu+TjeJJ/cIU2JV/HDqrCkpogLz7pXzOg27Yi/HGNZxqroPLz29h7g+/fmxsV/VPH
         BbQz/HkXpepRSbsisjf6DgEFqIJYJvoGALnTAm5ehOQi+eoU//wXcryrQRucZzwhCctR
         /3LIfYDheWh5LjJfr4fESRgi5xsTiMVsyY8vTlZ+CrDKfPWYZ5boHSPWdI8BGCgc7x8b
         sm0A==
X-Gm-Message-State: AOJu0YxwnnbGISeRbe/l9LdG9u4PNUAtDJ7XYqNtAa3g6hMe+DWP/uAO
	/DFVuS/PQ1Z0pVjgigCN+pY=
X-Google-Smtp-Source: AGHT+IE5kuECq0tf9IoykfQ1vj1ZjrW3n5l/zY4+sxIrvh7b/PxjVBv3CE9zlOGzTuUDQnzNpQG9wQ==
X-Received: by 2002:a05:6902:534:b0:db7:dacf:ed96 with SMTP id y20-20020a056902053400b00db7dacfed96mr11216655ybs.119.1703068014962;
        Wed, 20 Dec 2023 02:26:54 -0800 (PST)
Received: from localhost ([185.215.181.26])
        by smtp.gmail.com with ESMTPSA id w6-20020a25ef46000000b00db5380fc1absm1322769ybm.19.2023.12.20.02.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:26:54 -0800 (PST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: joeyzerocrash@protonmail.com,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Martin <kevinmbecause@gmail.com>
Subject: [PATCH 1/2] kbuild: Enable decompression for use by EXTRA_FIRMWARE The build system can currently only compress files. This patch adds the functionality to decompress files. Decompression is needed for building firmware files into the kernel if those files are compressed on the filesystem. Compressed firmware files are in use by Gentoo, Fedora, Arch, and others.
Date: Wed, 20 Dec 2023 05:22:50 -0500
Message-ID: <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
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

Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
---
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
+      cmd_xzdec = cat $(real-prereqs) | $(XZ) --decompress > $@
+
 # ZSTD
 # ---------------------------------------------------------------------------
 # Appends the uncompressed size of the data using size_append. The .zst
@@ -548,6 +551,9 @@ quiet_cmd_zstd22 = ZSTD22  $@
 quiet_cmd_zstd22_with_size = ZSTD22  $@
       cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
 
+quiet_cmd_zstddec = ZSTDDEC $@
+      cmd_zstddec = cat $(real-prereqs) | $(ZSTD) --decompress > $@
+
 # ASM offsets
 # ---------------------------------------------------------------------------
 
-- 
2.41.0



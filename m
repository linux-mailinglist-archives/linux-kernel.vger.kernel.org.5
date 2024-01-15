Return-Path: <linux-kernel+bounces-25562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6082D2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497C11C20A84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402FA3D;
	Mon, 15 Jan 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCge9Hwl"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF17E5;
	Mon, 15 Jan 2024 00:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabd1c701so9879776e87.3;
        Sun, 14 Jan 2024 16:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705277826; x=1705882626; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8qRzLu2QfiYFCgn0VSRgtOrUr1VXFFkr88Zi/Lqch4=;
        b=MCge9Hwl1iI0rZ6OhdMElwbvnoIk3KW+tr7udKXJByQ9uERr3oHJA1WpCnJcqE2nA+
         w3oP13MW9axRM+eR/YOwsbAXZjEZyMEKpr3i8aj7s2NkcSxiktxDJcYKJDzxFSnsl4+t
         Y81deuSVIvwivaqVyEaXw+dlTdKX4tAnZnhKTLe+59PLmshjp3s336GWsfotiKiERDSr
         KcgzzBWjxF5CeoTea3BNKyydDTM7UY6Puc3FM8gzXIQRJ3BsY05w+S20x2KOvHC2kCDX
         evkwV4gHxXsQlYpqL9UfhmNrEhvKBaSVrF96zoc7k/M7gadAaL/j7GZkRWnVIEyqmHQu
         sPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705277826; x=1705882626;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8qRzLu2QfiYFCgn0VSRgtOrUr1VXFFkr88Zi/Lqch4=;
        b=iADgcCXIawGUWJZ8ii8jFwXk4OocJHrZw8th0XHKtA8d/Hf4/u0Q7IHm54VLbEgg52
         wrRXGcBPs+okRCiJDtb29z8WMWlBRHlOc91vQEXcEUd0jkGTmQwqjv42X0eIqEuYs5ag
         BTNc3Gw3vJnyBSxgq4732SoIuThVzOuQl/w7S2EEnR3h6uo4kV31eZCzHXeIalqjvGyj
         ax4uklbjT51N1V2zjVcjxAt8u1yewuWa2IUPLmR27+7j6moyryhBFO6+ho+VybTQNSla
         qXwxN+gDInwbvgEbWE1Nb2TzRujzoku4R6Aweu8z2uGJHJ5L5BNS0HaJSGWxjm0KadfJ
         z7Kg==
X-Gm-Message-State: AOJu0YyiJcxWHkyPzdICDiVxNLSBV1OpVxNHTeZSyq+IRkcwUx4ibdcH
	qx3CtOIFpYubDcgJuFthVeE=
X-Google-Smtp-Source: AGHT+IHX76/xBqwm06VH93U471uaG12CWhzjYyrX7DfDHbI3X3wL3qhyEw+rrbqvcJM/ScLZ98AFxQ==
X-Received: by 2002:ac2:4247:0:b0:50e:cccb:f5f2 with SMTP id m7-20020ac24247000000b0050ecccbf5f2mr1998756lfl.56.1705277826081;
        Sun, 14 Jan 2024 16:17:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b00a2ae69cca5asm4712357ejf.144.2024.01.14.16.17.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Jan 2024 16:17:05 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] kbuild: take vmlinux.[ao] out of single-targets
Date: Mon, 15 Jan 2024 00:16:06 +0000
Message-Id: <20240115001606.15477-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For current kernel, when we make vmlinux.a or vmlinux.o, following
message would display.

$make vmlinux.o
/dir/to/kernel/Makefile:1887: warning: overriding recipe for target 'vmlinux.o'
/dir/to/kernel/Makefile:1138: warning: ignoring old recipe for target 'vmlinux.o'
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
make[2]: Nothing to be done for 'vmlinux.o'.

The reason is vmlinux.[ao] is treated as single target, while the rule
is written in root Makefile.

This patch fixes this by take them out of single-targets.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Masahiro Yamada <masahiroy@kernel.org>
CC: Miguel Ojeda <ojeda@kernel.org>
CC: Nathan Chancellor <nathan@kernel.org>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f1b2fd977275..66fb08f6d971 100644
--- a/Makefile
+++ b/Makefile
@@ -280,6 +280,7 @@ no-dot-config-targets := $(clean-targets) \
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
+no-single-targets := vmlinux.o vmlinux.a
 
 config-build	:=
 mixed-build	:=
@@ -315,11 +316,14 @@ ifeq ($(KBUILD_EXTMOD),)
 endif
 
 # We cannot build single targets and the others at the same time
-ifneq ($(filter $(single-targets), $(MAKECMDGOALS)),)
+ifneq ($(filter-out $(no-single-targets), $(filter $(single-targets), $(MAKECMDGOALS))),)
 	single-build := 1
 	ifneq ($(filter-out $(single-targets), $(MAKECMDGOALS)),)
 		mixed-build := 1
 	endif
+	ifneq ($(filter $(no-single-targets), $(MAKECMDGOALS)),)
+		mixed-build := 1
+	endif
 endif
 
 # For "make -j clean all", "make -j mrproper defconfig all", etc.
-- 
2.34.1



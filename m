Return-Path: <linux-kernel+bounces-130699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC91897BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3462D286AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC00156C5D;
	Wed,  3 Apr 2024 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3OD0jh+"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8878692FC;
	Wed,  3 Apr 2024 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712184215; cv=none; b=AgdDT4A8AcahetffZR4Sy+JMDpmQ61F6A0vbdi9WunUsAOJLAfsDxOIOnVXzKKJOS7sXSZyPtuR4WiPCjYdjmfNgxsz6IGc1AF87El6BtUHm4hrKaz4011wqE9hBwDj3oIkDB0WwAKOUUEZUoITeUHuSRQ82XmJIK9A2367fzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712184215; c=relaxed/simple;
	bh=lOubGtR80AaNFh/cJV+FIWAPhTfv5Muj74fW8EsJv/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYqePKeCVGu54hdpwrsqdJ8fi6a3DpT/+2Jx+6dYUr9wmdy8+gjhmo8FcmKgrceKald8XvX0JoCbJ73ctV1RS30ybWYD0xuypz0omC3O2pZK/8xKg0BqSrf8shUAe0q2iJccaSUIt/o7qwIjJVfWlCn1qXp1M2hcNlkDUYzmCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3OD0jh+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d159e4ffso54054a91.1;
        Wed, 03 Apr 2024 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712184213; x=1712789013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbtBOu7AIsmC5hqACAkZ2qUxEdKcn2SBtMp5/oLSpC4=;
        b=W3OD0jh+2Eb5DfkfsJ0BhdCOBuT4l1oJKKlvJVZQ5FVlrtCj/aJ1uArWxbzQYHTqmA
         RZYygt0OlHAaL71kIj3tXNyo1CCJ+CUIdJscCPrvK2+ddAFQPOcQ2CBolxi6N/RaDB62
         fqhdvg7J++5ax5xsx0ycqq5OzAemctb10zCwOMKHecOFYneuWGNTS+uYYXMZ+HEhBWfP
         mgQsQ0ZKySnUQ/wwxS2V9F09UDLNTnZ4dR6+Z949IROEx/qAV4P2vdv4vZGo9W/KNdlZ
         ELts58k/V4Z6Q4qcs7RLoE7snzTc+utZdc05zj1DEoc4DlYaO0Lnfi7y0FV57fbxdaN3
         MziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712184213; x=1712789013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbtBOu7AIsmC5hqACAkZ2qUxEdKcn2SBtMp5/oLSpC4=;
        b=qRSvbdc6cQ7agMRABSabG5LfFGGFZrprMhrVniKt00a93AmPPqF2v1gXHdP37h1P+U
         4avIMLvDvDcBrtQfYZXUYP8EwGM4ZTl+KmEANuZPvp+K7R5JVu3RCoAUiFSGTVkF8oWi
         +CP2OSC1lce4scjElf9ayb1Qxmofm1roJS9kr2Rg8Nu4h3Bo0TFj49bnJuaFFHOpn9jy
         rNHH1zcdVxxsEF4UdXxFi73NPKzrfdfqELlk1Mer132AiW5lVov3ICr8Pp8wijrJyVOw
         2glyVWH0FNEmSD1nJRDv4sXzfohTF4/Qra8xTzX7+M+S/K5h5fQUojGACkKcEYzbHDQA
         zfww==
X-Forwarded-Encrypted: i=1; AJvYcCUoHNEhduy1jgPKZr3a/ya1HrEpKPEoonN9vnZ6/KEZJaoJ79OPWj3Ob3qauUIKCMM4nhlxvnizVv32AlkE4/yDc+hYYXqsQNjL1O94+XTxOIfyY9QXCg0oNx7CE55H8AYLHBg70ezaEuvjuxT5SSe9+pwx1ZDEKrmjwwe4ltdpX8Kn
X-Gm-Message-State: AOJu0YxsoX8eo2+PvqRjDYMB9wWPx5BliIz6HkmyaYZYP67Pbbi/Ylbl
	O1HA0AVT1ZTUvQir9/CNl7E7Z/hhiKPtEherNpKpH8XD8WAx6SM3
X-Google-Smtp-Source: AGHT+IHou4AJqLm8+IeQGJUuH8c7Wq/7OSMZ7wXA890VZ2cnN0mGXEfhLE/66T7EWveDYzRPE/RIWQ==
X-Received: by 2002:a17:90a:d48b:b0:2a2:c388:bb36 with SMTP id s11-20020a17090ad48b00b002a2c388bb36mr1387422pju.11.1712184212960;
        Wed, 03 Apr 2024 15:43:32 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 13-20020a630b0d000000b005e840ad9aaesm12184383pgl.30.2024.04.03.15.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:43:32 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Charlemagne Lasse <charlemagnelasse@gmail.com>
Subject: [PATCH v6 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Thu,  4 Apr 2024 11:42:54 +1300
Message-Id: <20240403224254.10313-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403224254.10313-1-21cnbao@gmail.com>
References: <20240403224254.10313-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xining Xu <mac.xxn@outlook.com>

If function-like macros do not utilize a parameter, it might result in a
build warning.  In our coding style guidelines, we advocate for utilizing
static inline functions to replace such macros.  This patch verifies
compliance with the new rule.

For a macro such as the one below,

 #define test(a) do { } while (0)

The test result is as follows.

 WARNING: Argument 'a' is not used in function-like macro
 #21: FILE: mm/init-mm.c:20:
 +#define test(a) do { } while (0)

 total: 0 errors, 1 warnings, 8 lines checked

Signed-off-by: Xining Xu <mac.xxn@outlook.com>
Tested-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 14 ++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 127968995847..a9fac978a525 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -906,6 +906,20 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725/
 
+  **MACRO_ARG_UNUSED**
+    If function-like macros do not utilize a parameter, it might result
+    in a build warning. We advocate for utilizing static inline functions
+    to replace such macros.
+    For example, for a macro such as the one below::
+
+      #define test(a) do { } while (0)
+
+    there would be a warning like below::
+
+      WARNING: Argument 'a' is not used in function-like macro.
+
+    See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
+
   **SINGLE_STATEMENT_DO_WHILE_MACRO**
     For the multi-statement macros, it is necessary to use the do-while
     loop to avoid unpredictable code paths. The do-while loop helps to
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..9895d7e38a9f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6040,6 +6040,12 @@ sub process {
 					CHK("MACRO_ARG_PRECEDENCE",
 					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
 				}
+
+# check if this is an unused argument
+				if ($define_stmt !~ /\b$arg\b/) {
+					WARN("MACRO_ARG_UNUSED",
+						"Argument '$arg' is not used in function-like macro\n" . "$herectx");
+				}
 			}
 
 # check for macros with flow control, but without ## concatenation
-- 
2.34.1



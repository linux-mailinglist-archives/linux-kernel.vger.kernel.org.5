Return-Path: <linux-kernel+bounces-13733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4336820BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124591C214DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656C4C140;
	Sun, 31 Dec 2023 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TGiNmJG7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9BBA30
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3e6c86868so63166745ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036483; x=1704641283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuCoCK+SW4zawUSFFv0erKPf4OwGQ3cihPvdb62nAAQ=;
        b=TGiNmJG7kgiO6iwMkVvaOG55cZTPy7o/ffaBqUuSV7X3owlmL2WcNqb2+mRm9eUGok
         CqeySdUs1AaREkBpiYR80ANy8w1bmGixtosjtWS32TzZzGHm1A0UNdGMU9x3MxTl8xSB
         yRTurWDUnV9Kf3n3tT6Sl5xvBgJdjCt/0HZ5FJYLZm/Rc8X/v9Eq5xmU9er4t4K4UcqJ
         6dJJEMaZOqsxSk0AK14HPj82am5teiZNlt5v4RD+WP2l4myQavcS3DtGMqKi2544/F1i
         EEXLBU7v9dNk5R2PwmsGEswSq7B1pz6WPAsopj20rwUWSPgSeM05L9SOTK/wAMPl6WxQ
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036483; x=1704641283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuCoCK+SW4zawUSFFv0erKPf4OwGQ3cihPvdb62nAAQ=;
        b=K51LndWc0dR0ELvpnZWFw1dIJpLYDCD/kr5U1I5AiVif1uj72yJQ9qS3mwME7sBwpK
         YzZqbw8mYW/exE4z3mHr1snYv8yhs7FRaOAiVA9xBPlYohtPmlcNIKkJXcNcx0oT5SS5
         dAAzIx3mghmrC+1kgCdObOVZhwOBVnnAuawoO1XoHcW2qKPpI5rwyJkveMN2M4Rw/6CO
         u9Anrk8hodUDgC4DOFchigQbuwsbe+21+ksKhBkGgAJXoLOynKDtyFNKYXYMZqJK52Uy
         ZXW4OVhrY7mBfsEkVdLijYn85YQ15FC3E7QUylwzk26gv5Q7NqK31qUcZOmHXV1jZGsi
         tyTg==
X-Gm-Message-State: AOJu0YymkV3EXUUDEJ/o4kM0tqeM4DkOi6s1WP4AET0wkgqVu8vLIEXK
	+T416k2v/244GeqUhXBx2V1lloO71DuBaA==
X-Google-Smtp-Source: AGHT+IFrXdhgAdCMZNHHFRjvOLoIEeS5k4qN1vslTS4fA+aVRSXmXy/wbfSG12vHdQUE2i/D13D4aw==
X-Received: by 2002:a17:903:1ca:b0:1d4:25ec:5975 with SMTP id e10-20020a17090301ca00b001d425ec5975mr20365331plh.10.1704036483091;
        Sun, 31 Dec 2023 07:28:03 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.28.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:28:02 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v4 03/11] RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO in kconfig
Date: Sun, 31 Dec 2023 23:27:35 +0800
Message-Id: <20231231152743.6304-4-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231231152743.6304-1-jerry.shih@sifive.com>
References: <20231231152743.6304-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM main and binutils master now both fully support v1.0 of the RISC-V
vector crypto extensions. Check the assembler capability for using the
vector crypto asm mnemonics in kernel.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0a03d72706b5..8647392ece0b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -636,6 +636,14 @@ config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 	  versions of clang and GCC to be passed to GAS, which has the same result
 	  as passing zicsr and zifencei to -march.
 
+# This option indicates that the toolchain supports all v1.0 vector crypto
+# extensions, including Zvk*, Zvbb, and Zvbc. The LLVM added all of these at
+# once. The binutils added all except Zvkb, then added Zvkb. So we just check
+# for Zvkb.
+config TOOLCHAIN_HAS_VECTOR_CRYPTO
+	def_bool $(as-instr, .option arch$(comma) +zvkb)
+	depends on AS_HAS_OPTION_ARCH
+
 config FPU
 	bool "FPU support"
 	default y
-- 
2.28.0



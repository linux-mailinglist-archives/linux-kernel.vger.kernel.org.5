Return-Path: <linux-kernel+bounces-7637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA60B81AB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4A21F23B95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96C4B5A4;
	Wed, 20 Dec 2023 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uEH18OOc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478104AF75
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-594196f5081so116720eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703115463; x=1703720263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=uEH18OOcA3Ib+xRdxwKKVLD8ttrUwaJhrJjmEARabck0E/el5cpMVWJSaFWIKtQwaj
         Lrz1lmvMmDRxhVkosgx9s7Oz6VHxrIGezHu/f1tGDWBqbPye1rx9u24tQuNsOIHIZg6a
         tl09PtBIQ8ye92QGAHWqvEHPGwXcf3GB+foLqraJI3oNmDixitpSek/CLJE9f96bZLVu
         yUMMCIqkYjcC8MP2/ejvjoYQCbdxIlPBFlvANn/nRJZh/ikhsc/TGQCIau5k06aoS7UP
         ZujK9InSXVVfI4Rddb05TpdM9yP/wnOPLUlO2E1BacgyJmAVm4e0SMIT2Bdvu7y/zY8d
         hVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115463; x=1703720263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjqGV1Kb/P5zbkrU4HZj42U242Y4ucdb6cKzFhJu16E=;
        b=VO/bcQwmY/RaC/KuYOOYFo4Ff9Ql0SovpK6mEvQyz6aKMH77utiNs7CyTcoHe1m3IJ
         xGCvuH/quT/zNGiG2x3RAoFsXdagv8LunozsGgabGF2CGTL731mPZeNjUpq3IEHmX7yk
         6DT19rKv0V+b9KckVjSoi7vFPazyoQ2n1/HVqKhneFggaE8qai1BEBb6qqGj0J2twT+d
         PPo1MCwxjySxd7Vd30OCn7IX+4hg5BIJHw7kjqP8kQDBHs0JbLGA4K3CU62vpzerGBbp
         ZYMFR1cswWoc/aAMONzB7ltL9iH2K6trPAZ0QFtdR6kWJuCDzyT/gp97aHJAT2IkHtkd
         22NA==
X-Gm-Message-State: AOJu0Yziy6oLKsTDvC+DxInSsiZIexeMbbrBgX9jGm9s2IND6aa3vQly
	toOlzmH81APojSk35YjIMKVD8Q==
X-Google-Smtp-Source: AGHT+IGHNOnr8Aim6MPnEshwNbtCD3bmjs0I4LnJU8bFAnjzSSgQbv7AbRhjY0LeHpmhPl0ncXT31A==
X-Received: by 2002:a05:6870:2406:b0:204:1640:871 with SMTP id n6-20020a056870240600b0020416400871mr540390oap.33.1703115463452;
        Wed, 20 Dec 2023 15:37:43 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k5-20020a056830150500b006d87e38f91asm132834otp.56.2023.12.20.15.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:37:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 20 Dec 2023 15:37:39 -0800
Subject: [PATCH v13 1/5] asm-generic: Improve csum_fold
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-optimize_checksum-v13-1-a73547e1cad8@rivosinc.com>
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 David Laight <david.laight@aculab.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703115460; l=1517;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FtbING0Tg9V1myoJvDDTr8ph0mEbsa+4mbxe/ijBRBI=;
 b=xEtGAzIZTi0hssL5BrH22sQ/Z/VxvZj1DqZ2xODP/wyuVs3LLvuUYmbbKU/IWSuPywx+xI7Vd
 9xXGrsLI9uQDaY3XpdcikT0hlogpiuc94AKvf2h4XD1x0mqkd4yUqVi
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This csum_fold implementation introduced into arch/arc by Vineet Gupta
is better than the default implementation on at least arc, x86, and
riscv. Using GCC trunk and compiling non-inlined version, this
implementation has 41.6667%, 25% fewer instructions on riscv64, x86-64
respectively with -O3 optimization. Most implmentations override this
default in asm, but this should be more performant than all of those
other implementations except for arm which has barrel shifting and
sparc32 which has a carry flag.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: David Laight <david.laight@aculab.com>
---
 include/asm-generic/checksum.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 43e18db89c14..ad928cce268b 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_CHECKSUM_H
 #define __ASM_GENERIC_CHECKSUM_H
 
+#include <linux/bitops.h>
+
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -31,9 +33,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 static inline __sum16 csum_fold(__wsum csum)
 {
 	u32 sum = (__force u32)csum;
-	sum = (sum & 0xffff) + (sum >> 16);
-	sum = (sum & 0xffff) + (sum >> 16);
-	return (__force __sum16)~sum;
+	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
 }
 #endif
 

-- 
2.43.0



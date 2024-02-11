Return-Path: <linux-kernel+bounces-60859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09820850A39
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361CA1C21C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BC5BAF1;
	Sun, 11 Feb 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chvvX/L0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D121E488;
	Sun, 11 Feb 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707667723; cv=none; b=bIBCqmCNIlHIKLhepkB1+4PA8BpVr0RIY7Au7t7CUn/BE7dYK+vP/l0LYMhAVnEUEgmAV/yLm9penob2GyMukinoyI4BCVHrskpsRoVilW5T7whZXXPOG9Tr7t7YIM6YvKDfVneQOnjZfzRdYtlOIKD1CmnOPkk8QAfkNEMCDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707667723; c=relaxed/simple;
	bh=N55mi/y8ytD51GnohFmYC1C7IWXhLQVa5jGRqoxECmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q78ZNv2gJAdhG8HhkyrmGV4+xGlZQcI6hlZ/h5Riu3GVnPOp2UzGe4UPc+EOpY/s+EYQolarVP0HnV4CmvJtHQWB2//l5BnFtZileMRNIJwuJwsTJc1Luvp3d46UfMbpBfS/6R/bnAMjrkcIvzjlf0Li6UbwK76seRf5/79NOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chvvX/L0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d74045c463so19501245ad.3;
        Sun, 11 Feb 2024 08:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707667721; x=1708272521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lotKNDu5K1rKJW60VS8sQo+NyQpFqzMMO/FPKjpoA2w=;
        b=chvvX/L0H4FHkSzWdUv1L6H1YwjEPwAWgO4II7+wSM/sSzi1jJ4kJviUGLDymZP/sr
         bNGyg4FAZnE+4I2ALzsc1pzUMN75Ttmu+OAYLZNcWgxm8MtME9hlcoYM7GZp8HmspVCj
         2ceY0pfmCAFA0rcw10P56vJnBHIhTmehYQOx9Y/TvhL5UkkAfujLF7o/uMM3Rjex3cCb
         gCO9y7w+jDCkeDktvcswVtSTK6yOA7T0VaJTng93xe3y14twDxQWUDwUbo/6l2zYGjRz
         uBJcYYFJzSdFn2ZRXSA8wsAWlMGst46Mo9pV20zCM5Fx5nI52+2HLh6PDdoSpHcDy3oB
         2GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707667721; x=1708272521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lotKNDu5K1rKJW60VS8sQo+NyQpFqzMMO/FPKjpoA2w=;
        b=WOykkH1P/g6fY5EeAkVM8sM5e9xh2cpRbGVe5OCy5eHGhhmz5NsDt0XJN0Epb0Mxbp
         MkX5VgLFR3/NphtLD8z8FRvCBL/0nJl/querA0l1urUB+QDCxR9k6Gi5hJUHsdnQ6zWZ
         u35TpXEDgbMfxKSRY6IGffyRg0bRi7PbvjNsjgbsQyapbJQBaORFehA9RP3z1JXSEQ1e
         866ocDjNGSfgsu4Lz/9a7aAskXwy8/7pyGdIit46nn57HVG4pIFeTFN4/8617a92D5wB
         2JWpWYXMNbNwifBtqE2RNydRk5/35vLS6BpvbTwv8Eu2ZjTJ/92v/cXPxUdNj8tBAnCh
         Z6+g==
X-Gm-Message-State: AOJu0YwhQm0LA38gSiDLC9qRRxMabPn0szhBGgp39uUwfAhofHIAF+Gs
	ppnRx9w3A1+I8e7astal5ArY9R938Qt0VNfIXRrgHsPDLDxyby7chWDvfuEU
X-Google-Smtp-Source: AGHT+IFYTvsPa1mClu6Wnu9S0N/VPJWgBITVulZ3VBS6AeHV90HEmG+t6Hs7GOd/N/517nAOypCOAA==
X-Received: by 2002:a17:902:f80f:b0:1d4:4df7:22ab with SMTP id ix15-20020a170902f80f00b001d44df722abmr3718138plb.55.1707667720573;
        Sun, 11 Feb 2024 08:08:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv3UwthIijA0gLXk2GNfKrxVQMENxp7ruxwbs0m7VQKdhCL01TFfyeqgsgnvmHRNkIXdakMHlT/BOQzck7Yb1lZm5nF2H1tBEV0bw7rCgQME2D7WZLJJESjkF2xUwhaPVFOB5yzvisQWBd08e5T3PvkVS5hIZwDjbMYF0PoLvnEdDobsC6DocziUqG
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16-20020a170902cf5000b001d9b092bcd9sm4495980plg.148.2024.02.11.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 08:08:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler
Date: Sun, 11 Feb 2024 08:08:37 -0800
Message-Id: <20240211160837.2436375-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 'lib: checksum: Use aligned accesses for ip_fast_csum and
csum_ipv6_magic tests' was applied, the test_csum_ipv6_magic unit test
started failing for all mips platforms, both little and bit endian.
Oddly enough, adding debug code into test_csum_ipv6_magic() made the
problem disappear.

The gcc manual says:

"The "memory" clobber tells the compiler that the assembly code performs
 memory reads or writes to items other than those listed in the input
 and output operands (for example, accessing the memory pointed to by one
 of the input parameters)
"

This is definitely the case for csum_ipv6_magic(). Indeed, adding the
'memory' clobber fixes the problem.

Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/include/asm/checksum.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 4044eaf989ac..0921ddda11a4 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -241,7 +241,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	"	.set	pop"
 	: "=&r" (sum), "=&r" (tmp)
 	: "r" (saddr), "r" (daddr),
-	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum));
+	  "0" (htonl(len)), "r" (htonl(proto)), "r" (sum)
+	: "memory");
 
 	return csum_fold(sum);
 }
-- 
2.39.2



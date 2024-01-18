Return-Path: <linux-kernel+bounces-30605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5D8321A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A330285485
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1FB673;
	Thu, 18 Jan 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="17TjdaQq"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F7379CD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617409; cv=none; b=PYxETq71suQnCtd50Umn6fzo+Ae76ncmydtH7Kca9bmHGXCQuqRTz8ysUV/9WRJ4cqaqPKGwcz/1L00ieMFKEpUvbPAOQaIe/hwohT3YMkHCYTyl5NhdjoBlbJ99li8f8w9rq4OkFqgjJF8pTyCHbCgeO7TufBfUw5LFTlxw140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617409; c=relaxed/simple;
	bh=Ewf2ArCyVhqQECvgVJiy2phXnKTeR3STay2OCvwENw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g9sSfAkHbQG0xA/IXxQYA4okGFIorjT2PQU3DRxwrdpJmG5dBg3IPTl4KDcSWJyP6/i6LLwZ2ip4J1QZwwMrSP4nRAhJXbeyW0k9APKRorIJ7YpWEIfQI/2oDwKlHALZReDiOs72fiaK+IJPEB/zC20r2wpdt88L4pOw3+nviYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=17TjdaQq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dac8955af0so193499b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705617407; x=1706222207; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22psKGJ5/XvThdwDSK02VziHgNEv3yYHumxnTIri9Ik=;
        b=17TjdaQqeF5TG59QM+epASHEr+TKtUeYfAJy0fteKj3miqO+qeyFh2szePcOBto2p2
         pcjCGH1YJHTX991PvAWAZu9EP3F7udcGmwu7Y4guembRmaOxGKjDlDdklymyu0NlxKh2
         cd5sav0RvdfTH1HfWnPcX2qTu0etqmLYxc473mFIteqt9pp6V1s09tkGMibFw/sOifLU
         AWUJDHcRYVQ7mBVjU7/PtBAJ3p19lKM3oB88CyI0iMEY1S6jlL/jtSxeB6TRWLjQ7bGY
         7PxSCTIdqecNiEzHL9IrBADPE25BG1zMH2KJy8VzsbL4G2zvMROxhN9z3/RoxqIJKNUQ
         IkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617407; x=1706222207;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22psKGJ5/XvThdwDSK02VziHgNEv3yYHumxnTIri9Ik=;
        b=gUVovTBDD5Eq8rXLGF6t8CPc7v2GGOrTZ6rTle7h2stZkThDK3Witz7FXYB3IONHdJ
         0m8eN9nQqTQi5kjfOmEQ2vsOZFiRGmIJ+YEl9H3RVW64lwxa08ZBBbAieJbeYcJSH7J4
         Oqdral/f29E6CicK3tVJXZnyjXLqbsG/nfwUWOhU2Z82oR1TTriP6vKtt465/eCdSNMS
         fqHw6D04t2Gh+JxQOc86cLvXdCtPEUdJzPK11jqhynWObh6bKjLDXro7Xpmemm/YkXkC
         XhCfpcunr/BXZspjS0s9Nyuz41zvxynLjMjJH3vnP5NP+mRAj3wvrqbfSMrX3I5VfcvN
         lEtA==
X-Gm-Message-State: AOJu0Yy32i7wVWPWcVsF9MAqsQx9yKr4DQUtXe5cbdF6IBQ3xfWJxCEC
	B0kw/MMBnRbXE1KKhQ99x+y9bcVr+HHfm+l9LViq7iGcAVTMSnZU99zdhQ4PpGLr0QhqH6m54EC
	n
X-Google-Smtp-Source: AGHT+IGa1v+KN/+ULl0Ii7BDD3/Y6hqg1cXKT1geyyY5xoILJoNQPTvRCCfXRozpmgxLg+KkQanQZQ==
X-Received: by 2002:a05:6a00:2308:b0:6db:9684:defe with SMTP id h8-20020a056a00230800b006db9684defemr1482192pfh.8.1705617406785;
        Thu, 18 Jan 2024 14:36:46 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t34-20020a056a0013a200b006da13bc46c0sm3904979pfg.171.2024.01.18.14.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:36:46 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 18 Jan 2024 14:36:45 -0800
Subject: [PATCH v2] riscv: lib: Check if output in asm goto supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAPynqWUC/5XNQQ6DIBCF4asY1qURQmrtqvcwhihOdRYwhkHSx
 nj3Um/Q5f8W79sFQ0Rg8ah2ESEjI4US+lIJtwxhBolTaaFrbWql7tLx5m0ETxksbWndkqUV4hA
 mtgN7O1MiadpWa6eMctCIcrVGeOH7ZLq+9IKcKH5ONavf+ieQlVTSNO7W6HFsJzM+I2ZiDO7qy
 Iv+OI4vzXL07tsAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705617405; l=1498;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Ewf2ArCyVhqQECvgVJiy2phXnKTeR3STay2OCvwENw0=;
 b=8j8Lc3kU83hQIjeeCFyK7o9YgcEczbHdmRGsbhtSGH1IrtSy/F8ki8oeXrvzdncHyn2Ia3Ld9
 x+nDNC7CGyfBtpWARLnVleMssPBiXVhl4azmSkd8VdXYfkkMD2pn8pt
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The output field of an asm goto statement is not supported by all
compilers. If it is not supported, fallback to the non-optimized code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: a04c192eabfb ("riscv: Add checksum library")
---
The OutputOperands field for asm goto statements is only supported
starting from GCC 11. Split the asm goto to remove the use of this
feature.
---
Changes in v2:
- Use CC_HAS_ASM_GOTO_TIED_OUTPUT
- Link to v1: https://lore.kernel.org/r/20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com
---
 arch/riscv/lib/csum.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 06ce8e7250d9..af3df5274ccb 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -156,6 +156,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 	end = (const unsigned long *)(buff + len);
 	csum = do_csum_common(ptr, end, data);
 
+#ifdef CC_HAS_ASM_GOTO_TIED_OUTPUT
 	/*
 	 * Zbb support saves 6 instructions, so not worth checking without
 	 * alternatives if supported
@@ -214,6 +215,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 		return csum >> 16;
 	}
 no_zbb:
+#endif /* CC_HAS_ASM_GOTO_TIED_OUTPUT */
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
 	csum >>= 32;

---
base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
-- 
- Charlie



Return-Path: <linux-kernel+bounces-157305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037738B0F94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ED81C22679
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD565168AF1;
	Wed, 24 Apr 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oV8Dn830"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6110161913
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975735; cv=none; b=Dj6ymXJpvBk+9JjsgGIDEA22m7akgqSCr7D3Gkj0BiQV7zj9721CetTvZjydXg0kNr7LfCiyqrz2eUt51XUDA03eJ9H7TYAaOKHN+LjOFEKdCmeqq30Eft6MOBxrNsTuHNbB5ap44U5wehLROR7wPQso0jbIHF4e2x5EJhZlYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975735; c=relaxed/simple;
	bh=RrP4p1oOkU3DSs5epOmV4/BbqCtTpx1t2NayPBKRDTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xc9uK4cUAu8wuKt0ArEMa3IjFAe2N/PBOKMdDrnc+rRraqL0X2FO2tnZufrrudXVuj+hQoqJDDDRh7L1LgXIfIc0kacB4c3b1bzQNttsp9vBp2r5hPW8hRSGGRJ/6wtyB7B/o9OhhRpBtlXYEJocdDvQanYrqTM1KMReW3Yvmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oV8Dn830; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso20743a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713975733; x=1714580533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/mT8dYLNNDcBxpI6RYoMuqc0Mj6CDLobboyrOMzI0o=;
        b=oV8Dn830P4OOsx4GLDJ3RIfTAE6/pZrEyB3YurvFgUxWAa/cCNEDgUI7cOUm56Wcvx
         Fh1d/1XZhErLWRLU97GXj34CIuSSxwUzps1leUXppfJu4Mq603yTneOkej8oCkXuAPxs
         YWhfdZOOsoMq3gOG8QpLRctE4PNahXlqqIcqfzPzBYBLkSWcJfUJkO+JhVzwVCx8dbaR
         I+RufrwH5OGNLMXFajzjLVC/v3FbAGlkZn5urHR/w8vwaN2gXQZFhqfOxbpGWkKqmlNA
         Euvw/Hp6jFuDONBRBnvf+6O+3EuYELL7dOlnWk8o49kVQYTbexwoZpbxJyySmOwt9wGH
         H8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975733; x=1714580533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/mT8dYLNNDcBxpI6RYoMuqc0Mj6CDLobboyrOMzI0o=;
        b=aSYuFK2AwCCl/VXa2+vpVG00y8vT0d7E64XrWTnpX+SGjhgGIes4Zde+oCzhD5FJh7
         Gx8vV9f7i2h8QXhBhVOEAMjTHNC18itSy2j7VoyNv2r/jq9HKNmCASfgdYKStitvcliY
         Y/TBTDhmSLx14p0HJHkon2wz7KVtf/nDcHHzHOPIxFGdqltvtIV35o1VyLkRjXpUkhoo
         eGpr94cBbsk0+7zfRXR9F6ciY6MNEMwrMUkSlfW+QLNuiA659FpaBK9LMGL5bdp1DGRA
         Bs/rnM8ZTx+wNJhWnX6WQwIGLe37xW16CAwzSbnjvO0dK5fnXseA27ou01q8VoAIIzNe
         ZmEg==
X-Forwarded-Encrypted: i=1; AJvYcCUADhky120BwwSIzFH+SbB0iiVqRsGfJwKklMpFE64acEblC9K38UiHSkb6qJQk8u5UAUtM3ROkQ5QtRCQDjH3TzqR7gKY+hiaCRsUi
X-Gm-Message-State: AOJu0YxijvYKMiZPmT0D+5nmJdW4kwp4F3v7U2o71sRHLmaT8X2fLM2d
	hBwWdd7S6os1wYDf8r45gBhbZ/h/cg1J9sdLhSbtYPY0YWZdXNzcWCIFtwMwE/Y=
X-Google-Smtp-Source: AGHT+IGMumjYf8mPlW+j425B4XJG0C/FHdcbATybQFw+ishD2opGN8n3uPWhego21AWcmcCax3AHhA==
X-Received: by 2002:a17:90b:68b:b0:2af:3088:e36f with SMTP id m11-20020a17090b068b00b002af3088e36fmr2212404pjz.7.1713975733147;
        Wed, 24 Apr 2024 09:22:13 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a1c0800b002a610ef880bsm14505760pjs.6.2024.04.24.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:22:12 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Apr 2024 09:19:55 -0700
Subject: [PATCH 2/2] riscv: cpufeature: Fix extension subset checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-cpufeature_fixes-v1-2-585e73d2226b@rivosinc.com>
References: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
In-Reply-To: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713975728; l=1120;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=RrP4p1oOkU3DSs5epOmV4/BbqCtTpx1t2NayPBKRDTg=;
 b=fykBMmNYGQRbdKCnZBCBpAC7r/ZAcCVj+foxhpZYBt1r8uQQCIiAPcxCl/E79KO5e4NqinaiQ
 KxWiqVn4klhCdrNlU6ZGZ9F6O2RPTasya1RqwpiCLfDAjqIoRlwDu6r
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
than if ext->subset_ext_ids[i] is valid, before setting the extension
id ext->subset_ext_ids[j] in isainfo->isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c6e27b45e192..6dff7bb1db3f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -607,7 +607,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}

-- 
2.44.0



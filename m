Return-Path: <linux-kernel+bounces-163105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402E8B65BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8C6B2146D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A61194C6C;
	Mon, 29 Apr 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nqgqoVvL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1A2209F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429806; cv=none; b=BbcBTu8kN21hgw2oB0sWsQmS6pPlLmDti6p8wH1K9Bann10iJ3uCOcQT/rAVB2H0B12j68iUnkhWIBGu8OXsqdzGTyB2dWYbX4Dd89aeO9aThP2D5RKIKlSsBOJEfCfAlG5yw7pMj4KSW/13J52z8ZeE0l9reBJ+apZjb7tQAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429806; c=relaxed/simple;
	bh=T08ZWGfXzu8lqvzWKxup1FOG2SgEPHbIfOXibfZRkUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5SUnd0bkux0JAa4XPcUPiEnyoE0RLBqN1O/l5VIhPsgeAzLT/6iSFf8gbqG9mosL/q47BW0gs+jAXzu9jQSo7wTFf3pOc1EjnrSEnNp0AWaQjsDk9waH52bUtUdbdrnoTTiNEzc9hhICUNgz3zRNgTNBDWXjInftoeooGGxR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nqgqoVvL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso36466935ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714429804; x=1715034604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aX2DfJuhjTWNBKhMnmqS+pd+lvRTTCLIsIFTFp4GW/w=;
        b=nqgqoVvLd4qJ0t+I6wzZSnKzTRdhYqFc71hljOs3QtJdI8oMwGmA4T+fbCvUyMsfYg
         famjQgFUcrPKAi3RVMOAW46umrxAKJiIpAbcJq4ykH5Kx9nmvbsgtWa4iWPBdNdr2Z8n
         WJPod8cl7JFg7lwE8+C640+/dmhMEBEJ0RKU53cfT5SVkLovAqVbB3uhkWE7ffaW7GbW
         zDlYrclCf2UyKxRsUB1wapzWPgfphyXA0eoYqArTUdlNHeRbphoJdT/ner0HmycjazO6
         C6B86xni2oVH3ROYp1Soyt4R7Vxmz1mNz6uY4D3WQ4SPY2F/WhaU0MbFFTGMZzvrwO2r
         AdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429805; x=1715034605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX2DfJuhjTWNBKhMnmqS+pd+lvRTTCLIsIFTFp4GW/w=;
        b=vSJfZYA+BSY26nOc9QUm+ljOO4jw4iZ1ao3/CRppIY8LTL8yxc10Kw7h5F9HUxEd6K
         uOKIICRFByd3Xl/szmauIck7evZYzedx6sWGneeVsnwP1SS8tpJJSjDj2A4idXyrYOXy
         2UJJ3au3CaF7rDOggBXm6TV7qYaKYt1rQbbRhGZQfBCnMJTRvqaq1YzpNdaSMNkRKbBj
         N15A62RcSC4P9G055tdpMJXz/2os4cn3BMKSK5t4P7tgbGDaZfXPHM5m0G4rTuV9QyTU
         dDzJDIihiMuu8w2EFsz79jwFoeRXtWtou9V9AVRK23cT0LHIOeJ335OZEVTyZo4dayUG
         aqjg==
X-Forwarded-Encrypted: i=1; AJvYcCV2GG7o5CRG87ZXM75fdiNQCoyM2Go4VqgF2mhMX6dQL+9ZMxEVeAAalGcCapcaJ7diJ5btqVIUcQqtpyoqrAcJUFrnHVi9rUBbUGOc
X-Gm-Message-State: AOJu0YxyoNIubAzZ0W5nQmoyWD4zw2sJiXCMU3GJreFBYOO6a1BMToCA
	pb6YSAKNS9lMKuKZ7ypCU4fA+jtlvxRY7hq8yu1dxtou9PRpqsBLQ4RZ8HyNJSI=
X-Google-Smtp-Source: AGHT+IHwxNeVVhhVRrTQfsymAJ/atiWTaXImzKKz16IcJH9dHlOgfRjFsDqkCd6wjtJtnoRt1L2VrA==
X-Received: by 2002:a17:902:c412:b0:1e0:b62a:c0a2 with SMTP id k18-20020a170902c41200b001e0b62ac0a2mr10454686plk.51.1714429804664;
        Mon, 29 Apr 2024 15:30:04 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001e0942da6c7sm20794013pls.284.2024.04.29.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:30:03 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Apr 2024 15:29:52 -0700
Subject: [PATCH v3 2/2] riscv: cpufeature: Fix extension subset checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-cpufeature_fixes-v3-2-6aa11dde513b@rivosinc.com>
References: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
In-Reply-To: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714429799; l=1173;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=T08ZWGfXzu8lqvzWKxup1FOG2SgEPHbIfOXibfZRkUI=;
 b=fsDLorZDUM2Mswu8g1OspVSNZ6CUk8OfBnWHhbHEHmrn1zhm44AcPx9hBM+6Hl7CGQAa5lboZ
 Cf3P53ThUgGDloa52Mb06Hwze38zJRMWl4xBqxsp+n9pvZ8c5eC08/1
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
than if ext->subset_ext_ids[i] is valid, before setting the extension
id ext->subset_ext_ids[j] in isainfo->isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 818adb0d388e..ab683bed8d44 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -605,7 +605,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}

-- 
2.44.0



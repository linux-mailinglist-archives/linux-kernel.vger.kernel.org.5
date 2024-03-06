Return-Path: <linux-kernel+bounces-94536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632587411F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14F1F25865
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EE1420B9;
	Wed,  6 Mar 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B0158IGN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4572140E29
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755471; cv=none; b=tC5Clu+GmBORakJMHH36sCUyDXtNYo2Mi1yw5WJAAhHMd2ohLxn1Ccfj3Of50ObZY3qCFnyR5/fE5fmpTCRsnGVCGc1vRf/JeoTbalj/LzGZ1K54n5kRzfAEgH4nJcluSGp1ixfyrbBO5oeqba7BtGwhH0T6rt360DGcNyy7GTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755471; c=relaxed/simple;
	bh=lTFn9I0Y3b7Ejl8OaTTiYWgoS6zNgQwuVEQYPtx30SE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RbUxRLux4LwotiG34wzrxTxGUP3N5ENHUoWqKd4ux3uVYVyF3U2y97sZx5vlIiuOXRFnH1iPyNgysrXrShWojZx68yYFbxv7Gq4SS/mhFWuZ6rS+/xNjtoyIXzGjqJqco/pp9pr3Q8JTF2yMlvUVdHocN8XQkdqJgzUQ4Hs9AtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B0158IGN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc418fa351so9374415ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709755469; x=1710360269; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKUay/eboC7v6g8jePCucowgEylXLTR6sMxM4Bv1SF8=;
        b=B0158IGNyCI86safOzgH+hhbKjAez8hmDTzevB7DVRtTuX3BLpas28CXDu6Pz5tUa6
         v9EpDaC/JaoQJ/Pa3DN3VGJp90GEMb0dXSRsw46D6Ow6iiJcTQLI821UKMQYZuZ+h2wj
         mJ5JuCURcxyW+sohyBPg/z1BqwSWieKI+sg20NXHzE5feicOcZvpGEsAsQRBo3G+MQaT
         e2kmNV6Ky77PYOR7RfwQlvZ0HOgZBZi9N00nbED4RYHBjKSH67bEr+FY3CBp1wZysFVC
         lAnnJPWOBn14TZk6K5FThgf6WFd6AXPpKBT2bAtDt6QN77ot5ZMBC7Y4qowtvwRVb+lw
         lYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755469; x=1710360269;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKUay/eboC7v6g8jePCucowgEylXLTR6sMxM4Bv1SF8=;
        b=lR7AnAO4LHlUfYdaN7jkwwxvFdc9PMd9zHEv1cPeu8FMT7HX3LPX6pieYvtOGCQiyG
         dE8doq1FwDmxh1jv+bU53csnQiFM8sMYr4c+FC21luyL/UtcrHuPhspypIupsH0iHCf0
         DNwP5f9e7GfAsg7hu1hH1DRMQJNpXDEE/zgQVrpwGCQtSobrc0QpBDUdTpyNXUjYOIzh
         Sof23wWfanB8Fpuj9KfDhlTNrRPurJktGgPwB2Wulik9E3OKsiTU9jvWn5j0gLGQRAfN
         m0w323+bXAyjwdRZpgT050OSk60iPy1ortpBdXVxX7la5E6/y/7G+D/3lAHhg+1okZfM
         2x1g==
X-Forwarded-Encrypted: i=1; AJvYcCWCtaNCoZT1rTo/Yr+UBBU6kmrF5B+Jm6r+bwUKClurjl9D0LGdoCkvHTLDzrF2CqjGALBuaAN+QH8uK+ukaAdD8pJ8R2djvaOTCcWc
X-Gm-Message-State: AOJu0YzDFf0izPicAOZrN/QOTfVNNb2ATLpne5RwcGzu83wAyruCaWfW
	k+iiTEJuGWNFZGpOAp8MlXAdm8VNfxxH2k3vyXa1JvAAwlwZmkG4AqoGF9haqVI=
X-Google-Smtp-Source: AGHT+IFcRftRFdHRA7STML/iSxC0fVuC2YX2iC0np1Vii+/hyKYKXEUuZ+g+4TvJ8a4sfCUIx1o79g==
X-Received: by 2002:a17:902:f68b:b0:1db:b96f:4a50 with SMTP id l11-20020a170902f68b00b001dbb96f4a50mr1469650plg.14.1709755469033;
        Wed, 06 Mar 2024 12:04:29 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001dd42bbb08asm874913plx.253.2024.03.06.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:28 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 0/4] riscv: Use Kconfig to set unaligned access speed
Date: Wed, 06 Mar 2024 12:00:00 -0800
Message-Id: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEDL6GUC/43Qy2rDMBAF0F8JWtdFb8lZ9T9KMXqMkoHEClIxL
 cH/XiWbmGKwV8O9i3Nh7qRCQajkeLiTAhNWzGML5u1AwtmNJ+gwtkw45ZIywbqI1fkLDNd2L3g
 aIQ63kj0MIY8JTx2VwoETRqVekKbcCiT8eS58frV8xvqdy+9zcGKPdr89sY52vY1MKehDdPaj4
 JQrjuE95Ct58BN/kZzuIHkjjQlCWw/ReL5CiiXJt0nRyCBl6lmiwnu9QsoFyfQ2KRsZA2WgLAv
 UhRVSLUhutknVSK+tElZq4MatkPpFij2/1I3UjIOPuk9S0H/kPM9/03iv8HACAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709755467; l=3010;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lTFn9I0Y3b7Ejl8OaTTiYWgoS6zNgQwuVEQYPtx30SE=;
 b=8MyknLAmGtODfurxjwQVAiKmK3GpXVKDJV0yFZpoxyv/K1imsgOekLb25lWMFMgTfg5vAl5WN
 a1og6lbKqyAAyjG2R1kLCR4dQauYz6Wnh2mmOCNxauABgjHrh1e+Zyz
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v7:
- Fix check_unaligned_access_emulated_all_cpus to return false when any
  cpu has emulated accesses
- Fix wording in Kconfig (Conor)
- Link to v6: https://lore.kernel.org/r/20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com

Changes in v6:
- Consolidate Kconfig into 4 options (probe, emulated, slow,
  efficient)
- Change the behavior of "emulated" to allow hwprobe to return "slow" if
  unaligned accesses are not emulated by the kernel
- With this consolidation, check_unaligned_access_emulated is able to be
  moved back into the original file (traps_misaligned.c)
- Link to v5: https://lore.kernel.org/r/20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com

Changes in v5:
- Clarify Kconfig options from Conor's feedback
- Use "unaligned" instead of "misaligned" in introduced file/function.
  This is a bit hard to standardize because the riscv manual says
  "misaligned" but the existing Linux configs say "unaligned".
- Link to v4: https://lore.kernel.org/r/20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com

Changes in v4:
- Add additional Kconfig options for the other unaligned access speeds
- Link to v3: https://lore.kernel.org/r/20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com

Changes in v3:
- Revert change to csum (Eric)
- Change ifndefs for ifdefs (Eric)
- Change config in Makefile (Elliot/Eric)
- Link to v2: https://lore.kernel.org/r/20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com

Changes in v2:
- Move around definitions to reduce ifdefs (Clément)
- Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
  (Clément)
- Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com

---
Charlie Jenkins (4):
      riscv: lib: Introduce has_fast_unaligned_access function
      riscv: Only check online cpus for emulated accesses
      riscv: Decouple emulated unaligned accesses from access speed
      riscv: Set unaligned access speed at compile time

 arch/riscv/Kconfig                         |  60 ++++--
 arch/riscv/include/asm/cpufeature.h        |  31 ++--
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/cpufeature.c             | 255 --------------------------
 arch/riscv/kernel/sys_hwprobe.c            |  15 ++
 arch/riscv/kernel/traps_misaligned.c       |  17 +-
 arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
 arch/riscv/lib/csum.c                      |   7 +-
 8 files changed, 378 insertions(+), 293 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie



Return-Path: <linux-kernel+bounces-96051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D39875698
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163B1281ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F7135A68;
	Thu,  7 Mar 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aw6Zzbmb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4084A2B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838355; cv=none; b=X+3S0BPyuKI5CSmrIp0K20rT4D/k3VJl38JG6cepAnBWscgnRJfYCBYqK/eiWwfHZhneqHTkht8OMcMtRrGbZBEYpw60DADu1nyQB9An8qQHbQsRCkRJVpz7Nlo/0AhX2EcMJFycE5S+VXqrZJO+VWr4UYCWKQ4j/VCz7BKSGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838355; c=relaxed/simple;
	bh=0lxp9fgkMSqXRqet6QDcLrjZVWsznGOp1aCABxqMD9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ePp1Ztqmyb7uynhhJusIOKPLxxx//6GTGAjAZKO4v4qUf3Lw8AFoZhSdK6XDl4rscAIt61uGQBUfgbg4omr9znIxvrqZXWYIzR6Bz4jK8rFwIESPv+YUfEwKWdciZCPW/tmQ+AIAcGqFaK2mHQysQbJam1N7MIxWqXm65hgS6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aw6Zzbmb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dca3951ad9so10108235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709838353; x=1710443153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjtJhyRDCpI19Ewh14cBKwZVOZbV4kYbTUkGrdqq6Zk=;
        b=aw6ZzbmbRWCKxlit4GmKrPJKorpkEaA4aEPfKlsxTS3Al1H7rPZcN0uWKYdPFH1QCr
         RW+T2F6IuhGgVbE/ih1qrdaVVv7IdXwBa1HACFtzr0R+L3F7RoYU5RsHNIByMCCpH3NO
         A5DElP+rqq6dIHI632tkfLWh2eJqvteXjYGrLJ3zjhAWIY1EEB6IDWWqByHJ4i/TwVoj
         uDd/25//QcjzHaTdkgraoM9YY5w+4Y4KaTgbMMrm7R4raOmf7KrBTdKCwV3u/hSrWd9o
         czowbPGHspKt9hHKrsSylrKm1OkbM5rp5HMMwexe27UTm3fQPtSlY/BXO9R1xufMgfGr
         gryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838353; x=1710443153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjtJhyRDCpI19Ewh14cBKwZVOZbV4kYbTUkGrdqq6Zk=;
        b=AKWUxQTEbSdsLAq2XRXsgdgUW7Mc8FSdnVH8+gh4WeAxJHLG7pyxkMxDZWhFHCTrL/
         TZn22O8QyqRsWDM5PFe7176w0JEaR6NAuProR1zHkGfOBP0Fc2Gl/bKzAw77fqjwHFG8
         ailkNE8/EuyJ5b2u3VZyIXZbtqJy6igKSQsliEY0078wLvsa04E1+nWquSgQq1Avh9e+
         Re1z/8JtmAjkRmTOFrah99soMzv/aVO1uCbxYU/HIc5smIHPts9tyT+ARLHM0f5zM+7S
         8dmADL20NDXLKJgkG7Z5QELCvTqYw5mB3NzpkAe6eCJYKKu05ju+oTaOV9UjLdXcBgPy
         pgIA==
X-Forwarded-Encrypted: i=1; AJvYcCXbYNLP8tTaaJy2fFByr1xrkaCHTnzHnYNH8BC37aCupaT78GKji3Ugl9n+8Tg0FX10oYhx4NYvAQGB5PTiyv5eOh8/hNv83E4L7T/E
X-Gm-Message-State: AOJu0YwsQjf6EaI5mE+GPxVW92WyFu5oE2hyiiVLO5qBG9Sb5rtI4swj
	BX912h/EoMZuZxmPBJf3NzJOWQRvfgMZzYCVVYQdOYxBz2udfh/6HOAUDB3pmB4=
X-Google-Smtp-Source: AGHT+IE5B0hugsWDTp99p7N7xEvh7wJEMxFLgTSlvpzLfPeOAcoxplC7fkr6cxVl+tPmkAbvsbASVw==
X-Received: by 2002:a17:903:41d0:b0:1dc:a837:7e1b with SMTP id u16-20020a17090341d000b001dca8377e1bmr10394525ple.63.1709838352986;
        Thu, 07 Mar 2024 11:05:52 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001dd526af36csm1747338plk.295.2024.03.07.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:05:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 0/4] riscv: Use Kconfig to set unaligned access speed
Date: Thu, 07 Mar 2024 11:05:44 -0800
Message-Id: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAkQ6mUC/43Qy2rDMBAF0F8JWtdF70dW/Y9SjB4jR5BYQSqmJ
 fjfK2cTUwz2arizOJeZB6pQElR0Pj1QgSnVlMcW9NsJ+YsdB+hSaBlRTDkmjHQhVeuu0N/avKZ
 hhNDfS3bQ+zzGNHSYMwuWKRENQ025F4jp59nw+dXyJdXvXH6fhRNZtsftiXS4MzoQIcD4YPVHS
 VOuafTvPt/Qwk/0RVJ8gKSNVMozqR0E5egGydYk3SdZIz3n0ZCImXNyg+Qrksh9kjcyeExAaOK
 x9RukWJFU7ZOikU5qwTSXQJXdIOWLZEd+KRspCQUXpImc4Q1SrckDh6uF9AZzYkBZ8/+X8zz/A
 XP2u9vDAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709838351; l=3215;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0lxp9fgkMSqXRqet6QDcLrjZVWsznGOp1aCABxqMD9Y=;
 b=ljet3jnYOUaIeYRX4kKRcuKAcFbCR+qmASHc8JBY/3sVQhg+/D60OJTG4tT8zR6/GM3X2ycqJ
 cpnoVXVWNDaCOX8QArrIwQCTUsSTsixQc0rdIuiAJgBeuLDO3pIBxMR
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v8:
- Minor commit message changes (Conor)
- Clean up hwprobe_misaligned() (Conor)
- Link to v7: https://lore.kernel.org/r/20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com

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
      riscv: lib: Introduce has_fast_unaligned_access()
      riscv: Only check online cpus for emulated accesses
      riscv: Decouple emulated unaligned accesses from access speed
      riscv: Set unaligned access speed at compile time

 arch/riscv/Kconfig                         |  60 ++++--
 arch/riscv/include/asm/cpufeature.h        |  31 ++--
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/cpufeature.c             | 255 --------------------------
 arch/riscv/kernel/sys_hwprobe.c            |  13 ++
 arch/riscv/kernel/traps_misaligned.c       |  17 +-
 arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
 arch/riscv/lib/csum.c                      |   7 +-
 8 files changed, 376 insertions(+), 293 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie



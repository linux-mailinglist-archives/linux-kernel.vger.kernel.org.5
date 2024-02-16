Return-Path: <linux-kernel+bounces-69311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E0858715
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2FB24FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429D1509AC;
	Fri, 16 Feb 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hTMiKAPT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405514D43D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115609; cv=none; b=WOuf2MthdCPoH98zEfqDpD5iwRnk/aKheYxXNc46yS+gFc8VA2ARTsz2cp3WKrpQ7E43sm+XCHjtAmOQ5nvITwAZtGGa2hZgqEP8FFJ3bpEugAU03zWeAT9rM0xjMkYwW8aixfUp8YzuCMt6eDXHswGmZBZvxyMYJMOnCq2d6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115609; c=relaxed/simple;
	bh=yAKgil5iGjdT26N5K5Xf0fZQIeI37RtlfXgAB02i4iY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nUc9s8FSAbJYj03gQi4xYuD+DvkyHyKdWJLBQ9C4aoRD9E+/YUt8QhGdDY0rT94gWlmAJjIvXN5hxJwKkUck+EssnFbsyApc7GkoXejoKpukR74kchjdx8DLU7NZYErF5sSumHhxB72ZqTYY0jZDYeOa5MlJi9VFE/RwLXVjBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hTMiKAPT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e104196e6eso2604482b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708115606; x=1708720406; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NzWE5WIBCpf5ZTmFY5V/bHTObz1VU0gjQMeEJG7d9OY=;
        b=hTMiKAPTutfdVIGF44uJQfN4oX8xwvMSW9/HWbLHFNC/iHkYZ30Zu6l1Va1hGkqq9k
         GBTLEOhVvTFuNOhsGnYvOkY+oyh0Jpy1WfzVXZlX9FBzIkGLbMVgsF7zhoLlZ0tezvLA
         KZqjHqxDaqYFoiZpIXXUqI2s2ETAn6um2jByUwitPrQ/yYMBAWHdFu730MMeAuT6iqFv
         Lnp2psr4hbVS1588Au+6c1pkNVIixWHeFMvtgvcOmqRvUqR424mVFMBRFo9oJNplOoxU
         rFRDgMPL4Ezwg7B8D3CRQKkFF1F3PwqwbAQokYoqBsIz8mulQkSoHjIHHNQnhN2ty6b9
         3dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115606; x=1708720406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzWE5WIBCpf5ZTmFY5V/bHTObz1VU0gjQMeEJG7d9OY=;
        b=cwNpxUAvg3gMzWWHRSoRsoVFNCrHPx9fXYJ+6cg0V8kHPNEhNL7oVhUOARrxs3ds+u
         gVgTmgwbMC6veRQpQOOrYatrHABQKAthup2rN5sNJDV7GNxFrkaThL2RQeGZgoDS267s
         5MKjWEF66v8NbW7bA+2iHgxj3YZLuLpswZuwVmv1SKExeF8Ey+LCpYT0mi64mJzxUynU
         dyoIaykAffqrLo+TFPoeQI1RGj9bjtrGsu5jvkDv7FXDezlV8d3/kzmb7ctrIOV4BHwK
         mUUDIofSGrEv2Ce2KoUEfNHvE9zHrzusjUhvcn2EQMCPmdA9TEA/ire35sCtdMerbuPP
         eQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeZ1Q85XqLOe1BTvIao0b9de+L9G34HrNitXTpFbXpTEUjrJ3RL2FTSVF1AN8WQ4anJa8DnVnkbDDhrFoZ9DNEcJzhm2RrUzSMwSU1
X-Gm-Message-State: AOJu0YzpHw9WZEo3My07UBcD6Rd2A5WMLPcxEnmaucWh1r0B4oNIb+y3
	DprLTVLxLDRd3pkt34AdnEvnCXT29eVKylx4F4SI1056kdDd/AjsmrAfpAk2OgA1A0nF1qlwirc
	n
X-Google-Smtp-Source: AGHT+IEVhbPcWzD55yw+Y7FJ5a5/7r4jpRGA/7IFcvDtH0t0CDKBUnIYaYNUkpWQ2BiBJU+p07ZlYA==
X-Received: by 2002:a05:6a20:c906:b0:1a0:911d:e4f with SMTP id gx6-20020a056a20c90600b001a0911d0e4fmr503112pzb.33.1708115605908;
        Fri, 16 Feb 2024 12:33:25 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b006e091489776sm369918pfg.92.2024.02.16.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:25 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] riscv: Use Kconfig to set unaligned access speed
Date: Fri, 16 Feb 2024 12:33:17 -0800
Message-Id: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI3Gz2UC/43NywrCMBCF4VeRrI3kVtu68j1ESi6TOqBJSSQo0
 nc3ulFE0NXwz+I7N5IhIWSyWdxIgoIZY6ihlgtiDzqMQNHVJoIJxbjk1GHW5gjDqd4jjgHcMKV
 oYLAxeBwpU1KDlm3je0mqMiXweHku7Pa1D5jPMV2fg4U/vv/bhVNG+87xpoHeOt1tE5aYMdiVj
 Sfy4It4kYL9QYpKtq2V686Aa434Qsp3UvwmZSWtUr7nnklj1h/kPM93+lwUUXcBAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708115604; l=1835;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=yAKgil5iGjdT26N5K5Xf0fZQIeI37RtlfXgAB02i4iY=;
 b=BN1ENEKrMEo8ZtA4kCbniJfEZ5tGU5bD879ggcvgytzCbBDPp+jAEUqS9S/ESeyVDiXM3VD28
 K/v6hM7AKaDA4OzThqF0hDpZ/IYjCFZUTCwgFHNtuyBGo1ZetswNh2R
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
Charlie Jenkins (2):
      riscv: lib: Introduce has_fast_misaligned_access function
      riscv: Set unalignment speed at compile time

 arch/riscv/Kconfig                          |  58 +++++-
 arch/riscv/include/asm/cpufeature.h         |  45 ++++-
 arch/riscv/kernel/Makefile                  |   6 +-
 arch/riscv/kernel/cpufeature.c              | 255 --------------------------
 arch/riscv/kernel/misaligned_access_speed.c | 265 ++++++++++++++++++++++++++++
 arch/riscv/kernel/probe_emulated_access.c   |  64 +++++++
 arch/riscv/kernel/sys_hwprobe.c             |  25 +++
 arch/riscv/kernel/traps_misaligned.c        |  54 +-----
 arch/riscv/lib/csum.c                       |   7 +-
 9 files changed, 454 insertions(+), 325 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie



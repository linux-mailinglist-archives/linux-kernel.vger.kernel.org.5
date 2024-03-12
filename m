Return-Path: <linux-kernel+bounces-100940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D42879FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD99E1C20EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9764AEC8;
	Tue, 12 Mar 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fCZFbCpO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C478347796
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287625; cv=none; b=dfVOqKUuR/WT7TpSXM61mvZL+tVSPgQPRYrbB31WP2OClwT3KNHfpAEep/y1ysIgxBz2TcVUM+tguqouClVXfBOVwJyAA82tbS9HQ/uLkrEKEoIgsqAeRYSTf44EQv08ExYBNwzSI3vh/C299hdK+6JBjH78YxY38y6Ay0XqcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287625; c=relaxed/simple;
	bh=XX2+/VdM5mhKCZhAjluqbyHqY+H52dZCZSEOzxTDQYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kmeO1DbXtgWJT9EcSiJgKBpV8Zk1LAFq84QP/i+1MdpeyUhbIxKT2maCPh5EX/6MwjuSIuWt0L+fXrk+H8c9FOoLTtrjP+4g/O5SGoe4RUlbVKEdruin+xvpHEYwQECkCzcg8imLJJzXVftUopNZbDnj1UkQ4wC1hrDjFESmM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fCZFbCpO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd9568fc51so25940125ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710287623; x=1710892423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbaFnomR7UPqP/ib9gPmxvX9sB23kPs908oJq/nrjUk=;
        b=fCZFbCpOZXwhcivwwGkhr6/IzfmKa/vJro0W5H9Zti5+WmR4+T1rsdYHzCcAOs/lyN
         DUxLC682QlHMUphDRNdjKMV4uGfdjXz6FjpBd8CoS2DtA7rM5hcx0lsQS91PAXGPnx1n
         5qMpEWiYKreGMaOfe09Eg7Z431jqxu9hMTDYmdK77gsa6qCMmNhNijk44rfUcaxxcT67
         2woVWwAl6BT8FVV4g6TmRuPCiIQFMreaiqhXGOIkZzReJ1HQAg1jodD5k+X1Cr3L/dFS
         1oK4e3qEyd9rKKjgF5oqKpuNkbW0YYN4VMcm4o0ASITeDeuEUXlMOVAuqA9K69KeEk1C
         TsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287623; x=1710892423;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbaFnomR7UPqP/ib9gPmxvX9sB23kPs908oJq/nrjUk=;
        b=Av/BahNNSTqATpgxjADyIo8JMqIqGHAp3xWyGQ481b8UJHLJqk3v5pgvk1FScvcnEm
         sX3kyk15LFbTR5inS0GlNYPzCe6eFe5lOI+w3EHoercmm9O2BvGpA56grNYHB0mX81v7
         PobYNCXoHVZMfa6d+pWZHWhM7kvQPJNtiF/7VP8/rJ2dqgQLZPxS6Pgyg57J7a2sMEkW
         d0dEY4BlxsKo/1GQQvqs7HZUlBjbTQGZZuvX7dELtKO0B541h9U6qTeMrsBs5j3kxIdt
         WOicZxaPkEwodye8gNC4C5nomYpyU7vykB6y0f2w/FpRWiEjZDksdutjjRf2a6beHVBt
         WOHg==
X-Forwarded-Encrypted: i=1; AJvYcCWuLqSqZOzUcS3r4oyPSSkdFx548g7VUCfW0Re5qkqaPeiRNa+TSeVRCKIfbtYKsGX+AQPZ229TLuyoC2qvSNgU+0Lu7dOEaKwLvijE
X-Gm-Message-State: AOJu0YzOojUXYa2LLDh000KCVTrlVuddz1HY22SME4BHdXhO+L0ffGXB
	5Zc6FP/eXQ5Vu6lc6IDuRUMJDPEVJMJn1WD1h8Zk/uUwpDBF6bUCrDbfYME6Ekg=
X-Google-Smtp-Source: AGHT+IHVbfM3Upj8dQ1ZiJAogAez9qyzrGsHmhX8elIUp0oPQ1+icC5GBmRm1mIUrYnc9dn7CC/z2g==
X-Received: by 2002:a17:903:110c:b0:1dc:2d65:5fd1 with SMTP id n12-20020a170903110c00b001dc2d655fd1mr13242321plh.2.1710287622877;
        Tue, 12 Mar 2024 16:53:42 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm7282844plw.239.2024.03.12.16.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:53:42 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v13 0/4] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Tue, 12 Mar 2024 16:53:39 -0700
Message-Id: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAPr8GUC/23SzU7DMAwH8FeZeqbIdpwm5cR7IA7Nh1kOtFOLK
 tC0dyedWBuhHGPl909s+doscU5xaV5O12aOa1rSNOYDqqdT48/D+BHbFHKhISCFiKaVOPqYWum
 lg2AsywBNvnyZo6Tve9Lbez6f0/I1zT/34BW36l8E0SNixRZaFz1YRO8I6XVO67Sk0T/76bPZU
 lYqpIJdUpbkXUdqcOhQKlIdklDtUm1vGo3akrLRmYrkh2RA2BteOcvAXkhcDzqoitSltLvUWQ4
 DRo3BEFHtt10p+112WQIjdtkya1+RppB4zNZkaaxAhxwxOKhIW8pulzZLVgPnqbEAYUX2haRjt
 v32JubvOok2mJpEKCkfqwDbjEj3BoUVYKhZPCwVreK2RxEVGSEtEWu9Ih1WlXbbJBDFIADs4/9
 9uN1uv40iyc4kAwAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710287621; l=3918;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=XX2+/VdM5mhKCZhAjluqbyHqY+H52dZCZSEOzxTDQYM=;
 b=iDe63BieDVlBvDEubOrVk77TNEJxUHkq9FbutFVORS9XaaUJEGTcCrNlCGaHxB4IU2b09a6yq
 HqFpMP4qtBbA2AOKshD8M+PGTA+ek+P08cDFlAKWtHCiY0Wq6hEEM6k
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

Patch sent to add PR_RISCV_SET_ICACHE_FLUSH_CTX to man-pages [2].

[1] https://github.com/riscv/riscv-j-extension
[2] https://lore.kernel.org/linux-man/20240124-fencei_prctl-v1-1-0bddafcef331@rivosinc.com

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v13:
- Properly unset thread.force_icache_flush (Samuel)
- Add ctx value checking when SMP=n (Samuel)
- Remove duplicate bit set (Samuel)
- Link to v12: https://lore.kernel.org/r/20240312-fencei-v12-0-0f340f004ce7@rivosinc.com

Changes in v12:
- Use context.icache_stale_mask instead of thread.icache_stale_mask in
  PR_RISCV_CTX_SW_FENCEI_OFF (Samuel)
- Link to v11: https://lore.kernel.org/r/20240212-fencei-v11-0-e1327f25fe10@rivosinc.com

Changes in v11:
- Add back PR_RISCV_CTX_SW_FENCEI_OFF (Samuel)
- Fix under nosmp (Samuel)
- Change set_prev_cpu (Samuel)
- Fixup example testcase in docs
- Change wording of documentation slightly (Alejandor Colomar)
- Link to v10: https://lore.kernel.org/r/20240124-fencei-v10-0-a25971f4301d@rivosinc.com

Changes in v10:
- Fix fence.i condition to properly only flush on migration (Alex)
- Fix documentation wording (Alex)
- Link to v9: https://lore.kernel.org/r/20240123-fencei-v9-0-71411bfe8d71@rivosinc.com

Changes in v9:
- Remove prev_cpu from mm (Alex)
- Link to v8: https://lore.kernel.org/r/20240116-fencei-v8-0-43a42134f021@rivosinc.com

Changes in v8:
- Only flush icache if migrated to different cpu (Alex)
- Move flushing to switch_to to catch per-thread flushing properly
- Link to v7: https://lore.kernel.org/r/20240112-fencei-v7-0-78f0614e1db0@rivosinc.com

Changes in v7:
- Change "per_thread" parameter to "scope" and provide constants for the
  parameter.
- Link to v6: https://lore.kernel.org/r/20240109-fencei-v6-0-04116e51445c@rivosinc.com

Changes in v6:
- Fixup documentation formatting
- Link to v5: https://lore.kernel.org/r/20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com

Changes in v5:
- Minor documentation changes (Randy)
- Link to v4: https://lore.kernel.org/r/20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com

Changes in v4:
- Add OFF flag to disallow fence.i in userspace (Atish)
- Fix documentation issues (Atish)
- Link to v3: https://lore.kernel.org/r/20231213-fencei-v3-0-b75158238eb7@rivosinc.com

Changes in v3:
- Check if value force_icache_flush set on thread, rather than in mm
  twice (Clément)
- Link to v2: https://lore.kernel.org/r/20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com

Changes in v2:
- Fix kernel-doc comment (Conor)
- Link to v1: https://lore.kernel.org/r/20231122-fencei-v1-0-bec0811cb212@rivosinc.com

---
Charlie Jenkins (4):
      riscv: Remove unnecessary irqflags processor.h include
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
      cpumask: Add assign cpu

 Documentation/arch/riscv/cmodx.rst |  98 ++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |   1 +
 arch/riscv/include/asm/irqflags.h  |   1 -
 arch/riscv/include/asm/mmu.h       |   2 +
 arch/riscv/include/asm/processor.h |  10 ++++
 arch/riscv/include/asm/switch_to.h |  23 ++++++++
 arch/riscv/mm/cacheflush.c         | 111 +++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  19 ++++---
 include/linux/cpumask.h            |  16 ++++++
 include/uapi/linux/prctl.h         |   6 ++
 kernel/sys.c                       |   6 ++
 11 files changed, 284 insertions(+), 9 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



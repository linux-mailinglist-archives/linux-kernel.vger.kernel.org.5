Return-Path: <linux-kernel+bounces-37941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910683B89F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E425F1F24AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD7710971;
	Thu, 25 Jan 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ImPK+B3u"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F5101D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156592; cv=none; b=lhwkv4NqEyUCHfB6nOUNgJSmuFseu1uJjt+CAqavTrCmi6tvId+2RLOuQaNNmVvQfJzs9VXCtWLdprf6z7h1TSUwW4FMQSQkfCkSz993hYVeV0nviiX6+/4TQ/p9q1kHNx5lW7IOeY2+rkTQk0KpSBa+/GVgAdVW33y5vw/fkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156592; c=relaxed/simple;
	bh=Fp/Nsdcth0hMGV4QFLJyIHW6clYIcFNJ6WEMI/uUbQg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vGOMCUfqL8uUCwpmGfM/FTFUUWexdiGmJF5woaefrsuxWaUuU1it2CCmQeUUaV17cBUs0jZwk3o2+M2BuBS0+Dt+6jnLW3MZQOPsUmeD2ZOKrcJ75bT0l3GlWZzzivlIDaB4BtnFwxveKdixrEyPcJG78qivH6lhX3eYjJIfC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ImPK+B3u; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so251397a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706156590; x=1706761390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdsnxFeLDc7O+tsMX6XHeSkZFgA7YsQDvmpx17WI4kI=;
        b=ImPK+B3uSnxBQUMF7empJ4iH42WReotTS9BJDTwMI2S67bMKnT2q3FhvrLzYoe4T3b
         wYi7HUSJCtQ7f7/N/Oq2t3Sj3MdD9XixxtQ8k8AKZVSUmRBjT8Dzeu1Ey01nw9GZGQAk
         hOC5+oYTERUnQokqGW1qTSr/ltbYMpIdfL/4QzFp2Exvvf8NASjp1aXHd4Tutb7fFZ/o
         1W8Dsp2C91SmY5ADED1AMfxeselJUoC1yoQwQWo/wn/RNRBejndaLo7CAJWfxt4mGU3P
         SFa67xr5LIj2+7ozMEF2UCvyEhVvqCPxaWXeLluUt9fOxRuDqauxjVeGrzHsiOEsqrkj
         3Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706156590; x=1706761390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdsnxFeLDc7O+tsMX6XHeSkZFgA7YsQDvmpx17WI4kI=;
        b=U1Zi6dcaUZV+yBp/fHPkrIXVyzioiW3wP8EFKcKkUsJwB+p/5uuNrOlXhcNC4CwCT4
         FD9MMPdtNIVxdRra8Z0NBAdXg4bGroaIuwkADgwzSq6XIBHtTyb6XY4Hx88wruTfWKOC
         HnTAMFmaUZbWV5yEw1l1FBcydkYa4hBpcRmWK/RTD2vOQ64RFNglJ/pMjWtgV1A18n3q
         DNjtTRlVsnsKWhswGYAKZU98mu+MJbZ8mc+GwPzsyup9/LBIF4vaJbVA+83n2kjr3ghq
         hhiaEtX2JP8YfBVKeOZmK5TrvrPVVg6ueaaK9gB8UBk3Q0lp4o+qwGoB+ni9VVRf2Meo
         UHOw==
X-Gm-Message-State: AOJu0YxifQjkSGwIy6E5VBJQU5CXVrNk3q27kcZfof3FeQ5J6UJyRvZQ
	8AdbbUQ5Hb2ZVCL3dXnFhxGBYR1SyDV17ZhcGcPMj0B+f9LZyUHW2U7gMtOWHx8=
X-Google-Smtp-Source: AGHT+IG0c3KHNOYvKXWZKGA877PW8294s0ljZp87IKGqkduZuQ+JPtDg7C2fQbUVQ11GAN+QWsDGOA==
X-Received: by 2002:a05:6a20:9f03:b0:19a:fbfa:b16a with SMTP id mk3-20020a056a209f0300b0019afbfab16amr468801pzb.30.1706156590009;
        Wed, 24 Jan 2024 20:23:10 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ko9-20020a056a00460900b006dab36287bfsm14549743pfb.207.2024.01.24.20.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:23:09 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v10 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Wed, 24 Jan 2024 20:23:07 -0800
Message-Id: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACvisWUC/23QS07EMAwG4KuMsqbIdp5lxT0Qi+bFZEE7alEEG
 vXuuCOmU6EsbeX77fgqljSXtIiX01XMqZalTCMXCE8nEc7D+JG6ErkhCEgiou1yGkMqXe6zgWi
 dygMIfnyZUy7ft6S3d67PZfma5p9bcMWt+xdBdI+o2EHnUwCHGDwhvc6lTksZw3OYPsWWUukgJ
 eySWFLwhuTg0WNuSPmQhHKXcptpNWpH0iVvG1LdpQKE/cNVsYwqZMq+Bx1lQ+qjdLvULIcBk8Z
 oiai1rTnKfpeGJShEw1YpHRrSHiQ+bmtZWpfBoEoYPTSkO0qzS8dSyUHx1VQGwobsD5Iet+23m
 cjr+pxctP/luq6/EfVc/3ACAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706156588; l=2933;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=Fp/Nsdcth0hMGV4QFLJyIHW6clYIcFNJ6WEMI/uUbQg=;
 b=SvtUbRzRCSPcDsyKUxxcadxQoBxxmIhU4504F5DxcJ1phzCTxqjQPG4L5ty+vMNgQswrEoK5x
 HlIebRpycAvDGysjIrrNQ3pIhmMKVTQ3CdAEmLCsQkAYHOsQyG0xTtr
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
Charlie Jenkins (2):
      riscv: Include riscv_set_icache_flush_ctx prctl
      documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl

 Documentation/arch/riscv/cmodx.rst | 96 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 arch/riscv/include/asm/mmu.h       |  2 +
 arch/riscv/include/asm/processor.h |  7 +++
 arch/riscv/include/asm/switch_to.h | 13 ++++++
 arch/riscv/mm/cacheflush.c         | 67 ++++++++++++++++++++++++++
 arch/riscv/mm/context.c            | 13 ++++--
 include/uapi/linux/prctl.h         |  6 +++
 kernel/sys.c                       |  6 +++
 9 files changed, 208 insertions(+), 3 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



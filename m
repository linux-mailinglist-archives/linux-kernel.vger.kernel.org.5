Return-Path: <linux-kernel+bounces-62543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DB85229A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185171C223A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24D50273;
	Mon, 12 Feb 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M3nABIb8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528C4F611
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780994; cv=none; b=nL1c36eZ7KmsmLeh3fShrkmWOCm5W2mML2j0G96kVpqA3w8QFxmySo+QvhLHYy8JGM0lLlA7jEIrsj9KuzsnAQxuWLqbfzSgMURt6jwcSj2NpzOjdAJ9cRDDk7LIoyt6UBWgu2tmTpUKgC5irDQPoBur8rc3CfQ006X8BGguN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780994; c=relaxed/simple;
	bh=pUkJcJN2rctCyQ0hK/qiJS411FCsdKiJii0pjIPLWbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lyWsfMTXW44g4juzS90IUlgKEETynj6iu4h0n++cdQzOzwZSCrqhL8Hw58vdHfhmeQSwOMZtnqIMnIn4kU1CPFa5x2+l/KuKtf2zq+vm2svUVQcf3MfIbdhQuNfG9hQ/LILg3cUl0bdkbfoG3qwaAFcqhjkZIYa7McKrIEosAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=M3nABIb8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d780a392fdso31488755ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707780991; x=1708385791; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNioNdguCz5tyqf3w8SAJg3WWFu/ZpF1hV12mYbLuZw=;
        b=M3nABIb8Duqd1/WqTQLCDTwxg+B5jxrOMCM13OuQ6X23HAea/NPLKfEUtTITKl9omP
         Uq0BBS9EazJ9EUgNwwRIXhXU1yEO8EdObHVoVdX+EVs2Csqln6APqSx9Ote7dDmgvRMc
         G62DiHTNe7YkhRuBuyaLgdEzd56pMZpHtftQcRDfPwTnI1M458pxlQeHExvZq/yu6Hg6
         BiMzBTvDtA1yKEW9S801lDi8t9oQE1HiBqrtuia6wnYP1zzge75zxYfVCBxaNj+DAsZ5
         IexEU6twYcCZ506jEYh4UyQbg9m40IVi8RWforSrnW9ASDi1/vGDW8lFCoO3qT/u7Jkp
         70tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780991; x=1708385791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNioNdguCz5tyqf3w8SAJg3WWFu/ZpF1hV12mYbLuZw=;
        b=FSrLlfb7sXdUY2Urr5Fja6CYd9Y6fRhATISI48ljTk8NbHCh1LE5nQAbBIIgy9Y98d
         idVDsgVy90q5Ah4LAV4jeBNBqxWFIQxxYjGMvoVXMVli+gJ1Y7PijAcdzG8GIAkvrkT4
         4FxvKok8rNlc76M+45vqOqeXefaubeuFO50denFb3dabZ47e2wo/dS2Yq5714oSWutd6
         avQ1pj6XpbbrW0ezQGaSOqyhHr3IO11Hu34A3Cp4czG2QzenUTpSBTXkcrMt+HZfYaeO
         S4RfIWUmkpILMK5ZaQ3lDFsC4uHeZW5jBfTbIDJRq3g6eGSjqIqVO51RkeZz2FrwrQ9E
         zfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUyNBvqQPHl6J1Ml/Djc/BoemGaW6K1RBSGFMxFEj+AJhx8TCxOgY8SLzg7lxKoyR66Kbt9Y9AWmIb+ZZovjTaQaF17QvJViTmfHaY
X-Gm-Message-State: AOJu0YykEYtFgMRkqV+C7/jtmZj6DqauVGmYrAAmQzseCwNg8cZeoNhU
	yk8c28Wl7oGPmubh1UdyNbKZuXYjdStHXlR0/TqvPf8tReig64CtM9asbLjeYwU=
X-Google-Smtp-Source: AGHT+IGlzxazBjxv9RA941+ZHFC2kAe0rM4VKTlBx4LwX5kenDzB6/KnJLHG3CbaBKLMEuWgOEr4pg==
X-Received: by 2002:a17:902:e5ca:b0:1d9:a5ec:30d2 with SMTP id u10-20020a170902e5ca00b001d9a5ec30d2mr11052876plf.12.1707780991294;
        Mon, 12 Feb 2024 15:36:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpvQ/bifwy33zc0j7hfXTIrBarDTDQRSnG6jYoRxhctuzyMpZB6R4vMI76zxbUXHW0cs3V8WLKORH+/uwFPaweDLNxZ7qbduxPCHHp0g7FFkebRIRxtn2bizXbAPcSXa8QVUUu97cm7VTqO4JHVM283X7nKupleVBuXX3tbwbUi8IlEBnYoLbiSp+JhOnGD8VzLBXHn3gVtZ98YrtIhUVagP8HgaUEES4xH8F+9CuDEpfjLP+N/q2901jsLZ9+4IZmDRonnYLIENZ54LTACnJQ9/BheuZoViYtxjyRimNQJyM4fxmdG+920Nh0ZHC0kiYnoZPYtLsiKBcKkrRgH39F49cjZ9FbEyrWwykOK+ncNr596z6qNw24o1R3+Yuu80MZg+QWKMUcCTADenpd1O/lte6A4HetVbCQKl2Byf3z4eDJhGCHuVB6E/Dt08bDCsftsF0=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001da153682c5sm888693plk.261.2024.02.12.15.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:36:30 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v11 0/4] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Mon, 12 Feb 2024 15:36:25 -0800
Message-Id: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHmrymUC/23SS07EMAwG4KuMsqbIdpxHWXEPxKJ5MVnQjlpUg
 UZzd9IR00Yoy1j5fjtWrmKJc46LeDldxRzXvORpLAfEp5Pw52H8iF0OpSAISCKi6VIcfcxd6pO
 GYCynAUS5fJljyt/3pLf3cj7n5Wuaf+7BK27VvwiiR8SKHXQuerCI3hHS65zXacmjf/bTp9hSV
 qqkhF1SkeSdJjk4dJgaUh6SUO5Sbj2NQmVJ2uhMQ/JDMiDsD165yMA+UXI9qCAbUtXS7lIVOQw
 YFQZDRK1pdS37XeoigRF1sczKN6SpJB67NUUam0AjRwwOGtLWUu/SFsly4LI1TkDYkH0l6dhtv
 /XEMq5L0QbTkgg15eMrwLYjUr3BxBIw/LO32+0XwJEEjKwCAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707780989; l=3458;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=pUkJcJN2rctCyQ0hK/qiJS411FCsdKiJii0pjIPLWbg=;
 b=MPwj9l2ctTE9U5PMrkcabg29HVx1LnyHJJ9FmdT2NRt6a6jiZmF+27/ABOvnKjANPSgri2Nzk
 yny/fD+G20bBSrkLd6AMgL81mkbhViWypSaZGxhLbhPl1JRHJHuVKKM
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

 Documentation/arch/riscv/cmodx.rst |  98 ++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |   1 +
 arch/riscv/include/asm/irqflags.h  |   1 -
 arch/riscv/include/asm/mmu.h       |   2 +
 arch/riscv/include/asm/processor.h |  12 +++++
 arch/riscv/include/asm/switch_to.h |  23 ++++++++
 arch/riscv/mm/cacheflush.c         | 105 +++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  18 +++++--
 include/linux/cpumask.h            |  16 ++++++
 include/uapi/linux/prctl.h         |   6 +++
 kernel/sys.c                       |   6 +++
 11 files changed, 282 insertions(+), 6 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



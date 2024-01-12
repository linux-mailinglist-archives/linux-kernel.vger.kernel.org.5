Return-Path: <linux-kernel+bounces-25119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D957082C825
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864C2287561
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF501A5BB;
	Fri, 12 Jan 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PkrIwmkx"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314821A704
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d50d0c98c3so50468935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705103782; x=1705708582; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSP2/M0KF32uiW9ftv4gIz5p6qLp/uAAFpBRC32J+TI=;
        b=PkrIwmkxohlRJU/d07XlG2GcEnufRN9A02Roy165B3fHrY0FAUKApq/wf2//k4HDpo
         1LS2tXSK6gJzuX6GFB23gETZbPkL1QkfEzXetqeymlBVdl9xWzpghYyIglWZE6dEyEwd
         qmc5d7PmwEIOjMzbwMRrIyiMJ5jO9JRGvkyYjHlDgkB1u/DWv3+VdaflmJUCDdMukUKt
         V90PHVFyrXyFTw1dDexv5M7IzO8+oIrpgwZGAO5MkdyUl4vVAuTXn7iQMLYNI9VRBJWy
         kk29PRAQmJNYxH4NGzCGbvsiCNflZsaiF0ebvQqwlxrH0sXea/HyIbtjg04r7fnlge3R
         AGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103782; x=1705708582;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSP2/M0KF32uiW9ftv4gIz5p6qLp/uAAFpBRC32J+TI=;
        b=hidKnO7ODBI271EHofocFENaMKcY+JSRAyYE1kFD7lp/0KaKGcCHeMyx8PunSMYYbo
         QnQAgNLFNte4Qn6pXdCkAzpINb8GePi+CJPUISaZI0MvMuZMO0aKVKVMiNerRbHgyom4
         XuukgzZIfxbLA4QuZ9q5pz2FWdOHlzAuB78TTrcEreHxKRh5OYBhytJ0KiDoPkvRxhue
         flwtmPDQRiVG2GlE8XkCxnkFYit0/IovX+O5YtPsVIv8Dx6P6DH7l3OLVo4DJxf5J6Ci
         GgeQYLuClfmF3B99HPkmSUSgkPvuhx2cDJy8LX+AROm6A+SIrqzWRc1h1UZDxvgOuGWZ
         dlDw==
X-Gm-Message-State: AOJu0YxSK3BRYRD/BejHsy85S+ohjvBiGLZSiwprhPSyyyVAXac1cjO8
	lXs/+SPLBBGnZYcRnDlaZKe70N3VZB836A==
X-Google-Smtp-Source: AGHT+IG4gBtsgyIEpgs86D5iPR6zSD6ZpRdErJUi2IQ159YkrAb7SJNIwIw42d3KQh/fXO2CV9ZaQg==
X-Received: by 2002:a17:902:8e88:b0:1d5:6600:3d96 with SMTP id bg8-20020a1709028e8800b001d566003d96mr2406125plb.0.1705103782367;
        Fri, 12 Jan 2024 15:56:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001d3b3ac2d7bsm3725537plb.245.2024.01.12.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:56:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v7 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Fri, 12 Jan 2024 15:56:19 -0800
Message-Id: <20240112-fencei-v7-0-78f0614e1db0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKPRoWUC/23Py07DMBAF0F+pvMbIM36GFf9RsfCTekGCbGQVV
 fl3nIqaCGV5Rz53PDdSY8mxkpfTjZTYcs3L3IN+OhF/sfN7pDn0TJAhBwBNU5x9zDRNSbGgjUi
 Wkf74s8SUr/ei81vPl1y/lvJ9722wTX8rEB8VDSijLnpmALxDwNeS21Lz7J/98kG2loY7ydmQ2
 CV6p5BbBw7SgeR/EoEPybedWoI0yE10+kCKhxQM2Di4iS6D8AmTm5gM/EDKvTRDyi6thSghaEQ
 8+q3ay2lI1SUTAKpbIaT/J9d1/QFjEzRawQEAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705103781; l=2142;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=7NrtzZUolbE1vnII9PeZvgH9s80f0X/yu6SBfBeEopk=;
 b=HXQxAQ9NQYkhFje02cXtnO0r4RIu8BhoepGEzSabovWAoFxMm370RSGcwi/8QMIe504Z/ZWoz
 UGWzld43/vFAHaiwNSNwGs5jUDbS0KCsFlDVMvBVtVXbSYr2TihEDos
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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

 Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 arch/riscv/include/asm/mmu.h       |  2 +
 arch/riscv/include/asm/processor.h |  6 +++
 arch/riscv/mm/cacheflush.c         | 67 +++++++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  6 +++
 kernel/sys.c                       |  6 +++
 8 files changed, 181 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



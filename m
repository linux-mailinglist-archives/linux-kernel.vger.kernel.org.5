Return-Path: <linux-kernel+bounces-21271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA00828CDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFCB288254
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC93C693;
	Tue,  9 Jan 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eGZTpIqT"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DE3C46E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2041e117abaso1708935fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704825808; x=1705430608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8tIh5/SJkOUUlCOBe2SBZ/CeVYcs+QLRLt1HCIE+Zg=;
        b=eGZTpIqTC3OdpV4DsMftIlv+OQAF2OyycmtkbbqJgAy3+8LIn2yJVWHmtMtI6IZCm3
         gnM3b+r0aD+PiQio25cviJloaDTwJpQb0oFOg5pOcR51yd8NXt547GAARt6uk4YN1aP2
         B0Kup1Pm3zumfJQuMSS/5LSL/5VNmO/G5e5HjTyRqT6qhay9oEeA53DscZ97mwDvy6Zc
         q5Tm2/qYubRccmeQWz3skgVjy/FNX5yt3mrq+GBMwPxq1KRLS0O1lAQoqbCQ3FdId3YS
         AVqyMvKTFM+Vujn/D9ip/NCtel8O8liwxLyBOkAEyWgwiGSuz0cvlTJL0FqDpNZ1LDiA
         4h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825808; x=1705430608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8tIh5/SJkOUUlCOBe2SBZ/CeVYcs+QLRLt1HCIE+Zg=;
        b=aIN92XlBfZVt7EPGG8YilRLaQ0WpCgldbcd29zIDxu12yCGKiZkw4zXjEX3ly5Rt+N
         oAn2CmoQAlPmUVvcCw0qoqiI+KkYVlKYEn7OrYHfKT7A+A5SZaaTsBeOIIbKi/wgRqi1
         nqlexWm1triZ4Avcr6Oed4u7T6UqGvmVjlVM/DiJgSdBeci4VP20xc8juVZo19D3fKEu
         FtnTA2mXDolPKusP7lsvtlcBfTIZtTdwbZGwGM0Y5+Px6yb5gYxV91kumRKONYGErUZR
         1zSppsOHx+LkZ/5PJyW2lWxkzgsubaSiFtx3RvWEnqhXIzxfiiuZBqcFYfC6vR6vUsJ1
         qokA==
X-Gm-Message-State: AOJu0YysgrDSgBU6FxiIX8z2ZaQy2G+2UfTiETP5E2m+Kb9SO9KvNNMO
	t7g86/aEkXKF2XdhXH8Gwn20Mhaym4JukQ==
X-Google-Smtp-Source: AGHT+IFcxswKi7F7pE1xwoT7t0vdbShn5ks82furi63XCAnlNWziga0jcShQ7a72MoVw6ae19zgnhA==
X-Received: by 2002:a05:6870:d14b:b0:206:d54:7b2a with SMTP id f11-20020a056870d14b00b002060d547b2amr4357731oac.116.1704825807883;
        Tue, 09 Jan 2024 10:43:27 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j2-20020a9d7682000000b006ce2c31dd9bsm450423otl.20.2024.01.09.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:43:27 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v6 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Tue, 09 Jan 2024 10:43:24 -0800
Message-Id: <20240109-fencei-v6-0-04116e51445c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMyTnWUC/23PTW7DIBAF4KtErEvEDGBIV7lH1AU/Q8OidgURS
 hX57sVR40SVl2/E94a5sUolU2Xvuxsr1HLN09jD8LZj4ezGT+I59sxQoAQAwxONgTJPhzSIaKx
 KTrD++LtQytd70emj53Oul6n83HsbLNO/CsRHRQMuuKcgLEDwCHgsuU01j2Efpi+2tDR8kVKsE
 rvE4AeUzoOHtCHlUyLIVcplp9GgLUpL3mxI9ZBKgFgPbqrLqELC5A9CR7kh9au0q9RdOgekIRp
 E/P/beZ5/AdWDF6iHAQAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704825806; l=1943;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=fXFUftloV5jzL0u4aeVUYxoLDAW2ZraqE9n+Yoo2iUk=;
 b=NAtn7SuloNiPreSBIIN21r9pJE15rERzjhOZSODLLXEdLhVRFRC8siAHMji5UtZHKbUt+hl9p
 Ho5wmA+uqyvCZcZ+W2SeQp3SK39CsEpKGvR1kOj5ba0MSK+R4hNMYAb
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
 arch/riscv/mm/cacheflush.c         | 58 +++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  4 ++
 kernel/sys.c                       |  6 +++
 8 files changed, 170 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



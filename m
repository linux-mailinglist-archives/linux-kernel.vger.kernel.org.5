Return-Path: <linux-kernel+bounces-36187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5C839D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F42884B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A154676;
	Tue, 23 Jan 2024 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ToiJMkEj"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6E55C20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052684; cv=none; b=kWQt7GqoRQBVGhjPwTnYZr0a8oNLp6i5QuEoFErvj/KnlqoYHQ9GHGRmariy63UBygHVYYaIww8CL9Iv3HE2LjtwtAQRmIo2Qg5Ph9YWRMySHvnFBVhXhweF88e170Q/A0Su/V/uDyoi7GWg025NJHjhf5oHkj2ARVozF55Q2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052684; c=relaxed/simple;
	bh=lV3HEfTHxEddjMBrOCEy8vgSa2t7hMJLTJM/Li7jryY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=atlOfT1jHA/f9M0sZUKmQj1lmnuUs5XcuiGX5Uv7vxCCFvPMAMyuS92aZKw3blnnT8X2S642sbSVW6JLSIb6mjeg9SPok1eQhtSfL903UIXL84Miog3hdr4uO6fDc4fUjUlBhIhQgzKns8rYVr4uHbUg9ZErcegN7GkCETT8N2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ToiJMkEj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29041136f73so2538712a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706052681; x=1706657481; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPLpv78BJLsbcTo4oE701G/w7O+DnzJaribhl89oWJk=;
        b=ToiJMkEjK1GdnfXszXdLctb+U7IItZloXiH2c30SiCHvqrUFHfcoNJFX31qOo066ei
         KieZd3N4DKgHqioTqAXVVMZ2+aowL1leqOMh8S4Kro2CcNFqeLcTepvC9ivUrDwrOGk8
         l27pE149Z2oZ6EaGF/8HbfFzpNCHvOXo7A5OLXVWIiXLf+VHO8HB1/3JYeF9o4nLNjg+
         1GfYKo6YtgETcaz+mZ1RRh/5D5qG+XAQ8WF7Ik8C2w0UZLfDlqYaqLBt5DnyKP2rDldn
         ELqvi5yaM0G6W8DS5Ljdf3dIH2STiThWA+vRWjjqhHj43rhbRCIg6EI9Jla9dUAFh3s2
         65fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052681; x=1706657481;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPLpv78BJLsbcTo4oE701G/w7O+DnzJaribhl89oWJk=;
        b=ksJPDbmVl2+rpbzMIYwZhkGZ8dDxKLrvu8oi56aqk398hHaITUyWyCcV5yz6PiR5l1
         vmLacYNj6zXpLbQM7NfN1FJIX3qQbYTBHs4kYBBhEwr3LOsDvfQHWkiM67FsvNMUtpBG
         FbsESbDSqRvQLOngLFxftsS969YAJgy9C3zRSy95LVY3iYaP1G9J6G6khrYp+BPlCfqh
         ScpOiBPZlSUKIIsujVBFILm3eS6rwHQmfT19dwfNC3YaEW30OCJgHH1TGT4QhJXFtTll
         UrCX1/kQCs42CyAteTZ/VlVw47N19huUNp/xtzv+oXsITY7mVttP/2xbYlUojYYhZ5tL
         GedQ==
X-Gm-Message-State: AOJu0YwxXYM9haCiNSGmp6baadKT7mTKgmFYLn7BvRk0vqYftVaYfHjt
	FEodk0chBn6VwQG2Ovbfbgu3Y5RE/+qfd/Snotx9iQdvhixCIUiD62oPsyIP1yI=
X-Google-Smtp-Source: AGHT+IHHSMC8/iZEuQB8Qml5Ex7QP0EZ31R59Xy2rbYb82NH/5U+IKioHdrHvmukE6W6REgdnH4DPg==
X-Received: by 2002:a17:90a:98c:b0:28e:848c:74cd with SMTP id 12-20020a17090a098c00b0028e848c74cdmr3073763pjo.49.1706052681639;
        Tue, 23 Jan 2024 15:31:21 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b0028d19ddb1afsm12150698pjb.33.2024.01.23.15.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:31:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Tue, 23 Jan 2024 15:29:50 -0800
Message-Id: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO5LsGUC/23Qy07DMBAF0F+pvCZoZvwMK/4DsfCTekFSJcgCV
 fl3nIq6EfLyWj7XnrmyNS45ruzldGVLLHnN81TD+HRi/mynjzjkUDMjII6Iekhx8jEPaUwKgjY
 iWWD18mWJKX/fit7eaz7n9Wtefm69BffTvwqie0XBAQYXPRhE7wjpdcllXvPkn/38yfaWQgfJo
 UmqkrxTxK1Dh6kj+UMS8ib5/qaWKA1xE53uSHGXAhDawEVUGYRPlNwIMvCOlEdpmpRVWotRYtB
 E1PutOsqxSVUlCERVrRDSd6Q+SHzsVlepTQKFImJw0JHmKFWTpkrBrahbEwkI/8lt234BbhBl9
 TUCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706052680; l=2561;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=lV3HEfTHxEddjMBrOCEy8vgSa2t7hMJLTJM/Li7jryY=;
 b=eE/8vUQ4mnp83HBoM+DinjzgmoC2nyziyWltlbuhSI/ppEpbLIXS/l47joIaKNXOamXEJDW85
 DNF3bcPoiEFDCK1T8jgp+pP0rYj7Ill0HnKJ0yugVksJ69ECv4DtfyJ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
 arch/riscv/mm/context.c            | 14 ++++--
 include/uapi/linux/prctl.h         |  6 +++
 kernel/sys.c                       |  6 +++
 9 files changed, 209 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



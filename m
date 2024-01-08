Return-Path: <linux-kernel+bounces-19985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C418277DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4281C22FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E454F8F;
	Mon,  8 Jan 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2tLL0GVD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAE54BEB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2044d093b3fso1758131fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704739359; x=1705344159; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nOCifhuDAF11Xb1y36KLhAB8txEl19e9KXFbeS4gyw=;
        b=2tLL0GVD30E6OQOU9VVhPDk98+tOjAOlHrN3Hrz7SihFOFiUWDJI+djCyjj+9zo9lz
         3YU2n6VICW6QBQwEoa2j9sp4uidTR7oFq4aLQG8AmKYzI8Mkk+nTyeJHXrqy1e882iYT
         Hvhu7XECK4JhhKS6rK9o+4d9OReaaDzAm8ZhxtNoew4TuyjBhHm/EVfFuQUdoexGX5m1
         tFTGQoJ+4oXwjEk3252u9FB35LrggidD7ceIJ6QJVPj7BdPXNT6EMVNfDJMBEaVSKd3o
         f0U6cL3rZvkODVof+tLbQzWXh1drYjTNdRdCFK7+LfuKvKNI2fCDPMlDDT2UEUc5yBRc
         NK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739359; x=1705344159;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nOCifhuDAF11Xb1y36KLhAB8txEl19e9KXFbeS4gyw=;
        b=dC+n/nGqgB/IkvnzsLY5gxsORKOZ17gf8WwcziIADCB+99G0z6A5kq58oPLzJBmuN3
         TxeX9ygJu5TAslV96hAiaJWS/FzEhw0r0ri5XQWtstUShDduh4tLWhChUMzpa6umr9ST
         vE/v1V3qJ09SFJ0pjh+6TeHluw8zDdsi11rHtdYq2lF9TAsh7No+N4q69a6FoujqQXuX
         Pqs5sErx1rjO0IJJGdPbysqa2B3HHMKO7EGqvHtj0dlcKbcV9hwi3vjVXdamkbEA8I0y
         49ejx0oNDrLrG77LPteQBeoL8xqZiN10nXoymm/LlmP6TQvRn/5s22vm6NxqsdHGmUqi
         rJzQ==
X-Gm-Message-State: AOJu0Yya8Wquw0OLQQr/V6kq/h5uSl+kPkEiJH6xlgqYaDBR6N6erjXA
	SY1h5NyG6xfhVEfu9C8RCMZk0Pi+7YrzLQ==
X-Google-Smtp-Source: AGHT+IFBhwdGEizekSKi4JNYjZjHKzpIt3Wz/KrnO04cinNIvQ+drTPWlQ+A/SCeEXr4sswGa/DJsQ==
X-Received: by 2002:a05:6870:91cd:b0:204:302f:74cb with SMTP id c13-20020a05687091cd00b00204302f74cbmr5618403oaf.24.1704739359134;
        Mon, 08 Jan 2024 10:42:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id pp24-20020a0568709d1800b002044a0677adsm97860oab.8.2024.01.08.10.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:42:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/2] riscv: Create and document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Date: Mon, 08 Jan 2024 10:42:28 -0800
Message-Id: <20240108-fencei-v5-0-aa1e51d7222f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABRCnGUC/23PTW7DIBCG4atErEs1M+CfdNV7RFkYPCSzqB1Bh
 RpZvntw1DhR5OWHeF7EpBJH4aS+dpOKnCXJOJRRfeyUP3fDibX0ZSsCMojY6MCDZ9FhH2rom9a
 GDlS5fIkc5O8eOhzLPkv6HeP13s24nP4niB6JjBq0Yw8toneE9B0lj0kG/+nHH7VUMr1IA6ukI
 sm7mkzn0GHYkOYpCc0qzfJmU2HVkmnZNRvSPqQFhPXD2RbZWx8ouD1UvXmT8zzfAOamo+VNAQA
 A
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704739355; l=1802;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=6KNeJtSft3TzqK/eFueLjOMt0bd1sLwSYJMWIyfbYI0=;
 b=vMikdA7TGJkoeVdq0Tn488ZeRydrutnxr/h5WWzxF168I0ofq4f+j+tnBgjLzA/QnKYhZjICD
 Jyvi8cks/1TAsDtEcNbyiyigWNNKiqvbIjmsdAUhBCF/ufU605rgoo3
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Improve the performance of icache flushing by creating a new prctl flag
PR_RISCV_SET_ICACHE_FLUSH_CTX. The interface is left generic to allow
for future expansions such as with the proposed J extension [1].

Documentation is also provided to explain the use case.

[1] https://github.com/riscv/riscv-j-extension

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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
 arch/riscv/mm/cacheflush.c         | 56 ++++++++++++++++++++++++
 arch/riscv/mm/context.c            |  8 ++--
 include/uapi/linux/prctl.h         |  4 ++
 kernel/sys.c                       |  6 +++
 8 files changed, 168 insertions(+), 3 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231117-fencei-f9f60d784fa0
-- 
- Charlie



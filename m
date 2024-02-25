Return-Path: <linux-kernel+bounces-80121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D2862AED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90051F21853
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE711401C;
	Sun, 25 Feb 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qYewoJJ3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cpfn29oy"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7A12B71;
	Sun, 25 Feb 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873971; cv=none; b=QuO9Pxq4QdyEvA/agxLO7L/hhHqWHk279qy2IFla7Z92QPmwdWPz6pxC6Lod/FjSa4jfDLcGSH94Asbk9DpDlHbROmzNrkRLzGTQzXF6zKdurwb1h7mCf3CtTks+87CSG88zQiYiU1x5GNbsCcyXmhXE4omLmJUDmFvgZQBDypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873971; c=relaxed/simple;
	bh=i6bB374PAzuU3ox7uAqrICDtayFJQ294bZPoDLtVsWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKxxGNd4MA4IwWS+Ir6LUFHMhB0t8Q8bU+UO4hB2UiQy+LeCVnJkJlGM3hfkMTP2Sm5YjGWzD27qlH22Ydntq/Ivc5B579Dvqt03eIRB7PhBYH4nRZHA8IVfDYl/bwgZewFy3WvUvEZq315gdnB71HYb44mNvE/s113j3hwV3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qYewoJJ3; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cpfn29oy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TjS0n3TYpz9sTP;
	Sun, 25 Feb 2024 16:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1708873961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRjLgmcWR9yTbwpAT9QEvtskHcomtS4deDEwTh2BUkM=;
	b=qYewoJJ3vroy7TmvLLAMXzJz+c3tBxhgHdZmxUoUhNUpEDidD1hB4rTofyu8DDK3TBMDa1
	Y0kJvNYcm6Qr7gTNz2ApaZUoIIKRePOysmi3ZvclIRhPgSJG4x2evkqnm9cVH9ru11M99I
	feAbRmt+eVfQV5p8ZG7YmOyESqBOZ8oeTEEKEtZnCVBN4i2LWJZrObqZHJuDIXPthUFJYA
	jBzD61a0jXuGTFlOxavca0htXSlXUKiu4uAVZXWQgmLWbyWRD7y3tA4Ff85Nd6adgQHsaI
	LokUqrV4S5weL76QRPlRu9HjGn1/c34MWj2Szz8NjyiCZIX4ZFP6mzCQok94EQ==
From: Alexander Stein <alexander.stein@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1708873959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRjLgmcWR9yTbwpAT9QEvtskHcomtS4deDEwTh2BUkM=;
	b=cpfn29oyeYBGBQef+XdFTAD8FBTentm3fHDqlGpGCgRE/LvKG0wmug4lunaE2LpOBoT+LQ
	6ci2iUhzEo7i9T3XHoGYPfFIZihvwnF8TRMfIoQKp+m5IBmTSxNgsjpdlejECI6QpPU8fi
	fsjGuVvWcswk2N3FIX+UlTKlKTlR/P5/HdgzGq8hlxMtlPyM3b4MjRgPr6tfESc5s4OE9u
	jriQO9p7gTornEFdHH2S+ULrXOoIPEgBjzOGuejHKYAfzLeTyC/W3J/EYBR5o8D+Rf+BqW
	6HJEuOqxrLDMUDY2ELc5+/VEUsO9B7a5G5RzWyjP0RLCV9a5EBZiuoziC2g8bw==
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alexander Stein <alexander.stein@mailbox.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kbuild: Add DT schema check also when applying DT overlays
Date: Sun, 25 Feb 2024 16:12:08 +0100
Message-ID: <20240225151209.343160-1-alexander.stein@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5u1eryii4c9kny9m3tkcmhobp84mk8hx
X-MBO-RS-ID: 8917cd3fdc859ece579
X-Rspamd-Queue-Id: 4TjS0n3TYpz9sTP

Add a similar mechanism as for regular DT files to call the DT checker
after applying DT overlays to base DT files.

Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
---
I'm unsure if this is the "right" way, or if the multi-dtb-y lines
should be moved. But checking for schemas in DT overlays is a nice thing.

 scripts/Makefile.lib | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 038a12e15586..964892b18f95 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -406,10 +406,6 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
 quiet_cmd_fdtoverlay = DTOVL   $@
       cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
 
-$(multi-dtb-y): FORCE
-	$(call if_changed,fdtoverlay)
-$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
-
 ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
@@ -418,9 +414,13 @@ DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_dtb =	DTC_CHK $@
       cmd_dtb =	$(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+quiet_cmd_dtbo = DTOVL_CHK $@
+      cmd_dtbo = $(cmd_fdtoverlay) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
 else
 quiet_cmd_dtb = $(quiet_cmd_dtc)
       cmd_dtb = $(cmd_dtc)
+quiet_cmd_dtbo = $(quiet_cmd_fdtoverlay)
+      cmd_dtbo = $(cmd_fdtoverlay)
 endif
 
 $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
@@ -429,6 +429,10 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(multi-dtb-y): FORCE
+	$(call if_changed,dtbo)
+$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
2.44.0



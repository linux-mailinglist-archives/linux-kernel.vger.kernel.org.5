Return-Path: <linux-kernel+bounces-133694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8719C89A774
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD911F21A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0A374FF;
	Fri,  5 Apr 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pivt5Oed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5036B0D;
	Fri,  5 Apr 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357775; cv=none; b=Ygj5t0sRfOCYzR4llez/h6G91MCJ4un7Skm+xFiJcjpOqsF8c6w0ZPSEuDizQEW4eUhkPODEZHjeKsGpDvi0eBCVXIpezGk0fAZYtfszOf+to129k3kVV3J8+Ui/xbiC40UO36vu203XGtd/cfNTSbym9b3g/3xKStI3iejlW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357775; c=relaxed/simple;
	bh=trQSVrFFgKc03l1meR9oLABQJfqpYjIaW5IZInGv0VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6+Zva7SHKF257Db0XcW/8VCt5n46jRNa9TVSl3p4Wi/oI6fuyRQ251DsbmEJzsOdAfN+bZ+26STRXSsZ1hHRbyga/6aeR6xVA6aI9GRYTDTQAwvEDHm7zPszjgRzXKjABeAAImNCZWNiAS1PYwTQaruRW8Elc9rRY1OTCptyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pivt5Oed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E45C433F1;
	Fri,  5 Apr 2024 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712357775;
	bh=trQSVrFFgKc03l1meR9oLABQJfqpYjIaW5IZInGv0VM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pivt5OedSqMRqVjSZpIirmPDDtFPCnCFH10QiedEnAvTIn1lSHhUiyVj8/BVdX0RH
	 XwCvHuQd4APIX0xhMJfU8JOnb8PVTIrnQHexfCYze5CEZMNgSvC6mQuEhqj6ddZXAX
	 GHEej1z3n2Xyg3ZAaSCRQ2bw6e12a+WDb9nPhHexSVxTt9ajfR/ffWxicw1aOFQVnY
	 yzLZ8mnDzzPB+GWL6Gvm53o4sYrDQeVd9TQwuW3MHEV9vDuO2CvYVL6v8ZMjqd3yd0
	 +ywcqwkjVe7ScodOBhAILiT6sgt8FS4cgD2CmADG+n9xPHdOXE4qAJK6XzRRO1Hnjt
	 NR6DNcXXjbzPA==
From: Rob Herring <robh@kernel.org>
Date: Fri, 05 Apr 2024 17:56:01 -0500
Subject: [PATCH v2 1/3] dt-bindings: kbuild: Simplify examples target
 patsubst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-dt-kbuild-rework-v2-1-3a035caee357@kernel.org>
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
In-Reply-To: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

Instead of stripping off the $(srctree) multiple times do it once up
front, but keep the src/obj path as it is going to be needed in
subsequent commit.

Rename the variable to CHK_DT_EXAMPLES to better reflect what it
contains.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: New patch
---
 Documentation/devicetree/bindings/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 5e08e3a6a97b..95f1436ebcd0 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -32,7 +32,7 @@ find_cmd = $(find_all_cmd) | \
 		sed 's|^$(srctree)/||' | \
 		grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))" | \
 		sed 's|^|$(srctree)/|'
-CHK_DT_DOCS := $(shell $(find_cmd))
+CHK_DT_EXAMPLES := $(patsubst $(srctree)/%.yaml,%.example.dtb, $(shell $(find_cmd)))
 
 quiet_cmd_yamllint = LINT    $(src)
       cmd_yamllint = ($(find_cmd) | \
@@ -68,8 +68,8 @@ $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version
 	$(call if_changed_rule,chkdt)
 
 always-y += processed-schema.json
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
-always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
+always-$(CHECK_DT_BINDING) += $(patsubst $(obj)/%,%, $(CHK_DT_EXAMPLES))
+always-$(CHECK_DT_BINDING) += $(patsubst $(obj)/%.dtb,%.dts, $(CHK_DT_EXAMPLES))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean

-- 
2.43.0



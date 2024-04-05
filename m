Return-Path: <linux-kernel+bounces-133696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2289A77A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE0286E61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CC446A0;
	Fri,  5 Apr 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhCesNHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F223F8D4;
	Fri,  5 Apr 2024 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712357780; cv=none; b=VyqyKiovrvTvfBUattYCDa74p0nFempIfp8LXG4bEMXjGfa44vr6BVq11udy7C34yrqqafC+Z4kQH6Mzexn19Lv5a3oCYqbH6NgD6yggIJF2rfDI96VC4BPEFAF2kG/sxUl+ob8XZxrpWWIWvYtKrvNQ4dwrGWERXcT8THg3Hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712357780; c=relaxed/simple;
	bh=AO5Kpd/Nydfgj35Of2FHSq+t2Vc9UkcYjNb1Rv1uAJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMcthdO6zKhwdXOc/QafmQju7EV0Vrnq4FL3kcExcV3GUInry3FigQ2rRFtZnCccI6DVvrQOzBOXd3cVkhjYuMsfYi7nTby4eMGY2hLB8c3FatY/tMzWtVaBP3WMHFEsKTxuJP+T3/iZiujPdgCiFMtmJK5ywuYRgYw8Laylg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhCesNHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC6CC43394;
	Fri,  5 Apr 2024 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712357779;
	bh=AO5Kpd/Nydfgj35Of2FHSq+t2Vc9UkcYjNb1Rv1uAJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jhCesNHgJsGQy/dJ+jMTvQxpMAlN7OgTaHzunQ8wqR+ZK1K0QOohd2H+VYYa2GJXJ
	 VoO8mEj6/LAQxky2LY39loFOlGyqMgUgjy0ku0Ra3JqIbLqsdzuchkfDK1vm3nfJt+
	 gF+ncWODUv/WmY7G63bW0WhCs7seeraBk51OcDoNZiXuflI/Kr01Kz7iGlvJisijxU
	 ZTIjRN6PfQBKU4mkVqU1BJnOciHkf372J0/YxkjTG58vMrbdF5M3eomG9/0oxjg3MV
	 vpPLotdW3RgC4/nKE0t9UA9P0oGMwG9v8KqKLSul6cYDfI8wtH5vbbj0eGmpigoqEz
	 cbR2Q3O98NeFw==
From: Rob Herring <robh@kernel.org>
Date: Fri, 05 Apr 2024 17:56:03 -0500
Subject: [PATCH v2 3/3] dt-bindings: kbuild: Add separate target/dependency
 for processed-schema.json
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-dt-kbuild-rework-v2-3-3a035caee357@kernel.org>
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
In-Reply-To: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

Running dtbs_check and dt_compatible_check targets really only depend
on processed-schema.json, but the dependency is 'dt_binding_check'. That
was sort worked around with the CHECK_DT_BINDING variable in order to
skip some of the work that 'dt_binding_check' does. It still runs the
full checks of the schemas which is not necessary and adds 10s of
seconds to the build time. That's significant when checking only a few
DTBs and with recent changes that have improved the validation time by
6-7x.

Add a new target, dt_binding_schema, which just builds
processed-schema.json and can be used as the dependency for other
targets. The scripts_dtc dependency isn't needed either as the examples
aren't built for it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Just split out building processed-schema.json and drop running
yamllint, schema validation, or checking examples separately.
 - Fix multiple targets in parallel build. (Thanks Masahiro!)
---
 Documentation/devicetree/bindings/Makefile |  9 ++++++---
 Makefile                                   | 24 ++++++++++++------------
 scripts/Makefile.lib                       |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 3779405269ab..8cdda477987f 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -63,7 +63,7 @@ override DTC_FLAGS := \
 $(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
 	$(call if_changed,mk_schema)
 
-always-$(CHECK_DT_BINDING) += .dt-binding.checked .yamllint.checked
+targets += .dt-binding.checked .yamllint.checked
 $(obj)/.yamllint.checked: $(DT_DOCS) $(src)/.yamllint FORCE
 	$(if $(DT_SCHEMA_LINT),$(call if_changed,yamllint),)
 
@@ -71,8 +71,8 @@ $(obj)/.dt-binding.checked: $(DT_DOCS) FORCE
 	$(call if_changed,chk_bindings)
 
 always-y += processed-schema.json
-always-$(CHECK_DT_BINDING) += $(patsubst $(obj)/%,%, $(CHK_DT_EXAMPLES))
-always-$(CHECK_DT_BINDING) += $(patsubst $(obj)/%.dtb,%.dts, $(CHK_DT_EXAMPLES))
+targets += $(patsubst $(obj)/%,%, $(CHK_DT_EXAMPLES))
+targets += $(patsubst $(obj)/%.dtb,%.dts, $(CHK_DT_EXAMPLES))
 
 # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
 # build artifacts here before they are processed by scripts/Makefile.clean
@@ -81,3 +81,6 @@ clean-files = $(shell find $(obj) \( -name '*.example.dts' -o \
 
 dt_compatible_check: $(obj)/processed-schema.json
 	$(Q)$(srctree)/scripts/dtc/dt-extract-compatibles $(srctree) | xargs dt-check-compatible -v -s $<
+
+PHONY += dt_binding_check
+dt_binding_check: $(obj)/.dt-binding.checked $(obj)/.yamllint.checked $(CHK_DT_EXAMPLES)
diff --git a/Makefile b/Makefile
index 763b6792d3d5..1356e48caa2b 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,12 +1398,12 @@ dtbs: dtbs_prepare
 # dtbs_install depend on it as dtbs_install may run as root.
 dtbs_prepare: include/config/kernel.release scripts_dtc
 
-ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
+ifneq ($(filter dt_binding_check dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
 endif
 
 ifneq ($(CHECK_DTBS),)
-dtbs_prepare: dt_binding_check
+dtbs_prepare: dt_binding_schemas
 endif
 
 dtbs_check: dtbs
@@ -1421,16 +1421,15 @@ PHONY += scripts_dtc
 scripts_dtc: scripts_basic
 	$(Q)$(MAKE) $(build)=scripts/dtc
 
-ifneq ($(filter dt_binding_check, $(MAKECMDGOALS)),)
-export CHECK_DT_BINDING=y
-endif
+PHONY += dt_binding_check dt_binding_schemas
+dt_binding_check: dt_binding_schemas scripts_dtc
+	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
 
-PHONY += dt_binding_check
-dt_binding_check: scripts_dtc
+dt_binding_schemas:
 	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings
 
 PHONY += dt_compatible_check
-dt_compatible_check: dt_binding_check
+dt_compatible_check: dt_binding_schemas
 	$(Q)$(MAKE) $(build)=Documentation/devicetree/bindings $@
 
 # ---------------------------------------------------------------------------
@@ -1626,10 +1625,11 @@ help:
 	@echo  ''
 	@$(if $(dtstree), \
 		echo 'Devicetree:'; \
-		echo '* dtbs             - Build device tree blobs for enabled boards'; \
-		echo '  dtbs_install     - Install dtbs to $(INSTALL_DTBS_PATH)'; \
-		echo '  dt_binding_check - Validate device tree binding documents'; \
-		echo '  dtbs_check       - Validate device tree source files';\
+		echo '* dtbs               - Build device tree blobs for enabled boards'; \
+		echo '  dtbs_install       - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '  dt_binding_check   - Validate device tree binding documents and examples'; \
+		echo '  dt_binding_schema  - Build processed device tree binding schemas'; \
+		echo '  dtbs_check         - Validate device tree source files';\
 		echo '')
 
 	@echo 'Userspace tools targets:'
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3179747cbd2c..d1d51e38b55d 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -410,7 +410,7 @@ $(multi-dtb-y): FORCE
 	$(call if_changed,fdtoverlay)
 $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
 
-ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
+ifneq ($(CHECK_DTBS),)
 DT_CHECKER ?= dt-validate
 DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings

-- 
2.43.0



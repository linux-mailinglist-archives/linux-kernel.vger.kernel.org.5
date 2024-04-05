Return-Path: <linux-kernel+bounces-132786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0460899A26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484311F22C20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21998161316;
	Fri,  5 Apr 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="SiXKl45A"
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B2160783;
	Fri,  5 Apr 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311373; cv=none; b=GuMfMlvYQuLcs6A9cInmLRtB9I+hHGT10k6SHs7CBNg7u5ANPCzmzKjayutSSYw5W1xrD2JKLtlgOCCTrgDqwfrsvvfBqCKj/5GmIPDV28kaWwhnuUAMlIxuf4AjAbipoN7CT4WOMh8qGHI4iVdB1Y+Fv5T81xSvfLfHYPXSuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311373; c=relaxed/simple;
	bh=EGWGbEK4PUsKwc70vkiP6VAuTOJPQgfxrESjpAm84Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vs4BaKwb+Lu35a+Z4gWrFz3VJSrL/KsgloOQhuknME7GlhorMamM2/Bh8paEwD9XFxNJ3MeeEaqNaR6gu6Vz0+ptEtlYKhNJwd9bO63nl1ywyc3vzquhtmurbDa74/v3FvIU0PYFrAaxIO3yvqQTUJBJUUEG2L4VYlPpkjutxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=SiXKl45A; arc=none smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5342; q=dns/txt; s=iport;
  t=1712311371; x=1713520971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IIsUhLgbNNdmnBkjYQ0HE6V5+KPIcu6NFN76XdqX3ck=;
  b=SiXKl45A25hll6h2F6yC11xjSqs4VuddjCR+mHc0/6Y7ul7FW+6Smq/9
   0KCptQCrLUNEC2o6wZc4eHXROlAGFnCM3n19cSUHihdcfF3cF9cTmJvPu
   YPa0vX4a9fGGZIDgJA18hzTBDzTLwwLGyY41JHXg28a4XuAlN9EYCKQxq
   o=;
X-CSE-ConnectionGUID: s61VkzV5QzykVMURJlleDQ==
X-CSE-MsgGUID: LIC5oCIhRgSjSpi0byH07A==
X-IPAS-Result: =?us-ascii?q?A0CQAQAhyw9mmIENJK1aHgEBCxIMggQLg0BWQUiWPItzh?=
 =?us-ascii?q?ySKc4ElA1YPAQEBDzETBAEBhQaIEQImNgcOAQIEAQEBAQMCAwEBAQEBAQEBB?=
 =?us-ascii?q?gEBBQEBAQIBBwUUAQEBAQEBAQEeGQUOECeFbQ2GXDYBRoE9ARKDAAGCXwIBr?=
 =?us-ascii?q?1aCLIEB3i6BahiBMIx7hWEnG4FJRIEVgTuNMwSCYYoBhFiGe4I8hFlKgSMDW?=
 =?us-ascii?q?SERAVUVMhkYCTwPDBoCGxQNJCMCLD4DCQoQAhYDHRQEMBEJCyYDKgY2AhIMB?=
 =?us-ascii?q?gYGWyAWCQQjAwgEA1ADIHARAwQaBAsHdoM9BBNEAxCBMgaKEIMVAgUjKYF3g?=
 =?us-ascii?q?REYgwtOghMCgSoDCQMHBUlAAwsYDUgRLDUGDhsGIh9vB5t4AYJsBgE9PhMBg?=
 =?us-ascii?q?SZKCDdzkk4RkXCBMp84hB2MDpUdGjOFW6RYmGIgpAKEY4FrByyBW00jFYMiC?=
 =?us-ascii?q?UkZD445gwOaMSM1OwIHCwEBAwmKaAEB?=
IronPort-Data: A9a23:FWqxJKwdQisHjvsSZNh6t+exxirEfRIJ4+MujC+fZmUNrF6WrkVVz
 2RMDWiCP/7YZTTzc9FwOt+yoRsOsJLQxoNrTwY4qlhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YyaT/H3Ygf/h2Yoaj9MsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu4+GeH3utj5Gq3VzFTV7R+ddqCEwaBNhNkgp3KTkmG
 f0wITQJaFWIgPi7heP9Qeh3jcNlJ87uVG8dkig/lneCU7B/GtaaGfSiCdxwhF/cguhQFvbTf
 cwedBJkbQ/LZFtEPVJ/5JcWxrv23yGkI2IFwL6TjY4WyDXU5y1x6rfWMuHNe4SAVOUNwW/N8
 woq+EyiX0lFb4bAodafyVqoh+nSjWb4VZgUGbmQ6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dTL
 Ec85CUjt+4x+VatQ927WAe3yFaAvxgBS59TGfA77A2l1KXZ+UCaC3ICQzoHb8Yp3Oc9QiYg2
 0Ohm8zvQzpirNW9T3OW8bOdthu8OyEOKWJEaDJsZQ0M/9nqpqkwgwjJQ9IlF7S65vXwECr5w
 zGQqzkWhLgJi8MPkaKh8jj6bymEr5zNSEs+4R/aGzPj5QJib4njbIutgbTG0RpeBJ3HF2eCr
 kZZotqP794rMKuvkCiAbNxYSdlF+M25GDHbhFduGbwo+DKs52OvcOhsDNdWeh4B3iEsJ2aBX
 aPDhT698qO/K5dDUEOaS4u1D8Jvxq/6GJG0EPvVddFJJJN2cWdrHR2Ch2bOgQgBc2B1zcnT3
 Kt3l+73UR727ow8k1KLqx81i+ND+8zH7Tq7qWrH5xqmy6GCQ3WeVK0INlCDBshgs/re+liIr
 4kEapTUo/m6bAEYSnSHmWL0BQ1bRUXX+binwyCqXrfafVo4Qj1J5wH5mON8J+SJYJi5Zs+To
 yniARUHoLYOrXbGMg6NImtyc6/iWI03rHQwe0QR0aWAhRAejXKUxP5HLfMfJOB/nMQ6lKIcZ
 6deIa2oXK8QIgkrDhxAN/ERWqQ4KkTy7e9PVgL4CAUCk2lIHlGZqoC4JVSwrEHjzEOf7KMDn
 lFp7SuDKbJreuioJJ++hC6Hp79pgUUgpQ==
IronPort-HdrOrdr: A9a23:Gu6h8ax6VPJCUexiXhc6KrPwI71zdoMgy1knxilNoNJuHvBw8P
 re/sjzuiWbtN98YhsdcLO7Scq9qA3nlKKdiLN5VdyftWLd11dAQrsO0WLK+UyEJ8SHzI5gPW
 MKSdkYNDU2ZmIK6frH3A==
X-Talos-CUID: 9a23:Jxx5yG7PMmgb3avHEtss7xBNJMM3TCDk3mbTHWqFM0RtTLC5cArF
X-Talos-MUID: =?us-ascii?q?9a23=3Ardm5WA3v+YUoCMW/Z7OZ8q/ZTTUjx4WFVUcmsJU?=
 =?us-ascii?q?8tPKGDjRxYz2MrGzoa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,181,1708387200"; 
   d="scan'208";a="246103875"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 10:01:42 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTP id 435A1fVn028453;
	Fri, 5 Apr 2024 10:01:41 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add MO(mod objs) variable to process ext modules with subdirs
Date: Fri,  5 Apr 2024 03:01:38 -0700
Message-Id: <20240405100140.1394290-1-vchernou@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.59.233, sjc-ads-1541.cisco.com
X-Outbound-Node: alln-core-9.cisco.com

The change allow to build external modules with nested makefiles.
With current unofficial way(using "src" variable) it is possible to build
external(out of tree) kernel module with separating source and build
artifacts dirs but with nested makefiles it doesn't work properly.
Build system trap to recursion inside makefiles, artifacts output dir
path grow with each iteration until exceed max path len and build failed
Providing "MO" variable and using "override" directive with declaring
"src" variable solve the problem
Usage example:
make -C KERNEL_SOURCE_TREE MO=BUILD_OUT_DIR M=EXT_MOD_SRC_DIR modules

Cc: xe-linux-external@cisco.com
Cc: Valerii Chernous <vchernou@cisco.com>
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
 Documentation/kbuild/modules.rst | 16 +++++++++++++++-
 Makefile                         | 17 +++++++++++++++++
 scripts/Makefile.build           |  7 +++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 9c8d1d046ea5..63e1a71a3b9a 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -121,10 +121,22 @@ Setting "V=..." takes precedence over KBUILD_VERBOSE.
 KBUILD_EXTMOD
 -------------
 Set the directory to look for the kernel source when building external
-modules.
+modules. In case of using separate sources and module artifatcs directories
+(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
+artifacts directory
 
 Setting "M=..." takes precedence over KBUILD_EXTMOD.
 
+KBUILD_EXTMOD_SRC
+-------------
+Set the external module source directory in case when separate module
+sources and build artifacts directories required. Working in pair with
+KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD working as
+module build artifacts directory
+
+Setting "MO=..." takes precedence over KBUILD_EXTMOD.
+Setting "M=..." takes precedence over KBUILD_EXTMOD_SRC.
+
 KBUILD_OUTPUT
 -------------
 Specify the output directory when building the kernel.
diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index a1f3eb7a43e2..135be2fc798e 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -79,6 +79,14 @@ executed to make module versioning work.
 	The kbuild system knows that an external module is being built
 	due to the "M=<dir>" option given in the command.
 
+	To build an external module with separate src and artifacts dirs use::
+
+		$ make -C <path_to_kernel_src> M=$PWD MO=<output_dir>
+
+	The kbuild system knows that an external module with separate sources
+	and build artifacts dirs is being built due to the "M=<dir>" and
+	"MO=<output_dir>" options given in the command.
+
 	To build against the running kernel use::
 
 		$ make -C /lib/modules/`uname -r`/build M=$PWD
@@ -93,7 +101,7 @@ executed to make module versioning work.
 
 	($KDIR refers to the path of the kernel source directory.)
 
-	make -C $KDIR M=$PWD
+	make -C $KDIR M=$PWD MO=<module_output_dir>
 
 	-C $KDIR
 		The directory where the kernel source is located.
@@ -106,6 +114,12 @@ executed to make module versioning work.
 		directory where the external module (kbuild file) is
 		located.
 
+	MO=<module_output_dir>
+		Informs kbuild that an external module build artifacts
+		should be placed into specific dir(<module_output_dir>)
+		This parameter optional, without it "M" working as
+		source provider and build output location
+
 2.3 Targets
 ===========
 
diff --git a/Makefile b/Makefile
index 4bef6323c47d..3d45a41737a6 100644
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,7 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif
 
+define kbuild_extmod_check_TEMPLATE
 $(if $(word 2, $(KBUILD_EXTMOD)), \
 	$(error building multiple external modules is not supported))
 
@@ -152,9 +153,25 @@ $(foreach x, % :, $(if $(findstring $x, $(KBUILD_EXTMOD)), \
 ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
 KBUILD_EXTMOD := $(shell dirname $(KBUILD_EXTMOD).)
 endif
+endef
+$(eval $(call kbuild_extmod_check_TEMPLATE))
 
 export KBUILD_EXTMOD
 
+# Use make M=src_dir MO=ko_dir or set the environment variables:
+# KBUILD_EXTMOD_SRC, KBUILD_EXTMOD to specify separate directories of
+# external module sources and build artifacts.
+ifeq ("$(origin MO)", "command line")
+ifeq ($(KBUILD_EXTMOD),)
+	$(error Ext module objects without module sources is not supported))
+endif
+KBUILD_EXTMOD_SRC := $(KBUILD_EXTMOD)
+KBUILD_EXTMOD := $(MO)
+$(eval $(call kbuild_extmod_check_TEMPLATE))
+endif
+
+export KBUILD_EXTMOD_SRC
+
 # backward compatibility
 KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index baf86c0880b6..a293950e2e07 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -3,7 +3,14 @@
 # Building
 # ==========================================================================
 
+ifeq ($(KBUILD_EXTMOD_SRC),)
 src := $(obj)
+else ifeq ($(KBUILD_EXTMOD),$(obj))
+override src := $(KBUILD_EXTMOD_SRC)
+else
+src_subdir := $(patsubst $(KBUILD_EXTMOD)/%,%,$(obj))
+override src := $(KBUILD_EXTMOD_SRC)/$(src_subdir)
+endif
 
 PHONY := $(obj)/
 $(obj)/:
-- 
2.35.6



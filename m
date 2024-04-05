Return-Path: <linux-kernel+bounces-133374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321989A2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63841F225C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE0171E41;
	Fri,  5 Apr 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GZil8yxZ"
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32075171670;
	Fri,  5 Apr 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336243; cv=none; b=agilDD7Gtp48oap7kTEEUCKXSe94vl1HtapMJGcypbfpN6ATC6cD9j+hg2I/fzE/p+zDuca6KOFBJWjFf7q38viyoyoWShUGAAxFL6ZPhU1YGkcTPlRsfT3ac0bJWLOcuR+q/8LnY+omVmpzYCiRYGCdLvcz9tCG/m9gtBpt6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336243; c=relaxed/simple;
	bh=qXuwMCT+b3u9KeSmgIWHdfGEQJkVakqVWx1OHSggAVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTWYo4Xvyio89CY3z8I7wz2K0IfIxXnq9CSkQPfLoCMxZEr/tnaKTpn9SWpBmhAcs6kWolHZ+NZYx/mvrnp5sQdgb7oPP2nEYu0UZcuvBJSIe98nqzzTAiScDS9dY3WbHGuQ4C7mvs2rcFTMF3w5rHigilSVAXunpYQ/mu9Y/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=GZil8yxZ; arc=none smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5348; q=dns/txt; s=iport;
  t=1712336241; x=1713545841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3giUsTCXvDdhR8jWae0EY/dEresrV+oTZ2G7M/vJy6c=;
  b=GZil8yxZYaGeOBquPdcMgrOOUrPOdYxPovcnhbPlhzVyM0gcdJWcP3Ja
   FHv5BCt4rZtyzyeSXIvb/iLWbckFToSlkRvT3ZjeHgPVglxe3pAPYReC4
   evt2ma2oLohpcoOpO9HB8x4zr8MyD8hdIx6DhKEPT8I6XWPtRgRdIIQ4s
   M=;
X-CSE-ConnectionGUID: y+8OyqXeSbCm8u+1be0NQg==
X-CSE-MsgGUID: 94PtCkYcR2SQXvekIlsO8w==
X-IPAS-Result: =?us-ascii?q?A0CQAQByLBBmmJ1dJa1aHgEBCxIMggQLg0BWQUiWPItzh?=
 =?us-ascii?q?ySKc4ElA1YPAQEBDzETBAEBhQaIEwImNgcOAQIEAQEBAQMCAwEBAQEBAQEBB?=
 =?us-ascii?q?gEBBQEBAQIBBwUUAQEBAQEBAQEeGQUQDieFbQ2GXDYBRoE9ARKDAAGCXwIBr?=
 =?us-ascii?q?zeCLIEB3i6BahiBMIx7hWEnG4FJRIEVgTuNMwSCTooAhFiGdYJYhFdKgSMDW?=
 =?us-ascii?q?SECEQFVFRoZGAk6DwwaAhsUDSQjAiw+AwkKEAIWAx0UBDARCQsmAyoGNgISD?=
 =?us-ascii?q?AYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WDPQQTRAMQgTIGihCDFQIFIymBd?=
 =?us-ascii?q?4ESGIMLToIPAoE/AwkDBwVJQAMLGA1IESw1Bg4bBiIfbwebagGCbAYBPT4TA?=
 =?us-ascii?q?YEmSgiBKpJOEZFwgTKfOIQdjA6VHRozhVukWJhiIKQChGOBawcsgVtNIxWDI?=
 =?us-ascii?q?glJGQ+OOYMDmjkjNTsCBwsBAQMJimgBAQ?=
IronPort-Data: A9a23:32X/hqzcYc9PJnmIVpx6t+exxirEfRIJ4+MujC+fZmUNrF6WrkUHn
 2JMDDuHaK6DazOnf9B3O9yzoU0A6J+Ax9JhSwJr/lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YyaT/H3Ygf/h2Yoaj9MsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu6fyXBmmmgcGoxWbDI2avmv9jVGcPMthNkgp3KTkmG
 f0wMjsBaFWIgPi7hez9Qeh3jcNlJ87uVG8dkig/lneCUrB3GtaaHvqiCdxwhF/cguhQFvbTf
 cwedBJkbQ/LZFtEPVJ/5JcWxr/21yOlI2MFwL6Tjftr23T4zz166uLWCerLd9+rQd5yzlnN8
 woq+EyiX0lFb4bAodafyVqoh+nSjWb4VZgUGbmQ6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dTL
 Ec85CUjt+4x+VatQ927WAe3yFaAvxgBS59TGfA77A2l1KXZ+UCaC3ICQzoHb8Yp3Oc9QiYg2
 0Ohm8zvQzpirNW9T3OW8bOdthu8OyEOKWJEaDJsZQ0M/9nqpqkwgwjJQ9IlF7S65vXwECr5w
 zGQqzkWhLgJi8MPkaKh8jj6bymEvJPFSEs+4R/aGzzj5QJib4njbIutgbTG0RpeBJfaHn6Qp
 UgJoMK16bATTsiHmXSreepYSdlF+M25GDHbhFduGbwo+DKs52OvcOhsDNdWeh4B3iEsJ2aBX
 aPDhT698qO/K5dDUEOaS5i6B8Jvxq/6GJG7EPvVddFJJJN2cWdrHR2Ch2bOgAgBc2B1zcnT3
 Kt3l+73Ux727ow8kVKLqx81i+ND+8zH7Tq7qWrH5xqmy6GCQ3WeVK0INlCDBshgs/re+liIr
 4kEapTUo/m6bAEYSnSHmWL0BQ1bRUXX+binwyCqXrfafVo4Qj1J5wH5mON8J+SJYJi5Zs+To
 yniARUHoLYOrXbGMg6NImtyc6/iWI03rHQwe0QR0aWAhRAejXKUxP5HLfMfJOB/nMQ6lK4cZ
 6deIa2oXK8QIgkrDhxAN/ERWqQ4KkTy7e9PVgL4CAUCk2lIHFCZqo69JVSxpEHjzEOf7KMDn
 lFp7SuDKbJreuioJJ++hC6Hp79pgUUgpQ==
IronPort-HdrOrdr: A9a23:iv3EfqidPvTrOZA32Mc6VzlGxHBQXtUji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcK2+gs1N6ZNWGMhILCFu5fBOXZrgEIMheOk9K1rZ
 0BT0C7Y+eAamSTSq3BkW2FL+o=
X-Talos-CUID: 9a23:jYhC4WGjIgr8Sop2qmJ2tx4zC9kVf0bX53KAPgzhA2sxboSaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AMDdUjg1PETgcMmjvAPmjJes04TUjsviWFGsOoJ4?=
 =?us-ascii?q?84fK9BTJ9OBaZlxPnXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,181,1708387200"; 
   d="scan'208";a="206922865"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:56:12 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id 435GuBC2023239;
	Fri, 5 Apr 2024 16:56:11 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, Jonathan Corbet <corbet@lwn.net>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add MO(mod objs) variable to process ext modules with subdirs
Date: Fri,  5 Apr 2024 09:56:08 -0700
Message-Id: <20240405165610.1537698-1-vchernou@cisco.com>
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
X-Outbound-Node: rcdn-core-6.cisco.com

The change allow to build external modules with nested makefiles.
With current unofficial way(using "src" variable) it is possible to build
external(out of tree) kernel module with separate source and build
artifacts dirs but with nested makefiles it doesn't work properly.
Build system trap to recursion inside makefiles, artifacts output dir
path grow with each iteration until exceed max path len and build failed.
Providing "MO" variable and using "override" directive with declaring
"src" variable solves the problem
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
index 9c8d1d046ea5..81413ddba2ad 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -121,10 +121,22 @@ Setting "V=..." takes precedence over KBUILD_VERBOSE.
 KBUILD_EXTMOD
 -------------
 Set the directory to look for the kernel source when building external
-modules.
+modules. In case of using separate sources and module artifacts directories
+(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
+artifacts directory.
 
 Setting "M=..." takes precedence over KBUILD_EXTMOD.
 
+KBUILD_EXTMOD_SRC
+-----------------
+Set the external module source directory in case when separate module
+sources and build artifacts directories are used. Working in pair with
+KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD is used as
+module build artifacts directory.
+
+Setting "MO=..." takes precedence over KBUILD_EXTMOD.
+Setting "M=..." takes precedence over KBUILD_EXTMOD_SRC.
+
 KBUILD_OUTPUT
 -------------
 Specify the output directory when building the kernel.
diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index a1f3eb7a43e2..b6c30e76b314 100644
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
+		Informs kbuild that external module build artifacts
+		should be placed into specific dir(<module_output_dir>).
+		Parameter is optional. Without it "M" works as both
+		source provider and build output location.
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



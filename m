Return-Path: <linux-kernel+bounces-128247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888E895842
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D840B1C22D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD13A1327ED;
	Tue,  2 Apr 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="j2lpEUgL"
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23ED13118A;
	Tue,  2 Apr 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071900; cv=none; b=q1m103HGB5Y6cB9eCXj33OJv2Ae2L/tvTXXO5OblTpRVOE8TEsVkQtLYAl4kDyUNN0cXj9c3r2Rk710Fl0sh52XatpZt+Yj3ogpBorctoAlhj9Ac1G/tEWoig5eVxURcemgK1LN+BH6qDro9RCd+inMij1NyCgIAjmLwdCu4ZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071900; c=relaxed/simple;
	bh=e69MTcmMVQRlw2pSk4NeN0iFCrZxVM43Fm6IIEyLoZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5W4bpK2diCPT/C7M39fkoA0fvwRKvEj2ApZZYjlUNZXJC6+Gi3yjNNKdCh7rtVTekJ2KGX/3aGnrbZcX82+7PdiB63Wy2B7boqihIbCBiEFaILIhqAmXm5SfFnKj7d+DjctYmAWbuyUARzqaQqpQVPXLIyP2HyBOrgjGy/tOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=j2lpEUgL; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2610; q=dns/txt; s=iport;
  t=1712071899; x=1713281499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+6buokSRXxD5AHfqji+FJX+U612BchLgn5C5OOcHDp8=;
  b=j2lpEUgLMF5U8UNjEAUELiasRz4r2QjOFg2yeNsxuJNMdxCxBDRU32AA
   vCLgwn+oj4cEnunlNABIqAfPgqz4uHLxuC01+qI4sc9v7NaDmAydZ3iR9
   eLkwF/RvYQvyFwwul/582wo/fLz2Fme8bHbTNs3csebiyW732s89CGdon
   s=;
X-CSE-ConnectionGUID: puciDyntTuO4io/BVrtvHQ==
X-CSE-MsgGUID: 6/xQRmZbR+er6QTgIsyl1A==
X-IPAS-Result: =?us-ascii?q?A0AwAQCYIwxmmIUNJK1aHgEBCxIMggQLgzVWQUiWPItzk?=
 =?us-ascii?q?heBJQNWDwEBAQ8xEwQBAYUGiAgCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQYBA?=
 =?us-ascii?q?QUBAQECAQcFFAEBAQEBAQEBHhkFDhAnhW0Nhlw2AUaBPQESgwABgl8CAa8Wg?=
 =?us-ascii?q?iyBAbMygWoYgTCMe4VhJxuBSUSCUI0zBIISgzeOW4RaiDaFO0qBJAOBBWsbE?=
 =?us-ascii?q?B43ERATDQMIbh0CMToDBQMEMgoSDAsfBRJCA0AGSAsDAhoFAwMEgSwFCxoCE?=
 =?us-ascii?q?CwmAwMSSQIQFAM4AwMGAwoxLk9BDFADZB8ZGAk8DwwaAhsUDSQjAiw+AwkKE?=
 =?us-ascii?q?AIWAx0UBDARCQsmAyoGNgISDAYGBlwgFgkEIwMIBANQAyBwEQMEGgQLB3aDP?=
 =?us-ascii?q?QQTRAMQgTIGihSDFQIFIymBd4ESGIMOToFWLQMJAwcFSUADCxgNSBEsNQYOG?=
 =?us-ascii?q?wYiH28HpH0Bgm4BPT4UgSZKCIEqkkuSAYEynzeEHYwMlR0aM4VbpFQBmGIgp?=
 =?us-ascii?q?ACEY4FkOoFbTSMVgyIJSRkPjjmDA50CIzU7AgcLAQEDCYpoAQE?=
IronPort-Data: A9a23:m5HBra8aLg0w8bsVOYOJDrUDXn6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2ROD2GCM/ePN2Pxf9txO97i905T7ZPUy9NrSAFq+H9EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbjpOs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0KfaKnmToMqP81DhL3rrhN9QFl0oHbRNr46bAUkWn
 RAZADkJahbGjOWszffiE69nh98oK4/gO4Z3VnNIlG6CS614B8mYBfyRvre03x9o7ixKNejVZ
 8cDbz1yRB/BeBZIfFwQDfrSmc/y2imhKGQB9wL9SawfvS/D9TZ04rLXc9fPJOW2SuROj0LBj
 zeTl4j+KkpHbIPEk2XtHmiXruvOmz7rHYEfDru18tZ0j1CJgG8eEhsbUR28u/bRokq/Xc9Pb
 k8e5ysqoYAs+0GxCNrwRRu1pDiDpBF0c9xRGOo+4RqlxKjd+AKUQGUZJhZHYcAmvckeRjEw0
 FKN2dTzClRHtbSOQHKc7LCFhTC/Iy4YKSkFfyBscOcey9DnpId2hRXVQ5M6Sei+j8b+Hnf7x
 DXiQDUCa6s7ldMA1omq+0z7nhXwp5+OZDAv+hv3Zzfwhu9mX7KNa4ut4FndyP9PKoeFU1WM1
 ETofeDAtYji6rnTzkSwrPUxIV2/2xqS3NThbbNHFp0l8XGm/GSuONkJpjp/P0xudM0DfFcFg
 XM/WysPuve/31PzMcebhr5d7exxlsAM8vy+CZjpgiJmOMQZSeN+1HgGibSs927silMwtqo0J
 I2Wd82hZV5DVv09lGfoHLlEjOZ3rszb+Y81bc2rp/hA+efPDEN5tZ9VWLdzRrlgs/Pa+lm9H
 yh3bpTSkn2zr9ESkgGMrNZMdgpVRZTKLZv3sMdQPvWSORZrHXppCvnah9scl39NwcxoehPz1
 ijlACdwkQOn7VWecFniQi44MtvHA80gxU/XyARxZz5ELVB5P9b2hEreHrNqFYQaGBtLlqcuE
 qVeIpzZXpyiiF3volwgUHU0l6Q6HDzDuO5EF3HNjOQXF3K4ezH0xw==
IronPort-HdrOrdr: A9a23:YNyNIa4SsDzk1dGpMAPXwMfXdLJyesId70hD6qm+c3Bom6uj5q
 KTdZsguyMc5Ax6ZJhCo6HiBED/exLhHPdOiOF7AV7IZmbbUQWTQb2KxLGSpgEIYxefygaYvp
 0QFJSXz7bLfDxHsfo=
X-Talos-CUID: =?us-ascii?q?9a23=3AEJzxFWh/v0hpVKjmWoBNZEK3YzJuamDWzVvBJVO?=
 =?us-ascii?q?EFEE1SbrSY2GK5L1Eqp87?=
X-Talos-MUID: 9a23:QhcDEQkU6wznDguJOyzndno8c9dR2aGcAnpOnI9YgvWLFDdhP2602WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,175,1708387200"; 
   d="scan'208";a="248631178"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 15:30:30 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 432FUTlY029489;
	Tue, 2 Apr 2024 15:30:29 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Add MO(mod objs) variable to process ext modules with subdirs
Date: Tue,  2 Apr 2024 08:30:27 -0700
Message-Id: <20240402153028.1378868-1-vchernou@cisco.com>
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
X-Outbound-Node: alln-core-11.cisco.com

The change allow to build external modules with nested makefiles.
With current unofficial way(using "src" variable) it is posible to build
external(out of tree) kernel module with separating source and build
artifacts dirs but with nested makefiles it doesn't work properly.
Build system trap to recursion inside makefiles, articafts output dir
path grow with each iteration until exceed max path len and build failed
Providing "MO" variable and using "override" directive with declaring
"src" variable solve the problem
Usage example:
make -C KERNEL_SOURCE_TREE MO=BUILD_OUT_DIR M=EXT_MOD_SRC_DIR modules

Cc: xe-linux-external@cisco.com
Cc: Valerii Chernous <vchernou@cisco.com>
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 Makefile               | 17 +++++++++++++++++
 scripts/Makefile.build |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/Makefile b/Makefile
index 4bef6323c47d..5858708d357c 100644
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
+ifeq (KBUILD_EXTMOD,)
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



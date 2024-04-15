Return-Path: <linux-kernel+bounces-144900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE98A4C58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F5B289516
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134C50A78;
	Mon, 15 Apr 2024 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CMyLI6s+"
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675A4E1CC;
	Mon, 15 Apr 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176097; cv=none; b=uOJ1Shi+TQsxz7fx6HSTj11BoI+kjgWz9mgLzM4NPo9lQgwOZ5Af4NmEgFKW3gDWe0gHknfZAXT8WkBZqhksdQi5vOU7yPI3eL9QfDxI5mTpXDBToE67Hy1RF9TSAP41h6X+wImRhadSdD3dvJB+x5zQj9g4vKm5qm84tndzHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176097; c=relaxed/simple;
	bh=RqAEBdXkuhhoWsHmsOHKzOs4fXtCaTOFoBogX3Q8SOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KieW9jcysYUgLETm6+Af5QhQxgpvxiQbBmKSjY+Qn8ZCzMbEtwEkBoAPHwaJIsbWjQfuteMffzcuRbzXD33X7ZH4RaM2JgIuGfqT8qsWOcKTq4cfcqKVtPVn8JhaKPBq2uEdG3sihOQAImKKc9XfwyQOUAunLRNnDKbm4qrdlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=CMyLI6s+; arc=none smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1361; q=dns/txt; s=iport;
  t=1713176096; x=1714385696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MDwG+Mia5B8PCehRdAN2ame1UKYXToOdUZOyoXacjTc=;
  b=CMyLI6s+UV8vRtptoapS7yrC/f9FWiAp8BWDkNlvVUseZwEpFSfUAjjU
   q47Gn5TbeqTI+P2fGRKsVErnywJl6gLgTB5mu/D3oi/JltuJJg+Y52TNY
   XSU5moGOirMTrzoZ7mubS/qQvuSbDyiY0vep994mAx52MU6Ni64gBLGSJ
   U=;
X-CSE-ConnectionGUID: 2YZZw2mRRBasH7Yf+OkTyQ==
X-CSE-MsgGUID: IQXdst5ATaaixhnSd/ND9w==
X-IPAS-Result: =?us-ascii?q?A0AwAQBB/RxmmJtdJa1agliDQFZBSJY9i3OSGIElA1YPA?=
 =?us-ascii?q?QEBDzETBAEBhQaIGQImNAkOAQIEAQEBAQMCAwEBAQEBAQEBBgEBBQEBAQIBB?=
 =?us-ascii?q?wUUAQEBAQEBAQEeGQUQDieFbQ2GXDYBRoE9ARKDAAGCXwIBsiCCLIEB3i+Ba?=
 =?us-ascii?q?hiBMI0HhWQnG4FJRIEVg2iKZCIEhiB+mk9KgSMDWSERAVUTDhQPDBoCGxQNJ?=
 =?us-ascii?q?CMCKT4DCQoQAhYDHRQELhEJCyYDKgY5AhIMBgYGWyAWCQQjAwgEA1ADIHARA?=
 =?us-ascii?q?wQaBAsHdYM5BBNEAxCBMgaKDIIJgQwCBSEpgXeBERiDCUuCDwKCe4E5AwkDB?=
 =?us-ascii?q?wVJQAMLGA1IESw1Bg4bBkFuB5x2AYJ/AT1RTIFob5JOkgGBMp85hB2MDpUfG?=
 =?us-ascii?q?jOEBYFWpFgBiByQRiCCNKFOhGOBZDqBW00jFYMiCUkZD445H4JklgsjNTsCB?=
 =?us-ascii?q?wsBAQMJimgBAQ?=
IronPort-Data: A9a23:dLWsB68h2Xi5nE7aIP9lDrUDXX6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 TFKCmyAPvuNYDCnfdh+Ptuy8EoGucOEndRkHgBuqH1EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbjtJs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0OX2E0qg68mp9WfPaFuz8vstK0IKLLRNr46bAUkWn
 RAZACoGYhbGjOWszffnDOJtnc8kasLsOevzuFk5kmqfVqlgEMuFGviXjTNb9G9YasRmA/3ea
 tAfbidHZxXbaBoJMVASYH47tL751yihLW0F9jp5o4IW2ljf1xAs+YTkOdvFetqxSYJzsheH8
 zeuE2PRWUxCa4fFllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaK
 EYJ+y4ihbY9+VbtTdTnWRC85nmesXY0XdtbFOkz8ymDyKPP5wvfC3VsZjhIdNwvsuc1SCYs2
 1vPmMnmbRRquaacSXOH8aa8rj6oPyURa2gYakc5oRAt+dLvpsQ4iQjCC4olG6+uhdqzEjb1q
 9yXkMQgr+8iv/wUjaCBx3rOmBLzl5aKaQ0J9zyCCwpJ8ThFTIKiYoWp733S4vBBMJuVQzG9U
 J4sxpj2AAcmU8vlqcCdfNjhCo1F8BpsDdExqURkE59k/DO39jv/O4tR+zp5YkxuN67omAMFg
 meM4Gu9B7cKYBNGiJObharqU6zGKoC7SLzYugj8NIYmX3SIXFbvENtSTUCRxXvxt0MnjLsyP
 5yWGe71Ui9BUP02kGTnGbZGuVPO+szY7T6ILXwc50n2uYdymFbEIVv4GALXMbBntv/sTPv9q
 Y4HaKNmNCmzoMWlP3GIqtRMRbz7BXM6Hpvx49dGbfKOJxEuGWcqTZfsLUAJJeRYc1Buvr6Qp
 BmVAxYAoHKm3C2vAVvRMBhLNuiwNauTWFpmZ0TAy37yhSh6CWtuhY9CH6YKkU4Pr7UynaEsF
 6BUJK1twJ1nE1z6xtjUVrGlxKQKSfhhrVvm0/aNCNTnQ6Ndeg==
IronPort-HdrOrdr: A9a23:uXUJsai+e5f0n8HOuCSP8DQgCXBQXtUji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcK2+gs1N6ZNWGMhILCFu5fBOXZrgEIMheOk9K1rZ
 0BT0C7Y+eAamSTSq3BkW2FL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3AQ8WlVWjDH9P/ktlyZR8dSzm9LjJuKEzv/miKJnW?=
 =?us-ascii?q?CI29yaOKkRxy3+591qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AZrj4Jw0dPVumrBuRD5zkw+eXAjUjwp2eBFsRzLw?=
 =?us-ascii?q?6ssCFJSx2ADvaqhjmXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,203,1708387200"; 
   d="scan'208";a="199966856"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 10:13:47 +0000
Received: from sjc-ads-1541.cisco.com (sjc-ads-1541.cisco.com [171.70.59.233])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 43FADkp5026282;
	Mon, 15 Apr 2024 10:13:47 GMT
From: Valerii Chernous <vchernou@cisco.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/Makefile.build: fix ext mod subdirs build with separate src,build dirs
Date: Mon, 15 Apr 2024 03:13:44 -0700
Message-Id: <20240415101345.3807776-1-vchernou@cisco.com>
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
X-Outbound-Node: rcdn-core-4.cisco.com

The change allow to build external modules with nested makefiles.
Current unofficial way(using "src" variable) allow to build
external(out of tree) kernel module with separating source and build
artifacts dirs but with nested makefiles it doesn't work properly.
Build system trap to recursion inside makefiles, articafts output dir
path grow with each iteration until exceed max path len and build failed
This fix update "src" var during processing subdirs and resolve
recursion issue
Usage example:
make -C KERNEL_SOURCE_TREE M=BUILD_OUT_DIR src=EXT_MOD_SRC_DIR modules

Cc: Valerii Chernous <vchernou@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Valerii Chernous <vchernou@cisco.com>
---
 scripts/Makefile.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a293950e2e07..75ea9052ea4a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -490,6 +490,7 @@ $(single-subdir-goals): $(single-subdirs)
 PHONY += $(subdir-ym)
 $(subdir-ym):
 	$(Q)$(MAKE) $(build)=$@ \
+	$(if $(findstring command line,$(origin src)),src=$(patsubst $(obj)/%,$(src)/%,$@)) \
 	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
 	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1) \
 	$(filter $@/%, $(single-subdir-goals))
-- 
2.35.6



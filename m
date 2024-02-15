Return-Path: <linux-kernel+bounces-67711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE18856F84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345D81C21550
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46663141988;
	Thu, 15 Feb 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="zl8HHMua"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C113AA32;
	Thu, 15 Feb 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033568; cv=none; b=K8q9wdBtr2iNEeOGrzYxRAcI1VozwaLdj3HbJb5KJ1SBEZHmxigiV3PVXN862gp1eQ9DJa/1fnT9FWl4ggr377x94X/n+NWP7lOJfBOXXUtcND0XWSA5VxGCWO+P7kOGASuqYMMl+l387pFjOAg36/W2vME6eD+9QLTQDah/NvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033568; c=relaxed/simple;
	bh=qY5hh5BJmLss9k2lRLa3oNcQmmSDKwLM11o2XCBEAqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xk3JrsgDSC+WFeSM1nUnRObyVIHGYdNiADhAmV+hj5Mj40DzqsMEPbqyoo5d3oydyIJSG+19vyLso60XHuL2I6d1jB+LETbNbu0OP0fVA5tRhzNa/NsdBJUYJ41Q3R9vwYSDkWm48EvbZFIrABgjft1zRPQS6eF5ihiK0bgYeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=zl8HHMua; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 3D79730D84A3;
	Thu, 15 Feb 2024 22:45:54 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:mime-version:message-id:date:date
	:subject:subject:from:from:received:received:received; s=
	dkim20160331; t=1708033552; x=1709847953; bh=k9H/onLw4R/vaV9f5I9
	kzKzjWWyD9CLFEIFSbyA0sSM=; b=zl8HHMuaC2CnSBbLC2JbzTgfnXLiNcS7fdp
	1UaCiK7HVG5F0tmIgZjuresLNSOKSEMnUreZOd0ACK4FpxwX3A1qel0W5eZtyUa/
	7O2lH1CnXIJDlfZhnuGxwE7RWW2OaLOCo4yD+45S+fpomHl447j/tEotJ31STWug
	cX17R8CG4xPjNtGKVhzEqkqrBLQT71sQDxb2aQx2rfD9DCtSPpLTogmXrmI6T4OE
	M32EWR5SvSPxrzFcRxAsyVyRKXFPANzLE/zVpxGz8VSxMPkOTatlUwHa225/Hhi1
	eiqChr2hfVbcd1Csw+AhtcwRWZtlFoyfYtxT0kV4ahDZmIolCBaNLAO12Lk+ZA8Y
	/Mz7xYleziJN2tfiVZPpSnVGnR+gcCxcnPrFYM0+vK2F89nsWza4zmG2jrEUrDkl
	8Wl8z4PHteowTUh6TgdIbelrzVwWNYP72hv1BaZcLlaXz1KM39ss1nuNb8/0uHgr
	Ety2xjfGCliN2cXu54J61uH0KFb5zXlLxD5x5gnhs8Jq7+hyha6k0vchZWuBYqtD
	H/oy/OjaNRNlSUv6YdtIVCAjHmrXY3GbbQGefQBOMVppibM91n9MnhgwYrOmz49l
	logHck7nFyZfyhgUH5pfFHB/avszM+HnGoy7iMQnmMlEaxZzBkyypB0VsJhXqVcI
	U4uc+L98=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id jYDHNM0Cuv7L; Thu, 15 Feb 2024 22:45:52 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 9DC8530D849F;
	Thu, 15 Feb 2024 22:45:50 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 8DA5F30B2987;
	Thu, 15 Feb 2024 22:45:50 +0100 (CET)
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: it_IT: remove references to original documents
Date: Thu, 15 Feb 2024 22:45:46 +0100
Message-Id: <20240215214546.19947-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A relatively recent improvement to the document building process added a
functionality to point to documents in different languages. Hence, it is
not necessary to add an explicit link to the main English page.

This patch removes those references

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../translations/it_IT/admin-guide/README.rst          |  1 -
 .../it_IT/admin-guide/kernel-parameters.rst            |  1 -
 .../translations/it_IT/admin-guide/security-bugs.rst   |  1 -
 .../translations/it_IT/core-api/memory-allocation.rst  |  1 -
 .../translations/it_IT/core-api/symbol-namespaces.rst  |  1 -
 .../it_IT/devicetree/bindings/submitting-patches.rst   |  1 -
 .../translations/it_IT/doc-guide/parse-headers.rst     |  1 -
 .../translations/it_IT/kernel-hacking/hacking.rst      |  1 -
 .../translations/it_IT/kernel-hacking/index.rst        |  1 -
 .../translations/it_IT/kernel-hacking/locking.rst      |  1 -
 .../translations/it_IT/maintainer/configure-git.rst    | 10 ----------
 Documentation/translations/it_IT/process/1.Intro.rst   |  1 -
 Documentation/translations/it_IT/process/2.Process.rst |  1 -
 .../translations/it_IT/process/3.Early-stage.rst       |  1 -
 Documentation/translations/it_IT/process/4.Coding.rst  |  1 -
 Documentation/translations/it_IT/process/5.Posting.rst |  1 -
 .../translations/it_IT/process/6.Followthrough.rst     |  1 -
 .../translations/it_IT/process/7.AdvancedTopics.rst    |  1 -
 .../translations/it_IT/process/8.Conclusion.rst        |  1 -
 .../translations/it_IT/process/adding-syscalls.rst     |  1 -
 .../translations/it_IT/process/applying-patches.rst    |  1 -
 .../translations/it_IT/process/botching-up-ioctls.rst  |  1 -
 Documentation/translations/it_IT/process/changes.rst   |  1 -
 .../translations/it_IT/process/clang-format.rst        |  1 -
 .../translations/it_IT/process/code-of-conduct.rst     |  2 --
 .../translations/it_IT/process/coding-style.rst        |  1 -
 .../translations/it_IT/process/deprecated.rst          |  1 -
 .../translations/it_IT/process/development-process.rst |  1 -
 .../translations/it_IT/process/email-clients.rst       |  1 -
 Documentation/translations/it_IT/process/howto.rst     |  1 -
 Documentation/translations/it_IT/process/index.rst     |  1 -
 .../translations/it_IT/process/kernel-docs.rst         |  1 -
 .../it_IT/process/kernel-driver-statement.rst          |  1 -
 .../it_IT/process/kernel-enforcement-statement.rst     |  1 -
 .../translations/it_IT/process/license-rules.rst       |  1 -
 .../translations/it_IT/process/magic-number.rst        |  1 -
 .../it_IT/process/maintainer-handbooks.rst             |  1 -
 .../it_IT/process/maintainer-pgp-guide.rst             |  1 -
 .../translations/it_IT/process/maintainer-tip.rst      |  1 -
 .../translations/it_IT/process/maintainers.rst         |  1 -
 .../translations/it_IT/process/management-style.rst    |  1 -
 .../it_IT/process/programming-language.rst             |  1 -
 .../translations/it_IT/process/stable-api-nonsense.rst |  1 -
 .../translations/it_IT/process/stable-kernel-rules.rst |  1 -
 .../translations/it_IT/process/submit-checklist.rst    |  1 -
 .../translations/it_IT/process/submitting-patches.rst  |  1 -
 .../it_IT/process/volatile-considered-harmful.rst      |  1 -
 .../translations/it_IT/riscv/patch-acceptance.rst      |  1 -
 48 files changed, 58 deletions(-)
 delete mode 100644 Documentation/translations/it_IT/maintainer/configure-git.rst

diff --git a/Documentation/translations/it_IT/admin-guide/README.rst b/Documentation/translations/it_IT/admin-guide/README.rst
index c874586a9af9..bef37dc5ff6d 100644
--- a/Documentation/translations/it_IT/admin-guide/README.rst
+++ b/Documentation/translations/it_IT/admin-guide/README.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/admin-guide/README.rst <readme>`
 
 .. _it_readme:
 
diff --git a/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
index 0e36d82a92be..7bc0c102d05d 100644
--- a/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
+++ b/Documentation/translations/it_IT/admin-guide/kernel-parameters.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
 
 .. _it_kernelparameters:
 
diff --git a/Documentation/translations/it_IT/admin-guide/security-bugs.rst b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
index 20994f4bfa31..b447485c64a6 100644
--- a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
+++ b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/security-bugs.rst <securitybugs>`
 
 .. _it_securitybugs:
 
diff --git a/Documentation/translations/it_IT/core-api/memory-allocation.rst b/Documentation/translations/it_IT/core-api/memory-allocation.rst
index 11d5148f8d6b..1be788f1ee99 100644
--- a/Documentation/translations/it_IT/core-api/memory-allocation.rst
+++ b/Documentation/translations/it_IT/core-api/memory-allocation.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
 
 .. _it_memory_allocation:
 
diff --git a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
index 17abc25ee4c1..2eb255c70144 100644
--- a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
+++ b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: Documentation/core-api/symbol-namespaces.rst
 
 ===========================
 Spazio dei nomi dei simboli
diff --git a/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst b/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
index b473cd2190be..520cddc8358a 100644
--- a/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
+++ b/Documentation/translations/it_IT/devicetree/bindings/submitting-patches.rst
@@ -2,7 +2,6 @@
 
 .. include:: ../../disclaimer-ita.rst
 
-:Original: Documentation/devicetree/bindings/submitting-patches.rst
 
 ================================================
 Sottomettere patch per devicetree (DT) *binding*
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
index c7076a21667a..c987d5ac741b 100644
--- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: Documentation/doc-guide/index.rst
 
 =========================================
 Includere gli i file di intestazione uAPI
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index dd06bfc1a050..b8bb1ba9d864 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -3,7 +3,6 @@
 .. note:: Per leggere la documentazione originale in inglese:
 	  :ref:`Documentation/kernel-hacking/hacking.rst <kernel_hacking_hack>`
 
-:Original: :ref:`Documentation/kernel-hacking/hacking.rst <kernel_hacking_hack>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_kernel_hacking_hack:
diff --git a/Documentation/translations/it_IT/kernel-hacking/index.rst b/Documentation/translations/it_IT/kernel-hacking/index.rst
index 50228380bd50..69395b8c1a5a 100644
--- a/Documentation/translations/it_IT/kernel-hacking/index.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/index.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/kernel-hacking/index.rst <kernel_hacking>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_kernel_hacking:
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 4c21cf60f775..b707be620fb5 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -2,7 +2,6 @@
 
 .. c:namespace:: it_IT
 
-:Original: :ref:`Documentation/kernel-hacking/locking.rst <kernel_hacking_lock>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_kernel_hacking_lock:
diff --git a/Documentation/translations/it_IT/maintainer/configure-git.rst b/Documentation/translations/it_IT/maintainer/configure-git.rst
deleted file mode 100644
index 8316fa53946f..000000000000
--- a/Documentation/translations/it_IT/maintainer/configure-git.rst
+++ /dev/null
@@ -1,10 +0,0 @@
-.. include:: ../disclaimer-ita.rst
-
-:Original: Documentation/process/botching-up-ioctls.rst
-
-.. _it_configuregit:
-
-Configurare Git
-===============
-
-.. note::  To be translated
diff --git a/Documentation/translations/it_IT/process/1.Intro.rst b/Documentation/translations/it_IT/process/1.Intro.rst
index c1be6dc398a7..eabbc5311a10 100644
--- a/Documentation/translations/it_IT/process/1.Intro.rst
+++ b/Documentation/translations/it_IT/process/1.Intro.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/1.Intro.rst <development_process_intro>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_intro:
diff --git a/Documentation/translations/it_IT/process/2.Process.rst b/Documentation/translations/it_IT/process/2.Process.rst
index 25cd00351c03..66da1a8ae12a 100644
--- a/Documentation/translations/it_IT/process/2.Process.rst
+++ b/Documentation/translations/it_IT/process/2.Process.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/2.Process.rst <development_process>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_process:
diff --git a/Documentation/translations/it_IT/process/3.Early-stage.rst b/Documentation/translations/it_IT/process/3.Early-stage.rst
index 0809de39108a..89c686e4b1b0 100644
--- a/Documentation/translations/it_IT/process/3.Early-stage.rst
+++ b/Documentation/translations/it_IT/process/3.Early-stage.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/3.Early-stage.rst <development_early_stage>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_early_stage:
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index 54fd255b77d0..56833ffc993d 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/4.Coding.rst <development_coding>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_coding:
diff --git a/Documentation/translations/it_IT/process/5.Posting.rst b/Documentation/translations/it_IT/process/5.Posting.rst
index a7e2a3238415..0559e9043a8d 100644
--- a/Documentation/translations/it_IT/process/5.Posting.rst
+++ b/Documentation/translations/it_IT/process/5.Posting.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/5.Posting.rst <development_posting>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_development_posting:
diff --git a/Documentation/translations/it_IT/process/6.Followthrough.rst b/Documentation/translations/it_IT/process/6.Followthrough.rst
index df7d5fb28832..f4ce05959046 100644
--- a/Documentation/translations/it_IT/process/6.Followthrough.rst
+++ b/Documentation/translations/it_IT/process/6.Followthrough.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/6.Followthrough.rst <development_followthrough>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_followthrough:
diff --git a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
index dffd813a0910..463da627ad09 100644
--- a/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/it_IT/process/7.AdvancedTopics.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/7.AdvancedTopics.rst <development_advancedtopics>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_development_advancedtopics:
diff --git a/Documentation/translations/it_IT/process/8.Conclusion.rst b/Documentation/translations/it_IT/process/8.Conclusion.rst
index 32659ff467c0..a32795b75faf 100644
--- a/Documentation/translations/it_IT/process/8.Conclusion.rst
+++ b/Documentation/translations/it_IT/process/8.Conclusion.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/8.Conclusion.rst <development_conclusion>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_conclusion:
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index df8c652d004b..809587e3e7de 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/adding-syscalls.rst <addsyscalls>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_addsyscalls:
diff --git a/Documentation/translations/it_IT/process/applying-patches.rst b/Documentation/translations/it_IT/process/applying-patches.rst
index 1d30e5cd2a3d..c6401f90ab6f 100644
--- a/Documentation/translations/it_IT/process/applying-patches.rst
+++ b/Documentation/translations/it_IT/process/applying-patches.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/applying-patches.rst <applying_patches>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_applying_patches:
diff --git a/Documentation/translations/it_IT/process/botching-up-ioctls.rst b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
index 91732cdf808a..cdc13bed030f 100644
--- a/Documentation/translations/it_IT/process/botching-up-ioctls.rst
+++ b/Documentation/translations/it_IT/process/botching-up-ioctls.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: Documentation/process/botching-up-ioctls.rst
 
 ==========================================
 (Come evitare di) Raffazzonare delle ioctl
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index f37c53f8b524..d7952edd3108 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/changes.rst <changes>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_changes:
diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/process/clang-format.rst
index 29f83c198025..f5a815124171 100644
--- a/Documentation/translations/it_IT/process/clang-format.rst
+++ b/Documentation/translations/it_IT/process/clang-format.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/clang-format.rst <clangformat>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_clangformat:
diff --git a/Documentation/translations/it_IT/process/code-of-conduct.rst b/Documentation/translations/it_IT/process/code-of-conduct.rst
index 7dbd7f55f37c..16f66b5d32be 100644
--- a/Documentation/translations/it_IT/process/code-of-conduct.rst
+++ b/Documentation/translations/it_IT/process/code-of-conduct.rst
@@ -1,7 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
-
 .. _it_code_of_conduct:
 
 Accordo dei contributori sul codice di condotta
diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 284a75ac19f8..a164f45a2fa8 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/coding-style.rst <codingstyle>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_codingstyle:
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index ba0ed7dc154c..f489fd6b172e 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -2,7 +2,6 @@
 
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/deprecated.rst <deprecated>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_deprecated:
diff --git a/Documentation/translations/it_IT/process/development-process.rst b/Documentation/translations/it_IT/process/development-process.rst
index 20e77c9816a1..220acb2a2978 100644
--- a/Documentation/translations/it_IT/process/development-process.rst
+++ b/Documentation/translations/it_IT/process/development-process.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/development-process.rst <development_process_main>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_development_process_main:
diff --git a/Documentation/translations/it_IT/process/email-clients.rst b/Documentation/translations/it_IT/process/email-clients.rst
index 76ca3226c8cd..8cd95b38ec37 100644
--- a/Documentation/translations/it_IT/process/email-clients.rst
+++ b/Documentation/translations/it_IT/process/email-clients.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :doc:`../../../process/email-clients`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_email_clients:
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 052f1b3610cb..5067d8fbb8ce 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/howto.rst <process_howto>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_process_howto:
diff --git a/Documentation/translations/it_IT/process/index.rst b/Documentation/translations/it_IT/process/index.rst
index cd7977905fb8..277486cf91b0 100644
--- a/Documentation/translations/it_IT/process/index.rst
+++ b/Documentation/translations/it_IT/process/index.rst
@@ -5,7 +5,6 @@
 
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/index.rst <process_index>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_process_index:
diff --git a/Documentation/translations/it_IT/process/kernel-docs.rst b/Documentation/translations/it_IT/process/kernel-docs.rst
index eadcbf50a1b5..962cf4ae7de6 100644
--- a/Documentation/translations/it_IT/process/kernel-docs.rst
+++ b/Documentation/translations/it_IT/process/kernel-docs.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 
diff --git a/Documentation/translations/it_IT/process/kernel-driver-statement.rst b/Documentation/translations/it_IT/process/kernel-driver-statement.rst
index f016a75a9d6e..3944d7b9e41f 100644
--- a/Documentation/translations/it_IT/process/kernel-driver-statement.rst
+++ b/Documentation/translations/it_IT/process/kernel-driver-statement.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_process_statement_driver:
diff --git a/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst b/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
index 1f62da622e26..0eb947f339b0 100644
--- a/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_process_statement_kernel:
diff --git a/Documentation/translations/it_IT/process/license-rules.rst b/Documentation/translations/it_IT/process/license-rules.rst
index 4cd87a3a7bf9..574cf43ee01d 100644
--- a/Documentation/translations/it_IT/process/license-rules.rst
+++ b/Documentation/translations/it_IT/process/license-rules.rst
@@ -2,7 +2,6 @@
 
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_kernel_licensing:
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
index ae92ab633c16..3918864a67d7 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/magic-number.rst <magicnumbers>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_magicnumbers:
diff --git a/Documentation/translations/it_IT/process/maintainer-handbooks.rst b/Documentation/translations/it_IT/process/maintainer-handbooks.rst
index d840145bcceb..65a40f2ed7a1 100644
--- a/Documentation/translations/it_IT/process/maintainer-handbooks.rst
+++ b/Documentation/translations/it_IT/process/maintainer-handbooks.rst
@@ -2,7 +2,6 @@
 
 .. include:: ../disclaimer-ita.rst
 
-:Original: Documentation/process/maintainer-handbooks.rst
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_maintainer_handbooks_main:
diff --git a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
index cdc43c4a9b0b..bb7ab05630a3 100644
--- a/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
+++ b/Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/maintainer-pgp-guide.rst <pgpguide>`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_pgpguide:
diff --git a/Documentation/translations/it_IT/process/maintainer-tip.rst b/Documentation/translations/it_IT/process/maintainer-tip.rst
index 126f17ee541e..4d48dd70cdbd 100644
--- a/Documentation/translations/it_IT/process/maintainer-tip.rst
+++ b/Documentation/translations/it_IT/process/maintainer-tip.rst
@@ -2,7 +2,6 @@
 
 .. include:: ../disclaimer-ita.rst
 
-:Original: Documentation/process/maintainer-tip.rst
 
 Il tascabile dei sorgenti tip
 =============================
diff --git a/Documentation/translations/it_IT/process/maintainers.rst b/Documentation/translations/it_IT/process/maintainers.rst
index 3225f7c89fda..8642df51a683 100644
--- a/Documentation/translations/it_IT/process/maintainers.rst
+++ b/Documentation/translations/it_IT/process/maintainers.rst
@@ -1,4 +1,3 @@
-:Original: Documentation/process/maintainers.rst
 
 Lista dei manutentori e come inviare modifiche al kernel
 ========================================================
diff --git a/Documentation/translations/it_IT/process/management-style.rst b/Documentation/translations/it_IT/process/management-style.rst
index 76ed074082ea..19b6982b8506 100644
--- a/Documentation/translations/it_IT/process/management-style.rst
+++ b/Documentation/translations/it_IT/process/management-style.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :doc:`../../../process/management-style`
 :Translator: Alessia Mantegazza <amantegazza@vaga.pv.it>
 
 .. _it_managementstyle:
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
index 5bc5b9d42f31..2ac207c96187 100644
--- a/Documentation/translations/it_IT/process/programming-language.rst
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_programming_language:
diff --git a/Documentation/translations/it_IT/process/stable-api-nonsense.rst b/Documentation/translations/it_IT/process/stable-api-nonsense.rst
index cdfc509b8566..3987944437f7 100644
--- a/Documentation/translations/it_IT/process/stable-api-nonsense.rst
+++ b/Documentation/translations/it_IT/process/stable-api-nonsense.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_stable_api_nonsense:
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 248bf1e4b171..9a249227d1bd 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_stable_kernel_rules:
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 2fc09cc1f0be..520fa808647a 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_submitchecklist:
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index f91c8092844f..8de4a4a5afde 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_submittingpatches:
diff --git a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
index 4fff9a59b548..2b976bcf8970 100644
--- a/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/it_IT/process/volatile-considered-harmful.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :ref:`Documentation/process/volatile-considered-harmful.rst <volatile_considered_harmful>`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_volatile_considered_harmful:
diff --git a/Documentation/translations/it_IT/riscv/patch-acceptance.rst b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
index 2d7afb1f6959..0603a3c55631 100644
--- a/Documentation/translations/it_IT/riscv/patch-acceptance.rst
+++ b/Documentation/translations/it_IT/riscv/patch-acceptance.rst
@@ -1,6 +1,5 @@
 .. include:: ../disclaimer-ita.rst
 
-:Original: :doc:`../../../arch/riscv/patch-acceptance`
 :Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 arch/riscv linee guida alla manutenzione per gli sviluppatori
-- 
2.39.2



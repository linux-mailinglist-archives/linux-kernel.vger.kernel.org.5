Return-Path: <linux-kernel+bounces-6377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754498197EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31930287955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA6ADDC6;
	Wed, 20 Dec 2023 05:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AyM1Wu4I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA6C2C5;
	Wed, 20 Dec 2023 05:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703048576;
	bh=aov3XsnKUY3GBBlV2AX+kFD0m3ya0yI+MQWXFBF/bdQ=;
	h=From:Date:Subject:To:Cc:From;
	b=AyM1Wu4IwJtbxgxmdweZz3kowBY2HVz+67dutZxTWqunmrHk/nYtPcK+SKrQU7rZG
	 5wjWOGDTlHIaNjgVwc00hI4mM4O2/sMAOE6Au55CX8DYx2RtCWWRY9bBgbddoCFstE
	 HSabCEjzTfLCCmYSEQw6++TOyifJfRJRsH83FNxA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 20 Dec 2023 06:02:49 +0100
Subject: [PATCH] Docs: remove mentions of fdformat from util-linux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231220-docs-fdformat-v1-1-0d05279e5d83@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHh1gmUC/x3MQQqAIBBA0avErBN0gqCuEi1MZ2oWaWhEIN49a
 fkW/xfIlIQyzF2BRI9kiaHB9B24w4adlPhmQI2DQdTKR5cVe47ptLfaDGpNbuKRDbTmSsTy/r9
 lrfUDSIjJt18AAAA=
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703048575; l=1799;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aov3XsnKUY3GBBlV2AX+kFD0m3ya0yI+MQWXFBF/bdQ=;
 b=s82G8QO86ONdxKq5S9zqasrA/pAkwKu8hQb568diFn2pTUIX6zqjPUh9186htP2vmktT5cmpl
 0FUpOwh2XaqBFjI94pMuTfO9Q5M33n786vC7UuPueWi78pfwf3qZ/xu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since util-linux commit 13b26e3c36d1
("fdformat: remove command from default build")
the fdformat tool is not built anymore by default.
As a result it is not packaged anymore by distributions and therefore
not usable by users.

Instead mention the "mount" command as more likely to be present
alternative.

Also drop the reference to fdformat from the list of features of new
versions of util-linux.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/process/changes.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bb96ca0f774b..a8827b442649 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -39,7 +39,7 @@ binutils               2.25             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 pahole                 1.16             pahole --version
-util-linux             2.10o            fdformat --version
+util-linux             2.10o            mount --version
 kmod                   13               depmod -V
 e2fsprogs              1.41.4           e2fsck -V
 jfsutils               1.1.3            fsck.jfs -V
@@ -213,7 +213,7 @@ Util-linux
 
 New versions of util-linux provide ``fdisk`` support for larger disks,
 support new options to mount, recognize more supported partition
-types, have a fdformat which works with 2.4 kernels, and similar goodies.
+types, and similar goodies.
 You'll probably want to upgrade.
 
 Ksymoops

---
base-commit: 55cb5f43689d7a9ea5bf35ef050f12334f197347
change-id: 20231220-docs-fdformat-b1200ec9f6f1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



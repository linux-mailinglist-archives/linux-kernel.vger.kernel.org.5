Return-Path: <linux-kernel+bounces-168367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ED58BB797
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5431F25386
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85077135A46;
	Fri,  3 May 2024 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YwWTH4o4"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C058D12EBD8;
	Fri,  3 May 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775563; cv=none; b=FiLZDNCEfA3iKjCDHhoJdSPrDZrEgKu9duOdqCKMUMaiYZzkOotbfOAYHVeJvrzxYn/qJz4jo938B+qGFNHoHoQRN+TsomKbiHYyuhQscpazOVzuzKAqJnRMrbkZd+GKuJpkIjoZD7W1BQHRlWlFOa6C6LwxzzWZeXMtwS6EySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775563; c=relaxed/simple;
	bh=21I/iVXiY4P/S5VIMv3ONJQ3Fh+mGWukiz2n3SF/yHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C93EBEGcHfdPJiC2kxpERNPfJPhjZ7TAPcxtVSaAVUEJhN0NxvZmmzJ9FhI7ZC3V1CKq1d7nGim5uFTjtZQnTNUjz237QMtv1bL30LkbHeWVHLOr3Ifvb0bNMGDfr3DyNS3CB2ckScL2RVIvxlyvilhp5qobwgN5XJzzoCI4bU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YwWTH4o4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id EEDC620B2CBA; Fri,  3 May 2024 15:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEDC620B2CBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=BclhrrU8GsfAxJr08fvQ1SP/XE81ON3iDJw76HmsLpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwWTH4o4EThAk2MuhoY9yceDGfo7AfMywOD/tECDntb/szro2KBeT/kxv6qhcLnGV
	 hU0J2Bq9qkEisDYIm+rEGMAIMmGT8bNxsMrOR3Zl2W+tERld7QzAQBsoe49BCjXPNT
	 soC3qm3Cz8dV6v/v1F0Z/0iV+SkSRqlMuhD1unDs=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v18 21/21] MAINTAINERS: ipe: add ipe maintainer information
Date: Fri,  3 May 2024 15:32:31 -0700
Message-Id: <1714775551-22384-22-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Update MAINTAINERS to include ipe maintainer information.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

--
v1-v16:
  + Not present

v17:
  + Introduced

v18:
  + No changes
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec0284125e8f..def7116eba7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10742,6 +10742,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 F:	security/integrity/
 F:	security/integrity/ima/
 
+INTEGRITY POLICY ENFORCEMENT (IPE)
+M:	Fan Wu <wufan@linux.microsoft.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://github.com/microsoft/ipe.git
+F:	Documentation/admin-guide/LSM/ipe.rst
+F:	Documentation/security/ipe.rst
+F:	scripts/ipe/
+F:	security/ipe/
+
 INTEL 810/815 FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.44.0



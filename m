Return-Path: <linux-kernel+bounces-143478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC08A39F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F959B2211B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910B6CDCB;
	Sat, 13 Apr 2024 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lJOlD+fh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A68F4C97;
	Sat, 13 Apr 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969774; cv=none; b=QLvoqBuWL3zaSTRplwhzKWnWhS7Ezy0Istr1bFdcrrlUDmZ25arap0NIPWrhtByFD+j2lPkliNdAYskEv153YSW97rlU4xR6yVtQ4kqV9EyLqbX6hcutL8Q5q68+nSvvKuAVlMrRZyxou4RCz+ezRnoStfOCOKUgtfqbqrcQ6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969774; c=relaxed/simple;
	bh=pBU/dUpHcW7hv4jahHyUxb9624g5oZLMksU7XwtQcWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QT8w+tWBGeKDRK8+TEL8NQu/Q/Ua83Td8mWXu6r4T41Qm0kIymA/UImXMWjTai2XwiJVW3Oc1OMgHXyWOU4Xlhmxqu+XYrG30GtuqxMOpV9zpRLmbOLflLfCEG5FQXzfKgaTB3uoTAfU4c9V2+Xz7sI8CYdrn3v+BlTcnwlXetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lJOlD+fh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id AD89A20FC5FA; Fri, 12 Apr 2024 17:56:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD89A20FC5FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969766;
	bh=RkLiZLmYY6yXHhJqHQYW5lgf/n+IHqe1I+s8c4aEHFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJOlD+fhAoGAuJ5iZUO71L5J5LCGOsNCchcUL6JHtoAoyT5JDX0HrG3Eqe3ErOvnU
	 BvMpI3b83kNEU7wV1u0gMFyOywTOm+CFsHhq6jKBWtwaDvWB2gnKNfr6G56JV/toT7
	 vogkh3rb+v16VTJ9Opjit07BN+AqWythNOtPfyQ8=
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
Subject: [PATCH v17 21/21] MAINTAINERS: ipe: add ipe maintainer information
Date: Fri, 12 Apr 2024 17:56:04 -0700
Message-Id: <1712969764-31039-22-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
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
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5b89687680b..93eb4e12a789 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10745,6 +10745,16 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
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



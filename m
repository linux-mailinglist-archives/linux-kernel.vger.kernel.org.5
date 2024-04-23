Return-Path: <linux-kernel+bounces-155939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A58AFAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C31C234DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5811114A612;
	Tue, 23 Apr 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFtOgot4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CB144D34;
	Tue, 23 Apr 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908755; cv=none; b=DnB5otSL/YmrwaR0o+Ax4c1uR7NluE/h+AiaX760svKa1mVYLX8SzvgZpS4oFdRz1hstRl+bO6NPPuFSaJi94eurZ2rB5/DuAq2hPWvmpYUKe64FvSa+jqy/Jk5uvc2h+tbHQ3lgpnjPUu617I93jRNSOB/2U5FObxzH9CyiNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908755; c=relaxed/simple;
	bh=sEQqf+wzeSom2bYuFt0QrLDhcjRdIUaBFD+1qqpVwW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iTnFwxQ1lBCpWdQp/eaw3ZysOjhFbBa5p6qXdGZDLrnJHUDo4/FYokwrJvB3wpsDHf9AUnveQsA56GRAQXuAwqWWMQl327/p4lsrdVjXb5HWZ24nE8HJauCUgFV1FHAqQ1YWTsOa9jg++4tNufUlTdLbLMk8Mt40qdp89kpOxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFtOgot4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87F1C32783;
	Tue, 23 Apr 2024 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713908755;
	bh=sEQqf+wzeSom2bYuFt0QrLDhcjRdIUaBFD+1qqpVwW0=;
	h=From:To:Cc:Subject:Date:From;
	b=TFtOgot4ZCPq0QHMRLQxzaZ4uihP3rp2F7DVxwmtqJaYrMTGPIvfSpca+W9YLkXt3
	 nyh9haVhBTEEzX815in8jzT2R2cqawGyYXjwvcLZl7U4T1+hEWQuGWLWudDs7i+rJ9
	 RP7MrHIgqdRrAUL3xUun1WrBr65Zr6bt2drxjQfa9EfK6o/N2qXvagxI8uTrUcutvo
	 fnlRMEVfbxZvhpJ49a5UoP+dEDgEzh3R71lZQ2Y1HJK7kc204T8vbsrncjfUN1DNaG
	 8XNG+4XHppiLd9M4wJ05sxmDImOcnxTtXWioGX4xhZ+9PVkjpvma3cshfEXlFAKp24
	 vtFGs2P8osyxg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3] MAINTAINERS: Update URL's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE DRIVER
Date: Wed, 24 Apr 2024 00:45:49 +0300
Message-ID: <20240423214549.8242-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TPM driver test suite URL to the MAINTAINERS files and move the wiki
URL to more appropriate location.

Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- No changes, resend.
v2:
- Fix typos: https://lore.kernel.org/linux-integrity/eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com/
- Fix typos and added ack: https://lore.kernel.org/linux-integrity/1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de/
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..6c20536e626e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12044,6 +12044,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
+W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 F:	security/integrity/platform_certs
 
 KFENCE
@@ -22381,7 +22382,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
-W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
+W:	https://gitlab.com/jarkkojs/linux-tpmdd-test
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
-- 
2.44.0



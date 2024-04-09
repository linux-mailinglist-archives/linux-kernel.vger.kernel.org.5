Return-Path: <linux-kernel+bounces-137507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D393E89E308
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BA21C21196
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7A158845;
	Tue,  9 Apr 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5WRpWzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785481586C7;
	Tue,  9 Apr 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689738; cv=none; b=lM5SMG3W4HMsCY12NFYAee4fGnmrlXJBoZtST7Ibdr9fQYo9TSlEZDNad/0oEU8tK6AxTMVs/ITB033yJfNGxu7SsN42keKputlYyNzhnvQpNa84gcesPS7qrjDL6gHgLH5V4Vt5aAA4eNMU0Z4IN6dIfJ95LWcyvexwY9BQRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689738; c=relaxed/simple;
	bh=hKJyPipwSlWNSIMizCRceeDh8wt+CqFsNp2LwxWis+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udDVBoyw+VxHm3sjBJB017Eh9GtrCeL1GJ/iPBwQGwDjztnNCwG9mwgtBL2S2rQ/JkF0bakB8UpVW3P5e3aPLWFpNHqxO1yH8JFEB+IdLHbqkrLfjqqlsSAHQTfgY4oyKaQ28LcO7Hl2RcPbuqntT/fKSiQeW5PvTOzqDCUnj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5WRpWzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A4BC43390;
	Tue,  9 Apr 2024 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689738;
	bh=hKJyPipwSlWNSIMizCRceeDh8wt+CqFsNp2LwxWis+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u5WRpWzIGF/bZH4GDBpMDJMxAJLFUV57XH28zaeEQbOo/x8XFXr+JGxBUzGJNAPWj
	 U1jJSvyyWGghoM83QjUVlwkWeOkeS8PE3sIm+BIvNi6h6hmYpS/rrrgt0ZkpRztAcl
	 8yN3iDXxyEjxvrRaxy2xuXIXfAPN/uVHo3cyGmK75Zf4J+kNSJGnbUFEoktsop5WVz
	 ghPz2/yXvbwhnKGmnTYxfCHLnuasg+CWOE6nLv0OYcJiKUAnQe9rCU8uzsZ0XIlDTk
	 7CW7kVByGVuehk+67p54WgAfY9dl5+ezOu8qDYztC3NksglGQfNK6jT/MqTYdxgb/9
	 9YEXu4NwNK/Dg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	"Daniel P . Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/2] MAINTAINERS: Update URL's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE DRIVER
Date: Tue,  9 Apr 2024 22:08:46 +0300
Message-ID: <20240409190847.10869-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190847.10869-1-jarkko@kernel.org>
References: <20240409190847.10869-1-jarkko@kernel.org>
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
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Typo fix: https://lore.kernel.org/all/eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com/
- Typo fix: https://lore.kernel.org/all/1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de/
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1339918df52a..01dc4940fc06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12015,6 +12015,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
+W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 F:	security/integrity/platform_certs
 
 KFENCE
@@ -22344,7 +22345,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
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



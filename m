Return-Path: <linux-kernel+bounces-91266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44854870C03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C651F26492
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7130D10A39;
	Mon,  4 Mar 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3NUKu1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2FE542;
	Mon,  4 Mar 2024 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586028; cv=none; b=EIC3x4vwZoC83Z2BhBTydny5hCg8CYYsq0+TDNPzzF5i+7so3VonT04Qhv9oq5ZQCefMCZgjBBxcw/6AU2v9tahWzJwGO8hD9QmUashBkaDfsgLxbqgCOQSDZl9WVK9X0y0V4G6be7SNTyzRMS875k3e9JmO2uG0W8nR0EzN9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586028; c=relaxed/simple;
	bh=Uc72TsYnh8JUOjGwrPZbuhoEBO5wvmtcnyzgyQEqjBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SS1O5P+XzWgPqqXWWscv/W/QYzWSbOPsESx2QNR2nH7rFuQHcnYn0mkuq7QuCnVDFIqyqW7G0UGQBJO7bvC6H3+9wX/JF7MYx83nHvPJdbBU2ufNk3PICqSrvCy7Z7JYsEAvC9kBaWOgvp2DfuVOqRxkXpzwm4fwKB4jYBACAKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3NUKu1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6167C433C7;
	Mon,  4 Mar 2024 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709586028;
	bh=Uc72TsYnh8JUOjGwrPZbuhoEBO5wvmtcnyzgyQEqjBM=;
	h=From:To:Cc:Subject:Date:From;
	b=o3NUKu1DRo8zQrm5vcb5gyuPnyW0j99q5QrM6MRctNN5GLijcBe017ychBKqshCoS
	 oTA2za1W4aI1CBK+pPb1dmBOwKnevpmtZPyA5HveF2QpUetN1TA2mBVwndKJW3gXx5
	 94V4jc3x0LtvFBQY6xw1j+4FxpRVAa3M1FxsVU0X7n8oo9wm4ILA6bgJ+bc//Tbamq
	 CTe0LO/AE3k0oMhctLwhHax2D4DoHBafWNxkU/VFxTRoPT6d/qZBgb//filiWAvB0q
	 xjTQ4IUb0StLGSXF9WWmallFfuqs/b9IisNQztWJBaJrhlK8ceqjLj0cjwV3VVa/kh
	 deClD2/6POtkA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE DRIVER
Date: Mon,  4 Mar 2024 23:00:19 +0200
Message-Id: <20240304210019.34018-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.40.1
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Fix typos: https://lore.kernel.org/linux-integrity/eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com/
- Fix typos and added ack: https://lore.kernel.org/linux-integrity/1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de/
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf77be03fb2b..99e0466663fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11947,6 +11947,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
+W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
 F:	security/integrity/platform_certs
 
 KFENCE
@@ -22278,7 +22279,7 @@ M:	Jarkko Sakkinen <jarkko@kernel.org>
 R:	Jason Gunthorpe <jgg@ziepe.ca>
 L:	linux-integrity@vger.kernel.org
 S:	Maintained
-W:	https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
+W:	https://gitlab.com/jarkkojs/linux-tpmdd-test
 Q:	https://patchwork.kernel.org/project/linux-integrity/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
 F:	drivers/char/tpm/
-- 
2.40.1



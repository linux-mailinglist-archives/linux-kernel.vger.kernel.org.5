Return-Path: <linux-kernel+bounces-108122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0B880646
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E571CB21D86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C8A3BBF9;
	Tue, 19 Mar 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/3cNKzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8C3BBE7;
	Tue, 19 Mar 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881428; cv=none; b=GvqoUfT4ka3yVB0tgH1QhaZ4NU2b2egcSDElJmiGfsgVpjIZ/cJ1R8bh3+dfW9jbcEgOMlW52Uwp3qI+LaFP4FFHj0uOkuvmx2y4AJh1sLvc0oMEB+JjYbyyOnO4iuCHN4DnvF0G1bbl0CinJwFIr8FSy/UMHtHW0J7T73aJ1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881428; c=relaxed/simple;
	bh=ax4r2DBaBvshd+m31sBVKdKua94Y5tDgpvNWLRBYi1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxA1syt8iSe5C31h36Wx2pmDQ/TefD54JJ943O0sObEXXc/4gBvjtWjK0K7bUtn4KIOebtsM3clPU8ylprzvBn6d+Iazlc3N4LxwbeIP6llFfLb8Gx+xxMir+ooTDIQKUoqTiWQm+y7euJc1vKJYvv5slr9mnmL3RssedhNVo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/3cNKzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972B4C433F1;
	Tue, 19 Mar 2024 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710881428;
	bh=ax4r2DBaBvshd+m31sBVKdKua94Y5tDgpvNWLRBYi1A=;
	h=From:To:Cc:Subject:Date:From;
	b=R/3cNKzf2jLJ97PHp8Dd5/NvqtmBPQrxbIcnPIKYyUYhlu8hOVDzj7no7Em5qwsHl
	 d/Gd5G6O6pC5KmhIhSK7bM7NcemPynNe9GSOvsq9fE2CTjLoPNVsuaoD3WR3dHdH17
	 snITfNRUWvLEB4/641UIgQeoRBIlTiLGlnEtCNx/muLbF6vVjoY6ecC/lcXN/kNP8z
	 MVYAoF75EowkV5belwjQcdbJYbPOWYZiBMx6X6v6HxGuJroqzlPtlc1XQO/7tnaJ1z
	 WpFboS+WnGLCcp93xzdRc1dy5jQhFSTFQT9G48qnufOSEbYVHOicNnaGRjj9Sa2ohy
	 07RcKF9Il2J2w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] MAINTAINERS: Update URL's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE DRIVER
Date: Tue, 19 Mar 2024 22:50:11 +0200
Message-ID: <20240319205012.54577-1-jarkko@kernel.org>
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: linux-integrity@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
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



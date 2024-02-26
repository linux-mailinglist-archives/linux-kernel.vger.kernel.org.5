Return-Path: <linux-kernel+bounces-80587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D958669FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E53B1F22BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22381BC56;
	Mon, 26 Feb 2024 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdV0oQs3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48361B96E;
	Mon, 26 Feb 2024 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928571; cv=none; b=Wouc5TDtfLYUwKSc/ywY+zVRn+IZxyK7Hl0LnLPVuhIi7WQCVYoHFfTYR3hsduyQWsHhlasdvZeVVT33poL4Q2rBGSl4UMHQGuCOi73suF9xWqnamFOZgLL7fxPA+VXTsjwBzwY6xhLEF9ULgY4aDDzTMK6yEb1LJN5oS+xxJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928571; c=relaxed/simple;
	bh=VzBdBR270wk6Rw87wAt99T+r6rZIf27FEzJNxzBR9PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apx8C0z0ttN1hKhC9MfdYHBniGtBwRM/lYht2uSLN41PaIdnT+SHCvXtIt8wESLHGxndR4PTsgDZY+e2TNkcpEcA/HUd+xXLSpDFMVdxzlbpRiuRzuU0EDr4qPEQgO3HX5bSjX96zLkDsSw515M0EnTAAiYomMlrKe1wCO8nZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdV0oQs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C024C433F1;
	Mon, 26 Feb 2024 06:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708928570;
	bh=VzBdBR270wk6Rw87wAt99T+r6rZIf27FEzJNxzBR9PE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZdV0oQs3SVvwwbtYNihraQfRgEde57fRXWC9BHgMFakv7y6ap7Csev4OR+sRCP3mQ
	 ajvuLaPOkivv3vpCGdf+DvawnBXDXiDg4un+7QYie+RBGlIHizirL0WX9BJlpsdNwi
	 UKVXNh7WJcUmZnZ7iXuZeXQQ5Rh77igVVZeA9Glc4ml6j6Yi5+QdDMzgrTtvDnu/Hk
	 +SicwQ3NPdZjV1qbsfSOVS4Vp5zO8+cUoiFeYlmKOhYn4SUH9NscsUcnpaN3EXQSkC
	 L09dsEg5j8lUO3BuJtwatfDtHPC33/zboOhc+nM8zXPQNuI0Duf7kHvaGh83Wf1lEC
	 8gJaHnNL8/quQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and TPM DEVICE RIVER
Date: Mon, 26 Feb 2024 08:22:45 +0200
Message-Id: <20240226062245.2279635-1-jarkko@kernel.org>
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
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf77be03fb2b..6380c1109b86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11947,6 +11947,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
 L:	linux-integrity@vger.kernel.org
 L:	keyrings@vger.kernel.org
 S:	Supported
+W:	https://kernsec.org/wiki/index.php/inux_Kernel_Integrity
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



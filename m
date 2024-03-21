Return-Path: <linux-kernel+bounces-110405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F3885ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1271C231BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9C1353F4;
	Thu, 21 Mar 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0QhQBUf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B956130E54;
	Thu, 21 Mar 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039538; cv=none; b=GlbNprUdKcZ5mIV5WYfG5Tbq2xzz3bnv7MnY2h6u6jWPuM5pNk1nbg0PPmJ9c+w7sAPqWW+x1Hoye4aNprxXMt3Lme24S1tQ566+cbdsaZcFohI0A/E5Gi6ntu9efqhpDjpMkphCv6HOkzlGGpnYFxiFiWL24n3oDpBMcWfhOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039538; c=relaxed/simple;
	bh=nPVWYcFVife9z6PvN7CZBdrGkGPDFZARTn8Jlbi06jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8Y0fuyQKSLoVwiPVSRFhns/kEWUOlQrcZsVrNTeBslGvIRj0ZhudE3aRvjEPj63D0USUfKZJ8c787auZgXKxbXe2pOkp0y7evzfh6OHM6nFgsK1W+vOtNafWajWbIXCBU8L7vNvNIEgaDCpYmsrA/L41o6KzgjgP+nBi0F7r0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0QhQBUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6728AC433C7;
	Thu, 21 Mar 2024 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039538;
	bh=nPVWYcFVife9z6PvN7CZBdrGkGPDFZARTn8Jlbi06jo=;
	h=From:To:Cc:Subject:Date:From;
	b=p0QhQBUfqBhYa0QHOFz2qzWrrtUZmGwvBVc1ven3CagVdge1xOMt6mi5/CAbFumaG
	 lLVDLvYdAJA48kGHY0T3BLbfFR0xuoLsnMHIvmvK+RlZKfNqM+eAuExhhPfqxdTUdW
	 K4KYpS+aA4PRgIzSJ7zbsuxC93sUc0oZPMVS0Jbj65Ggwgq39IW/tsLsnZdokrIHwP
	 05WBoKY82KPsnR8Gm04ENhFBmDSCPkGSDQM8sWRJxszfcvRE1feRkX1PHWWWcrNagA
	 6S8wF9mdknt7/Y2QlcfwFarDDJBf9FEVbz8iqHNBI0iVCjMzQR9u1osUuDF4tmuENu
	 GByjFZx4UYAgQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Daniel P . Smith" <dpsmith@apertussolutions.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	keyrings@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3] Documentation: tpm_tis
Date: Thu, 21 Mar 2024 18:43:07 +0200
Message-ID: <20240321164314.14732-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based recent discussions on LKML, provide preliminary bits of tpm_tis_core
dependent drivers. Includes only bare essentials but can be extended later
on case by case. This way some people may even want to read it later on.

Cc: Jonathan Corbet <corbet@lwn.net>
CC: Daniel P. Smith <dpsmith@apertussolutions.com>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: keyrings@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v3:
- Fixed incorrect buffer size:
  https://lore.kernel.org/linux-integrity/d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com/
v2:
- Fixed errors reported by Randy:
  https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
- Improved the text a bit to have a better presentation.
---
 Documentation/security/tpm/index.rst   |  1 +
 Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm_tis.rst

diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
index fc40e9f23c85..f27a17f60a96 100644
--- a/Documentation/security/tpm/index.rst
+++ b/Documentation/security/tpm/index.rst
@@ -5,6 +5,7 @@ Trusted Platform Module documentation
 .. toctree::
 
    tpm_event_log
+   tpm_tis
    tpm_vtpm_proxy
    xen-tpmfront
    tpm_ftpm_tee
diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
new file mode 100644
index 000000000000..078b75666086
--- /dev/null
+++ b/Documentation/security/tpm/tpm_tis.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+TPM FIFO interface Driver
+=========================
+
+FIFO (First-In-First-Out) is the name of the hardware interface used by the
+tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM Interface
+Specification, which is the hardware interface specification for TPM 1.x chips.
+
+Communication is based on a 20 KiB buffer shared by the TPM chip through a
+hardware bus or memory map, depending on the physical wiring. The buffer is
+further split into five equal-size 4 KiB buffers, which provide equivalent
+sets of registers for communication between the CPU and TPM. These
+communication endpoints are called localities in the TCG terminology.
+
+When the kernel wants to send commands to the TPM chip, it first reserves
+locality 0 by setting the requestUse bit in the TPM_ACCESS register. The bit is
+cleared by the chip when the access is granted. Once it completes its
+communication, the kernel writes the TPM_ACCESS.activeLocality bit. This
+informs the chip that the locality has been relinquished.
+
+Pending localities are served in order by the chip in descending order, one at
+a time:
+
+- Locality 0 has the lowest priority.
+- Locality 5 has the highest priority.
+
+Further information on the purpose and meaning of the localities can be found
+in section 3.2 of the TCG PC Client Platform TPM Profile Specification.
-- 
2.43.0



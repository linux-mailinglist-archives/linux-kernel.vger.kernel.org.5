Return-Path: <linux-kernel+bounces-91304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580C0870CB1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D5F288C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F47BB00;
	Mon,  4 Mar 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3lsQydi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966D1F60A;
	Mon,  4 Mar 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587659; cv=none; b=UJTQjP6+Rq+EwaTC60wBFkQQVnoInR0P+0f58Qb8Ec9uqcB+OT8RUeu5N6EAYcaOAcQ3Kb2g88J9h4pdXNi2jwgl9GzA6Dp2AR/OhHGVWpRMgFFcBlcD+q+mNoG9bZL62qp/MtEyIMsynmTPBomRxqDVMR/g0xfpe5eVjMw+rMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587659; c=relaxed/simple;
	bh=UY6mUVzXU4C6/zwtBskI3ysdKqTN2J6STcG/R2urtLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XREsXjMI1h2tKrZVzFKi7mPRbDjxTpirNHCoda38xh0w0gxx9ABsz0ckUpamWTdckC3r5alMtsIAFXTb58pJ3KxHcq7txelvXZJnk00Ml56yJsEwjYvuSsK4lYOSoxqYMltZJcAWPWVoEpYwESPAbiI4QkNfQpU/Q0JD86Wk17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3lsQydi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75524C433C7;
	Mon,  4 Mar 2024 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587658;
	bh=UY6mUVzXU4C6/zwtBskI3ysdKqTN2J6STcG/R2urtLI=;
	h=From:To:Cc:Subject:Date:From;
	b=R3lsQydiQPWi5DbHFUwZapv7I50IhUlpLYZSaKykoZ3dmPjxLt5XgfYVal0mIYicQ
	 ZmzjtA5DRR6ua4surkSF3tWeFFMWgIQ91vYAzLqSkJB4m89NJSFKiKpO9vjkNpW2OQ
	 elEvhcN3n47mWEm/EEN/W9e1h3K7g8DLnyQ28ffrXeNjCfAm0F0bvzsXNU+n/t1CsY
	 oPXEpJHQ8PEYP3kJL5ZKF+4bcpsLZtl/E8sAcC3pJhfDyHB2ekNBXNvVSl83KuZ4NL
	 9SBqKMLJ8P46negLZTlVmXDfmb9ou8VxfhT7SqSX7rM+BFYC5YLVObHtQBxtbvQu3Y
	 MOjPBv4m4sZdA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-doc@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Daniel P . Smith" <dpsmith@apertussolutions.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Alexander Steffen <Alexander.Steffen@infineon.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH] Documentation: tpm_tis
Date: Mon,  4 Mar 2024 23:27:34 +0200
Message-Id: <20240304212734.43213-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.40.1
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
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
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
index 000000000000..3cec0216a169
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
+`tpm_tis_core` dependent drivers. The prefix "tis" is named after TPM
+Interface Specification, which is the hardware interface specification for
+TPM 1.x chips.
+
+Communication is based on a 5 KiB buffer shared by the TPM chip through a
+hardware bus or memory map. The buffer is further split to five equal size
+buffers, which provide equivalent sets of registers for communication
+between CPU and TPM. The communication end points are called *localities*
+in the TCG terminology.
+
+When a kernel wants to send a commands to the TPM chip, it first reserves
+locality 0 by setting `requestUse` bit in `TPM_ACCESS` register. The bit is
+cleared by the chip when the access is granted. Once completed its
+communication, it sets `activeLocity` bit in the same register.
+
+Pending localities are served in order by the chip descending orderm and
+one at a time:
+
+- Locality 0 has the lowest priority.
+- Locality 5 has the highest priotiy.
+
+Further information on purpose and meaning of the localities can be found
+from section 3.2 of TCG PC Client Platform TPM Profile Specification.
-- 
2.40.1



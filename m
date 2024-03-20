Return-Path: <linux-kernel+bounces-108652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F469880E02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A5E283F46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771933BBDB;
	Wed, 20 Mar 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDzu7bX+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2113BB35;
	Wed, 20 Mar 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924966; cv=none; b=qpxnyAyD/C4aylWnwPZR8fEtcKttWMEDwTunLdqv7UpcjV0myUuYWpPb2hpODmkWEdYrL3OXiZHmyT/wMyJoDWAMg1m89TR0C+dnoQK/5IvhZXKr7kZAcBgR7AfrdAWVe5oX3krz69cJIqh+kHCN0SkgOXT4ETNq0tqlLXdp0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924966; c=relaxed/simple;
	bh=LGyKYM8XcN8nBnrxBDrb0mYgitWNCQAUDnZ3X2WeWo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/kN/j2pNY5PYFjcIYqUTSmVTk9TnB//XlqkIHUvM1moNUk5T0dewB+VWom3VginEdYfb8ITV/Zdx13oihkPQFu+gZT53LCNocPvsfH6ZYy2gGKxi0gckArNZQ+FEQWh4l6JjuQ2lhXZcR5xNzcU9RFxiDBna6UGAHRKogw7SR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDzu7bX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61EBC433F1;
	Wed, 20 Mar 2024 08:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710924966;
	bh=LGyKYM8XcN8nBnrxBDrb0mYgitWNCQAUDnZ3X2WeWo8=;
	h=From:To:Cc:Subject:Date:From;
	b=LDzu7bX+x9PSrTH6Xd7JrdDYEcfYLME/QLFo1J+0xPMv1zNhFevPQCPqnFR9nv8p6
	 pYlxrN1Ua9lqNZOrbuqcybpYY+DZyMZ2QJM2eny/cWSGT0NCr8ch6Z/yeW8XZ926VK
	 e/iyuMLZyuy113N3ksFxYvrYulgE/baZWZNXi54QFIERh8b7I/LN4Fho2GZ4n0fsQv
	 7TI9FByBBJ5jo6k+SRty5qb9gQ6cdYZ3LcJM2wWlT5jps1tzc6uu12swfzlwIm9atN
	 m54GlPIVXAJEh4iFU0V9uZ4aZee8AUBymlPH44qBB5mKnqAOAg6YT/z9/8fK22sQ0x
	 PVQ2dDa7BgSiQ==
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
Subject: [PATCH v2] Documentation: tpm_tis
Date: Wed, 20 Mar 2024 10:56:01 +0200
Message-ID: <20240320085601.40450-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.44.0
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
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
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
index 000000000000..b331813b3c45
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
+Communication is based on a 5 KiB buffer shared by the TPM chip through a
+hardware bus or memory map, depending on the physical wiring. The buffer is
+further split into five equal-size buffers, which provide equivalent sets of
+registers for communication between the CPU and TPM. These communication
+endpoints are called localities in the TCG terminology.
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
2.44.0



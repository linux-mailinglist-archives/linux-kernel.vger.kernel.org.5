Return-Path: <linux-kernel+bounces-111426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D952886C34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E343B24D44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB444C97;
	Fri, 22 Mar 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/P+vTaH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590322F844;
	Fri, 22 Mar 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110950; cv=none; b=GBP633D0mUZBXJU15Rmcqqhx/W2pjsmbXvAv0HZGaztR27kFnDhBXzmDfrIuCNFIuhWoSk/5ZT+Cq5wiroukp3q6gmcAf7gX3xWXHWPeb5tiVpd+gid3H8FAAc7RyjSFkFNwdDXQeDcll6lkW9kILu2xjkaSbLihLVSFoN1tDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110950; c=relaxed/simple;
	bh=DIU/riHW7d/Q828EtRoJMXqE8kp8ZnSjYwedK5XPRbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7C3pUp6GAb9CYmMtAcJX3YTiXoXZGay86lpN+DotnckeUPvFCOobBi56peNtzZK6xovrxfd8sK07z+M5KyI8cGQAsXSr6RF4gCm7DJ/pVAd9tncs98ynRovyFLyM6hx368SXdS7trCr1RZ4oN5BJ/ltgZjGmngm0evi5df0cCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/P+vTaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF17C433F1;
	Fri, 22 Mar 2024 12:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711110949;
	bh=DIU/riHW7d/Q828EtRoJMXqE8kp8ZnSjYwedK5XPRbA=;
	h=From:To:Cc:Subject:Date:From;
	b=u/P+vTaHBL1Qwg9rMUybG08tJuaCL6vcumDRR7PHiRZWZa0Ku+VsguA6Jz/oYwY/Y
	 qNNIoY2JogVZ1Ih34hgni6rT+X0sJF9I3IoX44804pCZ7LbSe3umt2A5+eqqmmLAiM
	 AUmjdLAmJGbLoBKHalDymv2gFjrcc/2aEUdPpgJpY2wEqv2Rq7FOxNtzSv0t8bS7cC
	 AncIoFdtkl1HZmLT46qeG+GrUD80IwC58ceIku1ALmyCFxfPw6P6JRGyzbAMvlCjWC
	 97XsAbbG1AQeTTAN6L4XZNUyXSmtZnEbDSZ33HwDvGBjmNtvCJ428TANpIUMF1rXwd
	 Z9ItmEWNNiCQQ==
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
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_))
Subject: [PATCH v4] Documentation: tpm_tis
Date: Fri, 22 Mar 2024 14:35:36 +0200
Message-ID: <20240322123542.24158-1-jarkko@kernel.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
- Extended the text to address some of Stefan's concerns with v2.
- Had to unfortunately remove Randy's reviewed-by because of this, given
  the amount of text added.
v3:
- Fixed incorrect buffer size:
  https://lore.kernel.org/linux-integrity/d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com/
v2:
- Fixed errors reported by Randy:
  https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
- Improved the text a bit to have a better presentation.
---
 Documentation/security/tpm/index.rst   |  1 +
 Documentation/security/tpm/tpm_tis.rst | 46 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
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
index 000000000000..b448ea3db71d
--- /dev/null
+++ b/Documentation/security/tpm/tpm_tis.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+TPM FIFO interface driver
+=========================
+
+TCG PTP Specification defines two interface types: FIFO and CRB. The former is
+based on sequenced read and write operations,  and the latter is based on a
+buffer containing the full command or response.
+
+FIFO (First-In-First-Out) interface is used by the tpm_tis_core dependent
+drivers. Originally Linux had only a driver called tpm_tis, which covered
+memory mapped (aka MMIO) interface but it was later on extended to cover other
+physical interfaces supported by the TCG standard.
+
+For legacy compliance the original MMIO driver is called tpm_tis and the
+framework for FIFO drivers is named as tpm_tis_core. The postfix "tis" in
+tpm_tis comes from the TPM Interface Specification, which is the hardware
+interface specification for TPM 1.x chips.
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
+
+References
+==========
+
+TCG PC Client Platform TPM Profile (PTP) Specification
+https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
-- 
2.43.0



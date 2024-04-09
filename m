Return-Path: <linux-kernel+bounces-137508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73289E30B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AF1F22664
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367C7157A41;
	Tue,  9 Apr 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0cBNmuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED54157489;
	Tue,  9 Apr 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689742; cv=none; b=Z4U7Wm1j52EvO0+vc9+Wflhumbf0t6f6lVgz5Lq4h2jLBpdbhwr7YZhnrgt9/fk9uLSXvEsQB5upgj+jcoBqics/aNlm/yRpvrrOBzQN/v94sP8NtdpHoU4ScRGhZ6F/LgTo2w9pNEF02nn9olBKFRCWWPPidvNsLmW0Kof+j5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689742; c=relaxed/simple;
	bh=UpK3Tp7MDdksNh8J95zsXrIo50ZqivfzGhiSPuSgXZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyiK/RCnOaYQsev/jw0ehTCWu08067hw0IScypDRsmrOyPTgh62WeJ0BTFNkz6d23XXC5GOgHItEI7tdM3D3lpIwP71O2ARlhZ2G9Eh6eO2gphvxW1YqxsGmd+cXANNbQfYB6eJcazSugD8vMIgD0p3Jlvoo+IW3DIhQGMEvqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0cBNmuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA36C433F1;
	Tue,  9 Apr 2024 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712689742;
	bh=UpK3Tp7MDdksNh8J95zsXrIo50ZqivfzGhiSPuSgXZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0cBNmuLTxP6dP/tIH6MPGNZ3Fhqp9BJNd5odIE3yWn5bi85AXykP9S+rHkzhm0LA
	 MHdCQH+5hzKe92GWYhOkfInwZnAmiblE9iskOW/jJSquIolRyvEcF0hJ5Qmk9+7QD3
	 QLH/71b2ojPVTuzw3XNzw4T57rBIL1gBcMV9fLk9QOMNucSuYwywItLMp6P5mZa9dm
	 9a/EYYtLYgOY75qScKKktePL1UsCMUDxXpUmdKI0nyiyiZdxLz+IuprRdGCeSMBTFn
	 YBTpT+yxzlUWhOUGf7uC4S8Ms/ZfdFNHXoM70cr/b0NW77tbH50dkiwOUgp8/UfNIU
	 tHjH3YqvUBGSw==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: tpm_tis
Date: Tue,  9 Apr 2024 22:08:47 +0300
Message-ID: <20240409190847.10869-3-jarkko@kernel.org>
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

Based recent discussions on LKML, provide preliminary bits of tpm_tis_core
dependent drivers. Includes only bare essentials but can be extended later
on case by case. This way some people may even want to read it later on.

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
2.44.0



Return-Path: <linux-kernel+bounces-28096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D182FA27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F80F1F26D30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21F2150984;
	Tue, 16 Jan 2024 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0n70SiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9B31734;
	Tue, 16 Jan 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435138; cv=none; b=umO1fVrQ4gTIXtzEc9PEaEBPDs1NdflVqwfaQhRLyYjMtT/EiDOhtR4a0q+vLwuKujUDkY4Mq0i31pzMcqR/AesWsnjgVVUTLGZwMn8xRNXkrm/03H9uQ0NkN3eL3M93ibQ6nidpMmgCTZdYUZW4gio6ocDoN8wzdx3rbUmGxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435138; c=relaxed/simple;
	bh=a5dEKGPNOq4Y2NwPLUimnMKCp1uLJMNVexXAOX3hkSE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=I+PU0m8Dk7ottnQhw6MjMh2hNgUFtF+HAg7/Qxp904qmSGe5fRLsxrt3IbaYKgLuRZipmOdn3L0wUOknqsXfv0QQwzRUOwMEleZBiwoBw/gP3oBgrJ8whHk7Gu3FNdky/csFrFChNK08OKrVCY7Bh+I+zc/+gpFsY1lJRGADyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0n70SiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861A8C433F1;
	Tue, 16 Jan 2024 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435137;
	bh=a5dEKGPNOq4Y2NwPLUimnMKCp1uLJMNVexXAOX3hkSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0n70SiNTUfp4krEMChUWI/F4GbI+j1ycyDWYvaeTK7HmZ+GVIEPWh0fqPgTRQwW7
	 YDtHWHD58dse/E7NzvMhjuZ0YZcg7vhutSctWP/wnNYDH4wiy/EF1FdKpS0fmZuhdx
	 Z1y41thBzo+FNCLyWsJ1AstebsKOPNRPnCxxZ/bgsSrlhbL0kQI57oG3tPN2sonXL/
	 IxSenqjnMQJzgtTKTGUzo3DqG2JYdrz2dFTeX/E6pshXb4MvnVgRCIJUa8q+Ic0pmO
	 72LgU2AQNp7+p7aKdW9A7Wy08Jbko2y4kDf9uZ/qG3xrtaeRlqwSsqy0mQ1v4hm4i5
	 Dwz4jYMPWom9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ching Huang <ching2048@areca.com.tw>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	xiangyang3@huawei.com,
	bhelgaas@google.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/47] scsi: arcmsr: Support new PCI device IDs 1883 and 1886
Date: Tue, 16 Jan 2024 14:57:12 -0500
Message-ID: <20240116195834.257313-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: ching Huang <ching2048@areca.com.tw>

[ Upstream commit 41c8a1a1e90fa4721f856bf3cf71211fd16d6434 ]

Add support for Areca RAID controllers with PCI device IDs 1883 and 1886.

Signed-off-by: ching Huang <ching2048@areca.com.tw>
Link: https://lore.kernel.org/r/7732e743eaad57681b1552eec9c6a86c76dbe459.camel@areca.com.tw
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/arcmsr/arcmsr.h     | 4 ++++
 drivers/scsi/arcmsr/arcmsr_hba.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 6ce57f031df5..3324114e6b06 100644
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -77,9 +77,13 @@ struct device_attribute;
 #ifndef PCI_DEVICE_ID_ARECA_1203
 #define PCI_DEVICE_ID_ARECA_1203	0x1203
 #endif
+#ifndef PCI_DEVICE_ID_ARECA_1883
+#define PCI_DEVICE_ID_ARECA_1883	0x1883
+#endif
 #ifndef PCI_DEVICE_ID_ARECA_1884
 #define PCI_DEVICE_ID_ARECA_1884	0x1884
 #endif
+#define PCI_DEVICE_ID_ARECA_1886_0	0x1886
 #define PCI_DEVICE_ID_ARECA_1886	0x188A
 #define	ARCMSR_HOURS			(1000 * 60 * 60 * 4)
 #define	ARCMSR_MINUTES			(1000 * 60 * 60)
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index ec1a834c922d..e33298b2d51c 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -214,8 +214,12 @@ static struct pci_device_id arcmsr_device_id_table[] = {
 		.driver_data = ACB_ADAPTER_TYPE_A},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1880),
 		.driver_data = ACB_ADAPTER_TYPE_C},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1883),
+		.driver_data = ACB_ADAPTER_TYPE_C},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1884),
 		.driver_data = ACB_ADAPTER_TYPE_E},
+	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886_0),
+		.driver_data = ACB_ADAPTER_TYPE_F},
 	{PCI_DEVICE(PCI_VENDOR_ID_ARECA, PCI_DEVICE_ID_ARECA_1886),
 		.driver_data = ACB_ADAPTER_TYPE_F},
 	{0, 0}, /* Terminating entry */
@@ -4710,9 +4714,11 @@ static const char *arcmsr_info(struct Scsi_Host *host)
 	case PCI_DEVICE_ID_ARECA_1680:
 	case PCI_DEVICE_ID_ARECA_1681:
 	case PCI_DEVICE_ID_ARECA_1880:
+	case PCI_DEVICE_ID_ARECA_1883:
 	case PCI_DEVICE_ID_ARECA_1884:
 		type = "SAS/SATA";
 		break;
+	case PCI_DEVICE_ID_ARECA_1886_0:
 	case PCI_DEVICE_ID_ARECA_1886:
 		type = "NVMe/SAS/SATA";
 		break;
-- 
2.43.0



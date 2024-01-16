Return-Path: <linux-kernel+bounces-27943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CF82F824
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFD91F27E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96A249E5;
	Tue, 16 Jan 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qefpkAEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA412BF0F;
	Tue, 16 Jan 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434632; cv=none; b=F5jwpw46WDni+x3gIi76hT9tYvFNJ48e9Ey23u+PUv1rIKRRkFGrX0oW6Y9w1XqIiHmaps0kS5YKpMN3vLloQTEbjJiazAmcZsWSfn5BsZmVjdt41ZvHdUIOWG0HCJP2+f+x/93q3m13bcgAgtaTdM9f6UKC72kpw78Vm/KyUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434632; c=relaxed/simple;
	bh=Erj+NcQupYPvXV2gptPgfjz+XiP+C/WCVLfnJv6LCzU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=d3eTOHFLp3uMk9tr41a+WvgkW6P0km/kW51ub7whm2/vNIpDwKZ+tFVGjLQ69Bh3dbOOHEhbb5GWUUMLx+hy2Czz/swtatUaHWHWLEkchmL1imWe3bz/COSBSl8L9R+wmloJQtXNSqYC7Ovt0nr8iEpUZIxtD6KuDbzbduNrN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qefpkAEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C0C433C7;
	Tue, 16 Jan 2024 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434631;
	bh=Erj+NcQupYPvXV2gptPgfjz+XiP+C/WCVLfnJv6LCzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qefpkAEHU8JVBdnJsCmIFpGiUK1P0+Am8RsdLxOX61aTfLp+hr06gL9mOKxq0K6lW
	 YeQ042x9Pqc4Xp2RlPaBIXJext/Pk9TLCJUBbHXlSQxcAzsifZSuGY7AuIpBRKWBHG
	 fdaK0mU21YEWWyLv+P6uSW2mLMeollpbEnBz4Sakvlc3OhDKtf6Qe4kx1eMsM5E4qE
	 0lJPCroZG9Qd90fAaJeb780ePDgCtOB4B2RofgTxIERPGwn/Vrf15mLsfvnozPj3Y5
	 6ffFX3evvtgRhXqp58w0wfRDFi11Fsg3f128Qt6iPf3DhDtYqwQ1cxwAv3xCedzQj7
	 9FSQN6Ggd9hzQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 035/104] bnxt_en: Add 5760X (P7) PCI IDs
Date: Tue, 16 Jan 2024 14:46:01 -0500
Message-ID: <20240116194908.253437-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 2012a6abc87657c6c8171bb5ff13dd9bafb241bf ]

Now with basic support for the new chip family, add the PCI IDs of the
new devices.

Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231201223924.26955-16-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f811d59fd71f..722cafed0dd7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -121,6 +121,10 @@ static const struct {
 	[BCM57508] = { "Broadcom BCM57508 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb Ethernet" },
 	[BCM57504] = { "Broadcom BCM57504 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb Ethernet" },
 	[BCM57502] = { "Broadcom BCM57502 NetXtreme-E 10Gb/25Gb/50Gb Ethernet" },
+	[BCM57608] = { "Broadcom BCM57608 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb/400Gb Ethernet" },
+	[BCM57604] = { "Broadcom BCM57604 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb Ethernet" },
+	[BCM57602] = { "Broadcom BCM57602 NetXtreme-E 10Gb/25Gb/50Gb/100Gb Ethernet" },
+	[BCM57601] = { "Broadcom BCM57601 NetXtreme-E 10Gb/25Gb/50Gb/100Gb/200Gb/400Gb Ethernet" },
 	[BCM57508_NPAR] = { "Broadcom BCM57508 NetXtreme-E Ethernet Partition" },
 	[BCM57504_NPAR] = { "Broadcom BCM57504 NetXtreme-E Ethernet Partition" },
 	[BCM57502_NPAR] = { "Broadcom BCM57502 NetXtreme-E Ethernet Partition" },
@@ -175,6 +179,10 @@ static const struct pci_device_id bnxt_pci_tbl[] = {
 	{ PCI_VDEVICE(BROADCOM, 0x1750), .driver_data = BCM57508 },
 	{ PCI_VDEVICE(BROADCOM, 0x1751), .driver_data = BCM57504 },
 	{ PCI_VDEVICE(BROADCOM, 0x1752), .driver_data = BCM57502 },
+	{ PCI_VDEVICE(BROADCOM, 0x1760), .driver_data = BCM57608 },
+	{ PCI_VDEVICE(BROADCOM, 0x1761), .driver_data = BCM57604 },
+	{ PCI_VDEVICE(BROADCOM, 0x1762), .driver_data = BCM57602 },
+	{ PCI_VDEVICE(BROADCOM, 0x1763), .driver_data = BCM57601 },
 	{ PCI_VDEVICE(BROADCOM, 0x1800), .driver_data = BCM57502_NPAR },
 	{ PCI_VDEVICE(BROADCOM, 0x1801), .driver_data = BCM57504_NPAR },
 	{ PCI_VDEVICE(BROADCOM, 0x1802), .driver_data = BCM57508_NPAR },
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0116f67593e3..259e78033e72 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1696,6 +1696,10 @@ enum board_idx {
 	BCM57508_NPAR,
 	BCM57504_NPAR,
 	BCM57502_NPAR,
+	BCM57608,
+	BCM57604,
+	BCM57602,
+	BCM57601,
 	BCM58802,
 	BCM58804,
 	BCM58808,
-- 
2.43.0



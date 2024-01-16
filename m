Return-Path: <linux-kernel+bounces-28037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DA282F968
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9FA1F26F02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B02D605;
	Tue, 16 Jan 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEKlK1as"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFA1420B5;
	Tue, 16 Jan 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434957; cv=none; b=JIk+Klyhb7lczBzq3HwwzEneuPsX1F7ijfQQWGNwmfudw1rk6L0+Qkk3AQ53Cv12xnU1UBGVKBrmOSSA6vvy8vgIRqz8QShXxrWIhD24RAMGFhuFZljH18nPSAE5d7btOCRvN2CpDVCNX3LjUsxaq1S60pvaomopgq4z65Od+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434957; c=relaxed/simple;
	bh=2RXEokfNRXpXQhkgrp6ngX7HyIcxybH5QKePibPX4c0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=p7SsvEb3c2ZiuFWQBiynUOxyh93k1eAaaKMxqx/aP8oxO+0eaha066l4uYXaAKKHMM/JfRnTcwmWtp2142y80R/LPKJ8HBVv5PN4ejn2WQbgrNNks0BAiWud2HtPSmyyNbMK/WlZuKe92hZpO+cYqvCSXFtd2HtXNFQhj1sJRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEKlK1as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7731C433F1;
	Tue, 16 Jan 2024 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434956;
	bh=2RXEokfNRXpXQhkgrp6ngX7HyIcxybH5QKePibPX4c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEKlK1asKf4fI/UDy2bo8v2fsvkIOgUSTpyDf9pbgrbOF4FxO2U9xoOWVWe4aU4J/
	 J5g/CwuaHFhDkJSFTWwLL0ZSI/yPCPfKqdYNo1TzwCYXZ6QgIjWcfRrDI8QXXfIhay
	 MemotzrYy25INDpDFs+jpyovlDPHz/0GdMioU3qjVXz4iewfrd9k+3LcL29G1rHaH1
	 1OMv/2K17+B5zLS7+mnQ1IYGKpx5dobeLOJqn7SiBVyHjLofhNKLVa9MKvyG6XN7KO
	 Sz+Y6gQGcpD/TYf5yLQGfYKUKDAkreMuF4G+0Yx6GW3M5LTOCtyeqrEKIY9WiRo7bL
	 WGnjRX3YZ8LNw==
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
Subject: [PATCH AUTOSEL 6.1 20/68] bnxt_en: Add 5760X (P7) PCI IDs
Date: Tue, 16 Jan 2024 14:53:19 -0500
Message-ID: <20240116195511.255854-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 623cdeb29ed9..3ab465e3cccf 100644
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
index 111098b4b606..0b3d93ad1190 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1685,6 +1685,10 @@ enum board_idx {
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



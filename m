Return-Path: <linux-kernel+bounces-28079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A374A82F9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501E61F25FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2CE2E651;
	Tue, 16 Jan 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDW0uXlL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650E14C5B0;
	Tue, 16 Jan 2024 19:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435054; cv=none; b=TMYh2O6eh13nqHWl4Tw4QZpPLOQH0bhDdtEMX7NzX93pgH8IRnsiex8OgesldipuKiwnLPUBDVjXXuicfyICed3DMeRscm7O9uC4piLRYu5wBKBNuZv8/4m9XsaAl9tOWRHWyk10oW6EQS1DaEyiSey8zZY7QQ7mxK5JaIAjzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435054; c=relaxed/simple;
	bh=+se2qFPpWzEahE8QqWVQzfI3NLv5TzlfAvQtlA8+bI4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=d9rC5GtGGPYaBKeiR5jOusBg3Ve+PzsSwhGTllveWTkKKJyLuoUBAo4htzyC6N9y0pRh/5nCCNVamMt7rXwhqRv98bZssaUHGDwXIzV2WDUFqWIlxrhnxzx2n5tsUs/oMDJXrAFWVTdusChrotCUnnrxXSh04gqkyKcps1OCy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDW0uXlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991CAC433F1;
	Tue, 16 Jan 2024 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435053;
	bh=+se2qFPpWzEahE8QqWVQzfI3NLv5TzlfAvQtlA8+bI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDW0uXlLwZSs26z8+Doy9W91TLnZDWTSlDRlFeWjA0rJTOyqvhZtHv4coVy6Hu8BE
	 yjvHTqgQf+hygPnBbetENOUa8N1fsxM64HCzDxInpruViwzshMcRLcBUTo8S12gz0D
	 GCgRT3lsC0030Uxt+zLmvorAmyfzCMJQuUGKtZ98wPvHBNFzgYAmdb8E5HMyjrLikP
	 sktc0rgzC2TapsN9oBGjog6Oit/NEg2F8tGhQ4bnSBeu9syGc0+Wv1f6ztxfWfWth2
	 lpVi2kvkhOIrRR05q+MMK5c+V0+0xLYBn8CFBHPMjxlQXK/IOOG9BcnzIdXjbaSApD
	 RcQWPCf7snBRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 61/68] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date: Tue, 16 Jan 2024 14:54:00 -0500
Message-ID: <20240116195511.255854-61-sashal@kernel.org>
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 5d192b697c7417254cdd9edc3d5e9e0364eb9045 ]

Set both WIDEBAND_SPEECH_SUPPORTED and VALID_LE_STATES quirks
for QCA2066.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 45dffd2cbc71..76ceb8a0183d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1861,6 +1861,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 = {
-- 
2.43.0



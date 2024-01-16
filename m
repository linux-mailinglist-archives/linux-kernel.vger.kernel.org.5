Return-Path: <linux-kernel+bounces-28178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C085682FB35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E281C24CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E665EB0;
	Tue, 16 Jan 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHpiuzGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98765E9E;
	Tue, 16 Jan 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435354; cv=none; b=UYE52NLNy8xe7aFxj1py9+AcOrCI808dGzzlgRHamokuf8CUI7h0drniYAa1S4ZQpMAAll6o/0eJy5UdhhjQzQFXR5HITiOpXfkhghYi8rTNgSmVbMAVgXCwwf6KkrghWhwZpIZ6jZf21tlDnR4CxDAOlqRHhXNR3t5D3pYPoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435354; c=relaxed/simple;
	bh=tHoOUnA/HTfRQb9HIyYTvvU4Mlhb1o7Tvskc+7cJVHQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=RIJlmLIy66SrwgtYgsn7812+MQzVeV4SeU83mBG1dUz0mKDetU0z6RTXYDnfRo5qjOOWQlAvgHrNvO08QVP7qYfw2gLi9Au0YuQHMH5clSzsAdC7PXSt2BnxkchPSx60KAlReW2DY3kQWuwYStnz3ADHYbNzOmdU6iur/U7V/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHpiuzGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E66C433B2;
	Tue, 16 Jan 2024 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435354;
	bh=tHoOUnA/HTfRQb9HIyYTvvU4Mlhb1o7Tvskc+7cJVHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHpiuzGDWQ/JVne9VIYO/chCEifxq/NKWT+LWyNE3ys9HJvxfX6hwvGyp+HgWYxKX
	 NLAl6e7W5BuFl2LWrSE8WsT6qm60JN9EETjlAjeuDIgxCnGaCgEdBcASRgIoeJCBgd
	 OYgMGrhNhcdhQVCbvmRs7MjowQ49BGsH9pGUU/k91A8wM9S82SW/7zzWP3ZMQ3D1q9
	 d8Mt8+ku2IMeRIY+fjKvxE7Cg1zGCPZZ5WJNV31Evzlc1rxhGfV3PnPElPslCGuZ21
	 Q48wwNxBFg7R951trq3DD04wJ86DV9/a6nfu9JB96FwE6O9T8CjU6Iv1y3vLv3wIVD
	 fZLdfacFYzmTw==
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
Subject: [PATCH AUTOSEL 5.10 42/44] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date: Tue, 16 Jan 2024 15:00:11 -0500
Message-ID: <20240116200044.258335-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index bc0850d3f7d2..6e0c0762fbab 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1814,6 +1814,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static void qca_power_shutdown(struct hci_uart *hu)
-- 
2.43.0



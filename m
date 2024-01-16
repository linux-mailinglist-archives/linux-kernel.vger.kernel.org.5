Return-Path: <linux-kernel+bounces-28131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951182FA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A10A28C026
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D863D1E;
	Tue, 16 Jan 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq6DJF3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64463D04;
	Tue, 16 Jan 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435204; cv=none; b=MHxLPnDznEIyfigC6ciJBrWGjQOd1RdxSJBdcyu0cdvd4le0YJKGIDgStI3bjgmdpbm4QinIQzraoPAMrsQc40obvaunGyNDs05J+rZSbnzlTKGJSCgPTs++/C0IqWfr8u9UQYRa2QRTz8P79nMT2h6VlfIAkNJLOlaV0ClpV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435204; c=relaxed/simple;
	bh=MpznTvwDkyPP+7Tbv8iUk2G+t1bodrh/Bm0p+mFWhkw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=QfQsQBwtFJ5s9fR6ag4rBviIHpRNpa40rIO8ixau6Js2jk6QHS7l//5iy2Ai4pkf7ipjiSGROSLUSNsUWLJLtkC2SoYwvQ4kyDkEbUp9+wdsa7046oTQtYc7+2W2arQUZ7z/BOiLCQf5kJUs9Con/Bup6qD8ftxiWvAdztmMhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq6DJF3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A1C433F1;
	Tue, 16 Jan 2024 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435204;
	bh=MpznTvwDkyPP+7Tbv8iUk2G+t1bodrh/Bm0p+mFWhkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sq6DJF3RF9KCS/qu4fQOvupuZD2Q/BY7lK/w3RKUxUoeCUUwyy12WVvTU0nKwCEDt
	 nwcigMtsv3DALjIzuLD768JwIMuvn+qVeeRwxiNHp1lrdU5KfhW/H+GiJLhUR+pzm7
	 DH0+OCpMDLY7P3diXaVZPAobO1qGgc9jZyulp34b7fQviWX+yXpYnqFrSOQr4V+2Zp
	 qoXQyhFRAMNyL81gVUB8vHAUZSwqGH2L0vMV/U3NKKrXgX+jodfp4FZJqYaEnqp4eg
	 fZm2+3yp2aL49HgKKEbGrlQZxtUiccfFRJXVH1hk+OO1SpUJTFbmrzbM5NDJ4Fe2Yq
	 t0eX8EzNrrQAQ==
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
Subject: [PATCH AUTOSEL 5.15 43/47] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date: Tue, 16 Jan 2024 14:57:46 -0500
Message-ID: <20240116195834.257313-43-sashal@kernel.org>
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
index 56b4b7248483..d10f1fe0f5fa 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1860,6 +1860,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 = {
 static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 = {
-- 
2.43.0



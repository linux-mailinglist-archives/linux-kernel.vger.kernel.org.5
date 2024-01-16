Return-Path: <linux-kernel+bounces-28005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51182F8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCF4289E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1B28DDD;
	Tue, 16 Jan 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1oY94+v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1220F13C4E1;
	Tue, 16 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434822; cv=none; b=Q8Eo5/1fHrAV1/GzALJXBw6ltvsIRf0jK0F7ICQOyGOulgSyi+YGx2kKbZeg7mJ8TnYJN6dXQ6B6k3VkCf94kKsA35PvVGNtH1C89ATfV9JaciwJKEYJyvOgMqPjDeK3NkKEaGYpd20lc8qwADNcw1OykmFoM0Xycoy2gsbHHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434822; c=relaxed/simple;
	bh=GlkJ2Yp5VIUBnnwnMYgOohmSkjhzxHB8tWe343Vs9yY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Dp9hq0KR5XHlJ2RGU3DGr8+vsm9/38nAbESQffdN71jFyXiQYWmRi9acfCKzTo/XgJ6Ug/xfR1/OG+ud3+dbFhfRA7DpnyPYyw/m7HVwp0k7SEG4yDcAiOxZfYVCShjaE9AL+6g9P+dpBw1vwzglVi3+9I6210KFr7H+goGo4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1oY94+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D27C433F1;
	Tue, 16 Jan 2024 19:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434821;
	bh=GlkJ2Yp5VIUBnnwnMYgOohmSkjhzxHB8tWe343Vs9yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1oY94+vxI4RPE4kQY9DBd9x1WjmsxvlLRRxZrWjf9uMGU7J+piv5TMyDL0PGMNSf
	 WCsvLKIS8sQRLvhE+PN03vNfr07WrvbFsuBZuR0rXtqB2fjvy0CsxEdgu3ws4OKrHj
	 wFVLOongzFKRMmi5k5CilNaX7mzRRKbJRNC923LYk3qNPWVhWUxH75MzPkC7ZI4Z9i
	 TXRjLsCYMCYkc+xYqgSReFwA55IzhiSLKAHk+t539aU7W34r9ce65WYPfbykFf4PAQ
	 adcHd2F3Lqyz5xyXbd/GdaI3kp/6ZZ5dOv0yaCrFFnuOdr0ykVlM4N7y+KzfOIqgSl
	 KUJgbwxs6M3bg==
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
Subject: [PATCH AUTOSEL 6.6 093/104] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date: Tue, 16 Jan 2024 14:46:59 -0500
Message-ID: <20240116194908.253437-93-sashal@kernel.org>
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
index 4b57e15f9c7a..ad940027e4b5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2035,6 +2035,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
-- 
2.43.0



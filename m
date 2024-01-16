Return-Path: <linux-kernel+bounces-27868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C482F6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA661F2658B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08964AA8;
	Tue, 16 Jan 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QugY+xxw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858764A8A;
	Tue, 16 Jan 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434403; cv=none; b=ZOv2aFiYWUAWucxmH50WP7JLEkWnnb+Sl6RC7ly1yVx+JonkcCT0e7Vse1O+bYCkEsC/8SveDdztQ9MXOZ5f8ULQ+YhJFnAcgCX9ims7lbScS/lfTiV5S7Vu0k+MBLRLZxvnZG8MQcguDc+S46QkttDkmbd7hj3XEk8ehGOr560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434403; c=relaxed/simple;
	bh=Js9xP661sytzzDg+w+9PCz+Wc4f7lJG3dTxFfi+cwpA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=DLrQGGMaqGCTO7EG0RQF3pm8S12d+s5rCh+gwMaH2WaBZiCvQyrUn/mC6S8ufDufZxBdomSDHalE5H3Ej6LM414p7CVYIrg7u97+eSb0f3c0wrjqnmYNzs3CcB8CVuMNZJvuJzGu36aGKTkN9IC21OZl/NsIZXAgg6Rrtm+mVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QugY+xxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5BCC433A6;
	Tue, 16 Jan 2024 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434403;
	bh=Js9xP661sytzzDg+w+9PCz+Wc4f7lJG3dTxFfi+cwpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QugY+xxw29vbMgVckgGQKWmGIiDxxwKS9Uehnqof5mP2R0q5O8FiR1DiH99PTnGhI
	 CgTPNAwDhAm3KiAMPk/Yle9hmP9qs+scYojM2YhCG4ZHhho+EcwfaEFhc3iryesc1R
	 YqHNqNXbUp7VbfZcQxka3Q46YXM16KC5qTqCRB2HV0fDGFuHc2ol4fW+2rdQF4ppXa
	 /nQsIW6md7XX1nq1DOJV7iAO5gbwfiO+BZH8B37lE4JRMOASAWrgMC7q/o6kGFWI77
	 TtJijyMo8feJjlfJxZwxNQSGj1ieUbgJjjgOiNa4+xboZIHp0YDVALIX67plVWvDiH
	 Lv0z5xY+Wj+ew==
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
Subject: [PATCH AUTOSEL 6.7 096/108] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
Date: Tue, 16 Jan 2024 14:40:02 -0500
Message-ID: <20240116194225.250921-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 067e248e3599..35f74f209d1f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2039,6 +2039,7 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 	.soc_type = QCA_QCA2066,
 	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
-- 
2.43.0



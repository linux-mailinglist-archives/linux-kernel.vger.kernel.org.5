Return-Path: <linux-kernel+bounces-111521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1368886D42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D2F1F29729
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51863132;
	Fri, 22 Mar 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gu6ckw/j"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3B62178
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114038; cv=none; b=tLsCJM8TGhbskpFsTYNMdn7pRGM6E5g9PKU9lY7pMFNw1KIegqu8k/IjzvpuTCDycEo55QOEqxTrRv6FUBLr9kvNj7CNubXVXW2XyTIgw0EhPtA5WHHHu9oIQUtUnowemgVCvhK00nnlPrfrQIJchSOeNqQD9w3E1hHfVm3Myho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114038; c=relaxed/simple;
	bh=hrwddtOWhwwpqzStqurX6HURaRQDq+BjbBtzHhWU8Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0OHDuV7nRUssGGO37l2aR+/IpII1pPTuzDHKNhcI1htjf9PKuoSpTbtB3dIchVL839Yk+P4VnNYqIK3LprMEKqEKqwXPXqks6QVLKMxlJORHF/Zj6P2QR309YbOrsCrwMIr6XOZlsv9i/t8n/tQ9r18v23j0a+MmUCdO+5BsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gu6ckw/j; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=8yl6l8CkHfdh1vd7TC3m/0eTvcj1wzr11O3P2GhLYlk=; b=gu6ckw
	/j1sujDiqodFSTHjDoqOUHGPeCyL4rRf6TDUR15YE8Bx+n60+uvG/bVjzECbXKw3
	HgSWA7Rag2IveYUbgNN4x1hMtqMNfORBMSVXV+QwRjL9cmxhc8ARL/wzRkHhOgYt
	QsmoiscxE/zj8O6Hubzg9eKU+IUH1Co3t8/QYlMo3kNWK/ylwB0bLBmoGE3tuiZP
	z1xfxVdkvYAVEFt8Ans04dp9aFSgTNtPNnoJGO989x6DvkKeHCoZhRDyPrEsDc7s
	2zIg3bUAfdhrja5nm7Rebb8jKn9vmyx/tp+F0fmN/QNAR6qGct2bONNaSbnfS7qs
	d9I/d1ig8x+fj6rA==
Received: (qmail 3871579 invoked from network); 22 Mar 2024 14:26:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:57 +0100
X-UD-Smtp-Session: l3s3148p1@a9wuxz8UkLBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 44/64] i2c: qup: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:37 +0100
Message-ID: <20240322132619.6389-45-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-qup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 598102d16677..2aeb5c33a711 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -380,7 +380,7 @@ static int qup_i2c_poll_state_mask(struct qup_i2c_dev *qup,
 	u32 state;
 
 	/*
-	 * State transition takes 3 AHB clocks cycles + 3 I2C master clock
+	 * State transition takes 3 AHB clocks cycles + 3 I2C host clock
 	 * cycles. So retry once after a 1uS delay.
 	 */
 	do {
@@ -1607,12 +1607,12 @@ static u32 qup_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm qup_i2c_algo = {
-	.master_xfer	= qup_i2c_xfer,
+	.xfer	= qup_i2c_xfer,
 	.functionality	= qup_i2c_func,
 };
 
 static const struct i2c_algorithm qup_i2c_algo_v2 = {
-	.master_xfer	= qup_i2c_xfer_v2,
+	.xfer	= qup_i2c_xfer_v2,
 	.functionality	= qup_i2c_func,
 };
 
-- 
2.43.0



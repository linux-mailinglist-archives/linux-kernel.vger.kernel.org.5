Return-Path: <linux-kernel+bounces-132064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D79898F45
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E4C284D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1042135A5D;
	Thu,  4 Apr 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="jVIk+bqg"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368A12D76B;
	Thu,  4 Apr 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260473; cv=none; b=CCX/Wub4L69cqK1LWbilfnaw0kZxiHgZZ1ekmHkehaPRWSE574QmOMZ22m0h7YNulQmlnpeMJYIW7Gucy/pO2uPsjtDracKjKXl93sCB+PE7WS3/nkf2qXHH+TpLoCHi79FPUS35/8W6D2fW5I5R+UL52eiL6xIaLKQ84KKfd2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260473; c=relaxed/simple;
	bh=SZWlzQtfsdaW9PsjgdhUMriXlWvym2xNI6HSd5gWS70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrAAWdAuuy/wr3Mm7eJ92IEjdltwBF9Knpp8alpbdB+ZIdjqDdB+BQRRamFVuByIsDdTkkacS7I2NaYH3PbwdhX6xnzGSyf1NV83pYWdChwvMcwdYxY7lmRqmJc6xx/dIVjn/GiaEQ61avJ3i9BVHVE8AM9VybZbxBOdN6RwZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=jVIk+bqg; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAJ-003qnl-2I;
	Thu, 04 Apr 2024 21:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I/eqSp3fz2MEWBZ0DqXy54vMgWaFQ16ZM1W/UJkmTqE=; b=jVIk+bqg/A1ZHI26xH8GZwin+l
	nrjh9OkYcloRN3W4ESV2PMGJZju0oPXbrvu0oiyr3C0hueGIWjPJV20boGSlDlvtNiHchqzilE2jg
	k/mdwgqwBv8uFhIbJ+xPJNSxC/GxpaPIwc42HNLMzMo5XEp7+Ru11+eVfNQkhOSds8CtHIzZ4kaMS
	avDPg3N9QCZrdk8zCIJXtKWncfUUz8EJEPY+pWMcBnBGr8HfvjlXWoK7Nn3wj5uisrCIExcwtYZny
	H5APtCwTH46mUDWMMftxvQs0Mr0GVoS8wVj1f4DxvoKRYYuYvVhCG3ozmrNzf82VE3PZ7GKHtfI8V
	sSkH7thw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAI-000Nh1-2b;
	Thu, 04 Apr 2024 21:54:27 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rsTAI-002nNZ-2B;
	Thu, 04 Apr 2024 21:54:26 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/2] mfd: rohm-bd71828: Add software-compatible variant BD71879
Date: Thu,  4 Apr 2024 21:54:23 +0200
Message-Id: <20240404195423.666446-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404195423.666446-1-andreas@kemnade.info>
References: <20240404195423.666446-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the BD71879 PMIC which is software-compatible to the BD71828, so reuse
the same device_type enum.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd71828.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 4a1fa8a0d76a..f0b444690d4d 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -585,6 +585,10 @@ static const struct of_device_id bd71828_of_match[] = {
 	{
 		.compatible = "rohm,bd71828",
 		.data = (void *)ROHM_CHIP_TYPE_BD71828,
+	}, {
+		.compatible = "rohm,bd71879",
+		/* equivalent from a software point of view */
+		.data = (void *)ROHM_CHIP_TYPE_BD71828,
 	}, {
 		.compatible = "rohm,bd71815",
 		.data = (void *)ROHM_CHIP_TYPE_BD71815,
-- 
2.39.2



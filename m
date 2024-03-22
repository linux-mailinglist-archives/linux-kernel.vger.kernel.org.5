Return-Path: <linux-kernel+bounces-111519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8714886D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDA41C24BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136461671;
	Fri, 22 Mar 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Xo4CUIDO"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1230629E8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114035; cv=none; b=V2xlF2Mk8/vKnnCT/LUbW0/Vd3v/n/crbl4SLUugVSJgxGekw10Debv8Bi42TTM5DxJDgEAy952Uc4Abz4eyVCBOs7ZbAT6lOZCcmNxtevfPyJbgl5T2blF6pBG/6OSSY3ZlWYe+u0X4EGjptak0TsCyCKqAmnxMw/hu22eQzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114035; c=relaxed/simple;
	bh=4jU5UrYVuKboOqguTAQNiprTpycabJ/ha8XLQxZAE+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4lnVVO2uoJCU0zVuGBHCoi41O3D0hLwT/wZEzppFwfkoEoOdmcMgTEeMyAKkEK9uJvYudoNDUVDb/yZehzyBZmVpaSqfQkBTYS6vs7PWQ5TBINlrN4aFobb+wEJiMRvDMxOHCoSc3LKgTm+EumoD27xKA4O8OKQinvhcYhxKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Xo4CUIDO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=jtQWgUHLJBsBn4k0hPCfptVF721mjEvpbVebl9Y7Pm4=; b=Xo4CUI
	DO/VElG0PJ52AZRRwzu5LRWgKWRmpxFP5+3SXwccn2imURSgyH5j/tU0sIcPlFtT
	9Dl0ea5R7ailNpRYciMmqGWRTfvH8b2uLEZz6xgGyh7Y8m21cGp2QrRui1YF21XH
	yPpGIO6bs4bLeTr38ULKTylbR/ezyWIfl78sraHAzm73kXBF+tOjq73KMGIimX1P
	zRQBOewsfliIYYrEsF+PVBdkuDCjIvYUNfzkmwkfjhsqPVPKV2rXXk4PmP3dmnWN
	atUWGxwyqegBt/XYanPBIgEcmriwMg5xIHMeN1PrI4J2zsecVakgjvwZ7/60SuPI
	sCeEwLH6pgvvj2DA==
Received: (qmail 3871408 invoked from network); 22 Mar 2024 14:26:55 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:55 +0100
X-UD-Smtp-Session: l3s3148p1@uVQJxz8UerBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 41/64] i2c: piix4: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:34 +0100
Message-ID: <20240322132619.6389-42-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-piix4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 6a0392172b2f..1f6223b88146 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -589,7 +589,7 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 		result = -EIO;
 		dev_dbg(&piix4_adapter->dev, "Bus collision! SMBus may be "
 			"locked until next hard reset. (sorry!)\n");
-		/* Clock stops and slave is stuck in mid-transmission */
+		/* Clock stops and client is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
-- 
2.43.0



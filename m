Return-Path: <linux-kernel+bounces-111507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DAA886D20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5968E1F26FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E460DE4;
	Fri, 22 Mar 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NJwmyVON"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B560899
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114023; cv=none; b=CGKLLvqzp3w2HrMD1AN2TcamF59rxfL82t3XRph9f1fRc/rmW+ikNPAIieQmaKIxCUeJ18FqpIUGepTbM50eDhk6hC1lBOPbPqx+qDr397rSo2bBPJ3y1C1lobAr1bF91lWK7efELWXmqtODbzm8lTIp1WGnjyiC49OKZcwiEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114023; c=relaxed/simple;
	bh=q7JRzLfJ8eThPTGrFEoS5oDExGETXR2V5D9xqAe4mLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHkfgvPNh6mU4sSdZ75GLXIYrArX58SJnE4clJkH4Y2dHbaYzX/50xV2UhS5rFVvaAiEr/OyfbOOqhEB7h/mWDeYLfhUDplWMFhosjulL9n60pUPb3kC57WjXcbCmR5CLlLD1QB6g03Qy0Mq6vjCU7c4WLbHlaPzVGwTT4x3zIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NJwmyVON; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ItvkqPOxxoAxX6wP7vqtFYes8mnGS8tDMPsJtLe0c/I=; b=NJwmyV
	ONyXHx43Ket4ijy0PAu5NZ/Gq58i9u8de1ufZvKAFznoF4R/5fxqFMN8GLLxzlRH
	X6rQ9CzdCnO7pboqDfwxGWJ5a6Ah3b4bCyoJmAt75wWCCLFa6G5C09CdaNj//vFC
	MwpARqcLpkBenCPLCqii5Dz2jFmZGIEQPFfcmcqdAFf5YsrmFOO1APdhQqFKRtUr
	jYlnocSCLj7+HgcobbG1eeQLOuq3a4CzrcANVd4IzmNtI3J8aKWbH1/0IRx9bU9y
	iAI/DLoYVopoPnMvSgHgueinejOLizZNjpJpcdbjkOIXzlF2bza81/NGMymJvA3M
	pMdxdVg61oa+SxrA==
Received: (qmail 3870828 invoked from network); 22 Mar 2024 14:26:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:43 +0100
X-UD-Smtp-Session: l3s3148p1@kuNVxj8UwJRehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/64] i2c: iop3xx: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:20 +0100
Message-ID: <20240322132619.6389-28-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-iop3xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
index 2e5f0165c3d3..9973f7d83205 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -22,7 +22,7 @@
  * - Make it work with IXP46x chips
  * - Cleanup function names, coding style, etc
  *
- * - writing to slave address causes latchup on iop331.
+ * - writing to own client address causes latchup on iop331.
  *	fix: driver refuses to address self.
  */
 
@@ -234,7 +234,7 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 	int status;
 	int rc;
 
-	/* avoid writing to my slave address (hangs on 80331),
+	/* avoid writing to my client address (hangs on 80331),
 	 * forbidden in Intel developer manual
 	 */
 	if (msg->addr == MYSAR) {
@@ -350,10 +350,10 @@ iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg *pmsg)
 }
 
 /*
- * master_xfer() - main read/write entry
+ * xfer() - main read/write entry
  */
 static int
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
+iop3xx_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap = i2c_adap->algo_data;
@@ -384,7 +384,7 @@ iop3xx_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm iop3xx_i2c_algo = {
-	.master_xfer	= iop3xx_i2c_master_xfer,
+	.xfer	= iop3xx_i2c_xfer,
 	.functionality	= iop3xx_i2c_func,
 };
 
-- 
2.43.0



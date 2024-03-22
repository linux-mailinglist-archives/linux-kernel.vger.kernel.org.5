Return-Path: <linux-kernel+bounces-111514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C239886D30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DEF1F28357
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15335626AA;
	Fri, 22 Mar 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FgprhwLl"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932061680
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114030; cv=none; b=QQEZuD549UuLSdtXRVYD9qg2xEwCu8bohC7kDii5qj5k817DPsDj++55BdgZM9/S8wUY6OXRlc2OBI2SqKd8BWbgjD3WXCoeydU3gkOrk9zZ/vM4ZVrvs5f/NiIhofjuV0Ecfp/ArSNiss/6D8J/3LvV1k6MP85RVQ82QTegmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114030; c=relaxed/simple;
	bh=PaE14FgF8utjw+iOuMQaOI1ODl2G/f5apZi+i46cVdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIOqNMiRDEarJVgayHyb0C+yyiwCFxLpa1HIPG6Zn9YOhcI5xkL3fIAfbGYl7/dGwcTUhiAk8Vtq40a10gnz3fi4abFBmWB2mEJl/Aoni8RVgB+a4CFYDg+dHa8wRICB0o315J/U3BjYqCK+xJJeLBHXCTd47aiGzDOMheTGpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FgprhwLl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1r2o49i7iw+BKKFei4mEIEQYijZQXuvYnywkJfqsTjQ=; b=Fgprhw
	Llnp5iR3M6IPiI56wO8nJCI7jZd/zEbWlbLTVXlQRy+gGmcLyYL+fNvI/TinEqsv
	M5ZWaf2y8ehQ8skw+bJFc0sPlXZOQW2JNNJBSRCBZTDKb/mxj0c/7TSdFEULFfa+
	fGcZP1emXrPg4GRIhwYZ9ku4mjpVfi+EacxIc6wpQaCEs5hLSnLILkmowsTCVsoz
	mk5htHbmdauGJp43DeRm3yfvyBzWbt8wzSo7IUR6WWSUGMYOzQ6UHB/yd0eT0cqf
	3qhIETDK7LVEAKSN7dCrRelO4AnpnerlxuYfqEQmAnOFu3NDsEOGdvDk/c0b/HDq
	WkEuPqtaykzHvvaw==
Received: (qmail 3871212 invoked from network); 22 Mar 2024 14:26:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:51 +0100
X-UD-Smtp-Session: l3s3148p1@OKTIxj8USLBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 36/64] i2c: mpc: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:29 +0100
Message-ID: <20240322132619.6389-37-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-mpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 8d73c0f405ed..135889fdb43e 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -115,7 +115,7 @@ static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 	writeb(x, i2c->base + MPC_I2C_CR);
 }
 
-/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
+/* Sometimes 9th clock pulse isn't generated, and client doesn't release
  * the bus, because it wants to send ACK.
  * Following sequence of enabling/disabling and sending start/stop generates
  * the 9 pulses, each with a START then ending with STOP, so it's all OK.
@@ -762,7 +762,7 @@ static int fsl_i2c_bus_recovery(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm mpc_algo = {
-	.master_xfer = mpc_xfer,
+	.xfer = mpc_xfer,
 	.functionality = mpc_functionality,
 };
 
-- 
2.43.0



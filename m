Return-Path: <linux-kernel+bounces-111541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315BE886D72
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04042854FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF61769D1B;
	Fri, 22 Mar 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VT6kn430"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDD67E75
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114057; cv=none; b=uPl0fABGEzUltrYP2TimCUEJXUwT1+IT7yTYM1aLydVyQydvOLO9cnqUGBdTv83/7gCVYlgR45B79axRDwB86Yfsd/9SGjneLqoR9T8zU+WR98wHTpeGxEwAeOOkO8Oyn8M+malBZQvlcUorj21J+98xHVLTiVh19N4mnmK4YCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114057; c=relaxed/simple;
	bh=3SYrWo907vsAxN9nNRVA1UFj//np9nL10OQCf9WRfD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak6+hqPLkF0dRinmWsSfKxooiav/mLCK7qcZtDc98eGwabA8Gk4Z0L8E7wkTVR8cfaDSHLD2Sv4dku+SKNX5ESXNG74frl2rLVdX37d4tsm1Fw8DKYOz/9lWN7VBvS2umorp9uvbPaBbWzj+/QFfqYT3m5gqhEL47xZhnjSnouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VT6kn430; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Mc+kkfqmbWeBgun419lGDhT1G5v018HjE/DNf0WDLT4=; b=VT6kn4
	30eDKn9BBGnx/dKE4FI8SNsCOADo0k0+EWC0q1O+6IorhRyNVmvj+bnsHP9srqtd
	5pxcsYrm0XHcOsPX//JFQlehqHfsuY737It4lxyZhp+zqJuNCZwGwk41Rt01m1nh
	hEi6sOKKs8TZLVAOg5/k1GwO0561m0Zs2By/tpMOMqqDXIbaVvNS7V97dwib4uLP
	QjrouLjQsM3UT4BzHHii7DveB1wO78YtDw3y9k0QtpvDLhK5ZYAF/epXHw6lyojz
	K5XrhZv+dgEHTIXELsUc3Ur52VXqhk518n53mYiFsmrH6/k3ACEGs8ZD3VhvnSwm
	kfup9LQTjU7EAqwA==
Received: (qmail 3872340 invoked from network); 22 Mar 2024 14:27:13 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:27:13 +0100
X-UD-Smtp-Session: l3s3148p1@z3QeyD8UmoVehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 63/64] i2c: scx200_acb: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:56 +0100
Message-ID: <20240322132619.6389-64-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/scx200_acb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 3648382b885a..0d773210f9be 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -110,7 +110,7 @@ static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
 		goto error;
 	}
 	if (!(status & ACBST_MASTER)) {
-		errmsg = "not master";
+		errmsg = "not host";
 		goto error;
 	}
 	if (status & ACBST_NEGACK) {
@@ -251,7 +251,7 @@ static void scx200_acb_reset(struct scx200_acb_iface *iface)
 	outb(0x70, ACBCTL2);
 	/* Polling mode */
 	outb(0, ACBCTL1);
-	/* Disable slave address */
+	/* Disable target address */
 	outb(0, ACBADDR);
 	/* Enable the ACCESS.bus device */
 	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
-- 
2.43.0



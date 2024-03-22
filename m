Return-Path: <linux-kernel+bounces-111489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAF3886CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98616283542
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0907C524DD;
	Fri, 22 Mar 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ik6n/zO9"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135056B84
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114010; cv=none; b=ADy0CD7tNol4I6CzJgW4iqwxbbckTT8O9C3EOs/aEYzqJ1CdOKAUfFZsLOR83y3h4EMxGi7LTnzi16+bVZuKucSdncjIMbnL/meHwGNjKZvDV5zRXACAcGelG9CZ1lmXtESsVByB6wmi3zRt98xgalKFGk679CfvpTHOtdYHSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114010; c=relaxed/simple;
	bh=7oQmmJVaprR+HZKpfHw09qchZeoWx9o84q9t9JP0HQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9LRsKL9T1dR9+PpK4Nfndzs7Y5c9N/vIvzglHy3TEvSzaLphC+s5Ku8R8JN/ATBuH/2hd2HzCAudjd/Y0kQS2uZlCaRRQJh0FNdpBApv+OzpUtlr1+hwTVZJcHzgg8SDTFjpL07PxDuwGGnNQ07vBObXNqSXwhiBm36IfYu/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ik6n/zO9; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=fB9xqyjvQZDgbI6QWDiCYg5KgycLfSIzO8kZL2YkZsI=; b=ik6n/z
	O95g0ZW+iWO3WBHgcOmzS2H9kvlN7IDVaaa2QC5byEgoCPdTymwQsS0AJ9MN5tq+
	iy4akf9H9k60bZjtYqKtpuRZg9Mlw6vuRWdmNTcbQgziN49iAxahtNOMbzJdgBhA
	NnnZ2ygFhmSHG5T8/TDofAl4iQsIIjNjHSQmL3FG0xhEBR0M3VD5JLbBZutUF7pp
	pWXlyx1GIrjZMbCAct8Hu4IM0ZqZwKHnIHXCx0UuwH5JRZ992O+r94cYWinPgmPL
	+NVjaan4grpMgjfgKJ3pCu+wFSzsRSiSBzhDjvvstKeZmNHndzESvUbTomiHtyiN
	P97ewOqPWmMaKEAQ==
Received: (qmail 3870333 invoked from network); 22 Mar 2024 14:26:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:31 +0100
X-UD-Smtp-Session: l3s3148p1@bE6jxT8UquBehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/64] i2c: cp2615: reword according to newest specification
Date: Fri, 22 Mar 2024 14:25:06 +0100
Message-ID: <20240322132619.6389-14-wsa+renesas@sang-engineering.com>
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
 drivers/i2c/busses/i2c-cp2615.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index cf3747d87034..91fffc39afa9 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -60,7 +60,7 @@ enum cp2615_i2c_status {
 	CP2615_CFG_LOCKED = -6,
 	/* read_len or write_len out of range */
 	CP2615_INVALID_PARAM = -4,
-	/* I2C slave did not ACK in time */
+	/* I2C client did not ACK in time */
 	CP2615_TIMEOUT,
 	/* I2C bus busy */
 	CP2615_BUS_BUSY,
@@ -211,7 +211,7 @@ static int cp2615_check_iop(struct usb_interface *usbif)
 }
 
 static int
-cp2615_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+cp2615_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct usb_interface *usbif = adap->algo_data;
 	int i = 0, ret = 0;
@@ -250,7 +250,7 @@ cp2615_i2c_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm cp2615_i2c_algo = {
-	.master_xfer	= cp2615_i2c_master_xfer,
+	.xfer	= cp2615_i2c_xfer,
 	.functionality	= cp2615_i2c_func,
 };
 
-- 
2.43.0



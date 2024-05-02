Return-Path: <linux-kernel+bounces-166848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD78BA0D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2273284C18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7017A934;
	Thu,  2 May 2024 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Ky+hkpkk"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB2664DB;
	Thu,  2 May 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676310; cv=none; b=Dq2BAtAu2dF9B71J8D6OLxLIQAS7eIGo/h7WBhrpP56yjpusqmob5qeI55O+DIwnQP/M7qvrEynvmAZBs4cfPKa58PrtvsBHPUN5Ne4VO6u5CH+IQar4leB/oLyA6vDNx0Qx4Le5e2GS3J049DD1TBTBLinNUZe4tNBx7sKpDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676310; c=relaxed/simple;
	bh=aCHIniCv0Tc+PYxGKN7qCxfa+STcvQCfgUcxyDpVlqI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2JrB8fWn/0tGnLfzGXbc4qQL2FJQVSJxCiYckBJeOjiUOWCJ+L5K7M1uSTKSAUnbH4Opb5fSxvp913sHHkHs4ZEh+rfgDT8vQapBsjEqqQaXi429O6xc7A/qRLlTMuHIWTzqnb+nmj/Z1Ue8CpSpPlob0ZYx6IMjlQB0Wozjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Ky+hkpkk; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdQ-005SoT-15;
	Thu, 02 May 2024 20:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0CDwM9oX6z8Z0kLm8cR2Bq5GdQPw7AnnpcL4J7ndwOg=; b=Ky+hkpkk3z2PboFTrISt8+jlhm
	06uyU48sOjDH1samrFh8h7+jfflyqOIznBzV+sMpokvLvjS7oOwexMsfO2b6vMhv+l/HtfMunMQEe
	2kTJ8cPnVmYuE5ba++9ruIB7m8vrRSfAKXSpghihe2+V/MMW3/1FaY1BaurRgLY8JkOUVXj7QbQms
	8Jatu+s3xvyDi+HjWSNzcS9lkI2ByAsFbkZzNYB81O9wK2H8TKbTfSdRPH1YzO8HafUvj7OYO8T60
	JKLOjrJyGegyFd9ofxuzzsIEgSvcEu3f/gG0UsKMkyGKOzqugzdVt900EdeJSotZzMUORS6PuAuCz
	eXDIT25w==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdO-000RVZ-1U;
	Thu, 02 May 2024 20:58:23 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s2bdP-003JC1-1V;
	Thu, 02 May 2024 20:58:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andreas@kemnade.info,
	hdegoede@redhat.com,
	andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de,
	siebren.vroegindeweij@hotmail.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: ektf2127 - add ektf2232 support
Date: Thu,  2 May 2024 20:58:19 +0200
Message-Id: <20240502185819.788716-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502185819.788716-1-andreas@kemnade.info>
References: <20240502185819.788716-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip is similar, but has status bits at different positions,
so use the correct bits.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/touchscreen/ektf2127.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index cc3103b9cbfba..5c2a6bfc63d84 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -46,6 +46,7 @@ struct ektf2127_ts {
 	struct input_dev *input;
 	struct gpio_desc *power_gpios;
 	struct touchscreen_properties prop;
+	bool shifted_status;
 };
 
 static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
@@ -112,8 +113,13 @@ static void ektf2127_report2_contact(struct ektf2127_ts *ts, int slot,
 
 static void ektf2127_report2_event(struct ektf2127_ts *ts, const u8 *buf)
 {
-	ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 2));
-	ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 4));
+	if (ts->shifted_status) {
+		ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 1));
+		ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 2));
+	} else {
+		ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 2));
+		ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 4));
+	}
 
 	input_mt_sync_frame(ts->input);
 	input_sync(ts->input);
@@ -303,6 +309,10 @@ static int ektf2127_probe(struct i2c_client *client)
 		return error;
 
 	ts->input = input;
+	if (dev->of_node &&
+	    of_device_is_compatible(dev->of_node, "elan,ektf2232"))
+		ts->shifted_status = true;
+
 	input_set_drvdata(input, ts);
 
 	error = devm_request_threaded_irq(dev, client->irq,
@@ -329,6 +339,7 @@ static int ektf2127_probe(struct i2c_client *client)
 static const struct of_device_id ektf2127_of_match[] = {
 	{ .compatible = "elan,ektf2127" },
 	{ .compatible = "elan,ektf2132" },
+	{ .compatible = "elan,ektf2232" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ektf2127_of_match);
-- 
2.39.2



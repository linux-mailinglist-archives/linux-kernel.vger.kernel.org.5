Return-Path: <linux-kernel+bounces-139754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007398A0750
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818551F25223
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A513C8EC;
	Thu, 11 Apr 2024 04:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xmxb8fS6"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752813B7AA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811004; cv=none; b=UUxho4AmVKXioi/lwI4bJWPVGvVimHghUeBLgXfEM9hDjBbD7ytQr8J/RYgOP8xCUcsoujgle16LQUjAvKIDCjcQQJa0qM9rsydl1D8uwqP4fvZStiJxj+ATVRD0O/6LDdDHiVt8/Am3hDQTRL0JAOnRNxfV90Ya4JzpXX46sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811004; c=relaxed/simple;
	bh=qh1N6xxXbxoyVeqUNnk7R8GnYu19bjjRQ9vc+mtv88M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vxw3vqVNSI8Q7KVOadJznOdcWpOgiecsgnfbKxHe4v/9Y0C+6GYLsZ4ofEwaxnFlk7FIlxVW3ez36TW6lDEnGMl9qzUokeimFXqwFTqmA7ZWn3jRg/sItIfpZgSKYKIrIduq0OJMw9/yo4H8tK3WGYACwLIpFntT8xMAKX5txfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xmxb8fS6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516ab4b3251so8434720e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712811001; x=1713415801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DAgGIo5zGQJrhgWPTd7vjLm3kyMY5b0dhTHS4JYFN8=;
        b=xmxb8fS65/s4BOeZ6TQsiMY6MGRCmOEenJIn4yHBQzIHT7YrYReIr5+w1S4f/coXH8
         5iBZ3Kw+4iNa909rEqPxqMH7GwD4JHPxzaCiVn8NXhVwkiMrp7/dJXbOK2YdSny4l7e+
         zJGLch1gAD+g1TOdcdmvU0OZMmmBwMWg2W9kSsP3+HBPD8nKI7mt/9z5mlq5lv4XqHGd
         X8lVB3kYBhDNgcnwoEQfR03hkPwSJNZls9HQ//dBe7XP2f0Qccc+Fe3ZEJWoWXYKxTwf
         cxK5zWMPSZQeevTuqA9zTZA2plTCP7DFyoDT51GilPvN0uUHLOnwA95sLqj4rWhPeidK
         nT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712811001; x=1713415801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DAgGIo5zGQJrhgWPTd7vjLm3kyMY5b0dhTHS4JYFN8=;
        b=QkHoUTqDdXRjLMzr8VaRil/IswqP3br3E+quRW+sbIlIIY959OBP6SFI+YZSflPsoD
         lHybUgJgF45n8tk5iHSDlwzJc6oN3Ec1ur94q1OpN587/VUS2Z7mU55gpmcH8hhmFjjD
         i4Hnwp3XGWbo+pODQBRTHEQpdcT0hOlkswHir5JlnorVuwFj8BB39nqlWH3EEUNpBZpi
         F8LSvH4KnOeg40dEIgL5JivfDTAk8QfjTtHVXDxa8heR7qnPDwEvbD07Ki4dBr9tYsaj
         6gqps3NMVTmAVPSz3mcEu9qggyJZabgW27ZCWWXtei4zDWBtL7ak/maI80ZA/pcKAjzX
         3mtg==
X-Forwarded-Encrypted: i=1; AJvYcCXGLS61WflsP+Lmvdu643vV0S1AP5w7qhh0f6Xwjo8+4jMwHt0C+aIImmM1Xjk06mr/RCBYJ4vJ+de7Cvfyndia6nxFbtRYm6YNIDTB
X-Gm-Message-State: AOJu0YzXmYLRAug6h9vNnFS8WbBHMR2Oi+WK6zZLeU3IyLrYY4Dz+jtJ
	y2eswyW7pYtBkFc05xMZzJKNZpeEPIXQyksE/6HzbaJbPCKMSFeIxJQckPuNDHY=
X-Google-Smtp-Source: AGHT+IHpxgoE6ryp41Qq6i2wozrgrTFsBC6bA+PKRXj/vk1+J47DXHlckvZHjw+/8nR1hnh2N3E0aw==
X-Received: by 2002:ac2:4645:0:b0:516:d8ca:40a9 with SMTP id s5-20020ac24645000000b00516d8ca40a9mr3477934lfo.62.1712811001090;
        Wed, 10 Apr 2024 21:50:01 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b00a51eed4f0d7sm364899ejc.130.2024.04.10.21.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 21:50:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Apr 2024 07:49:54 +0300
Subject: [PATCH v2 2/5] usb: typec: ucsi: glink: move GPIO reading into
 connector_status callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-ucsi-orient-aware-v2-2-d4b1cb22a33f@linaro.org>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
In-Reply-To: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krishna Kurapati <quic_kriskura@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3245;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qh1N6xxXbxoyVeqUNnk7R8GnYu19bjjRQ9vc+mtv88M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmF2v1iUg9yoEuR3Se6lcpQLtve2t8p7w/ulopP
 OKjCNyy6N+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhdr9QAKCRCLPIo+Aiko
 1XeYB/0QAqEbcE+8+WLZOds7OkmX13QLXz2T3UpuLdHesZHk3IGjSlDGaTBjKXXz4ABc+CfM4lc
 khJK0mkFRQqsaBcLH42zGOKLBg1APPZuTOwPZmYPY9KlofcDQZ7/r4hUSdeL0CgqYTA0CUWKcAk
 EZcDN05hb85LsK6ESba3lUrondR/QYjLDOeFkRE0svNmmzBg6HxK7yK99Elsg2vgf6AhUM1k5x2
 dysr7mM6kkPURDYMo5CVF2meyo/FvpnxqwBG2KREfSeulcGATneIhQb7ht22dpPJoScNaKgObPf
 7H44dBzNUl1NOpeccZL+G8OG6t0AuxvksM31s/bvuxd5NEpy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

To simplify the platform code move Type-C orientation handling into the
connector_status callback. As it is called both during connector
registration and on connector change events, duplicated code from
pmic_glink_ucsi_register() can be dropped.

Also this moves operations that can sleep into a worker thread,
removing the only sleeping operation from pmic_glink_ucsi_notify().

Tested-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 48 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index b91d2d15d7d9..d21f8cd2fe35 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -187,10 +187,28 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 	return ret;
 }
 
+static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
+{
+	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
+	int orientation;
+
+	if (con->num >= PMIC_GLINK_MAX_PORTS ||
+	    !ucsi->port_orientation[con->num - 1])
+		return;
+
+	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
+	if (orientation >= 0) {
+		typec_switch_set(ucsi->port_switch[con->num - 1],
+				 orientation ? TYPEC_ORIENTATION_REVERSE
+				 : TYPEC_ORIENTATION_NORMAL);
+	}
+}
+
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read = pmic_glink_ucsi_read,
 	.sync_write = pmic_glink_ucsi_sync_write,
-	.async_write = pmic_glink_ucsi_async_write
+	.async_write = pmic_glink_ucsi_async_write,
+	.connector_status = pmic_glink_ucsi_connector_status,
 };
 
 static void pmic_glink_ucsi_read_ack(struct pmic_glink_ucsi *ucsi, const void *data, int len)
@@ -229,20 +247,8 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 	}
 
 	con_num = UCSI_CCI_CONNECTOR(cci);
-	if (con_num) {
-		if (con_num <= PMIC_GLINK_MAX_PORTS &&
-		    ucsi->port_orientation[con_num - 1]) {
-			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
-
-			if (orientation >= 0) {
-				typec_switch_set(ucsi->port_switch[con_num - 1],
-						 orientation ? TYPEC_ORIENTATION_REVERSE
-							     : TYPEC_ORIENTATION_NORMAL);
-			}
-		}
-
+	if (con_num)
 		ucsi_connector_change(ucsi->ucsi, con_num);
-	}
 
 	if (ucsi->sync_pending &&
 		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
@@ -253,20 +259,6 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
-	int orientation;
-	int i;
-
-	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
-		if (!ucsi->port_orientation[i])
-			continue;
-		orientation = gpiod_get_value(ucsi->port_orientation[i]);
-
-		if (orientation >= 0) {
-			typec_switch_set(ucsi->port_switch[i],
-					 orientation ? TYPEC_ORIENTATION_REVERSE
-					     : TYPEC_ORIENTATION_NORMAL);
-		}
-	}
 
 	ucsi_register(ucsi->ucsi);
 }

-- 
2.39.2



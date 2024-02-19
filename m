Return-Path: <linux-kernel+bounces-71918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB485AC81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F402869D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8153E3E;
	Mon, 19 Feb 2024 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="T8NQ3yc+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88B53E08;
	Mon, 19 Feb 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372329; cv=none; b=FV9XBgv+oHkmNLrmwAcPDbq+DAq/vkx3vjdKn4z0Sdo8mpIAOp+nyKGMtbwSTZMavZs48joG1VYoTw3jm2/rBSfVPukajNH0rYNHnjxU33B5CZuefKhptygJLTb2g6qRzeEkKfPo0pBysdPVAQLAmHIKiCfVUsE+yyazTHdVQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372329; c=relaxed/simple;
	bh=HqeFN1a60RYkYnDY4jJhWDcZaJ8M5Sxyx9pblPEcsYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HJaegirf/dA2zs0Gb67eD2cFDs+0Tcd3+fy+L7QmzoaoIRkpeyUmyBLj3flSQBr8yDjpwUBugaMKR5H3smR60pjjGsc6y9Sse9DiAs59Hgn6mTyjCnVppIwzhyyfajfbhV19bQfqguBydQkvxfKGo6wS9O+uOKwzk3076YOLnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=T8NQ3yc+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d91397bd22so39603615ad.0;
        Mon, 19 Feb 2024 11:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372327; x=1708977127;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttW5o89yIoI1Avfpk22kOQXaoKdWhmBZDIrq3m6qjWg=;
        b=SEX0tBIhhW+UPumrJq7LC5bAznRmEfrrF4HbYlYMdSHlxNH0Zlmc/oCqlifFqajhqy
         fJgQZIOe/V2YNoZAvGI/JoOrAx18hGPr7mh1/FvTZ9Irdxo6u7XFSsoXF5Ev139SA9KP
         FYQKF7wJEqV9kwRjRgcY1ocdccEO2DB+gU5k5MYPPBccX1OkNHz+LNLbHS2oy50mcLb5
         Rfx97tPr2lalVe+C13n3PZYFB7e3/o+dCRSvFKs6CKnul/5WsaGpUM3R/x/3VXKc133j
         nAw69K9/fOdjawLAd/XQXlxFyhNSZZv57Wr4G6zdEgqwdR7/u+tADaqnMx7cRNnsC3pb
         GAkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5SoW4RFI0vAe9fi82QfaHKNVpucAS6Q4XUDLCJOW0D0rwaKhvspKnPIinKNcT84kPsnZht2m1fPp8e5zqD6ikR9hGKXIEOUnnSZXy
X-Gm-Message-State: AOJu0YxgIcZTrJpxdTgyb5Cu80pwIlU7BujbRKfiEDy2Ip8nI4qtltKw
	tg/C8tCeRe8oDuHxDx55bRxG4sFrtvn9R4iN+Y0MMDZTHW2oq44N0F4vDxjJ98uXzQ==
X-Google-Smtp-Source: AGHT+IESS2wNnRI8cyLPolb4B9oTxGsGuurVPhwMhC8qvBCiFQjCsjb6RHvEgJS0zZZqQKmlimT3sg==
X-Received: by 2002:a17:902:db01:b0:1db:f952:eebf with SMTP id m1-20020a170902db0100b001dbf952eebfmr3325421plx.44.1708372327572;
        Mon, 19 Feb 2024 11:52:07 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b001d9ef7f4bfdsm4784224plc.164.2024.02.19.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:52:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ttW5o89yIoI1Avfpk22kOQXaoKdWhmBZDIrq3m6qjWg=;
	b=T8NQ3yc+akwwtQBuqH9UA5KlPgm+6DwGHsHJmGPUDUFYWzu2UsV1Yde2Wdm/oakB81VUwg
	xucpdwQG1a9cCccnvJo5VuGQ43tHhLwhN4a7aFqKZMyb63VSRW1Q8kVSnIjliKu6gEyZqy
	Te+ZQ03Qr+FDt4m6jZbUfEDykvOHKBRBgwUS4tM8Cbux3IodCekjnqzcR2r7kRZwntfAWq
	heQ/UTVwZ4yQTmdvyFEegTqmMyMvdpFegMWXuyzOxqv25yr7IQn00bEj/q6/Um38JmLVNp
	fgKZ80VwH05WfxGlayMZMveOonwNxPMxEh5RiOi82XTHzLBRBVM72/52G0pixw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:52:52 -0300
Subject: [PATCH] counter: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-counter-v1-1-24d0316ae815@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJOx02UC/x2MWwqAMAzAriL9dmCH76uIyKhVCzJlcyLI7u7wM
 5DkBc9O2EOfveD4Fi+HTYB5BrQZu7KSOTHoQpeFxk7NSSKeaGdjw6noCPZip8hghxU2dVsTpPh
 0vMjzj4cxxg9riBPXaAAAAA==
To: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=HqeFN1a60RYkYnDY4jJhWDcZaJ8M5Sxyx9pblPEcsYg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07GVrWg1wYV77zJtKAyCHbVbj2eU+jsczwz0i
 BRw9puj6LiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOxlQAKCRDJC4p8Y4ZY
 pp8/D/45HFy6TouNZFD2GxiHlxV6Qv7JV0/Cb79BgIuie6WbEi6aihGI6GNDPp87x0/cENkexNr
 N1d4XASQbHaDHZFz3880cn8eXPCQa0QNj/eije9F9fwhuEqJkbWUc8hbTDkpkRTW3QNlRCaDnWw
 yGcj4NTWLFCLDcI2bRk39fmV462XyL9WY+sBv6Nm7qyGnLK7ufjrBam7jSTgy56yoqaGH6AvqNi
 JZYlQIjrF8v2I8oStl9wO89kEdrSiE002YjLThWSOx1jrf2yc5OzqzccFtectPU0Ai7/J+wlMiG
 HKabZ01G+J6SQZD0CzRzos9Twizr4UPo4WlIW5swrBA4k5rE6WcZVUS9Xbd8Ghjxg2tCaDEs0FF
 DpW+ea1brHDgkWpAtpN8IsMTKu2jaw7JQBi664UWaN3DCaYdSbKkRMTuhgf8mb9cOnSs7tqjXBN
 p6tCnUwuaCNZibZgyHHE5W46r7cZdyyjBBZ+a8uVnGQ0BkoKejTNVSaGDjvDAcQXn6ZfA9HaAgr
 Cg2oR88XNd7/dk7W5em2s6Iiir6TdDkWb1QsJx3Jh2rqcxaTPJUy7jzTLK7USAC0WfRy/DfVWv4
 vfKs94+DHOQW2Aj6UZ3yu7lRAjDEl4djpupXbODADyjmEcJlbmDRHGQvWbuC3Za6NmOttF9d0/l
 CZzOg37vE+cwwXw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
counter_device_type variable to be a constant structure as well, placing it
into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/counter/counter-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 29df0985f2ba..893b4f0726d2 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -49,7 +49,7 @@ static void counter_device_release(struct device *dev)
 	kfree(container_of(counter, struct counter_device_allochelper, counter));
 }
 
-static struct device_type counter_device_type = {
+static const struct device_type counter_device_type = {
 	.name = "counter_device",
 	.release = counter_device_release,
 };

---
base-commit: b6dce0452a0276339392bc5eeb722370a466ba25
change-id: 20240219-device_cleanup-counter-ca191517686c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



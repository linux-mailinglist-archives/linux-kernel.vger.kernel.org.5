Return-Path: <linux-kernel+bounces-51861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5881184902D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1272A283270
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E982555F;
	Sun,  4 Feb 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Q0KFR0Q+"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD8250F8;
	Sun,  4 Feb 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076570; cv=none; b=g1fo7rxawq67c/iZmWOgvd1/OXF8a7MA+59gqrRveZnyrSn08TlFUdDpuTrlayiJDG7WGx1DALP+PSse9vPWJxLF9dXy4plt1LWhT+0h0A9UYaxpr/8e4tNrJsz2I1Oije49I29V0NbA7Fz49Txu8HKpo63mInxOjezeACppXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076570; c=relaxed/simple;
	bh=bSEtUm8bN+TyipvwF0npj5p02e8GpdyMYtxzssJwS1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=chySs/I/e7rK5D07JqSVhpSN6+1BGL+5xgIrFOvxV1vQ1Qif5qVuuYMKbpc5T1pQfsKuxATw5x52R26VgUUh4sacmej5CAilHXk34U7FH+OzjLAuKJVsCFqXU1tW2xHF2p4TmSqnj3GkK5re6EeRV3I+q9JhzJyRHVKQm+68/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Q0KFR0Q+ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29026523507so3094944a91.0;
        Sun, 04 Feb 2024 11:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076568; x=1707681368;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGUsNvd4PYKbli2LypFPvRIIr39Yk7M4UXOO8wgms5g=;
        b=TH5jraGWvK42iWqu4NlnQ61SqTE16GWSsqP3mbQf2kqXr3WE8xwE0V7Po6zUfrPmMs
         Q7L4y24XEci1jK8yE2vfc3DIetcNavpptDNmlEvAvQOA4jXAr9CcNGqc6hyWWeyh38mE
         HlDnGhUY5wYlVdqVNECggmfwuBolRgnuO4gGP07D95T+AVV0QdRU3gTmSvjkizp9f4Ks
         ZOZOeHsw689/GUCPxVFhXN8vNKwJE7AcotePyrvUkxXKNDxVmfBt9RsWnySwmzIWqBly
         eT+BebVeTL/oJnnRPbc35T73OAAJk1XhI7oWG85SM5YljmsqHX7UIZo0ipTHwlh0UUE4
         f5Fw==
X-Gm-Message-State: AOJu0YzYR4LTfrSBwFC+UiV8cExqw1cPkpI9gJT2l9zzr99yWfbc3Cge
	cCpi27cUqxLWfBOo+tVq9jLVnOzYUOPqgn2xLFJB3FCIxSCgIC4fhCJdInh1YVcXTw==
X-Google-Smtp-Source: AGHT+IGJtojgv40FETF3Pfp8sNZocmaMKbWfuIUknW6yNtaz1Zv8giWHKv4qJkx3zQX8a8g/5Wd1LQ==
X-Received: by 2002:a17:90a:31c8:b0:296:669d:bf74 with SMTP id j8-20020a17090a31c800b00296669dbf74mr4327882pjf.1.1707076567694;
        Sun, 04 Feb 2024 11:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWBJoyNhK0xn68r+hQsJsGlxrjEJWw+tPc8qe1LWbRuyrGrYvSShFdet7GF3TGtAQalM14eifWiHKDf/d5lmI7W4jLX4Mb3aflKOPXn66og3smU5fKHVpKxzUoCSekC5mnB/fU9m0WbIA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id em7-20020a17090b014700b00295f31c3109sm3959473pjb.0.2024.02.04.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:56:07 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707076566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGUsNvd4PYKbli2LypFPvRIIr39Yk7M4UXOO8wgms5g=;
	b=Q0KFR0Q+6IU9bGvm+xMkP3mSzOP3bqcNPZP3dkb5GRxR17YPLc+YRH1dZsNUZKzig+8H7m
	K1nvPOpqT/ziIWzk8cuG9XwKQJ4AMKQ8lfcirzJOiN/1LKxjWIQFAmqWhTqd8sIRQbxs6v
	1o3qLfI4LQ2DcT2vnV3+5PKghZ4nhgj3yvK5YhpWjVxdFnBWBzAbyYos+NuWrGbrrTM8NW
	tCowYaOomk5XZ9ZbKJ31xlJ+HRnENWsXojdz+Geo1WXixqTqCN+kpBtFUsosSpMxAkQehp
	+3kBSlay6BSbA+5I0Mhhim+DD+mo8Ca7kYOLB5g2RjmjlZUKr+tyNTTQrY0dWA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 16:56:34 -0300
Subject: [PATCH] input: gameport: make gameport_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-input-v1-1-74c2438801cf@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPHrv2UC/x3MQQqAIBBA0avIrBPUpKKrRETZVANh4mQE0d2Tl
 m/x/wOMkZChFQ9EvIjp8Bm6EOC20a8oac4Go4xVRlk5JR7cjqNPQZIP6ZR15Zwys23KSkPuQsS
 F7v/Z9e/7ARDWnzFjAAAA
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=bSEtUm8bN+TyipvwF0npj5p02e8GpdyMYtxzssJwS1E=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+v0az0jIoYyxRLbxhUIdVYA+NxtEuutbWBjQ
 LJj/vRMDKOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/r9AAKCRDJC4p8Y4ZY
 po09D/41Ife/+pectYaYdPS9SkBTq6b3eFgVz4ua8qgDfj0VRKLzr1bpuEvOg5F5loyLXIrW+Et
 tUvBtuiRde/O/FrizA/SvFqofAXe1goROBPAEWhHxoejR4uJaH+B4ozF/+ax4A5jJgNHcQ1RgzB
 oWeyE7FlIVJaxE5OR9poxHOsp3+UIVKyNuA3+jXokkR2QY6CBpmeUmR1XiGPU1qor4K5gswJWv9
 RO/gQC3iwYJWEBmnnGSHjtaDILzG7AJwdUP8snrhKFUvyX52JPGfEzsuPiFpr98lttfjOYPHjzQ
 zmOUxnvxZ5/HF1S2qVdzDaTXZnt62HP/uajDZ+wBwj+wqsiystW2LkIrrn021km59vw3N1hbdpV
 U5GCcVEXox0qYo/+l6v2OjYn4XfafvR7WTkvRyHzp+ASqfLvHk0K7Pk2/NBi7e7QVJdvgg4I6hE
 K12KGXnOh0d+1zbkaJewB5FrZ0VZSr7OhOCTlyNUNvK/dnghqyuc6g8t4DmjbPszFcTRnzkAsPL
 ycmuxOq7nyW9NsZIZsG3hl5vb/Mtz/3gqTeUKR6YDmnpzNuB8Auofh/obiNCmuwwaOTctSJrkrJ
 QiPg7BjyseN+l3LmHBDHOceK1fl9orZtwwrjw2MCPxAWEsWj2w1Xp9O1ptzMLAkAvlvkZTucDYt
 yYj3rvzzphRrJ2w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the gameport_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/input/gameport/gameport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 34f416a3ebcb..cfcc81c47b50 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -38,7 +38,7 @@ static DEFINE_MUTEX(gameport_mutex);
 
 static LIST_HEAD(gameport_list);
 
-static struct bus_type gameport_bus;
+static const struct bus_type gameport_bus;
 
 static void gameport_add_port(struct gameport *gameport);
 static void gameport_attach_driver(struct gameport_driver *drv);
@@ -813,7 +813,7 @@ static int gameport_bus_match(struct device *dev, struct device_driver *drv)
 	return !gameport_drv->ignore;
 }
 
-static struct bus_type gameport_bus = {
+static const struct bus_type gameport_bus = {
 	.name		= "gameport",
 	.dev_groups	= gameport_device_groups,
 	.drv_groups	= gameport_driver_groups,

---
base-commit: 7d0f351da46098b3bbb147f886f059473b84ff48
change-id: 20240204-bus_cleanup-input-76cc02d48361

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



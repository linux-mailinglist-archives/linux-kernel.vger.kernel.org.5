Return-Path: <linux-kernel+bounces-41974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AFE83FA2E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255211C21FBD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A233C482;
	Sun, 28 Jan 2024 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRVgGKnd"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD873C46B;
	Sun, 28 Jan 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478585; cv=none; b=YD1tSK4F0wqZpfJClmCmTe7g+lxxw9a9Hl6P7KR44+xpsLG6eGDhqYaZ9IMWe9D8Y9xKk4ODzkpHZfsnsBsi9xpBEAj8hISvSG2ZGmHQc7Gdj2KrACDFObWJFOFIUpccw8S0MCeymIE8iHDXsDVmah6knIUipL+Dnl8m/0XbaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478585; c=relaxed/simple;
	bh=5XSwR5d0CYyIYkRItflEyY+5Xx4c+VbuswIhthiINY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRGoH0asEWgXzbCt1SUnTv1JxuWC8RCDLrOc2mrnwwZdoOLW3uukoRSOm5g1mXfbErVqREP5ZH72RgPp4LOhkTLEmr0tVCEM/ZN9bJ10VHT8pmFuB18sQQyUZT1MmoqBYmInNI2OgDJ74WAxFXwJNmjPFEa7YOvQFam4l6icrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRVgGKnd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3122b70439so279480666b.3;
        Sun, 28 Jan 2024 13:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706478581; x=1707083381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fG11WzG3UkhubdzI3pqjFW/7tCcUOSmi9kh2Qgw4z3w=;
        b=HRVgGKnd8gRVetmOKjjoBkauLLrDu8miJwcNfnEIahHLh/L1Sjk0SQyIvHkBR6tH35
         PuaRBKXgzRnMbhTer49Soej/PHNYVOi8ZcPxPG15eMp7ShDFnzKiTcJk6nGvtGsou8AB
         gDFD2nVcA40y3afrfTrAmbKmLcuRiX77q3Pyjox4xUHH8lcTXOClBGipWkwT8zjnDbgO
         AFTGxbK0DGfk4/K8/iy2yfuUHehhLUpYOlsB2tZ3CxmYX1K8A2t6k9YfbYJTILNXe21X
         V30NL0IgkWzqcE9EitJ/6seI3dvPRTlNLRHsNQxDUAQKqGvKzK3tLoCieCZWMHOiiivq
         bTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706478581; x=1707083381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG11WzG3UkhubdzI3pqjFW/7tCcUOSmi9kh2Qgw4z3w=;
        b=rCu1BJOxhMmK0GrFPi/hgbs2suSGXmNuQsJm8v3IPQgimRkXOKTixUbUF0z9axuNnc
         8dH4uYCzOWZf2PiBFf/1k27vmE+3+Y0cilHIgt57pn2BnISN6B7A262jrwsBi5fkkwvS
         Ed+UH3afJ7LZae9n2Ira4Ayl1ApTVFNHyQWYpkfXOofVm3mHjY57IEUzr760cFovX3uY
         LHuFJ5BzRqgcWiewQ1rpgD3Eu/l2a/j1RgJy1ued/A+Gf/n+i8aNrw+4/0jTMCST7mVA
         /Wc6SvKqygvN3YelqwxbCym8IPDVpfo+cciELjFnEA0yco+KnO49JI/azYkz/x96dodW
         eoHw==
X-Gm-Message-State: AOJu0Yychy9Te1mmdsvJbMmGxTN/tqwXnYav7A6VhraVZIhGX0nuklBt
	FJZQJjY1zpiWtU7gK+VqLGgfdeueA6GEtdrQVhntMUetjQl03BHB
X-Google-Smtp-Source: AGHT+IGcNTYSIze+l91AGzS0Y/tA1QCu1G5Y6lfss+bT6MNsdGY9j6HyfMjQa2+BGmW/qsy8JZjVGQ==
X-Received: by 2002:a17:906:dfca:b0:a35:9e9c:5dab with SMTP id jt10-20020a170906dfca00b00a359e9c5dabmr1249205ejc.54.1706478581427;
        Sun, 28 Jan 2024 13:49:41 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id th8-20020a1709078e0800b00a3539ca2f72sm2161545ejc.156.2024.01.28.13.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:49:41 -0800 (PST)
From: Yaraslau Furman <yaro330@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: yaro330@gmail.com,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: logitech-dj: allow mice to use all types of reports
Date: Sun, 28 Jan 2024 23:49:06 +0200
Message-ID: <20240128214906.60606-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You can bind whatever action you want to the mouse's reprogrammable
buttons using Windows application. Allow Linux to receive those keycodes.

Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index e6a8b6d8eab7..5730be1aa41c 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -948,11 +948,12 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 				HIDPP_DEVICE_TYPE_MASK;
 	workitem->quad_id_msb = hidpp_report->params[HIDPP_PARAM_EQUAD_MSB];
 	workitem->quad_id_lsb = hidpp_report->params[HIDPP_PARAM_EQUAD_LSB];
+	workitem->reports_supported |= STD_KEYBOARD | MULTIMEDIA |
+				POWER_KEYS | MEDIA_CENTER |
+				HIDPP;
+
 	switch (workitem->device_type) {
 	case REPORT_TYPE_KEYBOARD:
-		workitem->reports_supported |= STD_KEYBOARD | MULTIMEDIA |
-					       POWER_KEYS | MEDIA_CENTER |
-					       HIDPP;
 		id = (workitem->quad_id_msb << 8) | workitem->quad_id_lsb;
 		for (i = 0; i < ARRAY_SIZE(kbd_builtin_touchpad_ids); i++) {
 			if (id == kbd_builtin_touchpad_ids[i]) {
@@ -965,9 +966,6 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
 		break;
 	}
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-60555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F36B8506A7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261FA282342
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC67605B6;
	Sat, 10 Feb 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfFNn46a"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071E604D7;
	Sat, 10 Feb 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602007; cv=none; b=nivodCVHbiTJ2zWTXdbkNq/brJ3IwFu9EAMNM5udbZoKwz8rjKz3u5PT5re4+hj8Xm9Fv++KTKbJnajI8/m46oJG5znnDn/15Bli2quoRTCFqfGZfasg2JHlcVoOS2s6VmqglNAOwSVOtvzNTddnYSmPP+YzJJVZV4k4ZfKB3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602007; c=relaxed/simple;
	bh=gDhQUebaa7t6ieh8Y51ShSPwVNxKLw23nUX5WrKMldg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RGUHZxc5qjZ9t2X4xJ/yMFTHu1rxKEcYAkXEJwOeHfXS5AT0PV3pZ4XWOMw7BpgyfydDA11gxmXY0iEdtTNxGycVNw3F1Qkjat5WYlqMzijTXs1S1nPD+JlMhGvulGm5XdnrNeh1AfGXZzAQ4h1c1LH7WtHarf/fPlAM9HpYjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfFNn46a; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so2465693e87.0;
        Sat, 10 Feb 2024 13:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602003; x=1708206803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UODuNfAGA+zsvY/n5h+6gJpvPpOhAjXDdRWfKreEhiw=;
        b=AfFNn46a2zhBgqbUvk6eFwLa/Mh+3QrPL+1FUiIWS5rvYUL7lrAAKZ4+YAdwurXBYS
         uQV+UnQltKtJ0xBe3CgsApuR2wI9WsULbWAXGHh9IRjRSHTDMyN3ir92MOi48QMzsyaz
         NhHKp/zuY8KXI6oYoIx1KtiNdGrONRCV6pVfjxGBuykId+oqkqbM5SpLQtSQAaoKjUdB
         W1lpPJi/D5u4QdRa6URyqAA7eD1xPWDSnb//YTojRw627UI1VDfBtTmdkwRlXpnBl5bM
         Fo2mP9Nh7IF1IfF2ss4FaZWUWLSD0YXnRVTpnSO/6/TjDklXSAcMglhqAsHR6L54e/jV
         XNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602003; x=1708206803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UODuNfAGA+zsvY/n5h+6gJpvPpOhAjXDdRWfKreEhiw=;
        b=CgDHyw3liX8ODbCZ5ek4lu2DGDOj6wrcUIIqYRBvH2zpDR1fddmW9t0lpQHajH70kp
         Fplu4wAX58s3rtt22fmNngRqYjbMJQOZM9I1iX3rD8DgW0SWhvE0Su4WYjXtZ9jV6dpE
         m/0SFlaXaSM+OPRfkqquInuKJWqKd5n5PG2CQEopsDALm5fQE1p2zG0diMAKz659v/7u
         qyOe3Z6U02BCEnqRuIDsBONs6sxWGGY+rQqXM6Lcb7vV14YkqreexdkwIV/LQlkcYhdU
         EXMuksj7HHxof1b7TQHr6eZhIha2eWTfxBo7zHe9UGuHb4hxJhuW4IalhC0Q2rrTpSK3
         tpew==
X-Forwarded-Encrypted: i=1; AJvYcCUoGp7+k7JJjULpiQpdRGR6Td/htlYuLYyA+pu7zLWW8QCxCXJweIsYnrX5bodINENLcgIUW3Ju1ZOLjmSx/dOgiRpwj8Qn4+jx91vxgfNdBmGtQJCeEz3z1H0AFsQPoFG3AeZE6EmxEC8=
X-Gm-Message-State: AOJu0Yx7nMZp64PqMK+ly/YdSn9ekWv3rS/cTxn/Alpvw+yg2b5EbYrb
	P1VXJKq8W8YoxVzby1GtxSOUUXfz78tThI0EyV/IG1v5Jk6NFSmF
X-Google-Smtp-Source: AGHT+IEqofZLAjp83Pq1cN5RQ584GtEK65VSSqOrt+GNzw0tdk+B5sjqUQe5WiUwpym5FW4KIlWBKw==
X-Received: by 2002:ac2:4d91:0:b0:511:82f8:d30d with SMTP id g17-20020ac24d91000000b0051182f8d30dmr1738073lfe.32.1707602003255;
        Sat, 10 Feb 2024 13:53:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWujr/UBh0ujT5bxNwSXnL461jiku4Mw6uUMQEXaJ7m80CBselpdh0gltd+Qnal67DxWkC++wt+wI+92G+Xwf2fcC1r4g2MwDslhaQgaOYJ8OG3QglQMGd32QUMmSpGHs8hESyfdmayEceTc+63eiVKtt9znx+ZFg+CsFbfvAyU8A5BGAgUYDsf+CdCCUO9jUTSfE0buwwgVtIfirpsWD/+ZJkPJTOqxyqrZLzz4EGamsK/1o1Db+CzCoQCfovpI2JPTcyxa1Pn/hmCJoVqwo4A7dHyB1YLw21zeM6avXXdF7Hi76KzkjSI3PsQ8uzC45PrH9SWdukPDPs2tlxXOxf4/5OF4WlY2w4WcYySGjiutTvRLOe28Q==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:22 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 08/19] hid-ft260: depend wakeup workaround activation on eeprom config
Date: Sat, 10 Feb 2024 23:51:36 +0200
Message-Id: <20240210215147.77629-9-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not activate the 4.8-second wakeup workaround if power saving mode is
disabled in EEPROM.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index b24998092d22..ccd20f590720 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -323,6 +323,7 @@ struct ft260_device {
 	struct timer_list wakeup_timer;
 	struct work_struct wakeup_work;
 	bool reschedule_work;
+	bool power_saving_en;
 
 	struct completion wait;
 	struct mutex lock;
@@ -889,6 +890,7 @@ static int ft260_get_interface_type(struct hid_device *hdev, struct ft260_device
 	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
 
 	dev->ft260_is_serial = false;
+	dev->power_saving_en = cfg.power_saving_en;
 
 	switch (cfg.chip_mode) {
 	case FT260_MODE_ALL:
@@ -1063,8 +1065,11 @@ static void ft260_uart_wakeup(struct ft260_device *dev);
 static void ft260_uart_wakeup_workaraund_enable(struct ft260_device *port,
 						bool enable)
 {
-	port->reschedule_work = enable;
-	ft260_dbg("%s wakeup workaround", enable ? "Activate" : "Deactivate");
+	if (port->power_saving_en) {
+		port->reschedule_work = enable;
+		ft260_dbg("%s wakeup workaround",
+			  enable ? "Activate" : "Deactivate");
+	}
 }
 
 static struct ft260_device *ft260_dev_by_index(int index)
-- 
2.40.1



Return-Path: <linux-kernel+bounces-126763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402D1893C64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6B01C21668
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1B45BF3;
	Mon,  1 Apr 2024 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8v3s8xV"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E2446A0;
	Mon,  1 Apr 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711983203; cv=none; b=n5NMcwdXaizAsESGq4KAnCQK3VBMAI5f7tXkbubkiJ4wGm0gJQAk9iUSKnRAcvtNtAAwpttN+GcRPlmWHqNd0AVrKUmUl9RIHg9cjwQOJHnrWfrzRhjHA03Ys2oGDGTrHIB4OgZQWE/g2bZYRSXLp2w68cn2qHH0oJ5cJaRzask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711983203; c=relaxed/simple;
	bh=Hda/pcZKSdARtq0lDDOblBsfsob21d22E3Mq1DlOg9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srvRGDlc2HYa0sXM3sPklkqGvZbTMHgOQYXOdTcYBj4cEjjPHpEcVqrVQ92sXb9wCkvunuHKTRDKp4QnI7Mp43eDRrb1MQ45bL87OgK52iCxlN+BIgiYh6UE9MylT1TVbN9O0JGA1kqvxwG6FTyOsg3Tm0xzl9GpfmGZ5nOtvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8v3s8xV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so5116336e87.0;
        Mon, 01 Apr 2024 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711983197; x=1712587997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZvNyXwkPTrqwrSzNjuIBelxb6SA9fNeAnoyYJRTj60=;
        b=Z8v3s8xVjmspEtnTj711q3Cywj6VIQR2kjKAYneHhG3QnW6KvXU8w/M99q+LadT7Fx
         bEqznjRYgx6kjMBe6J2VSV9+kXXE631cOCNU9hZSgYP9NuBHgJNNAxJTV8/+5xip/kwE
         eGXJIFp+Qrr8DJ6umL6KI6/RhhkKFxmWpNIlFFg+9U00yDAR2OJnRaVUFwlpqKgIIh+g
         gfklLVvmBc2FApEVfyxXNC7Be4RFrQAykIko59vJJK4fgHZ9Dq+l4pQjjpNLzIqLW+a4
         AoEvUayVBtWn1NUmiV6T8hDbKfkYoNOY9fF7XAi858FwXbDIN/RheDEmU2tHJjYuYXXf
         pFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711983198; x=1712587998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZvNyXwkPTrqwrSzNjuIBelxb6SA9fNeAnoyYJRTj60=;
        b=NJpJ51C0xASXzD+laFR6b1RA/oJr5lmuJO5zYe9Lel6E3T3oT6d8lKinnhWwVWHLJo
         BeThBQm6r4q8DzwXSyFfafgJGCkf/ZOaQqf6lnDKtvA3dyi7RJH0nCjCP9pn+Uv3oscR
         k5+ggN1OXEDloRj3oIv80lEqyClBGpyaDNeLZq3XxSVZ3xUuMhlx2WOTkJ7AdmKJS8fU
         s68Oktl7TjUzPIWl/YaYANW7n9uXC4xSAcgAD8Ut1Kbj/HgJhiXlFTlL6dKGrXwtWC7W
         hGgFLyBP9+nVNItascVomzVW5Zs6Gl9pYqs1TisxvTfiw/6WvoyUAF6+4Ut4buxMCPdP
         Yqmg==
X-Forwarded-Encrypted: i=1; AJvYcCXwWkvfR2mDAo9mMsI3ih6FmydwFwSeWcio396Bh5BqbGk7bnTHSE1EyOxXuStr3mAgrDorP4NLbsFmXBnFrURr+ZV/f++vJ7QnWi7hcJ3pD+RpbQZ6cAjEiGugy0XxMvAqHBZO
X-Gm-Message-State: AOJu0Yzt1oqDhuSDZGBCNwixbfqXXJvZUbhmnP9T65pdCcruSqSMON4c
	81tB4goAg2u0KTSSRjm9vfs9olW2hiO7j9TnhlTT69s/XPWv3wWcq/CvaF5xHe6e
X-Google-Smtp-Source: AGHT+IHiFC1iVawFIdmsEKx7Pa4Jvjd/fNMQ0J7TvCjVyJQGxEpJ14Oans7o0yFjlvPxOBp5NtGq7g==
X-Received: by 2002:a05:6512:3c89:b0:516:a14e:82c with SMTP id h9-20020a0565123c8900b00516a14e082cmr4326576lfv.4.1711983197405;
        Mon, 01 Apr 2024 07:53:17 -0700 (PDT)
Received: from frutis-latitude7490.lan (public-gprs367196.centertel.pl. [37.47.65.157])
        by smtp.googlemail.com with ESMTPSA id x12-20020a056512078c00b00513e4086815sm1435703lfr.162.2024.04.01.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 07:53:16 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: phy: aquantia: add support for AQR114C PHY ID
Date: Mon,  1 Apr 2024 16:51:06 +0200
Message-ID: <20240401145114.1699451-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315080657.3460084-1-frut3k7@gmail.com>
References: <20240315080657.3460084-1-frut3k7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for AQR114C PHY ID. This PHY advertise 10G speed:
SPEED(0x04): 0x6031
  capabilities: -400g +5g +2.5g -200g -25g -10g-xr -100g -40g -10g/1g -10
                +100 +1000 -10-ts -2-tl +10g
EXTABLE(0x0B): 0x40fc
  capabilities: -10g-cx4 -10g-lrm +10g-t +10g-kx4 +10g-kr +1000-t +1000-kx
                +100-tx -10-t -p2mp -40g/100g -1000/100-t1 -25g -200g/400g
                +2.5g/5g -1000-h

but supports only up to 5G speed (as with AQR111/111B0).
AQR111 init config is used to set max speed 5G.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 71bfddb8f453..d34cdec47636 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -28,6 +28,7 @@
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
+#define PHY_ID_AQR114C	0x31c31c22
 #define PHY_ID_AQR813	0x31c31cb2
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -962,6 +963,25 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR114C),
+	.name           = "Aquantia AQR114C",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr111_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR813),
 	.name		= "Aquantia AQR813",
@@ -999,6 +1019,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR114C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR813) },
 	{ }
 };
-- 
2.44.0



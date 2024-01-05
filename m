Return-Path: <linux-kernel+bounces-17585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F990824FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F270E283797
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC621A15;
	Fri,  5 Jan 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z6eRd4Mc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DC2510D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2814fa68eeso106303066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704443069; x=1705047869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2ZqOfc2YusgwP+oQ4T/Qs2/x8rT4twAhOHtA+/5S5g=;
        b=Z6eRd4MceanzZw9QupE9PURLXR/QlNSGPF5nUrkjvEgDW6Q08NOOHVnnew5Pmbf4oq
         lkbAvBwxzB1HN9QpWKPNQBRxmEpdU8776nXoofOhdyHqMXvSF55+Csc3tq+wdXdUju6c
         PfkfPGn3sMhhQzilbQXXaXpx9SQYE+YJ3HlPRfvcoExykQnM8I91QZUjbRA355ttc5g9
         PMwZu5em1MT/NhI8AN89sIKrHlWf94yTlEMLHmtdw8qVObj7lG4HzVnKMeNWHOe9aTSN
         cH95pceAua3/khSYPcy16yjkZYTmBZSlnB53pPYa2B0IXn7JbHvreaZXHExX3XkHQKjB
         J6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704443069; x=1705047869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2ZqOfc2YusgwP+oQ4T/Qs2/x8rT4twAhOHtA+/5S5g=;
        b=Kt1HDP1aaWdcf5qp0HoymaTRm/1m06R83bPKsVWD9UuA9ngr8aAUY3MnrfysfwUXfk
         O0DKadC0jxd29H5VhO1nWr8MtXWrUMNx08LBOPrSGgLUKq8fWHou3JQqXk9r38Sm8788
         Ld5LWVOpsUXuZuHWBEWpv0ja+i5iVu2v9EsBLnLD3MwCc/pnIdMNDIaFgdEswxwBzbt1
         em1d/QTDiWlAa9QHXEPi9tO9sNZiUPzqs63Cw8YwJCwjFXvqjW11fJ7pN5VWXuR4ZAB4
         pq0CYwqMg8BmB4S/H5pXfS0K81X/hCElJWBxtQkq8HlnmQrONBbWZn/9mFX00Hp06S41
         Ktlg==
X-Gm-Message-State: AOJu0YxGWIjw3gSohGSufJbBKoaxNHjqrv3/w9amaeCZ8xFl1tVfFCB7
	imTOjqTht7PAML/deE3vUUMUyqIZSq3Epw==
X-Google-Smtp-Source: AGHT+IEebcMHP/l3wa8/tlp0iaG0Wl4wsPVIQVAulNpsIk/nVH1V1B4OCf8ED3tUzulGHaAcwT790A==
X-Received: by 2002:a17:906:8cc:b0:a23:713f:9851 with SMTP id o12-20020a17090608cc00b00a23713f9851mr584922eje.18.1704443069163;
        Fri, 05 Jan 2024 00:24:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709064b4f00b00a28e759a447sm596198ejv.213.2024.01.05.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:24:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 06/19] net: ravb: Assert/de-assert reset on suspend/resume
Date: Fri,  5 Jan 2024 10:23:26 +0200
Message-Id: <20240105082339.1468817-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

RZ/G3S can go to deep sleep states where power to most of the SoC parts is
off. When resuming from such a state, the Ethernet controller needs to be
reinitialized. De-asserting the reset signal for it should also be done.
Thus, add reset assert/de-assert on suspend/resume functions.

On the resume function, the de-assert was not reverted in case of failures
to give the user a chance to restore the interface (e.g., bringing down/up
the interface) in case suspend/resume failed.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- fixed typos in patch description and subject
- on ravb_suspend() assert the reset signal in case interface is down;
  due to this the Sergey's Rb tag was left aside in this version
  
 drivers/net/ethernet/renesas/ravb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0731857c2a0c..844ac3306e93 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2978,7 +2978,7 @@ static int ravb_suspend(struct device *dev)
 	int ret;
 
 	if (!netif_running(ndev))
-		return 0;
+		goto reset_assert;
 
 	netif_device_detach(ndev);
 
@@ -2990,7 +2990,11 @@ static int ravb_suspend(struct device *dev)
 	if (priv->info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	return ret;
+	if (priv->wol_enabled)
+		return ret;
+
+reset_assert:
+	return reset_control_assert(priv->rstc);
 }
 
 static int ravb_resume(struct device *dev)
@@ -2998,7 +3002,11 @@ static int ravb_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int ret = 0;
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
 	if (priv->wol_enabled) {
-- 
2.39.2



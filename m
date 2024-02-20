Return-Path: <linux-kernel+bounces-72676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704385B719
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D941F25946
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62B60B83;
	Tue, 20 Feb 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXlFU53k"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6FB6026A;
	Tue, 20 Feb 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420662; cv=none; b=P48tCuD91ILpBZwp/RxB1L9511bHc8uW0/P/scxoCZzNGg4fZmuryKLo+Q4covjveFTCC3RzIHQRgPiQfQV7ReGyjzry+CrT8uOYLR0Myh2qGuuE6PgKbF2BT14A42XvaLG2JdCnfI6YIMyF2vIP8i4BzJQH50kp3vGyFdoThiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420662; c=relaxed/simple;
	bh=Y4+kw5fSFQQlDkOZRhwRC0+QUSv5CfeWWx9wRZnsPNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dbrUeza8ImDyirRv55eAHvzgzrpkhFOho2xx4KFbxg90TlWNYNNcWDkhn9TUx3Em3YMSFATEAnlCsbolIO+W1ZsxTrMYW5aRdgvNIMnE9M4ZgBzxnyNcgH/QUbTQ65/tiQgSGh/hiYXYQRtvlHJYJfYP8Dj13I6hIKUSukrda8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXlFU53k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4126ac0c32eso8689645e9.1;
        Tue, 20 Feb 2024 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708420658; x=1709025458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZrwGhtv9s0VvylEijnGbReSc1OyaTC/p8gufQFjhr0=;
        b=fXlFU53kI8ptXEVD3AlWhtLcMUkCnJnchwSfZe9zRwet872/UjdccJ6QDHTIhRUPa6
         S4TyZqsnlsmsi85Ikdc8eAM5oDLshfKkKBQntOpnkLNPXQ4hbrALz8XpL36OGaf12yGO
         LympI4qKW7vbB52v3OjNBF9KfBahR/c2nvxYp/OVZXHBouxCqbQg6N1IBU8ZYv3aK2Wy
         P+1PRmJg0DFYAduZphio3drkXbnEdzZTBhEG4KAvcycmb6V9vlIEncyqa1n2+Zoj6U9f
         gOWwgCyX4THi+WQ1AiFi3FAFKNA2eRxUMJ4OF8SfqKmqPzsp7qC9DUNedf0yX2k4aAOc
         t6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420658; x=1709025458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZrwGhtv9s0VvylEijnGbReSc1OyaTC/p8gufQFjhr0=;
        b=MTpl6Gq/UjkUlziKE+tgWl4RuLYI9BvRWxzwAFwL7kvpTd1Oteh1JAMWyo9AT3IpBo
         rMmF5H4YH0+I1gm8uMorUrkO5xhaXywwB9Qa0RMG/PZ17Z7ByNs8fDVmu2+WMhYYTQAW
         TDYJNDvqpgjBDrHUcK71yODaORCWTsdw0vHmwZQbRyXCnIpmhr/5UQZN6dNRKTs0w2EU
         Egds5ZzCaymICI5ebd7ZC4DyCfo4tv+EKWbg6TrxMXqwOSIS1hfv8RHsWY+1oiBt5Yzg
         UU35NRrB55Dc7vyAWWL2jXIoC2v3PMHrAUcrs+VG57TDLnFOvnVGqRqV3WatD2gks8m0
         eSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVTy/5MvmefyAN5ThNdC0nmCSiSisW7DSPRGtp/j7Yzb6ujDf2LWulkH9G3GWxK8IYbD92w5lM9u3KapFsCiLPkWO30O0Z70HO1aqf0LkjVA6Qq+F7D2zOhSviEzduUtaoqhnzI
X-Gm-Message-State: AOJu0Yw0e6AIH9IfynhaFDC8SiCW1hVsxx0ISt93S4sg2mT8rlZoKKXZ
	CfGLo3mI8f5eQHdqeIJHFUyQoxa+FM1nqcoeU19h2keqOhVo2rk/
X-Google-Smtp-Source: AGHT+IFheKiyGbQ/0yz9kwl8fvcJsLXeq6xjON82DDfxSrN5tD+ZPojaj04MFISzpmZU5qn/ENxqRg==
X-Received: by 2002:a05:600c:4a29:b0:412:f24:5732 with SMTP id c41-20020a05600c4a2900b004120f245732mr11426030wmp.37.1708420658575;
        Tue, 20 Feb 2024 01:17:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b0033b60bad2fcsm12748356wrq.113.2024.02.20.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:17:38 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: microchip: lan743x: Fix spelling mistake "erro" -> "error"
Date: Tue, 20 Feb 2024 09:17:37 +0000
Message-Id: <20240220091737.2676984-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a netif_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 45e209a7d083..bd8aa83b47e5 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1196,7 +1196,7 @@ static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
 	ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
 	if (ret < 0) {
 		netif_err(adapter, drv, adapter->netdev,
-			  "erro %d SGMII get mode failed\n", ret);
+			  "error %d SGMII get mode failed\n", ret);
 		return ret;
 	}
 
-- 
2.39.2



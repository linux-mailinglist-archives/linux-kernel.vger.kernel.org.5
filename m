Return-Path: <linux-kernel+bounces-166525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864E8B9BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE222834EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349513C681;
	Thu,  2 May 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SdNm8TVL"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB713C660
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657577; cv=none; b=FEu0mJmh1jPLdXQ7LNc3IJ9CH3AOGrGqa20sDvdD67A8PEGxNI78GMBWHFDiAzBIh6jBQO8E/Cx3RBUaWKsz5dQ07stAdJkuGa0HjqsO553zlmnjGS5p/xuLY+Q+1iWGaBuez++xxxR024WRq9ts0SKS2XVxftoToPBA0r+fsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657577; c=relaxed/simple;
	bh=umAKYkGw6Qh2FAI5WcUUghAsI5djPBhIsfyxFgp451E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R99tXPu6eB2gsbsnyYTOp2NLHu+FNMSxF1RqdyxiKN+g0m/t2Z00Sl9CT2HPlwh+NEnaHuew0Bp0iWmlWQH9WGWNa4DNttOzaLrXNqZqMtlT0b8VjSm2osHIshE0ENywhfHpoUxAz6I5EKtixbg9HnTdo/6ULeRGsPCOZnw7CdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SdNm8TVL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f25f87e58so822167e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714657571; x=1715262371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjbvBW6RdAEPTXQDkB746T8DtbLmBQp7aI+NR/HIMtA=;
        b=SdNm8TVLQzMNJD+AUbaVgzzoJlYQQeS9DAf05qP0IVyOzxGnMkoNhw2d6p3RTEomn6
         6S198zsONFGHsSc+Kla7zjIJ+ZfFKYz/PfYWiyQNw7oagI7h5+uoP0EmVimRphcGbNqo
         wZYlgK6zJ3EHlNeKxzBUZCOWPF76xEynfM/wg0U5Dm0kcGFQM24fs3maEqk1nMOlH1L0
         Sl4s/C9Xt30fT+G7S+z2mEuIhLTtCqR9QVtr8NTpCJorGlQzfAzcA7lK5P5imuvSk3Mb
         lHkjlg9FCexO3sOzGMTXccfg3qko9YObpOT7ZvZirYg/IbhyZngSjTyk6T1V5HZ/DBI7
         yi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714657571; x=1715262371;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjbvBW6RdAEPTXQDkB746T8DtbLmBQp7aI+NR/HIMtA=;
        b=D/YxQusaYnj1Mql38dY350moCvIx6OZ/vQTQHTzuf12DfZdSe8/+yUqmk5ZNzNBIqE
         iQP/aZRkZG68CWhaL4GJRDZ07TkCo08s0544u6Yju8sEawc6KLLkccyNLD9guKALXG2O
         c+RlpkY1yW98OFj8Cnx3pDDnrt4KjfrMOeJeSoGZr2sobos0y2S8fX6IERurcTt4OOD0
         37Wxc1LVqLvgChmJZSaXpZFXOglaw4sPHqiKdZ3EXaakRLicB7zq8paWVpkpBc8kJccQ
         Gbs+x4S6O33bcDlpDomhy6uThGWpbbRiukH+lWM3YrwCassE+8nHiW3Rj6Xr30nm+rIl
         wKYg==
X-Forwarded-Encrypted: i=1; AJvYcCWXwXFE22v2KXCwlXy8nXPLA8mtnvFJZW9xdt8m4ypRnqmOq8KHG/sV2tOborbWNzAqisR5pClQ7bP1j1nlznscz98a6+sz6e6GDMjS
X-Gm-Message-State: AOJu0Yz4GdyAxJEAejSbgEU6lcR95d2KNf/CqOJFGtrOwT7LqUL7wZjF
	rJiLH2juOB5mwUMy16ncnLA3VEiE/Trh4eVtG9NP6Ojo+4gN10LWzbDEz1P9ATc=
X-Google-Smtp-Source: AGHT+IFep4NL01L9Ttyd1vLDcDsr7A1IdG5IgCdv67mtSJhnn0nKGdEu7Tq10aLQKCI1NwgsUJdJ7w==
X-Received: by 2002:a05:6512:3083:b0:51a:a400:785e with SMTP id z3-20020a056512308300b0051aa400785emr5147210lfd.43.1714657571559;
        Thu, 02 May 2024 06:46:11 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b0041bf3a716b9sm2014447wmq.34.2024.05.02.06.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 06:46:10 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Thu, 02 May 2024 15:46:03 +0200
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Check NULL ptr on
 lvts_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mtk-thermal-lvts-data-v1-1-65f1b0bfad37@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABqZM2YC/zWNwQrCMBBEf6Xs2YU0RFF/RTxsmtUE2yi7SymU/
 rup4PEx82ZWUJbCCtduBeG5aHnXBv2hgyFTfTKW1Bi888EdncfJXmiZZaIRx9kUExlhiP0ludO
 5NQI0N5IyRqE65N2uvBj+J/b8I/woy+/3dt+2L7gkdLaHAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714657570; l=935;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=umAKYkGw6Qh2FAI5WcUUghAsI5djPBhIsfyxFgp451E=;
 b=XsliQEKG1eu9+im+fcPyY5Bbcd0sVJkvx/RcjpKU1v7XxCLRK2GVF3ir4d6kad7e4Geja8X1n
 U9XUTA8WUMvBsVCV6f7yMC4aFi2H/666pKzVpdEoUoeX/0+JSCS+uxO
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

Verify that lvts_data is not NULL before using it.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
At probe, verify that lvts_data is not NULL before using it.
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 86b2f44355ac..20a64b68f9c0 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1271,6 +1271,8 @@ static int lvts_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	lvts_data = of_device_get_match_data(dev);
+	if (!lvts_data)
+		return -ENODEV;
 
 	lvts_td->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(lvts_td->clk))

---
base-commit: 9c6ecb3cb6e20c4fd7997047213ba0efcf9ada1a
change-id: 20240502-mtk-thermal-lvts-data-4b19d0685024

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>



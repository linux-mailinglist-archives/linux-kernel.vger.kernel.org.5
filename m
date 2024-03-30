Return-Path: <linux-kernel+bounces-125886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2D3892D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442EC28318C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C7481D3;
	Sat, 30 Mar 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJKucHwX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B743AC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711833030; cv=none; b=HSYfbbPiBriA634D7zWw7Az62UHIxwgrzOr92FleEREijYJzqgSwNXXfKLoIEt22sjk4MMlWxM/IUApikV6zdGiA1b0yXdKw4tVpvJIb1/1J2C/w72F9MZUMBglOcnulxFg+8DpKoJ7JmkIdsu+s+75fWFUFn0k2U795qg05K5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711833030; c=relaxed/simple;
	bh=5cyk0mZPWqkezr+FTKCeHWipPZpAG9tXQ3TzxjeoxaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYYPb1xsYyaV62VjtiXKfXkGJrtnZeVt1snctQhe0OMvPdD4qc3LAwmDDo12CBfqFTUDzacD6iXJ+en3D/Nnls+eJGD96FEkNmTGuVfcM+buCC+psxFTaemghE8jUyY9VrjyCrKJxIW2gmdley1wAF1qCa9FBfCPamKwh+DAbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJKucHwX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341e3682c78so1744678f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711833027; x=1712437827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=HJKucHwXrs4b+FQTF6hdlAYPCdImzzrwtKGc8WsGB3iqZORS5FZiTchupghwbi6xhW
         nH2y5k70ij9tBg3at2AB7dFP725wvz3R6/IlSOX9rnO6kffq33CUA9Ah0e7w4OACxwJF
         t+zxZmzHsxz6iW91jVortuqf1UbzccU6ZkTS+PJsVnU6DjYPP4bFXbE/XEPYhfmC7bQD
         8Oe45c6tRKF9FfsKAL0h1ZdVFfjXPGX+yOCEcOXsW25gVCO7OVqGdAs1HZF066/XdbCx
         DAw5j6aDvhV096NR6iMdpR8R8vnFO1pm+fVLUTKX+pDE9Sog0XM3gmovmBpUd9Re+QcM
         x8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711833027; x=1712437827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLkpmExOlKMcwACsZsH7M7SlZKO9kCP3VlHAwHc/QRU=;
        b=Vm6ITICkiVahKfH1QSt4yQ5f4gR4W0O82XlosGKwn07lf7MJGM1Xmn8FM9EvySYNwz
         sCT8zByZhMl097GjF3XUdfWqAsr8hxP0wlgjqHv+1dIKWkzKKe6pdtcY0v3+eISwsRa+
         7twiwttkzjnLxMg16+ldjVpioZwZYFH21PrsReST4Y0+EMWC20dpQG9jxKoCbk3T90dV
         zeXlarpGMWCurX6TEiO1pELsYEHaJGrZqu44z1PsOKvT5NPf7Mx2RQAuBkWPdJZU83KL
         sKapnz6LTuWimIsP6H0dMO4K58jw2GIFmz/ZQJVxl16cQ2oN9nogc4kJHnHrL9lC1dQt
         MDjA==
X-Forwarded-Encrypted: i=1; AJvYcCVw9R4SjrF43Hc2WtNtA+9dFKuunLw3U6a75HLUNRrW/jwCMJpmci2wjXhm63Q92XufljLJgyW9iZc2gERNxfQirVC96WfuQe7qvPMQ
X-Gm-Message-State: AOJu0YzOAYpslcxgrwlBeMNlVwFhSOCh1bk1Y06osomp/Yr7f7VdNxxJ
	xTBGTTJjPBiZ9KgH79cp4INf2V2W+ahW0XP/RrhIXNc+d5ZAx8nI7IiD7xKWsg8=
X-Google-Smtp-Source: AGHT+IERt4faZXoAKcqd32SoGypbspZ5AI2Z9HzqC72LYU0X3G22k6IsrcxS3SxIiC2LoT6Os1c6mw==
X-Received: by 2002:a5d:5222:0:b0:343:357f:6650 with SMTP id i2-20020a5d5222000000b00343357f6650mr3848599wra.45.1711833027100;
        Sat, 30 Mar 2024 14:10:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a056000036c00b00341ce80ea66sm7288097wrf.82.2024.03.30.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 14:10:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [net-next PATCH 1/2] net: dsa: microchip: drop driver owner assignment
Date: Sat, 30 Mar 2024 22:10:22 +0100
Message-Id: <20240330211023.100924-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index c8166fb440ab..79ae01507a8a 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -222,7 +222,6 @@ MODULE_DEVICE_TABLE(spi, ksz_spi_ids);
 static struct spi_driver ksz_spi_driver = {
 	.driver = {
 		.name	= "ksz-switch",
-		.owner	= THIS_MODULE,
 		.of_match_table = ksz_dt_ids,
 	},
 	.id_table = ksz_spi_ids,
-- 
2.34.1



Return-Path: <linux-kernel+bounces-150282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C598A9CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26361F212AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89DC16F8FA;
	Thu, 18 Apr 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vBxXnFu/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441216F827
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449855; cv=none; b=pFptKsY19pwuCHLEorgBTEAzKPdaOS6az6sVhZV6PxrY0FvXsWn3L/IxRetENM1b/ow7dcb8iqOlLoHMAMaURniy8M4e8XEsFeVuXMMOtO9GnbmNp6EL8+PQ9/smCAdOsIbP8tiYr0yzIb6U3BLGJZeyHWEf0Zv8EOnlnxDJM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449855; c=relaxed/simple;
	bh=CxkLUlifqvxz1G/Eho8b8T4Is6DgFjTZfGPXl6VYPH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbamQfR/gmNFaqDwjtYyypRFfXkopSAw7trOeh/PCjWZAmijLzrCss9FZkcj6S/4iNNtMzZDMzBkSDuhYMnQm1guaS3E48RIhulXEq/DhETMoT47dQ7TdvVCN7pPeoDLaYHXXnkv/h6fktpZ00rfgXDSUDvUKoCc/CdeQKuEdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vBxXnFu/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41551639550so6571095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449850; x=1714054650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3otSZuiUA0RBdwKSB/5nO1/TIttSyxWSp9sd21V3FQ=;
        b=vBxXnFu/c9mvmR/FN9iadbiWA6o/Wh2GnjzW+mc+RCpUIznlH3FoRLbNG1VhVdFPar
         r4y00EDwhP+8eo5+KLsWsA7UNnvIiOcItH82F5BoxSPiHvcysIuXe/Khb5A0rt3dXMj6
         JFXrmTm95ggwEb6XjmpsjlCQREaNayj1qYCim0VBoJY43CvBeArhqBkqh9reMXHDwnkU
         sAQxdAjGOeqOFmLNYs1B8I6Xcf652kPuNfsJha5rbAzSFlEsGslFep64U+p+J2ELjA0K
         lORdtKU+11dBydLFeocxSfnoxjEJU27U+EqtcV0X9sHWovow/LjCGKcDYIjqm5ii9TzL
         A1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449850; x=1714054650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3otSZuiUA0RBdwKSB/5nO1/TIttSyxWSp9sd21V3FQ=;
        b=Gp4MqDMsdKsGWkKQ5oMv9ftRjIKHB0U3bUnc/v0jrKc+QZLZvnBj+7miQzHDYfG52R
         hClJlX8LGPNsxiBTzg5Vl6zJXY+I+tJ5+dTVA9k8UdcQnwvkdB0jzrCdLCLthTXeXfQa
         srzFY3es1g255TE07DJxCGzl1yOhhvJGbfGyuzH5f9Aqqh+RGq+8r6d3NASKHTJZqzgm
         OUZWebbs8yuLaS9bQO6uFFZ5a92fq/Lr5+inPYyJ5Ed3dp3mBbBQITLTAuZn3NpmTN/r
         5ZMxe+qX4dqAdl4YTjBddxMGeQ4hVzS6FYrg5tCCXdh8YBAlqgsQUfgw61VwT8FSUO+b
         XsRA==
X-Forwarded-Encrypted: i=1; AJvYcCX2bO7jDq8YGdnsEYr/QLR9Q5nBQC/3AaZdhw9akj0z1gOo9H7+pu3gtPt+UMTmx6FZVtwS75wTzcBuJlpdclGval2uz963Ss9BbTib
X-Gm-Message-State: AOJu0YzMeJPCtBlcaujz6pVWABMseimfRR4oL5/K8JjvGCw4gwonXeTc
	zXxHlfaO0kgmCGf9uA6LoTpuNSthi3PI8JEpmJxfFbsm70SJ63JcJ8AYEIFDgpw=
X-Google-Smtp-Source: AGHT+IEiQUufXTv7FJcYkp/QB82CY+QyZl0A6G8qICn/+gCfoWDUcq8617KoBHtq/0X/7mU0hAwvqg==
X-Received: by 2002:a05:600c:4ed1:b0:418:d2c5:5c65 with SMTP id g17-20020a05600c4ed100b00418d2c55c65mr2438790wmq.37.1713449849699;
        Thu, 18 Apr 2024 07:17:29 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:29 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:17:00 +0200
Subject: [PATCH v3 12/17] clk: mediatek: mt8365-mm: fix DPI0 parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-12-53388f3ed34b@baylibre.com>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
In-Reply-To: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=CxkLUlifqvxz1G/Eho8b8T4Is6DgFjTZfGPXl6VYPH4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStjTlVje5tb59O8ee6DHe2YEYRuzYS3qUOt1aEr
 ArPtZJaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYwAKCRArRkmdfjHURQqNEA
 CYVXzwd+84f6xIO7EyRZqTIThqTCaSd0BOLeBN/VzpJk8gHezkxoYZHgiCRin94aHkjaR7VSMB/Quk
 qBq+TiWTMhA1/zaXb41ylAI+Dyew3JUPmpZ2M5T8yDYNnbEjiOAmGrAM9/+9bsp18Y72CDZgcRkkT3
 +VyS01NGZZsojIayz9SpoHYeJfa/MUxZ3tUyle4MMHJYbvkMs9MNQ619sgiQTWiE2+Q41Fv9dY9VoF
 mbVjtEs7R3f79z7ueli540F92j2WQZ4oJZ6LuQ0fGsXezsTGv/qfuoTmBHIVXRVY8p/9ciqrrnl8BP
 LVfYA2WXi8SJBZxYMYEOspJ2EYlIQyIZ03FG/bPJsvB7CYsuC0f4yqlwA8ARd2T6uoG0xHT3VeKS6Q
 sLNan3y/BScJLyDClVjWhMQXRW2CjNcSRVeM32pj6Ja37+B3RfnaAE9k4jf5pfbRkWxvsk7QPDCrCu
 IvPTDwRJhuyrC7BFmfac8T3JAUirPF00v1tjMXILiYfeA3K+Gm2K4SVmd+9EWgjEJcbf6ucCjlQU/p
 Mz7gTttZFPwcSGfcOzz67IGjCR6OlEXErvSLeC7em/u4Sq1gQIleQ5ecPpwKcZ2V5k4TcHwQn1/IyQ
 AREJ37OCcknpY2fMYZGW6FkM6el89Lz6S94SzjFiEJxeyBPQeCxEds2+saJg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

To have a working display through DPI, a workaround has been
implemented downstream to add "mm_dpi0_dpi0" and "dpi0_sel" to
the DPI node. Shortly, that add an extra clock.

It seems consistent to have the "dpi0_sel" as parent.
Additionnaly, "vpll_dpix" isn't used/managed.

Then, set the "mm_dpi0_dpi0" parent clock to "dpi0_sel".

The new clock tree is:

clk26m
  lvdspll
    lvdspll_X (2, 4, 8, 16)
      dpi0_sel
        mm_dpi0_dpi0

Fixes: d46adccb7966 ("clk: mediatek: add driver for MT8365 SoC")
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 01a2ef8f594e..3f62ec750733 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -53,7 +53,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
 	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
 	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
-	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),
 	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
 	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
 	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),

-- 
2.25.1



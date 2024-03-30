Return-Path: <linux-kernel+bounces-125875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF4892D4F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB6A1F21F9A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A88482E1;
	Sat, 30 Mar 2024 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rirMn9Qc"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DB481D3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831428; cv=none; b=rv7GAEXsL4b5/d9AjIVvKNLnhUOOSBLNXET0a00WuSjjNTW0KIimYbtiLZlc8s71Lvev3F2xiQ2PC7ne9Ld9c3KFH/qQXJ44sDcwrk4IXMldKUM8NQRa1yMYvFUENZkvk1sHFQY4fConGSjleEZRRAlwvXE8GJ0NoNsfIbfQPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831428; c=relaxed/simple;
	bh=YcU01k3+utKezOFHPg08Yx3HafMCGt2Hy8rvn4zmr1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiUj1b7958q+HOh+CeAQkoeHZa2w16x2nPLbfJYXzGYOwiE3AP5Dtr1Bv5N/0UILCYK85QQNgkcjmiDRPPv9l6Rwxb4JkjaCxOaDi1CMNoWR4HZozUALp/CN02RN22OSiZs/cY04cK9QbAtqTigoi8OoOvu4nutyxMLn91NSkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rirMn9Qc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34175878e3cso2250931f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831424; x=1712436224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lytz4NRlGMjIcJpm2jggdQDN6y6/sjFypog/Jp0bB6c=;
        b=rirMn9QcqpHWGxDF9FTcaVY2HUDGkPtLkBg9RTq68KGtVy3KxNS0eqg4tZ4VTSHkp1
         t3E11JDexNYWxlnD/qG6XYjy3ggdFCvGc1iknJohCqL7gPORbaVz+P4OyEVTZ7ukPMZ2
         oZtpl/4oSmK2Y1sMOCri5TQjGJhfXejLa9MZVRY8w8nJi2QJU8o5Mk3VkjunjIXVgyp8
         r4NlleKPd4zMLbBb+kq/9qie+0e6AvoLfv1rmvihjnJhqMnG03XV//oa58uDiXcleiYF
         IgjZll6llP+JX6WvaBSAJ4AUNdT5W9wVXb9h9vVhSwDBIMHgTBxNfem7aOuSiHuovqnP
         aF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831424; x=1712436224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lytz4NRlGMjIcJpm2jggdQDN6y6/sjFypog/Jp0bB6c=;
        b=GtRqsY3RcgJARk/1reAfEqDma0LXlAJ3hCBSKPKnII3jxs0ihXN8Bd571LosWKGl7F
         eMI0r277gukEarVBQYpDNjic+pkbuglZJCzkpJn7iaxmYRR2+SgDFjlwgALyh9/BX/AB
         jk5scFo0xpYS0MbNUZ8NxMCdR8jCv0LspmGm9YiRJrjh+odON0R2zap4FE4OIyAKe/mg
         w193P1o52z/hfh4A+4AH1C3n8HW+R0AmtUdv9draS52BNCSCCX5bkJCykUhlSSRNw8zF
         xW4Xtn1SmZQ1nL9TTLapdeivyWCVzZgYsgC9jw6CYjQMWrLgNntDOhWZj5WqgLEMcG2k
         fDAg==
X-Forwarded-Encrypted: i=1; AJvYcCX9GwY4c0Jvlj/KwneFdkYMhWgFjSvTHkmFtC5MFNUgsr1BPnbVsuhJzKc047Ld9dxqL3cEsa6LwROKdi67GCfk7AFlB5EmqXQ/6HNX
X-Gm-Message-State: AOJu0YwnlxLmCHdNRgTQonNMEkHE3XyAI8qn8u7OO0LPKgt/95GfgF20
	L7AsYXbCiawbFKRjgoaGHhIQ59HZ3A8hssLw0drcurNS/jC9YMJd0PLio1WiFTi2CsX5FU/et/X
	R
X-Google-Smtp-Source: AGHT+IEmC+12zHWKXQrDYIZtxl1tMQr6URkl8P5NKb7hNbBHYUVheUANTikJ3X+pXT1ODg2Gi3mwIw==
X-Received: by 2002:a5d:4524:0:b0:33e:d15c:3575 with SMTP id j4-20020a5d4524000000b0033ed15c3575mr3374244wra.33.1711831424325;
        Sat, 30 Mar 2024 13:43:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:22 +0100
Subject: [PATCH 11/11] drm/mediatek: padding: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-11-fd5c4b8d633e@linaro.org>
References: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
In-Reply-To: <20240330-b4-module-owner-drm-mediatek-v1-0-fd5c4b8d633e@linaro.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=832;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YcU01k3+utKezOFHPg08Yx3HafMCGt2Hy8rvn4zmr1c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlt2ZfAYGdPMVaud2WYnO/P2J6dEJEhY9cF/
 xWcTAT5AUiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5bQAKCRDBN2bmhouD
 185oEACByr63OyistUrAchRSUDePvLKUvea1pTj+6E4Q7EDGWgMV96qccpsRcfic1ckPDR8OUdl
 PAiUiqY3YBNXzQkXqwCJ/qCvhYOZwcfGmRuPXZxbQi3fKgESPqBLfjiJQ1ljMwhVZBu3Xqj6gJ7
 Yy/KKaAroXr2oxP3trIO1SZ5EMnZWFWFOWVHxR72WFZ/SCVyIg4OWl7pG+TGjNeCKBDeV4pFkR1
 xcQX9POwxlD7JFfLDz4lTzaPcrjHiyLiknsb+hMxWl8b2+cHB1WzkGEGwyYStobHvwxJJEVkOEj
 VX8lWB7SOcOy4S0l21nMtN8gFSgLu/q5/+nnaVHm+8XsTK+b5CYgV99B4wwCbl/2030p1xM+tBz
 QQIwisBM8DB0R/RpZuG809+9pqMP/7o1XLQb1IHFoHrIXOzxhNio97ZhXeNq9Zf05fTryfz7uPO
 aKxrsaC45FnvoOXNWAtfgLngEvqZYUkDA/Oo5WV31brU5NrYFx72Pviop4+SxbN0WoWHH8zvQCw
 ml47OAu+Mtq7XkbRX1tkb16TeMLByt2/vzM6HaB9ZGz7PRDkNXoezeUTDZoA9j5Ai5YV6FQzFhS
 FI8Z0DBbUYFcxKk9kGe34NLc20SdvfCCZBw5XFIMWKmNpHu+HSowyD5PWAMd1Xh56m38ZUGfThU
 jHlv1s/GNzDIitA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_padding.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
index 0d6451c149b6..aed84af5b9ac 100644
--- a/drivers/gpu/drm/mediatek/mtk_padding.c
+++ b/drivers/gpu/drm/mediatek/mtk_padding.c
@@ -154,7 +154,6 @@ struct platform_driver mtk_padding_driver = {
 	.remove		= mtk_padding_remove,
 	.driver		= {
 		.name	= "mediatek-disp-padding",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_padding_driver_dt_match,
 	},
 };

-- 
2.34.1



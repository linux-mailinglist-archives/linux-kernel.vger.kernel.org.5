Return-Path: <linux-kernel+bounces-90385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDEE86FE89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07FB1F22DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AED36AF3;
	Mon,  4 Mar 2024 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9/S/NyS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702125613
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547122; cv=none; b=a7Ces04+iSaoNIezRiHC7KM5BZRxmL26wVzp9g3rMFkiUWKO3nyx6YeCpBtYDpzcx3ZIk7nVRN7VbZklLEDFs58g7Fur5n2H2Q1lXtT94ny34XTcW8+v1YO4jJjPVwVrjOZnPDlL7ylxlBr4iLgzJ0fWKfWwDwHC1VXS/cIR4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547122; c=relaxed/simple;
	bh=tYiRyc4GCWh0OQZcegdBJotlKUvQmMppy24vmgOYX4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDo9Aken05Ujo699Egaol/oCrlUnLo53e0do5DPt0nbhaHY1zwYQ8eVDE3Io2HVGpg18VUGUpmL0Qvfv4pFNHyUjeVXqu0p4vEsSNYEHEiOMY1/bMcSWiaVoO8337u57LLrZgjU2ecYS4Ou3cU+jnJhc2gFTlpJiPbr/G04rTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9/S/NyS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so701943066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547118; x=1710151918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7jNpD8JVN2zPECncF/JczEVQcdrOC4+lvPqKzDW3Nk=;
        b=W9/S/NySWL4cFC3wUi4hMnYsusgzmAgly4dN0BY6/j8w6yyZj6HPozJfCYqVFihtWl
         Q3uzqncKkJsxqcZCKQbkFCeetXjz4nEJApFYLz56wm9+vtV0ZXH+FwJytY3HCBtFP8eJ
         j8Ac3ZwjTqPh6Djey3tSzwN4oudRYGpn0cQSQWWLIxZiy4b+yzJ/JzbL5cbk+fzVsKJ8
         sfBpNT93PiUwQGeeozWSxty+2I6gg/4Eo0FObjxBX23BqLw3Vw2LoJFVJwX0wDGy0B2P
         aCgFjC2lJ+gfIOK6ZUFSn8GnajIkCXlHli0YldFWc9qqI6VlkOA+fTf+UamJwTiSgq5l
         MIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547118; x=1710151918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7jNpD8JVN2zPECncF/JczEVQcdrOC4+lvPqKzDW3Nk=;
        b=rQFq+oU7nnb8D1xafPJMA5rEKm+XukmxKNzr3bSi+g4O5ryIpEITZLlmMaUPIZvbOd
         qDnqdLPdR4IBEsmCe6yeFrRB/q7eP9uo9KNbJ+ZSSpK5/Tne772lAj3qEXE5I69lHQ3y
         EA9M8chi83VqKe6gfdyYqtEyCQcj3BtahB/jqNLYUQg+XiT0egJqLpPuJ9iANBgO7MsR
         pRAJ1y42jK2ldnvvrjMVd2PjQ1toeqwzBlQnYUg10SEz+NZeBU6/Wc+s/eUYuKuZBBo1
         U391a4tG2uEXZ2chnIKEdBmLiODl8A03SW3CrFykzcOzcqTDpnhn5+E1n1WAxLa7VUdc
         aUgA==
X-Forwarded-Encrypted: i=1; AJvYcCWhlvOfU0KeAiHPywnkDeily/nXLLiMHfcW6etw1XW15lqZ0cNqKtVoW2+LkK0R2jZhQoJpRS007KPOzdQs/dgi0Wk1jtoMb9Nwdjbq
X-Gm-Message-State: AOJu0Yy1Kp4AdeMv1Kr5CnPTCxSSMcf6T12wHjyu2grHUUfWog2Wh3Ej
	TRcpJgpLYge/NMcKzdcdpswZ30+2V5iYWV/WXCtT3XhorOGglEtLKwbWrrBAnIo=
X-Google-Smtp-Source: AGHT+IHIKfIPI9q/DWJfY1zams1q9M6IFh+MBVE0LB3ZesWC40W+rYmZ2rQFJmiyAV8Fad1klY2w+A==
X-Received: by 2002:a17:906:f759:b0:a45:6251:f8e2 with SMTP id jp25-20020a170906f75900b00a456251f8e2mr895177ejb.7.1709547118705;
        Mon, 04 Mar 2024 02:11:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ef11-20020a17090697cb00b00a44bc99cd89sm2938481ejb.42.2024.03.04.02.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 04 Mar 2024 11:11:41 +0100
Subject: [PATCH 4/7] backlight: as3711_bl: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-backlight-probe-v1-4-e5f57d0df6e6@linaro.org>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
In-Reply-To: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tYiRyc4GCWh0OQZcegdBJotlKUvQmMppy24vmgOYX4U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5Z5kf3pCwb8HgUK+ziA6YZsz55ShzwCbPlrjj
 dMl2yuN1lWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZeWeZAAKCRDBN2bmhouD
 1/DiD/9EClVTNg83B4aoTpYk6q3ArcCWKbx42PizR2X6dccHjBKLN0SzFYUPp8ZRWNevidleHfh
 hupUfnR2wyDAYPVPWV8dJtdgoXjqCxq1y/1koCVZDMh7rajI7WnOkS6+g9z8POlL19KGLVYdi//
 Namj816X6p+XoGcwG7ns1mStAJdsc/RkT0gkuAN42tg/vREKdLIesdNxqO6PHytr8lr0oL5Qlf2
 O8Spa4QNgRt9FIlVFBvPv/UGY2ZlDjhUaPDn+xoIlqoCUN843JiGiAncg6CY+xPxs4XxbyKLFGp
 k2CSN4qRLf/sdfX4PagBz5wRrLKEkHDITyx0lJZ8K9NiSCWBD5XuJAApZJF81Fdam+7DIoyxPLd
 MxNndDTpFtHki2BkCFnq4kcOzKukGbR2jN0qBgi8y3H2JKsAdqQO3kgFS7Bec5ltmWT/4Qjtu2k
 cgw3rNW0c8rrFL/RpfV7mfgnnkB1HTcrv03TWerMJVvtTZlnp2udLIqpvjLsLiFj1Rl6Uy5ugtS
 aZ7OQgZkXseN2eOnZy3iB6URxjsuYEjwfWQ2pW8y8Y/1L4Sr/qJHZSTPRXKfNNsV19TI7msionx
 gDk54z5VALicMkbhcQGfaMiLD1bzd2ms0GRYNQ9KOFTFKsIu+56uI6bAXtAnbN2p5NypV/7lJ4w
 O9o+19pX4CAdJ5Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/as3711_bl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 28437c2da0f5..e6f66bb35ef5 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -383,10 +383,8 @@ static int as3711_backlight_probe(struct platform_device *pdev)
 
 	if (pdev->dev.parent->of_node) {
 		ret = as3711_backlight_parse_dt(&pdev->dev);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "DT parsing failed: %d\n", ret);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "DT parsing failed\n");
 	}
 
 	if (!pdata->su1_fb && !pdata->su2_fb) {

-- 
2.34.1



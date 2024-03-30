Return-Path: <linux-kernel+bounces-125866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4072892D41
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80657282140
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8A4D5BF;
	Sat, 30 Mar 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJjSy5c9"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD5433DB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831414; cv=none; b=jCM5fSZrvs1Xfsq36+tZ2Zl9R4EKt3+M4EE88j6af2bvND6vkny2NbdEXqfLRmlZL9D7CcqryoIUEFGypYwD65fl87O+QVTfzpaZLfQqTdn0Ui6wx0NaKZiWYIqKINi7JT0w2gy0p7b/V7i+N71OZE89nHyoYYmo8wQS3/+7JYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831414; c=relaxed/simple;
	bh=4HTnieqsHHDdbgAvPLUTi22tPknvvwpSzFloyS9LJ90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaUY/TfnkS8rJa9vIRuuj2KMZqwkh53+k80a8b6JxX2b3woXOLMa8O190Fsg9T3fil81UE23t+T5kQpXnkJ8iTzcYnvplttNhzwP822Gd9QHkt+5KaCsElJms5dWdwkcKvmLQxq/ZW3kwzsA1Ojh7FjBqphzQLoHncJw2rzDFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJjSy5c9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2223634f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831411; x=1712436211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkvgtJfZLFYPx9yFQ6Zl+mYWhCt2xCc9NZAo+ZUMPsg=;
        b=MJjSy5c9G9su0QwnWalpfyFd+rSs+ooq2g0VORyg5djphuXcZnNMF4Fuk39r9zr43N
         Jx4kSQOg5lNmiA49Ytj+mPPwvXecKks1QOe9OSCDH5/Vmh1c9gNydUf44Za2cU6wE5cg
         yRuJZRT6QYXFcW7mZoRz4SkTuYlroGHJMIR9oSqvJrExGjN713qFSeiIoDEgku1zW7Yq
         Wz62hSofor9MT9HdTfeCQ8iG6twCH92Kgtibfsf2vnrVmaZ0fjqFN0zQAjQ+0F+LpaHC
         ae6+fiFpksL3UZPTO0y5SPUh+35JCHmClIzys5N4E4bKkdcQ64U+EyBXMLMH3zeBpVcl
         DvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831411; x=1712436211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkvgtJfZLFYPx9yFQ6Zl+mYWhCt2xCc9NZAo+ZUMPsg=;
        b=DfaFX7FvM7Rxa2k8U6HJ69wmB4GOW+9lTqpnjOgAWwp3+4PEJUoGkfH7t4umyjR7ia
         itr+ueJgY16qcHFOmWGMEYlaC3rqeoV3GJqcbeyvunUiO3LplamxoNqjJgbrx7cUGIKU
         9qTNLNx5NbFavr6B08BXK+gg89CFXTiOS51epX+oXSmfYScLruTPM/yfisDE/WNdtIUF
         cB0P6vlYXPPEYvtGISEsLg+J1NkPdqkmGkhEk7z+9trGMhFO8X7XHqIozOtDFxdd2aV3
         Cxu9jPmxjmQXwdpTA8PIDcQxuWiD8bccb6GAkXXQJkByge4wh5XXY5g+Nt/CyMg/QoM1
         61ig==
X-Forwarded-Encrypted: i=1; AJvYcCU5Z7JP8lZ1jAs1LjR9aiER4X+hfMCa+brQ8WzOWrcmjTBbBZKjYOsfF669MoQ+dcoA7Q1zWmuxqC1hD0v3po+1Hfb0tAM3LryTbRHJ
X-Gm-Message-State: AOJu0Yy/zj+Iq3dPp/CdvamGhJc8mNdKeWxCNgDcDwHLFpCXjqIXC+cY
	hqG57Wf1qK1m9BPt3u4f9BAlKq7vNOvb+gsCfDFV19nOG74+VFmevJ6CdQNfTNwk1RHd63IWj/m
	a
X-Google-Smtp-Source: AGHT+IGWOdTkC7o9yGgejAofbZqEmlVeJu8V+2qwkD7lOHPc0dBfgw35/iSYGxJwzZWGT1QRUhFf8A==
X-Received: by 2002:a5d:6a8b:0:b0:341:c000:5f02 with SMTP id s11-20020a5d6a8b000000b00341c0005f02mr3680932wru.7.1711831410817;
        Sat, 30 Mar 2024 13:43:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:13 +0100
Subject: [PATCH 02/11] drm/mediatek: ccorr: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-2-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4HTnieqsHHDdbgAvPLUTi22tPknvvwpSzFloyS9LJ90=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHllHnjO2IXgcN6miz8gttSZeT0bPKxGg+MN6
 ZrEhreFAzeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5ZQAKCRDBN2bmhouD
 1zf0D/9oyBUNxb4yW5y+lYjzW+8hIB36xGGFf78Pk2cRxdk4fUZNyvxpadpNLMu0Pt5tVSvGiRA
 vCWgIwn2Y1Q0qaYqio07hjx47/wIUzpMqXiZrXEaFgy/hPcuVh5L9bLBhqK2evNoh1S/foRQUde
 t7Xr5ANtvslUmKkaBnxTMdhKkrxWHm0zwo4gTH9u6Zz8tZAiKPLimKC9cd2o6qTAHZONztgoDMj
 0X2+stZuG5HnDhixW52rogHLxTxGOfRT8IySNI4CShMOutaBORFmo48nVsCKOGs1Y0alef5vqDq
 saQR+JZktEwuqfrPOMYOL2Sd5hUzY2IWVFHBoFyYwnwnaR0f6wo7qkySwkHpVBqYsFCyrhS/fN2
 /mktuahx18Rf+zNlAruZJzoRZwuTl6Vu0E75RheuK0ahrSjV5P+IeIfmlZh9YzWLTuDdwst5BAm
 ijpg2rOpAVtKE4B/E+7+k7XjoYgKQpfA/dMP+YWR27kd/F4oEpjxcoeryrSEsPKPwK/19zrwzk0
 A6gHlTT4k+98Z49dJhkOgmHqAfbMoMceaLv1jwSzlVJ8iCHIoHu08hsmz3kTcAD6rZgor6Wa2W0
 ZtBPqX7oPOHeaI8XN2WZ5/DIrzq+NqCI5FLDYv/+6N4rFi0i+AoOc7M60jCvG3HPue2Cfkt7PuB
 WRWLu2iUpD5fhRQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 465cddce0d32..ff56c20d4e21 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -214,7 +214,6 @@ struct platform_driver mtk_disp_ccorr_driver = {
 	.remove_new	= mtk_disp_ccorr_remove,
 	.driver		= {
 		.name	= "mediatek-disp-ccorr",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_ccorr_driver_dt_match,
 	},
 };

-- 
2.34.1



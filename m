Return-Path: <linux-kernel+bounces-125867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E571892D43
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5906E2820AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD72736AE4;
	Sat, 30 Mar 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4xUzt04"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBD4AEEB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831416; cv=none; b=Y4OTF9BwAD0MbT/oIVW24OCgqA5sw4gloVjc7xyubwWjwHRqewSPUaXLMOAZqN4uS+OBtlycFrmig37XerudGV46oezCq5fEnllcScyw43iXRDKx9vmxPiBm0o2AFEIM6vbKzaLEfL2tDfSqVhtarBzyfE52qi+hKPtxojvg8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831416; c=relaxed/simple;
	bh=GRHvmMpjGaimoM6mb70wpxBieg+Y2V7L3kfHMvFyhf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCeIV4DjUEHPCOAvhnVKQQx4LZtegguJvXfS2sjMvVX5mZ7Yrwsm0VR6keE8RTeAidesfUPyFx2/RcIgM/60gHGzDuIc4efiCl+oBAvpGna8DhGL24A5cKjx0eJGxQDHZWK/M+B2Jc5/vrBVUrWq5CYq13njzwA0eJkLQ4XKzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4xUzt04; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33ececeb19eso1746397f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831412; x=1712436212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0emvF/cLhXuWiqzlLx7GJV12jM/n36nJMZKi2m5TQa0=;
        b=K4xUzt04e+KagbPASCtWXGYAxhuKLF2mJhoXxVBO8+9HL0LSlQ+Mu8tulqTNzpdY3j
         fDBY22iMfTOQ3MD9edpXAXjdt/FLzk2WNyauzEr9/LT08TlXJUjWP9CP0nGPMbJryTQ7
         t3OUpbPClA3Q1zbfbVWvRaS5F4G7Cm2+mfyr06N/ZGoxW0OWGCu5VQ/vNdORD2Os6HCl
         JDYIu0RJuu+tLPtuCaoBLSrav1LCOWDi47ipxdJbQyB6uxBIVRGU7rtakEuyDyBPCCeq
         4Ibnmn3sYq0g4A4TFEVp/8UjyQQYSFJIU9aiYlJVbmpnLq7z5HMZBRO0yMs8tXXwvTAv
         Nfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831412; x=1712436212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0emvF/cLhXuWiqzlLx7GJV12jM/n36nJMZKi2m5TQa0=;
        b=Fw70zHRLbHi+bdTParjGF+E/OeHlKVdqy0fnJcCDKnHzD/b3uwyHYd3Biaw+FdeI2h
         4kDQccscEiw5Gn1IuaXFwA/wYh9hfov41irrfATPada5VbgYsqkxRjxXW4rNIy5Cg7jH
         ZCzdWgcpwhssqt09/455wepBeeuGsy7D43z1bg54XxcNPUwvNeZwOjK+hmTtww5dnkHv
         nuHyE37kS7IOFbY6ax3N2aqlUPvHLjLADPeJSwdWCLfq33/pKSX5/OTIgRX+YDLPeyJK
         1vgOTPb0seZ/nzmbiI/+iMZ2c7jhGrkunklMs2o6Rypjby4rBw/87p+RRoh7IR2p7C9d
         QRxA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCFAtao6U9U54FSZOxvYa1Ooc/xOhbbHXcijxMo2FFXWD30CLiwk91B8D0VT4pKMNaahANivMevPK2dKEniOdBLrtFipeMIvVgXGB
X-Gm-Message-State: AOJu0YzoUML+r7ysbrAlcq+X6hYJ6uYlunwEG2FxAGh/k/HLm9m5MDEJ
	pM8JdfA/qK6ODJHf0tKcvDokfjo9tZYgPmjTfK+XyCFyyaQlE5uoh4aC6ioB67lcjT9sjPmX5SG
	D
X-Google-Smtp-Source: AGHT+IFkGqAbKXnEB2y8QAY0Zo3dFiMkav7aBNaw2zsKLOXyCOq5nMycSsl9SDGCHPDFBAqf4p0WrQ==
X-Received: by 2002:a5d:4a08:0:b0:33e:c539:977d with SMTP id m8-20020a5d4a08000000b0033ec539977dmr3478175wrq.22.1711831412348;
        Sat, 30 Mar 2024 13:43:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:14 +0100
Subject: [PATCH 03/11] drm/mediatek: color: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-3-fd5c4b8d633e@linaro.org>
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
 bh=GRHvmMpjGaimoM6mb70wpxBieg+Y2V7L3kfHMvFyhf8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlmQX028BWFMF7uYbxxXKUF/44ZixRru4Atg
 GlhsSuXrtyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5ZgAKCRDBN2bmhouD
 13ehD/9Hd4ygwzrjIvHIIwXY8PJt8UReasJZDJHAagJiHw+xkF0t5Ec1gIny/0GNd/jke3znzZN
 I1KVY31Tppzsk+l0aMsK+Dqta5He7KERwdfWpZorLx/4OYmLuGji/q3X1pK5PmOEbBYz5a26Fc1
 QCpM6bpUJxn3a1hDJguxb3d9RDlss1xVKWi4SXvFFXEt+wRIK+IaPspPQ4X5fgWSi559skINnZy
 UNFwl9mTeDv9bWydib0pGgaR0BdqlWtPx6mAuLrDlFl08HEE3XmuQyR6SrxFokIlF7rFZx3LXPQ
 ecDqvoSUd+PHla9esGDUFZMK4hFsasW08AC4ZGL9gCCTWR4/wLrsuO+SgBr6kmM/ElZCqulyTnD
 hFInPjuF0IoeO4cLeR+ChknPft/mZYylGRmcKJMfqjVKMsWKklDhYDYQ+yplNNzbGGu/Gwh910M
 j+MDAZElVS4b7Y6+aTkFh5+1HBIOnrQGFacFhvwSHHyWalr5vzHAxXTiMaN9NhzssJFH8N5p4Nc
 JaraB4apf1q3MkxiX9OrrrEJpdYJBCaGEQ3KTLWs0LgB0M+mIcXIa1F+IMMJZrm5UXr55vRM8Te
 G25+SaIwsLjDVI6nOtbSK1DGVUlpifEXp7x0yKNVGgEGUrY5ZI1dVIpWfD/1XnMJzRCZywRG7jG
 6oT/e40ZzEUHaaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 78ea99f1444f..b3117a1a6535 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -164,7 +164,6 @@ struct platform_driver mtk_disp_color_driver = {
 	.remove_new	= mtk_disp_color_remove,
 	.driver		= {
 		.name	= "mediatek-disp-color",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_color_driver_dt_match,
 	},
 };

-- 
2.34.1



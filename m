Return-Path: <linux-kernel+bounces-125873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C3892D4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95100283EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0DF4655F;
	Sat, 30 Mar 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYcZkyGr"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973056773
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831425; cv=none; b=mqHjBmmbr+03WipHSVIsUEKAH3nn3ub6Qb2UIrdLZOs0BPgl8ZwK8OEs/Q1gndcFVWEneDxdZFE7Kx0+ueMaylEvzluCTE74Y2/XbvkBlf0eTgvOTcI3rkE1sPdF7w7jU+OKiX2pDtZWlbS1el5PINEJO/yQFH9KRXEmIC9eoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831425; c=relaxed/simple;
	bh=gYuLLFBbKL2GTlBDQbb3uSAqyMopOooAltsdvgRD2hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uTXk31UbAcGw9Tyr7knl0c/yqUJl1CJfyYuAsQVzdgHLU9kqjydQeo76YfflPOm5kf6zRBJcAbXf4vS4LR8M0rev/D4rkFlPawGAQ96AYcHqBFJrM+oxLjOcfGgPW8/zwqDX5dyUwy4EwIVJAn6h9eXYvpOstzHO4tP9ww+JVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYcZkyGr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ececeb19eso1746460f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831421; x=1712436221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIExVlRuthKjEW06MrlFe0iZQElsYGeKhHET6Bz7z/I=;
        b=XYcZkyGrrL0NyZWXDCR60FSFwlE0JISXZtuhdB3bZVpPGM6cukR/bcHsxCFFWJxFF+
         2/wMXL2nJJYjIsgkR4hoHaNE72BFhvyYtN6D+PmjC5JG4/05ka8Dtbi5ArgI8iXoC9xk
         MmXwJOvpMUl7w0ghndEGsxbU6VQ9bb7xhMTbgiNCA5//kKzDA6GHMi6GA/bJ21uW6x/V
         xtjiODgsG+ECSA5hEFoh832NUevLYzM2lMiUlkLDV9c/U/LfCl/Dvq72OeTzIkRJ8t3k
         NXgA19HeieJjQ71WZ9IpSjvA53N2+AsRpn+eycz9hQEfpldxGqmFFaEsJW3dnyMnl/Kq
         AJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831421; x=1712436221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIExVlRuthKjEW06MrlFe0iZQElsYGeKhHET6Bz7z/I=;
        b=t196SxvHzEnpjacszL9sbfUsrSD/7lC5U6Y1eiflKq6rjig7yoLjNmfFXj4lgP4Jlb
         DGLuV8BcnZzqrWXkNrw1q1hrhqp9V6TmdS1JgfAC4f8m/t8VpyVBLL4svJ2c6BeuAmXS
         wVRpPEpt7kXSYVtpD3qEOMTOVXPCu6/89yLhqE18/zD409ZGG66u7hXk+nAaZHaV3MAY
         mk0GcPYpLALxu9/VI+J8/F0jF0XkIv17mjZX+q5OGB6ktr3HgtSkOtybzkyS8+NYfblW
         GQnq4OIEZaCM7CLQ7QPS/h5NH1WfJkGT+gCc4GDClfMjY8np46eqrj4DkcSjX6VrG04R
         ysdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzanPLkWe/AT9pqXy84QJOdYRIww/N+Pv2Txd/9PSdGPvDoU6KoyApTiumxPa2qdS9/7YQI8wQOuGJpiMDrXyB4VT2FmaPR68w6hQL
X-Gm-Message-State: AOJu0Yy1va8gHQl+6laR+7wqbcvP8J8rPy+JZF7EAMUm/yB7O4cZKaZL
	KmasCH0LRBGSegR1azDcPGZ8Vp51AfMjr2Rehf8YSCvSP3AozinathFq0F6nrUgb5LtDdFTPuxs
	m
X-Google-Smtp-Source: AGHT+IG9iuoUde1lAoly9jtwe67T5QJoT0i6GOQgmU6/FfQpixJJco2dyJL90gG9kOa3T1xDTvVHUQ==
X-Received: by 2002:adf:e4cd:0:b0:341:843e:6e4d with SMTP id v13-20020adfe4cd000000b00341843e6e4dmr3393582wrm.41.1711831421105;
        Sat, 30 Mar 2024 13:43:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:20 +0100
Subject: [PATCH 09/11] drm/mediatek: ethdr: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-9-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=817;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gYuLLFBbKL2GTlBDQbb3uSAqyMopOooAltsdvgRD2hw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlrjXt3AFiYBCnjyA6IB2F8XUw/XHWVM7c8W
 LQ1OsJvhACJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5awAKCRDBN2bmhouD
 15RhD/wJdwHVbjfn9rfbn1/qZXPJDRjD9Y/CdHrL3zlzjsCuWuN+NrLnzSMijduiHF5jRWWsD7e
 M/qUoK7ZFgeX4NUYXPwnSv+FgBr+FT6hbwz3k79heTqQK2CSyV/QrBmkNcXOdy2B/Q0L+UonRnm
 EhJcvOhvdT4bgYcU890eCarOpT0cgdqwTsazJ86Kt3ZqGTQ89iRxzxlYTJxbG8ysTx9kyO9whWL
 S+tU84AnkxG74cZbo0xPzkkE7o/Z4nUCgPcAchM0LBhvnTXRagikXGT0Dw9WWT265sNjSMzfHaG
 1zndHVatcxz5Z4vYbekZb2KOV1gjaTJYoRcx1gCFw0e2KzSxf6DQp8lXnyhX7H2UzgqXpeDdnhD
 BQr2Fqx7Q45NbO5rjkAxQtqm9nxl7k8529Oryzz+kPjdgyYGLZJoZslxDXdWYzx2mZuK409xQwB
 XM8NCUWUNMuNS0QXAEE593gsy6PXgwgi/8jEkKzhExH2EsHD4dAHe9eYtZHdwZ2OiE5wUKGNPMN
 ZJQNs9NLukWNKuHLEm4nMmYm1Hy+gS9Vhu/8HU8HrX+wnM82gO/VcXF1qMzPvIXZLH5N3YGzu03
 KJ0hkQRxKV7xEpxLP5PfimY6CMYKvM4PPDrb9FmgYpYwyPKr2w1vRg9NrD/DR5roEIMm0sMT3gy
 nZVnGFLIwFd7lDg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 6a5d0c345aab..434ba8b055a4 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -363,7 +363,6 @@ struct platform_driver mtk_ethdr_driver = {
 	.remove_new	= mtk_ethdr_remove,
 	.driver		= {
 		.name	= "mediatek-disp-ethdr",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_ethdr_driver_dt_match,
 	},
 };

-- 
2.34.1



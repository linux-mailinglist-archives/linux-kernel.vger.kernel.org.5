Return-Path: <linux-kernel+bounces-125870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF64892D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C58C1C20DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF855C1A;
	Sat, 30 Mar 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ei+9Uv0f"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7ED54746
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831420; cv=none; b=iGbkpThPr1pqTjPEXFczTkzuqw8BYplDZfj5qvApYLG8vWGJzDJUENw5kVAUdGB1Cbe+oP21cvikeyzpvwqFalr5PWnZ21lrh9rHoQVQWCriY4OW7XKt+Pso0n1GQ4erg3zWbdzONUrZfCIns/VS+VHrzKtF9wpdRAd7xVXtNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831420; c=relaxed/simple;
	bh=v30/7g6LlGP3tVcCZHt2tO6SJcJFhbx0VZHT/xHvl3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxtqLaip5/5rDODqWFJ++icEHaRzkcAfkChbIqyxLovPNZ2OR0cj2i+pwS6LT9/s/+FMjXfLOtGYSYOjjQUc65zj2CNc0hrzk4XJ/0WL6/91VPUzMxK5wA2At5TxRdIXbGj8/k2jUAg9upyqWAbX9RKSbAL+hEvjdWFO4J2D2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ei+9Uv0f; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-341cf28dff6so2203242f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831416; x=1712436216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWJmDtW45HEJ3u7PqTsUPbyNK5NNAsCg2Vc2E8WL+CM=;
        b=ei+9Uv0f/DQAGRp9B87wfYla7k3Bu3haviO7tv4anZ1EJ1N/XAa4foVMWC4my7Clr1
         WZ/gjXT3WgkB98cBI9j7OK8jz0Kh1hyVDB6bcDpcEI6mpCUdYhiebwCZAl90W7yXjHq/
         K+55k8Nc5gCItdIU3HvxAq1IGAv4b1/sCt67aq62NHA7HqNmbazIkboUf2GWd3rsN/fN
         pfiEzE+HIBddyxsdJ8YjmEPLjEv7gxnpqcQTrLNxRh+nJzpfNotQOffkG18Y5xKJb+2R
         QD7Ai0Qg58rEjolw1FpDzb7vOCl12po4syyBGDBr6C0uKlvFPsHyy4RPiBkLbQgiX2o7
         mgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831416; x=1712436216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWJmDtW45HEJ3u7PqTsUPbyNK5NNAsCg2Vc2E8WL+CM=;
        b=w4DN2Cln5E/rWVUwGWVAuR4IM0abz145misojQTUKr020TBUMlqS4o3yLteK/h9wp3
         soksIo4Z9fRF8A0I2UEzn4oCYwsQmkUDpkUs99D6yRy8FfwDn4Ucq/DnsfLNeSnpp0sm
         hZ/XeuETm50BnXXZm4mkjTKRe8CHYJ4xSi/Kifq15Ilo2Y9FX53Qnq3QwXu56Do5JvpV
         a6fu+eaVi1LRWnFRvGVpnA+BJCms8ju1x6I6Tc+vxormnZXR5p2VbV871NBtj1xXRDrF
         5SF51RXJje3f84D+VqHE25DcDrFKlA8aiPWCN3wjmRvshz5G2dk2SaFwlAhvPDOlx3dv
         ZdYA==
X-Forwarded-Encrypted: i=1; AJvYcCUe2MOt4UP16f97KiCi1H/5JyCPYNMNnXlQK514Lx2jFp5sYn4qpTVNN1TaQzR6U8SLUEeRwwsQkqbF08YkrVBAJdA57iSOt0SU4wle
X-Gm-Message-State: AOJu0Yy5s22s/V2S9RJnvTAQhc17uKPhY8P87W7Iowy6Fy1tzOORkVGN
	CxNiCeM0Mbss6okihRO5rDrz/GIlSI6WZtB68/wx1BZXrTl0Dj10H4Axw5YYqzEbr+e9oajfLoi
	m
X-Google-Smtp-Source: AGHT+IG+hFfASnhq0/mKQq/p18W4G3oaCfPiHAHV8QkPFTQ+2T8akxT/w8IqahTgANQV4BXyYuOElQ==
X-Received: by 2002:a5d:5f8e:0:b0:33b:87fb:7106 with SMTP id dr14-20020a5d5f8e000000b0033b87fb7106mr4541576wrb.55.1711831416697;
        Sat, 30 Mar 2024 13:43:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:17 +0100
Subject: [PATCH 06/11] drm/mediatek: ovl: drop driver owner initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-6-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=v30/7g6LlGP3tVcCZHt2tO6SJcJFhbx0VZHT/xHvl3g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlpH/nOsD9iDkauUFajwnyggNRWK7nl4QHHO
 o9wKXLw0N+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5aQAKCRDBN2bmhouD
 10pyD/4gXiChI6eF/nqOH/ByxwmwE0S1I82agd65uR4+66SlR5/x8yjVJbZMPxbRVdKFW34oGWu
 7zQx78eDNJUdj46hPevBL9YyxLU0DDJBKIO3lGnBvA6qTdFSnZDgFll0udt/PYkxrspnFtHi4cF
 /a+Qzmbqq1EJ2+/28ISHGz1d4XAnQiSAgiz+4QKGonnvawsC4aU2349Sfy8Qz4tfCrceFDzGTCd
 BEOYpQIoFflOxMVHckm30bU2OYWEqgM/juyXtBSUu4pFXpTRUwg6Op3yVf5bP1Mdq5CWliPQ5EZ
 FdxhOs04zmesoB8zUgwCWtvsXPTHhpwUi83dPXcn7W9CQjFGoEvENiBIh4e6n3sdixZn918En+p
 ZM4YAh7nTJWmSY65NhgmyoQYR4J6F2asn8OAGcg5fsbbXr4nU5MiicXLdd52A7k4VQYOrtj7zH9
 6VuAr2NoToeiNKO7Hp66WYuTNrF8OwgAO5YheqWsZiNqcNXIfPwbNx/1AXFyOKz2LoKqDMMzfC5
 ujOy7SKcKH4vpeUd4362htI7DjffLSta+CzOpI8wPOneKTkqJONlmJUA6/nzgugyXzaEAkB+/nu
 Tolz6MHQRTuT5FaBr2Ehg55v/aDb6Nqtmn4G7QFoUgO3KimXRvOQ64eZfqFY6adVlfAcMBDSAyy
 W5TouLFV3wQn9Yw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 2bffe4245466..c754dcab716c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -659,7 +659,6 @@ struct platform_driver mtk_disp_ovl_driver = {
 	.remove_new	= mtk_disp_ovl_remove,
 	.driver		= {
 		.name	= "mediatek-disp-ovl",
-		.owner	= THIS_MODULE,
 		.of_match_table = mtk_disp_ovl_driver_dt_match,
 	},
 };

-- 
2.34.1



Return-Path: <linux-kernel+bounces-125869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD9892D49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04631F21EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9154F89;
	Sat, 30 Mar 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVFSjnHP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9FB53392
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831419; cv=none; b=l0g3iJH3YgblWWDw5ekiu3+eetU+ulH5IyegBRPiaSDU3rovaJytZBdKWe3qUaI9laYtFhNbevvVToQSqjd2PsqhXku7vtFArMHHJoaDpHC9wj4+3aj+CcO0Va+aFDNoh8hFtSoGBF6Bt/okkTNp+dN30/QvcUquH03lT5edshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831419; c=relaxed/simple;
	bh=b0EHgo2CSjStKtKnfeIekdpJQ/pX6wxzKF2lo+63Woo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=infLEMbkjjcLwg626/v897g6Vfs3DnokgpwxJVrz5n+GdASNEUNchUUfXgdGzAS6MWqM6G+T6qWFGCwwtNBCz3I4ZEXscDUzLkjeDoK2dTzSPWcDXBuqxU+3gQ5RXgofGv4rvN8OqlsrJSwnTyzwXR5rEh2KxjC7Sn/Xij0u+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVFSjnHP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1482588f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831415; x=1712436215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZMcyUqBR/k0OnBPZ/xItiFTsULknE/cvSgUpIGsEGs=;
        b=dVFSjnHPutImz4q+YkVVLRdp6g1tvh5OcUFB4kGs5n8c2lFmCW3SBby26rpfTuIrFJ
         sGtq9J54sWUIHa0G6bIddb2wooWUSzqC37HFUeKQDRn1jrym/RaGE2L2Gf9x2uoG7Ss0
         GJhQ4du3aqWLb7b2rLG0orKDjJfpYs0NT24JytdJixOTovkdSXQSGrPs5/mRcCLZ8w8m
         7JUhAuG9jB9Kjf56CykN1vItC8axVRCGQhDJKV7TxwI62jatrdd+ZNq7G35D52aXk0HA
         MUeWeF70G8vSmfd6rvwyEZkRwgLP+isEb4GNd4mA/PZfmSihBsg/o3HJfIDQD4qbBZ0p
         kl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831415; x=1712436215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZMcyUqBR/k0OnBPZ/xItiFTsULknE/cvSgUpIGsEGs=;
        b=NwLNzEiNmCCUiBNWuo8ZRhnd8cLeObuHLzj6ak1P0sikUYEJiqINBLdPFy6h2HshJL
         LgGXXHPx0/CFwOqi7Ro+6SXrCirc2JhP22ljshR2zMs3b4kYgHXzEGaT5yyQWzJ4Irg6
         08klOmqnj4EPhgzXIcKfPEuff92elSZ5rv+ab8aEJSAB9kd00zF/ApX047GZCPqyMmlQ
         te59JzWf8kRLND8WmvnhNouSLgU+JquT88TBqrX6xWK6mtmSnhL6XBj5hW8zdxr/+ofr
         WjpHOAyMj0IaNlPOaSG4mBSTZPbsx29/hTLMxKVcn8oaKteDd8DVHysskMeJhGERJHHs
         gwBA==
X-Forwarded-Encrypted: i=1; AJvYcCVoIqCiwSfJeSK9QpmadgWLucM1F4JqUdPqh0jo0nLii6sH29E9GGXcrsvlF5sHnHQnDKRcSl6O/5U8x+QBeaddgtSZ4dUBEKpGfuyD
X-Gm-Message-State: AOJu0YxJf46K+xQ39v2bT43NxJybEc3dZyLvJXab2d4Jvccc28vYeSnF
	NggnhNpIWo9EG3u6M+Ta/PIbvHNMVxNLvXnA/BsbSTAp8+6xzvKpmj9apQWMhvuNz0JODlUEeuc
	r
X-Google-Smtp-Source: AGHT+IFOPcibh7RcxYoE+yKeTFuJDxXx3Ni5EVSpl4ErQkQW6bt0OOu9CjiSEgZ50RNBf0gaqrtggA==
X-Received: by 2002:a5d:6d4c:0:b0:33e:aead:af07 with SMTP id k12-20020a5d6d4c000000b0033eaeadaf07mr7795224wri.27.1711831415254;
        Sat, 30 Mar 2024 13:43:35 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:16 +0100
Subject: [PATCH 05/11] drm/mediatek: merge: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-5-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=856;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=b0EHgo2CSjStKtKnfeIekdpJQ/pX6wxzKF2lo+63Woo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHloSNtO1tsRRuakSotnUeOaQAA9DlbxPKmI/
 yM6r0Xqsp+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5aAAKCRDBN2bmhouD
 10pCEACFpCtrkjDrwu9QOYzz5bM9bqeh0KBhf+W1dALn5Ht/30IX/W+7jJvPORKHVniuYO33gGT
 a7BwIHK09dyu7aOdYL5bUGjXT4g6KqG39elMjWNnqKcBNMftmpStHOk9Fd3RXhJKhUiHnl7qKjW
 511LU+UBWbypp6yYmFowuMaGHjJZnnUJWyevgX3qZAGy7iED9B/Ce+tRZ1U+mLehS0b5D0rD8Ls
 81mmBqjGtGBHpLZoFERou1ioCvQNFpCWqoKkmC0PnPwyj7EtUguiOd68josP26+PBWX20XczeTS
 3fwqoktAmFp06fxQ/J+3o18p4s2m34/y+8pH5AAfdi+TIkkUyg7VNaAqyvYM4wjx2+YiVXpKoUO
 9FTLgL+Lai5oQkbncV57uYm1vLUBBAavV7gWqkv10p0HkRahzhsOKaETxQ9y/q0nqU4QyZNCbjK
 VR4CLTcWom7HtOI9y5Bv3GPsndZupDz0Z5iivrwgAFiDLvpkgfgjvWKA2j6+AdZDXojZDGYaJxC
 jeztkiDPkfw0L9you3OfEQWVpU8tqLaAu8Dso14Xzg2B833AJUVMP28JGe3iGFc9laMGGtVtEoQ
 lM4DOMK3NNL0zRkr1XImXb6UOqS0y5YupA6yln9qjW0llyaFneRfnkiG/OgKA5n6yJiT+ck4T71
 dEE+TSySv/rG3Lg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index 32a29924bd54..a04f76dbef73 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -376,7 +376,6 @@ struct platform_driver mtk_disp_merge_driver = {
 	.remove_new = mtk_disp_merge_remove,
 	.driver = {
 		.name = "mediatek-disp-merge",
-		.owner = THIS_MODULE,
 		.of_match_table = mtk_disp_merge_driver_dt_match,
 	},
 };

-- 
2.34.1



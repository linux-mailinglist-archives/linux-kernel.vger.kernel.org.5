Return-Path: <linux-kernel+bounces-125874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04850892D4E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836691F21EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843554A99C;
	Sat, 30 Mar 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJQGIlNg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA8657303
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831426; cv=none; b=RDbbvRXJzRvUZWLAm5yOonuKgbK+uN/3pYYaTP3QJC46yJs7hTJn+Wf51Q2a1Hg3hJY1RuwZ9scVzZ1bYl1Fjn3F5M0eq1jKlpX+iMMZfCcQP9P5WEgJ7ngWqJjy5b95xhwXNYB+gMdT6n/nMg6cPfbb3PKgzWrWKi1ohk4nu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831426; c=relaxed/simple;
	bh=rma3zTFbs+wEApKyePcrne7HCkkuvoEKS0IhtWThFuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F74vyIJ48tfNW2E5UY/XASNU4P2Tn564uR8mdlnPwgo/lHpITboh5TG78c2LodLTrFjpEAotfrWYA7fdHEp9gFgvzXnUsSlk0xRFWMg+iND5datIfWa0Q+7AGy5GAxWsEoDe5Vzzv29PHUiIQZ50O42QfT80bTDfsccSHWl+buw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJQGIlNg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3417a3151c5so1940746f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831423; x=1712436223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE55+oHy1SdFZMDti49ppLTo/iHekalp6UeR7soZNdc=;
        b=uJQGIlNgseo/AbWAzO1dIBqEOvAuMpTeFk666F+4vfRvYBf04IpOfh9Exd8kTBvl/y
         9SlgQul0gpBVAsDzOwTdQjDbpyprg7WxRIqHWNCBFTorYy0dyQM1jhCRPxUpGsOcojLL
         NGWXgZWuUEj2ppmZQarTrEBfXS4W/CItLTAbLrjjpCvg9mQPWm3FQEDducdEl5m1DAKW
         vPmqh4qExL93Hnuc3zezg12aOQToA71eLFCCdbPZY86iqYhA2Rb2XY6JywVWNCjfDWmu
         ZwBejRyZsV0nPs7RKGYqIsfHtB5CuPr1jYeD7PzPnVNaEst+3faJDur7CgdvgQnO4Kwv
         OVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831423; x=1712436223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE55+oHy1SdFZMDti49ppLTo/iHekalp6UeR7soZNdc=;
        b=kC0ymqFrKW4DmzCN72rAveXZQOEN5FuJxSpeLyPz3GStRy03JhkVVZJaKM3g8hGS2k
         A5iS1nqcxPiJFRPGuURM//Tj4fH5ZUL6GKY4L47Mx5x3lcdoJY0tOStGBq5wfw5oCars
         1TWaxD0iaiisrk5oM5AckyyB8O8LV/uUEkhrnYcP4HGhimeDcXKPRRYjPA0b6L25UlN7
         v7CYG1njZiohTeHcgKJynHLZEn8jTy+k/EtUEi4LLe8qwPnAjYL17tTiem8NxoV6We/u
         Q5iUMR4mXz1cgfJxRcvF4ESgSKu2ACm5yuPbilJIGOXWmTrazcoUzmFIPCnNdSlq6deU
         ylqA==
X-Forwarded-Encrypted: i=1; AJvYcCXHfndiOtNeyHn3I1OLjl7VWuwOdEjRNFqHRN8laty8MUabBIyaEEET3K17oAOiQ4sTcICjDVmFMz8gSARgo6GqDiUZIyufOGW/AhSN
X-Gm-Message-State: AOJu0Yxc7o9dzla7+m2HTVFV33ktahWz828uv+Wlvy00f0RTyqzWgdHS
	WCzy0cufsP3Uo6jVE7WUxVESybejC+xYM6nlExdLBXwKORwQRN0yhUbTSNn6z3k2gHrHGqj/1b0
	Q
X-Google-Smtp-Source: AGHT+IGhj6aUvEDGcPyq+BIjFVcHMWr4SCkwY++xRHGQ99myAD65Sbm7IyItf+0BA4rNbjIYqK9HxA==
X-Received: by 2002:a5d:526d:0:b0:343:3ede:c166 with SMTP id l13-20020a5d526d000000b003433edec166mr2587207wrc.68.1711831423068;
        Sat, 30 Mar 2024 13:43:43 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d4a8c000000b0033e7b05edf3sm7231299wrq.44.2024.03.30.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:43:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Mar 2024 21:43:21 +0100
Subject: [PATCH 10/11] drm/mediatek: mdp_rdma: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-b4-module-owner-drm-mediatek-v1-10-fd5c4b8d633e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rma3zTFbs+wEApKyePcrne7HCkkuvoEKS0IhtWThFuA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCHlsrCBkLAni5OwOGut1qOb6HE9LI4wMpnfhf
 n1aFWutFbiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgh5bAAKCRDBN2bmhouD
 18TRD/4hW6BmN4P/LbhIRVJSb1k9TFXOIB9cs6FIcrKfP12OOg96bu9RGCDfqrgclJKkoX37g6a
 L9PgCn4kK+nn0LNe36FCIyVvSuEcjJN9+L8BKV4//9XSt2e51YTTAOftpHQiSmCZIqthA04LBlc
 AC0gnGoXRcbX3fcdFkDgX6hFf6ToGnJoRu6/X4PyBokuQQ8BR+Ur7uZam2g4en+JI/+7IfgMC1d
 k6yLqsyKDM88+tu3blzU62agRcLDQPd5grNTqJuucWoZst5v9o1yITxlmCGUiNjks5psg/+9d2V
 QV/tG0gWaqr88RwaN6qOg+vH3uaZNIJMs3PtxnwJXDsXeBTmOornUfpNoex/3dWoXvjvZKZLLk0
 Hue2CNIzFX+YU72PMe3ISgRSb/IOl6Lcu0olEd0sHM/LOLM9kPAdXXwtFq19NBm+wGRZYlVDODp
 CcvzB6XhOHLs1favpokkW40O8N65NbEoElIHQcLVdNkdHglONyHACxOBTOjuB/1/ngkKDuji04h
 Uymh1ShYQZme+rKTAAPwB1fR7C7ngwGJSPo0hFr2z8tGWoQ+XK0sBiXPdJe8AnhkX9QvYEgoNdx
 qbJ8kojb6R3jVRU6pNebLl/QZn92wtkY/TvwuQFFjVmWgfj84VPb0dKfvozoOeHomg/XMHSqhiJ
 UB1nDx7vuAY2Q6g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index ee9ce9b6d078..925cbb7471ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -346,7 +346,6 @@ struct platform_driver mtk_mdp_rdma_driver = {
 	.remove_new = mtk_mdp_rdma_remove,
 	.driver = {
 		.name = "mediatek-mdp-rdma",
-		.owner = THIS_MODULE,
 		.of_match_table = mtk_mdp_rdma_driver_dt_match,
 	},
 };

-- 
2.34.1



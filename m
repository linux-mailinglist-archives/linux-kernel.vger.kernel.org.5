Return-Path: <linux-kernel+bounces-78110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E59860F08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319321C23A67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169715D735;
	Fri, 23 Feb 2024 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEApyRhe"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27675D490;
	Fri, 23 Feb 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683443; cv=none; b=H6aTdF5dcrDslkwlSKcz6zrCqmhDWN6SjdFT6cfblQuf0by4shZrecBWnSTpKlAFxXXxabsNIBHEBACxp1nW/bZI19hFLJrPNl1rZnUy1OHUunlwndsUJz6WjIs8lrG/KJQbeV7D5AdvoJxOU0eQYv5wzQ0jYkGfMCasSaa6E/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683443; c=relaxed/simple;
	bh=dHr9Q6AK8e1ReScKhI+4HGEeOhl5Ub1OKxN596mIEOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU595t44f463X6lR/8LeXwdOcwUJ+5zgC+ERmUqBpxB9nNt++nw0TvV5mLODuYv2CaS6T2BDjthS/B84Ssa2KMH6Q72Rwae4wlHb7lkmCVTXb0S2t5yEU1ADW5t6NKuxbDsS7jNoO/sVbmU6wON+PGGbOwI4mKGE9Jqfd8Wi2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEApyRhe; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so182552a12.1;
        Fri, 23 Feb 2024 02:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708683440; x=1709288240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcJb7bj0vF5Nl8yAX54/kA3qijtSrrqL2OLIzgs28DQ=;
        b=DEApyRheoO4vWS9arExSp7SgJSOTHYCz/CfACwUCQ3GZTiY5lsk8P1shirZWBODFfl
         6D0wodq0JMNJjZQ9GoH7+fVUN4G8sQeDcy8R//vagEsOBth9aoT9XHVAk32FzfoECY5m
         MOGhNl5HlFuLwlaiTTsnwc89nXgG4FG5CKP5n+JY9VIB+t/REu3JdkeJFXAiiLIaXseV
         RxQPaWysoIt5FYUCHALdRVvzDm+AzipqjXpHG42PhMfrEmXjKoIPq0EvJIswaie02LtG
         wDMty6lnO2Ij8YpRZUc1YQBMjzUvb3XqqEE1OtEHakd/JL0hM/RWzV4MQREEoFJzAYIr
         AHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708683440; x=1709288240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcJb7bj0vF5Nl8yAX54/kA3qijtSrrqL2OLIzgs28DQ=;
        b=JegZmzrw5Em5kFVuQd4jgkSs/4L/hPLtMPhzVlqjY5z6uNfFk0Jl3GzMTM9i4ZZDAI
         WYPaJI71ARn9NL9tJemUkbt/AuujMlTrtwektmP+MNZKfZEY3CgiPzub1XtOlLn9+vIW
         KQnW6r4a7AHBmGx/4cx8onNsCFyLNHfRDW7fj//0t2yRdsvnv+sR/rNxsopfQ0TbAUnC
         MJf01HqOb6iMSxSTAcA29pa7l4JJoN6cdF/hLK1J/i5ln/rOY3wra9nG81vbgelXCpmQ
         PPUyVLqk2RO07zwzi/YxXm68FbFzOueBfJML54d6wY9pAY8lewHf79mMjfS3Hq9Cgy4J
         bKDw==
X-Forwarded-Encrypted: i=1; AJvYcCXV60YxqWPbH0OZCZ0PUuUV0n/6wJnMjDDtgPGWZ1qtKFgV7+JrCHWkUmm5fl24BC7hp0AgyYBYt0OplpGa9UxpFcWeLEMZDCAmdQyVscgJwb2Fnwvt5zm24KufVNx7b/+87+8uTSz5Rw==
X-Gm-Message-State: AOJu0YwIhKC+GucziWN+frvokXErcmmMruKAiiTeWVSkJOxNsYLGWeCJ
	rhKOJSh0YxCOAUKfjtot1zj39CEJaTpDtxbaq72KZKWkrxdtp7di
X-Google-Smtp-Source: AGHT+IHvc1n+NKsk0Q17ghSiWK9ZF9+++tMXf6cANj0kAxJYepzSwkzporeZs5WUL6Npv0oRXc/ejg==
X-Received: by 2002:a17:906:b2d7:b0:a40:bff7:6e74 with SMTP id cf23-20020a170906b2d700b00a40bff76e74mr261771ejb.2.1708683439798;
        Fri, 23 Feb 2024 02:17:19 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a3d99dc3f3asm6667250ejc.67.2024.02.23.02.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:17:19 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 2/4] dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
Date: Fri, 23 Feb 2024 11:17:07 +0100
Message-Id: <20240223101709.30072-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240223101709.30072-1-zajec5@gmail.com>
References: <20240223101709.30072-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..1cf47db94c57 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -85,6 +85,7 @@ properties:
           - const: mediatek,mt7629
       - items:
           - enum:
+              - cudy,wr3000-v1
               - xiaomi,ax3000t
           - const: mediatek,mt7981b
       - items:
-- 
2.35.3



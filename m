Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DBC7D39B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjJWOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjJWOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3FF1727
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77784edc2edso215533285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072046; x=1698676846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXrQ0v5fD2lZpUHoVr89BN0KsiA1JdGijnakOGhbvJo=;
        b=ikL9dK2WSR7HXOo8i04hhl7jTb7v0kl0vkrN3nbZzuE9u4lgVRMx6i3WrzyEfeYttg
         KFr9AJPJXeH2lRl6Yyg6vKlFgdH9wkNm83KIWtCIaIvDEO/Cu8cRDONEskKYS9ShV18L
         eKm8qJ3pfRcSo3FfMKLftCrCEvGH6vd+BiGC8MyIO3Cq3y9sEzjHemj8z7H3WZZSJABY
         +98jHt6wh5+VahMEhWUXGT0KVMfbBzCH95DftkSvQRRcWho+XI9ICNZhndj/YQ7oN5pZ
         wMLgkk9uyjBga1EVkwYKZAHoBeXHIgg6Mm6Q6KKWXNwjsJhmY2Zw5PhtATAFnFPIKbP5
         4mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072046; x=1698676846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXrQ0v5fD2lZpUHoVr89BN0KsiA1JdGijnakOGhbvJo=;
        b=b1tAc17a9jfDBakVUFp815rUGGNncJA7+L0PFAoh+vt2uTTtUdo/OfZf+mAHg4BO3o
         aSLa16Xdpx7uCNlLPb3sBTfWycFUqPjh7DNeff82ZkuwxIvcFmMLMBUJx5jXlGmf24B8
         4Oz67p5PdDMzmug/hmmd5Jro8/vgKgouCSrUPQSsi3nSexFQLIX/JVF6ViluTFhNqfrp
         GQghvdzFA9ZHREjYFv9sl1su9kwvAiG9C15EamYoxxVYrNPnX/R1fGGYwVv1NftSWSVT
         kGTZoeoTGhR5xBDTcQjcGHasBamTYBsiyq3Yog3uvp/17NplhbU4YX06Ba4/exTwCggU
         xidQ==
X-Gm-Message-State: AOJu0YzWxxf2IPz2ASS6mrIdhq5P1Gr6YVpg39RgYS+QiIZ+kEny6yMn
        zz0CF8B3esEzH8ZrXOD3JjCoGg==
X-Google-Smtp-Source: AGHT+IEkEU6nuvyYg1bDt8UbuCs4r9wvONRIxcXy7le7F3scWSafhsyS4RhIdhies0FoEz8LuDnOPg==
X-Received: by 2002:a05:620a:27cc:b0:778:5736:6573 with SMTP id i12-20020a05620a27cc00b0077857366573mr10157809qkp.31.1698072046662;
        Mon, 23 Oct 2023 07:40:46 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:46 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:08 +0200
Subject: [PATCH 08/18] dt-bindings: display: mediatek: gamma: add binding
 for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-8-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=hW7CMZcG0C+Hg+3PvnUAIZENabLnRa3N/UE7I5J44y0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPEQMUcJaJNgJr3/lL5DFQPL4QTvWap+9SYsL7
 GBQJdOeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURZZmD/
 9N3k86URyJUUC2IPzR/C/E06OuIfEdO/WWkaFc6N2660KaCRzYBuOxzm+5WTjHcQH12qnokpsIan4i
 UbvSoS49lwSoAdA2lOMAHUQG2iVnSiLZkIk4DQVuCWR3KKKaiT4axb+gIwNgwudahNgnGjlRGJBSb4
 idDjG/7kpcFUaMobATpLY1cJpvjquWo/J1ItJLvO/I+FX0lbJlysMwJrjWFh5UoEa/JoTrX8jqpAsR
 PVFdrFMFsVckUZ9k40MwwZ6el2829PmGPymCSz9qXhT/9p1LexRpMD6oAO0KlS/wC7kDG3QMYfZIQN
 36jlHWwE4lMDOvMt8LE5Z8Epo2fASlTYIHFnxyaupk4DEl0upHREnx0nHOiO1ap6gH1QIfqRtvIeZ5
 /FO9tZXHFCRFHMvP0I0yBvszwaQFhOdxmzYyJyiDeQYo2j7L8mHDKWse2DLb/DnOgiBAK9BW4g/9Al
 1tRFHGgS5gnGldzq34E/8Fs2IT9IAarAAKISEteu1g8y583FKR6RYttn7ci7aELb3rENNaGqqXtqO6
 3XO7jIXtZ92IzbpuH0Dqyl73qBqBIrwSXDRpsA1RNJnM9XRWYA438HTXoWRULyjPksmURYnOplrAz8
 N1RKi8Sr7TAccueYnMTnO66rtxOgPGthiJUujC/+V1TToV7cGvIyKKZ7c8lw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display GAMMA for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
index c6641acd75d6..f447f4320e8b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt8188-disp-gamma
               - mediatek,mt8192-disp-gamma
               - mediatek,mt8195-disp-gamma
+              - mediatek,mt8365-disp-gamma
           - const: mediatek,mt8183-disp-gamma
 
   reg:

-- 
2.25.1


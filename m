Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792D7D399B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjJWOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjJWOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631710C8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7789cc5c8ccso277401985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072029; x=1698676829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxTXywbu9otyoHiH2LyJKtB0YMAbr6Ld4vLKRXgmSv0=;
        b=xfg4dcqQZKrVoEovKigEX0vSQpYbKs7ra6/Uf1CkwjEkcoJ2oAxWnCYzAeodvmWrYB
         SN5u1D2OtuGYoEelqMZ6rmCQaJGlNsT9zEGY2ADYgTSRrhBqVHqIPFFG8JrJM/rMWswl
         dmLis0vvXtnVS9VwPsZ9jTuGfWHHGaRLG6rjZfCkAyI+qr+Q3nSMFgQpv1fnLXkdYtBE
         jwNc4wo72K4866qSzlUkObzfrq4KTpFAS9ozEiEdZybRT9BTwrmDoDuqhin8BPm6K0Cz
         XwOHRUE+ncI3tmFVdoJy38A8AKG6b11HQgs7vexjbuWAkvnHwOrzsLDk42l9g46h1mV8
         vvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072029; x=1698676829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxTXywbu9otyoHiH2LyJKtB0YMAbr6Ld4vLKRXgmSv0=;
        b=FldMJCYZTdlVPN7X7yr/1IXctsnkTdP26Lo+F8Ep0KSdxeDgWXzQcY+EW+2rMvq7Hu
         5OEAVRI/A1ZklHqSyT8/Tq2InMwlEko81UkrS6FP728paUaxESiX3+UGZU9nmyG+VFry
         PDjRXHDy+xhRk4hZrFqTLiKCXu3tcp9WJy0cadt950Ak5RTsLK8lVhD6IDuQ11nrP4jt
         9jCYXduksq2GBNOF/jdlR/BYB8Vi03RLrWkTbewUdDc+8iwO+rhU+SnM+z1zCJH6iWk5
         AeL4D1qL7Vhl6xk1VZuNim5r3F6G7UA3Kp3DcVxDGdELfJY1POLim2ruj6if3jdeM8AU
         7wxw==
X-Gm-Message-State: AOJu0Yyw7GpMRoTLfi5PPggN5wAmXCluBEq+kiNO5wg+XS/N3lg1W/yt
        LN0HUxQpS2fQzGxqatP1pSOc5g==
X-Google-Smtp-Source: AGHT+IEgDRtfc3NNADXRb/ZlUHXnY2jqVnmdnhhEIJ55dIpMP6Yd7xxuXciomAvhvv7MbNCOmoiiqg==
X-Received: by 2002:a05:620a:25d2:b0:774:2470:6797 with SMTP id y18-20020a05620a25d200b0077424706797mr12666017qko.21.1698072029091;
        Mon, 23 Oct 2023 07:40:29 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:28 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:03 +0200
Subject: [PATCH 03/18] dt-bindings: display: mediatek: color: add binding
 for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-3-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=YU1e5sIok1+NbWY+6HobM33V2no6aYQT7i5d9DqejUU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXOX/azDl+ertxlsp4unLNJxzKKT9zEjAR6PtwW
 hAs1qQmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzgAKCRArRkmdfjHURRc1EA
 CyDaIaIfkyDDyAVVQwiAwHwJfYWVP8v6IFzEHshzqijzeYNEzhU5kywjLlaKyoNWzwS5QwYGw4ydP0
 rGGtLrS0sTHSrcZk5hPSOItdc3deukZxSxsBNw2L6QidCWnsCRMwK3R6wWpajt2AKap0WgUZXz8H2V
 XQ7YFHDkgZAEbK/ydrb0ywq4K/agzoHG190lbBvBUm4LHMTLWbA3zf0lermqAUExlOrVuT4c7k1ive
 SuJelX66K7WkPjqZj/WsxOUSrxhid8P6q2DoHoZC9cU4oaN8JqwnZzUtI0kVhggWylulFlyCiIyQ4S
 Uq13CkltChuXB7zrdWTYNZ3oKXWfUtf09TYzn+aD4KEszGS4CCBkx/Kx1PEurAZEWDOcECD8+ru40w
 rQG+Vh1XazpuQ/v4ItapdZssXcsXx9gGuFfps/Ag8tZhLHBtlKQS2YkmckrhVefSbXhkRwgbvMAJS1
 6DNHYYjAKvEqeTTsV3ECPQCeYrO6w2b8WxCc3gVkkLNdavoY+d3Fq90pgpV+XxIyul6+1/aNJDhn9o
 nEpRrs9plK+W/0nyUwkrWlbVBppj2gon9XQm+rRZ9iiz47Srd4Io3ZVSnBOh1ebM3iqcBG8Xd+Lb3z
 GCialIyQYoWGFpw0U96qCACTy26PC2yItVewLkUg/dDXskEGrmlymiViqVng==
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

Display Color for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index f21e44092043..fbf15242af52 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -39,6 +39,7 @@ properties:
               - mediatek,mt8188-disp-color
               - mediatek,mt8192-disp-color
               - mediatek,mt8195-disp-color
+              - mediatek,mt8365-disp-color
           - const: mediatek,mt8173-disp-color
   reg:
     maxItems: 1

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D07D3997
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjJWOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjJWOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:29 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F909D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d0760cd20so28042526d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072025; x=1698676825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2d8tTfPryf4AKFcvtoM/0h2MGK4CVeevmA8lDq1t/g=;
        b=velXhDnZwnAmZlbf3KrZo9g/UJqPbEiTgPQbwE/bQ7TKq98JdzWMX2Hn4lGOEgaI9w
         +npAuea2FHoMRe0eu3s1v7mrpZ/EIZRtDNuB0GlOLPQUFHqAZy56NSlVfVjhH3S5fCzT
         EuoTBVqmrt95jBeVaL+2DYjqme04AfZVnxD0Xz7/u/M6tVAroQ/C58ERH3uCQEyPqjDF
         1cWC8K5QtU1Kdikc/2IiCR8OjS3GjebIUFzkeXFfzjXHR5MO/F9h0XMpH9gKBas6hOma
         /69OgGsG5z9d1jqpl5nsoeTvBD6jdmCCS1NSnIhlMMPOaApnaWjxIEJiYv+w4oCBAvn3
         X6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072025; x=1698676825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2d8tTfPryf4AKFcvtoM/0h2MGK4CVeevmA8lDq1t/g=;
        b=wap9SFNMx0AANX3yc2F7ElCw5CD6MXGkeMHEyPQP3kmOa7N7NIZJS4qkRToN3J28LT
         7TkZw7nR4R5Kcnh2aU/lp5HSyqhRC8hr4V7wZri2UPInP3VOs9u91Tirja/NXzGgF1Rm
         UzLUNuP8S9RcsRkgtWHa1u6FoX0k16YwLIpyZpOoESUCkKOqURfn+liLZAj9YL4fcIyx
         gt8HnhMhOLf6uNp2TdbeZJWZrgd3BZIg6MByCDwIW+ThuER8IozuNTcak6kJbemGfD0a
         arvSUrOq2n28bPLoFv5y60fOQpulRaavnVAZbNLyeQ5rzfa57wboUZta7FqNYD0EyRPU
         hCoQ==
X-Gm-Message-State: AOJu0YwBS8lYkTGTbObadRGtrBGqjHvrKae7ckmy8vj1Od6/xXsebK+x
        4Hb+7JR373KOcT0eHt+u2d1jgA==
X-Google-Smtp-Source: AGHT+IHYknGzIGWpZ0MnxMFj1HRLj9OGQkiXiBAhAeZ95cF7ut0X8xJi+rv2oEbieuv/EeZZSuR9Bw==
X-Received: by 2002:ad4:4d43:0:b0:656:500e:7b64 with SMTP id m3-20020ad44d43000000b00656500e7b64mr16687358qvm.16.1698072025639;
        Mon, 23 Oct 2023 07:40:25 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:25 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:02 +0200
Subject: [PATCH 02/18] dt-bindings: display: mediatek: ccorr: add binding
 for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-2-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=JeNqW+WVxqqJtX+9p7tMLNbwoCk4n1DQyFj303zeDpE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXOHe+hbAHJDiOZ+OVrpp+ogl+pb7Lr4y+qX804
 OlABC7GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzgAKCRArRkmdfjHURc2gEA
 DFJ7bqOoha+846mBbXiyiSz8SjEv8vWq1uEyYeVmfWi3sxNfPvY88KKVK7KzsjG1iTOx2+0Kxn7leo
 DOIAZgnV2ZNoPSq6euB3iS86wajZsW+Vqe7IUem0PaHmzDl5JptkYOnFzuuIS0ABQ/ngG0ps1lkYtS
 Ku0Coa2KbBAmY6K2/XZ1O6P2AT3AqD5te9dsIbX1F0UJButVt/QxtIy4Iu8OelRfrJJbJUJkt6CJPB
 Xw0YSXE3JTv0zxGTiV+7gKGRSXBmCst2FmRFQnxUanUhBfB0ouROeDsJ+FAOENbfhfiRVn7Xfbfkc4
 HtR/EOX7cSm75MblTuT956tp2Kc6ikETj7dUmuQXOGCrg4NDtSMJZCTvZ29mCRjbtoZAZ4Te9H2m0t
 y7inJcqCfOcr2TO4IFx6TaEF/Ut5PZkYBuVspi005Cf8RyWovpNcA2LwTViTn14qQ09Z9X6MaRqbDc
 7MU5GLr/L+fTsk6gNYWEp027LKetYZpar7qX4imTJJD8a3DDGtW/5DMJN3W1DxzhBAOP/Yzi+kuv0P
 xd2f31lSLvE5rKq4BcX//75+rMyXe1AOrB1iA0StQrLWHNcao0QUVTtFeVzHAPUGBAMOrj/4bfaBCJ
 SPVxVC9f9mMG4h9P0XbJD5KniE3CaSL9W8jimZ23Xjz5kgf1ynbthPIpuZ+g==
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

Display Color Correction for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 8c2a737237f2..9f8366763831 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -24,6 +24,9 @@ properties:
       - enum:
           - mediatek,mt8183-disp-ccorr
           - mediatek,mt8192-disp-ccorr
+      - items:
+          - const: mediatek,mt8365-disp-ccorr
+          - const: mediatek,mt8183-disp-ccorr
       - items:
           - enum:
               - mediatek,mt8186-disp-ccorr

-- 
2.25.1


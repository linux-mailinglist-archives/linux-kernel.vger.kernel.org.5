Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257A7D39CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjJWOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjJWOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:07 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63819B2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778711ee748so267587385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072053; x=1698676853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CS7+tyIUs9rfVOlSsQt+PukwNB/K7NB7wUW73q4tlEs=;
        b=EWQA+X6fR+AbDfrB0rjpo4CM6Ga9UqhaFGoQOOnegbAc68M6ifNp0l6QccOTWSPHXD
         APQo1Wj8lfit7UVfifk8SkOiy9uuu3owOIKd6hME9ykKWipJa+j+eT16VCi3nv4tTg4Y
         YC6YV2jeE5JNBO7y7IPB1SBs8JFSQRrEEcyHq4aewZ2pdF9CO6EkimGE2BC4AWFn1YSr
         kQwrAPdJnnBHopeW0TLzmqdnHK+GeAMF2yLjMiWYPj4GxCXsI6gUNcEE5aB0BEY3SMrg
         x852Uqax/F9TNHg/DARSDQeQodUHtyQ8qYk0TOi4pTnsHPf505idSGFiTSXk4fYqNm29
         Y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072053; x=1698676853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CS7+tyIUs9rfVOlSsQt+PukwNB/K7NB7wUW73q4tlEs=;
        b=dAdlTGD1ba03RTRGLxa6jeWtDweCp7zjTvXYUSRfscXn7CnZwYv0VdLRY1zwQp8BKC
         fPly17rbn1w8xu7Yv6m/VuxZTv+JeZfUNvOHNEEtNw/UubYjhnR8YKVyCI0Rg14YP+RS
         VXReclGwKZXY2EgUrj/lcb2ytT93bMa/ZuOgGGtuUy+77eOk2SpU+6m/kZ/OGoqj14RE
         VvftFWEQYjDYXp5SQZFr6Z7v2Ts7AXxAF2mcNATBVJ3FH1MvvceJd1OENn58HNo9aQMX
         YgGOM+ioZfjyMCQBCPmpkRDWirXIJpSzMy/tbyoa1K1t8XD7SsvVl8u+CRxozHjcSY6g
         0aOg==
X-Gm-Message-State: AOJu0YwpKESlLIn31eastmWPz1945D22MXR/DVGPfV4moYsYPkvOVlTN
        QfW7sbVj6AILMo4zIeJ4+Nl/sg==
X-Google-Smtp-Source: AGHT+IEvoOYM4IjzQAb2DwZjFpHa6AfgFG/jeaxPD3Y8glmdNz/IF1lkLRc91XrRLdKpqXSeUPXi+w==
X-Received: by 2002:a05:620a:c4f:b0:775:687f:4c2b with SMTP id u15-20020a05620a0c4f00b00775687f4c2bmr10463449qki.44.1698072053532;
        Mon, 23 Oct 2023 07:40:53 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:10 +0200
Subject: [PATCH 10/18] dt-bindings: display: mediatek: rdma: add binding
 for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-10-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=JdRv1/SmSo/E5fP2RWWWzxwGKldluGDuZKeVPiQK0pQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPSxJ3NhBHAKqvJAyKpooI3Iy3NY5MCOPzNpgw
 m7QS6s+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURSPAEA
 CBHQlY624f0VJRltvATnFGmjv22cWRywnPXucDp/TEpmb0jC0gsoFqnxgzsOLXejQsq4OSA91OHScS
 29zmAuA00ddrwvCJYH9yBOfo4yiCAaBzucnvMXmOx/etDsUZ9OCAmtzQBsMokpK9LJtKb2UpIqbx2K
 nhlPBCa20wL06o1wbNRiK0EKbiAn7bougYHXdXXoiq8lzADg02mQKneQU+FyZ+vXCSedF3N6ciaA2L
 mlCiGR34sx0+LYduMKroR0FzoFe20wiZiphLziI7qjIyP6mFssUXfcouZnEyUO7pivdOAZRjA4ns+C
 W0L2ZERj7YswDoENOrxebw3heXOVEZWoCU27S+PyIrO/v87mRjLF/QlKQX6EKkbOHAZeL619gS7CST
 VTccb+HoMWt+EU2hQfWm1NmZxzCU27HJVGlDmk0Vp8z8wX2maCXxNmRQ1wdFidRbsgxGiweTVOE5D3
 eyKBxQ2ZKykMWFafl8th3J0U2IaVT0aNNa2xp2/avLOvC+0aVVlgCmFHpZierzyrO2j5KIfo6PM8AW
 johWF/+kOjLPdM6SXScvILReKIrun7Y3xka+Msd4ckpalB/sJUTOym3TeXoVDT+8OGnh37ys8R/oVC
 KcJyWNeiJqeotDGEL0WE0eFDygyQCZYg6+6DFW0ZouePIP3e5d7Z1QK9+KqA==
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

Display Data Path Read DMA for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 39dbb5c8bcf8..4cadb245d028 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -45,6 +45,7 @@ properties:
           - enum:
               - mediatek,mt8186-disp-rdma
               - mediatek,mt8192-disp-rdma
+              - mediatek,mt8365-disp-rdma
           - const: mediatek,mt8183-disp-rdma
 
   reg:

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC47D39A2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJWOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjJWOkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D510E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-778940531dbso209178685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072036; x=1698676836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHlKinnyvGcWLyX/UpwiSi0uqGe6vbSuDhHVYP6fxiQ=;
        b=fC6Y/+SebrdyEuuC3jLT/ZpbED6NfyvqVidN/TzwBNafxRB5yAmIGZDVt7q4pQzUH0
         paLe+Tic9vhivjmhw30FbHVIAP+tp+sGn9epPxmFIGJH1Vp9+WiFR20b1Sf+Eyz6Qq6J
         OuERdp3d0+Y8nPfZqiLANsE9dSwTk8sEDwX0sFbxYqqW5qe+S2WlIp2LT+ld+YbpOzDi
         2yNvQ3XtBsfJ2txzxRe1cr9XY2BCNJ+lidXdZo6KTjIRVDkhm8J9w3tO1NkTiN2kM08n
         3OXIMCmAfzbFfdJYZoKGXZjTld1XkWrRqqo7OCyekH38hxqq446w6mWBOUOydt+wGh7a
         umDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072036; x=1698676836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHlKinnyvGcWLyX/UpwiSi0uqGe6vbSuDhHVYP6fxiQ=;
        b=P5uG7wJIyLlexEq62j2QKhoR/wML0B+fkR3M/EU2ZNAKfupzg7u6kvt8PImzpBRz9U
         0kUYBgzQYlKnH2rVWEGs7CYZFC+rDGycYDIjsSh0/DwaFoaL4OK4qfmUQ6L4wFFiupof
         9y0J1bIJ3As6spD7nejsCwSqE+UaKxLxf6KKt5acBAxDFDczOVXQgkkcWxh6g3FHlT9S
         BZ09rgV5cZZcT87m85EmE9fdMo68ZLuHpqDKC3gEke5uLAutjDSlBL/o2NRzVo2MxDtk
         l5MZSBRoxOHWnhr1FfeOCzGkrNaCqcu3hbNK8P7KbsknPWRPOOkofxiTP50oQFOHY6Hz
         af9w==
X-Gm-Message-State: AOJu0YyeQFQ7defGs3ah2trocxRlDM2q+DPJZpvunTMQJQ6mgchN9pxN
        uLwbJLCanXwffBON99ZMP8ICSw==
X-Google-Smtp-Source: AGHT+IEiBk1UARjKqcmuU2E5mciS/+khU+Ezo/QX4nadgM/Ncz49UAdPF0+0FFE8lX/iNwYnZl5nXQ==
X-Received: by 2002:ae9:e912:0:b0:774:3235:4e6d with SMTP id x18-20020ae9e912000000b0077432354e6dmr8721774qkf.21.1698072035914;
        Mon, 23 Oct 2023 07:40:35 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:05 +0200
Subject: [PATCH 05/18] dt-bindings: display: mediatek: dsi: add binding for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-5-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=+OlEWEvMUxFbKjJVjIiLf0e0kaqCLKK8Af5H5ievjhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPZJ/cY4ERZiiSBfVRRGRyTqsN8HRcTtNer+op
 /GLORxmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURV0oD/
 0VXz2ryPfkA3GQgZfBGaQjZnLlqT71UDJqxrP4rzcrY58feUXLCqvam9ncDhmdgUSBM+aphUEBydzM
 WJH8b2LKpzmJaj5S8Wqz5jyP/D0snP4yShSpzIKA0W84vr969DljY9A0mz82JprPusmwLUWBpr873x
 iUD+sj9hNpR9mIu1BN+rAFj3se1zGrhWPAk+djg4GQC9Tlg3UAUwS87Qk3jA2xTlaeCRgv18Jngq0S
 ar9r0GTuD5IwHO4szV96F6eF77D6EWrNEcTHm6jbcdSEfQP2ecIjNOuTt85fAwTjhXqzXIby6ng1U1
 wdeBarMnV+qZIaOTiwl/3E3/+LnkQ2zZR1t1mJ6EyaQtWiyETT5bkYubyh5XsUAO1069iV+6uA3M8q
 ucsPRUSAqTSZ2fKX0yK/gwnSj432MKNFNMBnL4hPOGQcznyrlQpqZadpPUqvk6pCpGNDcvILphvWQ0
 AKifv6jwJLQfWb3FTbAtPoa9uRffmwzNlaub6T8EwrebyoGUFyIj4769lqi4XlYSHr2rk9hYlyQBYo
 vAxhRBm3jOkj8U2LWqL3zaFMr+epUIWc5htDqbxnXwi3apKidDY68sPFZ98mk5xBmITeY+ueR/Rry5
 n4zO4J4zgWT5Ss7YzL7jjwLr3MVXV8PDgniVA2BSyJ9UDXJM/TiRtPE3v0DQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display Serial Interface for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8183 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
index 12441b937684..2479b9e4abd2 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
@@ -34,6 +34,8 @@ properties:
           - enum:
               - mediatek,mt6795-dsi
           - const: mediatek,mt8173-dsi
+              - mediatek,mt8365-dsi
+          - const: mediatek,mt8183-dsi
 
   reg:
     maxItems: 1

-- 
2.25.1


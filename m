Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C587D39BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjJWOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjJWOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:02 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550171984
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:51 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-457c4e4a392so835136137.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072050; x=1698676850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btxrc1J+7nlpNBhaaQIbXhy+BRoKrBh7Tei2ReYceTw=;
        b=cLSHiUR/hYTLq5+W4mmD7GwIiwZxyMm5ZvkRc0LLGQIedFO/PxkhZOV0bPAP3SShsH
         K0905soWLL0Q6zt7WlTrzlhK+Nu00mlhJ4Gbyfe71PNhskzRDIV8L+zTSbw11XKBPaH5
         AF6X/wKl/m7wjXlEm985cfPSnyfG+Hh2eo/QBpvoyxF6sUD8cRm6hmVThzPDr1oOaIhV
         wQ+rc6ikggfxg+6Hv6iWw40tABmQnLvFReScScp/cr6n6Uqt0vhfpe19D4YLn+G6tYbx
         i/o+DD+xVre+QEEWcvBOuFoYiSZfITVh02YIhHYv8UvpTwowaHTECJ1HDssYYPKVihOg
         60bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072050; x=1698676850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btxrc1J+7nlpNBhaaQIbXhy+BRoKrBh7Tei2ReYceTw=;
        b=wfVZPXVPPtHKyqOKyLf7N+FQ9rWsHVxOT8uzZfqqQfXIgv+MC7E9j19KoXpcUU2fGh
         C9nPxdL6hErqGLOVTHcabJpgiPH/oWeyiztta49ztjrf4Sfy/VuL6Ey7qMooZDN/rPrl
         0nscaXnC9vTreQFAFPnuv5wL5p+UxS//uqPZ1Ruz+H4VGMDMapdwg8qFCq4IUA5VmEYf
         UGFTKhspIzMVbEDe75ej0Leqf64YCwo1tCwKZCYomHF48eSugLUa+1xIPvgGS51n7ZEd
         K0wwbkJ89cPAMy6m7+/GLFHrwFUXo3K2SPSFgCAQ5IjmWHUUSkFJGZJz2f2Le2BO+UeC
         YFQQ==
X-Gm-Message-State: AOJu0Yz0fyLBWn0a4+Jz0boihdkQzjUUO0LbNuoRjDyT8tRYELB5s4po
        2yNlrkkPua2DFyEdpud3os8iKA==
X-Google-Smtp-Source: AGHT+IEHtN0BO7u7QDArNCPWdW4jkZH4U2Tgzur52L0BG1r41rfx44EWTcGQl9iPYctJnK5hBurJEQ==
X-Received: by 2002:a05:6102:4741:b0:457:c025:4c7b with SMTP id ej1-20020a056102474100b00457c0254c7bmr5878640vsb.19.1698072050079;
        Mon, 23 Oct 2023 07:40:50 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:49 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:09 +0200
Subject: [PATCH 09/18] dt-bindings: display: mediatek: ovl: add binding for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-9-5c860ed5c33b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=M4WYL+KrM0LAMGbIVVc2NhXvV7PADZ7FKnKax4OIhj4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXP+76mL8HcY0aJG5HTEVTd79bVZFTl7La+u6T2
 JtLgOyaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURW52EA
 CWVgb591a/Qg88wnSQZ4uFhh17HaC4VEqoWqnc5n29xLfeW4uwo4iuJ1oVMC+IgR5Sa4OZv57VWYUz
 1jpU9G55weccJHI8BBTZEpR52MScVpl88+GfNRQhBDdRXI2GiN1yBFQlSJM9b0L8s4xlrZKDvDX4Z7
 gP5EZEa20WZkJN/ZIwRqeU6NaN50M0VhcX/skUqfrivEaeM7hkBhqBD/O9Vs/0Iw6+VolwYEFlr1wy
 Khn/iFY3FUx5JS5iMwAlV0CDUo9gDfbFhVV31rxhCRnK4KbTSnl9Dz+kEoJD0dUfIjNGJHxGm6Cn4U
 0bz6kYLJId4zAYyUeKK8PoJTCEeV7kgjI27B9yxPGCzK6KITdroOYCTMt6QP9DqY7KMexqo6SAyR6B
 knw3j9zrIxxYNWVptIoES4cPRcD5nYKrwvJ8DcCRx9TOKqpXnzkWifEGFWAQqnOGNTKk2o+MurGpkk
 KXaBkkZXiMWmHPYO9GpgdrI2M7VZwq/IQVIKc7aEe8pZjpPX868/ZSdgszL1nRULbhHUrzJaLLKMsS
 WNe7bfxjPFr+NqgEf0vr8ZypN2tC1fqKSXgB4MWxMb0n6Uwy2+Tx/6bfn9UwPfbwLkfoaUOlULrghE
 wJoHb2K2NMlrEE8w5A0+VvaMQcUD64/D5uzOy3Z5Ilnx4VcaTFuadcOxuUjw==
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

Display Overlay for MT8365 is compatible with another SoC.
Then, add MT8365 binding along with MT8192 SoC.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
index 3e1069b00b56..2873bbdf3979 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
@@ -43,6 +43,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8186-disp-ovl
+              - mediatek,mt8365-disp-ovl
           - const: mediatek,mt8192-disp-ovl
 
   reg:

-- 
2.25.1


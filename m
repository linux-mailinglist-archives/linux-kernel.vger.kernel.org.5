Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AF769A72
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjGaPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjGaPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:09:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022B10F2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso7659268e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690816143; x=1691420943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=B1DYggB8eGqCpLsilfDjv+CtPtKA8mzBBJiX3DsqfFcVmRD3EHJVa1I3ui/adpLG4o
         5L0OkqX16kwiG+alYKt7beRdvQIUy6Vqp3fytmEb5t72ZkLKEhGIgX3oVK/qbYP2dIf+
         PcZ/IBYg5fcpqwrCWjYL+XwqkbsE3JJtqktw3OwnCLBUH9VtvguIXX/hX+tgZ2GTjPyB
         R4x/Jm7nX/dzvKoX2oYUEEJP8wTaKuD9XBJLfoKlM1IVbZmntXqZyHRJzDJHiJGj94Ut
         w2Rglkd43okEbIloEuKynBL4GOaTToBhU7MKjHy1yqnf8agEPfjNDDUg+3mo7/l84d8k
         JPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816143; x=1691420943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=HbyC/5kg+Cp4qDO28H1Bo/nF31RXbjKGFgao40+uHFw2ojcbL/d8bTw3rDffXok2J4
         3ktE/0TiPvsIzBSwBByzi9+nbIC5KQMB3Z5WsZItL4/WBvtmShnHJzYMtqwaOEwrFsKv
         J+blRyqwZsRTQyEL5oOkCt+TbyduQPEXhxmIxpz7Olor+VZHYWkiICNJSXc+LHANA1Xh
         J1xNHn0HOacXw0Omg+oNUF6WvH8/p5eywBcJW8IKhz8QtA4vP3xImNlz+R59bMD2L5Xg
         ImQHTznxWBXdXnwLr6sgFmYzQ7eBavsXlOOrCNCHI7r2vayPoMK18lBItTYx2VohL76/
         Mm4w==
X-Gm-Message-State: ABy/qLbX7uYtMi9YLEpGZmNChVvHnUivzGZkNyXhyWJTzWF1cZxoiUrf
        sdXxcAh9l8SqV4Mu5nnLpYE64Q==
X-Google-Smtp-Source: APBJJlHa9zHDumGZmnru2O8XwCkJrQtDXNbzYwW+KavipyZYevSoqWizlwsA89+vnBqByZBXimV7aA==
X-Received: by 2002:a05:6512:5ca:b0:4fe:599:5684 with SMTP id o10-20020a05651205ca00b004fe05995684mr71097lfo.34.1690816143625;
        Mon, 31 Jul 2023 08:09:03 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id u22-20020a05600c211600b003fbcdba1a63sm11728791wml.12.2023.07.31.08.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 08:09:02 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 31 Jul 2023 17:08:58 +0200
Subject: [PATCH v4 3/3] arm64: defconfig: enable STARTEK KD070FHFID015
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v4-3-fb1d53bfdef6@baylibre.com>
References: <20230711-startek_display-v4-0-fb1d53bfdef6@baylibre.com>
In-Reply-To: <20230711-startek_display-v4-0-fb1d53bfdef6@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3ewdZnRTwiLei9nYvBO9iEQ33z/6iSvXdTZm6ylJVyY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkx86JSWBe/R+WdTNSp+vNLNQkL6rWTTSurE2qm+F8
 Nb0tXdmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZMfOiQAKCRArRkmdfjHURRqwD/
 0doxKphu5595hSG80BpEmZ8DzSqvovKlEfgPCJMGL51vVD+dY6e02ieFPrS9uw6FyfIpq13lRYesi6
 DJr6qrgxwbKGSA2d46RkMnc1xYF7GovxIPzU1oevQjr81n3HYn9VJTva6SR0Vq+jgES8mC6jcXOJlY
 emtjChmuuolXVTe1JDMWRmZ/p2kIfVDIfeVZVB0l98kG6QBJit6oYvKix5iU2zuZknzxNDlIu3jn7N
 9RJ4nLVJyarM43diGm0yzIAS4Kz8qmbIBcwaPMG9ShA4vr+kTNog1efaJnjGnKlqmqMTR66ILli16v
 widOVEVlnhBC5s/YwJnLMdupi4OkDu6oFcH0piuwpcmTH3qxGSGEW3xCV0MotrXj3t+FhsfOHn/R2H
 Nc+8ez34sEGbmqLNAi/Y30ypmLijfbumQr3WRn4AdovudtfBD41aZ0bB0utXD1awsLFyR8XsMaU/mX
 QFYZqfTD/S0UR9VNxvCH0onfYdfKMpZMUfWnwp9sS1/NxeH4DYUkvCwOqDIvx77wByJZcM7D/Ui5dT
 or30NjCl2/P2DLuC/IX6tF7KDBXgfXUBR8+ztt3rOT0kUN637geJRLBPqzp7MKw+ObOrJBilY5sfSi
 JwHqNfF5+QR+4m1I3vy8ZyeaDT/463ZSawnmTJtI7dn42Y7mAM7LDnm1DiMQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build Startek KD070FHFID015 panel driver. This MIPI-DSI display
can be used for the mt8365-evk board for example.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0777bcae9104..cb24a3d1219b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -816,6 +816,7 @@ CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m

-- 
2.25.1


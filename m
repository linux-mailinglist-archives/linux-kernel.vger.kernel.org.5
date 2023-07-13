Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94966751CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjGMJId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjGMJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3381BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99313a34b2dso68357666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689239260; x=1691831260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=3ExRJOSaoELf46cylFsr+j3DBGl9E6ckv1aalbj2EoZKiCzXfv9/GRe/617KC3fXPv
         SGs217+1UAijm/HBf9Hpw4EFkKL3M+p8xS+qVz4Xb3ioEoNYMj6pIcvZpcuh66V6VqkI
         lHx4tI/WAojKmz9ubTdQGKpuNdRUQqJV2T2Bwnn6qWWX+yEDmYPqi8qT+unBxhgsAeHL
         wfXrucMoUj5GpnG4KoyhLC/udnoxbh01SElxynFMW+t1R14Whl8bWUjLjxkl5ocY4S2s
         ywf4AdBm1J+fQURrWM/Unfc5kO+eKop8kKzfw3eCeUSpjNCvsAo2o4R5npuov0A0KVKB
         VpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239260; x=1691831260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GJI50mwxWlMPNP5cWPxpWEEdZG5lOnOefrq0yW+CGM=;
        b=D41WL0W7rl0XSBOF4aJjQixNhWB5HsnRYmE5BIkFZm61RIVWE5OfND1dF9M2yZ2z2v
         ZH6i/fY2JATTabEED41EZm5o6CIX3DBKnINVpXKA3FFku0ZhTyZKi6910p5uIQ3xVxHH
         KReommFuBkSd77qrhY8hGk1xBMNfELEJsJxkF1HSqcw0BN4mqau9y9/Gh6GQ9j9NgOcf
         rN0sO0rG4ZZ3GNLWMVEUsXIh9+pXNTNMKgEO2V2M/5O7OzijqeALDgNBtz8t/9N5/Lua
         S8N1SZsk0vJ47Exyed2c7rM3MmajqQ9B+jmlKJkgWm7mLwXTrmLMgdLP/ryDIzNoqXPK
         Dw1A==
X-Gm-Message-State: ABy/qLYoHS1IsD9MVFfqBAxQPgGsrR9S03lvKMqzaoMN/GIfikrkM24B
        kyrljl4ARbc2tzioRLl1rH9qyA==
X-Google-Smtp-Source: APBJJlFtq9zvjnF5mO4pjUZ+zKNfAotMYWi5ZC/UqAFlKGTWW2MBafd4apjqEfu17W261IuQyV1xFw==
X-Received: by 2002:a17:906:77cd:b0:993:d9a5:dafe with SMTP id m13-20020a17090677cd00b00993d9a5dafemr1068378ejn.14.1689239259868;
        Thu, 13 Jul 2023 02:07:39 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p18-20020a1709060dd200b00982d0563b11sm3707352eji.197.2023.07.13.02.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:07:39 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 13 Jul 2023 11:07:35 +0200
Subject: [PATCH v2 3/3] arm64: defconfig: enable STARTEK KD070FHFID015
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v2-3-87bc7bdec6e9@baylibre.com>
References: <20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com>
In-Reply-To: <20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3ewdZnRTwiLei9nYvBO9iEQ33z/6iSvXdTZm6ylJVyY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkr77W/dPGgI/R56qX2ubiKnlfqietIeYs+hZ/DMSo
 Gffi2+KJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK++1gAKCRArRkmdfjHURTOND/
 9LYscCCo3fgVX+6xN9GlW6I6ZPPi6Ffr+zx0PfkKhLYmBl40hljfWl2w/XKWw7AlW7dx0uzYOUumvN
 1hzrMqBpvv43z1Opcv6mJcUngDCj3JrIv5LijFC3MsKp4jbTD5xKTnnElwPlvt0/CXjD9EW7k/au71
 OEzPUQAY+s+cG756C7t9pYapU891EHu8Xi/F0VbMQ2oh2H/tr/1/P29WyB27acO/KyQVsFAVE61LHW
 5XuUWIZ6z8bnM5Ped3JDvJP5T+t0UnsR5EkuYba2gIAlK36q1kcTYvnQwVrUD+5iSuATdfCKXtxOsD
 HayOuWQyYfI5U0n6lbS9POMwiC5keCXuKPKbgURY8EiEraLdtxgbp93siaou+jSr8R246YeSaXuUNe
 XpU8JvlqK6iBluxLU9C0NHYndTg5WIKtanUCe96NhsltdjZOx8zA6Me3Rn/ucgZc5SoYKD7NhMOKn+
 40fCuCIoiz2LQbt56s3fXyAXQgn3+Xn5MKjWbN70mABYNwovpS2EIADcR8JuUIBEoKgC0EhkxtsfjY
 OMHTFBYRIoa3V+WQkig9D+4QcWnvnDUgvlsBdrXi2YN8u+YoQnlD5d/BmJtnoW6h4CxgOuKGLmmHf1
 7GtmkfUSpDT8KE8jxGaTKWXkOfM6QcATev/MDgS2VryNv5hJHwbxUFtWigoQ==
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BA0751CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjGMJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjGMJHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:07:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321D1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991fe70f21bso79522966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689239256; x=1691831256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwcL9L1d5Ep6I3OBmVEevOc5sUTVYd5D4r/f/BPtefs=;
        b=UESAu+5a5TJxeQsviLt+XkW6TqgybmnL2loLwuqcwcrZX5lgC9JBicbJwvmqupEuG6
         4WVy4VPASqrgJTWptK1GGIzYaAr6QINZdEflWWoqwGky7IHsNZuKqRKZ4KIUSPosFVO5
         dVrzBEnugotbmyNFFbX/5FwT4s00Lq0Midakx0+D0DyqemyKzOZYjDApjbkSajvDHx0o
         YBOZGoSRFhBsCUW+CoUu++R1U/HbGqefD+cj7wd0yWIGkz8MOdMViohdIqc4x8YCd8wY
         HrNtZn/VNZz3zZ7n9YubPXwi0IydbXaN4stJZgFtTNGNvZ8L/hvrDsTVwdHU7iKqqiRd
         eDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239256; x=1691831256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwcL9L1d5Ep6I3OBmVEevOc5sUTVYd5D4r/f/BPtefs=;
        b=UEq+vJXJRF66Dl+YoRcUq0EDnxFtbbsr8q1o7fqBBq8VCIuFHQDBeveAVXqArgz9iW
         AD4HfOdEcn3307IVPV7A4CyIvz/K7yRaMpVeth0/+Kxk8biXSc0jrMAMkT5yoJ2K4f49
         /XypNglj5//V4QCzuaX9unj/XTAit1xxTeUF/U7L7txdxD5haQqOjlKiUR8NUi3eQyMw
         FsKLGJrZtLVssXbl+PeCd79Nx++iTEshlFSpREDZEt9KP/9CIUTuq2ZuuYl6aMGCUAWB
         uOdpfwRh/9kUCl2VPvNS9p9QIGy3u9EtVG8SV9ynGUoLTY4jsvmH5TjiHgONPvDDRfEu
         Q9UQ==
X-Gm-Message-State: ABy/qLZEV/lcjzOGrTBzGdnvTBNhGNDixVB3hOTokbf056Zk5XLU3Zgu
        x+z6lwUFsuxAbKOGU1A6KosJHQ==
X-Google-Smtp-Source: APBJJlG/9dWdAO+IHMennvFnx6By0szo1vvjGgfqMSsw7wupzZ+6jkd9yMZGR2+spJ8wS3e08a/IdQ==
X-Received: by 2002:a17:906:5a45:b0:977:95f4:5cca with SMTP id my5-20020a1709065a4500b0097795f45ccamr911215ejc.54.1689239255685;
        Thu, 13 Jul 2023 02:07:35 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id p18-20020a1709060dd200b00982d0563b11sm3707352eji.197.2023.07.13.02.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:07:35 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/3] Add startek-kd070fhfid015 display support
Date:   Thu, 13 Jul 2023 11:07:32 +0200
Message-Id: <20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANS+r2QC/3WNyw6CMBAAf4Xs2RpawsuT/2GI2dJFNtaWtEgkh
 H+3cvc4k0xmg0iBKcIl2yDQwpG9S6BOGfQjugcJNolB5arIaylFnDHM9LwbjpPFVbRlY1RVDpV
 GhFRpjCR0QNePqXNva5OcAg38OTa3LvHIcfZhPa6L/Nn/g0WKXMiqaGWtyRRNedW4WtaBzr1/Q
 bfv+xdLR05ZxgAAAA==
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
        Alexandre Mergnat <amergnat@baylibre.com>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=3y5LMZOUzphp7mX14QjhOYQXh5yv0tTAKwXAmNFnEB8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkr77WCyMuAZkdsHbMMihvWnhf1LFUKBPEmnEVeSqM
 jKNcQ+OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK++1gAKCRArRkmdfjHURfNBD/
 wKl40srBR89jOhq8VWwgbAbUPLeM19ItclQ2y2gem8pYXOkoFhCaAeUt9c9bZet0i/TqOVG6LKQKXZ
 TmzhZJWbrJ4RJRTWjg0nfcpxO6uSxLDT1q4sYIMZ9v5d4eTXNefO1+1pE/h/Wv1h9a7JPc2rFRoc8q
 MMKCtSvr5p4jRJlTV7uRNo2IUOlamv8d9ue0Gthn/6tUTshAHPh2nkmRj4gOCD/N8cMdZI88C0aY2w
 wXhxk0A1milOKjkzjdIU0dLV5d8k3TLUYtl+Yoc1qSYbxCRhjg/I34wjAp3sUhsHdXzJFGF9A9vYPw
 POYvyR1pbONQvRAkPvhc8engSQPlUZuF7bJsjhPfJaSAePFmbWwq4sxzCJxnG7Itj+UGrr5KlEGhrM
 7NXzlVFoZpcB5y5GnCO/jIwYu6Hz5ObI6d51BQ2xuYIvKEdXVW1LFDH4AjfgTKPSBzMzuqxHBSGadA
 0MctXbbMxSAXaymUI7pZLr5ngn1cXSagOA8WxAHgiz4jR7NWzmmmWdW0YEiiVW+IE46uZc+LVw38MU
 btxqgXtsA2p/sgkTqy8GpmLNifE+G6UK6tuj9T6ohdnSpmrvxVwn8AdR53O8TfJdvy949eq8H+5ntQ
 nbZwcrht0BQsAfUcKBDM8SZdOE5hsCNvKuxB4wnZFRuLc/mkv/vkx0cSvAow==
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

Add the support of the Startek KD070FHFID015 panel.
It's a 7-inch TFT LCD display with a resolution of 1024 x 600 pixels.

This serie come from a bigger one [1]. Then I addressed the previous
comments for the related commits here.

[1]: https://lore.kernel.org/all/20230220-display-v1-0-45cbc68e188b@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Replace "dcdc-gpio" by "enable-gpio" because this pin enable the
  Power IC supply. Also, this property come from panel-common.
- Remove height-mm and width-mm since they are useless here.
- Re-order elements in the stk_panel structure for readability.
- Link to v1: https://lore.kernel.org/r/20230711-startek_display-v1-0-163917bed385@baylibre.com

Changes in v1:
- Fix typos in the driver.
- Merge 2 regulators in one bulk variable in the driver.
- Remove backlight enable/disable from the driver because it's already
  managed by the backlight core.
- Move hardcoded values from function to the generic structure in the
  driver.
- Remove unnecessary function (stk_panel_del).
- Replace some functions by macro to increase the readability.
- Link to parent serie: [1]

---
Alexandre Mergnat (2):
      dt-bindings: display: panel: add startek kd070fhfid015 support
      arm64: defconfig: enable STARTEK KD070FHFID015 panel

Guillaume La Roque (1):
      drm/panel: Support for startek-kd070fhfid015 MIPI-DSI panel

 .../display/panel/startek,kd070fhfid015.yaml       |  69 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-startek-kd070fhfid015.c    | 431 +++++++++++++++++++++
 5 files changed, 513 insertions(+)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230711-startek_display-958d265f6baa

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


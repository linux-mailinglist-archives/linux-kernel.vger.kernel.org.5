Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172CC7AA246
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjIUVOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjIUVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AC7728A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:10:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501eec0a373so2174444e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316204; x=1695921004; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugBDutMDUwFIW+XGJXmxe0gl1d5PC4XWkOZfksjcQqA=;
        b=P9JFo3v9tJIfk9LtDAF50Tx21GrHeWc5KEghxOsJGcEAn0bjQfhjrhhFXwCEXyXwlR
         Aj60TUQ70eNAohVkfAyfaVizZDzJCa6aTfFrObCJ4wcFl6ygVXLj9MhkYUnlPf2iIbH7
         gWmjk3bNv51/F5PfP9jo1q2apBwwxBLD0HNGBS/RaGAyRu1EXtoXl/RnH9qqcT2BmGzQ
         1tb8kjDqGZWuFh09YROBoDwEAXj4XQptbIbxwwRP2QlEWP2/mWOsptGDgBwbamsnWZ1i
         o4yYMzjeDVahWuhtl9TAsby4cID7C4qL207/vG7v8ga+dKWresXRI44Rr/By6a4/pmd2
         TkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316204; x=1695921004;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugBDutMDUwFIW+XGJXmxe0gl1d5PC4XWkOZfksjcQqA=;
        b=d7+usU1sKflPKxKXKgG18J6KAwvHFi/cxf5mC88Q9Qu+dIdGRf8ff71UFzbPkzr57R
         5lA28RfGKK1aaaZ00443vkuoUbfl34myW2IhPenOoTzzBQTounpff03dbSYvdH/hj5x7
         VtARb1B1v7KsgTBXxnLDrGoYFhY7wl/DiA/b44fQ5qqM/n9lIqc8CEPTnimbHIt6gFyH
         JsgFeiY16d0roo+Wvmo0IQmTlnu5LugaXBHPWgzG87HqfZxt0nKtEoDVaOx+3oL4PgUw
         0C4Y6YFQnJi/GrAJm5HztGhF8uK4q0JS//lrOz1O7FLlOKcn4goHM/aPYAB9kPExgeXs
         yv/Q==
X-Gm-Message-State: AOJu0YygOhUYJy09bkIbAq6+jIz78zB46I5xWXSKG6q17jb3um2kU+LE
        HFhKs9COjgmqcYN3J8MAUJd2ItdqTHHqqkkGeCk=
X-Google-Smtp-Source: AGHT+IEnnA232hi0EjTsYEA0fIpKe++PKr1UXQZi0uD10vlJ9FkSOMNsPgiVpxoOQOFx8n1j9hlDEQ==
X-Received: by 2002:a05:6512:3987:b0:500:c709:5845 with SMTP id j7-20020a056512398700b00500c7095845mr5625864lfu.4.1695281781975;
        Thu, 21 Sep 2023 00:36:21 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id q6-20020aa7da86000000b005307e75d24dsm441078eds.17.2023.09.21.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:36:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 21 Sep 2023 09:36:19 +0200
Subject: [PATCH v5] arm64: defconfig: enable STARTEK KD070FHFID015 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v5-1-7c209b560cfd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHLyC2UC/4XNwW7DIBAE0F+JOJfKgAG7p/5HFFUsLDGqY1vgW
 LEi/3s3OVaJfJyR5s2dFcwJC/s63FnGJZU0DhT0x4H5zg1n5ClQZrKSqrJC8DK7POPvT0hl6t3
 KW90EaXQ04ByjFbiCHLIbfEe74dr3VE4ZY7o9b44nyl0q85jX5+siHu37g0XwigujWmEBg2r0N
 7i1T5Dx048X9uAWuUNIIhoL3kJAb7B9QagdQhERfFNbNKB0Cy+IeoeoiYggglYQA0bzj9i27Q+
 4fUbVjwEAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ZqBjtuVH5iG5uzbV/ObjtVAFVdhGQkuX3d03Z+MhOtE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlC/J0HIUmqcs3w8sVHd6Qv45aTh86t9nXC2QvQc42
 okBx2wmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQvydAAKCRArRkmdfjHURRdhD/
 9q6rLUwlHsvW8RP/xyU9kS1KwV1KWmzOwTgAf2LOb1Qqx7y/+BCwl5rRvmQIZybto6ilbxfoZJAT/7
 V9fHIzyKGcVcFkV/bhV7K66pkxrJ5duogni/9XG6mZZkyBzjuAMoI2J0Jw6icsq0Fv7IB22lNFs/eY
 E3E1ysXs7gylF+bvcGDyIASJIlntA4yRrmdD0tq+INOhA7vDhm3DJP2rqilhCU9oWkiZHzu+LCjP4L
 jiVt11Fjr01T0SM+sN/yjcCBIepERtuGKTWMClEo/S1zcs7TG+039lhUGF5tNYFsNe89CKRkEmQmPN
 QElRvYBSa1PU/ZsskpNWfz8Ysud1gLnUiAvBheT/jY6aTBa9nevCznw3hFJ65+FKxJUZ8g6vJja7jQ
 nUzsnpZRkh6Y3pCEpdo181HeRe7XjJHzePMgH7xY4LVML6GtsTlbNj4f5Wvr3D73xzmJoqPbkpHqwp
 GUIUE9by4VIk19PfFvVx0LDadrmqdPN1dU1CtvhIAXSxU4O9yik3EoTY8lTw8+8zw3OBFDpfGU/zHt
 AFizi+0N2SRoZicLfQDVlNUBplo+daV8uDX4rK0twfYwT1ykx8Di1k2IOfPWXav6rKWXnbwrwSXuHY
 0IPMIYPB8keqL5nH8TgsGtfoqcH5aoUtaGbUKo2APHVB9X3iJLfsT+FSUpqQ==
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

Build Startek KD070FHFID015 panel driver. This MIPI-DSI display
can be used for the mt8365-evk board for example.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Add the support of the Startek KD070FHFID015 panel.
It's a 7-inch TFT LCD display with a resolution of 1024 x 600 pixels.

I use this display plugged to my mt8365-evk board.

This serie come from a bigger one [1]. Then I addressed the previous
comments for the related commits here.

[1]: https://lore.kernel.org/all/20230220-display-v1-0-45cbc68e188b@baylibre.com/
---
Changes in v5:
- Rebase to 6.6-rc2
- Remove merged patches: dt-bindings and driver.
- Link to v4: https://lore.kernel.org/r/20230711-startek_display-v4-0-fb1d53bfdef6@baylibre.com

Changes in v4:
- Remove useless function: stk_panel_shutdown.
- Align parenthesis for readability.
- Link to v3: https://lore.kernel.org/r/20230711-startek_display-v3-0-dc847e6b359b@baylibre.com

Changes in v3:
- Remove spurious line.
- Remove useless ops (enable and disable).
- Remove brightness value init because it is set right after
  using mipi_dsi_dcs_get_display_brightness(...).
- Link to v2: https://lore.kernel.org/r/20230711-startek_display-v2-0-87bc7bdec6e9@baylibre.com

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
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789f4868..86918abc5466 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -837,6 +837,7 @@ CONFIG_DRM_PANEL_EDP=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
+CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_LONTIUM_LT8912B=m

---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230711-startek_display-958d265f6baa

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


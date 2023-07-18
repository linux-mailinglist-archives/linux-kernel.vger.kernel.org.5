Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E1758046
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjGRO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjGRO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:58:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D38171B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:58:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5651789f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689692318; x=1692284318;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7qbajFrTu3xdmlkD7sMCozUhGPFxBZ+VIOGec5FvnU=;
        b=V1Q75zWF08MtcCWIc+qmruiy1a5sB8RKBM/B61PWKSCB3xA2vTvtFHR9912xPdBXqG
         bulne4a6GTRE9rcdTLFXbiykp1/QcT6nL32KY7C4VyL+iDus36uL4xUeFcPOm0ER8uIG
         LNS5n6b7GFAlOcODOevdkhKhaYexj7NXYlR1ST9WU1Yo/VbgHuXf7tZvfPLjmCxXLzmJ
         fPM0C0q3t4a6g/cgg/isB/FYwtvE+wFZsMPs4Zuh4Np7xOzKC+xIw29zEy39dP5ba+vM
         9oko0gTRYnipMMOfJN5I6s9BBigpUzh6BJOq8WTILIzLYW9pfo6h3wFC8B+8lZk7pdK8
         mXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692318; x=1692284318;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7qbajFrTu3xdmlkD7sMCozUhGPFxBZ+VIOGec5FvnU=;
        b=ewUEVTY26Er5GenX6xId9oZ9faiwnfiUS9Mt8LsPFLn9obL8lx72wwe38mSC0ze5nF
         J4KWTcPqKcC39kHgQh3MKUHvXaj+JfCtfRsi8Gqr/hKk/0SrLytLUNwM5XoYDzcRXvnf
         IR2HAXF2Pc7XMZhHAij4uWjZJg3adL0UiANpdRlXzIfvWCpf/t0ZI/9U37qzB1kvT1h6
         RztcrDzf721Kvg9SE8aIwrKmGfrvlqnb6Rw6kxyB4D7c/usKiFnU3pP/TUWK8Cy0ew3n
         PUUB064nAIkYxRRc7uZo8rH7tvzVrahDaXUZyyn8hJvFTJ+m/QvNSp4JOjih7Wdn1NL7
         BhEg==
X-Gm-Message-State: ABy/qLblG5g1Y8Ho1X6DQSKbrClKsdkBMCXDDG5fMxObIt/3Nyry9pLf
        yuvA1Eh7UwfawcY/nz9ZDA5M3Q==
X-Google-Smtp-Source: APBJJlHlwQZq7zOOpq7KDx/jo79mR9NlyYtg5NASUFKIGCfSDYzmBHgMhFLaVxFVunhexBSDFb5YMQ==
X-Received: by 2002:a5d:428b:0:b0:314:d31:f7 with SMTP id k11-20020a5d428b000000b003140d3100f7mr12318821wrq.63.1689692318485;
        Tue, 18 Jul 2023 07:58:38 -0700 (PDT)
Received: from [127.0.1.1] ([86.71.62.179])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00317046f21f9sm2602817wro.114.2023.07.18.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:58:38 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
Date:   Tue, 18 Jul 2023 16:58:35 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable OMAP watchdog support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-enable-omap-wd-v2-1-921f829bc0a5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJqotmQC/3WNwQ6DIBAFf8Vw7jYCFW1P/Y/Gw4JrJVEwYGiN8
 d+L3nuc9zKZjUUKliJ7FBsLlGy03mUQl4KZAd2bwHaZmSiFLGveADnUI4GfcIZPBworJY1oyro
 SLEsaI4EO6MxwaBPGhcJxzIF6+z1LrzbzYOPiw3qGEz/Wv43EgYO8ybvqhakV4lPjOlod6Gr8x
 Np933+aK3UlyAAAAA==
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, afd@ti.com, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689692317; l=1273;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=Fjs0Ne391uULid7nmq/UoMxgWX0s3FwfGN1aefJQ8bo=;
 b=k+ggxpGC2jcIE8lhscoiaStdf/7o8cr6BIN+8Pj5W6BQ3gdocYEoJcWFeBnkqLchF9MXzWDIq
 AnlMwVxZ0ELBAZZ4KYf6IX433KqPiGhUsfo98onFndTX3aYYcpnx0VI
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase build and test coverage by enabling support for OMAP watchdog,
as used on TI OMAP based boards.

The watchdog timer is an upward counter capable of generating a pulse on
the reset pin and an interrupt to the device system modules following an
overflow condition.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Enable OMAP watchdog support in multi_v7_defconfig for TI OMAP based boards.
---
Changes in v2:
- Add explanations in commit description.
- Link to v1: https://lore.kernel.org/r/20230718-enable-omap-wd-v1-1-34396f2c76aa@baylibre.com
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f0800f806b5f..7d93e21e0cb9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -554,6 +554,7 @@ CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=m
 CONFIG_DW_WATCHDOG=y
 CONFIG_DAVINCI_WATCHDOG=m
+CONFIG_OMAP_WATCHDOG=m
 CONFIG_ORION_WATCHDOG=y
 CONFIG_RN5T618_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-enable-omap-wd-6a563c280752

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


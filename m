Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EE7F0642
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjKSNEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:04:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E61B9;
        Sun, 19 Nov 2023 05:04:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50930f126b1so4474240e87.3;
        Sun, 19 Nov 2023 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399067; x=1701003867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP7dCzocUVh4qFf97xC71aXva/0AFLOJoQWQWCRF4fM=;
        b=e8u/HsDVFl1cABDm+8eJ3OdHmcAgPn22bNKK70jGs7bTfGqWbpyqTkjOqP8Pqvk3H/
         ZSaPHmH5suoytEZqUXYtGlUIMdX7CdfR68M5l6UQuwn4W3Gx8C36gdL+4f/5fPP4PLoC
         DysavuWisyzCW8O2m2y+dJqWDhkLuURR1PxwnfIZRO8wYK944+fewJuq8LXhbYunLrE7
         BhFaRtpn1/ViD99xzJV8ZAWFfC7/j55Bw+HkEZqgvcpA4GHGLtMUP1jp4HQWuF8u6Aqm
         cAK7sGKKtFRfVxXmTByReTyvuHWGViNZzfbqeW9kl9kHMcYhDgUnaLttTqo1UF18+Ln6
         c9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399067; x=1701003867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zP7dCzocUVh4qFf97xC71aXva/0AFLOJoQWQWCRF4fM=;
        b=psGVABLOTE/DMARXEt65Td0vybWhVEJdPZ4aekvTLGgBEh1V453sRF1CdAWzilJZtY
         U/Xciu3zuK3GvZsYXqgfgBk7z0M2qIMYszHo5j5JZ23nDUacJuo2TizS8fKvW/LkCb0G
         ZxgpjRPH7+ine98qDcu+2BuGN9wqhlYXyQpGHzseFbK0k/WA5Y3D4rhjsxiQQFZQfKg5
         pT/9FIkDWj01uOR1iMY/93m81iuMyCAQZk+EfFV9g+veXaeJopKGeWowG5qmIY+QLSQs
         PLIy89LEPV4n/qiE+gwBGGwfgyy7lVhR4UOg2GNoURlPX17inypotADP4bieoe3Oua/H
         pPAg==
X-Gm-Message-State: AOJu0Yza3Wo1GtyBhrz2k0zhrZfJQsJypBjnb8eTVBsbvvC8u+BOSSOh
        BgpZr7Q0RvVuCNcIQUY9Zw==
X-Google-Smtp-Source: AGHT+IFFw1D0jjPGC2PZaMsI6F+bUzIABnBmKjG2xRzT2rKj6n+5Zy0g8TK1aiDHb8uH87JEQ+H8Hw==
X-Received: by 2002:ac2:5316:0:b0:50a:6fbe:fec4 with SMTP id c22-20020ac25316000000b0050a6fbefec4mr3582233lfh.33.1700399066958;
        Sun, 19 Nov 2023 05:04:26 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm2827866ejg.110.2023.11.19.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:04:26 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/3] Add Geniatech XPI-3128 board
Date:   Sun, 19 Nov 2023 14:03:49 +0100
Message-ID: <20231119130351.112261-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds RK3128 based Geniatech XPI-3128 SBC board.

Please see commit messages of the individual patches for details.

These patches have been part of the pretty huge RK3128 bring-up/fix-up
series [0] which I've splitted-up now, as suggested.

[0] https://lore.kernel.org/linux-rockchip/20230829171647.187787-1-knaerzche@gmail.com

Changes in v2:
 - drop nodes from board DT that have been part of the initial series that
   are not upstream yet
 - rephrase some board DT comments
 - refine commit messages
 - added mmc-ddr-3_3v property for eMMC

Alex Bee (3):
  dt-bindings: arm: rockchip: Add Geniatech XPI-3128
  ARM: dts: rockchip: Add sdmmc_det pinctrl for RK3128
  ARM: dts: Add Geniatech XPI-3128 RK3128 board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm/boot/dts/rockchip/Makefile           |   1 +
 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 397 ++++++++++++++++++
 arch/arm/boot/dts/rockchip/rk3128.dtsi        |   4 +
 4 files changed, 407 insertions(+)
 create mode 100644 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts

-- 
2.42.0


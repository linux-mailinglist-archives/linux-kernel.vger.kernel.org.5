Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F4801CDE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjLBNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:05:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B5F0;
        Sat,  2 Dec 2023 05:05:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00cbb83c80so441680566b.0;
        Sat, 02 Dec 2023 05:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701522317; x=1702127117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlmbJveqqWu3UwBC8vwfKHQE4Oarn94AjuSP1HWUeBI=;
        b=N5TxvQVHFWNliRq9SFGZSsQT2MVvyhxMivm3KiAURABJvgY36xjXNnPVqGEOeAfNBD
         clZd4w5zvf63RcvctGlnVm9Qc5hxtwMrV+LQ3LfLOq0s8xLlPv8l5BYgVhbSVEDnlxTH
         LqOyubE5MU043OPwVYllJ+As+dHkZPw9MJDFS/lqY3E61hhW1gF8KebG/bGrBpPkScWI
         sreF9jtbRIlhZrbJr6/2fMj2L6u75Cxq5fUrk47YXS1fMOQ2NFeG/gZ3BttNUJZUpLFt
         CQ2aoZg/RiRcALnZhOouAG2SCILph0BSVU0c3f5Fjy6+y189bH5GPmhoor1zVbty3Hmg
         m5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701522317; x=1702127117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlmbJveqqWu3UwBC8vwfKHQE4Oarn94AjuSP1HWUeBI=;
        b=EToea18diO74sJwIYz2cC0FymEvYCKUzRae2aneQSfmHg50xCavFwJILXqXUjwi6jQ
         eeM+efW448zu15Jsr2LPpEwaMNKLKzu/O/fkwCZP/ACdakHrYOktKv/5Wxi/+LNs2n9o
         LbyQq1RPmVyWZlsyO9t2uLoB+DXKmD0Ev8h93ViZ8hASwVSeJqG4Dturr98eecGRMzWO
         KTgru5WzcJeI3bR4EPzBq6NNsb7EnSBUWatg72HpuQ5jleTNtEoiGGaf90GMhYxhlklW
         1mB88kfE28cm4s9QkVzYpBKhU6AxXYgsc0I1GzSVLhI9+DdncJRhrmTs7TQ+7yb5gLo1
         HZJQ==
X-Gm-Message-State: AOJu0YwbBGADzptnZD5fYN4ORuZ42/O/atoeq0M3iiYxMofn5MlXfLB6
        rcFYvXq7lVUd+HBBgYObO8M/1uvDaw==
X-Google-Smtp-Source: AGHT+IGRIGvQmJDiHFsyOFQZOb1u+p7x4RTsXeU6k5ENkIv33g9kDxunLOZ+qogZLatt7t1wYNfveA==
X-Received: by 2002:a17:907:11db:b0:9fe:43a0:4ac0 with SMTP id va27-20020a17090711db00b009fe43a04ac0mr2075416ejb.24.1701522317371;
        Sat, 02 Dec 2023 05:05:17 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id bs5-20020a170906d1c500b00a0bf09c9483sm3045324ejb.35.2023.12.02.05.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 05:05:17 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 0/3] Move core bus and gpio aliases to SoC dtsi for RK3128
Date:   Sat,  2 Dec 2023 14:05:04 +0100
Message-ID: <20231202130506.66738-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Following up the recent discussion [0] about where aliases can be/should be
placed this series moves gpio, i2c and uart aliases to SoC dtsi for RK3128.

Note: This patches are based on maintainter's repo.

[0] https://lore.kernel.org/all/b0c637f5-5abf-420b-8b02-839eba68799e@linaro.org/T/#m94aebb23a29b015d94b250a70b675febdaa902ea

Alex Bee (3):
  ARM: dts: rockchip: Move gpio aliases to SoC dtsi for RK3128
  ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
  ARM: dts: rockchip: Move uart aliases to SoC dtsi for RK3128

 arch/arm/boot/dts/rockchip/rk3128-evb.dts      |  5 -----
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts |  7 +------
 arch/arm/boot/dts/rockchip/rk3128.dtsi         | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 11 deletions(-)


base-commit: fd610e604837936440ef7c64ab6998b004631647
-- 
2.43.0


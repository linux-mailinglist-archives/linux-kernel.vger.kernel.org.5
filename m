Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87D78CEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjH2Vla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjH2VlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:41:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29537D7;
        Tue, 29 Aug 2023 14:41:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so6465949a12.3;
        Tue, 29 Aug 2023 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693345276; x=1693950076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgbDSFaryU4ca1B55I/LLmVwTu+viTZKb05cg+910PM=;
        b=AqH0BsF0hNVol900WOqi4rt6SS9FUq28g4n+6s8zqFkxslrdmYYzizP0Sn/dRXH7eL
         B/yXdL5XtJl19Zln+OaZajEqXl/nH0ABck3aYyC/Bcs3fW58sc4f2L9dqZQUaxZQHEll
         aTtJiPZ3ui1OHWH21mvKk2OXT3FO7Djt/6tUYCbPWvV8qSIldwMh02QVSvTqkO6eZcZD
         ZGYM3P1Sv2YHFkB0fWvO+eT7adMnmZ6TzMnTze4gJjIhLOjxQPHrnxfbV929+abef3KS
         trQM7e1Zh3xGTaK1DlJA15wbdB99HBeCEUpseqIsmEDufomJNfC/P44gJCcGME+Dzs7I
         IENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693345276; x=1693950076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgbDSFaryU4ca1B55I/LLmVwTu+viTZKb05cg+910PM=;
        b=gOI/up5ev9u544nuLRj0vR+9VOmBsCo7p0gPRq5lWMGEclFYS8INtiDDf5KOwUzBRs
         wJ0bLZT6L6iJM/dH13Q2VaUy0mgzdc+bo+xadTG4b4pNPMYkMdrPPpKB3gG9zKBdE+Ps
         Z55x0vi6STzf9zJirlOwkusoGjtNcLZD20G9WJ2GM6gYKdOiAdPvU3cXyX2dl72K86/x
         td97NAL53FgHDK/SunnBUEP9dCybc4zqlZgirEx1iA/+l0E6aKLrCl6fcswTjYGCI7b9
         +77cn+ivpU53HZmJAR+2h9RLYo0aR22OSfj600kwGgzQOj/TRX3tRhFQU8hAL65+ggmD
         icfQ==
X-Gm-Message-State: AOJu0YypbvyaK3veqlnr8yAVI+A+YcMYYPxooguEcjbFMiVKounICtPr
        vUw7tmeAcm4tT96O3iWopA==
X-Google-Smtp-Source: AGHT+IFUtF4tAi87N77EKj8HYwHF1DKsELUTQbd3MjCDy66CG2SqZHgFuUrx/SQ9h14cPF8BM5rtdg==
X-Received: by 2002:a50:fb95:0:b0:522:3849:48d8 with SMTP id e21-20020a50fb95000000b00522384948d8mr389164edq.9.1693345276579;
        Tue, 29 Aug 2023 14:41:16 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:84d2:f616:9527:dd98])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm6113428eds.77.2023.08.29.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:41:16 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/4] Enable SMP bring-up and cpu frequency-scaling for RK3128
Date:   Tue, 29 Aug 2023 23:40:01 +0200
Message-ID: <20230829214004.314932-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to enable bring-up of the non-boot cpu-cores by the
Rockchip platsmp driver and enables cpu frequency-scaling by defining
appropriate operating points.
Please see commit messages of the individual patches for details.

These patches have been part of the pretty huge RK3128 bring-up/fix-up
series [0] which I've splitted-up now, as suggested.

[0] https://lore.kernel.org/linux-rockchip/20230829171647.187787-1-knaerzche@gmail.com

Alex Bee (4):
  ARM: dts: rockchip: Add SRAM node for RK3128
  ARM: dts: rockchip: Add CPU resets for RK3128
  ARM: dts: rockchip: Enable SMP bring-up for RK3128
  ARM: dts: rockchip: Switch to operating-points-v2 for RK3128's CPU

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 61 ++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.42.0


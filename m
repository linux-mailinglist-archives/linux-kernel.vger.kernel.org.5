Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2DE801CAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjLBMmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:42:00 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7D12D;
        Sat,  2 Dec 2023 04:42:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c11430624so4849198a12.1;
        Sat, 02 Dec 2023 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701520925; x=1702125725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrbLqLr6+RIrfdx9hRSNIeKennbFVuSCmM6g07Rq12g=;
        b=AhViRfBgE13vn21O/b9kdHfcjdRenamSpxBTVBt0m6i//KipBJKyuVf9VDs6XGAOR2
         T5ITH5F1HF/9+6VXcCShpRugkT0ypc/ZDyUsQHvN0wCwZdL1YV7fOAl6s/slqj7P086x
         IBlapxGtmG8jfFKFpJLBIFDlckaEX1+LrjkAHn7xwzfWzRxvGWhM1tc9lMlYSFC2fdeh
         WhtDw4N/MmZsPYWwIGv07c+k0ZHsZYQvBJrVOQM6o2E3n2c/zjc8EpvEIEI7eKyMa0g5
         pwLAy8oa02m3Gz1ory5JWkv/8Pe2auM/f1Afpn5ynaGj1CHu+Dz4Jff2Wpv7bP9hIPBx
         zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701520925; x=1702125725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrbLqLr6+RIrfdx9hRSNIeKennbFVuSCmM6g07Rq12g=;
        b=cZmxRNUtfiygpeQ6kd+jUwVu/EcwPOnGSaySKJghuIVpDlfg1MsYs/tMKAPWMwNdkB
         X5Kr8rIcekjpflIOL1Fhh0VssRh9tlIYzG6vI7eIbKsSi+Fa73aNmezCKYR26m/QHP6+
         QxOj/4QQL0MAslRkGzYQPwEjPn3xohiYRdFUTg3lnyOqV9daLKQ/gbV/lZ0nmqv5ZobW
         Sdw4RTmo0P7PihsVgZg4KTVAuyHW9R6jhuBr+B7KY8iA6n6K6Nd2Dyt1eU5Klx+gVON2
         8Cfa2MFzE9A2xwvdZp0WPjjlmE5sKV/RYoCIYDzBn6i2jZ+NmiZWC6mSS/IuGF5Lu5aU
         +x3A==
X-Gm-Message-State: AOJu0YwxGfsefVOYgIBhk5FZE8EsdI0ySoJr7+zjSlxPmbRa3Qt4ubrD
        o899EWARybq1wEzr9/sElDyV1i1xng==
X-Google-Smtp-Source: AGHT+IGl1ks4h+edw4TgH0EWvsVT5wHukbcnyWRKAZa7Pi6lB4jPRIW6GjJmFSY2FPAI7hOugtYJTA==
X-Received: by 2002:a17:906:5193:b0:a1a:5cbf:4b5c with SMTP id y19-20020a170906519300b00a1a5cbf4b5cmr1054740ejk.15.1701520925097;
        Sat, 02 Dec 2023 04:42:05 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060e5300b009a19701e7b5sm3009602eji.96.2023.12.02.04.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:42:04 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/2] Add GMAC for RK3128
Date:   Sat,  2 Dec 2023 13:41:57 +0100
Message-ID: <20231202124158.65615-2-knaerzche@gmail.com>
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

RK3128's GMAC is already supported by the Rockchip's glue for dwmac
driver, so this series basically adds the respective nodes in the SoC DT
and the enablements for XPI-3128 board.

Note: These patches are based on maintainers repo.

Changes in v2:
 - use phy reset-timings according to the datasheet
 - added rx-fifo-depth and rx-fifo-depth for gmac

Alex Bee (2):
  ARM: dts: rockchip: Add gmac node for RK3128
  ARM: dts: rockchip: Enable gmac for XPI-3128

 .../arm/boot/dts/rockchip/rk3128-xpi-3128.dts | 28 +++++++++++++++++++
 arch/arm/boot/dts/rockchip/rk3128.dtsi        | 28 +++++++++++++++++++
 2 files changed, 56 insertions(+)


base-commit: fd610e604837936440ef7c64ab6998b004631647
-- 
2.43.0


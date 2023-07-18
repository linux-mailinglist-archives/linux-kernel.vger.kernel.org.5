Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288F758245
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjGRQjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGRQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:39:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4367E1B3;
        Tue, 18 Jul 2023 09:39:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262e839647eso4115238a91.2;
        Tue, 18 Jul 2023 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689698389; x=1692290389;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJfm9Xu6mLNf+bMAmuP6AEX0CyJ95XqwOktwztwQYHc=;
        b=WuaFFFb8P26DlxbEI98Sj9R8DetzfD5pLUWStEYhjaTGtJH+OUC3umtYjNgHw53X8H
         qRQz9GWTsXAIw8VqpXYoRn4nH1Ah7isvmtXvHS4QWlaW2HQQOrhO1i4lP+Se/EmSLKsH
         p9SLbEWHHS3M2CbGlPep/pdKYflAHMnT2458jc02O1Q8Wgu4rgmk6B2G1IraMMBbbeuX
         iRWXAYcYtwu3AgJCLEV4JOftBkNXpHIoV1AI9NB1sHxKTNczwCKtrJYzab4fajTWXn6L
         tgxfZQaBAXvS4rVJERQ1GahNghgEHZOuIOyq3D7dUCM8Ar9OdimqlIeaDOgMcpYwW9ha
         yWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689698389; x=1692290389;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJfm9Xu6mLNf+bMAmuP6AEX0CyJ95XqwOktwztwQYHc=;
        b=JP6xpmZ7vimSjPwIUorUuSRb7yRyB9BCSX1kCiD8C6tKQ+Rt2o7YBhUZ/7FQl1X59t
         WoSa02BMhjtrxzuBdwX1SygetCAoEiLSOUHmlz3QWJCq7dR9gmlg7MI05w/2Rx+lTdY6
         eVN7hK0+XQ/ee9eRKKo5HNjk/0SX4sO1saBQx3EdmLK64KbPGx6Tx2JLYvezSucsFAYy
         9SrS8M92kxNHIGSpyUT/1DgRrj0UQE4/xHyB1C7ppy98M60ekFjrGOlWqcxEFJ93A1D6
         QdvSN/gXDjrlqODiLxj75qfdyI+uUOvsiDy1irzI214T33GLieERJYYLTb1kkgwT7dCs
         4U1w==
X-Gm-Message-State: ABy/qLbpP2g+zphXFSwz+QI5qtzOMi8wgnCd7vWrpeF/w+DX4PTXruTb
        O4588xJ6OMWodIJIqsJRZf8LIA22+xg=
X-Google-Smtp-Source: APBJJlHZTPpp1pKtH1Oi100fve+RA7DjBKu+d4ef5KaEWCIBBYdCe08KvkmNsDfXxRTogVs8bDcwIQ==
X-Received: by 2002:a17:902:7894:b0:1b7:ffb9:ea85 with SMTP id q20-20020a170902789400b001b7ffb9ea85mr15154411pll.29.1689698388615;
        Tue, 18 Jul 2023 09:39:48 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id g21-20020a170902869500b001b80d399730sm2077207plo.242.2023.07.18.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:39:48 -0700 (PDT)
Date:   Tue, 18 Jul 2023 22:09:41 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH v2] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4
 boards
Message-ID: <ZLbATQRjOl09aLAp@zephyrusG14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue affecting the Wifi/Bluetooth connectivity on
ROCK Pi 4 boards. Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
on ROCK Pi 4 boards") introduced a problem with the clock configuration.
Specifically, the clock-names property of the sdio-pwrseq node was not
updated to 'lpo', causing the driver to wait indefinitely for the wrong clock
signal 'ext_clock' instead of the expected one 'lpo'. This prevented the proper
initialization of Wifi/Bluetooth chip on ROCK Pi 4 boards.

To address this, this patch updates the clock-names property of the
sdio-pwrseq node to "lpo" to align with the changes made to the bluetooth node.

This patch has been tested on ROCK Pi 4B.

Fixes: f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth on ROCK Pi 4 boards")
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>

---
Changes in v2: Added the Fixes tag as per feedback from Vincent Legoll
	       <vincent.legoll@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 907071d4fe80..795a70948d9a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -45,7 +45,7 @@ led-0 {
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk808 1>;
-		clock-names = "ext_clock";
+		clock-names = "lpo";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable_h>;
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
-- 
2.34.1


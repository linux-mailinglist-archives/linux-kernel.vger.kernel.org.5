Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E169754E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGPJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:31:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A5BA;
        Sun, 16 Jul 2023 02:31:26 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89d47ffb6so19158685ad.2;
        Sun, 16 Jul 2023 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689499886; x=1692091886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAEW5pBQpGEQa8+u+L9FSRTp3sQn8Q/V86sBZoZsPWQ=;
        b=l6RwRWzaknd6B76niiuL3tAR63PuV1iQSjFKFJXxADmQb4HesnoyQ447/WNd4TUcO6
         XATKCziG9vWxMed+uSYI0nDY901HvvRQdJlAETW6bwI+GaFGfsR6yJpEQqdJ+U0ay0+W
         0CwrvCc3JTkBzqTM/gPZOgHYYgVf/TnJDOCxKIXFO3EgW5HKFXKYnrDdPkP3tN//SC5o
         rE7IIgz7ANUGNYdgbKHmLhxbJj5Hg+Q+Ai9AvZ2m/qLmj8HfNj5ddXWulXeOSXHc/WGU
         os6aCBAz8ugrM3R+5w/KlXe2yoPjQ2jOpjxBoiy8/BIdbvRnBCBsk4ab5hfJVly6J/wV
         R8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689499886; x=1692091886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAEW5pBQpGEQa8+u+L9FSRTp3sQn8Q/V86sBZoZsPWQ=;
        b=eR+7hxRHsU4HY7JdmCVXr03PcIqKVvwhZEoU8BeHu8PrejFD3xASUmUIhlZ9JOoZm+
         r6ubkXSrzdT1z9AeQpXsEE7Syp08CZc0zqYDubPzg5/Jj6KONJ59qnz2bCk6bldi9Web
         PTIBO2jTNq/7Go/WwQa6RceBKbZwudVabfMWH2Zfxxdcz447AX02Q6eKrC1kbuq6aRU6
         M85nNOc5+hYjCZsk/j/sddq3jGp2VHchCuSRgbpKpLiD34dVTYf2GFBDy59DVVodGOel
         D+oWAEt7k9ynvNjO9P41DqNFfWZeHarcvEbixQ//is9JBlQTK1Q7QvXN6dLk5GWp04mR
         9Pig==
X-Gm-Message-State: ABy/qLbiuiU/EgFbGVXh+m8PIV64+IWUEqW9RYFDZVhqBvXrKQOvJcYt
        iV3b4fiehkFbaT6OXtEsEXQ=
X-Google-Smtp-Source: APBJJlF/U3P4PPfKm/yTvfoD3FH7ic/HtRrlLwsE4DFcJwxy9JLajQ6TfObSOFUhHXjL9WuuDR2T7g==
X-Received: by 2002:a17:902:ec88:b0:1b7:fef7:d578 with SMTP id x8-20020a170902ec8800b001b7fef7d578mr7533075plg.41.1689499885772;
        Sun, 16 Jul 2023 02:31:25 -0700 (PDT)
Received: from zephyrusG14 ([103.251.210.195])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001b89f6550d1sm10662211plx.16.2023.07.16.02.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 02:31:25 -0700 (PDT)
Date:   Sun, 16 Jul 2023 15:01:19 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
Message-ID: <ZLO450xOIQ29VoBT@zephyrusG14>
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

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
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


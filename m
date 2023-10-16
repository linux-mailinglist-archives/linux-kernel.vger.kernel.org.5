Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD187CB44A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjJPUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjJPUMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:42 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336CFF;
        Mon, 16 Oct 2023 13:12:35 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qsTwu-0000QB-Q3; Mon, 16 Oct 2023 22:12:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Christopher Obbard <chris.obbard@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Yogesh Hegde <yogi.kernel@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v1 0/2] Fix i2s0 pin conflict on ROCK Pi 4 RK3399 boards
Date:   Mon, 16 Oct 2023 22:12:18 +0200
Message-Id: <169748713689.982818.14313668807415400753.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114737.494410-1-chris.obbard@collabora.com>
References: <20231013114737.494410-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 12:47:25 +0100, Christopher Obbard wrote:
> i2s0 fails to probe on my Radxa ROCK 4SE and ROCK Pi 4B boards with:
> 
>     rockchip-pinctrl pinctrl: pin gpio3-29 already requested by leds; cannot claim for ff880000.i2s
>     rockchip-pinctrl pinctrl: pin-125 (ff880000.i2s) status -22
>     rockchip-pinctrl pinctrl: could not request pin 125 (gpio3-29) from group i2s0-8ch-bus-bclk-off  on device rockchip-pinctrl
>     rockchip-i2s ff880000.i2s: Error applying setting, reverse things back
>     rockchip-i2s ff880000.i2s: bclk disable failed -22
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
      commit: 3975e72b164dc8347a28dd0d5f11b346af534635
[2/2] arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards
      commit: 8cd79b729e746cb167f1563d015a93fc0a079899

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

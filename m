Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18775FF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:52:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05BE55;
        Mon, 24 Jul 2023 11:52:44 -0700 (PDT)
Received: from [193.138.155.172] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qO0fg-0008OD-EO; Mon, 24 Jul 2023 20:52:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Yogesh Hegde <yogi.kernel@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, ivan.orlov0322@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
Date:   Mon, 24 Jul 2023 20:52:37 +0200
Message-Id: <169022470428.2905604.14514573882052237409.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZLbATQRjOl09aLAp@zephyrusG14>
References: <ZLbATQRjOl09aLAp@zephyrusG14>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 22:09:41 +0530, Yogesh Hegde wrote:
> This patch fixes an issue affecting the Wifi/Bluetooth connectivity on
> ROCK Pi 4 boards. Commit f471b1b2db08 ("arm64: dts: rockchip: Fix Bluetooth
> on ROCK Pi 4 boards") introduced a problem with the clock configuration.
> Specifically, the clock-names property of the sdio-pwrseq node was not
> updated to 'lpo', causing the driver to wait indefinitely for the wrong clock
> signal 'ext_clock' instead of the expected one 'lpo'. This prevented the proper
> initialization of Wifi/Bluetooth chip on ROCK Pi 4 boards.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards
      commit: ebceec271e552a2b05e47d8ef0597052b1a39449

and added the "Cc: stable@vger.kernel.org"

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

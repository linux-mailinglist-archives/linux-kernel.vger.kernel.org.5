Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3E67F1755
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjKTPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjKTPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:32:12 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C88CF;
        Mon, 20 Nov 2023 07:32:08 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r56Fn-0008VB-Mr; Mon, 20 Nov 2023 16:32:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Alex Bee <knaerzche@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] Add USB support for RK3128
Date:   Mon, 20 Nov 2023 16:31:52 +0100
Message-Id: <170049419905.1671702.10955033014678896611.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
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

On Sun, 19 Nov 2023 13:13:35 +0100, Alex Bee wrote:
> While interestingly the DT-binding for the Innosilicon usb phy found in
> RK3128 SoC exists already and it is exposed in the SoC DT, it has never
> been added to the driver.
> This patch-set adds support for this early version of the phy and does
> some DT-fixups in order to make the 2-port host/otg phy and the respective
> controllers work.
> 
> [...]

Applied, thanks!

[3/5] ARM: dts: rockchip: Add USB host clocks for RK3128
      commit: 759d6bd9ef94f0e658202947d44b939c6e3ed363
[4/5] ARM: dts: rockchip: Add dwc2 otg fifo siztes for RK3128
      commit: 4b12245e59efea81e19d1aa118f6f835b3e27b3a
[5/5] ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3128
      commit: fd610e604837936440ef7c64ab6998b004631647

The rk3128 binding and the phys is already defined in the binding
and devicetree, so I've picked up these, as they're independent of
the phy changes themself.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

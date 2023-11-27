Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B527FA0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjK0NXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjK0NW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5CA1BDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C29BC43395;
        Mon, 27 Nov 2023 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091376;
        bh=QwSBdJ/YKv2G0wND49Ay9xZy3Z92H53HIWkYc1/ISxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BGvd5vcG9H8ZCuQOfQzYPFnWcZqkc/t3oZVgxdS48Unv8LLEsChHioLVaXoJaV3le
         zsWTbQKCaGOAEWldbJ1GoBq680KZ3ws/DIu5/sReU1yHOG4pK5JisVHsSAxp6ootNc
         Bt2sCu01dxBxhnpwc7vE4uz7KdwF9A46rgItnp0HYWGj3CgWIhwsR9Ivv6DQXs/uO6
         HMlCF4WAp57KsxI4jwOKa9/pjnitSW8HAkSys8jB9m6aXMVlhPs+7eYC6dEFW1Y+aS
         IBmCjRhBGd6Mjoopstmdadc4zbizpY9qsjdciMcVN7LflH1ejujnGHbszfGlBvxikQ
         6KWokK75hW4Zg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH v3 0/5] Add USB support for RK3128
Message-Id: <170109137310.42627.13364867198507933834.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

[1/5] phy: rockchip-inno-usb2: Split ID interrupt phy registers
      commit: 2fda59099462ee700e424ba3ac928d13ad6389a8
[2/5] phy: phy-rockchip-inno-usb2: Add RK3128 support
      commit: 62ff41017e147472b07de6125c3be82ce02a8dd7

Best regards,
-- 
~Vinod



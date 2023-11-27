Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941777FA0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjK0NWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjK0NWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:22:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889C81AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:22:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C5C433C8;
        Mon, 27 Nov 2023 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701091347;
        bh=2JKjpQ+5QKANLP+xGmPCkybvq6kf6sMCsdtq+PhVm3o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bCbLnI25DgO/3NhVtGI6COesZn76ioTqblgX0vP1w6UCsafKA1UsKw7/uB3q5Si7E
         p3Kwxii8gLbZ2pI48nGZ95j7tCxkjRhPDeDT7MIb1pu3byNgX7F9a4EJOuREIhO0KE
         omLxzqv8kaY+/4fjVKkhTbtcao3YOMTD+yEee7TTDbDD0gN9sSx0tOisOzv+002ZU9
         NSNR9SnqbE5j0LVkbDbzY9ZBG53CmO/nLruMScsiR115l2tUbzLKTvIGkd4MoZGRKI
         eyfyZQWOIpSFd+X71z4OeyFouedfd4sC93e34la6eVNuzs3w8/gDNq1j5lW7DL4YbT
         QcrR/GgjDKUdg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
Subject: Re: (subset) [PATCH 00/31] Fix and improve Rockchip RK3128 support
Message-Id: <170109134007.42627.12929766893521974712.b4-ty@kernel.org>
Date:   Mon, 27 Nov 2023 18:52:20 +0530
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


On Tue, 29 Aug 2023 19:16:16 +0200, Alex Bee wrote:
> this series fixes some issues I found when testing my "new" RK3128 board
> with the mainline kernel and adds some core functionality like SMP bringup,
> usb and networking.
> 
> The propably most distinctive change is the split up of the DTs for the
> different SoCs of this platform: RK3126 and RK3128. Even if I'm not adding
> a RK3126 board in this series: I think this change should be done as early
> as possible in order to avoid issues in future.
> Actually it should have been done like that in the first place.
> 
> [...]

Applied, thanks!

[08/31] phy: rockchip-inno-usb2: Split ID interrupt phy registers
        commit: 2fda59099462ee700e424ba3ac928d13ad6389a8
[09/31] phy: phy-rockchip-inno-usb2: Add RK3128 support
        commit: 62ff41017e147472b07de6125c3be82ce02a8dd7

Best regards,
-- 
~Vinod



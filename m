Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9802378CCB5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjH2TNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbjH2TMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:12:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F883;
        Tue, 29 Aug 2023 12:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A621A60EEB;
        Tue, 29 Aug 2023 19:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC865C433C9;
        Tue, 29 Aug 2023 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693336351;
        bh=bRYIifLgkuUPG5p3oQ5mGo6bchndBBgLudqkZpSpN/I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AVi3GhIEibAzhB4UqxMA/KpFN/QdGTMFAE/DV5noYmVXNkgP7uMbzCZ0qqo7LifEo
         30+uX7Ku9PVqCvYWjZk03mvcDAiu5JDPgFyH0NHIKOjVq09KJRtVnQS0c15lhSXasb
         f20QyD4wVzkzJfFnekBUGsix+h9Ef14k3vEuS1jySD/BSrWbI1LyDZqpw4S/u5T+I3
         P5Q51Eo2VomZPsJnnZeeim0r0X6k67C9mBmqEEfVxbU2agpnm/6ZP8GUi2YNt3XAdn
         1IFiDf364auENySljCAo/VTO3HUE85C9HkJngJZG3IYDjmOgeXdjH9DJXRkeWswNBW
         +YD/oLsGurGiQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
References: <20230827023155.467807-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH V2 1/3] ASoC: dt-bindings: fsl_easrc: Add
 support for imx8mp-easrc
Message-Id: <169333634070.3145573.16731628887521536226.b4-ty@kernel.org>
Date:   Tue, 29 Aug 2023 20:12:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2023 21:31:53 -0500, Adam Ford wrote:
> The i.MX8MP appears to have the same easrc support as the Nano, so
> add imx8mp as an option with a fallback to imx8mn.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
      commit: b5f3cec3159dd28563e5a88096769f7b77272790

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


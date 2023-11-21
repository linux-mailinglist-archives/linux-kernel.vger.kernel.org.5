Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B237F3669
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjKUSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjKUSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:45:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD619B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:45:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DACC433C7;
        Tue, 21 Nov 2023 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700592354;
        bh=EO6luDaoUXzK9d1/iYTv3zcFJV469noLg8l0rjIvJ60=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HSACHcHsqFmT/I15b1ugu5nNPev/5uP+Z7IWJBd4FR7SWsVV8y4+sKfyqB0uxEFlc
         bfx15Z7Xh3V0+Ck9GMq7pzGksECDUE3tiIpl+/TCsoQaLV3ZBIxyVRKnpv2qaVxiNc
         dAwa8Gz3b1R8VkdC3Bkcvo5nlaCXsVNfgS5zWjfx9d7splSvkdU/lTJUQb16nVtI+u
         MlQtuVhbqq03mDxdedDyKVK72cZ1nJnQTlPnn65iAewwP3VaFT70jCQb0/udPPsAtv
         1d3Ss7ZXVxFSJWXQIe98HTwaUFhcMMpnQOJCoslosDGb51wWmeEkcWzSWZs6sv0VYA
         zYoDS6q8+ERcA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20231121052512.20235-1-chancel.liu@nxp.com>
References: <20231121052512.20235-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: sound-card-common: List
 sound widgets ignoring system suspend
Message-Id: <170059235006.1901021.2131981423033331673.b4-ty@kernel.org>
Date:   Tue, 21 Nov 2023 18:45:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 13:25:11 +0800, Chancel Liu wrote:
> Add a property to list audio sound widgets which are marked ignoring
> system suspend. Paths between these endpoints are still active over
> suspend of the main application processor that the current operating
> system is running.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: sound-card-common: List sound widgets ignoring system suspend
      commit: 27c69d7da1084af0b8b3a20ef9ff01e9eda5270c
[2/2] ASoC: imx-rpmsg: Force codec power on in low power audio mode
      commit: 5d9f746ca64c3ebfba3b650dbc4b0de705c83f3b

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


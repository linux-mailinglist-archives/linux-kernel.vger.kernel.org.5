Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E588759CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGSRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjGSRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:47:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46671FCB;
        Wed, 19 Jul 2023 10:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AAB617C7;
        Wed, 19 Jul 2023 17:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4EBC433C7;
        Wed, 19 Jul 2023 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689788831;
        bh=7kL4h42G7ZH1MZ9Zs075t+pMGhnJufVDO5ELr+Wq6PM=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=YXpV3WP66mJ6HviOlag1r7RRPg2KscCMlnHplMUaELPPR0sD2FkWFG1hV8UDPBQuK
         c2w2WcpoX+HlLTUYjS12beVuvFzqjY1q9GGyOLtI1u2aTwpcsgA1hQhNzNv6m9A6pk
         oauGJUPtRe78dzLYyPXmdsZAsCB+i3ea1NcKRPbwogB8sCfOwGkbafe1+PxZVSP3rL
         8Fg3ShLO0vnQ+06SU8Q8SLtj8RFrkrsWOvR0M9m9OuyfC1N8Vz3uiXCPbnPXR7n1r3
         WI77LuCLWCBuQvj8i/Eecx74wRCbAPa05C+jjLtCxM47APARYNilhI+5/mxmupfe7c
         Nw9FJwW6mP4ow==
From:   Mark Brown <broonie@kernel.org>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20230705190324.355282-1-andreas@kemnade.info>
References: <20230705190324.355282-1-andreas@kemnade.info>
Subject: Re: (subset) [PATCH 0/3] ARM: omap4: embt2ws: Add audio support
Message-Id: <168978882827.125745.5619053137283320178.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 18:47:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023 21:03:21 +0200, Andreas Kemnade wrote:
> Add audio support for Epson Moverio BT-200.
> In the vendor kernel, the MCBSP side is used as master,
> so do it here also that way.
> 
> Andreas Kemnade (3):
>   ASoC: ti: omap-mcbsp: Ignore errors for getting fck_src
>   ASoC: tlv320aic3x: use BCLK instead of MCLK if not in master mode
>   ARM: dts: omap4: embt2ws: Add audio support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting fck_src
      commit: 82e7c8b93a0614b1725e0ea11d0a77b04e058716

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


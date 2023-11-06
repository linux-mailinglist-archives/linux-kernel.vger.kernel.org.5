Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082667E22B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjKFNDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjKFNDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:03:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEA91
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:03:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFBFC433C8;
        Mon,  6 Nov 2023 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699275814;
        bh=owObuKCcgXmEq70pl4Bog7WiL0JeLtAQhOmCUT7KEHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MCGPBk8R+dedAi85lfupC3BaR0+vHAP+hU9XzYPIkTiGwtDlQZTR/Ne4yrrnKwSUa
         YxfJJFbnP75dAcFNCkcgWQYdC7QCtEbVRiuPsmLq5hFUAyyqPwOrT5bCUmWrxFiAwS
         2+BeTT/ORjK8iBij1MEzDgT4xhJeOimzXWvfwwqwRxoute9VYK0rIEttvfvmBmMa7h
         qgYP4tp5seMFNTSMfvWd3w0UmpUfPtw78Jfq9/4VSbul4eHwMB8EaU8IkUazYck7pD
         LCxKRWFc/BYAQp9aB2F+uNOrC6lWzakoYEjsAEyJcrDM5yd1TR1F28oEBRtH/ivV3L
         NgMxkmkYv7KuQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231106104013.704356-1-jbrunet@baylibre.com>
References: <20231106104013.704356-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: register hpd callback on component
 probe
Message-Id: <169927581290.3037292.1560531691981321378.b4-ty@kernel.org>
Date:   Mon, 06 Nov 2023 13:03:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 11:40:11 +0100, Jerome Brunet wrote:
> The HDMI hotplug callback to the hdmi-codec is currently registered when
> jack is set.
> 
> The hotplug not only serves to report the ASoC jack state but also to get
> the ELD. It should be registered when the component probes instead, so it
> does not depend on the card driver registering a jack for the HDMI to
> properly report the ELD.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdmi-codec: register hpd callback on component probe
      commit: 15be353d55f9e12e34f9a819f51eb41fdef5eda8

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


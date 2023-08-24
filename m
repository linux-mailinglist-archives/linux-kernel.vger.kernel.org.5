Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534E787906
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbjHXUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbjHXT7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D9EE6A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AF76501B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67FEC433C8;
        Thu, 24 Aug 2023 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692907179;
        bh=f35I8Lcz8ZvNMk25B59ccn0rxCT5E2m/l8Z16UXY6VU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nbU36nyz7ZRtAKM/+Mrl6qdm2MiU3UGQDQB940l3FSltE6Zhuz4UYPfdOceI5EpGL
         9X5z0d4UJHXQnhUrkV4aDseXB9z5u/9KFBxFLMXezfMb1UkzZEaIZTKnArDPq3BMRe
         F7WQ+Ld2cSGdsra42CNV0D9ErBhH76M6n6fhEAcKyNUDIPVM0cKxB6d3g4nnzRmb20
         ulhDU03IxxKkxprNiZyJ1VDPNx2csz7dGkSZbMwlEdHsoXMqwFs9yED7l39eElb4Y3
         mkckBbCmWoJ/X8qIq+EqOv+YTa1AaaPSFz3b4Dx3Tszu8oymCE1scTmzFBlAA1yB+9
         Lm5E54WEyaa6w==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        prosenfeld@Yuhsbstudents.org
In-Reply-To: <20230824011149.1395-1-mario.limonciello@amd.com>
References: <20230824011149.1395-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ
Message-Id: <169290717746.2976757.15163430161228318501.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 20:59:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 20:11:49 -0500, Mario Limonciello wrote:
> Lenovo 82SJ doesn't have DMIC connected like 82V2 does.  Narrow
> the match down to only cover 82V2.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ
      commit: c008323fe361bd62a43d9fb29737dacd5c067fb7

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


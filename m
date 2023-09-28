Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B37B2024
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjI1Ovf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjI1Ov3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:51:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7A1AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:51:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AC9C433A9;
        Thu, 28 Sep 2023 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912686;
        bh=JRSsDtLzeKIy9n8963zFa9jQq53Jmt6jQUGB+nO+3dY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KhbGXl685KDuzQMQKK4KmHyr+//v0EOw1ynKd8tpIaQUTBt/FLsLUQGAF3wnuO7F4
         clilN7rRVCPqJszpWblnzRFq3F9LMannjpSmvgnruw/ALzEryN07eD0z+iTKKOSmok
         jllSTmFRvrf3mpKFg7BMoC49YxjKfsL8TjZB/5WPfGTO5+2zvPVLsnVmmXiAjAuIPW
         L/AvAFrrn+Mb0QCMWEXIOQcaJqRjMfMU+3Kzdcc6WReBBkU4IqPM7sHR3zKAM7FEM+
         VeFnUMrVHX/JmS6NyJOgQG+Io0DyJ/lZYurUd/Z6jiXQZkORLvd7+Fzvmno++kSaSK
         0qZ0NHK/9JORw==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cy_huang@richtek.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
References: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
Subject: Re: [PATCH 0/2] ASoC: codecs: rtq9128: Add TDM input source select
Message-Id: <169591268524.2776105.13245316160946357436.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 16:51:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 11:41:06 +0800, cy_huang@richtek.com wrote:
> This patch series create a TDM source select property and use it to
> decide which TDM data source is connected.
> 
> Following by the below patch disccuion
> https://lore.kernel.org/lkml/1695780376-32301-1-git-send-email-cy_huang@richtek.com/#t
> It may not be a good choice to add the user controlable mixer control
> item. Since it follows the board design, make it as a device property.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: rtq9128: Add TDM input source slect property
      commit: bf38a0be7c57e43303600b5afc9b740882b3ed87
[2/2] ASoC: codecs: rtq9128: Add TDM input source select
      commit: 54ac512048c98b720a8fbf5899308788dff8def0

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B6781578
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbjHRWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbjHRWjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD31BD4;
        Fri, 18 Aug 2023 15:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A10CD636DE;
        Fri, 18 Aug 2023 22:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66585C433C8;
        Fri, 18 Aug 2023 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692398392;
        bh=Nse0OqiDeeow9aGXLambsveAhmESpWwoMJRYkKm94GY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t56wwAfcAmfQWhjpJxgGFzvwq+pOwBd4VpjxrobuEcfkrZc86Pn5dnkPXEQazUvCy
         2nc0tXtHujhFb2TNY+lwOW7eB2rgHlo9Dk4nx0gttFg56LybLIwgu2yPYv4M8PN9jF
         N4gX2WlgwpEh/GqaVtQuZBhLknO5KCc2VrxcpssAbMaiPJZL7UzzzNtCCtBm4ERk+E
         ZWy/48LbOW3P1E0mQprN1I3XhhGLhYc+n7bHPPxksyhMkHFEZdj12F0M05h7NpmNuR
         aiUBJCKIlDVuUsof9uaNKds3XTXDneCOmYxlOoWzL2woj6k3YJPB41o2Dja/i4fS3q
         suuulY23eC/zA==
From:   Mark Brown <broonie@kernel.org>
To:     lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v7 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-Id: <169239838812.91093.16710150349963610066.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 23:39:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Aug 2023 11:45:56 +0100, Charles Keepax wrote:
> This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> branch.
> 
> This series is mostly just a resend keeping pace with the kernel under
> it, except for a minor fixup in the ASoC stuff.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[5/6] spi: cs42l43: Add SPI controller support
      commit: ef75e767167a8f30c7690bc4689dba76329ee06e

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


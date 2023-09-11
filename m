Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13479C251
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjILCIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjILCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA001A8281;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D23C3277F;
        Mon, 11 Sep 2023 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476673;
        bh=WoSZuuZToBcsek+2qM1hUT4GFK4S9ngVS3iIz4yb0c8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uarpI7vhSp5ytnyWont9pj3X6rOugfLaoj8jWIU0g+Na2eaj0zXBTzdaEimi8dcFM
         JBYubp7AJYghYtFpkymWGTlWNDDnJilpvKEKnRrPKlR41vw0+t7PbGxuvStEE6/O/C
         eYI3P7o9TXFhOGjzX3KCJEQbacjuIUSA1y/oCKnzX/b3UCAVFpxDTw6riNLTI5c0Dp
         zAQCjAXV4Iz9HVPyE1gFZe/JO4svqitiqxeqhBH2xnkoUHkBckFaqxNK6rQcAI084R
         XnJFncvxMNLRUTulicOxkgrDW4MVPSHrBNs9j+OnzgjvSWxItXsnII5CSRHsmngl8c
         RdTz9x08jIeWA==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
In-Reply-To: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Message-Id: <169447667032.2387538.4844060984020698450.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 00:57:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 11:20:39 -0500, Vlad Karpovich wrote:
> Checks the index computed by the virq offset before printing the
> error condition in cs35l45_spk_safe_err() handler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
      commit: 44f37b6ce041c838cb2f49f08998c41f1ab3b08c
[2/4] ASoC: cs35l45: Analog PCM Volume and Amplifier Mode controls
      commit: 18050443b9fc4e809c077fbf0967349410e86117
[3/4] ASoC: cs35l45: Connect DSP to the monitoring signals
      commit: 3fecf69aa7fdf1910267dee1dbaa8ed865cf2cb6
[4/4] ASoC: cs35l45: Add AMP Enable Switch control
      commit: c3c9b17d27887f7b2f6b85d0a364b009b8436539

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


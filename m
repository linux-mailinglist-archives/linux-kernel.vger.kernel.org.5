Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C379F093
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjIMRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjIMRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:46:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6DE19AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAABC433C9;
        Wed, 13 Sep 2023 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694627202;
        bh=C69XA7WhlnFGCOFGMTb5QDKicj6hLtK+9Kr20IL8P4Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JUEWMTyAew0CYabud9NhLZvJlGPjv1y/e2NNN95RAQicKEpm6NXCVijFlNqp/Ab0Q
         gsh+0ltas9250WlXXupFNGTQghBTWk+fNRtKklquF6b+MVyAwaNxqoKgcsO0i6RxN9
         FltuYHu3jK6IV9ebTncvGo7deftNOWM+bIvLetqPsYGJ6qqq8dC9KiJBeLisAlf18j
         4iKOjE2GxpJepr6iNgoIkTSxHi1eKjAAidGIx0Z9pYOrAuvfkhIv1eb3DiaiADHff+
         /aUMY0w3S7gJX31TRd8d10Jfwag9pnI9xNBj52ki2ZuarAYfsoPxISpY35/3PlI6H4
         hvrtn+Ynv/RQQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.com, perex@perex.cz, arnd@arndb.de,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
In-Reply-To: <20230913091325.16877-1-peter.ujfalusi@linux.intel.com>
References: <20230913091325.16877-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Remove temporary string use in
 create_fill_jack_kcontrols
Message-Id: <169462719996.54382.1348437312266956494.b4-ty@kernel.org>
Date:   Wed, 13 Sep 2023 18:46:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 12:13:25 +0300, Peter Ujfalusi wrote:
> There is no need to use temporary strings to construct the kcontrol names,
> devm_kasprintf can be used to replace the snprintf + devm_kstrdup pairs.
> 
> This change will also fixes the following compiler warning/error (W=1):
> 
> sound/soc/codecs/hdac_hdmi.c: In function ‘hdac_hdmi_jack_port_init’:
> sound/soc/codecs/hdac_hdmi.c:1793:63: error: ‘ Switch’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
>  1793 |                         snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
>       |                                                               ^~~~~~~
> In function ‘create_fill_jack_kcontrols’,
>     inlined from ‘hdac_hdmi_jack_port_init’ at sound/soc/codecs/hdac_hdmi.c:1871:8:
> sound/soc/codecs/hdac_hdmi.c:1793:25: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
>  1793 |                         snprintf(kc_name, sizeof(kc_name), "%s Switch", xname);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hdmi: Remove temporary string use in create_fill_jack_kcontrols
      commit: 67a810b6f37a7805474add2d003034a288b94fa4

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


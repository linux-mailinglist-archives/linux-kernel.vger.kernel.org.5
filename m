Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C2B7ADB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjIYPdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjIYPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:33:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC6BCD2;
        Mon, 25 Sep 2023 08:33:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F977C433C9;
        Mon, 25 Sep 2023 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695655982;
        bh=UStx6NmdCQGQvwmGC5D2pyQnQNmQ94Ptm9hxFlXeGEQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uP+xAwOG82qTikxi0069W+JuYphMTlWTHxLVC58LB1BAuPZUl6oH6DesK73QurFeA
         tauJcd/mXvaI65NrsdCkWfRzGjWirYkI3XlZIbN1J9jgYEtRfrwhRE11nsYn7ZsQgQ
         aCVoZqRyHH8DpTOF+CfaJchUVy+/Q326hEen0J4ahfmnAQ0MCsy/lcMNThJNQ86uef
         Qxv1lELjU7Y+3VUzvXAU/PNl9kJQYfLoCIfZCOf9UYPtwil4Jlh4XJ58E58i0Ek1dA
         4mMA6W0O771IVk3e8c79TfXUM+WM5zY795KbrwPHPFL6KNjn0v4szrTemOzb/5rn0n
         4RaXvbVXfCwIA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <1c0090aaf49504eaeaff5e7dd119fd37173290b5.1695540940.git.christophe.jaillet@wanadoo.fr>
References: <1c0090aaf49504eaeaff5e7dd119fd37173290b5.1695540940.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: audio-iio-aux: Use flex array to simplify code
Message-Id: <169565598128.2480451.10167343100025422485.b4-ty@kernel.org>
Date:   Mon, 25 Sep 2023 17:33:01 +0200
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

On Sun, 24 Sep 2023 09:36:01 +0200, Christophe JAILLET wrote:
> "io-channel-names" is expected to have few values, so there is no real
> point to allocate audio_iio_aux_chan structure with a dedicate memory
> allocation.
> 
> Using a flexible array for struct audio_iio_aux->chans avoids the
> overhead of an additional, managed, memory allocation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-iio-aux: Use flex array to simplify code
      commit: c351835058419c1eb8791941a057c3f3e6068cb6

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


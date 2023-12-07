Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A102808FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443716AbjLGSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjLGSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:25:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8D10E7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:25:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E55C433C7;
        Thu,  7 Dec 2023 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973505;
        bh=yMiS9Pe6kPLbOYqn7iFPTCZx0Q1lRHoFloVf9IN9Jg8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=olqtFFoT+ryYEmbaNUq8qybt/oVXgscQwzGWvY4Kh91GTZTd5i/AfPMpivNbRnelC
         f6+Xkol1pnMHUM0yIfcBRbTXNd8afSt7ioT/8zZ747++Lx6zkbUkBgcQLCyRN3H6Sp
         m9Ujm/9JAaQGn3VbAj2NicOJCJSWmqcDmeJnNNVpLd0fsFYMORDH6PX85HggRjNJJS
         HSEugu6GeAo0/L55hCVOI+6V97zQj8PbWBculUrgsnwG4EAa2upk5ZC/ekB7vqD/7c
         EXWu//OjctE9a4jzi6nQK8N7qgDOVeI4I9GPd/H3pCxGuhJ3vUxMFi5hMZ0v8cW2TL
         +k4jjR1CqzBkw==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <1032216f-902f-48f9-aa49-9d5ece8e87f2@moroto.mountain>
References: <1032216f-902f-48f9-aa49-9d5ece8e87f2@moroto.mountain>
Subject: Re: [PATCH] ASoC: audio-graph-card2: fix off by one in
 graph_parse_node_multi_nm()
Message-Id: <170197350337.327814.15048120756650243468.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 18:25:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 15:42:07 +0300, Dan Carpenter wrote:
> The > comparison should be >= to avoid writing one element beyond the end
> of the dai_link->ch_maps[] array.  The dai_link->ch_maps[] array is
> allocated in graph_parse_node_multi() and it has "nm_max" elements.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: fix off by one in graph_parse_node_multi_nm()
      commit: d685aea5e0a89b66679e5266320ab2ba4378c754

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


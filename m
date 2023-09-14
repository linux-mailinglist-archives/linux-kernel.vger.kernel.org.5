Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821747A0265
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbjINLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbjINLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:19:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BA51FCE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 04:19:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1CDC433C8;
        Thu, 14 Sep 2023 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694690383;
        bh=L4aZkVJLe+acGFlr054UbgYKiGbGxVEfjTT4ozQy/zM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Xemy/p2Bng1q+bqEdjNrLrQQFsRRpa0lNmULAJpNGpQ6nhdUATmm+LFcDtdAdFCMJ
         6oM1RYbRGkejedgh+tY/8lFG3gEaQzNQgQLAeuqOr9IFlHrxdjzeGqwBqaSzNrpoeh
         Ykg86C5KI9lrkWYxgWA0HhewNoRzmNyG+D8MyFU/n6Zb/9GQeDkmVJhJnQo4G+lVEq
         n8uBRyBhyJ0aMXWGtPvz7RU3Qq9rWj1yPwgd6stLsCu6R/jRzmeDWEjXViCab25GZ8
         qCrdSDUdCQwI/x2ke8Z80bRMHK4q+FFPY64SuGd+0Uf4f9lrC4b5JS3oAfEtvtchsY
         OFMO5kB0+m/tg==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230913160523.3701189-1-rf@opensource.cirrus.com>
References: <20230913160523.3701189-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Only log list of algorithms
 in debug build
Message-Id: <169469038276.23670.6191780374716105761.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 12:19:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 17:05:23 +0100, Richard Fitzgerald wrote:
> Change the logging of each algorithm from info level to debug level.
> 
> On the original devices supported by this code there were typically only
> one or two algorithms in a firmware and one or two DSPs so this logging
> only used a small number of log lines.
> 
> However, for the latest devices there could be 30-40 algorithms in a
> firmware and 8 DSPs being loaded in parallel, so using 300+ lines of log
> for information that isn't particularly important to have logged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] firmware: cirrus: cs_dsp: Only log list of algorithms in debug build
      commit: 69343ce91435f222052015c5af86b550391bac85

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410F7C0167
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjJJQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJJQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:16:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5D94;
        Tue, 10 Oct 2023 09:16:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B90C433C8;
        Tue, 10 Oct 2023 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954615;
        bh=xy0tu/DXQ1C6+rDL2fSFMe7qK4vmfgejr0VdNHO+J8A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HWhwbc5hLf9p+N9vKNvSoe9oWeFDLyzL+J05cjC0YMH7ix4tkGnm+/NJcueYWjfww
         MgMOlVlO3mph671WkFBLiOUn0CQlWdwkjcAh7ZLidsQ/9ljw/k5KD9pdYHh5m6rVz/
         qnctC8uN5JqjxgE/3QVRTetSky1/yh4N5/tA0wcLkOBaE2CYprQdoSmS+jDggYvei1
         uq4nCIfUrJh288+WsyYwUarBWjhS9TrZCkzkBPWPARWI3/hAhiAjfj3/MFzDlZU2lz
         dUQQPbQy+H4JadN/e3NsfqhCgXjK27LXvwti7jxmg48RWJGn632i71Mx9MkfAVEEON
         2ZD6boC7h34Lw==
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20231006082104.16707-1-johan+linaro@kernel.org>
References: <20231006082104.16707-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] regmap: fix NULL deref on lookup
Message-Id: <169695461369.46031.9819352584199415131.b4-ty@kernel.org>
Date:   Tue, 10 Oct 2023 17:16:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2023 10:21:04 +0200, Johan Hovold wrote:
> Not all regmaps have a name so make sure to check for that to avoid
> dereferencing a NULL pointer when dev_get_regmap() is used to lookup a
> named regmap.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix NULL deref on lookup
      commit: c6df843348d6b71ea986266c12831cb60c2cf325

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


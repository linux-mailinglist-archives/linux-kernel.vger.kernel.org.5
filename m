Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30DA759A94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGSQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGSQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F9C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E066177A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFCAC433CB;
        Wed, 19 Jul 2023 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783442;
        bh=5gAguIUwz+hh69PG9DNBh73pWLu2XWGQ4Ih1pfJOoVs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AjM7g6F8j0RjrM9Pk1GnJ5+P7a9Vn9plcgphi/ajReXxDAqmpbhwa+IZcHWHEYEHx
         vbZkNYNC4MKPPaXs6bFer5eUtfsygBm+TR3W9LQ+mSfDWb+7j0m+o58AInpSlB13JL
         HxAt8qY4XdTfyCmNZT/3QU/6RRZv8Cw2zM1owIG36/vmoxZqG/+Jb6FExR4kIJCj5w
         xt/CrZBpSxtr/OG/suCiHFa7xMjOB/QJ2++SdKCm3oNETrQJdXMLBi28kJbWq9EUEO
         sz4qBfVGZkC3HkbHWniIB3nUu2macwXxIdze729KnBrESv9sryYeTxYS8myUYZHBKo
         n/EzYdlYeGvsA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Okan Sahin <okan.sahin@analog.com>
In-Reply-To: <20230718201453.3953602-1-u.kleine-koenig@pengutronix.de>
References: <20230718201453.3953602-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] regulator: max77857: Switch back to use struct
 i2c_driver's .probe()
Message-Id: <168978344078.94747.15299896826305461444.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 17:17:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 22:14:53 +0200, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77857: Switch back to use struct i2c_driver's .probe()
      commit: 2920e08bef609c8b59f9996fd6852a7b97119d75

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


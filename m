Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC87759A93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGSQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGSQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2555A113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCBD6171C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B6C433C8;
        Wed, 19 Jul 2023 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783440;
        bh=Nu8myV/QbaDXef9QLT+7qJpFK5fjlgc9oMw3dUeHytA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HollRyvaHgyBSVkQb7Hc6sdzXSy/jlrujpr3PYd31VDZC02CtsvAP5GV6DGEzV4hc
         X9UkddD5rkXzx6x2kpxX90uyF3nzyyq1r62qYcoMLiqRcYD/PsnWxXQjzzbq9YmCr8
         fJTAMInqWa72WRx2YArmyaNzhrtu0UzWTDZK0IX6pvTwuZSQ5kwOzlNx2dRUJ2iWFV
         6uyvm8VktITfaMNVyU22L/1TVNcueZDYxFmu9Zcx9KJ+cQFLKXKneO0jjJsQ8fA5tD
         bGfR/+S4vgbb+n+fndG7hPRkRBlT1l6lEL4EOv7KH/woOK3yTcrMxS/6o2KsTJGnud
         UdctVCyJ5CNdQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20230718193938.3593118-1-arnd@kernel.org>
References: <20230718193938.3593118-1-arnd@kernel.org>
Subject: Re: [PATCH] regulator: max77857: mark more functions static
Message-Id: <168978343922.94747.7191208693568326041.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 17:17:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 18 Jul 2023 21:39:31 +0200, Arnd Bergmann wrote:
> A few functions in the new driver are global but only used in this file:
> 
> drivers/regulator/max77857-regulator.c:209:5: error: no previous prototype for 'max77859_get_voltage_sel' [-Werror=missing-prototypes]
> drivers/regulator/max77857-regulator.c:221:5: error: no previous prototype for 'max77859_set_current_limit' [-Werror=missing-prototypes]
> drivers/regulator/max77857-regulator.c:235:5: error: no previous prototype for 'max77859_get_current_limit' [-Werror=missing-prototypes]
> 
> Mark them static, which produces potentially better code and avoids the warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max77857: mark more functions static
      commit: 541e75954cadde0355ce7bebed5675625b2943a8

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


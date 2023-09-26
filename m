Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72F7AEF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjIZPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbjIZPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:07:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370A124;
        Tue, 26 Sep 2023 08:07:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD77C433C7;
        Tue, 26 Sep 2023 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695740839;
        bh=YgyUUelmSbsG7ziMjbWSkUrWyVIsm22R5YCaeqmUTk8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bsc/9n4kTBtU/blSBxHlzKuhcsekjE7mJ1oU+xPOFgxboIeKOMJXHc9NKuG2hAXey
         NI7tGFm66OCS0u8hBFgd6ZtTk68wDNP7B2darhg9LSJecrewOrWrm5/t2CKszEIneK
         kgB8Ts7OSq5ybEw2gkDe4VhUtEUZNOU/egw6JOFwdNZd9DwyLh7mjH52kN9Rz/PhPq
         zsdBVF59crsKyXBHymqMhYs19z9iWUwNC94fYaOOIcvlyOqWynWrOnq65mDtQgXNEu
         szFkLmj7dYigiTZIWMGHoQPwDyd5Fmi/EP1sS6hBmLqQ2rObJjErPWI4aSHetryzAZ
         cjTIImow6AmIg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Vaishnav Achath <vaishnav.a@ti.com>
Cc:     d-gole@ti.com, vigneshr@ti.com, linux-kernel@vger.kernel.org,
        u-kumar1@ti.com
In-Reply-To: <20230926113812.30692-1-vaishnav.a@ti.com>
References: <20230926113812.30692-1-vaishnav.a@ti.com>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Fix hardcoded reference clock
Message-Id: <169574083816.2649563.11311626349884860645.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 17:07:18 +0200
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

On Tue, 26 Sep 2023 17:08:12 +0530, Vaishnav Achath wrote:
> A hardcoded reference clock of 48 MHz is used to calculate the
> clock divisor values, but the reference clock frequency can be
> different across devices and can be configured which can cause
> a mismatch between the reported frequency and actual SPI clock
> frequency observed. Fix this by fetching the clock rate from
> the clock provider and falling back to hardcoded reference only
> if the clock is not supplied.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Fix hardcoded reference clock
      commit: 2d9f4877988f64f0f336983de65c365b6a7debfb

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


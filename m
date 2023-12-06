Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3C807A11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379601AbjLFVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379738AbjLFVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:04:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C4AD5F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:04:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574B0C433C8;
        Wed,  6 Dec 2023 21:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701896693;
        bh=94SZSPJZpvqNb+Dqplrc7acGNMOWcuO8uMo8tuWo0BQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=pVARSB5Afh+DogF3yO3ISxtEFB8+UrBROK3I5PzzGrNWkPJxnOAE4syU8wwVWTfMw
         6JWqoDPoJCkcq75Epc0ewYdeUplb69Y6EO6lsTnYGkc9Oivab+Vup6fHB+89tMqTjw
         KuuAgMQniewFv2b/4xVtCuyiH+rza0RtwJ860T8DFQbgLDMoAKj2r6p3cE6xaWMRFa
         zdLoe3hWUrukmmJNHDJKT2W3EpFo48QW4SpM7NLBawhhUAaIJqScNVJ5CDhwKp38rF
         gtUDmFDdFJNB0g3I+M2+kyvFx3X9lgPxVdkyLNUgfDjSZ8tzm++YULHTTR0u2sP3L5
         UIW4CmVX+O2bg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@zonque.org, Nam Cao <namcao@linutronix.de>
In-Reply-To: <20231206145233.74982-1-namcao@linutronix.de>
References: <20231206145233.74982-1-namcao@linutronix.de>
Subject: Re: [PATCH v3] spi: cadence: revert "Add SPI transfer delays"
Message-Id: <170189669207.80266.3758979779470758907.b4-ty@kernel.org>
Date:   Wed, 06 Dec 2023 21:04:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 15:52:33 +0100, Nam Cao wrote:
> The commit 855a40cd8ccc ("spi: cadence: Add SPI transfer delays") adds a
> delay after each transfer into the driver's transfer_one(). However,
> the delay is already done in SPI core. So this commit unnecessarily
> doubles the delay amount. Revert this commit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence: revert "Add SPI transfer delays"
      commit: 7a733e060bd20edb63b1f27f0b29cf9b184e0e8b

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020337A4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjIRQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIRQFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:05:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FA46AF;
        Mon, 18 Sep 2023 09:04:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6E2C116A5;
        Mon, 18 Sep 2023 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695051952;
        bh=tIxm9zr1lCqSgOPpN3YUgZ8Lo/xG3N3FX7lR75wXaS4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=avCrAFbjTeIOVEOjs45Le4t2nh9+klfW5DfomLqHzR8I4RsbHpLNgXOB0cFIweYpo
         wo2KhEkdjR9Mepw3hsmnCdhZLo9MytMnrLoBNmpypXbXYBtRisOkOe9+DhRWighicd
         Azum7PJ2Q2zDnpyGdobBBzJlgZyQtOqY08T42/fJUfLeRM1QJsG9qgTkfnLpiBSS07
         O7xwKArkXijQw8H7eX4Sa4e7MSOd2v7KrUt+yi9R9z62nx4mvKUkbz6GGXeCnfVnTq
         MzyBrfrs/jw+2EVlxHk+wzLsSzs7RYTxl9X0HNQqWMr6IBokeGYSMR8TK4R1goKyc7
         3IeAr4UszeZBQ==
From:   Mark Brown <broonie@kernel.org>
To:     shawnguo@kernel.org, s.hauer@pengutronxi.de, festevam@gmail.com,
        linux-imx@nxmp.com, linux-psi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sre@kernel.org, Stefan Moring <stefanmoring@gmail.com>
In-Reply-To: <20230917164037.29284-1-stefanmoring@gmail.com>
References: <20230917164037.29284-1-stefanmoring@gmail.com>
Subject: Re: [PATCH 1/1] take in account bits per word instead of assuming
 8-bits
Message-Id: <169505195017.72731.8773235377055888840.b4-ty@kernel.org>
Date:   Mon, 18 Sep 2023 16:45:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2023 18:40:37 +0200, Stefan Moring wrote:
> The IMX spi driver has a hardcoded 8, breaking the driver for word
> lengths other than 8.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] take in account bits per word instead of assuming 8-bits
      commit: 5f66db08cbd3ca471c66bacb0282902c79db9274

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


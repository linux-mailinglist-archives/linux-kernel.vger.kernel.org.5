Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267979D039
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjILLjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjILLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:38:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E421723;
        Tue, 12 Sep 2023 04:38:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D6EC433C7;
        Tue, 12 Sep 2023 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518695;
        bh=PJj+NB24qGj8OVTKKzav3otPXDkniuIk97R5xoR//QY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=nUTGLWVbPda4UyLtV2EZbX9+g8D2tnomB2NpVhWSeEjwBWiOnAPTgqauYgKgrvDUz
         C/aKFhz6YYhCDUnT1zq251Qa0YKdlxNS2N62OMj5q9zI7V+Mx+mWLhQvP1O1Ck/3Uh
         YAM5IByK6aRL3XAVTSlC0bJGaQWAVfoHm9LbJpz4EQO97TYhTDURJthkR4oRJ85Hsv
         IPvqplteBNPhjUfpOOf95fx84JZyzEjhEyduKSZEMw4BO1zQu8pcXoXNJQt9ZLeiQ3
         oukPGb97sZSHNj5No73sSkGpZXJ/83a7ITe6ZT21tOc6GfdatZtzBe75ZsBGz1SPvj
         qDznyDuGj1pBg==
From:   Mark Brown <broonie@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230906132735.748174-1-valentin.caron@foss.st.com>
References: <20230906132735.748174-1-valentin.caron@foss.st.com>
Subject: Re: [PATCH] spi: stm32: add a delay before SPI disable
Message-Id: <169451869294.2398433.12354327819600702705.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:38:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 15:27:35 +0200, Valentin Caron wrote:
> As explained in errata sheet, in section "2.14.5 Truncation of SPI output
> signals after EOT event":
> On STM32MP1x, EOT interrupt can be thrown before the true end of
> communication.
> 
> So we add a delay of a half period to wait the real end of the
> transmission.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: add a delay before SPI disable
      commit: 6de8a70c84ee0586fdde4e671626b9caca6aed74

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


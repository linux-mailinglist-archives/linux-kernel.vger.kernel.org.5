Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADE80B45A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjLIMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:30:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007910E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:30:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2564C433C8;
        Sat,  9 Dec 2023 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702125036;
        bh=XRT/cv3fBxSUflS3ZmORCvFBGC0F3VAT47DfXQyREvU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CTwLMcMDFroNXU4kK/19XDeWGJAo5eyMkAk2Bq0EPMdg7QueOVDrSQbsfolVdkjTB
         GDFt66VrOG5ZasAjCkizt/3lXqE6AHMhob35Gp3sScsPoqjy2ek9x9McDYRDINu86I
         97Lf56MVLzqg3iU3O79YOoM53I8W1PZFiFXLydiKWjAVB+9MUa3+13tEJvgRIuQWkC
         BJmPM+FGnoDJYDt784N2y9y75tg8Hk2eTE6nCf39dVQ9A1gqCtGrK47I5jcjJmSvzH
         9JQhUj1stL0GvPPCd8+6vSBhQydIcQDDg3zUyCn2H1CSi21ywWGvQLWSkcS7vJtwaR
         jQ9BzJJvnqDvw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20231208185927.14124-1-rdunlap@infradead.org>
References: <20231208185927.14124-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] spi: mpc52xx: explicitly include
 linux/platform_device.h
Message-Id: <170212503507.2923765.14903539617326201742.b4-ty@kernel.org>
Date:   Sat, 09 Dec 2023 12:30:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023 10:59:27 -0800, Randy Dunlap wrote:
> Since linux/of_platform.h had included linux/platform_device.h
> and since that inclusion was removed, this driver now needs to include
> the latter header file explicitly to prevent build errors:
> 
> drivers/spi/spi-mpc52xx.c: In function 'mpc52xx_spi_probe':
> drivers/spi/spi-mpc52xx.c:396:20: error: invalid use of undefined type 'struct platform_device'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx: explicitly include linux/platform_device.h
      commit: 52c9a884c6388171f4c6cdafd9add042a7abec53

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


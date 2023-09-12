Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6F79D03A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjILLjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjILLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:38:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A31724;
        Tue, 12 Sep 2023 04:38:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6307C433C8;
        Tue, 12 Sep 2023 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518697;
        bh=HBSUSSCz7VtJdT97dhNbMYipOlAX0Lu2Batb61SCv2M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ljdUldHdWOQMgBbT1m3SWNAGwblkqdCL/y9lXLvNaBH4795/maOFvMxKLdLzaHPb2
         Q8JR434ASrr9WUWGSfrq4kfICrOUSNdz1hi+E3d5UCUsYGxJWBuIKTGqw4g2xDglQU
         WtEabO7GV9beKabrqJ+TW0rLrKBo1d0EBLVVv0rzc7nZMryQPhXnK+MSTnj/HfWi+u
         4zpErQYzW6qgcjEFT4TWHWh/oC8bN1mUbt+VANLnsA6I0czoySELJECiX0igdXl3tq
         s3kE7rDnXG4jbBs5UBOg7rXsLS9/vedkhWpyU5gdONtcmM1+EPKaIV5ZbEJkfpQxRL
         uMAiDIxS6OIdQ==
From:   Mark Brown <broonie@kernel.org>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230906183254.235847-1-han.xu@nxp.com>
References: <20230906183254.235847-1-han.xu@nxp.com>
Subject: Re: [PATCH] spi: nxp-fspi: reset the FLSHxCR1 registers
Message-Id: <169451869509.2398433.14593784454903945016.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 12:38:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023 13:32:54 -0500, Han Xu wrote:
> Reset the FLSHxCR1 registers to default value. ROM may set the register
> value and it affects the SPI NAND normal functions.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: nxp-fspi: reset the FLSHxCR1 registers
      commit: 18495676f7886e105133f1dc06c1d5e8d5436f32

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


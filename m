Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54190769971
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGaOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGaOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F7AB3;
        Mon, 31 Jul 2023 07:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4239461184;
        Mon, 31 Jul 2023 14:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6875C433C8;
        Mon, 31 Jul 2023 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690813526;
        bh=qCfflXFGYhn43P6n1KQI8WSYPLhbVuUpK+kcLC8wKz0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WWS3ykmV+4XOl3dMwArWTJnZV2Hf1rfM17pDDR+aP+bS2eCzG+2SKCEEA+gnbNPPX
         gVfeFbwcsIAI6RKKiEcQcIVZczpczv7+J0Z530pyi7N8Z+MkTKL4Xu+79wDnBOPngZ
         kMk0me1dNdxI7c7RUE8/XfkPX/Ycer/EFr5LTPefpHjF593ESy6PW/bEPNtUt7KTdb
         92LP9ZEYJje0geskmjgzUlyCPMrHLs0G4L298UKu4iQW7sXfEov7rYjxuQ1mt9tLVQ
         5MialwJ6ogiiTTJq4d7pxPYk2K7ScjPSXwTexZMrvCbwZzf/KpLeSYE+OHVqWYRQFG
         TMG24gi9TnYqw==
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wang Ming <machel@vivo.com>
Cc:     opensource.kernel@vivo.com
In-Reply-To: <20230726105457.3743-1-machel@vivo.com>
References: <20230726105457.3743-1-machel@vivo.com>
Subject: Re: [PATCH v2] spi: Use dev_err_probe instead of dev_err
Message-Id: <169081352446.53208.1309498212353397667.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 15:25:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 18:54:47 +0800, Wang Ming wrote:
> It is possible that dma_request_chan will return EPROBE_DEFER,
> which means that dev is not ready yet. In this case,
> dev_err(dev), there will be no output. This patch fixes the bug.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Use dev_err_probe instead of dev_err
      commit: 893aa09ee5959533d8e51e06b1bde35286edaf70

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


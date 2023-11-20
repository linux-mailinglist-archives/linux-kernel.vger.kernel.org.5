Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF567F1930
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKTQzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjKTQzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:55:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E1BA;
        Mon, 20 Nov 2023 08:55:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE8C433C8;
        Mon, 20 Nov 2023 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700499340;
        bh=MGF7xaDM2yhd8xR3ZAVbFdVe7AAYUmj0We9ffdF28qc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hoHroQ0Bqn+Vo82WU7c9eiB+RslcmRK597GhGPEVVJf+QtWeqGixaNvg0bk7MthF5
         AIoEMPIes4JVVMsWNPy1aHuxaU/sg9rAyY1/aVF4eVx4fwjuxKTwX266971pEvwkuK
         Imvugym29y6DGTnnlUVoNYDCV6NCkyONVEJMBU2RpHgF314VFIv1/EGhVqb7Y2Eb9K
         XssE7aEfa7LFGiMJ6U6PDF4U2liuNJgnVMYEgibzGKGUjZOk3FjomYA8TMZoE+APhf
         C3BI3G/XTZhWN+psJOLr+KZefRIRIi2saLfnp2jUBGF8EYxq57+V6gvnwVOlADBXZE
         BzCfY/Wh3FaXA==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <1c88236b5d6bff0af902492ea9e066c8cb0dfef5.1700391566.git.christophe.jaillet@wanadoo.fr>
References: <1c88236b5d6bff0af902492ea9e066c8cb0dfef5.1700391566.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: ingenic: convert not to use
 dma_request_slave_channel()
Message-Id: <170049933886.658720.721164714596647527.b4-ty@kernel.org>
Date:   Mon, 20 Nov 2023 16:55:38 +0000
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

On Sun, 19 Nov 2023 11:59:50 +0100, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ingenic: convert not to use dma_request_slave_channel()
      commit: d3bb2cb0f1769cb3424f3102ebcde51d18065424

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


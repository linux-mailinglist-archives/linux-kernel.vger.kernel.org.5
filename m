Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFDD774B94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjHHUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHHUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3FA1B504
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419FE62C84
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB5FC433C7;
        Tue,  8 Aug 2023 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691526764;
        bh=pDMRaXMeynTWgnbfoi29Uj6rm3vA/DA1SfJXMvjCNQ4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ikKSBR4G7MvGNdJOpj3nCzxVtUfGld0pGUOCGqHa9h3ZqMXK9M+Fyfol3ileKB4tP
         fBFOQGLC4vQnJeL1f2KSt9Fjk5nkAzZ/nAaCJ4181VnHwHDKSixf3V/u9+JlsBmS/m
         gBNMG47RBC16fGTd9HzT6MYA7GgDswSCrYzqM3nhbX6apGQQZyd/5kDJssbZjoCrGH
         nnlOjXb37omvItTTzc5aqchjfBk5r87TxpnKV3FffzGAGX3VOKuomwLPnVWaQaLAkC
         P0pLda4fvjktfVa8kNxZnL2PhQfAaE9BgHpUFnn8DBf+XbvSRexL9IxLgC+KrIraUo
         nVc2dQT1RxJQg==
From:   Mark Brown <broonie@kernel.org>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        Yu Liao <liaoyu15@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        liwei391@huawei.com, tiwai@suse.com
In-Reply-To: <20230808132519.637452-1-liaoyu15@huawei.com>
References: <20230808132519.637452-1-liaoyu15@huawei.com>
Subject: Re: [PATCH v2 -next] ASoC: pxa: address unused variable warning
Message-Id: <169152676291.192712.2528202966433056507.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 21:32:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 21:25:19 +0800, Yu Liao wrote:
> gcc with W=1 reports
> sound/soc/pxa/pxa-ssp.c:594:15: warning: variable 'acds' set but not used [-Wunused-but-set-variable]
>                                             ^
> This variable is not used so remove it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pxa: address unused variable warning
      commit: a932f45a1832d18fb64704636a958ef993a1d1da

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


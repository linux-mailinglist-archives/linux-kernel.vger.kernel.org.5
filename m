Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD97EF666
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjKQQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346116AbjKQQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:42:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40DD4B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:42:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400B0C433C8;
        Fri, 17 Nov 2023 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700239357;
        bh=0YO3W1z2caIL7bIq90ttl4T3ywvbM+YloArMTAnEaxU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Mz6s4cXinGnAZ+ilnphcYBrJqFdAtJ/lw0ZuBJYZNN9co6pIjsm6jTNi3/jnU7x9w
         ww8hOKh0A+mLjU5Fxznd93aRh+d/5L++/CHWVidqgvzlMZYyXB5Oq0S5/IeVjLwQyk
         kqNk16Vm+8SjXyddUpDYjbpXATkk32a0EPMid2cCOJBeWs/4CnqBAtZxOeC+xw/0GE
         4vnz5tEbsCWujVvZREFVCyNFwnDasEz/wUqwYUN1eu9MYW/b9sALmLeXI5gGaaU+LN
         94KVvDkYXaloq7X1UlWn7lXiLhjaJy+lLwu4/eSnZYTi6YnaAzblVxSiX0IHnWLjZc
         xbdjxa73df7OQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Lin <CTLIN0@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
        ctlin0.linux@gmail.com, kernel test robot <lkp@intel.com>
In-Reply-To: <20231117043011.1747594-1-CTLIN0@nuvoton.com>
References: <20231117043011.1747594-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8822: Fix incorrect type in assignment and
 cast to restricted __be16
Message-Id: <170023935469.1567036.15285427485660372538.b4-ty@kernel.org>
Date:   Fri, 17 Nov 2023 16:42:34 +0000
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

On Fri, 17 Nov 2023 12:30:12 +0800, David Lin wrote:
> This issue is reproduced when W=1 build in compiler gcc-12.
> The following are sparse warnings:
> 
> sound/soc/codecs/nau8822.c:199:25: sparse: sparse: incorrect type in assignment
> sound/soc/codecs/nau8822.c:199:25: sparse: expected unsigned short
> sound/soc/codecs/nau8822.c:199:25: sparse: got restricted __be16
> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
> sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16
      commit: c1501f2597dd08601acd42256a4b0a0fc36bf302

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


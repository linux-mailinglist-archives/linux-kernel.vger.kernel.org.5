Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEFE75D0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGURlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGURla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB030D1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC4561D76
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA1C433C7;
        Fri, 21 Jul 2023 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961280;
        bh=AseNTTO1fNzLwHCUFZunwFpmEDAVElunA65MkuhBqpQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZBG3st0HCf/9jk1jqEKFgQo7RwciU5pVzUiYsT7CXkMspKlW132pBa//y87m+vl2W
         cyla7r9KeId5pvY6bOwaye4Dq2VDGA8kx4vwqpYHnS3pnbmTOqfo7m3MMJPUrw9gU0
         9uEmVdGFmNzfsR6gRYwA1B216YNkMOimixEWIQT5XKbg5vDhR//7K0BHtZqR9lvGTm
         52Fs2Jna/v8cUWvz3xojb4ypDoEtvMazHh+bRfcznAku+XqXnfyUJhpX+LWuzRIV5S
         yaPLsR9vJbFxN8JUeUHQ4GGzIFLicd0XuVTiNvLrvCRRbpZafIAbBL4noeD6n5B2h9
         cHSn9pTEGfV2g==
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230721-regmap-enable-kmalloc-v1-1-f78287e794d3@kernel.org>
References: <20230721-regmap-enable-kmalloc-v1-1-f78287e794d3@kernel.org>
Subject: Re: [PATCH] regmap: Remove dynamic allocation warnings for rbtree
 and maple
Message-Id: <168996127928.147835.16755202438819557381.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 18:41:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 17:31:36 +0100, Mark Brown wrote:
> Thanks to Dan and Guenter's very prompt updates of the rbtree and maple
> caches to support GPF_ATOMIC allocations and since the update shook out
> a bunch of users at least some of whom have been suitably careful about
> ensuring that the cache is prepoulated so there are no dynamic
> allocations after init let's revert the warnings.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Remove dynamic allocation warnings for rbtree and maple
      commit: e02a4ccbeced64aa10f4e99683c721ec43e993c1

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


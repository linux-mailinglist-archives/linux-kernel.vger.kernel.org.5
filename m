Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33598773E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjHHQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHHQYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1DA241;
        Tue,  8 Aug 2023 08:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451526257C;
        Tue,  8 Aug 2023 15:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64EBC433C7;
        Tue,  8 Aug 2023 15:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691508859;
        bh=iqdb9o7NG0Q4Ny5jzGBS3IGcKFC7L9BhBviEVEUTXPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Zxv8glbioSr2Ps5ajogqX6df0q9ghE+A+CKgBFN4rJn5VxUpy7+dVtNunzeoR+L78
         gLOSxbkm3gf0MJER16gJ6TReloKuf2/aCaQ8odq35RnTLyileHwdVj0+PvA0COkm+y
         GlKqrsyvSD8K9C9+EYvmb8nTeaUFXCYlbek8sEp9G9eJpZs3ZagKn6n+DOa/LW9nwY
         GDFTlWOSaveczzWYlr+xUXVRKjtYyro20PlTQfZdP8VHIQwBK18xZf+VOxxoy+uAh5
         60+iYi9cRax3xMpCO5axaL/GFLb/nPRsCTASeeoAZbXGugxSizoIJR2BP49p3IYv2h
         ffbPr8kOdFMnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
References: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] spi: dw: Set default value if reg-io-width isn't
 specified
Message-Id: <169150885852.58102.6432343415096180168.b4-ty@kernel.org>
Date:   Tue, 08 Aug 2023 16:34:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 09:16:21 +0900, Kunihiko Hayashi wrote:
> According to the dt-bindings, the default value of reg-io-width is 4.
> However, the value becomes zero when reg-io-width isn't specified.
> 
> Should set the actual value to dws->reg_io_width, considering it
> referenced.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw: Set default value if reg-io-width isn't specified
      commit: 2ca03ecc9c8556e913aef6f381154721dec4e44b

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


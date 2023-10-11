Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D17C522D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjJKLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjJKLeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:34:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5D88F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:34:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3F8C433C7;
        Wed, 11 Oct 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697024089;
        bh=T77Zw4Ow+fGootlr3AzajNul/Y31eLQDixkQ42a4Eco=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W7vdqLtxGJGwwnSXxh3fxZies3A93UQ3lYTZM+wU7N7228PCEfJGYy2ELwzOLOc2a
         EDSCKOpzaQ2JU7gQhdxNXqDqTrHP768IGb+VN2n5eTojP87zFqflHI+VnsFQkDKpiC
         jwgl9+HUi0uBT59x/heygfMxV3+hM/L8FXixl4B+Hk40JNRcwAv0kQjdQM4KEul5YM
         LKY3icUnaKUsQixaXvS+ldrXHf/M9oY/mq5w2Dn2ZIbIF4WIbS9zChvPv+PddmErve
         yuwwsT5N9+X2N6pUEf7UOc70fjj7QCj3ADZdBpE+ybZ6iIZJTxjOeQPIT3H6FzZ9EL
         40KFZpnvC53bA==
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175050.work.819-kees@kernel.org>
References: <20230922175050.work.819-kees@kernel.org>
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-Id: <169702408624.29318.955313379054643924.b4-ty@kernel.org>
Date:   Wed, 11 Oct 2023 12:34:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:50:50 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mca_data.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: apple: mca: Annotate struct mca_data with __counted_by
      commit: 59825951707eccf92782e109c04772d34fc07eb6

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


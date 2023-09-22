Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D27ABBBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjIVW1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:27:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF34919A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 15:27:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B58C433C7;
        Fri, 22 Sep 2023 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695421630;
        bh=g6ZipImHzWeQiovS+WeBEOUiNBPw8TjA4wZva4vwMxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kQ0ugVXT6IG62g8lFiHVfHvw0avcgkgrYfcfZTfUKrJEE1ykxMJlQmYC3fOnfZvjY
         Xga9J7ldCfdYasLoOMErX/JMZ++NV5pfbXKUx/t0PoArfawup8tgNuQqcdOxpATaPF
         k9eJKWsel5ZDs1dxT3VG5xXQ9W5lkuNofD0ySeEZGP3anqvn3S3tfUHijgJx6c0sQv
         2FByppArjU0RsKG9QM2Eu+TsjgTZdEHktA5EXU2vf3YzFaqK92rRDDYppmRsVF9Akv
         HzZqA3GJzaShqwBHPHB6CVshCG+OS4JO2qfH3bRqI+jiXxuLk6/gXUolnyXxYx1/9h
         q8EU8aZhM27Hg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175402.work.819-kees@kernel.org>
References: <20230922175402.work.819-kees@kernel.org>
Subject: Re: [PATCH] regulator: mc13xxx: Annotate struct
 mc13xxx_regulator_priv with __counted_by
Message-Id: <169542162748.66572.1754159074793629269.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 23:27:07 +0100
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

On Fri, 22 Sep 2023 10:54:02 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mc13xxx_regulator_priv.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mc13xxx: Annotate struct mc13xxx_regulator_priv with __counted_by
      commit: 6e6891ccf0c7e70f13bc1d5ce5a7edee2b5de045

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


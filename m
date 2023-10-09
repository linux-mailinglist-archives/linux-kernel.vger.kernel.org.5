Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8997BE7F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377922AbjJIR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377909AbjJIR3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:29:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02041A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:29:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867C6C433C9;
        Mon,  9 Oct 2023 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872589;
        bh=Kgq9dnbTrtqSOafpxynRJ7uEV9ANCrxny0KeGFCUYgk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dc/usC2t/uREaBFreFCshDGgxmbwLr9QptVzPzMMjGCYmcYoAFTGxNavwwYBKJaoL
         6NTDtLzY57AWszIsUepo9iQP3CZ6T5Bglkg4/zTshieZu262SRIXohnStHaBw8jJ/+
         2AzCvKCOnZ2ywspJmuYcOmE+t7DqnWnWDj5hk5XBn7yJaAeA8roT38qb9k4VvmLvFL
         Eq8RqZQolhg0fm5KPexCcL2GnB+8vIgOAGtXRT2cj1akt5411Fsy+VcPzhm1FDypKU
         5PMLw9x5RD4uTVlQU5JK90JiZU/2//pc7TTRILNvclrp0ViQp8wcjMw66kSZGG8mgR
         Ha2RVxNNx/fpA==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175330.work.066-kees@kernel.org>
References: <20230922175330.work.066-kees@kernel.org>
Subject: Re: [PATCH] regulator: da9062: Annotate struct da9062_regulators
 with __counted_by
Message-Id: <169687258725.126964.12871475282941350323.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 18:29:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:53:31 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct da9062_regulators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9062: Annotate struct da9062_regulators with __counted_by
      commit: 907f2a48359b836ff22e55eeb4a440fb9af86c10

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


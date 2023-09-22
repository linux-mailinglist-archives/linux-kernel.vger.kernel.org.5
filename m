Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10917ABAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjIVVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjIVVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:04:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECDBAC;
        Fri, 22 Sep 2023 14:03:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F126AC433C7;
        Fri, 22 Sep 2023 21:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695416634;
        bh=pSbLyjHY4h4629PeT8i8/aSNKm6+ImkuIyi0PSXCWZk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hqBNsnybSkb+lmVmvue/8XaYYcGG4OiAOjNOVGvixdSKO3JlwXRytqMCvm8ecV+TF
         bI/SF7aIjrrp9Gr4/Nemi+FkMSzoH0Np5HqgZr89OP0dm3dEoWVf8Z0TNu2RpnCA54
         oOMjzVs4n8k5oFy7Y1udpHFn/pNY/XBHzx7WzUfnKOG+mKDQRTg+MbD3u3zfCBW49q
         ACuOVMXmwX9p/j+ae1nvXBHM4d9JorOMqQrvdbkitjJDqWIYYlClf8MRyEJwcYStSE
         Z1sppg8SKtzaS0gNVQia3U+ywVBsWS94cqbK8RijeC3x4A4JeWzG/yTuvrcbammnVr
         HU2Di/YKz6Ngw==
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-spi@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175322.work.170-kees@kernel.org>
References: <20230922175322.work.170-kees@kernel.org>
Subject: Re: [PATCH] spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with
 __counted_by
Message-Id: <169541663166.63661.5167874277861773035.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 22:03:51 +0100
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

On Fri, 22 Sep 2023 10:53:23 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct pci1xxxx_spi.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with __counted_by
      commit: c40897f4730f4f9a37f3155e3e0452e1c8da37b4

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


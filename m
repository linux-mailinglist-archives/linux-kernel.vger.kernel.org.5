Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301087CAD98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjJPPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJPPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:33:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36C111
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC103C433C8;
        Mon, 16 Oct 2023 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697470404;
        bh=ReLBlkdX/Ih5s92nu5iD07eefwL3bPoRMnTYOk9amZc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YwQ2Blf0JX3WRi+CsGYYqK+p3IfDkg4CRhEaIuGeSvR0S14R+Y7SJHvYyk+IkTFHt
         m+Wz7pA8uSrYinvoDUimMJFSZxk4EeWM5vniF9VnzEypA16j8ardzeW5wL/5b51eSU
         rfPVeuWw31RPYENCGvCBtcE7DVaddwsopMBWfC/a7PGQl93l2aM3t6r5txboT/dudS
         xzwp2QpqBZR+6ddwDT+0nFyHY/2fvOugNvOL20249udCTifgyc6L3uvTuL1pd2MYhN
         a9V8BV6QyNQmb8XaZnCRdUzerR4gebGzGpikomjLjVVCGbYvzF1RE+ZsxULK9MwpJh
         D9TCFXwWaXhKw==
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <ZSRvh1j2MVVhuOUv@work>
References: <ZSRvh1j2MVVhuOUv@work>
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-Id: <169747040242.42352.2081584730958275030.b4-ty@kernel.org>
Date:   Mon, 16 Oct 2023 16:33:22 +0100
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

On Mon, 09 Oct 2023 15:24:23 -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() and size_sub() helpers, instead of the
> open-coded version, to calculate the size for the allocation of the
> whole flexible structure, including of course, the flexible-array
> member.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sigmadsp: Add __counted_by for struct sigmadsp_data and use struct_size()
      commit: 4f88c72b2479cca4a0d4de89b4cbb6f1b37ee96d

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


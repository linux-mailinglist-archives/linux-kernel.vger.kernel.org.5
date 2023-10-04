Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F160B7B8632
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbjJDROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbjJDROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CE9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:14:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E09C433C7;
        Wed,  4 Oct 2023 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696439690;
        bh=OChQRgMpKKiJhEsPPPkrmvB+lR0zGT+Qobq2Mq6I6Qc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FYabR7fWF3KDMfynzlv3jmlC69I/uZx0XOiLkUQk5nHGGn619LXB5sbiZmxdihmoz
         xCUOowb4epg7Jab4A51ETsR7II1grYC5bEqpPcwq8WrM0bWrjbhl9Fsx0HSEyqNXxU
         1A4YjYBHqxv08D8H1/8FZNozVgEwYyKyp521Epnp6x1WR5GattIBBKJo/MZOTCEvQY
         51ei3kx8p0LV7Jq7ToHDoMZK7wmic31cGHdngCqtOG8LfW2QLsMinNSu7FtRrcFPXR
         hFWmk2VVnqbH6Z1Z0viqW0pKrGvgpy3TlQZJz95ZxhXslQ0jq/ATMtwdK3wzzvwet2
         x921jJ8fdQjjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
In-Reply-To: <20231003232852.work.257-kees@kernel.org>
References: <20231003232852.work.257-kees@kernel.org>
Subject: Re: [PATCH] ASoC: soc-dapm: Annotate struct
 snd_soc_dapm_widget_list with __counted_by
Message-Id: <169643968801.45803.5943161279278436256.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 18:14:48 +0100
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

On Tue, 03 Oct 2023 16:28:53 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct snd_soc_dapm_widget_list.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by
      commit: 80e698e2df5ba2124bdeca37f1e589de58a4d514

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


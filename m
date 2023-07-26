Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D33763E26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGZSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGZSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B11FF5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E12561C00
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274A9C433C7;
        Wed, 26 Jul 2023 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690394883;
        bh=JVyjq9khiHsaa2EzqXPO6ynI006tU7vtTMC1jiwR+lg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fkGjnpPm2GN3CUoAPKXuLP9eeBpcwqunRDJ2uVsc51l75wjEbLoqZMcg4QHIVs83Q
         rMzVLrseDVPKqkWwMlUZJcll6X9W7Fnx/+W6wwc+erJDonNi87y2gbF5lDekoIujFO
         pxrJvZz03Dxwh3uz9kny7Geznh9PYBouiLp6NDk25ugUBL689MCzzqScMB3BNiHHz9
         WpSlbyNuEE2aGtDx3Zi+lCRVbu21lYb84DuS98biRiXwadpusVYPzaWtabhM4hKxvm
         duTIdYUQOjs3XodEhaXjxPRik8tBM6tfcKP77EXYels+KytNt6xnPZsr7boxBGO5i4
         e2XzKTh73t8pA==
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, justinstitt@google.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
References: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
Subject: Re: [PATCH] ASoC: intel: avs: refactor strncpy usage in topology
Message-Id: <169039488086.108395.14504873016968111035.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 19:08:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 22:08:38 +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1].
> 
> A suitable replacement is `strscpy` [2].
> 
> There are some hopes that someday the `strncpy` api could be ripped out
> due to the vast number of suitable replacements (strscpy, strscpy_pad,
> strtomem, strtomem_pad, strlcpy) [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: avs: refactor strncpy usage in topology
      commit: f6500ec12c1ec745fbec20fd4734b832bbfd4aac

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


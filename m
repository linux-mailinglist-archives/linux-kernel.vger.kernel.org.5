Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F924803A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjLDQ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344961AbjLDQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:29:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D617192
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:29:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEC3C433C9;
        Mon,  4 Dec 2023 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701707367;
        bh=4WtvMQO7czlVbQnYRym4oVON7CjNUVWJaUmSd21Ll3g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ARR8FPHhkE1qf6v2Jb2pGvUjj1qFJeDnZ++GXacPgsa3ewkg7MilOmwEIa57ervtr
         0jzuHiJnLqo72OiVNwTMWNysTV/4VQuwMQKjAitCS7UgYMn5GdkQX0uZlOTfu1Bh1j
         Jn+FMzxVk7gtBu0gicHiZOakbrZjF4MmElu+CsrLFYfH64bb+CPLtnM1k9On3/ocUH
         9RD8vkXfJWnFuaEL5K75+FoCkJPAZNXQuTyCrl+Q/kvUS7f4hrOh4UXyHc7Q7Nim58
         KFVnKxW/WEewXVbVt50BLfoomwd5t0UugEPAD3T6YDwtFsaRx1k8fS0cHXXm5n3dAj
         PjpXKLWX+zlhA==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Reichl <hias@horus.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231203222216.96547-1-hias@horus.com>
References: <20231203222216.96547-1-hias@horus.com>
Subject: Re: [PATCH] regmap: fix bogus error on regcache_sync success
Message-Id: <170170736703.96972.10213325187917313129.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 16:29:27 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2023 23:22:16 +0100, Matthias Reichl wrote:
> Since commit 0ec7731655de ("regmap: Ensure range selector registers
> are updated after cache sync") opening pcm512x based soundcards fail
> with EINVAL and dmesg shows sync cache and pm_runtime_get errors:
> 
> [  228.794676] pcm512x 1-004c: Failed to sync cache: -22
> [  228.794740] pcm512x 1-004c: ASoC: error at snd_soc_pcm_component_pm_runtime_get on pcm512x.1-004c: -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix bogus error on regcache_sync success
      commit: fea88064445a59584460f7f67d102b6e5fc1ca1d

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


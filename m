Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CFC7B2022
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjI1Ovd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjI1Ov3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:51:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04651AE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:51:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C585C43397;
        Thu, 28 Sep 2023 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912688;
        bh=chePX/SYayvnhA9C26rs98NM+t613nF7ydh4AzYC8O8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZYG51XpLTAQxCl3dQmuiHqqV5f1x/wwlk4hp8cdO5uo+sSITeMLwRS+fczhSYAP59
         rxoP58+YlzvSjiBFda423UCh/bNTY/EaL2PmSKeNSTrTndEjDoFTxoKPscsMOuQDci
         1ev0DhB0dq+0RyvgWKT0jkH42v9XEZXXnyzOcoQWi0+LMKzeU3/6q9J98d2zpvZ67e
         O/QJX3SAL8ctmlJ95Mj1ctUkykrrglXUhY5i9M5zVZU6fI7phUIUxb1ygzwskuKZH6
         P3SSaT6Zd/L/RorkaP1buhIsLBJz+QZX7imkHzBhQUoEoVCv+5a17xIcndUE0qrkSH
         GPaGJP48Pbcyw==
From:   Mark Brown <broonie@kernel.org>
To:     james.schulman@cirrus.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     david.rhodes@cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20230928085200.48635-1-jiapeng.chong@linux.alibaba.com>
References: <20230928085200.48635-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] ASoC: cs42l43: Remove useless else
Message-Id: <169591268759.2776105.1120997506461467883.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 16:51:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 16:52:00 +0800, Jiapeng Chong wrote:
> The assignment of the else and if branches is the same, so the else
> here is redundant, so we remove it.
> 
> ./sound/soc/codecs/cs42l43-sdw.c:35:1-3: WARNING: possible condition with no effect (if == else).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l43: Remove useless else
      commit: 67fcdbfd9e133be69c9541a806f6ccfe594fa9a9

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


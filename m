Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C57596EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjGSNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGSNd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB811B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F8960F80
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D842FC433C7;
        Wed, 19 Jul 2023 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689773606;
        bh=bRvmDa89F8tiiWEs4W8W25Rz7T9FiMmeQyv4PQo01ww=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Z7UhaFJWNJTQ+acILXK8LbHJN90m1mM0O9bfhS9NeWy89PpfAR3Pnltqiwx2ZDs7l
         lK+BPRHAdj+yKqiOzwqL7cKu8W95UjpeiN894kf+pOZheHU230Wc9AUfjtzFLYT5XB
         bM0nTz2xLjpnUulF5gYZ7Q6V0e8VmwhCLw37bkGpGNACHflzJ5TrPKiBDs1juOeJGm
         Nkmknf/upBUWdvxQY71zO+VgyJogGm/YazfLE0htRxwEKw54GoeAdZl0qms9skEWCf
         SakPebAR8hTqJuxAy9eArIuiTfDsYtlqmizJNwjSwGmWTl2YWscXTLiJuxhhm1US+g
         v3NCj2ip75UYg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
References: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
Subject: Re: [PATCH 0/3] regmap: Add interface for checking if a register
 is cached
Message-Id: <168977360558.39760.4789872825823703528.b4-ty@kernel.org>
Date:   Wed, 19 Jul 2023 14:33:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 21:33:02 +0100, Mark Brown wrote:
> HDA has a use case for checking if a register is present in the cache
> which it awkwardly open codes with use of _cache_only() and a read,
> provide a direct API for this.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: Let users check if a register is cached
      commit: 78908f45ccf1dc2f4d5fb395c460fdbbf7e9ac3a
[2/3] regmap: Provide test for regcache_reg_present()
      commit: d881ee5a872fd539a8c693e4c8656b9343c9aae0
[3/3] ALSA: hda: Use regcache_reg_cached() rather than open coding
      commit: 99aae70551f99536936438bbcfc562df69eeb79c

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


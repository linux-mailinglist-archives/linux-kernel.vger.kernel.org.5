Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13E80558D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjLENLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjLENLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:11:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9F129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:11:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68367C433C8;
        Tue,  5 Dec 2023 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701781911;
        bh=1TCYwVKEloYGEL2guMDbGsAh6Bv9GHm+H5QB2DEoszc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IYQDcemZy4fOvY4j6DGWriCZAhFx5utnLusxL9J8g6lMx7UGl+mr16IpLf3NrBR+u
         4zjZvGY7iEkXpsSEiC5uFTSXUOfIoTBvUDy8p+iEezUASMeSO4+zY6syRQZm6uzaGu
         +WDreO+v+Z2Lce9oE3Ndlo+muvV3Q/VQBagDCc+fq7V9AFySVsslXJTERTn7JQg0qS
         w6JweKbbPYWNxVKJ9Sh9lGL9buuE/tvN55OCeXK3+tPnJOMqZer0VWa6U62B1TpHWo
         F6c7LBsaupDWuhHBLnTLvIuH3vSLzWMww4yqaeZFykFq3tgBACRFRdjYehtCWnJHcv
         jlNbJZ0MY1O5Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc:     perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
In-Reply-To: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-Id: <170178191007.32878.14836362585756098271.b4-ty@kernel.org>
Date:   Tue, 05 Dec 2023 13:11:50 +0000
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

On Mon, 04 Dec 2023 12:47:34 +0000, srinivas.kandagatla@linaro.org wrote:
> Limit the speaker digital gains to 0dB so that the users will not damage them.
> Currently there is a limit in UCM, but this does not stop the user form
> changing the digital gains from command line. So limit this in driver
> which makes the speakers more safer without active speaker protection in
> place.
> 
> Apart from this there is also a range check fix in snd_soc_limit_volume
> to allow setting this limit correctly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ops: add correct range check for limiting volume
      commit: fb9ad24485087e0f00d84bee7a5914640b2b9024
[2/2] ASoC: qcom: sc8280xp: Limit speaker digital volumes
      commit: 716d4e5373e9d1ae993485ab2e3b893bf7104fb1

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


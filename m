Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CA275D0BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGURlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGURlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609730D4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41A9A61D6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB6BC433C7;
        Fri, 21 Jul 2023 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961271;
        bh=NGOdNal+BzVgQX0raM+ChQ6+I6DzdcNqi1bvgMhIf4E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g2Sqt0YeqnPSupYT1tWBXFQHYFVhsZ5Isk3iwch92TFbC9QZkEgN3XwJD5eyNcK2N
         0RTGXp1mKLb4fl8NtFc6zta3A01JWltbd8EKc8Su7iTTojfTNk7xj/+ppiW1820Ywq
         RG38BaORQ53XenmW/hX1FdLn3mHJADyd8rMnErxADv9srXicjWvq3qOchpq66jXO3u
         CiQJht4NS8kKwxakP+03a+AwYL/BX9D0Es6Iz+il0TngB8Sn/mTzpUYgQKaJ9GIK6k
         iyXexQYleLlhfiKYLhKZS7rfFujc4T+JCClt7bud8XHyXKzWeaxpAo64FbMIUKhVAh
         iiAOIcTpJNISw==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Stephen Warren <swarren@nvidia.com>,
        Matus Gajdos <matuszpd@gmail.com>
Cc:     Mark Brown <broonie@linaro.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230719164729.19969-1-matuszpd@gmail.com>
References: <20230719164729.19969-1-matuszpd@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Silence output on stop
Message-Id: <168996126891.147587.9119073399027050309.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 18:41:08 +0100
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

On Wed, 19 Jul 2023 18:47:29 +0200, Matus Gajdos wrote:
> Clear TX registers on stop to prevent the SPDIF interface from sending
> last written word over and over again.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Silence output on stop
      commit: 0e4c2b6b0c4a4b4014d9424c27e5e79d185229c5

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


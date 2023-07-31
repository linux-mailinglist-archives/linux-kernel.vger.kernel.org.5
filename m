Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21A876A422
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGaW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0112B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 15:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB0A16130A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506EC433C8;
        Mon, 31 Jul 2023 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690842389;
        bh=DW2FSU6rnV9IwJAsh4AWzYblSNvh3mL6+fIG/bCh92c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q259eM5ULCYIk1AxPMqc7RRJValHMgWsU2rV99DZJFrNNbEDZ8xDWdt50WUxukXE7
         ucJcQjO99VsjlyIFAi6nLGB9QyxDBIVvMGyQkRpxPas2AsA3fQ59tUAhNHr9D8b9Sw
         YJ5FV0aq2UlwqPk61w4Hn+qHiluFn7RM4Oma9pXFgMAqt6xAGD7hK88mrYUCwnPufd
         GGN+2S7zydtaczE4HN4hEtLvgIVHX/PjY0PepDf8cZuz7plCUpliJi9FYCWdkwoCIk
         AOEU6OrHkI0W4aEAdoVFNZI3iRUxYhvyhcbRUGxWwbaZ2igPQhwlrkHnJv3avh3+9V
         Xk19kGEJc0VmA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
Subject: Re: [PATCH 0/2] ASoC: wm8960: Clocking tweaks
Message-Id: <169084238738.576259.9856984284848931512.b4-ty@kernel.org>
Date:   Mon, 31 Jul 2023 23:26:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 11:47:01 +0100, Mark Brown wrote:
> A couple of minor clocking improvements that make the wm8960 driver work
> a bit better with generic cards.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm8960: Read initial MCLK rate from clock API
      commit: 0169cc3f200cbd737a57592fc478b24ff3cec3c5
[2/2] ASoC: wm8960: Make automatic the default clocking mode
      commit: 2bbc2df46e67be1a26b9c2b18a581b83e17ccb19

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


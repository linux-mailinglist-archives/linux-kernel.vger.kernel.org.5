Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C618782B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbjHUOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbjHUOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093D138
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9544617CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9DC433C8;
        Mon, 21 Aug 2023 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692627626;
        bh=zfy8G2F327LaRSMwUwL6CEsZ16UtB8P0JW9ckCJnC/E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=chEMzjYosxJWAipp0dTHL1WKwkTRYHLGNmJdZTOy/voD+HcudKBykNFfmoUbzyEal
         3ZQYV6SIfsZ4AxlaAlQqdAcWL6XzaJo/+Trvhrg3+yrOLeXi2TwjVHHyx+shKptftd
         i9cQz16q0Z19v6wcBA5uit67Y7G57u8BNk8qc3+4CUszB1LXs5ipghNMUHbIxnEwvy
         P56v47dSgcMYC26aG8+gFbhdgfki9T5hfiztCrw6+qnb2Tyl5JRO2JubBQpg+SYV89
         aOw6b7u/H1w/YA4yP0AOl8RdNqQhxHtYtN61QQrXM4G6P7SzMHJ2cYRFXF63HOYZua
         OIdJQ/gnI9LCw==
From:   Mark Brown <broonie@kernel.org>
To:     BrenoRCBrito <brenorcbrito@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        linkt <xazrael@hotmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230818211417.32167-1-brenorcbrito@gmail.com>
References: <20230818211417.32167-1-brenorcbrito@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for
 acp6x
Message-Id: <169262762417.266100.4223916224469728296.b4-ty@kernel.org>
Date:   Mon, 21 Aug 2023 15:20:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 18:14:16 -0300, BrenoRCBrito wrote:
> VivoBook Pro 15 Ryzen Edition uses Ryzen 6800H processor, and adding to
>  quirks list for acp6x will enable internal mic.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x
      commit: 3b1f08833c45d0167741e4097b0150e7cf086102

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


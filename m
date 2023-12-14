Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6298131B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573364AbjLNNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573340AbjLNNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:37:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A891123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:37:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174CEC433C8;
        Thu, 14 Dec 2023 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702561043;
        bh=O5TgA8MD5vafe0qN8lLvWfpYDU/q2IvTpt6dbdNgacg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=g9XWIkX5pkRl7TBT4gmlxHjimfT4hsCXHzEdPeejrdKwSGeP/dHhm039YlV2lK2/r
         YIQiL3tSVd7K7WTw7jecTQPoLMXBqwCrv+sSmFAj/lbwhilSNNHYEIFf1DL2brw1xU
         iS6KYL3LaeGCeZHNL+5PvMatoTf6K9ue2nJtX9KTAcm86Tugh709uBEWzMwCorBNYX
         5/cYGvLQ+VB5FN0vLHeQPz2bJZFDK3klGrwn3hz06QGSn2y7rRHm3ZSiBko0lcba8p
         qW6fLOw8J4mm4VeF2ZOONEaF/JaqeMDAlXeyJfvDFMl5e9JGq8XDMJXDnLRrr12VrL
         5MazXj1ESj/nw==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        daniel.baluta@gmail.com, alsa-devel@alsa-project.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
In-Reply-To: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
References: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH v4 0/2] ASoC: audio-graph-card2: Introduce
 playback-only/capture-only DAI link flags
Message-Id: <170256104081.58703.13815510713299468490.b4-ty@kernel.org>
Date:   Thu, 14 Dec 2023 13:37:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 10:11:17 +0200, Daniel Baluta wrote:
> This patchseries allows users to specify a link only direction with
> audio-graph-card2.
> 
> Changes since v1 - https://lore.kernel.org/lkml/20230801082433.548206-1-daniel.baluta@oss.nxp.com/T/
>      - used audio-graph-card2 instead of simple-card as we are deprecting simple-card.
> 
> Changes since v2:
>      - Fix device tree binding error reported by Rob
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: audio-graph-card2: Introduce playback-only/capture-only DAI link flags
      commit: d29351e8c20d61a852bbdfcab7bb7166bd916558
[2/2] ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only
      commit: af29e51bee8223d8b26e574489d2433b88cdeb2f

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065BB7EA10B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjKMQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:14:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBB10E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:14:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0210C433C8;
        Mon, 13 Nov 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699892089;
        bh=Wo5otqcyJKAOgLF2JvrplvCMcLhcQRTUClyysnN30PY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QBCN6bHyLufLzGNHunYTSxGt1yCYOhXVradn4REqoB/m4LPAo5evtxuAVuVLP3IOl
         AlZfMPifjMuvPIqUpy5Z3hhsTL40P8CeNTwtsc48UpMWIMuWIn/djlHO780yWF/Qt2
         f6cqFsw3EQaPLxytHq60PA8rgsH0MCEu6UWzG3ruQbZhUARlIYVQ4FGDIOj1YQabtW
         +l0CxSTsG7knD9SUrZSgEylwrxixpKxyiN+dI2Tqt278dv5GkuK3H2qcN7bKTnnBez
         DwSEt6x1dKrR5S9dXqPuk4a6iissCzdbRf0EhV3fB4hUyQckx1lNNSkmfkONVMN4ev
         mVVSH53jO33IQ==
From:   Mark Brown <broonie@kernel.org>
To:     Seven Lee <wtli@nuvoton.com>
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, conor+dt@kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
In-Reply-To: <20231107035230.1241683-1-wtli@nuvoton.com>
References: <20231107035230.1241683-1-wtli@nuvoton.com>
Subject: Re: [PATCH v4 0/2] Add DMIC slew rate controls
Message-Id: <169989208519.3289099.6577549034579346529.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 16:14:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 11:52:28 +0800, Seven Lee wrote:
> Determine DMIC slew rate via property setup.
> 
> Change:
> V3 -> V4:
>  - add "maximum: 7" description.
> 
> V2 -> V3:
>  - Update description of DMIC slew rate and remove
>    "selection" key words from property name
>  - Corrected variable name of DMIC slew rate from c file
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate.
      commit: 1fb1a7c4a6328aff97eeca513fe7239099c13016
[2/2] ASoC: nau8821: Add slew rate controls.
      commit: 91d1a18b6381abd7a0137449fe345924072e4a32

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


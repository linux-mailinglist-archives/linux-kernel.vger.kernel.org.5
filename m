Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721BF756F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1794E4F;
        Mon, 17 Jul 2023 14:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFAF61291;
        Mon, 17 Jul 2023 21:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28A5C433C8;
        Mon, 17 Jul 2023 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689631179;
        bh=L4LNILElwEJuIvZsN9V0NhiSCNz4Ki8cQsqwvuJykvo=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=QXKgOwmHlEVnNI7mc/TIk7h7m85AZuTRJ2zI7MzW+kUSv8nw7c0nIfPZw3GdADPXM
         h6mhCp1iMdTp6ujNMJLWw5wicHgBYOvLa8XCqRzRf3ne0F67BCEovoP2CyOxQo74Rf
         NIKJ8cHBUKFWgD4CTxM9rbPnQvQjZWcDWiXNchnNHdygR5a0fLkLTJENfTpkG/DAuM
         v9Y9X7zw9FmaRvTGBTmTR0zH/zlVWhn/P/GjoVdxhhK/2198ujTP/u2Mjms92yQf0D
         OvkNTk/a9dJgWA9Nm/xUqEZXcBvY6FQJK/qJcKZ5eNGEOhjTf1Fz1PWSsJPj0fCLIa
         GCvfo8sCDBS6w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20230714092913.1591195-1-chancel.liu@nxp.com>
References: <20230714092913.1591195-1-chancel.liu@nxp.com>
Subject: Re: [PATCH 0/2] Add support for rpmsg sound card on i.MX93
 platform
Message-Id: <168963117664.522208.15403610708641093351.b4-ty@kernel.org>
Date:   Mon, 17 Jul 2023 22:59:36 +0100
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

On Fri, 14 Jul 2023 17:29:11 +0800, Chancel Liu wrote:
> Support rpmsg sound card on i.MX93 platform.
> 
> Chancel Liu (2):
>   ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX93
>   ASoC: fsl_rpmsg: Add support for i.MX93 platform
> 
>  Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml | 1 +
>  sound/soc/fsl/fsl_rpmsg.c                              | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl_rpmsg: Add compatible string for i.MX93
      commit: 143f8c69a27f3fa8ed30c7f6790ea039fff57cfe
[2/2] ASoC: fsl_rpmsg: Add support for i.MX93 platform
      commit: 60f38a592efe08e5ced454e8a05f6814e6e221ec

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


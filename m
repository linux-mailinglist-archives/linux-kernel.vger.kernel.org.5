Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222375FDC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGXRbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGXRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D9171F;
        Mon, 24 Jul 2023 10:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD6061306;
        Mon, 24 Jul 2023 17:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B93C433C8;
        Mon, 24 Jul 2023 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690219896;
        bh=jTpn8Fz2iciYuoEBgv60/TBE76Imy8ifUR5muq9g77U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DMIvyyacP3iu4kLw90X2uogRzVAHkIJMHwX4GVA5ibPczcXDmaK13BggXaKR/OMiy
         eaj+YcGHkD+BTrWUqdazj3khEVqz3iu00jrN6TfQkwurf8RsAt/czhwmVOFGa2ozkr
         W3cToLVAibt9Hlb+OuOumIoxQ5gS4Jn5CgxApEXNjeOyIBOesPjqlAvMOv5BcBG1TO
         QkV8+EXAu4MA/sw2QHj5bQt0dZtkXpy2+CDbQjFQdL/rzuEhdE1PsV3ESghT1WfyQ7
         DuW8jtmYfb72Lbi0Rl2qwERvsRMzw/JA6XHG/4p683EhYVX+WTBYS+Zd4FwHnLje0+
         0Co7SDvTN9mDA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230721165027.2155528-1-quic_bjorande@quicinc.com>
References: <20230721165027.2155528-1-quic_bjorande@quicinc.com>
Subject: Re: [PATCH] ASoC: codecs: lpass: Log clk_get() failures
Message-Id: <169021989456.995610.9873876267138125933.b4-ty@kernel.org>
Date:   Mon, 24 Jul 2023 18:31:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 09:50:27 -0700, Bjorn Andersson wrote:
> The LPASS macro drivers all acquire a number of clocks, but give no
> indication when clk_get() fails, making it hard to identify and debug
> system configuration issues.  Make these drivers provide useful debug
> information when this happens.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass: Log clk_get() failures
      commit: f54e3474507427bf272bcc79c7c248c7f55d45b4

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


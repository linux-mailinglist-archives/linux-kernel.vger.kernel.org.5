Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192178032DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjLDMeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjLDMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:33:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC59A10CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:33:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64251C433C9;
        Mon,  4 Dec 2023 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701693235;
        bh=+77X1yTHGoZ6/peS7Dk73aNb2pKF+nsPMu9+E5xI4yk=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=aVwbO2l02TYFwFd16DAOemiS5rQMaHLiWSSry78cuj4+e10bzPETUZTsYcvP2m9dE
         HoHRQF8NX2PhpqEfN9pbFYDgSUpCsM1zK4IE85CoHXVSHpsb9T6L956yGaJC39I3KP
         GNzp4vkkB2XtugeISJ0Lh8A64s0/fdBMFke+CI4+Crd5wdmhJPFueYx9/stYsHwEk7
         /7FICdBFCCdCyy3x5TpUIDCsA1Y/jJMCwhIK4rvJNdm8j2RAQUzZg3BkdSzVZcxwOG
         klxFbxOT19yvUbCikt6JFVt+rZyIupxDAzmEDZay32sor+S2Jyb+daIgbIEapF2Lph
         EdxUjQlQoPUaA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231201135332.154017-1-krzysztof.kozlowski@linaro.org>
References: <20231201135332.154017-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: sc8280xp: set card driver name from
 match data
Message-Id: <170169323312.40199.10496089708040196942.b4-ty@kernel.org>
Date:   Mon, 04 Dec 2023 12:33:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 14:53:31 +0100, Krzysztof Kozlowski wrote:
> Sound machine drivers for all newer Qualcomm SoC platforms are the
> exactly same, therefore it makes sense to use same machine driver for
> newer platforms as well.  Choice of sound topology and user-space Alsa
> UCM files depends however on card driver name, which must be customized
> per each board.  Allow such customization by using driver match data as
> sound card driver name.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: sc8280xp: set card driver name from match data
      commit: 625ed9457de50d7726ccb3f2bc4e01e543ceb126
[2/2] ASoC: qcom: sc8280xp: Add support for SM8450 and SM8550
      commit: fdcaecfc71e2f4ab70ce9469f14dd64c23bf401a

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2986575C515
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGUKy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGUKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD71BC0;
        Fri, 21 Jul 2023 03:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AECF7619BD;
        Fri, 21 Jul 2023 10:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D2C433CA;
        Fri, 21 Jul 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936887;
        bh=GqMqpNt1ykUMAT67xmcy7JW79ykixqQxUJAP3ZLHy7Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=H6oKC7RnJUObIQkeWee7W1FwQF/unFVJ6PUyFra3PektbsEnuWJpN3aIT9DWNHkAT
         HE61fRsuAA1DFbxHzjKcjJ/h78pRhYedwbtyGa76cBciYQ2n6ha6+D6cLzHwxnUaBM
         ZRZyjXTaOE5a6XwmVuIH6118nrz8wHNPz8Z4eFXwv9ezB4rZ6/IZWeR+MYfU6p6CDU
         SI88R/eecOlzLiyiFlMiFIGTUMJ9vB9PNDSMyzwwHHgtaOxOldFtQ270YXykzba6XA
         wNKxzYr8KKPPG0SyUzrzEyxL4M2+Qwg7hdhpNGKaKICjDQAQ8bJ74tiTG9zD46Ykcy
         DM/Wg0FHwNwtg==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
Subject: Re: (subset) [PATCH 0/6] ASoC: codecs: msm8916-wcd-analog: Cleanup
 DT bindings
Message-Id: <168993688478.20527.15549284339710004321.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 11:54:44 +0100
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

On Tue, 18 Jul 2023 13:40:12 +0200, Stephan Gerhold wrote:
> Drop the redundant reg-names and mclk from the PM8916 analog codec.
> Having the mclk on the analog codec is incorrect because only the
> digital codec consumes it directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: dt-bindings: pm8916-analog-codec: Fix misleading example
      commit: 944b5c7146fbd0a68f501d9a8a87c3fc5767a3de
[2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop pointless reg-names
      commit: dfc491e55255a96b2d43cdb74db10d4222890769
[3/6] ASoC: dt-bindings: pm8916-analog-codec: Drop invalid mclk
      commit: 469c6d9cd1cfb468f01a15f940272504a6b5d083
[4/6] ASoC: codecs: msm8916-wcd-analog: Drop invalid mclk
      commit: 97f29c1a6143762626f4f9bd9fc2f8a2282b9dcd
[5/6] ASoC: codecs: msm8916-wcd-analog: Properly handle probe errors
      commit: 5c0f9652da47061ed3f7815c1dfeb205c545ce54

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


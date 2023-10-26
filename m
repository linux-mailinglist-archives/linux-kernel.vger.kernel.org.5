Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9EF7D8432
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345163AbjJZOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJZOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:06:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D891B1;
        Thu, 26 Oct 2023 07:06:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B39C433C7;
        Thu, 26 Oct 2023 14:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698329194;
        bh=Q4T6YNzviV/YhhhKEggjgAtYZp6sRLmfAiT+GEWyp3U=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B075zTCHd/tWysLniMnrAMRXcPLl2UYXlI+l1xr4i5FzX9y5Sks28UYfwdbmUqOoR
         BPEq2fwy80rE64HaHMSwat+FWzGVuRvUs5tnSvelnvE2hk8iMv5e26xjnzjXi2nVBr
         2Ve4wm/qYcbrJbbq63Jd+7C7dhewgI23qjPLnRlHr0JaRpnfgj/He2EPzQsmfzzKM/
         OH8p5mrRjYAZZwZu+lmxeW79yQBB/xFZbi9w3Twh2vDG3ld7pw7LbtneJrTocuBXVO
         mHUURrsbEoGTHNOFBBYL/KvaTIOqFL7fao8IkQeXq3X+unQXUVdJFTuAuAvkhGXOim
         ZuLW/+Dt99mXg==
From:   Mark Brown <broonie@kernel.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
In-Reply-To: <20231025135550.13162-1-quic_sibis@quicinc.com>
References: <20231025135550.13162-1-quic_sibis@quicinc.com>
Subject: Re: [PATCH 0/2] regulator: qcom-rpmh: Add regulator support for
 SC8380XP
Message-Id: <169832919131.118035.6543028726284946961.b4-ty@kernel.org>
Date:   Thu, 26 Oct 2023 15:06:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 19:25:48 +0530, Sibi Sankar wrote:
> This series adds regulator support for the Qualcomm SC8380XP platform, aka Snapdragon X Elite.
> 
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat
> 
> Rajendra Nayak (2):
>   dt-bindings: regulator: qcom,rpmh: Add PMC8380 compatible
>   regulator: qcom-rpmh: Add regulators support for PMC8380
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: qcom,rpmh: Add PMC8380 compatible
      commit: ae61939cdf378ae3acc5716ccb43fef3cdace36e
[2/2] regulator: qcom-rpmh: Add regulators support for PMC8380
      commit: afb823a5843e6790106fcfe5029cfa736e05007f

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


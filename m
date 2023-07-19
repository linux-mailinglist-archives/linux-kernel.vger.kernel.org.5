Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193F975A134
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGSWBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGSWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7871FED;
        Wed, 19 Jul 2023 15:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2EB61857;
        Wed, 19 Jul 2023 22:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB3C433C8;
        Wed, 19 Jul 2023 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689804068;
        bh=ZGb/L/F75EEAk4xb9XJDB34DOMqNWMaoiBCf5BKg7kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NecdG9Ph3Krgbg+CsKdXh5LepQDlhrl8ytKtLD6KedMjev4exultyLmv75OkBIM/Q
         dqruvO3Pb0r9uGnIy2To1eqkb++G2/jKuMYItQ6WkgtFQN9qU2WwrIJCTvR+HBPCnJ
         J/MGEJI7QQXCUBBzdiJPDeaytkgXk1X4+PKDcqOSWc+cNvgcdIsPaEyctrp3PE6t2U
         yKGbqIPa6j3UGBIQzEAZCzuQFzxdGqy46W35ptGm6tb6A5T2udL7wxDt9DHOU6DdM4
         3JcETakyxKSC8QdME+eH/UG49QkwsB5vEd0QHXwkJbTvXmTrQrRsdG6qICYa9AusyD
         fA8jYh6L2vWtg==
Received: (nullmailer pid 855035 invoked by uid 1000);
        Wed, 19 Jul 2023 22:01:05 -0000
Date:   Wed, 19 Jul 2023 16:01:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/6] ASoC: dt-bindings: pm8916-analog-codec: Drop invalid
 mclk
Message-ID: <168980406491.854976.10503527558613116747.robh@kernel.org>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
 <20230718-pm8916-mclk-v1-3-4b4a58b4240a@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718-pm8916-mclk-v1-3-4b4a58b4240a@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Jul 2023 13:40:15 +0200, Stephan Gerhold wrote:
> The audio codec typically used for the MSM8916 SoC is split into two
> parts: the digital codec is part of the SoC, while the analog codec is
> part of the PM8916 PMIC.
> 
> The analog codec in the PMIC has no direct connection to the mclk of
> the SoC (GCC_CODEC_DIGCODEC_CLK). As the name of the clock suggests
> this is supplied to the digital part of the codec. During playback it
> will use this clock to transmit the audio data via the "CDC PDM" pins
> to the PMIC. In this case the analog codec indirectly receives the
> clock signal through the digital codec.
> 
> GCC_CODEC_DIGCODEC_CLK is already managed by the driver of the digital
> part of the codec in the SoC. Having this clock on the analog PMIC part
> additionally is redundant and incorrect because the analog codec cannot
> receive the clock signal without going through the digital codec.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/sound/qcom,pm8916-wcd-analog-codec.yaml           | 10 ----------
>  1 file changed, 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


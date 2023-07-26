Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C787763ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjGZPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjGZPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F2FC;
        Wed, 26 Jul 2023 08:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B122A61B3B;
        Wed, 26 Jul 2023 15:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F00C433C8;
        Wed, 26 Jul 2023 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384952;
        bh=9zDz3SagJCMaLUegWEGoTDA+cWb/pILa/bDTQy9G+xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQDxUytPwExrxnMDK1NoeR5aEUldj5zSKlNSNR6ZZCSMbwQjpQasj3kzix52ujS+4
         L0W2QvjR865awdef3Owd2xrvr/BEMNLPJgblfqrYM/28fNdVf8hwHCMIQXfnrsjECw
         7wWs18fNf5FWiIIHPxRcU/4iUGM/EqNubKYP4ISthJwOH1LnUQyTkP6gtOmXBA/yi5
         gkBWeihHXrM/uHdrie0MZ/6z8SYYbmz74RIT0zKsUiN9JsCeLJIbOW5m25NPEqRfVR
         +EEk9AR60RVgxJx9oJPZzY0ELPPRgvBfQdX9R3RIYOLGj/hq29H0hOReg4PE/4OWaG
         XF6oKUslZC3ow==
Received: (nullmailer pid 1471317 invoked by uid 1000);
        Wed, 26 Jul 2023 15:22:28 -0000
Date:   Wed, 26 Jul 2023 09:22:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, linux-clk@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lux Aliaga <they@mint.lgbt>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>
Subject: Re: [PATCH v4 04/17] dt-bindings: display/msm: Remove DSI1 ports
 from SM6350/SM6375 example
Message-ID: <169038494815.1471241.4131859739067244773.robh@kernel.org>
References: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
 <20230723-sm6125-dpu-v4-4-a3f287dd6c07@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723-sm6125-dpu-v4-4-a3f287dd6c07@somainline.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 18:08:42 +0200, Marijn Suijten wrote:
> Both SM6350 and SM6375 support only a single DSI link, and don't have a
> corresponding dsi1 node in DTS.  Their examples should not suggest an
> output interface port on the display-controller node to this inexistant
> DSI host, with a dsi1_in label reference that doesn't exist in the
> example either.
> 
> Fixes: 3b7502b0c205 ("dt-bindings: display/msm: Add SM6350 MDSS")
> Fixes: 2a5c1021bc77 ("dt-bindings: display/msm: Add SM6375 MDSS")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml          | 7 -------
>  .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml          | 7 -------
>  2 files changed, 14 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


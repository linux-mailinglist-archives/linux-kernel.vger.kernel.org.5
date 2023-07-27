Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD97655A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjG0ONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjG0ONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:13:38 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC62682
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:13:35 -0700 (PDT)
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 43D5B20443;
        Thu, 27 Jul 2023 16:13:30 +0200 (CEST)
Date:   Thu, 27 Jul 2023 16:13:28 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/17] drm/msm: Add SM6125 MDSS/DPU hardware and
 enable Sony Xperia 10 II panel
Message-ID: <zvmz7i5jgrx27ildrc3tpcnrfgeivr3itv5qlwidsbr5iu5wwa@y3v2sehpw3vy>
References: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
 <169046051039.1413710.12901529844343078449.b4-ty@linaro.org>
 <6c5197c9-e24d-70ac-fd75-2c72369d8b7f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c5197c9-e24d-70ac-fd75-2c72369d8b7f@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-27 16:34:49, Dmitry Baryshkov wrote:
> On 27/07/2023 15:22, Dmitry Baryshkov wrote:
> > 
> > On Sun, 23 Jul 2023 18:08:38 +0200, Marijn Suijten wrote:
> >> Bring up the SM6125 DPU now that all preliminary series (such as INTF
> >> TE) have been merged (for me to test the hardware properly), and most
> >> other conflicting work (barring ongoing catalog *improvements*) has made
> >> its way in as well or is still being discussed.
> >>
> >> The second part of the series complements that by immediately utilizing
> >> this hardware in DT, and even enabling the MDSS/DSI nodes complete with
> >> a 6.0" 1080x2520 panel for Sony's Seine PDX201 (Xperia 10 II).
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [01/17] drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/a7e3fda5948a
> > [02/17] arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/b7d35a8eae54
> > [03/17] arm64: dts: qcom: sm6125: Sort spmi_bus node numerically by reg
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/2be52ca96a71
> 
> Of course, these two patches sneaked in by the mistake, dropped them now.

Lovely, glad to have that resolved so quickly.  Thanks!

- Marijn

> 
> > [04/17] dt-bindings: display/msm: Remove DSI1 ports from SM6350/SM6375 example
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/4be2c19261fc
> > [05/17] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC PLL0 DIV clock
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/4f86e343f3c6
> > [06/17] dt-bindings: clock: qcom,dispcc-sm6125: Allow power-domains property
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/91043642f28c
> > [07/17] dt-bindings: display/msm: dsi-controller-main: Document SM6125
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/cf5859476e5d
> > [08/17] dt-bindings: display/msm: sc7180-dpu: Describe SM6125
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/04a664dffd19
> > [09/17] dt-bindings: display/msm: Add SM6125 MDSS
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/3bde3b8f8a04
> > [10/17] drm/msm/dpu: Add SM6125 support
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/76c5dffd0bc4
> > [11/17] drm/msm/mdss: Add SM6125 support
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/de50357565d3
> > [12/17] dt-bindings: msm: dsi-phy-14nm: Document SM6125 variant
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/cdac445883cc
> > [13/17] drm/msm/dsi: Reuse QCM2290 14nm DSI PHY configuration for SM6125
> >          https://gitlab.freedesktop.org/lumag/msm/-/commit/7638d8059ace
> > 
> > Best regards,
> 
> -- 
> With best wishes
> Dmitry
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6475A0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGSVwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:52:42 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C941FD9;
        Wed, 19 Jul 2023 14:52:39 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 12D6F20388;
        Wed, 19 Jul 2023 23:52:36 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:52:33 +0200
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125
 variant
Message-ID: <wr2f6uzgam72ykgrjgalmo2h2ye2xlzgh4v3utxqed4isyfkau@aarofkuvysuk>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-10-03e430a2078c@somainline.org>
 <285facd1-bf20-aff2-b680-f796e8830038@linaro.org>
 <yzz4dddlh2no3lmuxrkuxhsuaf3brruo635pgfpnaxwffmnl6j@uk3jxtoarg7w>
 <d5f925e4-fbfe-cbb2-c3e6-8e806761d61e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f925e4-fbfe-cbb2-c3e6-8e806761d61e@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 01:01:54, Dmitry Baryshkov wrote:
> On 19/07/2023 00:00, Marijn Suijten wrote:
> > On 2023-06-29 13:54:13, Dmitry Baryshkov wrote:
> >> On 27/06/2023 23:14, Marijn Suijten wrote:
> >>> Document availability of the 14nm DSI PHY on SM6125.  Note that this
> >>> compatible uses the SoC-suffix variant, intead of postfixing an
> >>> arbitrary number without the sm/sdm portion.  The PHY is not powered by
> >>> a vcca regulator like on most SoCs, but by the MX power domain that is
> >>> provided via the power-domains property and a single corresponding
> >>> required-opps.
> >>>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >>> ---
> >>>    .../devicetree/bindings/display/msm/dsi-phy-14nm.yaml         | 11 +++++++++++
> >>>    1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> >>> index a43e11d3b00d..183a26f8a6dc 100644
> >>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> >>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> >>> @@ -19,6 +19,7 @@ properties:
> >>>          - qcom,dsi-phy-14nm-2290
> >>>          - qcom,dsi-phy-14nm-660
> >>>          - qcom,dsi-phy-14nm-8953
> >>> +      - qcom,sm6125-dsi-phy-14nm
> >>>    
> >>>      reg:
> >>>        items:
> >>> @@ -35,6 +36,16 @@ properties:
> >>>      vcca-supply:
> >>>        description: Phandle to vcca regulator device node.
> >>>    
> >>> +  power-domains:
> >>> +    description:
> >>> +      A phandle and PM domain specifier for an optional power domain.
> >>> +    maxItems: 1
> >>> +
> >>> +  required-opps:
> >>> +    description:
> >>> +      A phandle to an OPP node describing an optional performance point.
> >>
> >> I'd rephrase this to be something more exact, like 'desribing power
> >> domain's performance point'.
> > 
> > Sure.  I'll leave out the word "optional", that becomes obvious from
> > maxItems:1 without minItems, together with referencing a PM which itself
> > is already optional.
> 
> no, default minItems is equal to maxItems. It is not listing this 
> property under the required what makes it optional.

I thought it was both.

Magic.

- Marijn

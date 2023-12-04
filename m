Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D726803877
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjLDPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjLDPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:15:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225A6DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:15:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42ECC433C8;
        Mon,  4 Dec 2023 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701702943;
        bh=lKRmpWH6UR7dQ27BRS9KstFz+7kTpsRB9YknLvU8rlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vv/Fx9qEMNFV0KlnfGLl4eFeHmRhbZTXvwqMfQeFytuZoP6LN7riUBwDOB8/Ts2Yf
         Y9nkN2IRhew5Vmafw/4ybGAnsP71mb0RrZnBlThTmHHTFea4Gm6MMyYSuoGrtgbxwB
         nXnaHdMWyEwDruCaX45tD2E+jHwQ3eyInCqDvxefavWnPS3kQCabsD8PZpWtKQ5NAq
         f9FenlvEt7BYvlp03YanuX+LYWDrI0eO9eZCZqac7Je2M7IM0MuDaOgBfS/DtjqnbS
         hGpDBLPKvXpQ+4vl3C9bElr9d2DwbENkZDLCpZqb4e5yW5HZMUHqtgBHCgR7huqNDZ
         oN8R+FmDksUmg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rAAgJ-0003tX-1d;
        Mon, 04 Dec 2023 16:16:23 +0100
Date:   Mon, 4 Dec 2023 16:16:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: qcom-edp: Add X1E80100 PHY
 compatibles
Message-ID: <ZW3tR86MM0upnh9v@hovoldconsulting.com>
References: <20231122-phy-qualcomm-edp-x1e80100-v2-0-114e789f0195@linaro.org>
 <20231122-phy-qualcomm-edp-x1e80100-v2-1-114e789f0195@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-phy-qualcomm-edp-x1e80100-v2-1-114e789f0195@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:01:36PM +0200, Abel Vesa wrote:
> The Qualcomm X1E80100 platform has multiple PHYs that can work in both eDP
> or DP mode, add compatibles for these.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index 6566353f1a02..190f61c1d0f9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -21,6 +21,8 @@ properties:
>        - qcom,sc8180x-edp-phy
>        - qcom,sc8280xp-dp-phy
>        - qcom,sc8280xp-edp-phy
> +      - qcom,x1e80100-dp-phy
> +      - qcom,x1e80100-edp-phy

As was discussed here:

	https://lore.kernel.org/lkml/20231017032810.GP3553829@hu-bjorande-lv.qualcomm.com/

there should most likely only be one compatible here too as this is just
the same hardware block operating in two different modes.

Johan

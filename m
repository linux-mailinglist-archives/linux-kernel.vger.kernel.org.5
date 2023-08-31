Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A578F287
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjHaSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjHaSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:25:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F41E5F;
        Thu, 31 Aug 2023 11:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C548B82352;
        Thu, 31 Aug 2023 18:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1FAC433C7;
        Thu, 31 Aug 2023 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693506307;
        bh=mpdm3+Uw/AcG84Tn6S3nN0xqw5NePOf+tIacyG1BBEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/pgqpJ8Wyt/2JlLhmOrz9U04wwmoSheFQU6IIMCv/7Yxc6HOIKZWpVzGvdKAOq0Y
         TReVg2jxaC2MwRseCBKkno2WJ/yioMg+onzeYNBrogkHRJ1c+O7fjABxa1gRTQuC2T
         UJAHY1q32Ya0vPriQL1eNRJXMFul/TFNzn8QjGtw9fubVKUetOOYi3zURzbnSB9qPj
         ajBV1qmRKEyuwLGy5AOopaozZxO+fhkvTYLe0OFJCD9cFqQAE220lyd/f4p/c1Uag3
         vdIgwvuOoYtNRxZ3JaJqULZwlSYOGkMHBwuu+nTentgtJF4bj1VIR4UST7qVP/H78Q
         9L/gJJiERwVtw==
Received: (nullmailer pid 2547623 invoked by uid 1000);
        Thu, 31 Aug 2023 18:25:05 -0000
Date:   Thu, 31 Aug 2023 13:25:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,usb-snps-femto-v2: Add REFGEN
 regulator
Message-ID: <20230831182505.GA2541736-robh@kernel.org>
References: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
 <20230830-topic-refgenphy-v1-1-892db196a1c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-refgenphy-v1-1-892db196a1c0@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:13:51PM +0200, Konrad Dybcio wrote:
> The HSPHY is (or at least can be) one of the users of the reference
> voltage generating regulator. Ensure that dependency is described
> properly.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0f200e3f97a9..e895b6c4ee49 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -53,6 +53,9 @@ properties:
>      items:
>        - description: PHY core reset
>  
> +  refgen-supply:
> +    description: phandle to the REFGEN regulator node

Supply names are local to the device (sink name), but this seems to be 
named based on the supply source. Maybe hard to do if all internal 
stuff. What is this supplying and what's the source if not REFGEN?


> +
>    vdda-pll-supply:
>      description: phandle to the regulator VDD supply node.
>  
> 
> -- 
> 2.42.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0FD7D652F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjJYIcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjJYIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3FB0;
        Wed, 25 Oct 2023 01:32:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF53C433C9;
        Wed, 25 Oct 2023 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698222723;
        bh=3EvtUJ5jSxxg99ZPimDtfxabqbVmNmAQ52h/5Pp/l0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptuouP19h4Fln6k46PfSSy9lKo8ckzwutWDpiQMyK/hlbgrztNjE/GaxKGYo2qgSt
         fBtcIGypHyXkDyZ0oFCTNQ+dX1H/RYvYsioOOiT+8qqLcLfyXN5A/ZZczKsNurRkQr
         mvfeYB0/7qMEDHhe+9zMHh1AcFfdf3/BmXZmNoGsVMoSy17JUpLdg+q4AvpM4809mH
         XrY5Wef8yqLCCC8AWWEazUSJHnZEuTfAQGkt1848RNVhncp/GASku4DXhFDpLmTUyF
         1xjLz+i6BF+HAQCCUiSqC9LLc/3CwCstmiVrxDTgN63dSR6Qt1vs14ulKNlmGJVN3c
         lM9nGW2gZXwWQ==
Date:   Wed, 25 Oct 2023 14:01:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mailbox: qcom-ipcc: document the SM8650
 Inter-Processor Communication Controller
Message-ID: <20231025083156.GH3648@thinkpad>
References: <20231025-topic-sm8650-upstream-bindings-ipcc-v2-1-b1a4670ed6fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-ipcc-v2-1-b1a4670ed6fa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 10:25:47AM +0200, Neil Armstrong wrote:
> Document the Inter-Processor Communication Controller on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> For convenience, a regularly refreshed linux-next based git tree containing
> all the SM8650 related work is available at:
> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
> ---
> Changes in v2:
> - Fixed typo in subject
> - Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-bindings-ipcc-v1-1-acca4318d06e@linaro.org
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index cc6f66eccc84..a35f9483dc71 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - qcom,sm8350-ipcc
>            - qcom,sm8450-ipcc
>            - qcom,sm8550-ipcc
> +          - qcom,sm8650-ipcc
>        - const: qcom,ipcc
>  
>    reg:
> 
> ---
> base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
> change-id: 20231016-topic-sm8650-upstream-bindings-ipcc-0b4e1924ee28
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

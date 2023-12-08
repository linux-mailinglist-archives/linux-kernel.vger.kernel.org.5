Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194D980A11D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573528AbjLHKek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjLHKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:34:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9C1710
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:34:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF51C433C8;
        Fri,  8 Dec 2023 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031683;
        bh=3pZgEJRxT1FI/bA6lGO5jGck7die4pp5hNpMdbV10qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD4Fc59dBMH9+k0tKVg2OdsrGLMAEnnzVrR63ff7Eo1pb5VStpCROIqUvTb8Dca/o
         b1nKcDuBKzbvjCreJx1VVgyB+SIsU2bMRFp8et7nXmQKF5FmOm38+/FR6qVLhE8CJp
         mdonPbssL1BmW6perPgzh0qt0o2UdVXV/h2G6tuTYz7i9RwgJ1efsD18fv1wNo60o1
         qzJTKm20QM6m2b89ZAdP9TnQrFgau0Ikw0f+wu48DSomf2nRf1oO1BR5zD3kouo0MA
         Wa/aZkqL7wLuRd5qoNptVUVidiRAc36soc6U0cDbTAWE2J8Vgfi7fMVKwixtQ9Wm9O
         tA8XX7P8hncnA==
Date:   Fri, 8 Dec 2023 16:04:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Message-ID: <20231208103427.GA15552@thinkpad>
References: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 03:20:06PM +0100, Krzysztof Kozlowski wrote:
> There is no "resets-names" property, but "reset-names".
> 
> Fixes: 075a9d55932e ("dt-bindings: PCI: qcom: Convert to YAML")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index eadba38171e1..8bfae8eb79a3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -88,7 +88,7 @@ properties:
>      minItems: 1
>      maxItems: 12
>  
> -  resets-names:
> +  reset-names:
>      minItems: 1
>      maxItems: 12
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

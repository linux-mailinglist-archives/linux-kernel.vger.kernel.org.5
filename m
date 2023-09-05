Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D66792C26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354245AbjIERHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbjIEQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F361F46B8;
        Tue,  5 Sep 2023 09:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B90F260B99;
        Tue,  5 Sep 2023 16:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C59C433C8;
        Tue,  5 Sep 2023 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693931904;
        bh=j0OeAERZBXx25b1hoC5tIs/7DWLipKf6KPeTFzeNQqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2wjmcDbgPR3HVXF7xu8JC0qwJ7SOArNWbVujiPhOCLzDFlEFdYpQ/BDI0hiXEg9E
         mP0uivQRa7BmpqmWaCpmIwc8wPSMRMZEnbnT53FnkYIQ094Yy9mhepJxqFXqY3Zb16
         r6jaRvKXlYDDIgKNk4wD8uT1f95MLjWxKuDmmv7w0AOvIs+fXMJA2yy6o48O1EfhaO
         MVMZ9d7dykmQkpeHt0sVqJycBmmkm481DcrkOfa+NYOcSpNwrv1Hxgmw38dSn4tgYe
         MWD0+wQNRrLkn0B6ljWWY8TkJalLqRjL60tfyCzEzc9GbkaklxcmoGrIlYlrAV4oTW
         u+fvGoaSrinNQ==
Received: (nullmailer pid 3505213 invoked by uid 1000);
        Tue, 05 Sep 2023 16:38:21 -0000
Date:   Tue, 5 Sep 2023 11:38:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add
 magic tuning overrides
Message-ID: <20230905163821.GA3500273-robh@kernel.org>
References: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
 <20230830-topic-eusb2_override-v1-1-ab23825385a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-topic-eusb2_override-v1-1-ab23825385a8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:40:15AM +0200, Konrad Dybcio wrote:
> The EUSB2 repeater requires some alterations to its init sequence,
> depending on board design.
> 
> Add support for making the necessary changes to that sequence to make USB
> functional on SM8550-based Xperia 1 V.
> 
> They all have lackluster description due to lack of information.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-eusb2-repeater.yaml      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> index 029569d5fcf3..83fd6f936bf9 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> @@ -32,6 +32,27 @@ properties:
>  
>    vdd3-supply: true
>  
> +  qcom,tune-hsdisc-value:

Is '-value' redundant?

'-thres' or '-threshold' would be more descriptive.

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: High-Speed disconnect threshold
> +    minimum: 0
> +    maximum: 7
> +    default: 0
> +
> +  qcom,tune-iusb2-value:

-amplitude?

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: High-Speed trasmit amplitude
> +    minimum: 0
> +    maximum: 15
> +    default: 8
> +
> +  qcom,tune-usb2-preem-value:

We have 'hs', 'iusb2', and 'usb2'. Can you be consistent?

> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: TX pre-emphasis tuning
> +    minimum: 0
> +    maximum: 7
> +    default: 5
> +
>  required:
>    - compatible
>    - reg
> 
> -- 
> 2.42.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6437C7CCAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJQSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:31:40 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D2993;
        Tue, 17 Oct 2023 11:31:39 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so4230072a34.0;
        Tue, 17 Oct 2023 11:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567498; x=1698172298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzWRwWp3BxixilkAzmNhq2oiRa0dsZPpPZCzdqmjz/8=;
        b=QPqTy/eTa1ImV2x3KAWa5q/jEpm/6NUoDZwCOZf+1UWu9lFCeYeUlfUd9kh6VgPqDd
         hOuoeCnKhDH7ttObvA58eGGIGfvlpg9wxzOKu/PO2FRnLZfEvYbYjNMw5jM1NUvydjma
         GwFa9T/wc0G4HoNNXKuPU5NNXXgV1AWZ1rRgpBbmLs+6GmQGQWmq851EerAQECRv9dZx
         lbJ3O4+LEKtiMtq/De0Us4cyhHPphh7iaAV9tNLmSx1HRtzF69sPoPRehTAPqk7Z1XRt
         EEmhlaOMxZPH6Tacb2IexFzAUGdzxBgCDhgTDYyRWc++rSoVK3x5YxJTJ/ya8wQvhihk
         SqHQ==
X-Gm-Message-State: AOJu0Ywzz/ZvV7MrGBGqU7NHmYE/86vui8eQEghR1NmkQwGkaRHMzieT
        Ku6DK3AEMU3Q0rrhApCrnQ==
X-Google-Smtp-Source: AGHT+IGLlG3DfuJ1i4PwEW4HSVYWwjf+v63085nkwxWVjtssu00SZkvpA/2SSg7tfQCAsA1wzX9yZA==
X-Received: by 2002:a05:6830:44a0:b0:6bf:1f5f:ed18 with SMTP id r32-20020a05683044a000b006bf1f5fed18mr3883374otv.1.1697567498617;
        Tue, 17 Oct 2023 11:31:38 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a056830104700b006c6311b15f6sm346957otp.38.2023.10.17.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:31:37 -0700 (PDT)
Received: (nullmailer pid 2478778 invoked by uid 1000);
        Tue, 17 Oct 2023 18:31:36 -0000
Date:   Tue, 17 Oct 2023 13:31:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 10/12] dt-bindings: usb: qcom,dwc3: Introduce flattened
 qcom,dwc3 binding
Message-ID: <20231017183136.GA2438579-robh@kernel.org>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:18PM -0700, Bjorn Andersson wrote:
> The Qualcomm USB block consists of three intertwined parts, the XHCI,
> the DWC3 core and the Qualcomm DWC3 glue. The three parts can not be
> operated independently, but the binding was for historical reasons split
> to mimic the Linux driver implementation.
> 
> The split binding also makes it hard to alter the implementation, as
> properties and resources are split between the two nodes, in some cases
> with some duplication.
> 
> Introduce a new binding, with a single representation of the whole USB
> block in one node.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         | 482 +++++++++++++++++++++
>  .../devicetree/bindings/usb/snps,dwc3.yaml         |  14 +-
>  2 files changed, 491 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> new file mode 100644
> index 000000000000..cb50261c6a36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -0,0 +1,482 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SuperSpeed DWC3 USB SoC controller
> +
> +maintainers:
> +  - Wesley Cheng <quic_wcheng@quicinc.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      items:
> +        - enum:
> +            - qcom,ipq4019-dwc3
> +            - qcom,ipq5018-dwc3
> +            - qcom,ipq5332-dwc3
> +            - qcom,ipq6018-dwc3
> +            - qcom,ipq8064-dwc3
> +            - qcom,ipq8074-dwc3
> +            - qcom,ipq9574-dwc3
> +            - qcom,msm8953-dwc3
> +            - qcom,msm8994-dwc3
> +            - qcom,msm8996-dwc3
> +            - qcom,msm8998-dwc3
> +            - qcom,qcm2290-dwc3
> +            - qcom,qcs404-dwc3
> +            - qcom,sa8775p-dwc3
> +            - qcom,sc7180-dwc3
> +            - qcom,sc7280-dwc3
> +            - qcom,sc8180x-dwc3
> +            - qcom,sc8280xp-dwc3
> +            - qcom,sc8280xp-dwc3-mp
> +            - qcom,sdm660-dwc3
> +            - qcom,sdm670-dwc3
> +            - qcom,sdm845-dwc3
> +            - qcom,sdx55-dwc3
> +            - qcom,sdx65-dwc3
> +            - qcom,sdx75-dwc3
> +            - qcom,sm4250-dwc3
> +            - qcom,sm6115-dwc3
> +            - qcom,sm6125-dwc3
> +            - qcom,sm6350-dwc3
> +            - qcom,sm6375-dwc3
> +            - qcom,sm8150-dwc3
> +            - qcom,sm8250-dwc3
> +            - qcom,sm8350-dwc3
> +            - qcom,sm8450-dwc3
> +            - qcom,sm8550-dwc3
> +        - const: qcom,dwc3
> +        - const: snps,dwc3
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,ipq4019-dwc3
> +          - qcom,ipq5018-dwc3
> +          - qcom,ipq5332-dwc3
> +          - qcom,ipq6018-dwc3
> +          - qcom,ipq8064-dwc3
> +          - qcom,ipq8074-dwc3
> +          - qcom,ipq9574-dwc3
> +          - qcom,msm8953-dwc3
> +          - qcom,msm8994-dwc3
> +          - qcom,msm8996-dwc3
> +          - qcom,msm8998-dwc3
> +          - qcom,qcm2290-dwc3
> +          - qcom,qcs404-dwc3
> +          - qcom,sa8775p-dwc3
> +          - qcom,sc7180-dwc3
> +          - qcom,sc7280-dwc3
> +          - qcom,sc8180x-dwc3
> +          - qcom,sc8280xp-dwc3
> +          - qcom,sc8280xp-dwc3-mp
> +          - qcom,sdm660-dwc3
> +          - qcom,sdm670-dwc3
> +          - qcom,sdm845-dwc3
> +          - qcom,sdx55-dwc3
> +          - qcom,sdx65-dwc3
> +          - qcom,sdx75-dwc3
> +          - qcom,sm4250-dwc3
> +          - qcom,sm6115-dwc3
> +          - qcom,sm6125-dwc3
> +          - qcom,sm6350-dwc3
> +          - qcom,sm6375-dwc3
> +          - qcom,sm8150-dwc3
> +          - qcom,sm8250-dwc3
> +          - qcom,sm8350-dwc3
> +          - qcom,sm8450-dwc3
> +          - qcom,sm8550-dwc3
> +      - const: qcom,dwc3
> +      - const: snps,dwc3
> +
> +  reg:
> +    description: Offset and length of register set for QSCRATCH wrapper
> +    maxItems: 1

Isn't this more things now? Or the description is wrong.

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE77F44A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbjKVLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbjKVLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:03:03 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B01BB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:02:56 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cca68f6e01so2927617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700650975; x=1701255775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=judoGuVj96yz0cfO1+LrQgdiCfR9oKHOka9ldKzU/iQ=;
        b=SrQwfrirV/5VWQilXkyfyRtt5jvd+FoLmuNpVWivxbn5oUnX+jRa2MOecV/oU9La3v
         ZYH3iVBOSwd9FwY+YKEPqVMEUmxNF/GnAmWAsDKXDDwaNg6Wq8KO9yeIB4xqR1UnTmtI
         qeHFlJmciGDxuNA9QIN3z6uAQ01dbiT7dF2/ILFTee76YpuZMFdn/cW2uTxyfY13LZrx
         i+M9OAegEWqsVY/mULJWzRt9Qv8qOlbI9MNoAGxB2ZnsG/eayPJhGb8sUyJG/DiqG3Wb
         EEq2G+u8yh6yu6QTI6YKdnQqNhw9NkNsm29/ccsyPGqxBC/JHEyN5Uzg2DYSuL8Fkjl3
         gMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650975; x=1701255775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=judoGuVj96yz0cfO1+LrQgdiCfR9oKHOka9ldKzU/iQ=;
        b=fp6BZL5vXQcMqa8XcL3v0Npt5YDofCqbL3uUEFjvtOWfKw9RsbjMS2njmWREXDxq3Z
         QKJCNeoDLtYdgSXwmojm22KQFOHmPlW26bqFMEP9AKwAg/JKMfGfb3IVlKpQmeaglDUA
         wDOfVno018Y3r3umxvEO4ovVYStvru8YtgmD5cWAae5ULXMXa3Abfmxr39y/k0yx8txP
         kRNbeX5NASrjVD0K+2v6J7qKR3taErRzOOQy4iFaxsZHNFZmxU6zv4LNfLmkjt2tv2xe
         paezanbHqKzcUS2gAnXMfTZeFFncFXyPbOzWHNT4cttkJ+VwUPLQ9L8aBy3ieIsHNjWj
         LYMA==
X-Gm-Message-State: AOJu0YxyAmgq+Uel4DmopUpI/sjDgmsEWMnpOiRPkVln0Oc0BICq+Prn
        /qY2xuUtOoNorVftr/HsHUMxapQDisJmHu/MILNG7Q==
X-Google-Smtp-Source: AGHT+IG7QtdXMD/IbuQvfyaSezE4/wn9Rzi9wEyWCao4R2S63hXyZv7aDlf2lJ46E658E4CV4osFbPqMxC2QwFZs1R8=
X-Received: by 2002:a81:93c4:0:b0:5a8:2037:36d9 with SMTP id
 k187-20020a8193c4000000b005a8203736d9mr1961750ywg.25.1700650975747; Wed, 22
 Nov 2023 03:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231122-phy-qualcomm-eusb2-x1e80100-v1-0-ce0991161847@linaro.org>
 <20231122-phy-qualcomm-eusb2-x1e80100-v1-1-ce0991161847@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-eusb2-x1e80100-v1-1-ce0991161847@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 13:02:44 +0200
Message-ID: <CAA8EJppov1ZtJvxyiXwik77bs5=dDfE_k_Wv8-DyzYtoEzvv4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom: snps-eusb2: Document the
 X1E80100 compatible
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:28, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 compatible to the list of supported PHYs.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> index 8f5d7362046c..ea1809efbf56 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-phy.yaml
> @@ -21,6 +21,7 @@ properties:
>                - qcom,sm8650-snps-eusb2-phy
>            - const: qcom,sm8550-snps-eusb2-phy

Ah, I think this answers my question for patch2. Can we instead reuse
the existing compat string as it was done for sm8650?

>        - const: qcom,sm8550-snps-eusb2-phy
> +      - const: qcom,x1e80100-snps-eusb2-phy
>
>    reg:
>      maxItems: 1
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3F7E3FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjKGNJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjKGNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:09:06 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76072B3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:01:59 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a82c2eb50cso61635967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699362118; x=1699966918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKVO9Km+ohatrlDcgogUtJ4mNCpxTTFHDSK1wMZmOyc=;
        b=r5Few5gpA76Ifz0dX1zlEQNbsMf92BhqfRDD+0U85UtZhe8OTiUVKxvIVlEXOJfE4i
         y3ayktHHwujW29SkiK8YLXqxM1ZbbhM+f/I7MzIA2afZ3aac/Wq0VWzNkAuVqAeCy/1P
         7h7g6SbKBR4yryNNbg5v/5SofqqZRFlaKOYr0uotIQfY8JPw+8hXdqTVTZIl3dbaQGTx
         PChQBD72Qe+PFPMcyePbGppoTiBTvpkm3kelhZ5fgFEnsSYSmhtkzmjaK9w8v0uSF043
         ICL6zsglBB9ML92k7sOpiJqsqggFo339o8fy6CK/lJfg50HOTIgYTw3hQEHTeyWIh6XN
         cBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699362118; x=1699966918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKVO9Km+ohatrlDcgogUtJ4mNCpxTTFHDSK1wMZmOyc=;
        b=LnjkVc9MuWzStTMSPSuyDooLgjTcjSJNp6p7uWdqbKxP6u5uzxqmOCTy0reQoc+X2O
         B33BerUXxVX2RTMO83btjp8BkYRenQbaIdX2AjkysV3IGYSn+cjahrWi4/0zxGrcsStZ
         aZxFME0/GJD8UuFbZCpJITdICtt6WnfvX5mtzAutcl3LGBgk7vP8x/8VJH8EWg0cl+O9
         oRnzmimR5MYcJ5OYbZXwOp5UX+i5/Sc+fVFpT/EiUAu60lo4fk0dWnN9X+Z2iOPxoN7q
         y/+C3vDEUw+FlKa9HsvNnoaArZ/e7Nv7dp0J3FTkpvXk3Eg+JJBk1kXNVW0Mm7PF8V8W
         6V/A==
X-Gm-Message-State: AOJu0YxvDip98D/fad/oGJGAouTyYVy9usY14lQEcBlGqKnq/DR+b93n
        owGiDi4p4rGrgYaros8Y/XY/Tp5D2OFu+nObth0LxQ==
X-Google-Smtp-Source: AGHT+IHKQoKSsmRcg/sOieixzdu1e2l7NoB3NK+XgDvDXaMmTUjWJdL0uuTj6OuaO4uthq+8deJFWHoWrBfrpSar5O8=
X-Received: by 2002:a81:5210:0:b0:5a8:181e:8d6c with SMTP id
 g16-20020a815210000000b005a8181e8d6cmr10151699ywb.10.1699362118505; Tue, 07
 Nov 2023 05:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com> <20231107-refclk_always_on-v2-1-de23962fc4b3@quicinc.com>
In-Reply-To: <20231107-refclk_always_on-v2-1-de23962fc4b3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 15:01:47 +0200
Message-ID: <CAA8EJpqvCJsft3Y-m2ZYORBg=6P7EhT-PsCSkuQ4xaxuf3KOwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 14:26, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Document qcom,refclk-always-on property which is needed in some platforms
> to supply refclk even in PCIe low power states.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 2c3d6553a7ba..263291447a5b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -93,6 +93,13 @@ properties:
>    "#phy-cells":
>      const: 0
>
> +  qcom,refclk-always-on:
> +    type: boolean
> +    description: If there is some issues in platform with clkreq signal

nit: there are some

However this still doesn't describe what kind of issues with clkreq
you observe. I mean, clkreq is just a GPIO pin.

> +      propagation to the host and due to that host will not send refclk, which
> +      results in linkdown in L1.2 or L1.1 exit initiated by EP. This property
> +      if set keeps refclk always on even in Low power states (optional).
> +
>  required:
>    - compatible
>    - reg
>
> --
> 2.42.0
>
>


-- 
With best wishes
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99FB7ACC73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjIXWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:18:14 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08CAEE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:18:07 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59c00b5c8b2so62702367b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695593887; x=1696198687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=148f3od4UEgt0C3+sCv2idXUqd/hwbuqnZG5oUZXv6Y=;
        b=aBhoVb09JCipnenktEbqDz9vuwlwrH79TNHtYoPUk0tyLwiR81+AEr920sN0jPOIvC
         crRrZj5ZDuVeGtFVxRX18Gba/0dZCvgzCll5VvsqF4v+MrwmvZHkQaA3SRA4dXY8Wc62
         h4IZ/M06v9GvXd+5OOMDItd5r3RKMMK5hi461diJ0Vra3913vPbmDfSBAoffxzao40tf
         dD/7rVt0nUti6ntk9boxC1rtvwN1GhvXn66pWMsDWzv5wWWji8XHAW4XnexPRdbiihOy
         vSZwa5/Bvjmr4C8rPUlbGEJ4XirWCZrs/0toaJy07PqVYyHYw6u2+/RJ/s072NfdBxc8
         hSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695593887; x=1696198687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=148f3od4UEgt0C3+sCv2idXUqd/hwbuqnZG5oUZXv6Y=;
        b=NumzGtireM5DSvbP73IvsXZrz/1ZCYlKA08TKsp6opshUda5ATRBPewQo4Fz7V4r0B
         zDVyAhsdfP0kaRuU6GkjE6KPurd/wnrfQ8Sj25p6tgiHLD2BQue/sX1BRgXqA60CrWDo
         XkjXc5YhRGkhNeYSl1qa1inl53vre6UQGcTJP4oKTRzN68we2dqsIWZfQ8yybq6z3gJI
         G+S0iETdpC1pNNEoZ1560eddIvzINLAhAySfGfQqePQVGdwjkQUvKGA0wZnZSpgShhIZ
         9Hs5pcanBJRoQD+z1yUMGDl0JcSSrJ3jscjVRwxTbCVlSWbVAaHcPW9dGEaM8gvesY5T
         l6Bw==
X-Gm-Message-State: AOJu0Yx7VicOyq6h+6xd0HBdGF2+m6JlfGmrSzoo5U1P3oeoL5MnEi+/
        s3TCWTCK55MbJghdebh79v03mMVh4yhd5ZK7c0fz9A==
X-Google-Smtp-Source: AGHT+IFcYRHDcxG8KWeFXXolriZPyC3AiPbFE3WBCzvXsIHeB+V+a6FXyJQypZvS1ds6r7pfEYfPu0vx7NFcpdfa5mE=
X-Received: by 2002:a81:6e0a:0:b0:589:f995:eb9f with SMTP id
 j10-20020a816e0a000000b00589f995eb9fmr4715168ywc.45.1695593886747; Sun, 24
 Sep 2023 15:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230924183103.49487-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 25 Sep 2023 01:17:55 +0300
Message-ID: <CAA8EJpoQdaKnXRaEvFpyqUD1vPvy=aQesxWZ3Usj0JcEvZpDkg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] ARM: dts: qcom: sdx65: correct PCIe EP phy-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sept 2023 at 21:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Qualcomm PCIe endpoint bindings expect phy-names to be "pciephy":
>
>   arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dtb: pcie-ep@1c00000: phy-names:0: 'pciephy' was expected
>
> Fixes: 9c0bb38414a4 ("ARM: dts: qcom: sdx65: Add support for PCIe EP")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

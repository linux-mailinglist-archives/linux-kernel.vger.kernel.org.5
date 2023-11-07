Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC827E3AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjKGLSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjKGLSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:18:20 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E50C11F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:18:17 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a8628e54d4so48326887b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699355896; x=1699960696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KN01AWNQnH0NyxudNjwGJF1KtUvDBJzjiBhVjhok8Bo=;
        b=CHQ36DtuI1h5Ii6pIJO0nrIFacS6P6B1fdYiEBk4aLEcJftlt4pgUKGB70JghrGgWV
         XcEAToI6h+T0Xy2GeHV49d2j9kcuIuLj76r53vBAsYFSXW2Z6WOPB0olfovh9U+WcAYQ
         g+LxjLZY97eYwTuSoTiBeyEAjt+NhPjpNebP0Usx5nUkinIn3pxu0gQtIrjlH4aDbp0V
         Q0W/WKf1Mi14/5qG/tIblH9cnE+Wgcr83zYPVKnNqcdXF0LhYS5Ig+EfFXUkKp2pw9EK
         YMgLu7cvIhNDr9igF9XEn5+gQViwwh44rzpb+cbUam2VrTL6oCalz/Sdut25tVXOTlHe
         pe8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355896; x=1699960696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KN01AWNQnH0NyxudNjwGJF1KtUvDBJzjiBhVjhok8Bo=;
        b=ujW7JN97yjuGM9rABjtRnYM3czxEBE98iBTOkAx2b85XjqCOpG46pQaMOFtSjhGpJt
         YMM0mT2TLaEFLe6yvNvpf4BqfQPhOCUYNzfyi1f6WP3aekv7Fgll+obyVfYZ9jwbma+2
         kSVsOtbTbGl4edpElrBOFJ5oeyeKY6A/CMWjbrvhxstqH/Qy1OUQ1/M2lKMW+76MF0SJ
         /NtEXRVGtq1H8AIakzY3F69gqVbURPOsSKN086SavQgUiXstiiA+5ZTQ00sfaOxauL2x
         y2v/jEI9vacR+FLKLQkWKTgeYkDRar8O6RiFMzPfRmYzI7WuLBLm+3eM4/VKRFtW6obO
         d1VA==
X-Gm-Message-State: AOJu0YxoKYAXQ2S009FeLph6LD0RJYhojJWoAe5MoLgraS/0lqGY/Ksl
        tvtm06yZ7qEXRptoftGzEBZ5O9hRSMeR4pGATWIlDA==
X-Google-Smtp-Source: AGHT+IFr/kWuslY+4gpxV40KBsp6Zix+rvtsKK0R1/xwG0WKsh6mfDW/4RJkC0L2j1gV1V+UO4d9BtS7jJktyKTBvaM=
X-Received: by 2002:a0d:cc95:0:b0:5b3:5d35:2398 with SMTP id
 o143-20020a0dcc95000000b005b35d352398mr1482435ywd.2.1699355895893; Tue, 07
 Nov 2023 03:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org> <20231107103540.27353-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231107103540.27353-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 13:18:04 +0200
Message-ID: <CAA8EJppm2wNrZ0V2xVz4GJHcY=dHYek3_wvrXYPj3HbJ039PeQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp-x13s: drop sound-dai-cells
 from eDisplayPort
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 12:35, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Qualcomm MDSS Embedded DisplayPort bindings do not allow
> sound-dai-cells:
>
>   sc8280xp-lenovo-thinkpad-x13s.dtb: displayport-controller@aea0000: #sound-dai-cells: False schema does not allow [[0]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index f2055899ae7a..def3976bd5bb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -573,6 +573,7 @@ &mdss0_dp1_out {
>
>  &mdss0_dp3 {
>         compatible = "qcom,sc8280xp-edp";
> +       /delete-property/ #sound-dai-cells;
>
>         data-lanes = <0 1 2 3>;
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

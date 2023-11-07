Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B77E3AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjKGLRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjKGLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:17:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFC11D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:17:49 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso5725433276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699355868; x=1699960668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ydvL0o1CmH6mf7K0w8mZfuazbRVH1fDLTN8b3rtk8E=;
        b=Y4NFr1pQzI472JRjuHXlAOdN9HNgaQgS+zfZzjTXYwZ4GY/eO3qC6xKvgAX0sWpLtc
         3tm9tEwGPve62PHyDZO5g7rZYjeO/NZSSnPKq/J8jC5sc7d4NjxPVZT/bbcgVvmCn3Am
         dtS99s4YMg/VQSkwOsCjrq+jGI6gnG9ic3lmZBfkB70j06GvMMHuLWdS/qZd6tXY2TAk
         eJc9ibmW3NB9uh0/GcVKIiYtnTFsfXMt/0HrbyS7DWjXLbDaVALH0FunARo/5CvdaElQ
         dVTt8quPIpsyc3WNfgFaXYK9bVnOS95UEB4RJbhsDfr0II7wEjVo1atN6As9C6tsb3G6
         yhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699355868; x=1699960668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ydvL0o1CmH6mf7K0w8mZfuazbRVH1fDLTN8b3rtk8E=;
        b=JPhkTEOwop0mzxB+kWiVJyIcH48UhrTg7TwFJlkt52+0WxCdZyTtxVhD4/vl4uDtYG
         VzrEL4dT6aikUx2Qcq+5+idNli6bK8RNGCZ/N50VHegZ69mS9YJEWknT8zqtcVId2XvL
         lFOauQkO1dsWB9rzHtjLRnSFHusPI8VoynZQpFdDcidMi/BGoYlzIhoyWZ5nnZLdRFC/
         8tK6CDmq0vZwcqT9UHeK//kPrRztPUG0DC1sw82zqLczAE6t68/iqyFe2yQ+3aCT7Cu8
         b00d9TKLZhgzR4TyF9s/+GroMmXfmO9Gy9IUKrkV72RrB/LEyOCckskYbf4PE8i5N6cr
         gTHg==
X-Gm-Message-State: AOJu0YwOF1JMKlgf2kXomMwKCBZa6Zlqo7xJfs1OXuUwCSX5ZZr+cmyV
        PyKT4UzWGraBtaMkyY3pNyb+hkuOpgVK/aN6zIWSCA==
X-Google-Smtp-Source: AGHT+IG1vN6zYMpeJ5WEK+n+SDm+pr9crueNXcCRYtyecm2T33jO7z1XTVsAQX2OJcNh1gijTFjzuM1eyJHUCvFnsyc=
X-Received: by 2002:a25:d457:0:b0:da0:ce42:e609 with SMTP id
 m84-20020a25d457000000b00da0ce42e609mr1754971ybf.8.1699355868469; Tue, 07 Nov
 2023 03:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 13:17:37 +0200
Message-ID: <CAA8EJpo4GXTLtEY2AgD8y+33dHtENGTcTr_ma88wfdhRzFF-ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8180x-primus: drop
 sound-dai-cells from eDisplayPort
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
>   sc8180x-primus.dtb: displayport-controller@ae9a000: #sound-dai-cells: False schema does not allow [[0]]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

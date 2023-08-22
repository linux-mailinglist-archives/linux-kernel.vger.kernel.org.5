Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF86783E66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjHVK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHVK4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:56:12 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5723ECCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:56:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bdba622d1cso500941a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692701769; x=1693306569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmbZKg8MO0Caap6tnCCUDBVYQhIxs2ct9dxwNPhfJ8=;
        b=HFzZ/XXKeXpwjt82B0mHZZG9JKd6iIY4ybXgnQTjEt4HKwvapq/RCvE2f60dmd+BtX
         qR7RQ5hyVVRD0Dd8h2DQsbfm66JefEkz44PWjkzcmV0xCYCYDr/7YZO5XNrdzNjEs5nD
         0YxF0MXW452u/h7z/H0eO25m6+tHTijDgiYfLTmkCNYX7+XKKKmKmaBFvo/s71QTmhXH
         G6hALlUeB01GA8vjdpiks5zjQIZhEEBbuxzLz9YliCJMdInzekL2/B7VNKKCGYO8DDm9
         sfx9FgnPtqtIq6+ixjtyIXFzi1LY1VmNYGVVCa5pbwyk8QdTyCGoybPLRcoGlaOtSr7I
         GWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701769; x=1693306569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gmbZKg8MO0Caap6tnCCUDBVYQhIxs2ct9dxwNPhfJ8=;
        b=QVVhaDvTPqWckpspAr2swzTqFjZSEXtTryi9f0ZsH52Vwk5lOEZvJYxVzI1xaHUx+x
         yNmCPtXwy7Xv6qT9mqsc3O3LYBipvgUSqsdCe7cdSr/IypYD3WQ22FMGj9qVpoRn3Mf3
         HmEcm+PmGgViw3Y1KgEjMSXWv4XNC7itTgBmHoN4TkDa+wVKYEz41f7KWszIBmdsroDC
         q3ZPH/oLzTzfUj5H2MgCUgfOuVs1qGP4w0bDiQxA5UzSTtVf89b7t9fix2l1DviK+KkA
         QoStb0S7B9WYXP9ZTY6ZEzL+JjEz4Teh8wkfH0u+7x94Uvoe3b+hYZv+CgRTFLyWR3YQ
         P7Rg==
X-Gm-Message-State: AOJu0Yw8KSSF/97PVz43Db5tnoHJPJbQzxY/o5qoPFp2zNmzTblkKxhF
        gCyZJyPkwqbY/8klfNvlp2TjIE2nYd10iJ8rk8SO8g==
X-Google-Smtp-Source: AGHT+IHRpjn+Tn5STuiluP/0dZcO+kQ0j7tCK8/nXpSRwA5NzJZfFnhty39Igkdoef8Hg8QvdY5b0Y2Ut+Iz5kCQ/U8=
X-Received: by 2002:a05:6358:9889:b0:134:dee2:8c18 with SMTP id
 q9-20020a056358988900b00134dee28c18mr8946835rwa.27.1692701769535; Tue, 22 Aug
 2023 03:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692699472.git.quic_varada@quicinc.com> <6d1638daf9b0616816fdecb529df86a394db7942.1692699472.git.quic_varada@quicinc.com>
In-Reply-To: <6d1638daf9b0616816fdecb529df86a394db7942.1692699472.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 22 Aug 2023 13:55:58 +0300
Message-ID: <CAA8EJpryKOzGd42NjG470D9jGr1Huv5D-F-NqaTo-0EJeFUr+A@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] phy: qcom: m31: Fix indentation issues
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
        geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
        peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023 at 13:31, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> * Fix indentation
> * Drop simple success messages
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v9:
>         Fix line break alignment
>         Remove register success print
>         v8 version of the driver has been picked up for merge.
>         (https://lore.kernel.org/linux-arm-msm/169226613917.81413.1200008047604336868.b4-ty@kernel.org/)
> v8:
>         Change commit subject and message per review comments
>         Don't include of_platform.h
>         Change struct init coding style
>         GENMASK -> BIT for one define
> v6:
>         Kconfig:Add COMPILE_TEST and remove USB_GADGET from 'depends'
>                 Change 'selects' USB_PHY -> GENERIC_PHY
>         Driver: Use correct headers
>                 const int -> unsigned int for 'nregs' in private data
>                 Use generic names for clk, phy in m31 phy structure
>                 Init register details directly instead of using macro
>                 Use dev_err_probe in the error paths of driver probe
> v5:
>         Kconfig and Makefile:- place snippet according to sorted order
>         Use generic phy instead of usb-phy
>         Use ARRAY_SIZE for reg init instead of blank last entry
>         Fix copyright year
>
> v4:
>         Remove unused enum
>         Error handling for devm_clk_get
> v1:
>         Combine driver, makefile and kconfig into 1 patch
>         Remove 'qscratch' region and its usage. The controller driver takes care
>         of those settings
>         Use compatible/data to handle ipq5332 init
>         Drop the default case
>         Get resources by index instead of name as there is only one resource
>         Add clock
>         Fix review comments in the driver
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> index ed08072..ea79c18 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -242,7 +242,7 @@ static int m31usb_phy_probe(struct platform_device *pdev)
>         qphy->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(qphy->clk))
>                 return dev_err_probe(dev, PTR_ERR(qphy->clk),
> -                                               "failed to get clk\n");
> +                                    "failed to get clk\n");

But why are you trying to fix this? aligning next line to the opening
bracket is perfectly fine (and is one of the endorsed styles).

>
>         data = of_device_get_match_data(dev);
>         qphy->regs              = data->regs;
> @@ -252,18 +252,16 @@ static int m31usb_phy_probe(struct platform_device *pdev)
>         qphy->phy = devm_phy_create(dev, NULL, &m31usb_phy_gen_ops);
>         if (IS_ERR(qphy->phy))
>                 return dev_err_probe(dev, PTR_ERR(qphy->phy),
> -                                               "failed to create phy\n");
> +                                    "failed to create phy\n");
>
>         qphy->vreg = devm_regulator_get(dev, "vdda-phy");
>         if (IS_ERR(qphy->vreg))
>                 return dev_err_probe(dev, PTR_ERR(qphy->phy),
> -                                               "failed to get vreg\n");
> +                                    "failed to get vreg\n");
>
>         phy_set_drvdata(qphy->phy, qphy);
>
>         phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> -       if (!IS_ERR(phy_provider))
> -               dev_info(dev, "Registered M31 USB phy\n");

This is irrelevant to the indentation.

>
>         return PTR_ERR_OR_ZERO(phy_provider);
>  }
> --
> 2.7.4
>


-- 
With best wishes
Dmitry

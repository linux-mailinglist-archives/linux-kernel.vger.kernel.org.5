Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D177DBD47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjJ3QAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjJ3QAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:00:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCA10F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:00:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859dee28cso36372385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698681640; x=1699286440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKk2V4+YytGbf7Kubv6ahLWsu9n3OHUmke4aOKpHn8o=;
        b=Yf7bzi1PG5ut2cbQ1LOqoqr+9MFgeva2chErIQxn/qrNCkvGKnw2V2osoLDat5DQbp
         HquBd/SqGgflnr0n3esqw2t34IT8xMjWG02NgBUdA6epG+X404cssQhd3+5TL7ljxbm5
         7/o4eUGGLLS/MI87lBWz0goSvZLH7XKb2FzkdYJcVxkECGYYIDp5NhYQAy7I4DRhHfov
         viZ+cH4VtzYpBGpckD5nwSu23HJRlSeTfuMXnf98UYTE77pkTz7bp6RntYv++JlTIi8m
         6Z02UPjjxzqIR53qJSxSu4U57WuANdXs1+buoKEIiU7jJNW5CV1nwmA7elQ3ZPR4LaEw
         nKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698681640; x=1699286440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKk2V4+YytGbf7Kubv6ahLWsu9n3OHUmke4aOKpHn8o=;
        b=n26rgoQPRt0X0w3dYHMLM8n1zGvdcYPVIV3+YqxnVs+qkHepoAksbvNH/bLSsS9sM5
         0LbEiaserj5xYTMSjXVHR7dliSZFYhfigyF/GPSZRd3BE0UrkLb2C++9x5Px2oEfByxP
         9aBbzFjGCqgXAX9GXj3obiRNY6RGSTro35yc6jeVqMVjGpvDdf4/UgBGsYUYjd6qUrAp
         SEgzO7ZAj94U5tmdU+VcvtKDv3nUASQPlZvaIdImj8oRBD5SJpfmWquu/mWuLMOMh8Ve
         Ww44drnoRMZMzq/hqBhC+4aCqf8Tb5FIJqX3kK6DUmpPxACe2u9wm7pmg7yv1iOMw67e
         RMIQ==
X-Gm-Message-State: AOJu0Yzu44yhPMuABsr9VuOwzg5IhfuQOMGA0rhPGB3ADUf83fcdU5Gy
        faniuzLeXBgXFEgK1S5JtzUudQ==
X-Google-Smtp-Source: AGHT+IFgDOW6Z+sEemwwIK9J/rhKUnbKudXde4JZ+gqlGYM31QGNGKxbw5dTfoiWkoWDrgoIQbN6HQ==
X-Received: by 2002:a5d:4842:0:b0:317:6513:da7e with SMTP id n2-20020a5d4842000000b003176513da7emr8040501wrs.36.1698681640485;
        Mon, 30 Oct 2023 09:00:40 -0700 (PDT)
Received: from linaro.org ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id h16-20020adfe990000000b0032dc24ae625sm8575499wrm.12.2023.10.30.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:00:40 -0700 (PDT)
Date:   Mon, 30 Oct 2023 18:00:38 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        ulf.hansson@linaro.org, agross@kernel.org, conor+dt@kernel.org,
        ayan.kumar.halder@amd.com, j@jannau.net,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH 0/5] dts: qcom: Introduce SC8380XP platforms device tree
Message-ID: <ZT/TJtlHrXXXr7X1@linaro.org>
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025142427.2661-1-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-25 19:54:22, Sibi Sankar wrote:
> This series adds the initial (clocks, pinctrl, rpmhpd, regulator, interconnect,
> CPU, SoC and board compatibles) device tree support to boot to shell on the
> Qualcomm SC8380XP platform, aka Snapdragon X Elite.
> 
> Dependencies:
> clks: https://lore.kernel.org/lkml/20231025133320.4720-1-quic_sibis@quicinc.com/
> interconnect: https://lore.kernel.org/lkml/20231025134049.9734-1-quic_sibis@quicinc.com/
> llcc: https://lore.kernel.org/lkml/20231025134632.10363-1-quic_sibis@quicinc.com/
> misc-bindings: https://lore.kernel.org/lkml/20231025140640.22601-1-quic_sibis@quicinc.com/ 
> pinctrl: https://lore.kernel.org/lkml/20231025135058.11268-1-quic_sibis@quicinc.com/
> regulators: https://lore.kernel.org/lkml/20231025135550.13162-1-quic_sibis@quicinc.com/
> rpmhpd: https://lore.kernel.org/lkml/20231025135943.13854-1-quic_sibis@quicinc.com/
> 
> Release Link: https://www.qualcomm.com/news/releases/2023/10/qualcomm-unleashes-snapdragon-x-elite--the-ai-super-charged-plat

Here is a public tree with all the support currently brought up
for this platform:

https://git.codelinaro.org/linaro/qcomlt/demos/linux/-/tree/sc8380xp

> 
> Abel Vesa (1):
>   arm64: dts: qcom: sc8380xp: Add Compute Reference Device
> 
> Rajendra Nayak (4):
>   dt-bindings: arm: cpus: Add qcom,oryon compatible
>   dt-bindings: arm: qcom: Document SC8380XP SoC and boards
>   arm64: dts: qcom: Add base SC8380XP dtsi and the QCP dts
>   arm64: defconfig: Enable SC8380XP SoC base configs
> 
>  .../devicetree/bindings/arm/cpus.yaml         |    1 +
>  .../devicetree/bindings/arm/qcom.yaml         |    8 +
>  arch/arm64/boot/dts/qcom/Makefile             |    2 +
>  arch/arm64/boot/dts/qcom/sc8380xp-crd.dts     |  423 +++
>  arch/arm64/boot/dts/qcom/sc8380xp-qcp.dts     |  398 ++
>  arch/arm64/boot/dts/qcom/sc8380xp.dtsi        | 3267 +++++++++++++++++
>  arch/arm64/configs/defconfig                  |    3 +
>  7 files changed, 4102 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp-crd.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp-qcp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8380xp.dtsi
> 
> -- 
> 2.17.1
> 

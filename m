Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161307ACCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjIXWwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjIXWwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:52:33 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF93101
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:52:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59c0b9ad491so61792647b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695595945; x=1696200745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wqePdKs4FSnXt7oeFVHQEm26iZNJhC0uyofhDbrUr/o=;
        b=Du2COnuMlmkuok1bgVTzEciYoZXTM2lO1i+lpr26zcLpfI/7FIzHSgBFH0rINZsipJ
         a9aRbh0WSK1pW0j+5v5eWheny093ItAtLJZrRAz0fNkDTg8XStvbQwm+33IfOgF7FEB4
         BAodzr1Yv4UyU1yxVle9ZNl2FBl14trs17wicIbIgZfFt+MNfjFwJXnkZzoSukU0PExH
         Ab7k2vz6u/HonZMzVcXf2OzJ81SMBz3AyVgCpQb/DXQudeVMVtGfAylWauMU6JZpGIPd
         q8HDanKNu7jtLCoBPpGrv4o63EFxD7GB3cwCewSC/mE/86aKIn49bcxEzahrREakm3SQ
         maAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695595945; x=1696200745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqePdKs4FSnXt7oeFVHQEm26iZNJhC0uyofhDbrUr/o=;
        b=ioGSECfJzRnnjLb6pC1lMJuCdFSx1LqxZiC0WtGqO/4azvT5/CAJ9pLcUf1V7gX3Pf
         s2tSJP75jH2g8DPAPZXH7DtSPHlYvJck1krQN4/+mZT9d18w2kHm96LOCrItjhEqvjJv
         g2d+iJLpXU2eHv69N1HCci9vXAmq2Aq05Vs5q3D6C/RdiX3stZQcgYwxCfWpZ3bE05x8
         USa7K2X1JzuJiR4zF8WDWFSvY9d0CSgJ9CPx2NjsogemmIWtSzFbQx/tokKm28eHW37G
         klA8Z3Ap2xGs8UMOSkEXeeekzn+ZSsbqmWiBBDHvad5lKeg0wP8VkWhHj2JTKT2D5yL7
         zdNA==
X-Gm-Message-State: AOJu0Yy1n9vGswFQWRwyUDzI2LEwCQ2B9aQBkbb14FoXCipMfrXiCQ10
        OIF21sY9vmtmxIwjnX+yS73wHtx1imzpcxnlhy5hbA==
X-Google-Smtp-Source: AGHT+IHmkOeW1EDSC36M8rpNz9cZRruORxhAmZUq0TCAXthzcxqv9L1+CneWfLH9vYiKedpBtnBvpPDfGCqf9V6ljDg=
X-Received: by 2002:a81:4f92:0:b0:59b:ec11:7734 with SMTP id
 d140-20020a814f92000000b0059bec117734mr5038823ywb.39.1695595945493; Sun, 24
 Sep 2023 15:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org> <20230924183335.49961-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230924183335.49961-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 25 Sep 2023 01:52:14 +0300
Message-ID: <CAA8EJprSKGLgPgGcNxPud3gp=zhSCOaB+8mp0s1Jc7XqpDZ6kQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] ARM: dts: qcom: sdx65: fix SDHCI clocks order
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sept 2023 at 21:33, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Bindings expect clocks to be in different order:
>
>   qcom-sdx65-mtp.dtb: mmc@8804000: clock-names:0: 'iface' was expected
>   qcom-sdx65-mtp.dtb: mmc@8804000: clock-names:1: 'core' was expected
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

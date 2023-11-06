Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F67E2112
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjKFMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:15:27 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0CDB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:15:24 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a92782615dso52720087b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 04:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699272924; x=1699877724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLeS77DJS+HON2OCKCmE4rFyK08nkhd0X2PzaXyv+3g=;
        b=Eek9A3iDmxcZ2EHJcOaCUGOVhf3KWhXuYYXulGvGc/ghWltqzEtX77fopiKOrnFAEi
         P5YYdKDc9xg5xMdwYVk9Hi3NkEDrC9jSMaSDMmpEGx7wTkG7bt1VrgYh7vI2SsfHn/VU
         gJE4Hn196nWwAkVY/0stgl17++v1Wxynx561zzX0TmxwTESNhAez5iHoioUTfkfUfFNk
         r1D12YRDB54uoLMtYRLA5/wMGYxxT+FfBlgxKinM0wJ82m87Pcosh4quPXSir16txVXy
         lYvtTzqJBydn0GmiDwew68cXOUMErB/p87i1n6tol8vkzjeYn6BLIgpy5tFmvvTfHDLn
         x6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699272924; x=1699877724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLeS77DJS+HON2OCKCmE4rFyK08nkhd0X2PzaXyv+3g=;
        b=elaYJR0BI2jLqiBrbACF4z6urv2zLkskk7jh0+xdPxjcGRwaWEMyDUh+6/pDeET8H4
         8ijnrgYzGf2EJprkrERO1Yleo/TD+eXib2p5U8XUnIdILDz0b6+YBRBB23YIpBq0KMVB
         ml5m1ItnKn2EGIeAJ6W0NM7dQ1+2Kupb/MsW+lrb1Ewsm5XYaM+jct10itM2uiEt/bQR
         hx9yJ1xH3M+o2JZjYOinbR4eLgjIetFVbxoAdowQd60trP32ZiF8Jj5uGIjxCC+rLwJg
         5k0eVSAMEJg50mABajigSmJ5tblW4Z1m0hpEJiKi4rYO2kgLAoM/0GRRGZ9TF3tWFNy0
         K7tw==
X-Gm-Message-State: AOJu0YxAxNIisFGRw8mAtQLnUUQAoQQueHyOAmImnRXCgoZnblYR1U2i
        R/FGJb1frDcEzUF2WcSufJvhNBUC0GrONXmBqt+11g==
X-Google-Smtp-Source: AGHT+IEgXIxroUt6+s1HwtcNxvpQjdM4tHS7AYlOOLSB9eJthbXZSHqKzEyTooNMvSPzECzf3DIWLZtCzaWDnqdh8gI=
X-Received: by 2002:a05:690c:fc8:b0:5a8:5219:df6b with SMTP id
 dg8-20020a05690c0fc800b005a85219df6bmr12604471ywb.24.1699272923759; Mon, 06
 Nov 2023 04:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20231106-pm8937-v1-0-ec51d9eeec53@riseup.net> <20231106-pm8937-v1-5-ec51d9eeec53@riseup.net>
In-Reply-To: <20231106-pm8937-v1-5-ec51d9eeec53@riseup.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 6 Nov 2023 14:15:12 +0200
Message-ID: <CAA8EJprRT=thU-7_rfX6Qhk55iC9Hc0d8x46uyt-p4DOHCrrwQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] regulator: qcom_smd: Add PM8937 regulators
To:     Dang Huynh <danct12@riseup.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Mon, 6 Nov 2023 at 14:11, Dang Huynh <danct12@riseup.net> wrote:
>
> The PM8937 is found on boards with MSM8917, MSM8937, MSM8940 SoCs and
> APQ variants.
>
> It provides 6 SMPS (two are controlled by SPMI) and 23 LDO regulators.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>

I haven't checked LDO / SMPS types. Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/regulator/qcom_smd-regulator.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

-- 
With best wishes
Dmitry

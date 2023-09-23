Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E707AC312
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjIWPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjIWPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:12:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE364127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:12:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so27959515e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695481947; x=1696086747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzhaS1WbLmeo0WlVMusFMrENnn61L9WwiZn5UG2VbMU=;
        b=qC128o+v/ju01ljSY+/fyCDiU7wx5ps+MOZYOat15EBZnjfbrhm3V+tHpxKymkPhCJ
         GBtASlqJ45Jj6yKZ5JCjPrs96HUH4A5+XSUbWHNmWuo+cDiH5pE1ematOWwtfhwymNzO
         33q/Jmr0S8F/iJmiv4u6erdEPTTxpwxY+7rhmuZ8BVSp6CDJUwbTNqhZ8JZB/znT82nc
         Bxz2sfrMr7dmvpIxztA30c4g6KyGP01wZzBaaDbCGLKSr8wHmTUiYfEaVbdtqaLCG43p
         qSMTK/H+qKJUyByLFWCFVSemw5iUylYzLxRjS0lZT9za+0nHwxYPKaeb91lZF62XOVkL
         OdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481947; x=1696086747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzhaS1WbLmeo0WlVMusFMrENnn61L9WwiZn5UG2VbMU=;
        b=gXiU9Uc6tD2Nex+pP1SavaS2ryzfQg++t8YAgIdzr7UrmEjdjeBoOJ6bQRAsfp+Q3g
         TwZXpepywT4OgpLJV25IhsYLxlc6flxSpEMqPH2jDmAhfirK3EC0uEK4bxvm6LQVzlaP
         jNNoc5mLgk2g/9fBMk6ZQLxSuZsHIHScw29JrrlvNqFtpNuBaVVj0UtqdiSkAUYRdRzn
         rnW6Ga2ZynRS2AOeBEXJHYJTnFrfLiihRqKoSyaXEpTG4TXv8buuok89E1jFOmJSq9OA
         6aQRiGMEI51bQyrgzy0JfqWzMaIV+9oAmbtzI2mh9yZgnSXamGlj+CXw2iYZikNOJ0sA
         KuOQ==
X-Gm-Message-State: AOJu0Yw2sTrgaw+ouaYofLjBEi6dj0NsMD5TfEHuLNE3k9sWF+SEpng/
        rUI/34vb96qnbd570dBkWNPnWQ==
X-Google-Smtp-Source: AGHT+IHYlGZInh8v6ky+Qg++LmI+9p5cONWHNxCEslCg/4K6Nu6ZVkuTUWU+dVjmJS4uAKh+v1A2mw==
X-Received: by 2002:a5d:4fc9:0:b0:321:69ba:d851 with SMTP id h9-20020a5d4fc9000000b0032169bad851mr2594590wrw.5.1695481947060;
        Sat, 23 Sep 2023 08:12:27 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003196b1bb528sm7195560wrw.64.2023.09.23.08.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 08:12:26 -0700 (PDT)
Message-ID: <bda0d75e-1af3-4247-a363-48998c21c8a3@linaro.org>
Date:   Sat, 23 Sep 2023 16:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: qcom: msm8916/39: Fix-ups for dynamic
 reserved mem patches
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2023 19:56, Stephan Gerhold wrote:
> Enable GPU/WCNSS properly in some MSM8916/MSM8939 boards that were
> changed after I sent the patches for the dynamic reserved memory
> allocation.
> 
> I have magic scripts that make the necessary changes automatically so
> I'm quite sure that I caught all new instances that need adjustment. :-)
> 
> Since my scripts only work properly on board DTs with sorted nodes
> I also included a bonus patch to fix that in some of the MSM8916 DTs.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Stephan Gerhold (3):
>        arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
>        arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
>        arm64: dts: qcom: msm8916-*: Fix alphabetic node order
> 
>   .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  8 ++---
>   .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 10 +++---
>   .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 38 +++++++++++-----------
>   arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  4 +++
>   arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  4 +++
>   arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  8 ++---
>   arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  |  8 ++---
>   .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |  8 ++---
>   .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  4 +++
>   9 files changed, 52 insertions(+), 40 deletions(-)
> ---
> base-commit: a35461d47fe3e555602912b905f1bae7045256eb
> change-id: 20230921-msm8916-rmem-fixups-46ec18b9ba5d
> 
> Best regards,

Do these Fixes shas exist ? I can't seem to find them.

---
bod

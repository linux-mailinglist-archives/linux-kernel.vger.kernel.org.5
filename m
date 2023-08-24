Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D27879E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbjHXVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbjHXVEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:04:51 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197162107
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:04:26 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48ff458f91aso82804e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692911065; x=1693515865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WkoUCmzk6kpY7dtKJHiHxStqN+h+r9LgpuChyH7uCV8=;
        b=Hm2mieTK64nboBW6aRDOHQOMRRpXIfJjIGW3+Nv9NG8xf5mb8heB4vdn2340LFcpgR
         o1i49N8Tm7UgFcncyiLVWoSz+64AuBzDoMFOJFJNXpItMuCzYTts+L3F+xwNmqRoOaHr
         FBeRTvDfOQoGomZIXHrEwHdqQMowdho66xvGMvF2AdGC+dUnTag6Vr9FzD4clIJFDaIf
         4vr+e8Jhh97YA7U+Qe1mGtbqzd78RWaS1a/ao6aWz0HEZfOLQidTlF3Oxod6AWCmUTrN
         HC32zsfCq9IycW6DFH+P4edvqOCHamN1NYOJDf2QnMZBC1cAFobUuZ3wgvydSTzu99Et
         WDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692911065; x=1693515865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkoUCmzk6kpY7dtKJHiHxStqN+h+r9LgpuChyH7uCV8=;
        b=WJvlLO85GP5Kn5C5FtbaaTK3sXuMecLPu9k0ALuI9/GqAXvrPE7yyEA17HMgqiqqpQ
         ChhRj5mURHOB/535DZVuiUOusx7mSYFmnFOQzP2Jw/45kHND0tqcBGfZ3tRI/Vc2MMFT
         dCXbDYuSVa1mZ6b5G07YotqMHckWVDVY4A5EdLMkOz4wo4ArQ6ZLgrfpLnujsVVebLJr
         NnAIW8juXzKnHUbKCzOQGLeBD2Acd9T2yhtudzZDD0bTFltXGmmR7hL6XWaJaE4pZ7Hy
         o5h7RXprw+WMa3fekg752gsFszprxdhZ3YatSYOEXskLfHLKv2yHNpzYQEMQxeXxnPxv
         7Dlw==
X-Gm-Message-State: AOJu0YzsHO6Arr3Mg8lhe7a5nalKX604dcNKv38KA9M1FqQNVzoI2Cod
        1nSkIu8FLPgtMyE9McBZWS1djT3i42MvZ/wlKIvTpg==
X-Google-Smtp-Source: AGHT+IGeJ7/r6a9gBrmT0pw+udF19ySh/nVFMaDVPBWMqeCt+B+Sx87zxPTnpBNBUFQEk0Z3KZmLmA0nHnEvVUN9N88=
X-Received: by 2002:a1f:e643:0:b0:48d:1cf0:f3c3 with SMTP id
 d64-20020a1fe643000000b0048d1cf0f3c3mr10466825vkh.14.1692911065190; Thu, 24
 Aug 2023 14:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230824173410.550126-1-quic_ajipan@quicinc.com> <20230824173410.550126-5-quic_ajipan@quicinc.com>
In-Reply-To: <20230824173410.550126-5-quic_ajipan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 25 Aug 2023 00:04:13 +0300
Message-ID: <CAA8EJpo=ZDmoMDyfHEZV9Ng6yM=Z2SdTyPSG246AmLKVR0-vwQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] clk: qcom: Add GCC driver support for SM4450
To:     Ajit Pandey <quic_ajipan@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 20:36, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> Add Global Clock Controller (GCC) support for SM4450 platform.
>
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-sm4450.c | 2898 +++++++++++++++++++++++++++++++++
>  3 files changed, 2908 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-sm4450.c

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--
With best wishes
Dmitry

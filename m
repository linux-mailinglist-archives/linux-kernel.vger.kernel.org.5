Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD2178E09B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjH3U13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbjH3U1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:27:16 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4410CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:23:39 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4122129390eso714951cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693426641; x=1694031441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSyK+dHkjDMQS0UZZd2TV/HXC5yoOWbGzZSM7TZhYog=;
        b=E94x284/ec5oV3mczKVDRl9Zf5+dvWa/jFSAz4XPUvyxXTiY6XdgzIqwRTKfZVrRuS
         prRN5EIidgfFU70/y/lejIoQvnutBdts75xyO+Bwt4JcRz31PE5Pv1R9yXaIkmmMFWuG
         b6OzxGMrahivqFClX66BpB8guXBKffmM5cM0Ha60OhPx01VsjqFBKDX/x+GFI7qvTZSr
         mvcAeaoViVZdAD8K7ZI2/WVW8P6pTb+BxjUsayzAjxgkejHREgCx/MUpwr6e+cQIpn08
         F5Vla+DZLM67tuQxLmIuTiB0/+1/btguO1HHsUgQxUvi+AumLa6p9xtWZBmblkK/cD5p
         DSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426641; x=1694031441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSyK+dHkjDMQS0UZZd2TV/HXC5yoOWbGzZSM7TZhYog=;
        b=g0If5NeLZUMIAdD38sd/wyALf9+OHrVsgcdiE6tnK6F8VUi/jJhl/MAN2OxsQW7Qqr
         JRqWFaNXt2cXpiVPi+fotjT3qf82KWP7kh3R6s01Phnda9+z5k5RJNK3uaiNMiQMKz3m
         z3Ox3KsfzktVxEgIzrGMncJ2Rqh5AEUTrP+jETtjJCGwEGxVCx4XWfBXJxVMhRY5Yw97
         inEwxcr19E29uKFsGtaQGQBQxdChG0UeMX9Ip+rHEs5ABJDNGijgtpBNViGBapDzVo3M
         M/oJdfJJd18ZxRO4nH+1ly6tgtzEkCjOQZI325Vs7rXyftt05l9Y42ckcaDLvFVbBYpS
         eLaQ==
X-Gm-Message-State: AOJu0YzFKFrsLh1gHr9mwgPe74/pi/jAxdqRHWE83fUsO+1XVQAT0AIj
        Vjw6dWEPJwe+g2GE0K7BvGyKL3zuaFwo6lzXUnwVCsq1HKapVPYN
X-Google-Smtp-Source: AGHT+IF3BC4QjQc9khz8UvoRWdeIpu1q8Bvmo2laKSOuKZOvmEKB3zwHspagVqx73Iha2+2P48AjcTOvasTtYpuNrM8=
X-Received: by 2002:a25:547:0:b0:d0f:846c:ef7b with SMTP id
 68-20020a250547000000b00d0f846cef7bmr3216161ybf.17.1693425868564; Wed, 30 Aug
 2023 13:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-topic-8550_dmac2-v1-0-49bb25239fb1@linaro.org> <20230830-topic-8550_dmac2-v1-5-49bb25239fb1@linaro.org>
In-Reply-To: <20230830-topic-8550_dmac2-v1-5-49bb25239fb1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Aug 2023 23:04:17 +0300
Message-ID: <CAA8EJpp2UbiknJ876ccCiSV2hDYdiGVRiQBdAEMM7e9z5OqK3A@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sm8550: Mark APPS SMMU as dma-coherent
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 21:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Like on earlier flagship Qualcomm SoCs, the SMMU is dma-coherent.
> Mark it as such.

On earlier SoCs we marked Adreno SMMU as dma-coherent, not the apps
one. Only on sm8250 you've added dma-coherent to the apps smmu.

>
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 1 +
>  1 file changed, 1 insertion(+)

-- 
With best wishes
Dmitry

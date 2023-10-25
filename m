Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A567D65F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJYI5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjJYI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:57:35 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25069129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:57:33 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b6d6773d05so1943642241.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224252; x=1698829052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NldaKyDc0l1BbJHjiT+K+qAycYibl9MYvEsSpwfuMU=;
        b=bu6agC9AJkWErlYgwOWs+/Wxdel+ILJWbnZDXrvmTRckSJ4QuTtcBy/ZgCePZbajJV
         lGAKkRzLQIvLLdl9W0B+r93+a0sohZb1RplCWsSImuVu7TQo+lpIFBU28uPNvVJN77SO
         e7B4mp5qsT916OXZyl/8tmITihtwahrKOemIR+Ffw2JhvMfH0tdklZsQ7yjkx3/BX+MH
         Xhwxe/3IX4CptLECUonaqxvvNyKOm6lSUuQhyllvpedohTAuk7nZMy18VKgufLp1iOrN
         Q14Xt1tiG8Sw6B7313ehppOXdPUhlzAp7ojHSUo/MzXjNgqaJ4AJh0RKBF1NhMYR4mYO
         iFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224252; x=1698829052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NldaKyDc0l1BbJHjiT+K+qAycYibl9MYvEsSpwfuMU=;
        b=EvBOW5YegHZIo0MXpY5UtQBUDp2ZEaLor1bESBIFPHGi92vjyi5gR/7qLfAcOJ9I7z
         yYUbTauGF+KHlrGFmQN+r4rnoHIiUvpE7Pndfyz6RlgpfR2WUEhjOIfECZRQ9J56kNq0
         MWT3bwlnTdc9mk9T1+2hpWyuaa9Sytqt6FW6IsQDYMiWQR/U5RIHIllRvSF96vX1SMhU
         KX7DTS6UH5jA9kzAB6uLaPPXuozMiIkzk4tWiBuCeaLnxQobzPgf9CxT0dOnY4NIGwKF
         n8YwgxlIefcoOEgRmAa+izQOBQ3T/XLnN9/sYPc5GxQl/XY4ALeV5SYaATUu7XSzejRh
         SSFw==
X-Gm-Message-State: AOJu0YySeJa9HbnOMpXQrWnNozbcd8EiBHJW5Fnz/qkh9V5IYYL0Z7HC
        4JLNCZLKcfI8d2C2suQoZBZaufbKsEgjfJ0sy86hzg==
X-Google-Smtp-Source: AGHT+IGhheo8Q9Df6KgUGR4PorlbsZsMr3I2+FSZpwFZ03w3W5uEdV5Ej71blcICjUAikq6NvJLTs/3FHZXoJH1v/m8=
X-Received: by 2002:a67:c313:0:b0:457:66e0:2c6a with SMTP id
 r19-20020a67c313000000b0045766e02c6amr14079783vsj.14.1698224252025; Wed, 25
 Oct 2023 01:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org> <20231025-topic-sm8650-upstream-phy-v1-5-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-5-6137101520c4@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 Oct 2023 11:57:20 +0300
Message-ID: <CAA8EJpoxdVNvwbEyVVF65FWVQZwydXvePCTmurF_6G9taQRJfg@mail.gmail.com>
Subject: Re: [PATCH 5/7] phy: qcom: qmp-ufs: add QMP UFS PHY tables for SM8650
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
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

On Wed, 25 Oct 2023 at 10:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add QMP UFS PHY support for the SM8650 platform.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |  1 +
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  7 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 86 ++++++++++++++++++++++
>  3 files changed, 94 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

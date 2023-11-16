Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382947EDB32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbjKPF0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjKPF03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:26:29 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EEE1A7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:26:24 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da41acaea52so362376276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700112384; x=1700717184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yqDHCBZleAowpUhWwykf6ZtGbHUaOJrU9HuRWep6kUI=;
        b=IdT7RGIhayhEzCgsPiwzG+FWkgu0YUh4OrwxbDNmfZltNrcGlvqI9ffMrVlIHvCkp9
         mzIcvcakMp0S7uTrzb+WvuTKPp7DOAzrKS4lBZ61p6Q1hem71qFWrcd3JEMkbbhYBNze
         BDQhERUpYfupDvYXJPNQ7TDDXP0F1VRIcC1VBn3eXyZIpPyBgphnzFo/6V/VDZNHTTIk
         OU6HYR40NmOkh31JyHSrF3MOGjC16bqbUWIONleNdE1UlI1Y0B/X/cS6c3D8LRXa4x3p
         ZLMYh1uaKx0MoLZ7sx5WmK8M6uibUZ1gPwc3MRfzexI0Kil8MQ2m8ZRWWHDQ0v4LVoNT
         2AzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700112384; x=1700717184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqDHCBZleAowpUhWwykf6ZtGbHUaOJrU9HuRWep6kUI=;
        b=epbNFcV+qxBtrqzciJ6mGPCCx9Z+5kdBNWXmJ5AaEsRrYEgj1ZnZ7O1MnJkUxKH32e
         lyWTp01OeWCx3kU6shvAQIZHT6vHMug9cSN+c5Rs5tEk1L/S8h/RSKk3VKnsuzrV8hQN
         5dAuBIW/xCsGRtRJpzqR+x7NHSdu5tZ6GbHq05Uq1agERBrrBgFzCRIXWCGzQ6BYMzHk
         N0Y3xeMSI8DbhvkT1EyTYrOYtpzmJq/qpAMn3KklX8SkgQYzP21qa3keuu+zXG8Sx76b
         FEVXVgJG2f+Wqbw1gvUImQe5WqFbFyLYEiIJXO/5gO47CbI+XQYObxIUuMyczfJ8lGI9
         FcWA==
X-Gm-Message-State: AOJu0YxZ5Kbfq1qlso2QLu3U1EawnDa5Sa2dhn05FUcxqJSHcCYCB5sZ
        cqRZJFDRcFpvQ1uDz8KTHGiLpoGLKrROBzIW/0/g5g==
X-Google-Smtp-Source: AGHT+IH4Hh02GCaPDvzQqHEwz8iMIIsTq0YxC8AwfYi/7ZFOFlASykq7O9a2NpeuSrDvxdXzSY+3k0ibpIMBNBtVrKg=
X-Received: by 2002:a25:b298:0:b0:da0:350f:fd6a with SMTP id
 k24-20020a25b298000000b00da0350ffd6amr15854525ybj.46.1700112384014; Wed, 15
 Nov 2023 21:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20231116051401.4112494-1-quic_rohiagar@quicinc.com> <20231116051401.4112494-2-quic_rohiagar@quicinc.com>
In-Reply-To: <20231116051401.4112494-2-quic_rohiagar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 07:26:13 +0200
Message-ID: <CAA8EJprzSFrb1qC-khPmTTac5o2ZX8azYBNPmT8DjyeNo3SAZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable GCC for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 07:14, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
> Enable Global Clock controller framework support for
> Qualcomm's SDX75 SoC.

Please add:

... which is used for this and that board and/or device.

>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b60aa1f89343..d1be1efa8a23 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1252,6 +1252,7 @@ CONFIG_SDM_GPUCC_845=y
>  CONFIG_SDM_VIDEOCC_845=y
>  CONFIG_SDM_DISPCC_845=y
>  CONFIG_SDM_LPASSCC_845=m
> +CONFIG_SDX_GCC_75=y
>  CONFIG_SM_CAMCC_8250=m
>  CONFIG_SM_DISPCC_6115=m
>  CONFIG_SM_DISPCC_8250=y
> --
> 2.25.1
>


-- 
With best wishes
Dmitry

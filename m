Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728817EEE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjKQJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjKQJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:04:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2D92
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:03:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso15603125ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700211836; x=1700816636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+a/E73oKPUIpqCJpWkfrUK2tYAxoil+7+qeJQEo9/6E=;
        b=KRV/UNxMVozR3SgGWNRkF+8KmXKiyHcs5wzL8F08b5nFnD+CTsPLOXU5mAMytb0gnj
         BocBX+nQyJjnIR2DfhTowuV48shRyf+pDUIhq9irTEQRZG3fDC+ufGOfY1nAZUUVNUqA
         +MmagW6+3rd3JBXfDpjrD9d0putr4wOkdhjSCLI4EF4ncYw0vTVg+VSi5isHLFJXHheH
         NRNZ/Juyb/nFz1cj87SKeyTr5I9z7TW5Qk4QXR0oAMN5+qFQcaAVOoTSTQD1gs3h40m2
         K/42xKCJbMTrTpuMsm1TL3MI1ApfygBFa/KOLzUW5VcQBGmGrgFeRyBM8ZEu8X2o2oZ5
         S3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211836; x=1700816636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+a/E73oKPUIpqCJpWkfrUK2tYAxoil+7+qeJQEo9/6E=;
        b=mMMKGV0270V8YYEGhICljtziowS5s4NCb53eC2innWxicTVchWTeZhyqBkDpBmcthE
         mXlrXIO0f3h1woQE6wXD5vgJ973gO4EZ/WZPoIzFFoO+WsjqC9kSSbsCZlJmhhx7ve0E
         VbLnvhovKCCw6wrZbYLGdwlLnC8b3MYyMWLnWGiCCbZnSxwkjVnmsaUFZSXQLBvuaf5x
         dLWsbNEUdLpcDVjc26mC63sBpVv44gcU/yLV1iY2OyNZn2GcyLEpMxiGvzX68pJIU+NS
         ACtN4yHutPtHHks6mPKMSad6kEnhGV7PHMx+zVAYwRzNsoifwgVRlLXy25+danj0Tdgs
         1Pvw==
X-Gm-Message-State: AOJu0Yz+1BGeXdKg8BbuFMb4UvuW6lmOWHTRd0nN35d5Hs2locXFTIqI
        Z2/t7qU9fJ8rXsQt1cLI0ZOx
X-Google-Smtp-Source: AGHT+IFja+WtC2OS4zhsenW8j0sFIeX9xO+zebfk77FBON46A04n4N2e+BUmVOq8jwsyvcPLOH/0Ew==
X-Received: by 2002:a17:903:2343:b0:1ca:1be4:bda4 with SMTP id c3-20020a170903234300b001ca1be4bda4mr13259932plh.4.1700211836575;
        Fri, 17 Nov 2023 01:03:56 -0800 (PST)
Received: from thinkpad ([103.28.246.177])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001c62e3e1286sm944986pli.166.2023.11.17.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:03:56 -0800 (PST)
Date:   Fri, 17 Nov 2023 14:33:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH v3] arm64: defconfig: Enable GCC, pinctrl and
 interconnect for SDX75
Message-ID: <20231117090349.GA244633@thinkpad>
References: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117055849.534671-1-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:28:49AM +0530, Rohit Agarwal wrote:
> Enable Global Clock controller, pinctrl and interconnect framework
> support for Qualcomm's SDX75 SoC which is required to boot to
> console on sdx75-idp platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
> 
> Hi,
> 
> Changes in v3:
>  - Clubbed all the three patches in a single patch.
>  - Link to v2: https://lore.kernel.org/all/20231116093513.14259-1-quic_rohiagar@quicinc.com/
> 
> Changes in v2:
>  - Updated the commit message for the patches.
> 
> Thanks,
> Rohit.
> 
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b60aa1f89343..4c0cd428d073 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -599,6 +599,7 @@ CONFIG_PINCTRL_SC8280XP=y
>  CONFIG_PINCTRL_SDM660=y
>  CONFIG_PINCTRL_SDM670=y
>  CONFIG_PINCTRL_SDM845=y
> +CONFIG_PINCTRL_SDX75=y
>  CONFIG_PINCTRL_SM6115=y
>  CONFIG_PINCTRL_SM6115_LPASS_LPI=m
>  CONFIG_PINCTRL_SM6125=y
> @@ -1252,6 +1253,7 @@ CONFIG_SDM_GPUCC_845=y
>  CONFIG_SDM_VIDEOCC_845=y
>  CONFIG_SDM_DISPCC_845=y
>  CONFIG_SDM_LPASSCC_845=m
> +CONFIG_SDX_GCC_75=y
>  CONFIG_SM_CAMCC_8250=m
>  CONFIG_SM_DISPCC_6115=m
>  CONFIG_SM_DISPCC_8250=y
> @@ -1519,6 +1521,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SC8180X=y
>  CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>  CONFIG_INTERCONNECT_QCOM_SDM845=y
> +CONFIG_INTERCONNECT_QCOM_SDX75=y

Is there any criteria to make ICC built-in? I'd vote for built-in on all
platforms to keep it aligned eventhough old platforms do not require it for
booting.

- Mani

>  CONFIG_INTERCONNECT_QCOM_SM8150=m
>  CONFIG_INTERCONNECT_QCOM_SM8250=m
>  CONFIG_INTERCONNECT_QCOM_SM8350=m
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F3813007
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573005AbjLNM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573010AbjLNM14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:27:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8669A131
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf898c43cso7828643e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702556881; x=1703161681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfkcmkKvkkXYQpeZuzjEAiTsYS7qsvNSpSZAPh5BmVE=;
        b=KxOIq78K8HYasGg6HFAN4LZi4tXP8x681zOIraBcRjL+PNif5TYZyJ9vU9bJrI/0SG
         JCRi0uZGY1SpaCv9G9uoz0d25B1PLv7v7QQpiPILN70vGdMJIKRhxNP8I8Ea3RvaNqaG
         YTh5r3nwush0COfXZRWdgJOed60zWhhAnEkmxNWcvuDE0JbvVR+rRRkPfUisGy3MZfu0
         A+xPxSEnAdOgwbzTxghaOyvgDh2ti/tR/t3yExQCtldiWuk3gpiRwGqlbIWHHLTlIVQ+
         8uNIV1arJO34QMomYxguXCn/lFzpuZmARl+GcuX1B72jYVy1cjLyw7MTFzULMxBUa7X9
         l3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556881; x=1703161681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfkcmkKvkkXYQpeZuzjEAiTsYS7qsvNSpSZAPh5BmVE=;
        b=bynLQphYumgalsc6ZDMmXMccmPasiHAa4vwGphIMfmvaubXaWxXlU6qpbMlMkwIuAj
         Wz5UwIj/3EThZEy0skFk7dIf1tcTw3ziSqYvRmkTCKzZVZ0zigfuHdAANfheDc68Pdt/
         7oVSPmUp2dZmeAJ34yYDp9jgFVmtZJyCQDCbe5fEmgVgPL/XcCb07lUCEpczfs2GB7uU
         HGa0qNfE6QaLoJVeZIFFzpguU5YeAi6Pic1HuE4MTW4Qmdkl0ltXxGl227ach0v+y6l4
         6eoo6A9iqcC1Yur3QzJ62oSFsdjGeLyhW4s+Ho0fUi7TjsTPCcERHd2h3wKVzSCflafF
         Vaxw==
X-Gm-Message-State: AOJu0YyQsFh3x+mT3t6M9fOH8bh6a5IAE6MwS2RWzbZoS5giT0DOjBVE
        yRYsBF7sop1oOH2B4Vl0vOONNA==
X-Google-Smtp-Source: AGHT+IGtTPHyMJcq2MCv4D+P2RwjYqjAi/JjJolXcTyiuMS71mlSdraT31zM3cAm84XD4KODk4ho2g==
X-Received: by 2002:a05:6512:208c:b0:50b:e110:17c9 with SMTP id t12-20020a056512208c00b0050be11017c9mr2697719lfr.90.1702556880783;
        Thu, 14 Dec 2023 04:28:00 -0800 (PST)
Received: from [172.30.204.158] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k4-20020a05651210c400b0050bef21a012sm1871880lfg.191.2023.12.14.04.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:28:00 -0800 (PST)
Message-ID: <f2a70872-d1e5-4d4d-8231-7106f9185460@linaro.org>
Date:   Thu, 14 Dec 2023 13:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214074319.11023-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 08:43, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
> Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
> Cc: stable@vger.kernel.org      # 6.2
> Cc: Richard Acayan <mailingradian@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

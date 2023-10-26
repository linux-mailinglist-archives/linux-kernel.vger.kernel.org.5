Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA47D80B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbjJZKZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjJZKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:24:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADEFDC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:24:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50816562320so914091e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698315890; x=1698920690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4Cf1JZHZEJIbarHfjcQQvZGpAiamoBRA5YGADyvYNA=;
        b=sB18Qo+oQ0VbqWZxI47oQ1YRnsgcbnT0iPr1FJ2ahjtcvWca8tLfTmf51KD53w6neF
         6Zwm9dwj29FPrukB7Tfg9ux2H4IcRr7MnsvDuQSFHFUZ+JvEAk5cnSD8+JNY+EhQecrx
         HYXgNI9Qhd5mb196zwd5dR+VFu6jPCTeC+a21goOTH0x+ngd/bGkPvw4GaVymyndQqBn
         iKe1SYYEYD28sGSO9ZUvL2hObST/XfTTsYKb2++tMQbbhctDIyZcg+aHF8AJvKFRi8+t
         duBkWou2wOgGLhM0q+WpCJq5yHvtIUr/jETFh6zeMxoLOPEdD1QnPvL8CNCMnPBdW4ak
         jA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315890; x=1698920690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4Cf1JZHZEJIbarHfjcQQvZGpAiamoBRA5YGADyvYNA=;
        b=Iamlg2PpBGDEqUUl4e1VsiwE9/UwnsxTsicOz6kRz0XkOwfxtACad3qjzyEzbSj00V
         kzyQtkdUTISIEJL636OlpP5qXX2rmnksIrbGMVJCuv3IuUCUW3bRpRUt4VAfZQLkr4CE
         ZPnSazXRwE7IFCLIIuVAt5RIqE5kHJtBulsBBxMKlOUK1//r0h7UEx1qIZxnJXZwlDYK
         7MCzhjpYXTMyfSYn+2PtU9LOfzU7dXnGKo1uF/EEi1FbUl/ySx1ZKfZxQGsJ5aAgZFO4
         SW0sx4sUpVZcvprMQ/EW4OuKDvvZCyteBfi2Vcak63d5pymhvWUtFJ6QflZnznWEO7Si
         ctIQ==
X-Gm-Message-State: AOJu0Yzy+eoIWRDFhDKRlwo7E6y22KvMN+1TACpNgJ+VBEPqcCqiNYq6
        1Gxqht6m/auZzZvRcq31RVtYbQ==
X-Google-Smtp-Source: AGHT+IFsc+CJWxE8BflOegK1D3LDUoloSBpJPCNoiuJnlzySCAJ0Gg7g6Sh6PmKM3Wnl1JkJm31pOg==
X-Received: by 2002:ac2:54aa:0:b0:505:7360:6010 with SMTP id w10-20020ac254aa000000b0050573606010mr12221397lfk.28.1698315889795;
        Thu, 26 Oct 2023 03:24:49 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 14-20020ac25f4e000000b005068d6de988sm2940995lfz.226.2023.10.26.03.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 03:24:49 -0700 (PDT)
Message-ID: <d0b22e91-ebf0-47e8-985e-f99629f97cf7@linaro.org>
Date:   Thu, 26 Oct 2023 12:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: arm: qcom: Document SC8380XP SoC and
 boards
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, ulf.hansson@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, ayan.kumar.halder@amd.com,
        j@jannau.net, dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        m.szyprowski@samsung.com, u-kumar1@ti.com, peng.fan@nxp.com,
        lpieralisi@kernel.org, quic_rjendra@quicinc.com,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
 <20231025142427.2661-3-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025142427.2661-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 16:24, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Document the SC8380XP SoC binding and also the boards using it.
> Also document the new board id qcp (Qualcomm Compute Platform).
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
Looks good, but can you elaborate a bit more on QCP? Is it going
to be a new fuse setting for devices that fall into the "compute"
category, but aren't necessarily CRDs?

Konrad

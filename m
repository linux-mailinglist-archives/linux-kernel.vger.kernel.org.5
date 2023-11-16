Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076027EE37A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345354AbjKPO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345355AbjKPO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:59:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC844D52
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:58:57 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso1295402e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146736; x=1700751536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LRHtC2gpJmEwx4E/5yYYZdnHzrj5ZjGQiahaov9z+Q=;
        b=B9B36SbSlHylhwlmd97I5+Ha/uBPiChIlTZY9TmQ6DnPejnz72h5Usncp4haDG553h
         gRWDYQYdv5nUzHpVhk0BX1CTwVVg/0axWLxAvqvwFuwW7XuQIdPrsSXH65WN0oRiTnpd
         N8caerjLNj8+Ugd78fIK/+uGXX0mh70/Ao++kXhSAh1tATxMw3qje5QIyN9bVzXTYgj7
         7DELwpNzwGSJ7yJTAIbIGspdXXMsBbvmZQ6wBrRJgkKHMK6FNINUMBXElURROAW2xqvy
         bCOBfsTvdhr3DzICUUCTKA86TXhQ90vcBreJboJDlicskRcfWlp8ZIJOaz/Nk97AvMdR
         umyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146736; x=1700751536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LRHtC2gpJmEwx4E/5yYYZdnHzrj5ZjGQiahaov9z+Q=;
        b=qEYp8eO2c7MS//8vAHZVmNw0YJAST1edwYkDsCEv5k25HwwZIGwFWHPpw/HKiFNp1k
         +ZPhLGccbZRrlEcA0ZhUXfrrPg5T2W/Hp346aCNbBt/CHga7mAdeSBwewv1eKxEpjlcG
         ceHtvsCGcqpRTmZYh15zK4gd1+5V3ha23A0dHllnUCklFQNGjg7pzQZxX2I2qmjS4HmN
         gysPgM4E/5aY/eiXLWLIcqfu0SusVDrqBgDNaHgrms6OMX5ns3FkuqNseNSz0uWdwBXn
         hPH98d6Pjxu/89rYy4Fe9R2QLXXL9j/F0gpbMvkG9Ob4OkOSgmv1oK2VAviIYAYyDvft
         x/eA==
X-Gm-Message-State: AOJu0YxTB3BqMORt5uqzY2AN6XWY8g2JCfWFQP5QXdMAcndfQ75ZTmes
        LeWdGgXtCpPbaqfsR4x2R21hVw==
X-Google-Smtp-Source: AGHT+IF39sYCCAsll4ai1X8v8QufbfS9p0GWBm5Tl1nARHiZftR7iTpIiKo0fROv1yllcNFaaBMSNw==
X-Received: by 2002:a19:750d:0:b0:50a:10a6:1448 with SMTP id y13-20020a19750d000000b0050a10a61448mr11111060lfe.59.1700146735779;
        Thu, 16 Nov 2023 06:58:55 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a199142000000b00509463003e7sm17278lfj.186.2023.11.16.06.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:58:55 -0800 (PST)
Message-ID: <c640dc18-b4f8-46e5-9bfd-b1349f7d91ff@linaro.org>
Date:   Thu, 16 Nov 2023 15:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] arm64: dts: qcom: sc7280: Add CDSP node
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231113-sc7280-remoteprocs-v2-0-e5c5fd5268a7@fairphone.com>
 <20231113-sc7280-remoteprocs-v2-9-e5c5fd5268a7@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-9-e5c5fd5268a7@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 09:56, Luca Weiss wrote:
> Add the node for the ADSP found on the SC7280 SoC, using standard
> Qualcomm firmware.
> 
> Remove the reserved-memory node from sc7280-chrome-common since CDSP is
> currently not used there.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>


[...]

> +			interconnects = <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
QCOM_ICC_TAG_ALWAYS

Konrad

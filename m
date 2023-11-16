Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3E7EE366
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjKPO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjKPO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:56:09 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699E893
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:05 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507be298d2aso1151397e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146563; x=1700751363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOjtDTqTnf7Djty8sAXJwD9eQx6I0vPmvqRRWr4Mj8Q=;
        b=TahFNGsgu7GDPRFlLGHT8S1BKnpSxBlpbyKZeN6indXTpuZxp2RTYFgfogtjYgchfE
         ZhmpRFbQmHKG165hEYxvuHILMIOoCjfYTEyMigRY3/Dq2PJJ3EAJJZyd+CbOXYteTvFG
         Z+nSzn7L2yDysCPRUk1mnHTilNkpcm1qCidQHxpMfv8bFA3XhHKEPH0OlSnaUsYvGvvT
         mOZcc++ND5tFdTcQw3zOXlmhHVnYDkpEJqG1QLpa3ivhN4Ym+ZLF7s+0bpn/UlBX0JYo
         6Sd9KIcSY3u6W/K73bVapZKJa25AetzuuXi+HtTi4bXX722wqnBHRyuVoujcaibX0q2t
         8EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146564; x=1700751364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOjtDTqTnf7Djty8sAXJwD9eQx6I0vPmvqRRWr4Mj8Q=;
        b=VHS2wZcjzYsQ45zTlvUxbJj844QoGxncqIVB52PoypzX5UCwn/qo7FMuQYw1BJj774
         z8TCmqHax77g2R4OoXmHNIaLWvadaJ/r0tW+Bums/HdSOSQWjrSR4D6qHCGA3IMWcLko
         3QZeLYb8v5mgRupTPLBrl5Tc5XPH1HXUPjSDn0kfURtjFgz2VuDSPNx+Edu3Z0zATp3L
         Vu1UoPpwytTqJVGZpIGG4/0omGDb5DvUbYDJIGTYxAJjq/lp25e+YUPOEZq0X40CLKON
         D6TmqsFL8SFsaRHtT/kz53hhPcrKlS4ssT8Cu5Guy40yi4pAPo7hbuR9dfqIxzNb2PU4
         YOgw==
X-Gm-Message-State: AOJu0YyFMaSBYUcxTmvzM/K9Lnh3xKtzPo7EcoSxvUH2HEYbTDyV3zW1
        M9J/fFVPp4HS+w7tPcP4OWaZyQ==
X-Google-Smtp-Source: AGHT+IFDMYXqlEg+F4sWMGncBm04jorAZmXLffuWB4mSZRl9WUMnZsfBmoQ3Py0+VAOCD0Sg3r5ZvA==
X-Received: by 2002:ac2:54b9:0:b0:500:d4d9:25b5 with SMTP id w25-20020ac254b9000000b00500d4d925b5mr10759938lfk.56.1700146563658;
        Thu, 16 Nov 2023 06:56:03 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a199142000000b00509463003e7sm17278lfj.186.2023.11.16.06.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:56:02 -0800 (PST)
Message-ID: <15792113-c54d-404c-b686-cc7c75ff542e@linaro.org>
Date:   Thu, 16 Nov 2023 15:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP
 & WPSS
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
 <20231113-sc7280-remoteprocs-v2-6-e5c5fd5268a7@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-6-e5c5fd5268a7@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 09:56, Luca Weiss wrote:
> Add support for the ADSP, CDSP and WPSS remoteprocs found on the SC7280
> SoC using the q6v5-pas driver.
> 
> This driver can be used on regular LA ("Linux Android") based releases,
> however the SC7280 ChromeOS devices need different driver support due to
> firmware differences.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77007EE371
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjKPO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:57:40 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8BFAD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:57:36 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5210a1515so12401891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146655; x=1700751455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0j2XTymde6n77RZxuh+iJCPkZ01ZtzNu1Y+icYSnoY=;
        b=TiSslfS/e7BRQd7w4sNt42QjLdjB+60uzBahgBePHhJV8wWiH4AxMxaQnUigSzGPrY
         jX9I/rDCmG6sBsOOSKlCrpwq5s+M5uFkKSw8CBl07/gV6RaT2jeo/KGCyyAKhQ9M1x5O
         N8HzxoISeTbbFrA4AAMd8LjUs/5rj0dn6yg5ti6Pu5rYUbUf48ZdbmbmSSUVyJY6ZrNh
         H2SgVTNnYDtKYpaOXJ1Xpr+mk2LUbS8Jc1+z2lWKCiGQ5hqdZn5idQkrOu2hVVk0uEpB
         ZRWZ+Ljyhidl44ujcIzPDM+37kbtc+85ffvz9MKsFiYuILdtOd4lmG6kIKNUGHWYyFWA
         SXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146655; x=1700751455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0j2XTymde6n77RZxuh+iJCPkZ01ZtzNu1Y+icYSnoY=;
        b=Yf1w0vueCvhkvW8dvzwh+YNemnWdcnGJyRHnHbq2yXu84Ld/s8Di8JAaTUSBO+1GbV
         lExFSMAxByYJ7lC7NGqO0H8fX8s0isgwcM9jZh8OrPXgekUD+GVvKsBTreSbBXArteIx
         OUAi/aA1mIOkxiWzjuLWSAZgyKa49buQ+/P47LHNrA1pZW1aTzFsquTeS2NoyocWFOmL
         K6hdLTkH0aaA0Unmi9aAhE7poRubuvTVY9lPUFqCtBZX+EqAVJrrEkvi7eWG2uME8r0A
         8Lt5VyjVoQuI8vKOQUi91jVhh3tORQ2g7ldMFb/zy3e/uHKdiXOzBbas15KRMoT+t9kD
         OhBQ==
X-Gm-Message-State: AOJu0Yy8oKG2bAoriiujMcIK049AwG+MPu7gILuQdluzDI4DwgQpRRWx
        /SXpNQDhAJChJXCA+c6FxV5uDw==
X-Google-Smtp-Source: AGHT+IFfCgVFmiQVrotF5sQQJuOfgF8Pp6fg4nFG0tBbccGK279cm85THeZg3qohiSXi7l+aJTlQ0A==
X-Received: by 2002:a19:5e47:0:b0:509:476a:ee51 with SMTP id z7-20020a195e47000000b00509476aee51mr11127194lfi.20.1700146654824;
        Thu, 16 Nov 2023 06:57:34 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a199142000000b00509463003e7sm17278lfj.186.2023.11.16.06.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:57:34 -0800 (PST)
Message-ID: <48139b6d-5ceb-44a7-bc73-ed1621d5f656@linaro.org>
Date:   Thu, 16 Nov 2023 15:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: sc7280: Add ADSP node
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
 <20231113-sc7280-remoteprocs-v2-8-e5c5fd5268a7@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-8-e5c5fd5268a7@fairphone.com>
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
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

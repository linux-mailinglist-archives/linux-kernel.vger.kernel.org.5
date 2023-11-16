Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5477EE35C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbjKPOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbjKPOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:53:27 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD7AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:53:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso1284097e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146403; x=1700751203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCGMSCkSoWBnrTUSH4qK8JLFeQXZXM72s+bKdEOy7ms=;
        b=P3Si+JPn/hgQt7EhlIlwDGnCgvwYM44ahuQAqX84bJ2Sx2LukOf5a6vogMWD4jOWWD
         vIgMSr6dTL/Pk4xI/oMrYVZm9FlAaK5rTiqHQa8jjvPxGPdefaaAN3/XQH89fZ3Y2G6R
         qbVqPuFYulCo9an/R0nLQ6wDc0hwqm5wo9o710T0ExjcXqt3dNxjYeC3dEw/Oy8MoQO8
         5/F2Th9RS2bSzdXFyQ7n+xLB+YTALYtAZlrS2amQA//EJtgFIJEItcDiHacwFCaeD8qu
         t5AIOXQvec+mEWIX4boFasjxi5KVJuPodcsimGZy2oki2rFiwIdDswEZF9zMP8SRu8xI
         6VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146403; x=1700751203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCGMSCkSoWBnrTUSH4qK8JLFeQXZXM72s+bKdEOy7ms=;
        b=jp19yMgOYur1PLB1HMSungi7RX0iGmc3Lg+WX4jtw8fhr7t3s8gZKW85/zy8Ncwr3r
         ql3IjryFY8BYAlK+dA5XMjzsGYMWhoy2bcU7xFvk7GElW3JJEGZWbt4vlxykExw8NOC2
         fSWFW0thZSAY4w0bgFvmD3fHuPAPYOcBAGYyed1xZBLKbUvfcBNHy7HiqUMaUfpv13Gb
         4OMxLij62ILdctr3M9dgbVrd3chwoKMZXRD0+UM0S0IaodrLHoo5960HApIwm0Mfj0ui
         TNsefVW1daHDQ7EKrYp9rNrebR/M8eLfUkjxhbAB3+Pb4AL6om5uYb+tzcRxFigbpOMl
         e+HA==
X-Gm-Message-State: AOJu0YyxSJ/L6ba6LPZIMj/xUNiSxR0a4ewzYXX9tnu/E/mLnePvYYNm
        4XI76NvsrpZ/iRwEswPk5m5Atg==
X-Google-Smtp-Source: AGHT+IEdBplgYFkk+bVCMr/NvJAR836rixMiQjKtxiF+Lp7YEE2DvqnWbMgqfbd/oPwUsrp1S/MBLw==
X-Received: by 2002:ac2:504d:0:b0:509:455c:9e3d with SMTP id a13-20020ac2504d000000b00509455c9e3dmr1758698lfm.18.1700146402658;
        Thu, 16 Nov 2023 06:53:22 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b004fe5608e412sm16550lfu.170.2023.11.16.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:53:21 -0800 (PST)
Message-ID: <ac66f3c6-04bf-4194-ba81-f91bee5cb13c@linaro.org>
Date:   Thu, 16 Nov 2023 15:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] arm64: dts: qcom: sc7280: Rename reserved-memory
 nodes
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
 <20231113-sc7280-remoteprocs-v2-3-e5c5fd5268a7@fairphone.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231113-sc7280-remoteprocs-v2-3-e5c5fd5268a7@fairphone.com>
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
> It was clarified a while ago that reserved-memory nodes shouldn't be
> called memory@ but should have a descriptive name. Update sc7280.dtsi to
> follow that.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

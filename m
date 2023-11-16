Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822E37EDF62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbjKPLQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjKPLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:16:19 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DAB5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:16:16 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5875c300becso376782eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700133374; x=1700738174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th8Cj+mO5ZqE4oT+uIcINI64qJyiQSbMF3c9mZmKXE4=;
        b=TSNxKRshYHGslR/rsQSfQ+5IRZI6Rl2JjTiS8Et/KbKDJFQXq5KL+UO2AkgA7ZbvN/
         Nn4HlGu3SFHT8eGG/BwfX98vZb0Yx+GU/YCr5WVNJrm/AQbDFh5hBJ+xZ++6Bt94okF8
         Q8oDrM04Urn9ZvxjfyoBcNarTzka0Hhy8KF6iCZ86jPCiThXvueesvXeMSVmvlNcH/Gt
         8qjm6ePYvJABLiOzlW2kUY5Mvt4bch9yURxv8niBK/3mOY9YkE7GNUvxnrq2ayt32F7j
         aacyYjYS6vlmNAn6U0xgxJ+OqniV9SHereRol11ZSNqHqfUzHvGmPtZt4O9d+I38FBy3
         l8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133374; x=1700738174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th8Cj+mO5ZqE4oT+uIcINI64qJyiQSbMF3c9mZmKXE4=;
        b=a+IEevSFQZy+l4WiW9j9wTMwaMk1p3tmtclaWae4RynCMrOcz5HjAfH/sy4HJ6ToMb
         K5nZqWEXKVO1geVc12MC8w1MCK6V4whttOFEzhJ0DNiLjwiSiaER2/Q7qkqIQiImdTGL
         97p2zMf5QKzc1zJ4PR5KfhBxKDETq63BprxgfIRE5J2YvyeXTftDZfwOzsVVCvStYwKx
         8kKz6xKb7ADH+Kh+TfM/XHvKjmQUivBFVmIMoAnYDCLEdUTiidP0CpuacLTdxBvZZo3+
         l1VRjmH9P8QpQYVtGOEOXjky0yZ13ivwEcKVm418QC4SdJbW762PzwXPRZU6Ir1RAkey
         jT4Q==
X-Gm-Message-State: AOJu0YzRTlZRMRzgAHs4wEpC/WCyB9U2z4XOWMeUIhM4YxLipONv3jAa
        mHNzXyCtLczMaduKwGnbe+UqqQ==
X-Google-Smtp-Source: AGHT+IFSWNcDMjr8E6irP+Q08pFVSG9V1Gb6j+9OkSIJrID9ggI0EyRh9jEEnDLPbVksyHfdMz7EbA==
X-Received: by 2002:a05:6359:5c29:b0:16b:fa0d:8265 with SMTP id pu41-20020a0563595c2900b0016bfa0d8265mr6709135rwb.4.1700133374359;
        Thu, 16 Nov 2023 03:16:14 -0800 (PST)
Received: from [192.168.212.13] ([12.191.197.195])
        by smtp.gmail.com with ESMTPSA id r5-20020ac85205000000b0041519614354sm4271080qtn.7.2023.11.16.03.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:16:13 -0800 (PST)
Message-ID: <4b8b486a-3bce-4b1d-b844-7d2dc499db0f@linaro.org>
Date:   Thu, 16 Nov 2023 12:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: defconfig: Enable GCC for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, catalin.marinas@arm.com,
        will@kernel.org, quic_bjorande@quicinc.com,
        geert+renesas@glider.be, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
        peng.fan@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com
References: <20231116093513.14259-1-quic_rohiagar@quicinc.com>
 <20231116093513.14259-2-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231116093513.14259-2-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 10:35, Rohit Agarwal wrote:
> Enable Global Clock controller framework support for
> Qualcomm's SDX75 SoC which is required to boot to console
> on sdx75-idp platform.

No, really, this is just one patch, not three. You do not enable a
platform with one-by-one config patches.

Best regards,
Krzysztof


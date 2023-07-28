Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A817766554
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjG1H22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjG1H2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:28:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5D3C15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:27:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962535808so29390411fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690529270; x=1691134070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNafLEWKCWHk1Q/GCD8fpQN53csIuJxGCApzHzUl+J4=;
        b=cvbyYal9w/8O6TpbNSfZiSB3NPbKpNrbwA0Pl8KoO5akeSN1cstQQ/3b0Fwq5nboJa
         W08NUyupLmp7hVAHqGvmTwGWEGWFcoJkFHiRpf3aSGISo6EOlUr58+O1Pq8nh6qD8Vel
         F5lc7uKMMCdsGa/lT6eEXEp2HB5NxHnf/6OgoZ3Rv+76Beok3p2FReGLgoN66L48ODYs
         hZjqrlnys23DUbaZ/bMns+GJOosP8dE4lok2/iWDK2md5NnzBPteZaFOcZ8Gb4AdoOss
         FmoH0YZQnBM8pZ2bpljO4kMA0tkUFV0HwoBUIlVCPZtQCZFk4ZEfRJ3gOOAFZGiRntch
         9/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529270; x=1691134070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNafLEWKCWHk1Q/GCD8fpQN53csIuJxGCApzHzUl+J4=;
        b=Pj9VqBxHokC3MYceGfQAvY6Tc9U7GCY8zJz0DE7wopLhhXebTTcvbwey4RTwGbLhHR
         tkmi/DFIXaSsDL/yALRSaAHeuqJ3Zqs08TJ8SCtU98bAiwjZPffjgJWVQKRyP1jdyv5r
         RbiGtwaydVumUMspG5Yf5J+dbPz5Z3zpkcmBwvwGDJZYBQ0AywziVesjhx7cQE2DK5Uf
         VOt1V2tEIarXT7zawyW1JGl6cyCTGQCfGxwuBR2+zQG0e8wIznnsZroSIrpuxtLTnUSp
         YbfTr7P4oFt3uVW6IOFfRuZBG++5cxir27NlHvl/DayyPl8xExbvv/i6t3ZRVc9XPz3x
         iWKw==
X-Gm-Message-State: ABy/qLYvppUmtgWhgr70zTO0ayj6BgKkPXajlRV11ds82XG/D/qbq93X
        sAcNu7gNmt7CPFuLZCFqR/lRxA==
X-Google-Smtp-Source: APBJJlHbQY+iRJVVhNPkSxL+x0Z0ZzSaBO/HRp6/q5HSe9MRZCYGRTErk6fUi0vWZuvnX7tYEjn/Ew==
X-Received: by 2002:a2e:2e17:0:b0:2b9:6d6e:df5c with SMTP id u23-20020a2e2e17000000b002b96d6edf5cmr1067297lju.5.1690529270007;
        Fri, 28 Jul 2023 00:27:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bc5c5000000b003fbe4cecc3bsm6430037wmk.16.2023.07.28.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:27:49 -0700 (PDT)
Message-ID: <08cd9bb5-678f-e03e-4598-dd1785f0d7a7@linaro.org>
Date:   Fri, 28 Jul 2023 09:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/13] dt-bindings: drm/msm/gpu: Extend bindings for
 chip-id
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230727212208.102501-1-robdclark@gmail.com>
 <20230727212208.102501-13-robdclark@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727212208.102501-13-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 23:20, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Upcoming GPUs use an opaque chip-id for identifying the GPU.

Examples?

Anyway, I think we should insist here of using something human-readable,
even if Qualcomm/Adreno internally use some weird numbers.

> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> index 58ca8912a8c3..56b9b247e8c2 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -13,6 +13,12 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - description: |
> +          The driver is parsing the compat string for Adreno to
> +          figure out the chip-id.
> +        items:
> +          - pattern: '^qcom,adreno-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$'

{8} should work?



Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEEF786C56
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbjHXJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjHXJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:53:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF6198E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:53:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so10076047e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692870798; x=1693475598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g60VBMn/aljS3vqGvUqOg19aGKd4uLJiany69UQcE6M=;
        b=OkHLvcxdBfs7T4d+Uro473dnXIgA8ARjvI82Wy2cADHSOBNa1ejmN/SgnoZ4xcEvry
         6jPrJljcG6ZDSu/Z0vbbrmnMe/pk2k/vfk8Ou9Rdohu92g6M85hfHSpq6rQvKlnG9OQa
         sN+VTgroGmPuMXqX39evvjw/EwWvM2DteFFmioq6wWtChpbm0bb4kjSsdG7J2N7q0m6T
         crLVFOk0a/QpZRSyj+2Y3lOU3P1N8LPCGPe4fBmitBPNzfGfGpwNeDHrZIgT5m3CaG8h
         hMeup0BXIvLV/3zDSv7HMQb2/oBO6jZ5E5h9OgGqDddv79nZf23n+uxTx9sgLdSzg/hp
         Epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692870798; x=1693475598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g60VBMn/aljS3vqGvUqOg19aGKd4uLJiany69UQcE6M=;
        b=WWblUYhMIThktVszCQA+yFrCUGGlOoikMJDX6Ce6tLaX22iZbGbNMvAqrEmUQZVcuu
         ac4pt0A27fqMK41L/fcYkE8Fh1/ttAhmX+uRoWK7th3nvO80IHNiDSq+Nb3In8mxroEX
         Cd0ewtDYxudFvBFU84xx+3S9moHVQKZUTxg8jXWBIdh0Fa4JJcUUZ9VT+95OKAGGk5Ii
         yqDrQ2If1S7UWlCxEgfsy73NIGNXBi5BnYQ2bMGeO6RucIBeGVMVppgk1hzXH97RC5Aj
         o2BgDJlydHh4c8B7JxJLrqaFhioVv3IxcOPoMlJfN+/MvCWRj8TAQcvMVK0PipIU/q3H
         Mxnw==
X-Gm-Message-State: AOJu0YyTcVx6uYl2TfjMbC3CsaXTv70iHv9o/XTdgurQLBqQW/V/ekAZ
        oqeof51atsld+ZmfFGrctuyF9g==
X-Google-Smtp-Source: AGHT+IFg+NGq6lHT5zvQa04TKD/1OTuEpj2KqEJnnm7Vypb5tB5uKla7biRyFVuNT0E5pCS8yzUtLw==
X-Received: by 2002:a19:5f50:0:b0:4fb:99c7:bb60 with SMTP id a16-20020a195f50000000b004fb99c7bb60mr8711656lfj.59.1692870798203;
        Thu, 24 Aug 2023 02:53:18 -0700 (PDT)
Received: from ?IPV6:2a00:f41:4882:ba34:4490:938b:eab4:c5ef? ([2a00:f41:4882:ba34:4490:938b:eab4:c5ef])
        by smtp.gmail.com with ESMTPSA id u6-20020ac243c6000000b0050097974ee0sm652660lfl.224.2023.08.24.02.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 02:53:17 -0700 (PDT)
Message-ID: <9db02015-2c41-40d6-bf35-69ef277e9ce4@linaro.org>
Date:   Thu, 24 Aug 2023 11:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add initial support for SM7125 and Xiaomi SM7125
 platform
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
References: <20230824091737.75813-1-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230824091737.75813-1-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2023 11:15, David Wronek wrote:
> This series introduces support for the Qualcomm SM7125 SoC and the
> Xiaomi SM7125 platform.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
Would your device boot if you:

- removed qcom,board-id and qcom,msm-id
- created the image like this:

mkbootimg \
--kernel arch/arm64/boot/Image.gz \
--dtb arch/arm64/boot/dts/qcom/blahblah.dtb \
--ramdisk blah.img \
--pagesize 4096 \
--base 0x0 \
--kernel_offset 0x8000 \
--ramdisk_offset 0x1000000 \
--tags_offset 0x100 \
--cmdline "foobarbaz" \
--dtb_offset 0x1f00000 \
--header_version 2 \
-o boot.img

?

Konrad

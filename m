Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B637DC210
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjJ3VrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:47:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1AED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:47:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507d7b73b74so6902694e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698702428; x=1699307228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dv1A6zRVtWjITncFEynfH6q7DmHK59zb3ejZomKVK5I=;
        b=ofRbc3+Se4iGaRyAnXEn8MCKVUtk1vr4WGbh94ppvslTPUZHf1mfiv0T6zy/vUjhaZ
         mm3lRERFmZMr1HyRu5/1BfitNcBA8A1aVm1cI6mOrNin7Oye1ngmSeMl5dPhLxVCf5mT
         ilXOevHpsWvrEx9YW17gXNNHOiGRk/6U46g1J4IoyXy+qcVzngCk+8cN3z0OXvQ9Iyqy
         ghT4wB942/BLdf4MvoN0wYAY5Q3g5M3TCQTOTLT+vZQIgHrHpQouZnuspwUw3sntk24e
         0hNyWKgHO0e2Dizts9rZoe4acV4wsN4N+22LWkAL3Is1+KIiRdnJYpboqxyasBvZDhhH
         le0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698702428; x=1699307228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv1A6zRVtWjITncFEynfH6q7DmHK59zb3ejZomKVK5I=;
        b=cucD6ztIKN1+wv2GKabKrmxBnula2t+SwJLGn/+WmOqLmFcbFbkjsP8E6uGGRSgFyX
         7UR4tW1zC3HgkFOCE+FIjcYDNNzDAprIyVx+ZFdR4pr9tXuJpdG+0qWf8qXMSEeFqE/A
         0bPt4wZ6nY5uFRK0rn/0jFAZCadKDBzs9eLJKhQ9piTgFCK+oMdM9cmQtMCvtcHbvATX
         a8j/2n/gbdqhiC9cj6154MGz1js5bG/Uofr4PFDu1Z2zleyhL7MZ4Oj6FNaA/s6XqI/u
         OdhyNO+xL2uXlK9IG3UhlsWVg9f7Pczg3G8hBBw+j2ahTq20AJlj8TlLagbahnw8O3Fz
         mdBw==
X-Gm-Message-State: AOJu0YzxWEjl6w4OrGTMSL+S8LJSwNL46zs8OWAIxJ72nm0bf1H8+9TI
        O1O+dbFeduAh0iGvoo1kbULeyA==
X-Google-Smtp-Source: AGHT+IHmRDlszl8xXIE1W9t6Pw63BxnEfMvhLkP9f+p8IeQs8mTiLMc10wVlxB2OuvHWtxzfX3B9Zg==
X-Received: by 2002:a05:6512:4026:b0:507:a16d:cf55 with SMTP id br38-20020a056512402600b00507a16dcf55mr10250215lfb.68.1698702428634;
        Mon, 30 Oct 2023 14:47:08 -0700 (PDT)
Received: from [192.168.133.160] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id bp42-20020a05651215aa00b00509133c05aesm1053784lfb.306.2023.10.30.14.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 14:47:08 -0700 (PDT)
Message-ID: <d6b63a3c-d171-4b6b-b222-8c619d90f51b@linaro.org>
Date:   Mon, 30 Oct 2023 22:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: acer-aspire1: Enable RTC
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-1-5ff3cf8b5701@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231027-aspire1-sound-v1-1-5ff3cf8b5701@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.2023 16:42, Nikita Travkin wrote:
> pm6150 has a read-only RTC that can be used to keep the time with some
> extra userspace tools. Enable it.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

kinda unsure why it'd ever be disabled

Konrad

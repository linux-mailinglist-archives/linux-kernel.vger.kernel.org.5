Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025907FD78F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjK2NLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjK2NLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:11:19 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98EBBE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:11:24 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so5304541fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701263483; x=1701868283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWMf/klpzywMLzA0r9l0xYbzFZeq3FK18LVIlLuRJbg=;
        b=jvlFeAZetzKCkTXAvbY4n8Vj5w3ErB44NvRr5di0IzytgCiIJLSlNHWpTLHj2oJIcU
         isxS+ATxC3PG61uwSwtEp5BS01GVwFoGDDO/LbW3DUiOk97uKiGHo5ju+B1OBXR7A4qd
         3oh3BMZifxmebFSHYhd2xi5KX7/zrXWB4NsHBjX+U/MMfgUiDjYcE9+Cun68E6xg+ck4
         zSECJrhSPVCoWw4IJTyUJDpp2LZnCKx8vrBPv2MLublIGyAHBYToufJN2sq1CkrYi2PQ
         IU7W2HOl1fxfAuBUufIyJyUEJaluz0R6lY6NV+UzFPljeVPMZFKhHWeE8Ja9KP3eQQnF
         ehtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263483; x=1701868283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWMf/klpzywMLzA0r9l0xYbzFZeq3FK18LVIlLuRJbg=;
        b=lSdUY/ss3cib5ew1rMzMwpYP8jkUdQW73SSNiLq7miLoGeZ5Wn6w0s6yALLSJNC7E8
         533/wACnvQ5C7ofBz9KKO5Fd/2AbHtw48ikoVgqklJBOg6+xJl1ZPmAdPNy/pdvsRtIB
         ZO50dt/qLsGaCdmyZxzA3skka8s5kkcJkL9ATX34HlLVhYu8tkUjZWMNySHxQ9tR+mhv
         Sfvvkw11L4nQHtk/3k9XFdpXEXG6EXQZnrYGnAtZwBVRXfXDlHNNdWcKNUBbm4pE4UKr
         OdHCdYseSuqUJkyr3DnfSQfrm2kFZxx1E79h9FZi25VNoOna1AAu1oxjvci4OWYczino
         1ZsQ==
X-Gm-Message-State: AOJu0Yxw5pdN7mjEWaQUx03SOfLfdROPwa9IhpXxccxrt/qcamDVeePg
        nn2tPf0rGMk7+HPmmmgu6LDX7A==
X-Google-Smtp-Source: AGHT+IHpvrnrEzzRn83d4IZPTHmaxwag88GIMbhkKF73ZmvwoY4hLd/VWHGxuvvDqQZdVuP/yVKQhw==
X-Received: by 2002:a2e:8804:0:b0:2c9:b84a:1485 with SMTP id x4-20020a2e8804000000b002c9b84a1485mr2743559ljh.7.1701263482976;
        Wed, 29 Nov 2023 05:11:22 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id i3-20020a05600c354300b0040b4b2a15ebsm2142988wmq.28.2023.11.29.05.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 05:11:22 -0800 (PST)
Message-ID: <3c92f044-d69f-4593-8aee-6d9b318b90e9@linaro.org>
Date:   Wed, 29 Nov 2023 14:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: thermal: qcom-tsens: document the SM8650
 Temperature Sensor
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231128-topic-sm8650-upstream-bindings-tsens-v3-1-54179e6646d3@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-tsens-v3-1-54179e6646d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 09:44, Neil Armstrong wrote:
> Document the Temperature Sensor (TSENS) on the SM8650 Platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


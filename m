Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286EC7B2FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjI2KHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2KH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:07:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D681AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:07:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405361bba99so137822745e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695982041; x=1696586841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saeVjZKnNIdT5X2zsR9LIVhUYqk+dCAG4klu5qT+Ffg=;
        b=lRFS8YZw2YXxaLiLUcmc8FelgGsR4YKETDVJ/Fi9XKvFK06VD8bHY2wWojQ65gEfx5
         7kapsYcNlWnnZh7hmAs8sSu3pPfzSMrV50oa9na/IMavd8nvkRGxvx1Rph0nfyaMPk5j
         xMNTg1Gcq8phChu5zytFNilTmC5jnOdXyojyglIR7UBLPnuzn8grk5/IykNEO8S5G3/w
         seWsx0Y4z8oouBHIwO8gy9Ypag+4hQtoETPPrfIJTzm7CcyH7VEZJVI3UvVLxp8FaGzG
         V8gx+19FQ59FsmOPM55ALeyhHlCJQ2Q7qx9dRV05Q8LtTk+7jo4aDiGn36FiTB8nE3Pu
         QdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695982041; x=1696586841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saeVjZKnNIdT5X2zsR9LIVhUYqk+dCAG4klu5qT+Ffg=;
        b=c6dBp3yWvo4qWdwAANE7V2wkdXNPcNh+OkgINpWz6mt4y1x4zad1T38xLTqGyBhA0F
         JobjwPQZCHFXFJZxlbY6pHltSwiTWRRUE6tWPGtJ7sBmIwJMb2t6FUHMarwLdVC8NAo6
         ELrp3VQiTLnbGIeFWzztzWgyFjsjVY2rQW6GSrIW+FXuzZA0axDdBO/mOkDIfzvvLhaa
         6J01dRECnj58Qqjcc6bXHTDb2bbmcCsy6rvyLlVoZPZLqGsefZ9IMTk0HWComcZx1jkh
         PaPJOvs1X97v/a39Ylyv1L71SL5ukW2dLAcWr3TG30McbSXm9xN0ST6SShv4dKDzPIXc
         BEhA==
X-Gm-Message-State: AOJu0YzWvpTv2XQdPs+LeWXGU1JdV8CFW9iULataLFv6Y5/y1gjEipSY
        s+gXxXcoPX5VLSPwyzKrlFI+gg==
X-Google-Smtp-Source: AGHT+IERNMlExukG/RveR36j1SNOU9On3l/LWyUL6FUPZWyOQjBBFEni+g6TLCYEFZZRLr9PU0SzYw==
X-Received: by 2002:adf:f08f:0:b0:323:1d06:38e5 with SMTP id n15-20020adff08f000000b003231d0638e5mr3438326wro.55.1695982040734;
        Fri, 29 Sep 2023 03:07:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m4-20020adff384000000b00321673de0d7sm5852687wro.25.2023.09.29.03.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 03:07:20 -0700 (PDT)
Message-ID: <ae6d5f5b-bd06-c55b-b970-f1f7e39fd749@linaro.org>
Date:   Fri, 29 Sep 2023 12:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: tsens: Add sa8775p
 compatible
Content-Language: en-US
To:     Priyansh Jain <quic_priyjain@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, kernel@quicinc.com
References: <20230926085948.23046-1-quic_priyjain@quicinc.com>
 <20230926085948.23046-2-quic_priyjain@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230926085948.23046-2-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 10:59, Priyansh Jain wrote:
> Add compatibility string for the thermal sensors on sa8775p platform.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


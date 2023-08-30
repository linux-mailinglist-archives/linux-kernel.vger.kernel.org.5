Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB878DFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbjH3TZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbjH3KHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:07:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20B61B3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:07:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so699788766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693390021; x=1693994821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0QDt8EBpEbkK9eM1eqblOra9xMFCfCG0zgEGNvO4kk=;
        b=iknhdr+RtT51/E9pRpCGXYg8VKSsjn8eD6bbYy5EPLyBxYubJoc/ADhuQVfG8xjwdy
         jBnl2TSrnrGB3ir9o9I5/aJUJRSHYqt2n6cZ2N1pW0/XMHC5usD7CWN27MuJT9ND6tBV
         ob6lZjCu7fOefUDIhPQtU7waXbLAZhCClABdkXQQD5C0XxHwyvHiZF+QKiknZnZ4hHFI
         nozbAycdbnrCu4dh38u3YdPHJKs/pU+DZOfG0zZvMMYbi21TBQsIJGc88TyTULI6mPw0
         HHgAHTtHBevZZRUE6sXO0bzvJu9rcpVoVIuHrPnxEoX46mSYoWLVcqiNq0Eyk/Ys+gM9
         1kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390021; x=1693994821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0QDt8EBpEbkK9eM1eqblOra9xMFCfCG0zgEGNvO4kk=;
        b=lZMlEm6VQnJsEFpMJXHObcbScCv+9R56R7PoQ85HiVgUprxBPssoOftcmOzVXnTAIJ
         go2VTH3UK/iGqS1vt4ydLKqzTll0qHun8Mk9dFSwoDQ5JCU9D9RMEndyZfkVnBmc4vwQ
         EXm9P5dPnq8t6dnga2+mviGmhuzgNU1W38K8IOwmEV2/NpE0mEdQe9Adf5p5czwsS8LA
         mHeT81Y7JwsdQoshjTBP7TmnAtezimE6vB1LinMACsglpaAN882SmN+7QaE6JoQlPva1
         Z4PLbtIUg49Z0BA5rQErbkiBoMLzDiHYyI8RiHDJ99CSF3Rb5q9cfRszvclHGUs9SAsJ
         PYVQ==
X-Gm-Message-State: AOJu0YzzeeQWqYsL0+qEebp9INNfMPkhZlzU7Z7UDsbxAY8hiA3lK7iS
        AnR2r7V3oglme/kSf/Z8J3OHcQ==
X-Google-Smtp-Source: AGHT+IFv/0eMRaF8EMn6yKSAU640SOXFjwBHm7nT9hJcJOrflNyyJnp5etXNA0N+OfyvOIj+/VbXmw==
X-Received: by 2002:a17:907:9719:b0:99d:f5dd:6b3 with SMTP id jg25-20020a170907971900b0099df5dd06b3mr1572959ejc.76.1693390021173;
        Wed, 30 Aug 2023 03:07:01 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id cl7-20020a170906c4c700b009a5f1d15642sm228320ejb.158.2023.08.30.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:07:00 -0700 (PDT)
Message-ID: <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
Date:   Wed, 30 Aug 2023 12:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 11:58, Luca Weiss wrote:
> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> on the SPMI bus. Use similar defines like the PMK8350 to make this
> possible.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> index e8540c36bd99..3514de536baa 100644
> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -7,6 +7,15 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> +/* This PMIC can be configured to be at different SIDs */
> +#ifndef PM7250B_SID
> +	#define PM7250B_SID 2
> +#endif

Why do you send the same patch as v1, without any reference to previous
discussions?

You got here feedback already.

https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/

Best regards,
Krzysztof


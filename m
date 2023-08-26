Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD6178965D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHZLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjHZLxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:53:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC11FD7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:53:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5009969be25so2786215e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693050795; x=1693655595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zlqYvrNT9PUAv5XmqZBjGuR+UnDR90WcQscjzLGLmHg=;
        b=r3TzFirXmwBRpTs9p45zCc6tHqJwP4g0Q8TV95pqYUEKpjpqZ2IHoZ0Twyb7YOpAnu
         aUCE5Zpp2AasnCrB2usKLPt3a27cGyEfaq7OOXAMHwu5aTh2ANv1q2Gyoq3vkMERs1Fg
         pAYCyXeCZCiOxGcBUTicS+XHNlOjRnPc76oCY3p+WWxmUVIABsJgFQOOpjX0Hem8B0zz
         MvAvJIxZ1M9nEuwxhAIHlH2Quum1PA8h+0z4dH3Zhm6MCv/pWMBC9Jr/Zlux/8dr8fh8
         GVVX0Uv3tEeURODb+fpI9zAO92iaZqLTN9cIAzKdYDW/1ynM5ZHrIs478ZocwDvQFDoT
         vufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693050795; x=1693655595;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlqYvrNT9PUAv5XmqZBjGuR+UnDR90WcQscjzLGLmHg=;
        b=AzahvicmdQJZ5hAeWVXPhEjyll+i8esz5inXr4p7ILGp14lcPV5VhlVRQSpnUN4SXx
         v5h+cEJk8qYvTDkxCFkRsgLcxPngF8SpwhRt3D37OWYP1BCE5RxtGBrEhb6TqZpjAvpz
         Mq2PBQQBFvE6QLoTk9EMJ8MCsQCjeB2ijIVK2EnjHa1EyPvOeaTpdvnUob7yTP2xWwYm
         g8F+7JZqjf05T05VuJwOvKvwpkGRDP5Zh0QLYbAh7bHGl86szvv8OAohCtX3eAPEpV6A
         RcN7J4XKrmc6fom4o6W0qxeGXDENv8LpTP/nRBi2jiVKP6s+3+empbMsB6UvluG4AmzL
         oohA==
X-Gm-Message-State: AOJu0YxYlsr89wSNVpenFw5llFtiYlOG0V9tMuJAIzsDVgZ2yWvrPX9r
        ZPIMkdvLZEZrMhp8X4K6qbZYmw==
X-Google-Smtp-Source: AGHT+IG+vab1Uyjae0tlLVaHthI4AF1AhvMp2RwXpOyJsWiIapsGe3TO2kZyCvks4SPsrrOUWzqaSA==
X-Received: by 2002:a05:6512:2524:b0:4fe:676:8c0b with SMTP id be36-20020a056512252400b004fe06768c0bmr16056397lfb.11.1693050794997;
        Sat, 26 Aug 2023 04:53:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2515b000000b005008c11ca6dsm678165lfd.184.2023.08.26.04.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 04:53:14 -0700 (PDT)
Message-ID: <154203eb-dcdb-4152-aec0-cfcc1bf80c13@linaro.org>
Date:   Sat, 26 Aug 2023 13:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: remove refs to nonexistent
 clocks
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719073520.2644966-1-alexeymin@postmarketos.org>
 <9e38d2f5-6da4-089e-1c70-a89069708909@linaro.org>
 <b8cc0229-d663-3527-b320-51a48b4af5b5@postmarketos.org>
 <ZLexD5tdjYGhTCR9@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZLexD5tdjYGhTCR9@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 11:46, Stephan Gerhold wrote:
> On Wed, Jul 19, 2023 at 11:36:46AM +0300, Alexey Minnekhanov wrote:
>> On 19.07.2023 10:39, Krzysztof Kozlowski wrote:
>>> It does not look like you tested the DTS against bindings. Please run
>>> `make dtbs_check`
>>>
>>
>> If DT schema for interconnect requires bus clocks to be specified, I don't
>> even know what to put there now. Can we change schema?
>>
> 
> I think I mentioned the DT schema updates during the review of Konrad's
> interconnect changes and he mentioned he would like to clean those up
> after getting the series in. (Which would be sometime soon now I guess)
> 
> For now, having the &rpmcc "bus"/"bus_a"/"ipa" clocks specified on the
> interconnect@... nodes is still valid. At runtime they will just be
> ignored. Feel free to just keep them there for this initial fix.
> 
> For the other two usages (iommu@, usb@) these votes with minimal
> frequency look a bit related to the "keep_alive" stuff Konrad added. [1]
> Maybe that could be used here instead of bypassing interconnect with the
> clock votes?
or just pass interconnects=

Konrad

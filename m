Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0E3793FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbjIFOyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbjIFOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:54:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0374CE0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:54:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso225239166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694012039; x=1694616839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzvDUKwNNCvvwcRlGd1bjyuF0B3jRIsnTL9TwpYuaKg=;
        b=MvsCHIS3+jX4XYoOrRduuN88M6Q0JXRxU7qWYkjQXw8qrikvqaiIgNiNu8MHryHhin
         s8chAwc0QLCDAixm68sTBOobSw0up1EZ0+4VTHNwGHv9Ac3N7Ba78UdIql+nrFqU2swu
         /asMWLV85JLeesLwRk21ozT1U1Mixe91JhwtJgo77qPAwFknkQJWPo311z3xlRYZBhff
         g6JErTQTTmP0S59PNA67qKQeyJkRdfgPcqbDBkKZt5UVZjJrJv9YSRV4r2p6loOyrU53
         h57iQK7f7kZXfvczLksakdTy59DCjH0uuDlUpfl3HajihfWj6+6HeRux6GhR0kFn1aft
         TP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012039; x=1694616839;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzvDUKwNNCvvwcRlGd1bjyuF0B3jRIsnTL9TwpYuaKg=;
        b=aw7LNKR+LYhPP3nhDJ/eN1VEylddsO6tK+oIcbvI09uuTPTCt9E27xiJMcw8LxG1Os
         rK69L10UsvLU9Moh4lphmcpPdXLdZdALB+1VcVw5BxpuqfUNd6eiun9xniF5NGd1IJiy
         2NprIAIvwO1DiT1KuJjGCV/RnLT2NLoeBYkFQvutwmGtOSWxavKDryag2y2BkA2K1/Xc
         3wDIbEFuM/m9dRwYUygiIqpt1mfDqMH0xqCqUL7FlN/mcMHZ7uciBa23rveS2d1aanxi
         f415vpKSPxVtePXO1KOqj7imlPNaOubyvyEnzEjozhiWDYTAyDq5f+KshNTLdpU2qicq
         BYgA==
X-Gm-Message-State: AOJu0YymiCc1x30qk393FRpcicN1GPTe3xEcytHHrwoFikzbetCll31Q
        HVOUNbjlZccqldkUB7rWIg118A==
X-Google-Smtp-Source: AGHT+IHSDfLiB9bVqAuS30pEWa+sj7tIzlrEBsFWx7jAaDTU7M9QtSLoVRKCUrvoaHHMpu0uGPDojg==
X-Received: by 2002:a17:906:9754:b0:9a5:9b93:d60d with SMTP id o20-20020a170906975400b009a59b93d60dmr3099252ejy.36.1694012039506;
        Wed, 06 Sep 2023 07:53:59 -0700 (PDT)
Received: from [192.168.37.154] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906b21500b0099bc8bd9066sm9134488ejz.150.2023.09.06.07.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 07:53:59 -0700 (PDT)
Message-ID: <458f7f27-958f-47b2-916d-1af1bdf53b7e@linaro.org>
Date:   Wed, 6 Sep 2023 16:53:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc7180: Add ADSP
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230905-sc7180-adsp-rproc-v2-0-8ab7f299600a@trvn.ru>
 <20230905-sc7180-adsp-rproc-v2-4-8ab7f299600a@trvn.ru>
 <4202b582-c0a0-ce13-7561-f5185fe1930a@linaro.org>
 <2caf25a10f8d97dd3694ec57ca0dad36@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <2caf25a10f8d97dd3694ec57ca0dad36@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.09.2023 16:52, Nikita Travkin wrote:
> Krzysztof Kozlowski писал(а) 06.09.2023 18:36:
>> On 05/09/2023 12:41, Nikita Travkin wrote:
>>> sc7180 has an ADSP remoteproc that exclusively controls the audio
>>> hardware on devices that use Qualcomm firmware.
>>
>>
>>> +					q6afe: service@4 {
>>> +						compatible = "qcom,q6afe";
>>> +						reg = <APR_SVC_AFE>;
>>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>>> +
>>> +						q6afedai: dais {
>>> +							compatible = "qcom,q6afe-dais";
>>> +							#address-cells = <1>;
>>> +							#size-cells = <0>;
>>> +							#sound-dai-cells = <1>;
>>> +						};
>>> +
>>> +						q6afecc: cc {
>>
>>
>> No improvements.
>>
>> You need to add ADSP to your board and then test it. Otherwise you won't
>> see errors and we do not want incorrect, even if disabled, nodes in DTSI.
>>
> 
> Ah, didn't think the check would (partially) ignore disabled nodes...
> 
> Is there any simple way to instruct the checker to ignore disabled
> status and test anyway? I'd like to be able to test the "clean"
> series as-to-be-sent to have less places for error (and manual action
> I guess...)
IDK if schema takes any arguments like that, but search-and-replace
status = "disabled" with nothing sounds like it could work

Konrad

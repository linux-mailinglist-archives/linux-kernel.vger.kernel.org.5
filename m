Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E62793651
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjIFHdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjIFHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:33:45 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D095CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:33:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so4436746a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985620; x=1694590420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fpD6AkXtMkCTmpfHMn2qCtUK2W4rA8+BGckdMcP312o=;
        b=wfXAKm2WeJwLJ33bF4T+LqW8OWqbrzya4Tm+SnPLtsH9QZmRgMehUXVZEtLOjl5x3r
         yT3b3EBdzPnFSqNTXsJ8rpTwiM76U+frOxJ2Twzg+yZpwZzSuQhssaT1rNHZh8xKlLBf
         HFb4mrpn0dCQW4IugZeMkGS5BGOK/dyFW7DIkOlhxO1wUksp7LXlWBoTNC1/GNLulIyT
         CeCzyhfN8gJYGUjN7ucIwUwkHSGQsvfeiydHOybe/7p4sdJuZRIkn5qG1B2kx1jO5UK8
         6dmdI3zMtGMyaiIVm4gEfQXp12zuMd5n4P22hKygbwARTOXwvbH8ScC6ZLarIMfRUTsn
         o3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985620; x=1694590420;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpD6AkXtMkCTmpfHMn2qCtUK2W4rA8+BGckdMcP312o=;
        b=JKjqSk1Xn0FEU9e5j+EVRlGefZbJPeaS+0eFHT7kD/vYdMyINnd/48lG0Pme6TOjZ1
         0SmUV4/ITUMLzJClWyws52fZn1tCT8uD7dFP0L6X1SlplmtUSpi1MCsOr0j9jsR8QTKO
         /rVK5JqJ6Svmb2d/6usNmM59iDe4x0pCW8FQwvJhq/1zMwnBz5+N+74oC6hSoQhuzMfP
         KA4dmDVUZX5XDNu2RIFf0YxkPa2lZlt7eaNnj37NHV7QgkY2T8FKkPscZkT5Xx26HTca
         +Wj/Q8ziFBW7Vf/QrMmrNbUlUPaaoLJ6Y6YYi5ynanxGEpvbWP861GIPpjdL4/pn/AXS
         k7cA==
X-Gm-Message-State: AOJu0Yy0PuW5r6YAZX2M0tBqXd4abG2dHh99u/ANnVHQCN7pAXtJdNjk
        S1b9qIkbl16NHAYfzAlETYwuPPwjzqESJ5rIQ7o29w==
X-Google-Smtp-Source: AGHT+IEhKqKFrVoZjkPExKcVXyQIew/nhqO2sPlIMwbwO3xz7DKGU3zysxKFS3T2Yb2MkM8NAYSu5w==
X-Received: by 2002:a17:906:224a:b0:9a1:e758:fc73 with SMTP id 10-20020a170906224a00b009a1e758fc73mr1540363ejr.67.1693985619802;
        Wed, 06 Sep 2023 00:33:39 -0700 (PDT)
Received: from [192.168.37.236] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906824300b009786c8249d6sm8690489ejx.175.2023.09.06.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:33:39 -0700 (PDT)
Message-ID: <f139041f-452a-46d9-b5af-a5ddef29c705@linaro.org>
Date:   Wed, 6 Sep 2023 09:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] clk: qcom: clk-alpha-pll: Use determine_rate instead
 of round_rate
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Cc:     quic_saahtoma@quicinc.com
References: <20230901070041.13463-1-quic_devipriy@quicinc.com>
 <3fe1655e30d62493a24e1f97ab7bf710.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <3fe1655e30d62493a24e1f97ab7bf710.sboyd@kernel.org>
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

On 5.09.2023 22:40, Stephen Boyd wrote:
> Quoting Devi Priya (2023-09-01 00:00:41)
>> The round_rate() API returns a long value as the errors are reported using
>> negative error codes. This leads to long overflow when the clock rate
>> exceeds 2GHz.As the clock controller treats the clock rate above signed
>> long max as an error, use determine_rate in place of round_rate as the
>> determine_rate API does not possess such limitations.
> 
> Does this fix something, or is it preparing for PLLs that run faster
> than 2GHz?
I did some grepping and we already have multiple of these.

E.g. SM8250 CAMCC PLL2 (zonda) goes (or well, should go) up to 3.6 GHz.

Today, only stromer PLL uses determine rate, but perhaps all of them
should.

I would not at all be surprised if many otherwise inexplicable bugs
went away with that change.

Konrad

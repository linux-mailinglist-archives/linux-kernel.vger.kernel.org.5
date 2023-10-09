Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC77BEC2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378193AbjJIVAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:00:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34EDA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:00:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5045cb9c091so6567059e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885212; x=1697490012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFZIXmEw2tc1DnjJYwLf5gJO4LbvSj649aUqBUfNLtE=;
        b=GIpsBT1PNjglUUx1tEs06IKZcM/j20vbudwWVNfVA1hNdA2LTqw/D/QncZ3vtH1IEf
         aBvPIGlHw0QeIdwLarG7HbdEfUfmJRlLH3nym+Qlv+LlbjpLnh8VqUQGqW3rlS2K/ew3
         YBbzZWyYrA+Yv9B7s3xtGNjacBTM+yljyBBCaoZPlfopONGbDbLJvN9FNKEtmGAy6jz7
         vh9NFTgh+cmBJlEoZBpPuFqMJZBTJREhCfWZJEjwg/Xh+Op0MzC98rGSuE7gRf1x6I2T
         rCT5v/bBYuXBIEKs0+n2E6LkS4mhWXsvkKGlaFpjPtR0g43WLdpv4HGt++5MRHACPpqM
         AszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885212; x=1697490012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFZIXmEw2tc1DnjJYwLf5gJO4LbvSj649aUqBUfNLtE=;
        b=T8/8w3N5IkN7yEuaunQHpI11byPLMi1pfsDi9DyyzoqaN69hwgSkWDKXd05DIQw3y2
         ivqPlOpqpuYZXXp00Msr2lFqsfG4/f/H9SatqC8PfQV/FH/ntq96VY6i4hq3fIaaIwyz
         9AUAFo1GyewOEvr4W+Rftf7T37wIYB+sTamdbgvVsgrQsCLOCeFfigfZR68V676+HMtT
         QrkoZ0oIUDvAvoVJOQzCZV6JLD0Ge9l4zScpWxDhF/y1RLkBmvcUOlx0IBVv7ZHUAsDG
         3VYJtC+630fGfuzQ7y/FAxMrbYUqZPO4ad1HhfZwSZMaPKIQ7FZ+hofVRzSMh/cCOj00
         zhEQ==
X-Gm-Message-State: AOJu0YyLGas2p+Us6wEvSP1M/PdOrcqPGykNSFL80kRmfCQ+mOHya/ed
        hzh5TmvC4O3i2hPSBDUeXRofxA==
X-Google-Smtp-Source: AGHT+IFiDYWQz4SXKOH5uGqzuFUrpdOqp33jcUV1BQQub9Nial0VFpPgIQC2f+dCF8FwCKzKQYD9pg==
X-Received: by 2002:a05:6512:200e:b0:503:183c:1223 with SMTP id a14-20020a056512200e00b00503183c1223mr12684061lfb.7.1696885211793;
        Mon, 09 Oct 2023 14:00:11 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d16-20020ac24c90000000b004fe5608e412sm1545004lfl.170.2023.10.09.14.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:00:11 -0700 (PDT)
Message-ID: <52bf96e4-f8eb-4f3b-ae2e-3c33d314b09c@linaro.org>
Date:   Mon, 9 Oct 2023 23:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] regulator: qcom_smd: Disable unused regulators
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-2-5d682493d555@kernkonzept.com>
 <9b7744bf-d42c-4922-85e8-ca4777f313a7@linaro.org>
 <ZSRhTIqYX7hQ0_lc@gerhold.net>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZSRhTIqYX7hQ0_lc@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 22:23, Stephan Gerhold wrote:
> On Fri, Oct 06, 2023 at 11:15:40PM +0200, Konrad Dybcio wrote:
>> On 4.10.2023 16:17, Stephan Gerhold wrote:
>>> The RPM firmware on Qualcomm platforms does not provide a way to check
>>> if a regulator is on during boot using the SMD interface. If the
>>> regulators are already on during boot and Linux does not make use of
>>> them they will currently stay enabled forever. The regulator core does
>>> not know these regulators are on and cannot clean them up together with
>>> the other unused regulators.
>>>
>>> Fix this by setting the initial enable state to -EINVAL similar to
>>> qcom-rpmh-regulator.c. The regulator core will then also explicitly
>>> disable all unused regulators with unknown status.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
>>> ---
>>> NOTE: This has a slight potential of breaking boards that rely on having
>>> unused regulators permanently enabled (without regulator-always-on).
>>> However, this is always a mistake in the device tree so it's probably
>>> better to risk some breakage now, add the missing regulators and avoid
>>> this problem for all future boards.
>>> ---
>>>   drivers/regulator/qcom_smd-regulator.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
>>> index f53ada076252..0bbfba2e17ff 100644
>>> --- a/drivers/regulator/qcom_smd-regulator.c
>>> +++ b/drivers/regulator/qcom_smd-regulator.c
>>> @@ -53,14 +53,14 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
>>>   		reqlen++;
>>>   	}
>>>   
>>> -	if (vreg->uv_updated && vreg->is_enabled) {
>>> +	if (vreg->uv_updated && vreg->is_enabled > 0) {
>> At a quick glance, are there any states for this value, other
>> than 0 and 1? This is not the regulator_ops->is_enabled, but
>> qcom_rpm_reg->is_enabled.
>>
> 
> Yes, I initially assign vreg->is_enabled = -EINVAL (for use with PATCH
> 1/2). It's in the part of the patch that you trimmed in your reply. :D
> 
> Thanks,
> Stephan
Oh, right ^^

Konrad

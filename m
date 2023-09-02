Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA0C7907BD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbjIBL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352094AbjIBL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:59:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E5C10F6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:59:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500c7796d8eso4961777e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693655943; x=1694260743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmGPvjcKg1B9BeWMi9rX6ODuX0AVL+S6ScyjViR6nPY=;
        b=NzNkTotv8Eb7EAVSwOtaSCpK+YaW1BrisrMKbtdA3rxm4VcnKeaTszWbbMzCOaluwH
         5KrbPtTWKvt2SXaqZGSpIHcUEvVAzxzm+xdKJSG+lIEWtBsDWxXvI70ebmuzPZk1culJ
         Evvs0I67Fee+E5r9VZC3JdZ2x7kSViFUflPw0P/u9kaYfPtds1HwKvDsFtEH7mIekv3w
         crGn+VXme+aYG1bA2cPKzeY4m5alONtph51bMM6ZBfbRx1QRQVsu0pKruqMjSL8l9vpU
         evG3oD5OXx6pKLWCO8M6+0XNHmTxfcyod6LVSYWz0ModIbfabU+Bz8/a3BtbXQMy5pfu
         hT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693655943; x=1694260743;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmGPvjcKg1B9BeWMi9rX6ODuX0AVL+S6ScyjViR6nPY=;
        b=MuQq7BiaXfvUMq2YufoV3sN/fqagyoZIWFJ51QfY8ZMB3f/k0nq3FBQIUsogOtrEGr
         Fg99j0MFaDHlvJocg6GaxeR8yYbSnX7+wJreVzRFOKmrByoTmx+pd8ropo4z399gVMGr
         yL/Vzi+ycWUfbraIAVMgEH7W4bsqBNG02Ks1QO5DdnDzaybs46D4RE6+A/CxEYM4nIsB
         zD5AJWGmwWCZtf6Zmx4cJMvEGU/QY2GFY+kw9rRWFlKIDAUAUPBWOUiEiY2UNBFYCvz0
         URcM2Ed6fvpbhQnDQfh/5w0bWIf+haHFI4EJclClY31QrjDcCZ6xbzwcAhyWjBLGmTF4
         Oz9Q==
X-Gm-Message-State: AOJu0YxNMZ2uwn+AsAgKXwRIIX3FOFpZ+fY4ULTaftyfeGIJ7vx32Q8E
        Bix9u55RDKrJjly5P+5CNhM7VQ==
X-Google-Smtp-Source: AGHT+IFF3j27XIHbpiAI7J8N84m5ufbECGCjNzFkvdA/v842JHdu/neiK0+2KJJAF0EjWZA+3ad4nw==
X-Received: by 2002:ac2:58dc:0:b0:500:bb99:69a9 with SMTP id u28-20020ac258dc000000b00500bb9969a9mr2641482lfo.64.1693655943559;
        Sat, 02 Sep 2023 04:59:03 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id l26-20020ac2555a000000b00500998f63cdsm962839lfk.109.2023.09.02.04.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 04:59:03 -0700 (PDT)
Message-ID: <ecafa01d-f942-4418-a01f-885b431c67ee@linaro.org>
Date:   Sat, 2 Sep 2023 13:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
 <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
 <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
 <ZOxNFPRZI/N3a7Kr@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZOxNFPRZI/N3a7Kr@linaro.org>
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

On 28.08.2023 09:30, Abel Vesa wrote:
> On 23-08-28 12:18:30, Jagadeesh Kona wrote:
>>
>>
>> On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
>>> On 23.08.2023 12:41, Abel Vesa wrote:
>>>> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>>>>> On 16.08.2023 16:57, Abel Vesa wrote:
>>>>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>
>>>>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>>>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>>>>> give consumer drivers more control and switch the GDSC mode as and when
>>>>>> required.
>>>>>>
>>>>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>>>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>>>>
>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>> ---
>>>>> Do we have any use for the HW_CTRL flag?
>>>>>
>>>>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>>>>
>>>>> Or even better, *if and only if* that is necessary, add a common
>>>>> property like "always_hw_managed" to the genpd code?
>>>>
>>>> The HW_CTRL flag is still needed for the consumers that expect the GDSC
>>>> to be have the HW control bit set right after it gets enabled.
>>> Guess the correct question here would be.. Are there any?
>>>
>>
>> Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW
>> control mode when it is enabled.
>>
> 
> Actually, since all the GDSCs that support HW control are by default
> switched to HW mode after they are enabled, we can't make any changes
> with respect to that since we risk breaking consumers. Therefore, the
> new flag makes perfect sense since we can switch GDSCs from HW_CTRL to
> HW_CTRL_TRIGGER per platform/consumer.
Ok, I can get behind this reasoning.

The flag name gives me a little 'eeh' feeling, but I can't
think of anything much better either..

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

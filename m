Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598F477E0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbjHPLrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbjHPLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:46:50 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216811FC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:46:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703a0453fso97593861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692186407; x=1692791207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwbPK6uvDQ5KUsB6YxB7kesrVzkL+KaWlF+xSHDLwgg=;
        b=k0sA6JSrN8PsZkopRof7O2RqdeCrs66aZdsF3mhfF9jNZ0C6AXZPNF9W0nfAeJzvaE
         uvYMPgERHzjYlq3bkMLt72rlCOxZMCNH7uMOLDphlG6fGp0PV7gHeWJkb5EEeiRbw4bW
         clJ/oN5jzHajD0xYcvnMr4dgkUu5bsoQSE0/ks/7ax6vPzhv7Vnc1zIUpqL5/zc8CLoQ
         DBGpuNPn4vSeNCKEnvbKrowp2quHJZpz0UQTPjqJfUkEB1crlP2+pge8kQ/pW5moKCvf
         eNgsudml0r/DUAGhdaPT1syiPZ7EQP0LH1lAlStc5tVq8p0nOcHtRgn0hUYB9FNDtvjj
         EwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186407; x=1692791207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwbPK6uvDQ5KUsB6YxB7kesrVzkL+KaWlF+xSHDLwgg=;
        b=h9dQdfVkRxKyrrM0WI6eVA6Ezd9WvZnyEqgfAG+/QhABOEfNd9lmvHkantEg4XCike
         nmW1nUyD73XbxK+z8dy9foYIO9SJrJ41zJyiy0buy2rsRXDg39aSNxONAd2f7JkiQ8fW
         DP7sud1zX1goaNqGlIBbd4j1VrPU4lKGijF6wHC8zUH/dv1mi75Ff1vuNPykucbEw6bB
         Y5a5gszNgS0ymMWJaBinysN+Zgjjd6XNmgu9kNtj+W4BcvOeJVXQRh3eVWalARb3DwE4
         QdcJPlDJt5oOdh3sT2Oe/Nif51dAXTjue6z7AcGR33hr02Xv8xNsrgZNCrCMOKl5Jgpr
         39pA==
X-Gm-Message-State: AOJu0YwLvKrtfslkpysu4rQ9uQNgo3M/g46lKj7RW85kwhWUqoarZu/s
        BfUlQ+RptHEAcczqM1O91Fs+5A==
X-Google-Smtp-Source: AGHT+IH6MxyxiasC64eaoloy2XXiSix/UcoRzoHQK7B4ZRc7UjjFER8ik9vxQVWZxEMrvRQNPr1WpQ==
X-Received: by 2002:a2e:9785:0:b0:2b6:d603:7667 with SMTP id y5-20020a2e9785000000b002b6d6037667mr1321366lji.8.1692186407379;
        Wed, 16 Aug 2023 04:46:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id b13-20020a2e848d000000b002b6ad323248sm3470602ljh.10.2023.08.16.04.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:46:47 -0700 (PDT)
Message-ID: <b1663bc5-5740-4b73-9404-999e868ffecb@linaro.org>
Date:   Wed, 16 Aug 2023 13:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] iris: vidc: add helper functions
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-11-git-send-email-quic_vgarodia@quicinc.com>
 <7a727add-6aa6-fe3d-b2bd-7e0bd2f93579@linaro.org>
 <8d5b117e-4743-c006-7e7b-a15bd3866e6d@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <8d5b117e-4743-c006-7e7b-a15bd3866e6d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.2023 21:15, Dikshita Agarwal wrote:
> 
> 
> On 7/28/2023 11:11 PM, Konrad Dybcio wrote:
>> On 28.07.2023 15:23, Vikash Garodia wrote:
>>> This implements common helper functions for v4l2 to vidc and
>>> vice versa conversion for different enums.
>>> Add helpers for state checks, buffer management, locks etc.
>>>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> ---
>> [...]
>>
>>> +
>>> +#define is_odd(val) ((val) % 2 == 1)
>>> +#define in_range(val, min, max) (((min) <= (val)) && ((val) <= (max)))
>>> +#define COUNT_BITS(a, out) {       \
>> hweight.* functions?
>>
>> [...]
>>
> sure, will replace with hweight.
>>> +
>>> +const char *cap_name(enum msm_vidc_inst_capability_type cap_id)
>>> +{
>>> +	const char *name = "UNKNOWN CAP";
>> Perhaps it'd be worth to include the unknown cap id here
>>
> could you please elaborate more on this.
>>> +
>>> +	if (cap_id >= ARRAY_SIZE(cap_name_arr))
>>> +		goto exit;
>>> +
>>> +	name = cap_name_arr[cap_id];
>>> +
>>> +exit:
>>> +	return name;
>>> +}
>> [...]
>>
>>> +
>>> +const char *buf_name(enum msm_vidc_buffer_type type)
>>> +{
>>> +	const char *name = "UNKNOWN BUF";
>> Similarly here
>>
> could you please elaborate more on this.
Something like "UNKNOWN BUF (0x15)" instead of just "UNKNOWN BUF"
would help us better understand whether the driver or the hardware
is missing something.


Konrad

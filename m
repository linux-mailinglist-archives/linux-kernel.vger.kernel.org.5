Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7026E7D2A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjJWGcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJWGcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:32:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEBD6B
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:32:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso4460476a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698042735; x=1698647535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fmtVbt5nFW5Eb2dXOQDhCfs+v2LzrHd1TY7XR+eBVc=;
        b=hSfcKguc3EvxoYhB6l+WYtHTlvYpgXsl4Y9Jc6JP+TmgLpbOO3d6/uzsbhv8g0TTlw
         DvAv7VUdhpslYWPuWw/0PJKfopcsk3fIsYPwbhZl9J1Ywk8zrBsVEnFHpZUgiJ1fgzyI
         GSJ6hvXE2OAE8Na7CbqLhRI+GQFiS5olb/M8AuIcAvhQ+dIlhRAdKSeT0RVgrkFFoP3e
         FOfxIwUqEsHrLMLpfPL7YxriWjcSkr5BeJggORDgzVk+bW63C4ILjrxtMwERv5tO+6+J
         gwXgUEaM11o/iLttY6sHawzmemLjbjfQZcMApsPcYuf2B9RImn0roqRP+3mNHodaDDOw
         DZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698042735; x=1698647535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fmtVbt5nFW5Eb2dXOQDhCfs+v2LzrHd1TY7XR+eBVc=;
        b=k44H8Lap7J95eatt1Hsnbj2BrNKkcVPKIp/UrNxrkCUMOhWyqV+dZACcQDnFEh4yut
         wHq6PFm1YILufAGzzTuD9CUFkXdP6AotYL2+CutXsZvZ9evoCseKa/CVcuFE2Vk4CGcM
         aymzzivfBwe1A9yEfyDtid8gV8DYbDem8fy8GpT4rBrLozY0lnB0t4KDDam27MJDhf/5
         LnYxi1N8WUAtv19oi0nU1bPbZTFMI1Ys6rqlGGyt6DTgbO3mKqPFe39EBUTHlz0/U2yb
         ZJzaBxLvXVMdvVW3FsNsbiJE2U66Ptj9cyvnNwyCkHbgEHQj24bKVORCMPPjUpZTsrUY
         oIHg==
X-Gm-Message-State: AOJu0Yz5s4/MPwE4SP5eP64hZOwG9R8aBAmCsi1x5K5Dc9KhPo9d5kod
        lt0fUEC1m6voj/2IbOMzSzwijQ==
X-Google-Smtp-Source: AGHT+IGzM+9O12/OCrP9uIqfj4L7fDrO4fHM6BwltP7gRv2HSMBUHNwYE1ycAcpcieFz83V4FZcytQ==
X-Received: by 2002:a17:906:794c:b0:9a2:1e03:1572 with SMTP id l12-20020a170906794c00b009a21e031572mr7399114ejo.19.1698042734714;
        Sun, 22 Oct 2023 23:32:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709064b0f00b009b2b9af0784sm6039976eju.110.2023.10.22.23.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 23:32:14 -0700 (PDT)
Message-ID: <7af782f3-fe6c-415b-a993-55962845a102@linaro.org>
Date:   Mon, 23 Oct 2023 08:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, marijn.suijten@somainline.org,
        andriy.shevchenko@linux.intel.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
 <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
 <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
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

On 23/10/2023 08:09, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 7/9/2023 10:48 PM, Krzysztof Kozlowski wrote:
>> On 08/07/2023 09:28, Jishnu Prakash wrote:
>>> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
>>> everywhere to match the convention used for these ADC peripherals
>>> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for
>> We do not rename compatibles to match convention. Please provide proper
>> rationale.
> 
> I'll avoid renaming the compatible directly, will just mark it 
> deprecated - but is it fine to do the other changes, for updating the 
> macro names used in devicetree (replacing the ADC7 macros with the ADC5 
> Gen2 macros)?

Please provide proper rationale why "ADC7 needs to be replaced". Your
marketing is not a proper rationale.

> 
> I do see an example of a macro change in devicetree done in this patch: 
> https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/.
> 
> Patch 2 here replaced some macro definitions: 
> https://lore.kernel.org/all/f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com/.
> 
> Patch 3 made the corresponding update in devicetree files: 
> https://lore.kernel.org/all/db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com/. 

And what is rationale in that patchset?

> 
> 
>  From this mail, it looks like the maintainer was willing to pick them 
> at that time: 
> https://lore.kernel.org/all/20220315225652.CDAD1C340E8@smtp.kernel.org/, 
> would something similar be possible here?

For stated before marketing reasons - no, would not be possible.

Best regards,
Krzysztof


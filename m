Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737578C40A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjH2MQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjH2MPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:15:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A9CD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:15:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so5652591a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693311300; x=1693916100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuSqHXD31D4rgwV6avUd8bNaF7QG/6g57P8yYOHyObM=;
        b=yzCG2sGObYfnmIReGnbAydo4kKKSBPJb3gGuQ7DgchEAHmfvZ1UCs5Ip/8wJiAcwkv
         J7SZQWUjWzs09d8LsiGSeIhfiSGulbXF2+AsyR4LjGRwhZ0SlROX2UEzatjvxAR0gwcq
         gyTtvJEURpPTIcBC8cx4YejzqqbAaHmun54IFNwVoKQV3lULtlPl0NyUId4rzHYWYros
         5IFfjbgk5keSooHi6zhemQ+A0atZnBE7ZB4SD45wGSVxproEX68+HWEP734eUFFzweie
         JGyaEpEZwAlDBBuKv1tldgh9dpBy4FiywuxeGHmfo/3SCy+QnoOmwyviezIX1lCocuTd
         cDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311300; x=1693916100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuSqHXD31D4rgwV6avUd8bNaF7QG/6g57P8yYOHyObM=;
        b=JTgLbxG7Sm+EzWbc+ZTxr1+5EmSInFpoVnkLhMkZ5vqGIcFH0o+X5TIrMT+oFVyIQe
         Rzzs1s9ABe1+VL7FxHZJqTTWFaj7oos/zccmBkRyA+twf8JB18q3L87N+OW9S9o5m3V+
         EFc7F4N+nIcsAM8VrgMoJzU4tyZ2ubgRtTxMVVSAxX4EbBwzR1kp5P5tMipWMKyNffvz
         3PyBATg+x0Vpb0b+AwI2yv09XFPjmzKSgkwB9H+Pwr65xHYrC6jFlErUPArbxR5DwPX7
         +wCCe8tCKdMOY07QHIJIfrovWIrbjd7rsIoI30pXxyIrg3d1h57oveMNixcn8tyxLBuc
         PLrQ==
X-Gm-Message-State: AOJu0YyOpHfEeIZ2NteoTbjmUknnOwt7E6EG208DiXMQBgQa9P+HMkgG
        z0C+IQZo+vZOh5NwbjVrf4434w==
X-Google-Smtp-Source: AGHT+IFHGUVchPQl+mF3sfUS3twhA0v9fn2dsAElqV/Z6NlDSTjZS3t04ZJcxcPizZMoJHsXHGLXzg==
X-Received: by 2002:a17:906:224c:b0:9a1:bd33:4389 with SMTP id 12-20020a170906224c00b009a1bd334389mr13676379ejr.74.1693311299737;
        Tue, 29 Aug 2023 05:14:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b009a1fd22257fsm5891367ejc.207.2023.08.29.05.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 05:14:59 -0700 (PDT)
Message-ID: <ecc6076b-2278-70e6-3863-3dcf89adfd0f@linaro.org>
Date:   Tue, 29 Aug 2023 14:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
 <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
 <73700e92-2308-3fe0-51b1-c2373be2893e@linaro.org>
 <bed64143-8803-5027-d9ec-eafaaeb64e35@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bed64143-8803-5027-d9ec-eafaaeb64e35@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 14:13, Krishna Chaitanya Chundru wrote:
> 
> On 8/29/2023 5:26 PM, Krzysztof Kozlowski wrote:
>> On 29/08/2023 13:41, Krishna Chaitanya Chundru wrote:
>>> On 7/28/2023 8:26 AM, Manivannan Sadhasivam wrote:
>>>> On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
>>>>> Add basic support for managing "pcie-mem" interconnect path by setting
>>>>> a low constraint before enabling clocks and updating it after the link
>>>>> is up based on link speed and width the device got enumerated.
>>>>>
>>>> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
>>>>
>>>> - Mani
>>> A Gentle ping
>>>
>> Whom do you ping and why me? If you choose not to use
>> scripts/get_maintainers.pl, it's your right, but then you might get
>> maintainers wrong and no surprise patches got not accepted...
>>
>> Plus, it's merge window, so why pinging now?
>>
>> Best regards,
>> Krzysztof
> 
> Krzyszto,
> 
> The series is already reviewed and there are some patches which is 
> reviewed by you also.
> 
> I am using the same command to send patches it looks like this script is 
> fetching based upon the source file where there was change due to that 
> only I was seeing the problem of all patches are not going to all the 
> maintainers.
> 
> I was trying to install b4 and make sure to send all patches to all the 
> maintainers next time on wards.
> 
> we pinged it now so that as this is already reviewed and no comments on 
> this series so that this can picked up.

It is the fifth same email from you. With just few differences. Please
stop. Please fix your email client.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991B757A21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGRLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGRLKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:10:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC881BCA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:10:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991f956fb5aso690391666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689678617; x=1692270617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aajYIP5snbVq3l5m7wqui3wz8vLZfCkS107XHrf17Nk=;
        b=FrBsmurDeFoxnrfcaRJj3S4siJ250IDShr9ktrso9kakqk/dqYGg/nGyrvPyLMTo7n
         Mzx80YMQeH/qKpx+G0hJY23/JB7zWvRcpGRd39AOeqU3AO0RBSqrc5qXUgkIiZkjZm0D
         49nguYZk9ZAhqavC0XEty0I0fSupPpCXydPmguajvH4FArOWHCed3mMdOnMtG4e0Rlmq
         6culvTmxnFlx6ofKV+VCvC7XyxhOfs0N0q46uehskc7JVyPmZ0EzFfAEAAOFmvJ8spto
         9N0OuAfhQa1/vfgKDoNivuxekRX23wNBwxHrNbo6+OjInvfvDguHZIlF7MdFXq5AmnxJ
         OclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689678617; x=1692270617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aajYIP5snbVq3l5m7wqui3wz8vLZfCkS107XHrf17Nk=;
        b=WTiRE9N5v9VtKO51G9Knoqa3LqqQS8kXTMdAslLfoJmmIPQqeHxSGdlAwpAdeCkL8C
         tVPdhfkzw3WE4mRJS+bZ+aUKd16yo+c633djC3xc0bEuzhLZEP29zoUo1MUr3bLGGchJ
         FqvXzbaAXT8P/fAlOtY3t/BcpJX61soz36CVMAg0rQ+z5IX+chC3cQcqXqouRKRf9E8s
         mksqpNc7XAimpLP+fJq9vI2bnJORYvgWEsQm8YqFsUxOIjL6OfVxr7hxwkt/he4N+w17
         XOKIAHKASIauVUM84/TPERJsNEciXKs2VwqUljRq8kzIbSsxjjK8NFvwIJ39XrGsD+ax
         Jdfw==
X-Gm-Message-State: ABy/qLaMHclt1ATeQkeHC+6hvB5KZDn6cP4TTcCkUdFCssP4ajY9eEbr
        HflaFmJn3PHF4xgVXqJ5qoNlsA==
X-Google-Smtp-Source: APBJJlGWV/QSUi6HFAgilRdsMb0RiR24L2HSwKqQilgOC33dQBeMvzgNtwKldyAC2HnEcBh8bsHMqw==
X-Received: by 2002:a17:906:10d2:b0:991:37d2:c9ea with SMTP id v18-20020a17090610d200b0099137d2c9eamr12802294ejv.6.1689678617448;
        Tue, 18 Jul 2023 04:10:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709063b8900b00992e51fecfbsm900717ejf.64.2023.07.18.04.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 04:10:16 -0700 (PDT)
Message-ID: <4131759e-9474-48f6-cc05-67b6d4b6559b@linaro.org>
Date:   Tue, 18 Jul 2023 13:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Content-Language: en-US
To:     Frank Binns <Frank.Binns@imgtec.com>,
        "conor@kernel.org" <conor@kernel.org>,
        Sarah Walker <Sarah.Walker@imgtec.com>
Cc:     "luben.tuikov@amd.com" <luben.tuikov@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "hns@goldelico.com" <hns@goldelico.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "afd@ti.com" <afd@ti.com>, "dakr@redhat.com" <dakr@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Donald Robson <Donald.Robson@imgtec.com>,
        "faith.ekstrand@collabora.com" <faith.ekstrand@collabora.com>
References: <20230714142526.111569-1-sarah.walker@imgtec.com>
 <20230715-paramount-straining-6a486f8af20d@spud>
 <a86f6359706485cf595889a07e513e2b9fd6d71b.camel@imgtec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a86f6359706485cf595889a07e513e2b9fd6d71b.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 13:08, Frank Binns wrote:
>> And this
>> items:
>>   - const: gpu
>> can just be
>> const: gpu
>>
>> Although, if there is only one interrupt this is probably not
>> particularly helpful. Are there other implementations of this IP that
>> have more interrupts?
> 
> No, all our current GPUs just have a single interrupt. I assume it's more future
> proof to keep the name in case that ever changes? 

Why do you need name in the first place? If there is single entry, the
name is pointless, especially if it repeats the name of the IP block.

> As in, by having the name now
> we can make it a required property, which I guess we won't be able to do at some
> later point.

Why even making it required?

Best regards,
Krzysztof


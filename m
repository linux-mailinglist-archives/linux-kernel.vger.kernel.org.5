Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618CB80ACFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574680AbjLHT2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHT2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:28:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B41732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:28:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3b3caa55so26495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702063695; x=1702668495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rv9sF+QHA+qRGJbR2BSZjDLq0CS33kbmgrIFh2tWFrU=;
        b=POFHJa6B5DhpBnJSAc5MgvHt6ac3HnkTsnR8hBI+nFOqLvSSxPosHuMGw0l4P7Sqph
         1zJPyIDepXhJauNiVWVp8LyM0sTxlDCQrYLqwmgAQrijv+G3Ii1SwZX9MVgFJcQBt2oq
         NZxit8llPlhsBepSW7AS5vanbOdkKrSwXyRHMlG1UQhw17h19nUEAamYQNMLrDmun2Ln
         9R+AvBf6jcnte4/kY9Y5N2JEcFIpbrd2PMNnbAevjVT4v/ztVv2bfsPEClfYrUdQ99tY
         W38wvXmtkaAk9mw1vP4L1H1SiD9XD1xAW5nHE4qd/J0f3fYPkEYRpOimDTvkxGm/fQKe
         Px3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063695; x=1702668495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv9sF+QHA+qRGJbR2BSZjDLq0CS33kbmgrIFh2tWFrU=;
        b=RAJs7ZGToBfwzp3ssUK0oCU/R4c93vEE4G3hzNVYXq4+Zeq2A+MDCr+o1CWXOuk6GG
         l/LUqCYuJUu8Qnbne12q2r4uHfOKN5LzrqfsngggNjkNRif2mz+3ZiFCj/3PH3fa+7yc
         r1ezaRVJbUXW+jfiK6fy/nv0MFzUlFXAcy79LzooKPXpNckcAnkJJmA9HzP/PgXc53hI
         WEBwgKBqHH4XdoCLgiPDoVmxjWDSDcPKg5tYv9fRTgn+3M/G+XaSGIrKFi4XwqYEYAil
         1tDO3pog4AnwEGE6nww5lq7WszY7KZBqOg8ftzZoPLOXYT4sDh41l84wFn7iVAuwOc1G
         SSlA==
X-Gm-Message-State: AOJu0YwOHffnmmXmnnPsNhCVZAIQaHteirV5EaPdns7tUOStEHRCdtET
        d6+1Dce79qtgTtYm2fX2cqBVXzq7XKMPMDEcZp+geg==
X-Google-Smtp-Source: AGHT+IFFFQbBGAOPWpM2U9jSGJT4S2n2V4kWHb50h8/FUw+8k2Lud611bt2P2PtOY0WsSueKTkMQdw==
X-Received: by 2002:a05:600c:3795:b0:40b:578d:2496 with SMTP id o21-20020a05600c379500b0040b578d2496mr220027wmr.27.1702063695109;
        Fri, 08 Dec 2023 11:28:15 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:731f:e6b0:e567:aab6:1db2? ([2a10:bac0:b000:731f:e6b0:e567:aab6:1db2])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b00405959469afsm3784245wmq.3.2023.12.08.11.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 11:28:14 -0800 (PST)
Message-ID: <8af70f29-0853-42bc-aabd-338eda6ed154@suse.com>
Date:   Fri, 8 Dec 2023 21:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/ia32: State that IA32 emulation is disabled
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231130155213.1407-1-bp@alien8.de>
 <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
 <20231206172022.GCZXCtVoZtt4t2TLpe@fat_crate.local>
 <4f232dfb-a112-4271-8f43-f85a02c4abeb@suse.com>
 <20231208192254.GCZXNtDjT73Z4L06h/@fat_crate.local>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231208192254.GCZXNtDjT73Z4L06h/@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.12.23 г. 21:22 ч., Borislav Petkov wrote:
> On Fri, Dec 08, 2023 at 08:42:29PM +0200, Nikolay Borisov wrote:
>>> +static inline bool ia32_enabled_verbose(void)
>>> +{
>>> +	bool enabled = ia32_enabled();
>>> +
>>> +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && !enabled)
>>
>> nit: But why check config_ia32_emulation explicitly, its state should
>> already be accounted for in ia32_enabled's value? So this check can simply
>> be 'if (!enabled)'
>>
>>> +		pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
> 				^^^^^^^^^^
> 
> If CONFIG_IA32_EMULATION is disabled, is there any 32-bit emulation to
> be enabled, at all?
> 

Ah, the !enabled condition will then trigger so it will result in a 
false print. Fair enough...

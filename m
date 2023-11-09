Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44397E686C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjKIKjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjKIKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:39:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB10210E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:39:06 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40a279663a2so1499035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699526345; x=1700131145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmGbwmaXtBtukBQbSz5/AjnhxMx8QNKzqe9+KNioNp0=;
        b=dpufDYmyevNF6IVh+HAMmA+4yya5tgBTewSwwUyBn5wa3+qOROWDB9OVo/cyFtRViS
         kwr5rFV2cDJ7tvmbGW5Rbf1NgFE6pxZTd9TwEFpLwq1TohczHNnzCnTqAwzYzomxAu6v
         247To/UFiA5Mf05KYfpWKfXJM+n0P5XUFzWtMbvO3OWEHuvbmyCmo1sS6/rT0WZXN+hJ
         JdQJYfvNI+7UHrUcj8/rrEHSNe2S2EO7TA9qoFd62qQkTivnk7cEtFi3awafAXSNi9x2
         Wjd6co14z4Y7xZ6Pn6+RBE8gJjinzT9LHFJfeXRwuKOHymI4vDxPGDhc2IvznoVx7MyB
         KZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699526345; x=1700131145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmGbwmaXtBtukBQbSz5/AjnhxMx8QNKzqe9+KNioNp0=;
        b=Csr+hIPb39Zpfz+sGB1WE5+SOs/+DUfA0tiFKd9vnP/t4Q4vjAFDvjVtZ6pCKVeB/H
         ExZhbvpQrzISn6gW9n0d8B0I9DqC9NN8/8+36A9RJJXAnUP5ahWCVLHuWnGdnjA7TeAo
         Pmcu6HfZT2YSNxpW8JXLT1yqcYgn7P6ESsiS+F/fyi0mfyJofyh/6OZmR5YLkdJ1Sd2t
         4pNnvjClGTLE8qaQDywx0AoWj+GukZj+mKJyCCQZE5y63IZZmAZ8/b9IMBfOGtw91kpS
         obT5ze95ipiQitpWpB4Dn8P/xd8HMMZzcFCoy0ZLBgA6/L8n3hMvUiwHqWAZE7XOTysg
         QB2Q==
X-Gm-Message-State: AOJu0Yz+xFgwhY2/5Pjt4yr/gI9QWLgyeTLw4eaFO4c8jkgzRwHoZTYk
        7mwZRKZqH25+eYh5SijiuAgipA==
X-Google-Smtp-Source: AGHT+IGJDtJU0vy2RLytoP9NwcqdfAiEsZKNe2CEhkkrVnWPGJ8hlOjTlrHY/RwmZQGojP3I0Fa1xA==
X-Received: by 2002:a7b:c4d7:0:b0:408:3836:525f with SMTP id g23-20020a7bc4d7000000b004083836525fmr4014084wmk.1.1699526344873;
        Thu, 09 Nov 2023 02:39:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:87b4:87b9:6476:5df7? ([2a01:e0a:999:a3a0:87b4:87b9:6476:5df7])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b004080f0376a0sm1662458wmq.42.2023.11.09.02.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:39:04 -0800 (PST)
Message-ID: <fd022864-f276-4c4c-84ea-0752b915a9b3@rivosinc.com>
Date:   Thu, 9 Nov 2023 11:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] riscv: add ISA extension parsing for vector
 crypto
Content-Language: en-US
To:     Jerry Shih <jerry.shih@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
 <20231107105556.517187-7-cleger@rivosinc.com>
 <5EF129A2-195B-4207-A2F6-DBA1FBB9F65D@sifive.com>
 <20231109-revolver-heat-9f4788c51bbf@wendy>
 <20231109-prevalent-serrated-d40eb5f71236@wendy>
 <F2C4CCA2-0513-4988-94C4-1ECEB9F1D578@sifive.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <F2C4CCA2-0513-4988-94C4-1ECEB9F1D578@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2023 10:45, Jerry Shih wrote:
> On Nov 9, 2023, at 15:54, Conor Dooley <conor.dooley@microchip.com> wrote:
>> On Thu, Nov 09, 2023 at 07:44:46AM +0000, Conor Dooley wrote:
>>> On Thu, Nov 09, 2023 at 10:58:41AM +0800, Jerry Shih wrote:
>>>> On Nov 7, 2023, at 18:55, Clément Léger <cleger@rivosinc.com> wrote:
>>>> The Zvknha and Zvknhb are exclusive. It's not the superset relationship.
>>>>
>>>> Please check:
>>>> https://github.com/riscv/riscv-crypto/issues/364#issuecomment-1726782096
>>>
>>> You got a response to this on the previous version, but didn't engage
>>> with it:
>>> https://lore.kernel.org/all/c64d9ddb-edbd-4c8f-b56f-1b90d82100b7@rivosinc.com/#t
> 
> Reply for the thread:
> https://lore.kernel.org/all/c64d9ddb-edbd-4c8f-b56f-1b90d82100b7@rivosinc.com/#t

Hi Jerry,

Sorry for that, I actually thought my mailer was broken and fixed the
mail the first time I answered but not the second time...

> 
>> Yes, but for instance, what happens if the user query the zvknha (if it
>> only needs SHA256) but zvknhb is present. If we don't declare zvknha,
>> then it will fail but the support would actually be present due to
>> zvknhb being there.
> 
> If we needs SHA256 only, then we should check whether we have zvknha `or` zvknhb.
> https://github.com/openssl/openssl/blob/4d4657cb6ba364dfa60681948b0a30c40bee31ca/crypto/sha/sha_riscv.c#L24

Ok, and if there is already some userspace code that behaves like that,
let's go this way and do not treat that as a superset.

Thanks,

Clément

> 
>> Ahh, I now see what that happened. Your mailer is broken and puts the
>> message-id of what you are replying to in the In-Reply-To and Reply-To
>> headers. The former is correct, the latter is bogus & means you don't even
>> get delivered the response.
> 
> I use mac builtin `mail` client. And I think I put the `in-reply-to` address to
> the `reply to` field. Hope this one works well. Thank you for the thread forwarding.
> 
> -Jerry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6B7D2AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjJWHOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:14:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5110EA4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:14:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32de9764793so445067f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698045288; x=1698650088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26tPvjduKfKMC5Y+TnU+2kouKBcEVMva4kAveFGyFik=;
        b=F1G3kJxLX7MHUk0i87R8TZJzTWP4Yp8XZmYqCgGxwkp8HrQMyaCX6Dt1j1gxBvkXXB
         kG4znk0BfygEQPhEOzlqU2kFaBkSxvUGrO1b8PAV8Pv3VWDpqsrSACjC+lAgwFuqeYi3
         bMjrnXrTLNwUwFLZNXccASFeh6FiZH+Kw4fM3BrlRjDqIP2iJMIbPMxee17m5FpzTOwq
         qZh8in5bhZhHmZzu6XsG5ux1xj8v7+SkQoWSH0p798POrU0wFfgmVX7Augx1MP0rFlIu
         hy8D4GqpSf2AWZjVZ7Uke7w/a26iww4Xqm2FtpYDPeV0ALnGyBEZnoPPl7ESXyspz/u3
         FJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045288; x=1698650088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26tPvjduKfKMC5Y+TnU+2kouKBcEVMva4kAveFGyFik=;
        b=Cwv7KzJ+zG5x55TIiECXaYARr8WP1repTf7Rs8ihwhYooJfJxeSv3ECBpbYPREfb0H
         JSgVE4MWLdfKTXGs0shoKdst6cQmgEU7SgQjOx9Gq43BDsbHILpP4CPxmBtnxVMx0dyk
         aVzRI22qAIRdDtXaLKgK1Q2waAaWdVtlWEr2jT6vqVVeB+SOAKjE//D0Iu3FqDWDUGOi
         PZZgow9YULdfaXt8BwTzYc39BRkNUusLbZpdR/p2Y7p/BCaM+1whxrsp+7+MstKi6coj
         69quGm7bRUgzNBp+zFkHbyXr+ynXuzn+lYbfESkl6pfTBW2sbDfMPlyHOSN5tKWNY9lK
         fVuQ==
X-Gm-Message-State: AOJu0Yy9WsJe3yInxQ7thZzKZcnInIqWEgMo/tm7POXAT+MSNwe+953W
        wzUMM+1dnxG/gNGyQV8QEHaZ3w==
X-Google-Smtp-Source: AGHT+IH6cqD8gxFinz+iQF08GyX6MMtj6EnWvLXSKTAQz1NuASZ3GUeBRA+mRrbDkbRJAMkzxsQenQ==
X-Received: by 2002:adf:a356:0:b0:32d:c293:1ab4 with SMTP id d22-20020adfa356000000b0032dc2931ab4mr5018430wrb.6.1698045287746;
        Mon, 23 Oct 2023 00:14:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:17bb:4fd9:531:a7cc? ([2a01:e0a:999:a3a0:17bb:4fd9:531:a7cc])
        by smtp.gmail.com with ESMTPSA id r8-20020adff108000000b0032db1d741a6sm7144610wro.99.2023.10.23.00.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:14:47 -0700 (PDT)
Message-ID: <c64d9ddb-edbd-4c8f-b56f-1b90d82100b7@rivosinc.com>
Date:   Mon, 23 Oct 2023 09:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
To:     7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com
Cc:     Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com>
 <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
 <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
 <7626f978-e9ea-4f8f-b814-aeac02bd3712@rivosinc.com>
 <E30E7352-1FB0-4DB5-94C3-2C6FC2A6F484@sifive.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <E30E7352-1FB0-4DB5-94C3-2C6FC2A6F484@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/10/2023 04:43, Jerry Shih wrote:
> On Oct 19, 2023, at 17:35, Clément Léger <cleger@rivosinc.com> wrote:
>> On 18/10/2023 19:26, Evan Green wrote:
>>> On Wed, Oct 18, 2023 at 5:53 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>>
>>>> On 18/10/2023 03:45, Jerry Shih wrote:
>>>>>
>>>>> The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bundled with `Zvbb`.
>>>>
>>>> Hi Jerry,
>>>>
>>>> Thanks for catching this, I think some other extensions will fall in
>>>> this category as well then (Zvknha/Zvknhb). I will verify that.
>>>
>>> The bundling mechanism works well when an extension is a pure lasso
>>> around other extensions. We'd have to tweak that code if we wanted to
>>> support cases like this, where the extension is a superset of others,
>>> but also contains loose change not present anywhere else (and
>>> therefore also needs to stand as a separate bit).
>>
>> For Zvbb and Zvknhb, I used the following code:
>>
>> static const unsigned int riscv_zvbb_bundled_exts[] = {
>> 	RISCV_ISA_EXT_ZVKB,
>> 	RISCV_ISA_EXT_ZVBB
>> };
>>
>> static const unsigned int riscv_zvknhb_bundled_exts[] = {
>> 	RISCV_ISA_EXT_ZVKNHA,
>> 	RISCV_ISA_EXT_ZVKNHB
>> };
>>
>> Which correctly results in both extension (superset + base set) being
>> enabled when only one is set. Is there something that I'm missing ?
> 
> We should not bundle zvknha and zvknhb together. They are exclusive.

Yes, but for instance, what happens if the user query the zvknha (if it
only needs SHA256) but zvknhb is present. If we don't declare zvknha,
then it will fail but the support would actually be present due to
zvknhb being there.

Clément


> Please check:
> https://github.com/riscv/riscv-crypto/issues/364#issuecomment-1726782096
> 
> -Jerry
> 

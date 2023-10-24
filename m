Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455457D4847
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJXHSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJXHSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:18:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C31A83
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:18:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c508e76eb4so8934471fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698131912; x=1698736712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRIlhtIeb1YFd4JwPYh+w2xPq7Nr26Cx3E5/ZUd7zEA=;
        b=jqHhOdEIuadN41MJVGii+Nssy5T7Ll9nxoxV4NeMj2wgKlOJfZt9W8zMxeaAoI8Ffa
         yknFvVzEuabK5oJQd75u1YXB6jfwM5Sy80LWLI6AlXRlj/sJ1N8weQIcQ/UhmPdploeQ
         GfItyqDuLDQnZEoR2CIB8hZpEVUtix/76FqlUrbasg0t9MzHSbdGqYADDWZRwn/tRai6
         xEoGZt6wNQiqCXn6+p3GQ3fC9gwaEwrQTGV3yZAfayXbkmU5N/UUGpENLThP78vzyBKc
         qipUBCoanXnNmAQwBFJDlZLJDDvNvbZnau/XixIZj78iJPfaSawEkc/DmtML7Zs9UvSA
         +JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131912; x=1698736712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRIlhtIeb1YFd4JwPYh+w2xPq7Nr26Cx3E5/ZUd7zEA=;
        b=phWbhjOi4P99lI4YBl6KYYDIxj6kCGtV3ZCMNpeDfwZsrUAOzrQZe2ZyKjBV3XtB3V
         nM0yz/xPJ3pe1YE3moC8HF63GPuEp49i8BO9CNEbCyV2BrMzntmrPOAUK6rOqu6wgmrK
         wssq1u/hisivzyQl053EYIqnhC3fQV9xMtQrSgg+z6bj4TuKEnxfEb67rOaTJAlXG0w/
         BZnX+0Gf959J218pbL9jjqGZhfxaSuWIKjyxBe9uem8nUupbh9rKh11dEjx4OpjeuZwu
         Pndewj6NRYdddgM5bCVqfTHdnaECqi6VZbZ5NucNhMxxq9s4jKTviihlOYYzIB2/vArd
         VzoQ==
X-Gm-Message-State: AOJu0YznBeXU+OEF1XNYBpu7PKfGONKu68mjLonS1JNnG07TU1hzBidY
        /AgEBGj2zMtm9yoKJW2x4P4Gyg==
X-Google-Smtp-Source: AGHT+IFC45ilAg3tRrLMb0mEc7pz2FsUd3r5wo9psNP7TVo1+HLGBSK/Yy4GORF6XAP+cC+mEVQGng==
X-Received: by 2002:a2e:91c1:0:b0:2c5:18a0:6c2e with SMTP id u1-20020a2e91c1000000b002c518a06c2emr8406164ljg.0.1698131912513;
        Tue, 24 Oct 2023 00:18:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9f43:3ca4:162c:d540? ([2a01:e0a:999:a3a0:9f43:3ca4:162c:d540])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4587000000b0032db430fb9bsm9278279wrq.68.2023.10.24.00.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:18:32 -0700 (PDT)
Message-ID: <d0ea4996-5c48-47b4-99b0-f4211276e0b2@rivosinc.com>
Date:   Tue, 24 Oct 2023 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] riscv: add ISA extension parsing for scalar
 crypto
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
 <20231017131456.2053396-3-cleger@rivosinc.com>
 <CALs-HssmufWCKzaGy7BwWz4n4hfwV9NjjRD-O_JeupM-p=Ov+w@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HssmufWCKzaGy7BwWz4n4hfwV9NjjRD-O_JeupM-p=Ov+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/10/2023 18:21, Evan Green wrote:
> On Tue, Oct 17, 2023 at 6:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> From: Evan Green <evan@rivosinc.com>
>>
>> The Scalar Crypto specification defines Zk as a shorthand for the
>> Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
>> which are all shorthands for various other extensions. The detailed
>> breakdown can be found in their dt-binding entries.
>>
>> Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
>> "zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt.
>> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
>> should generate the following cpuinfo output:
>> "rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zkt"
>>
>> riscv_isa_ext_data grows a pair of new members, to permit setting the
>> relevant bits for "bundled" extensions, both while parsing the ISA string
>> and the new dedicated extension properties
>>
>> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Evan Green <evan@rivosinc.com>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> My tree might be out of sync, but in my search for riscv_isa_ext, I
> also found a use in print_isa() (cpu.c) where we're reaching into
> riscv_isa_ext[].id and assuming it's always valid. If that's still in
> there we'll want to fix up that spot too, since now with bundles .id
> may or may not be valid.

Oh indeed, the array is visible outside of this compilation unit :/.
I'll check that before sending V3.

Clément

> 
> -Evan

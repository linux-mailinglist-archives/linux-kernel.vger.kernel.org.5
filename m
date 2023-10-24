Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD767D4CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjJXJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjJXJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:40:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C41713
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:30:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32da4180ca2so892430f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698139810; x=1698744610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epBSW7d/Y73fuCPm0yJqVjtBNeGFhQxq0MaplKN63vg=;
        b=AMiqT/jwK00ssjVuB21Y1vsh4Z8x0hMaB49VaHC9aXjss7zFtjX5jUszFo4EsDX9+U
         3QE9XlAxOfHHCd3/FBjIwKR20W434JL4MXLvmwW2i3ts6NbAvUQrv33CRhNZdzRnGAsu
         gslbGhzqrfouddAU2bPrRuxL3UMf0JtEUkGmFKEOjTbeOayV/QutH4Xsp5yJGS9jXat+
         5y/pGgy4py1/A1Me1qTzSg5/sWAL7caH/e6179AyoJMu8/MXYnm8LY3aP27WqLvs5lCk
         pxrFFNPhw12uT4xmur0Vvzi+WU5sTClp5f8KgdiUZCstD6ikiWE7CkXkyCjL3LdY9O7N
         2jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698139810; x=1698744610;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epBSW7d/Y73fuCPm0yJqVjtBNeGFhQxq0MaplKN63vg=;
        b=m0aiqiYElw3ixyiohIU7ISlGoQw5yz/Y2Id0I4B7p9gCzbqbGNKvD+eIkEfNEu5lfJ
         copf8jm+ozFuQobVDoAvyzz4/vAofIKsS5bLOAcEAOoaygfA6JkbDYEavGtSAoEClmP6
         b/HonEw2+B2US3iI3q6fvmzn98p3Wbv0VbEm67eOiz41zghY6ffDlwZE0qJRqqt1Wqh8
         Hza4hAgtg+QEf+tAOTeegBEQhZhfUNk+7+4e1u6l3OFiTU+GWYrFlE+zgS3him6tBLRg
         MYwHQp8mrfGRyy2aC1/gv9fpTV5CQcrNwbmR/fGRlvXnB2iEcJ8F8WllhsQdg24QQRFl
         5ryg==
X-Gm-Message-State: AOJu0Yy1cUgbukZMBtRwILGCRO8ArWhZnkZnDD6dqkvIdL3TxNNBiuJi
        wrzQlFP3zJKhsDbCqslwk+/yOA==
X-Google-Smtp-Source: AGHT+IFm/o5S53urNBlHODYQKB9HRkQDLb5L5tdDg3p22JIkoo7vc0CsuA6eRfMc1YyYbUFwwXSiVg==
X-Received: by 2002:adf:a48f:0:b0:32d:d9a8:53df with SMTP id g15-20020adfa48f000000b0032dd9a853dfmr8334091wrb.3.1698139809733;
        Tue, 24 Oct 2023 02:30:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:597d:e2c5:6741:bac9? ([2a01:e0a:999:a3a0:597d:e2c5:6741:bac9])
        by smtp.gmail.com with ESMTPSA id dj18-20020a0560000b1200b0032d96dd703bsm9574187wrb.70.2023.10.24.02.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 02:30:09 -0700 (PDT)
Message-ID: <56f6af04-bdf4-4b85-99dc-9eb4f391d7ad@rivosinc.com>
Date:   Tue, 24 Oct 2023 11:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] riscv: add ISA extension parsing for scalar
 crypto
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
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
 <d0ea4996-5c48-47b4-99b0-f4211276e0b2@rivosinc.com>
In-Reply-To: <d0ea4996-5c48-47b4-99b0-f4211276e0b2@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 09:18, Clément Léger wrote:
> 
> 
> On 23/10/2023 18:21, Evan Green wrote:
>> On Tue, Oct 17, 2023 at 6:15 AM Clément Léger <cleger@rivosinc.com> wrote:
>>>
>>> From: Evan Green <evan@rivosinc.com>
>>>
>>> The Scalar Crypto specification defines Zk as a shorthand for the
>>> Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
>>> which are all shorthands for various other extensions. The detailed
>>> breakdown can be found in their dt-binding entries.
>>>
>>> Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
>>> "zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt.
>>> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
>>> should generate the following cpuinfo output:
>>> "rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zkt"
>>>
>>> riscv_isa_ext_data grows a pair of new members, to permit setting the
>>> relevant bits for "bundled" extensions, both while parsing the ISA string
>>> and the new dedicated extension properties
>>>
>>> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Evan Green <evan@rivosinc.com>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> My tree might be out of sync, but in my search for riscv_isa_ext, I
>> also found a use in print_isa() (cpu.c) where we're reaching into
>> riscv_isa_ext[].id and assuming it's always valid. If that's still in
>> there we'll want to fix up that spot too, since now with bundles .id
>> may or may not be valid.
> 
> Oh indeed, the array is visible outside of this compilation unit :/.
> I'll check that before sending V3.

After looking a bit more at that, it actually seems that id is used in
cpuinfo to determine which extensions are present which means you are
right, bundle_size needs to be accounted for.

Looking at it also raises the question (again) of exposing the "bundles"
extensions themselves or not in cpuinfo output. With the current setup,
the bundles extensions won't be visible in cpuinfo output. For instance
if Zk was in the isa string, then it will not be visible in the cpuinfo
output, only the child extensions. One solution would be to always have
a valid id for each extension. So we would have one for Zk for instance.

We would then have a similar setup for all "bundles" or "subset"
extensions, they would have a id for all of them. For instance, Zk would
become:

__RISCV_ISA_EXT_DATA_BUNDLE(zk, RISCV_ISA_EXT_ZK, riscv_zk_bundled_exts)

Same would go for zvbb (riscv_zvbb_subset_exts would only contain Zvkb):

__RISCV_ISA_EXT_DATA_BUNDLE(zk, RISCV_ISA_EXT_ZVBB, riscv_zvbb_subset_exts)

For the sake of completeness, I feel like it would be good to have all
the extensions (bundles or not) visible in the riscv_isa_ext.

Any objection ?

Clément

> 
> Clément
> 
>>
>> -Evan

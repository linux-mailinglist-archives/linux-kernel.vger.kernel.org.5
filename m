Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B73D7B7CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbjJDKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjJDKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:03:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403B83
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:03:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32337a39009so429244f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696413822; x=1697018622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfae490VV9WBXM89EM3q6lxJTFYipXmEfpcaCyueRfQ=;
        b=wuGvrdba/Ritj1JqXcts5bWq5vpGlVWKkIZ7bm5Mj+ZcfeE1HC/LUY6aTgK+eozYkJ
         FpiuHPQf/JY++/z0vr+foOs2tzuQUL6bDONK6Sy7/4sTaYgecl5Fy8HLSO9LcPwho6e3
         t9F9YRV5BIX3hJkp+3Sg53HI90S1YX0/SUg05+YOoKSp96C+jXRu02o8YcsiDpA9smed
         6YTFbnNROYekEt2TteUI+etHY7Y2vCuaYJxuFY5IZrmLaE7yMPXXuV64/e5xwLhnIm+h
         NcB1VC2MxCxpXhprJj1IcGG/tAJXp8xdaiA8lNH0OGXWinQutJjiZe7Ht2ZEhB/TX+gC
         HPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413822; x=1697018622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfae490VV9WBXM89EM3q6lxJTFYipXmEfpcaCyueRfQ=;
        b=ruwrJHmm6iF+p+Oqq6ZVQ+K+aroROlRbXGKJyLpKUtcJQbfvMPx4TqCiFJzU+uAye9
         /QT2j+N7eVE/mWdiBAxSop7VnGG6EiIapGx2jnVwuUJDKCF0gk68miWOsQk994/AdtRx
         RyADdRhWDV1qHAjHZmz6Hddjbolb+KOFdjAbqf9AxNHlaGr22a9zbzT6XUF+qU6aH69B
         i7VjbrFetOgj3FaPI3qywBtJ+dqcSHdtpsq3Qwxv8J5hxqeXn8rc5Ymf0WovfoTkuDPf
         lRwfv/KH8+C6ukCXQ6qqaDyDt5bGn0hjztDduKWgs3c+seZMJtMxQ+Qnh8utt5jm2RHL
         vdDg==
X-Gm-Message-State: AOJu0YylgdR9+aF6sD4dLMwjmI1hF6DEJ22HXOibcsY+ah1FU5C7uMdD
        o3F6wesnKFMcKCEnccv+txTKXw==
X-Google-Smtp-Source: AGHT+IGqYRm62vztNg+Qsa035B5QN3qFSsyAitb9Yn2nk79RwGKOK04nLKq/XiAgCTq21LBJd/p9Vg==
X-Received: by 2002:adf:f40c:0:b0:31f:84c9:d75f with SMTP id g12-20020adff40c000000b0031f84c9d75fmr1467048wro.4.1696413821712;
        Wed, 04 Oct 2023 03:03:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9474:8d75:5115:42cb? ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id k14-20020adff5ce000000b00323287186aasm3646419wrp.32.2023.10.04.03.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 03:03:41 -0700 (PDT)
Message-ID: <6ac16274-3816-4b46-9068-e97af66c815a@rivosinc.com>
Date:   Wed, 4 Oct 2023 12:03:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     David Laight <David.Laight@ACULAB.COM>,
        Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
 <eb9dcaaf313642b096d68df4b92e7466@AcuMS.aculab.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <eb9dcaaf313642b096d68df4b92e7466@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2023 10:26, David Laight wrote:
> From: Clément Léger
>> Sent: 02 October 2023 08:40
>>
>> On 30/09/2023 11:23, Conor Dooley wrote:
>>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Clément Léger wrote:
>>>> Since commit 61cadb9 ("Provide new description of misaligned load/store
>>>> behavior compatible with privileged architecture.") in the RISC-V ISA
>>>> manual, it is stated that misaligned load/store might not be supported.
>>>> However, the RISC-V kernel uABI describes that misaligned accesses are
>>>> supported.
> ...
> 
> That it just really horrid.
> If the cpu is going to trap misaligned accesses then you want
> The compiler generated code (ie packed data) not to generate
> misaligned accesses.

Hi David,

Saying that you support misaligned access does not mean that they are
going to be efficient, just that they are supported (in fact, the uABI
state that they may perform poorly). The compiler is actually not so
stupid and will try to do as much aligned access as possible in what it
generates (unless forced by some assembly, cast or whatever that can
screw up alignment accesses). This is already the case and it will most
probably not change.

> So you have to change the kernel uABI.

I don't think so. Rule N°1 for kernel development is "Don't break the
userspace". So if changing the RISC-V uABI to say "misaligned accesses
are not supported", that is unlikely to happen. We stated that
misaligned access are supported and thus, they will continue to be
supported.

> 
> OTOH if you known that such accesses won't fault and will be
> not really slower than aligned accesses then optimised versions
> of some functions (like memcpy and checksums) can use misaligned
> accesses.

Yes, this is selected by HAVE_EFFICIENT_UNALIGNED_ACCESS. On RISC-V,
since the specification says nothing about the efficiency of such
access, we can't select it like that. Some RISC-V based SoC/CPUs might
want to select it manually in their config. In order to support that
dynamically and in a generic way, some future work could involve using
static keys for such alternatives and enable it based on the speed that
was detected.

Thanks,

Clément

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

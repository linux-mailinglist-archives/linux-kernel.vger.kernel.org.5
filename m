Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41A7B63F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbjJCIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjJCIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:23:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B66965AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:12:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c277f6f24eso1086431fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696320741; x=1696925541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7a5n0Ui2q8c2Q2RMg99Pm73cLNmhODZZUiYNdq+8QsU=;
        b=TDVnV7YZmuxcU558PwD2gd6G1CQt8O6beVy4/YmzrJXuxJ9UrVHCrDrtHmrqGourfV
         VZsufkDX4qmkfZyXh46+rkSXmiYKZyOKXlxEgWLmyry5e1puMGXFWUssFHyMfyzJCC1d
         tCA+1BMZmGmWOHnKpyQbEhYmmyc49hUA1Jx3oZP3oO6bUbSb3s9jokAbOw3FDUielyGj
         iX8PHzKkSzDIzTdLgrgd1KZVc/MaSN+iFTCrP8DaSCUvQzgDgwGHsC6ZnhqUfiX9Jea+
         X9YmTPxlRye35gQ0j3n/bdc29HXlPwrBZ081Ka0+2kPoZjRiHLPeeyC18YU2Ljnl5KSl
         VaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696320741; x=1696925541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a5n0Ui2q8c2Q2RMg99Pm73cLNmhODZZUiYNdq+8QsU=;
        b=iMUJAq42/++P1g5ub+wWU9HDM24GjbBki4F4N/T1ZZvWfODv9eS9SVX5Zq4jWNZKVf
         tHYChMz0U09crXhh1xn4szY77TdMqeP+VLGZB+jw42/jscDUWZUY2rQIiMWOmfpF8F/b
         p/UEOr1aDHx2QZeJaBkWIZxVAVHueqzeRmTV0e29z22vHA0vnSZqIHy2nMLZxoypuhaE
         vzsoAxtXmvAUWeAp3TfRARm49FV06YJwStqEP3hPxaQYVt+4saLZBoq2hl5Hpj19wVSF
         IPEnqkks7x8P5bdm5xo8/D/Qe/A4fo+rwLg6dlBafGFtB7olKRY2oftsiUZ6nqci+De6
         5tPQ==
X-Gm-Message-State: AOJu0Yz3g/0RRTD3QgPFS1omV7lY9NwSUYbSqWdIRWN2gVUOHMGttkSi
        r1PwBH4Tew6bgwBSScqpOxjOGA==
X-Google-Smtp-Source: AGHT+IGeLm22wz4BrxQ6tqBbXb7fGJMmOKsLLYWRdAHJgLMrzddEbfDFnWwERV9TNf8QEg0hRNUVbg==
X-Received: by 2002:a2e:b953:0:b0:2b9:e10b:a511 with SMTP id 19-20020a2eb953000000b002b9e10ba511mr8835141ljs.0.1696320740794;
        Tue, 03 Oct 2023 01:12:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:5e96:db9d:a127:1934? ([2a01:e0a:999:a3a0:5e96:db9d:a127:1934])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b00405442edc69sm8790540wmr.14.2023.10.03.01.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:12:20 -0700 (PDT)
Message-ID: <c7fa544a-664e-48c1-a9e0-09085a221862@rivosinc.com>
Date:   Tue, 3 Oct 2023 10:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     ron minnich <rminnich@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
 <20231002-spearman-doze-70cc026ac13e@spud>
 <693e6584-1e66-48c0-aa7c-61d9f88abd4c@rivosinc.com>
 <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAP6exYLtQuyqMgG6jRAhizp-52ebu3OLNSXe8a8xvLALYFD3kA@mail.gmail.com>
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



On 02/10/2023 17:32, ron minnich wrote:
> This was a very interesting read. One other thought crossed my mind,
> which is that a RISC-V implementation might make the alignment
> delegation hard-wired to always delegate to S mode. I.e, the bit might
> be WARL and always 1. For what I'm doing, this would actually be
> pretty convenient. Just want to make sure this code can accommodate
> that -- wdyt?

Hi Ron,

This series does not really care about "how" misaligned load/store are
delegated, it only tries to check if misaligned load/store are handled
by the kernel. So whatever you decide to do to delegate that is a bit
out of the scope of this series.

> 
> We have found lots of value in our experiments with delegating
> alignment traps to Linux -- not least because they tend to locate
> problems in the kernel :-) -- we've found issues in module loading,
> early startup (there's a needed .align2 directive for sbi secondary
> startup, AFAICT) and the timing code for misaligned load/store
> handling.>
> I don't know how you test this unaligned trap handling, but it might
> be worthwhile to work that out. You can test via oreboot and the
> visionfive2, save we have not figured out why SMP startup is going
> wrong, yet :-), so we're not as feature-complete as needed. But soon.

I test that on spike (which does not handle misaligned accesses contrary
to qemu) using a userspace program that actually exercise all kind of
standard load/store instructions as well as FPU ones with different
registers. Regarding the kernel, you are right that I might be lacking a
few tests though. I'll also consider using a visionfive2 board to
validate that on real hardware.

Thanks,

Clément

> 
> Thanks!
> 
> On Mon, Oct 2, 2023 at 5:19 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>>
>>
>> On 02/10/2023 12:49, Conor Dooley wrote:
>>> On Mon, Oct 02, 2023 at 09:40:04AM +0200, Clément Léger wrote:
>>>>
>>>>
>>>> On 30/09/2023 11:23, Conor Dooley wrote:
>>>>> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Clément Léger wrote:
>>>>>> Since commit 61cadb9 ("Provide new description of misaligned load/store
>>>>>> behavior compatible with privileged architecture.") in the RISC-V ISA
>>>>>> manual, it is stated that misaligned load/store might not be supported.
>>>>>> However, the RISC-V kernel uABI describes that misaligned accesses are
>>>>>> supported. In order to support that, this series adds support for S-mode
>>>>>> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
>>>>>>
>>>>>> Handling misaligned access in kernel allows for a finer grain control
>>>>>> of the misaligned accesses behavior, and thanks to the prctl call, can
>>>>>> allow disabling misaligned access emulation to generate SIGBUS. User
>>>>>> space can then optimize its software by removing such access based on
>>>>>> SIGBUS generation.
>>>>>>
>>>>>> Currently, this series is useful for people that uses a SBI that does
>>>>>> not handled misaligned traps. In a near future, this series will make
>>>>>> use a SBI extension [1] allowing to request delegation of the
>>>>>> misaligned load/store traps to the S-mode software. This extension has
>>>>>> been submitted for review to the riscv tech-prs group. An OpenSBI
>>>>>> implementation for this spec is available at [2].
>>>>>>
>>>>>> This series can be tested using the spike simulator [3] and an openSBI
>>>>>> version [4] which allows to always delegate misaligned load/store to
>>>>>> S-mode.
>>>>>
>>>>> Some patches in this series do not build for any configs, some are
>>>>> broken for clang builds and others are broken for nommu. Please try to> build test this more thoroughly before you submit the next version.
>>>>
>>>> Hi Conor,
>>>>
>>>> Thanks for the feedback, I'll check that.
>>>>
>>>>>
>>>>> Also, AIUI, this series should be marked RFC since the SBI extension
>>>>> this relies on has not been frozen.
>>>>
>>>> This series does not actually uses the SBI extension but provides a way
>>>> to detect if misaligned accesses are not handled by hardware nor by the
>>>> SBI. It has been reported by Ron & Daniel they they have a minimal SBI
>>>> implementation that does not handle misaligned accesses and that they
>>>> would like to make use of the PR_SET_UNALIGN feature. This is what this
>>>> series addresses (and thus does not depend on the mentioned SBI extension).
>>>
>>> Ah, I must have misread then. Apologies.
>>
>> No worries, maybe I should actually remove this from the cover letter to
>> avoid any confusion !
>>
>> Clément

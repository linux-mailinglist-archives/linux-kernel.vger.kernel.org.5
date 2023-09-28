Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F27B154F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjI1HtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjI1HtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:49:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912D8F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:49:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4064e3c7c07so1239665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695887347; x=1696492147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bs5ot7FeCsBm13VIPZe46Wdlh4ukmrcJmP2lb7/PRVE=;
        b=hkSwJRFeLAfQOFunpg7knvapl+ePHm1r20P5rUjKNTTpMu7sAZw7x25+mZGEwOILhp
         jy0lGD3RCx+Aa1feuTFx8cE40Jz7tAPRK4mpZtWj+5oertwMaX4OQrML0fOC6xiLH4eE
         U682Va07YySTaWgzYsnzA1k8huOJkBDpTR93Undr5zzFDcS82mFcramFB63a2X5oaOVw
         xUe5OEGIQqeZ4gyQAeFZqFHFSMendbzSCALkIl2ukcf9z4dmRCnFNU5M3OOrXgLRllHP
         axl5AOUkYMNHfwfxKhYFS4g1LS5CzH86hAOkQ73hKCW3aY2I7p8zAw7vtvVibPj+SaaX
         N4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695887347; x=1696492147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bs5ot7FeCsBm13VIPZe46Wdlh4ukmrcJmP2lb7/PRVE=;
        b=qXu1TZ2OCiWU3yxWUyPWRbkSNZEfg9CN/EsR637wW4KN/QJrj5JSDNRN3A+2h6tN6U
         jTs4IQYB48oBX3bwXIofmWcwnWXw2WfTAGFZqDfaWjqi91p6HKz6+F7YLMa/LXU4v1ev
         KGAvF6df4FuIKvMHmV074yIvfQ7BolMBICZhlk/Sbz3D+8ovUiN1c+iTC3PSmZsVgy8U
         ApgdieU7Bnh6kcYnwqv+DVKg2LN3Ne5vdI3w29uvpR9UkX0ob2V6+cqG6qrNP0Hb0FKh
         k2rqURrvDnTxOTEXJ5h9V2JRRQ9uAZEVlKxpACx2jtOkOh/bV0pYnhCTSEJzGeDqmKm6
         he4Q==
X-Gm-Message-State: AOJu0YzRSZi/CT+KGhQiBsEJ4yhU0vZVQ4HrORu8o++Pylnmbwn59njU
        1hAebXY4hBd646qJG6V1NUBEsQ==
X-Google-Smtp-Source: AGHT+IEwNFAmjNW91EMUnvbAC7XSuWTt0XxQR7RBhnV/RK6Ucnhre0DyD88YoIFJ+heFaendSSHICA==
X-Received: by 2002:a05:600c:3b88:b0:405:1ba2:4fcf with SMTP id n8-20020a05600c3b8800b004051ba24fcfmr455146wms.4.1695887346703;
        Thu, 28 Sep 2023 00:49:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:866e:3285:a245:a33f? ([2a01:e0a:999:a3a0:866e:3285:a245:a33f])
        by smtp.gmail.com with ESMTPSA id z4-20020a1c4c04000000b004063ee0b10esm4923477wmf.46.2023.09.28.00.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:49:06 -0700 (PDT)
Message-ID: <10997d30-e6b7-4a24-a43e-e22679e8d450@rivosinc.com>
Date:   Thu, 28 Sep 2023 09:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-Hss+OK-vJy_ZKjVbGh7rTBZA+GditWcdM1XjDDskGF76Dw@mail.gmail.com>
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



On 26/09/2023 23:43, Evan Green wrote:
> On Tue, Sep 26, 2023 at 8:03 AM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> Since commit 61cadb9 ("Provide new description of misaligned load/store
>> behavior compatible with privileged architecture.") in the RISC-V ISA
>> manual, it is stated that misaligned load/store might not be supported.
>> However, the RISC-V kernel uABI describes that misaligned accesses are
>> supported. In order to support that, this series adds support for S-mode
>> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
>>
>> Handling misaligned access in kernel allows for a finer grain control
>> of the misaligned accesses behavior, and thanks to the prctl call, can
>> allow disabling misaligned access emulation to generate SIGBUS. User
>> space can then optimize its software by removing such access based on
>> SIGBUS generation.
>>
>> Currently, this series is useful for people that uses a SBI that does
>> not handled misaligned traps. In a near future, this series will make
>> use a SBI extension [1] allowing to request delegation of the
>> misaligned load/store traps to the S-mode software. This extension has
>> been submitted for review to the riscv tech-prs group. An OpenSBI
>> implementation for this spec is available at [2].
> 
> For my own education, how does the new SBI call behave with respect to
> multiple harts? Does a call to change a feature perform that change
> across all harts, or just the hart the SBI call was made on? If the
> answer is "all harts", what if not all harts are exactly the same, and
> some can enable the feature switch while others cannot? Also if the
> answer is "all harts", does it also apply to hotplugged cpus, which
> may not have even existed at boot time?

Depending on the feature, they can be either global (all harts) or
local (calling hart). The medeleg register is per hart and thus
misaligned load/store delegation for S-mode is also per hart.


> 
> What happens if a hart goes through a context loss event, like
> suspend/resume? Is the setting expected to be sticky, or is the kernel
> expected to replay these calls?

That is a good question that we did not actually clarified yet. Thanks
for raising it !

Clément

> 
> -Evan

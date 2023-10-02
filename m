Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96E7B4CB6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjJBHkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbjJBHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 03:40:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC5283
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 00:40:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40651b22977so10373215e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 00:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696232406; x=1696837206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SmkuwNO2qK93iNkdDy+3DZV33vyoBJOdJJ+lJYPcnY=;
        b=E9SU0nG2Rx7ynBiPfYiswvXDG44PfSfM0VgCZAntkHJsGVZomi0awOvFxfkEkfQI0F
         m7hmSf2RgGAsyWvCR1Qkf9XROE2RBJDDEk7DaarkqHbDQkn5ZuQ6JVtxVEGQQujZeQm2
         R+xTbeI6oR0GHy0O9FXDaubOLeJR8oY0UgRbul31orJjDu4upBa6FERRrjNEPBRkEHCp
         dS8Do0uOBYxGccS2wtMk0+l9swXDufjWtO74VM3n67l4KsYg1/3NAWGNLUdYVbgzrJpx
         svy/bF+Qf+edDSLmJXidMrT9bS3OdjLgTeMd1dEZLXi/dpayFjekFq/XG/Ge5/r/eoEB
         eJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696232406; x=1696837206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SmkuwNO2qK93iNkdDy+3DZV33vyoBJOdJJ+lJYPcnY=;
        b=Y/yAhwYe5KGxqtAdk6PZO3bUJ9zYDcpkPF+DfHzTMqApiUNptf4NFsXhQsL8WwGO8y
         ZwKn78JHy0JBuzl74tv+nMr4R6HlaoYNKNw7v9IyyR/744THXvK9eI/taW1tSSFia7F2
         2vrC/pJsRonNjIATiQSdafkZteqvwNrg3erPMKscUYcygecnVRkUMhwOnySwkjvEZpZU
         SH2ku3dDN1SdlFVQVSJsRmNl1EMHUhCDTDlf7DEmyS+/quhZIhaa7AZrjQWDLLOFMi7L
         nuFuMVdrfv2w7CI1Ys20YmO1tUomc8VzsxZDJZ6snzdtsPfwgk6S1252/X2u2ykqv5KD
         pwFQ==
X-Gm-Message-State: AOJu0YzEaWWh+nyi/EYnOngbf/FQokFoD5Q7689o1tFGv+9HNX65CqWp
        9SHf+iyPTBDESuGSXvpFLOF9dQ==
X-Google-Smtp-Source: AGHT+IGpjr4vDelieeMrTffwVcMt8woXagyVVosQfp5vhupKOMLXb+SgLQsZ3moRwjQnrVRywBIhzA==
X-Received: by 2002:adf:d0c1:0:b0:31a:ea18:c516 with SMTP id z1-20020adfd0c1000000b0031aea18c516mr9425270wrh.3.1696232405718;
        Mon, 02 Oct 2023 00:40:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:2dc5:b516:f0fb:7491? ([2a01:e0a:999:a3a0:2dc5:b516:f0fb:7491])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003266ece0fe2sm5879650wrm.98.2023.10.02.00.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 00:40:05 -0700 (PDT)
Message-ID: <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
Date:   Mon, 2 Oct 2023 09:40:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230930-patchy-curdle-ef5ee6e1a17c@spud>
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



On 30/09/2023 11:23, Conor Dooley wrote:
> On Tue, Sep 26, 2023 at 05:03:09PM +0200, Clément Léger wrote:
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
>>
>> This series can be tested using the spike simulator [3] and an openSBI
>> version [4] which allows to always delegate misaligned load/store to
>> S-mode.
> 
> Some patches in this series do not build for any configs, some are
> broken for clang builds and others are broken for nommu. Please try to> build test this more thoroughly before you submit the next version.

Hi Conor,

Thanks for the feedback, I'll check that.

> 
> Also, AIUI, this series should be marked RFC since the SBI extension
> this relies on has not been frozen.

This series does not actually uses the SBI extension but provides a way
to detect if misaligned accesses are not handled by hardware nor by the
SBI. It has been reported by Ron & Daniel they they have a minimal SBI
implementation that does not handle misaligned accesses and that they
would like to make use of the PR_SET_UNALIGN feature. This is what this
series addresses (and thus does not depend on the mentioned SBI extension).

Thanks,

Clément

> 
> Cheers,
> Conor.

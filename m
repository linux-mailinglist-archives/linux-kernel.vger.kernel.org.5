Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBF7E356C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjKGHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjKGHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:00:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE87FFC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:00:05 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc4f777ab9so37771455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699340405; x=1699945205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT+fB+nShc13WFwJsBmCnkPpP2szplCX09J2M/XdGJc=;
        b=qavlxJPtvsJtxFBdQwFOVgEYU7hi5LpRx19AgpWuaBEju9wwL+/KUkWaoy93hx8shG
         HMABIivvvYeuDmsjjlRlCZ2XgL0hWC3gY6RcuDyJwEihZ886d9W2EiEJ2Cbbc3lOUbU2
         RhQ1BLodh6XCL3x3iSl0aXDaYPP0FzKxCsVsqyZ+g9FMh3PESug7OHPksU5T+TXmjFSp
         E2UT9qcFTz7Dt4+QRz4OX8eJFclaQUk0aQtgXinCaBOFTyA+pONTn1PPuGuJYdCr9wWo
         sSOG7tNc1h1T8/EedW99MIJtH1DKlZj39/Opq+5XyX1TeUgQXP1WX2hZfJrxXs8BLAc9
         y50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340405; x=1699945205;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT+fB+nShc13WFwJsBmCnkPpP2szplCX09J2M/XdGJc=;
        b=X3rxZI3x4N6pRpFtG1ez+QDLAzHXyYQmDF5JzZLYqoFgyKAFqXQTfUqo9WN8YMrzvr
         wSYKxef7B49jRaFAz4zyZLXyQ7poyHBYamWFeSkSKB2seADudAlExZiYodPjGzEsEiD6
         L+Ecad7SbHFi+Pd8yJb9/rk8cGzpD8ZoYdr4bC3nWqclkbMOTsMQminUNAo/xJjUdyqu
         3hnStZRHRkQPQbisg0AZcCGENY9LE2FNprPqvIq4i6Jh4/1lAClT3goNRgcjUKSUPe4U
         aEOmyOAKU7XnbMWQr1vgtaAOtj273eG91uxjQ3horbo3inarbLGlytKx4mNQW3+OeUTA
         4GoA==
X-Gm-Message-State: AOJu0YzC/7gzF4brg7gklAkdqHBgSwdcGE9SeEBKgLi6MW4O2hwZSlhu
        shc7CIJLdTzWNGtEQaG926fUyA==
X-Google-Smtp-Source: AGHT+IHfFOWchFvO8pJneXAWC0dzM9ECoTMi1CyG7yOXyLVhl6cL8Z+QF9QwrVc4186nG4cx0iwg+A==
X-Received: by 2002:a17:902:bd85:b0:1cc:ef72:8600 with SMTP id q5-20020a170902bd8500b001ccef728600mr1911154pls.62.1699340404326;
        Mon, 06 Nov 2023 23:00:04 -0800 (PST)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001ca222edc16sm6950068plb.135.2023.11.06.23.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:00:03 -0800 (PST)
Date:   Mon, 06 Nov 2023 23:00:03 -0800 (PST)
X-Google-Original-Date: Mon, 06 Nov 2023 22:59:59 PST (-0800)
Subject:     Re: [PATCH v6 0/4] riscv: tlb flush improvements
In-Reply-To: <24E0FC81-810E-44FD-9494-CA9374E495B5@gmail.com>
CC:     alexghiti@rivosinc.com, Will Deacon <will@kernel.org>,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, mchitale@ventanamicro.com,
        vincent.chen@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, samuel@sholland.org,
        prabhakar.csengg@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nadav.amit@gmail.com
Message-ID: <mhng-4e3e3fa7-5e25-494c-a3ad-6ef7ec78cf20@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 07:01:48 PDT (-0700), nadav.amit@gmail.com wrote:
>
>> On Oct 30, 2023, at 3:30 PM, Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>> 
>> +			on_each_cpu_mask(cmask,
>> +					 __ipi_flush_tlb_range_asid,
>> +					 &ftd, 1);
>> 
>
> Unrelated, but having fed

Do you mean `ftd`?

If so I'm not all that convinced that's a problem: sure it's 4x`long`, 
so we pass it on the stack instead of registers, but otherwise we'd need 
another `on_each_cpu_mask()` callback to shim stuff through via 
registers.

> on the stack might cause it to be unaligned to
> the cacheline, which in x86 we have seen introduces some overhead.

We have 128-bit stack alignment on RISC-V, so the elements are at least 
aligned.  Since they're just being loaded up as scalars for the next 
function call I'm not sure the alignment is all that exciting here.

> Actually, it is best not to put it on the stack, if possible to reduce
> cache traffic.

Sorry if I'm just missing something, but I'm not convinced this is a 
measurable performance problem.

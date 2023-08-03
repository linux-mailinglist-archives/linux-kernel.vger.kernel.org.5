Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62F76EDBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjHCPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHCPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:13:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E17FE75
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:13:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb7b8390e8so7493455ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691075628; x=1691680428;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFi6nkKuCfronVs3puu7JeuJqqo6OybabVqGaNziIKo=;
        b=BFF/P4SllIBeLlsCR85Pws/VNoP+i8PKJU8qgPlZeBbrBC3Ab0pCbpw1o+Ft7nMqgv
         hLrIoZfjIK5vNVCakvol5B70zNLbrRd9zEMoMN9A6w13ZgpOOVBkbr7XBuIpSZkxPNji
         sEXNrcwTcFcmJURjPJxGXKWAHqDvgLRvppNBt37pq5LeXUbAXwEuVgh4rXyF9ZejgJBi
         1dmzcTlpGIoSkjvHohD62dSskjSuvGsgk6PMq4wANW/AFjh0UBWFtIm1s5DssRJWTqY1
         oflQOZjK9zh4t6n8TL1Ag4Q4qechkvZSlh7+4IIElJNW9WBGJsnlHrH7Ut4pRmTEk+pI
         vXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691075628; x=1691680428;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFi6nkKuCfronVs3puu7JeuJqqo6OybabVqGaNziIKo=;
        b=dlOi3l8BRuKC/l3kDo9YOyPU3IDwhr4O0YMKa3MvWMxm02qcVOSB6CdVMAjZZgiDFL
         VHomxU9iYirO229ls3t3+cB3fmvqI8kz1oPLM8uTOkDdtql1MoWLDnqHx6bzGLAQwIob
         fKlAlVszJTKSlnhEmTti5sF9n9Oci6EPVDCUWB9O3SEvOD8HIB3YkaycZ4Eh1y2qdbOf
         5lfYRcMxeX/xIcmtKDgBhSVEzYnT1XRC2+dQePFd7Yu/V1VriG9/ucW9hIm5TNNU74tW
         2FS+qCrN1duY9QQ8/qcQCGwwkOJXFfpMHqLUSJwUFGyR8x3/a2f2AmVQnm7FLbpH6r5s
         nlVg==
X-Gm-Message-State: ABy/qLa6hehZ6fH0rM9h3EsSeEnHMtI+boSopQ59u+XX6cqtYPwAt9/4
        4FWT9z0nDH+qyLZosftu46NWgA==
X-Google-Smtp-Source: APBJJlGoGXFjAt34mfVI2PMBZl931LLcFaNTQJ9h+JJko9jh4GP1728E6rUCzfqmCMYzNC/d1arynQ==
X-Received: by 2002:a17:902:f681:b0:1b8:7625:3042 with SMTP id l1-20020a170902f68100b001b876253042mr21752457plg.10.1691075628504;
        Thu, 03 Aug 2023 08:13:48 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b001b87bedcc6fsm14494288pls.93.2023.08.03.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:13:48 -0700 (PDT)
Date:   Thu, 03 Aug 2023 08:13:48 -0700 (PDT)
X-Google-Original-Date: Thu, 03 Aug 2023 07:45:20 PDT (-0700)
Subject:     Re: [PATCH v2 2/3] riscv/purgatory: do not link with string.o and its dependencies
In-Reply-To: <20230726-excavate-swoosh-424ede98f63d@spud>
CC:     petrtesarik@huaweicloud.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        lihuafei1@huawei.com, liaochang1@huawei.com, masahiroy@kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org, heiko@sntech.de,
        ribalda@chromium.org, hi@alyssa.is, lizhengyu3@huawei.com,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, duwe@suse.de,
        roberto.sassu@huaweicloud.com, petr@tesarici.cz
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-45e67c5d-6969-43da-9147-b53dc9a78612@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 09:33:49 PDT (-0700), Conor Dooley wrote:
> On Wed, Jul 26, 2023 at 11:54:00AM +0200, Petr Tesarik wrote:
>> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>> 
>> Linking with this object file makes kexec_file_load(2) fail because of
>> multiple unknown relocation types:
>> 
>> - R_RISCV_ADD16, R_RISCV_SUB16: used by alternatives in strcmp()
>> - R_RISCV_GOT_HI20: used to resolve _ctype in strcasecmp()
>> 
>> All this hassle is needed for one single call to memcmp() from
>> verify_sha256_digest() to compare 32 bytes of SHA256 checksum.
>> 
>> Simply replace this memcmp() call with an explicit loop over those 32 bytes
>> and remove the need to link with string.o and all the other object files
>> that provide undefined symbols from that object file.
>> 
>> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>> Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
>
> This version keeps the automation happy,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Oddly enough, this breaks my builds.  I tried fixing the first one with
something like

    From 41c5a952f77e53bf4201296abff0132725aa19e6 Mon Sep 17 00:00:00 2001
    From: Palmer Dabbelt <palmer@rivosinc.com>
    Date: Wed, 2 Aug 2023 20:22:33 -0700
    Subject: [PATCH] RISC-V: Include io from timex
    
    Without this I get some implicit declarations.
    
      CC      arch/riscv/kernel/asm-offsets.s
    In file included from linux/include/linux/timex.h:67,
                     from linux/include/linux/time32.h:13,
                     from linux/include/linux/time.h:60,
                     from linux/include/linux/ktime.h:24,
                     from linux/include/linux/timer.h:6,
                     from linux/include/linux/workqueue.h:9,
                     from linux/include/linux/mm_types.h:19,
                     from linux/include/linux/mmzone.h:22,
                     from linux/include/linux/gfp.h:7,
                     from linux/include/linux/mm.h:7,
                     from linux/arch/riscv/kernel/asm-offsets.c:10:
    linux/arch/riscv/include/asm/timex.h: In function 'get_cycles':
    linux/arch/riscv/include/asm/timex.h:25:16: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
       25 |         return readl_relaxed(((u32 *)clint_time_val));
          |
    
    Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    ---
     arch/riscv/include/asm/timex.h | 1 +
     1 file changed, 1 insertion(+)
    
    diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
    index a06697846e69..1a4d181193e0 100644
    --- a/arch/riscv/include/asm/timex.h
    +++ b/arch/riscv/include/asm/timex.h
    @@ -7,6 +7,7 @@
     #define _ASM_RISCV_TIMEX_H
     
     #include <asm/csr.h>
    +#include <asm/io.h>
     
     typedef unsigned long cycles_t;
 
    -- 
    2.41.0

The other two look fine and are somewhat independent, so I've picked those up
for fixes.

Thanks!

>
> Thanks,
> Conor.

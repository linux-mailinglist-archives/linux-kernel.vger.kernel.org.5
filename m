Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC3752480
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjGMOAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjGMOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:00:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D921995
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:00:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso4417015ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689256838; x=1691848838;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxdXHhZkRJEwrXWIjK24zGSqZZm5q31b08WQriCK7TE=;
        b=Eh24wZckl+J5lQ354MGGwh6dIpIuG9CT5Ug1406jQ0tiXocc5dFbfpMlfLPk82RpQ+
         vRocFCfYe2tvzhHRRZuF4qSZkVVfboyg5RiWAERmb0tWHUSDeOdYaeK41h47B9JY2uoi
         2V1iv9jXaJ59lc2nU9cAyo5II6vdTdWw/gZJtkzLM+jeWGqzXABJam44+vUtkJ4oAZHc
         LSu1bbt96KB7x0/6DZVSFgQntmO4q8n4meF4w7iBhlIceR6jaLPW48c741ICBAhw/JsW
         3yMQr5gO/g0JUJAe8dKBtog0FT1agnniy+2M/qQr+LICCB4iIvDvhYS/VrFbz0yYsIG2
         0PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256838; x=1691848838;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxdXHhZkRJEwrXWIjK24zGSqZZm5q31b08WQriCK7TE=;
        b=IAobQP9zoav73WhzXSOq3r68v0Pvo0OJ3fOR3a3OXN3/Tg4TbGLPVbN339w6eIfuDf
         TCXoA7Ek4aKO25QetRVMHRAD4hzBNaBYapBaVY3odhlu6doLTfSY7AJ/Mfu7GE1qNFo8
         dz3H3RlREo8kqFsnJ0AQeVBZqKLPg0o5C+Nv9Cy91Lo6pudNS7KbhPUsw+faerZgac0e
         fvOYKeZooioEhtyM0W0uNIJFnadEaMeQiwz+xA8h4JXKjNdmpINv7lJ2RhUaoWxGB7bT
         SYq1FxtoRKr6Xe4KEU6ylsZRB6e8UMMhay+031cz+l+t63DvfT1CqKx1lrxZD0HOQ76Z
         pHWg==
X-Gm-Message-State: ABy/qLaKxgwzRfOgPshYrtxrRv8WD2qkBRAfhP87F8T/+zK61V8Xwiuu
        Sx38DM3SHLObGuENpWlP0Idwyw==
X-Google-Smtp-Source: APBJJlGOxRKCXxOQ7XP4v5T40hTG7yjtzwRAIp3E+FnOlmRixjn2MTRPhkXRMGhal/O7WoTJ2GC+Kg==
X-Received: by 2002:a17:903:228b:b0:1b8:a70d:412a with SMTP id b11-20020a170903228b00b001b8a70d412amr1104745plh.67.1689256838037;
        Thu, 13 Jul 2023 07:00:38 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001b8ad8382a4sm6044735plb.216.2023.07.13.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:00:37 -0700 (PDT)
Date:   Thu, 13 Jul 2023 07:00:37 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Jul 2023 06:59:52 PDT (-0700)
Subject:     Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
In-Reply-To: <ZJwdZ_cStUp0cXyS@FVFF77S0Q05N>
CC:     arnd@kernel.org, davem@davemloft.net, keescook@chromium.org,
        peterz@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux@roeck-us.net, geert@linux-m68k.org, mingo@kernel.org,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Mark Rutland <mark.rutland@arm.com>
Message-ID: <mhng-0bca249b-95f1-4e3f-b241-f37835e1c623@palmer-ri-x1c9a>
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

On Wed, 28 Jun 2023 04:45:43 PDT (-0700), Mark Rutland wrote:
> On Wed, Jun 28, 2023 at 11:49:18AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> An otherwise correct change to the atomic operations uncovered an
>> existing bug in the sparc __arch_xchg() function, which is calls
>> __xchg_called_with_bad_pointer() when its arguments are unknown at
>> compile time:
>>
>> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
>>
>> This now happens because gcc determines that it's better to not inline the
>> function. Avoid this by just marking the function as __always_inline
>> to force the compiler to do the right thing here.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
>> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Aha; you saved me writing a patch! :)
>
> We should probably do likewise for all the other bits like __cmpxchg(), but
> either way:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Though I'm not sure that means a whole lot over here ;)

> Mark.
>
>> ---
>>  arch/sparc/include/asm/cmpxchg_32.h | 2 +-
>>  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
>> index 7a1339533d1d7..d0af82c240b73 100644
>> --- a/arch/sparc/include/asm/cmpxchg_32.h
>> +++ b/arch/sparc/include/asm/cmpxchg_32.h
>> @@ -15,7 +15,7 @@
>>  unsigned long __xchg_u32(volatile u32 *m, u32 new);
>>  void __xchg_called_with_bad_pointer(void);
>>
>> -static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>> +static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>>  {
>>  	switch (size) {
>>  	case 4:
>> diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
>> index 66cd61dde9ec1..3de25262c4118 100644
>> --- a/arch/sparc/include/asm/cmpxchg_64.h
>> +++ b/arch/sparc/include/asm/cmpxchg_64.h
>> @@ -87,7 +87,7 @@ xchg16(__volatile__ unsigned short *m, unsigned short val)
>>  	return (load32 & mask) >> bit_shift;
>>  }
>>
>> -static inline unsigned long
>> +static __always_inline unsigned long
>>  __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>>  {
>>  	switch (size) {
>> --
>> 2.39.2
>>

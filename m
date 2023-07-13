Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4E751807
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjGMF0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGMF0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:26:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A518B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:26:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d75a77b69052e-403b07cf5d0so3420661cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689225969; x=1691817969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wY6yIeUd5XkzBxHd4IVhXPW1XkMh9zkeZ+8KULrZkQQ=;
        b=qhnJNFc9Ui8w3ZntanV9x3uULKUEk3Gr1w8FQK6ywNaBqjjhHZ84BHRj+m/9CQ2T3r
         8kxUYjUrna+eGdhNFU9cr0Q9K4OFicGwuPEN5eWCLdGoxAU4b+8YRGlty0iqYswmyVHU
         +xCYkQwgaHIvqamfG7JVhESHM45XU/a95Inqp7f4p+R1SOnxe6Dlas6XPlySwW89xjrR
         kv5AdE5picQObmafQ6vGg0p/3e5NJcFk82cCmbvQDRQWAbQ9Md8jSv4j/JhwdHCAMY/L
         UMdNzfqghGKNA+l05uY+A/pNPyYP0tYF1VynCc6GKRUwpRb4g6ywO14FFXhHL1YEghYr
         //ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689225969; x=1691817969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6yIeUd5XkzBxHd4IVhXPW1XkMh9zkeZ+8KULrZkQQ=;
        b=FCOAqdw4FRuU3CEeVt3A3N9f5LzUWScuU2fZZQ/OWvBr28tPpS/csjdtGlFkG/S06D
         z69eRnZN9M0NCWQb2GJz4wvVbc65TkYax1j/yW8dDMs5WenTZ+htLXXJEvHe30O+F7rr
         kYTTVf/QoPnmoaJEAN+NqK+N2VjxBAgerfYGukVEdKC4ENKBkzoLIu+uUFips7AeYwaL
         pvb2YhosaoZIGb3bmmXE1XlL3UqbCU+8HRqUAbNeQCK2OJZ7Og1txZsu7114Y/3xT1e+
         zW10Mhe43kqQwJQ15mayAGUeQspPSPKNaH9jWwYO2w8XHLxDK3DUMDkJtS+pqHhGS/R8
         riQw==
X-Gm-Message-State: ABy/qLaMUr2ajcJ38xMTN+zWLfA8CS/rqdrH8daxROd1IGIsYY5QzapG
        b0B5UHZIWwgjvYi4LoXYZOI=
X-Google-Smtp-Source: APBJJlH2UNtTGC8nZZnk8cJsui63PsvCqbA2j22TBkK9asviiVC12PDgkQ98kSuFiNgAamwR3I443Q==
X-Received: by 2002:ac8:5c4f:0:b0:3fd:ec2e:cd75 with SMTP id j15-20020ac85c4f000000b003fdec2ecd75mr1101874qtj.15.1689225969635;
        Wed, 12 Jul 2023 22:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.53])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a001c00b00263258fda1bsm11745740pja.46.2023.07.12.22.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:26:08 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <7937b1c9-cde3-29ad-66dd-c95c4f0506ca@gmail.com>
Date:   Thu, 13 Jul 2023 13:26:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: entry: set a0 prior to syscall_handler
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
References: <20230711062202.3542367-1-CoelacanthusHex@gmail.com>
 <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
Content-Language: en-GB-large
In-Reply-To: <CAJF2gTRgXbEfQWiWtZtVNBDhpY2miG_ByHrVZF2fbfu60hCHcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/13 08:00, Guo Ren wrote:
> On Tue, Jul 11, 2023 at 2:22 AM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>> When we test seccomp with 6.4 kernel, we found errno has wrong value.
>> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
>> get ENOSYS. We got same result with 9c2598d43510 ("riscv: entry: Save a0
>> prior syscall_enter_from_user_mode()").
>>
>> Compared with x86 and loongarch's implementation of this part of the
>> function, we think that regs->a0 = -ENOSYS should be advanced before
>> syscall_handler to fix this problem. We have written the following patch,
>> which can fix this problem after testing. But we don't know enough about
>> this part of the code to explain the root cause. Hope someone can find
>> a reasonable explanation. And we'd like to reword this commit message
>> according to the explanation in v2
>>
>> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
>> Reported-by: Felix Yan <felixonmars@archlinux.org>
>> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
>> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
>> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> Tested-by: Felix Yan <felixonmars@archlinux.org>
>> ---
>>  arch/riscv/kernel/traps.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index f910dfccbf5d2..ccadb5ffd063c 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -301,6 +301,7 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>
>>                 regs->epc += 4;
>>                 regs->orig_a0 = regs->a0;
>> +               regs->a0 = -ENOSYS;
> Oh, no. You destroyed the a0 for syscall_handler, right? It's not
> reasonable. Let's see which syscall_handler needs a0=-ENOSYS.
> 
> Could you give out more detail on your test case?
> 

Our test case is here:

int main() {
  scmp_filter_ctx ctx;
  ctx = seccomp_init(SCMP_ACT_ALLOW);

  seccomp_rule_add_exact(ctx, SCMP_ACT_ERRNO(EAFNOSUPPORT), SCMP_SYS(socket), 2,
                         SCMP_CMP(0, SCMP_CMP_EQ, AF_NETLINK),
                         SCMP_CMP(2, SCMP_CMP_EQ, NETLINK_AUDIT));

  if (seccomp_load(ctx) < 0) {
    perror("seccomp_load");
    exit(EXIT_FAILURE);
  }

  int sock_fd1 = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
  if (sock_fd1 < 0) {
    printf("1st socket syscall failed with return value %d and errno %d (%s), which is unexpected\n",
           sock_fd1, errno, strerror(errno));
    seccomp_release(ctx);
    return 1;
  }
  printf("1st socket created successfully, as expected.\n");

  int sock_fd2 = socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
  if (sock_fd2 < 0) {
    printf("2nd socket syscall failed with return value %d and errno %d (%s).\n", sock_fd2, errno,
           strerror(errno));

    if (errno == EAFNOSUPPORT) {
      printf("2nd socket syscall failed with EAFNOSUPPORT, as expected.\n");
      seccomp_release(ctx);
      return 0;
    } else {
      printf("2nd socket syscall failed with unexpected errno, which is unexpected.\n");
      seccomp_release(ctx);
      return 1;
    }
  }
  printf("2nd socket created successfully, which is unexpected.\n");
  seccomp_release(ctx);

  return 2;
}

>>
>>                 riscv_v_vstate_discard(regs);
>>
>> @@ -308,8 +309,6 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>>
>>                 if (syscall < NR_syscalls)
>>                         syscall_handler(regs, syscall);
>> -               else
>> -                       regs->a0 = -ENOSYS;
>>
>>                 syscall_exit_to_user_mode(regs);
>>         } else {
>> --
>> 2.41.0
>>
> 
> 

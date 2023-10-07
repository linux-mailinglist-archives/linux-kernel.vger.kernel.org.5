Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBE7BC675
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbjJGJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjJGJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 05:36:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BFBC
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 02:36:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso202358a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696671393; x=1697276193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+mN4Fuw8Pq7u34N8Cg808+vgUyA4DE9f1nGy42Vw9Y=;
        b=BfLnVrchwUB7SSfGbuPhVktj+qVGz/BD/zIZMN5fLNX/SVxYc2wP7iARsjObqOJz61
         6THoGlpZk0lCgEpN2n7PENz7NGNO+EAwWfEGrtuM2MM3H+zR1/zAoy99XmNXaqVaS5xu
         hsPCG97xXqq3vGqHCpDaMIrpA/cuPmp+04k+N14cLHatjHP9xlfIjhInAEZW3G0C6y1o
         fw6fO4AdxtXhHveaOPLp2QdBuSjQT1zcMxfbTm9COsJDk7WnjpzJqnXjRAnRRpTTsQhn
         eHAG2dKfvmsDvCYe2P2XB/O6GEGppBoyvK59TWhwyXfQZzAy0TPS+M+LgtccIc9ORzLe
         VWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696671393; x=1697276193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+mN4Fuw8Pq7u34N8Cg808+vgUyA4DE9f1nGy42Vw9Y=;
        b=R2j6R+3xiYyFDskShf/lH9BgZnZ1dXDvb6gn5rHKXA3+HQqh4hn/xf0rxJCtgd8dEA
         qXYP85HaQUp3G9pAVroznYz8M4svnGUrK5r+QtgNGsbEvsXALmUvukiaRzgL+xeDWFRo
         z93Fz9uCO8tPwTVJFwIy7ow084WjCt7DXEc2bnw9TiSANQqI/3QBAPT9NCWe7SRfI/Jp
         Oi1xFYTpUngdtqzwJO1JBpnwW3QlYQOpffXcGd+DI02xQFO1S+s+/FtE+wQQBst0qQGb
         OVtLEqe1E9L4iYVdMQOC09PdhQ3aFyVI9g61jxXNAzzimObtG9RaYomxq1XTwBTfiMsE
         IcAA==
X-Gm-Message-State: AOJu0YxWjFhV8cRroyoSxSp6XEf2tlBg9OfY8twNlP4qkR9ToMwI2KWN
        At4dDVLO4szFO7mpG+JV+vG+wJzz6VV93FzWerA=
X-Google-Smtp-Source: AGHT+IEpyokVkR63nWM234tU0kyZnsFdXLBndERDqI3UKHwbaFiG3l8N6X/vxZ8zHrkQ4KDOVmBKf5O3yvpCM7MRsvA=
X-Received: by 2002:a05:6402:12cd:b0:530:f296:d446 with SMTP id
 k13-20020a05640212cd00b00530f296d446mr9529070edx.34.1696671393112; Sat, 07
 Oct 2023 02:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <202310071301.a5113890-oliver.sang@intel.com>
In-Reply-To: <202310071301.a5113890-oliver.sang@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 7 Oct 2023 11:36:26 +0200
Message-ID: <CAFULd4bUu=wVhH8AweOPycEw2QsbFWSjP8ytr7SM6Z5WLOdWsA@mail.gmail.com>
Subject: Re: [tip:x86/percpu] [x86/percpu] ca42563486: BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 8:16=E2=80=AFAM kernel test robot <oliver.sang@intel=
.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_pri=
ntk:Booting_the_kernel(entry_offset:#)" on:
>
> commit: ca4256348660cb2162668ec3d13d1f921d05374a ("x86/percpu: Use C for =
percpu read/write accessors")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/percpu
>
> [test failed on linux-next/master 0f0fe5040de5e5fd9b040672e37725b046e312f=
0]
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +------------------------------------------------------------------------=
--------------+------------+------------+
> |                                                                        =
              | 9a462b9eaf | ca42563486 |
> +------------------------------------------------------------------------=
--------------+------------+------------+
> | boot_successes                                                         =
              | 13         | 0          |
> | boot_failures                                                          =
              | 0          | 13         |
> | BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(en=
try_offset:#) | 0          | 13         |
> +------------------------------------------------------------------------=
--------------+------------+------------+

Since this is a randconfig (x86_64-randconfig-006-20231006), does it
mean that all other configs worked OK:

i386                             allmodconfig   gcc
i386                              allnoconfig   gcc
i386                             allyesconfig   gcc
i386         buildonly-randconfig-001-20231005   gcc
i386         buildonly-randconfig-002-20231005   gcc
i386         buildonly-randconfig-003-20231005   gcc
i386         buildonly-randconfig-004-20231005   gcc
i386         buildonly-randconfig-005-20231005   gcc
i386         buildonly-randconfig-006-20231005   gcc
i386                              debian-10.3   gcc
i386                                defconfig   gcc
i386                  randconfig-001-20231005   gcc
i386                  randconfig-002-20231005   gcc
i386                  randconfig-003-20231005   gcc
i386                  randconfig-004-20231005   gcc
i386                  randconfig-005-20231005   gcc
i386                  randconfig-006-20231005   gcc

and

x86_64                            allnoconfig   gcc
x86_64                           allyesconfig   gcc
x86_64                              defconfig   gcc
x86_64                randconfig-001-20231005   gcc
x86_64                randconfig-002-20231005   gcc
x86_64                randconfig-003-20231005   gcc
x86_64                randconfig-004-20231005   gcc
x86_64                randconfig-005-20231005   gcc
x86_64                randconfig-006-20231005   gcc
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc

are of interest to me. Assuming they are built with gcc-12, I wouldn't
immediately blame the compiler for the failure. Due to the nature of
the change, perhaps a weakness in the kernel has been found with some
obscure config setting. As said, my default Fedora 39 kernel (6.5.5),
built with gcc-13 works without any problems.

Also, does a successful report from yesterday [1] mean everything was OK?

[1] https://lore.kernel.org/lkml/202310060322.yeZgaj6Q-lkp@intel.com/

Uros.

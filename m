Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B700179017D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjIARbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjIARbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:31:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354CCDD;
        Fri,  1 Sep 2023 10:30:57 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7927f36120cso81095139f.1;
        Fri, 01 Sep 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693589457; x=1694194257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7Ic2JgCifJ9BR0gJc8OX6iWRD9HNnkepfgcfad3kDo=;
        b=fX3/IOFKa4wYzloFLDAIQsaGuP3u0+R5E5YCdaXxh4HDRF/n8KTjDNcJJR4nnq9D4c
         PSHVnL/ZDs+vO7deOy8WJddcaKblMykrG96ml1EXsYOjf2bdgMm5VTD3TbSM6OfIhOS2
         fMe5p5B1v0jE4e/DIKck8IB2CPRpGi9cLbnvWm6WXfZ/LxLTLIkzqH0jM4AUuSWW6yVO
         TO2Vxewe+ey2xffaoID72PNU8CZc9fEizck1MlY5s/Bqz9kpHcyVd7JzIIn/tktgyxps
         6+ZUJCkOxRuSzyrAeNnuo06G9P14xkNI/VYWdbYSh+CH8X4YnQmvc7b1KeAdolnv333w
         YcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693589457; x=1694194257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7Ic2JgCifJ9BR0gJc8OX6iWRD9HNnkepfgcfad3kDo=;
        b=fzj2pFaSplQq0P49wyX6VTAzaIyBET655xR2eHGmACQjQ//VbJb80SIomPQlsBcHpu
         Zl3QPc+vrPhzAF8nJ0ZFGKOBhUDROEdiYiyjoUPZajWpCWPA6LlUVd92yq3WknGGLHp+
         kPmqk1wioPm/UR8LGB2FIuNqLiJ+ABc85WHAnRCzof+y91e0KjjbHTXfBoMPRKyLKhAV
         XvRYr0RPWBY50xBcLA1BDgqGOIs/+k1WRw/sxFvMIlC7x/CpXq9/st+oAhphRabzGn4P
         uvSUP4dGPYeHEFFOz8PlUvKYFZP6r6Z0LK7AgR6CMucbSSlg+RWBTf1OKmXIv4xhjq3B
         1a9g==
X-Gm-Message-State: AOJu0Yyq2f9lIY64wSwq9eN1XYW078mzgG1djCS1ECbgnUYicUGqdm/9
        lc+bt1II47lScyg6F9U8p6o=
X-Google-Smtp-Source: AGHT+IG60rEwPMClyUpLxgIkdetUrkTvd12OeZpQuEmA5mPuJPh251Y1toBygAxAyHVb0OiLVFUbUA==
X-Received: by 2002:a6b:7f46:0:b0:791:2db5:c779 with SMTP id m6-20020a6b7f46000000b007912db5c779mr3826112ioq.10.1693589457075;
        Fri, 01 Sep 2023 10:30:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f23-20020a056602039700b007836252a084sm1178665iov.48.2023.09.01.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 10:30:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 10:30:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Message-ID: <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613224545.902376621@linutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 14, 2023 at 01:39:46AM +0200, Thomas Gleixner wrote:
> Initializing the FPU during the early boot process is a pointless
> exercise. Early boot is convoluted and fragile enough.
> 
> Nothing requires that the FPU is set up early. It has to be initialized
> before fork_init() because the task_struct size depends on the FPU register
> buffer size.
> 
> Move the initialization to arch_cpu_finalize_init() which is the perfect
> place to do so.
> 
> No functional change.
> 
> This allows to remove quite some of the custom early command line parsing,
> but that's subject to the next installment.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

The backport of this patch into chromeos-5.10 and chromeos-5.15 via stable
relase merges is causing various Chromebooks (not all of them) to crash
early during boot. Subsequent fixes have not addressed the problem for us,
so we already reverted the patch from chromeos-5.15 and will revert it
from chromeos-5.10 as well.

I don't know if this is a Chromebook specific problem, or if it affects
mainline, so this is just a heads-up in case others experience similar
problems.

Thanks,
Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF5779B17
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHKXQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKXQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:16:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EE100
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+9PwEm4hEDzSTwbmAJI2he99h1fCWhCKVGttfWAvx9c=; b=mB7EKmwgCqBIPrMV/0uv0ERwjq
        mF1+mwgs4MushF4PIaR7iQZRlwUdUBynVLacl/2zYKiduhPxeyv9//1bEdDkAgCwcFWKfF1Bn/gLv
        YED9Y7AzyIiIBDnQdB3gtAb94acer0DKUspYF6AfEEOf6CwJOwZ4AeDZ/pH+vYaHae9M33keDcNkW
        u/DmrBn/wTjku6gAdfgdxJqiRGLhv9ZKl3rdnMYfVyIAYI3xJdItCLpzLJJJ7fStX49UEWg0DSfW2
        iiBXJLT6CQQi+PWzgp0RVqHsoDKldePkCRAisPjO18Iu2vr0dZP6XvfYyKvaR0+EqCi18lw18l4JB
        1QGS1qzQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUbMf-00BsoJ-1E;
        Fri, 11 Aug 2023 23:16:17 +0000
Message-ID: <be96aa3f-f7df-8fa9-02d6-fe26cc01d555@infradead.org>
Date:   Fri, 11 Aug 2023 16:16:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Build failure in 6.5-rcX ?
Content-Language: en-US
To:     Andrew Randrianasulu <randrianasulu@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+rFky5xK35402EGQ-6VqxT-arR7SWLAcp2PyB1xK9ZGRqhs2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/23 13:39, Andrew Randrianasulu wrote:
> I was trying to crosscompile linux git
> 
> 9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
> 
> Unfortunately I got this error:
> 
> ====
> bash-5.1$ make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu-
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CHK     kernel/kheaders_data.tar.xz
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.kallsyms1
> arch/x86/kernel/irq.o: In function `__common_interrupt':
> irq.c:(.text+0x1727): undefined reference to `irq_regs'
> irq.c:(.text+0x172f): undefined reference to `irq_regs'
> irq.c:(.text+0x179a): undefined reference to `irq_regs'
> arch/x86/kernel/irq.o: In function `__sysvec_x86_platform_ipi':
> irq.c:(.text+0x1897): undefined reference to `irq_regs'
> irq.c:(.text+0x189f): undefined reference to `irq_regs'
> arch/x86/kernel/irq.o:irq.c:(.text+0x194a): more undefined references
> to `irq_regs' follow
> make[2]: *** [scripts/Makefile.vmlinux:36: vmlinux] Ошибка 1
> make[1]: *** [/dev/shm/linux-2.6/Makefile:1250: vmlinux] Ошибка 2
> make: *** [Makefile:234: __sub-make] Ошибка 2
> 

This probably isn't going to help much, but I can't reproduce this build error.
I tried native x86_64 build, LLVM build, and command-wise, an x86_64 cross build,
all with no problems.


> ====
> 
> config attached.
> 
> I use binutils 2.25.1 and gcc 7.5.0 targeting x86_64-unknown-linux-gnu-
> 
> so my compile line was
> 
>  make ARCH=x86_64 CROSS_COMPILE=x86_64-unknown-linux-gnu- -j8
> 
> after adding crosscompiler into PATH
> 
> I tried to rebuild with make clean, but issue still here.
> 
> I am not subscribed to LKML, so please CC me if you have any idea what
> I did wrong ...
> (I try to avoid recompiling whole of gcc over new binutils going from
> 2.24-something to 2.25.1, may be my fault lies here ..? I hoped those
> two versions of binutils close enough for just replacing binutils)

-- 
~Randy

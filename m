Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541737D9850
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbjJ0Mc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbjJ0Mcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:32:53 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au (icp-osb-irony-out4.external.iinet.net.au [203.59.1.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4716121;
        Fri, 27 Oct 2023 05:32:47 -0700 (PDT)
Received: from gateway.pc5.atmailcloud.com (HELO mqr.i-0d0b1d0ec847e0a83) ([13.54.26.16])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 27 Oct 2023 20:32:41 +0800
Received: from CMR-KAKADU04.i-07b63d9bd7300620c by MQR.i-0d0b1d0ec847e0a83 with esmtps
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qwM13-0000eV-0h;
        Fri, 27 Oct 2023 12:32:41 +0000
Received: from [203.87.15.156] (helo=[192.168.0.22])
         by CMR-KAKADU04.i-07b63d9bd7300620c with esmtpsa
        (envelope-from <gregungerer@westnet.com.au>)
        id 1qwM12-00052V-2c;
        Fri, 27 Oct 2023 12:32:40 +0000
Message-ID: <d1b2a270-7b6b-4e32-8e68-9ee1a2ef6bdf@westnet.com.au>
Date:   Fri, 27 Oct 2023 22:32:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] kbuild: generate KSYMTAB entries by modpost
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
References: <20230514152739.962109-1-masahiroy@kernel.org>
 <20230514152739.962109-17-masahiroy@kernel.org>
 <1fac9d12-2ec2-4ccb-bb81-34f3fc34789e@westnet.com.au>
 <CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com>
From:   Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <CAK7LNASQ_W5Yva5a4Xx8E2EYi-tN7x3OHgMFhK+93W+BiX1=9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-atmailcloud-spam-report: Action: no action
X-Cm-Analysis: v=2.4 cv=ObheTDfY c=1 sm=1 tr=0 ts=653bade8 a=Qq7imNNZi2wOFNr6RxuhDA==:117 a=Qq7imNNZi2wOFNr6RxuhDA==:17 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=8-D65JXZAAAA:8 a=VwQbUJbxAAAA:8 a=FP58Ms26AAAA:8 a=ccNvEddV17TnxeFARSoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-Cm-Envelope: MS4xfFWciNC6NEmBkMzFIH+fk7GHOEKKILrzX3envwWo2snlH95fADdIJk+VvwsMfhokVcSddSOo6qvarE5TLwl8CLT3pDPN4bqpQ+L/I5AkYBB0Y/QrRiHn yBLWXXf3Zij7Xlg9pyWxyrBth3sg8sQfa1RA5pxde/Pvz59rOqGZXXEITaSe3XJrwJ0FECGdclgXYQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/23 19:56, Masahiro Yamada wrote:
> On Fri, Oct 27, 2023 at 1:30 PM Greg Ungerer <gregungerer@westnet.com.au> wrote:
>>
>> Hi Masahiro,
>>
>> On 15/5/23 01:27, Masahiro Yamada wrote:
>>> Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
>>> CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
>>> whether the EXPORT_SYMBOL() is placed in *.c or *.S.
>>>
>>> This commit applies a similar approach to the entire data structure of
>>> EXPORT_SYMBOL() for further cleanups. The EXPORT_SYMBOL() compilation
>>> is split into two stages.
>>>
>>> When a source file is compiled, EXPORT_SYMBOL() is converted into a
>>> dummy symbol in the .export_symbol section.
>>>
>>> For example,
>>>
>>>       EXPORT_SYMBOL(foo);
>>>       EXPORT_SYMBOL_NS_GPL(bar, BAR_NAMESPACE);
>>>
>>> will be encoded into the following assembly code:
>>>
>>>       .section ".export_symbol","a"
>>>       __export_symbol__foo:
>>>               .asciz ""
>>>               .balign 8
>>>               .quad foo
>>>       .previous
>>>
>>>       .section ".export_symbol","a"
>>>       __export_symbol_gpl_bar:
>>>               .asciz "BAR_NAMESPACE"
>>>               .balign 8
>>>               .quad bar
>>>       .previous
>>>
>>> They are just markers to tell modpost the name, license, and namespace
>>> of the symbols. They will be dropped from the final vmlinux and modules
>>> because the *(.export_symbol) will go into /DISCARD/ in the linker script.
>>>
>>> Then, modpost extracts all the information about EXPORT_SYMBOL() from the
>>> .export_symbol section, and generates C code:
>>>
>>>       KSYMTAB_FUNC(foo, "", "");
>>>       KSYMTAB_FUNC(bar, "_gpl", "BAR_NAMESPACE");
>>>
>>> KSYMTAB_FUNC() (or KSYMTAB_DATA() if it is data) is expanded to struct
>>> kernel_symbol that will be linked to the vmlinux or a module.
>>>
>>> With this change, EXPORT_SYMBOL() works in the same way for *.c and *.S
>>> files, providing the following benefits.
>>>
>>> [1] Deprecate EXPORT_DATA_SYMBOL()
>>>
>>> In the old days, EXPORT_SYMBOL() was only available in C files. To export
>>> a symbol in *.S, EXPORT_SYMBOL() was placed in a separate *.c file.
>>> arch/arm/kernel/armksyms.c is one example written in the classic manner.
>>>
>>> Commit 22823ab419d8 ("EXPORT_SYMBOL() for asm") removed this limitation.
>>> Since then, EXPORT_SYMBOL() can be placed close to the symbol definition
>>> in *.S files. It was a nice improvement.
>>>
>>> However, as that commit mentioned, you need to use EXPORT_DATA_SYMBOL()
>>> for data objects on some architectures.
>>>
>>> In the new approach, modpost checks symbol's type (STT_FUNC or not),
>>> and outputs KSYMTAB_FUNC() or KSYMTAB_DATA() accordingly.
>>>
>>> There are only two users of EXPORT_DATA_SYMBOL:
>>>
>>>     EXPORT_DATA_SYMBOL_GPL(empty_zero_page)    (arch/ia64/kernel/head.S)
>>>     EXPORT_DATA_SYMBOL(ia64_ivt)               (arch/ia64/kernel/ivt.S)
>>>
>>> They are transformed as follows and output into .vmlinux.export.c
>>>
>>>     KSYMTAB_DATA(empty_zero_page, "_gpl", "");
>>>     KSYMTAB_DATA(ia64_ivt, "", "");
>>>
>>> The other EXPORT_SYMBOL users in ia64 assembly are output as
>>> KSYMTAB_FUNC().
>>>
>>> EXPORT_DATA_SYMBOL() is now deprecated.
>>>
>>> [2] merge <linux/export.h> and <asm-generic/export.h>
>>>
>>> There are two similar header implementations:
>>>
>>>     include/linux/export.h        for .c files
>>>     include/asm-generic/export.h  for .S files
>>>
>>> Ideally, the functionality should be consistent between them, but they
>>> tend to diverge.
>>>
>>> Commit 8651ec01daed ("module: add support for symbol namespaces.") did
>>> not support the namespace for *.S files.
>>>
>>> This commit shifts the essential implementation part to C, which supports
>>> EXPORT_SYMBOL_NS() for *.S files.
>>>
>>> <asm/export.h> and <asm-generic/export.h> will remain as a wrapper of
>>> <linux/export.h> for a while.
>>>
>>> They will be removed after #include <asm/export.h> directives are all
>>> replaced with #include <linux/export.h>.
>>>
>>> [3] Implement CONFIG_TRIM_UNUSED_KSYMS in one-pass algorithm (by a later commit)
>>>
>>> When CONFIG_TRIM_UNUSED_KSYMS is enabled, Kbuild recursively traverses
>>> the directory tree to determine which EXPORT_SYMBOL to trim. If an
>>> EXPORT_SYMBOL turns out to be unused by anyone, Kbuild begins the
>>> second traverse, where some source files are recompiled with their
>>> EXPORT_SYMBOL() tuned into a no-op.
>>>
>>> We can do this better now; modpost can selectively emit KSYMTAB entries
>>> that are really used by modules.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>
>> This breaks building kernels with an m68k-uclinux-gcc toolchain that have
>> modules configured. Before this change they built and ran fine.
>> They build and run fine if CONFIG_MODULES is not set.
>>
>> A few hundred errors like this spew out:
>>
>>       scripts/mod/modpost -o Module.symvers -T modules.order vmlinux.o
>>       ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
>>       ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
>>       ERROR: modpost: vmlinux: .export_symbol section references '', but it does not seem to be an export symbol
>>       ...
> 
> 
> 
> Where can I download a prebuilt m68k-uclinux-gcc?

https://sourceforge.net/projects/uclinux/files/Tools/m68k-uclinux-tools-20231026.tar.xz/download

Regards
Greg



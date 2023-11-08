Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B277E5296
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjKHJVS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 04:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjKHJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:21:14 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A731722
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:21:08 -0800 (PST)
Received: from loongson.cn (unknown [209.85.128.171])
        by gateway (Coremail) with SMTP id _____8DxVugAU0tl8P43AA--.9356S3;
        Wed, 08 Nov 2023 17:21:05 +0800 (CST)
Received: from mail-yw1-f171.google.com (unknown [209.85.128.171])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxG9z8Uktlve07AA--.65044S3;
        Wed, 08 Nov 2023 17:21:01 +0800 (CST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7d9d357faso77450857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:21:01 -0800 (PST)
X-Gm-Message-State: AOJu0YxgkVyBpetCcnIg0v1eIGh0U8eCxzB5HfPejfWeZhArCq3s35Di
        nSNkesLMIZXmyA469UsHlNPbF8vsr1g9/Lq9Gikvzg==
X-Google-Smtp-Source: AGHT+IExsJoTzNlh7EfTY60IiHlh4S/fXfmHBvUaYttA31jC9yG7uDjmf540fZkAd+lZKupJr7U5MJ5u1nlvvNP8DzQ=
X-Received: by 2002:a25:f453:0:b0:da3:613:fba6 with SMTP id
 p19-20020a25f453000000b00da30613fba6mr1293686ybe.0.1699435259493; Wed, 08 Nov
 2023 01:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20231108040447.288870-1-wangrui@loongson.cn> <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
In-Reply-To: <d32d8a26dcd75a840727cdb50546b621d34d326b.camel@xry111.site>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 8 Nov 2023 17:20:48 +0800
X-Gmail-Original-Message-ID: <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com>
Message-ID: <CAHirt9jQHTRGdv4rShgvWHEbG1vzuLkNDbxLP7x4eMtuB3BB5g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Disable module from accessing external data directly
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8AxG9z8Uktlve07AA--.65044S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr47tw48tF15tw18Kw1fZrc_yoW5Aw4rpa
        97GFyjgF47Zr4UArn2kFs2qa1Yga1rZrWrGFyDtr15ZF909ry8ZwsaqrZFgF42k3sIv348
        uw48AFy2934DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YiiDUUUUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 4:37 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2023-11-08 at 12:04 +0800, WANG Rui wrote:
> > When compiling module with GCC, the option `-mdirect-extern-access` is
> > disabled by default. The Clang option `-fdirect-access-external-data`
> > is enabled by default, so it needs to be explicitly disabled.
>
> I'm wondering why it's enabled by default.
>
> For this simple test case:
>
> extern char **environ;
>
> int main()
> {
>   __builtin_printf("%10s\n", environ[0]);
> }
>
> With Clang 17.0.4 and "clang t1.c -S -O2", it compiles to:
>
> main:
>         addi.d  $sp, $sp, -16
>         st.d    $ra, $sp, 8
>         pcalau12i       $a0, %got_pc_hi20(environ)
>         ld.d    $a0, $a0, %got_pc_lo12(environ)
>         ld.d    $a0, $a0, 0
>         ld.d    $a1, $a0, 0
>         pcalau12i       $a0, %pc_hi20(.L.str)
>         addi.d  $a0, $a0, %pc_lo12(.L.str)
>         bl      %plt(printf)
>         move    $a0, $zero
>         ld.d    $ra, $sp, 8
>         addi.d  $sp, $sp, 16
>         ret
>
> So GOT is used for accessing the external variable environ.  With "clang
> t1.c -S -O2 -fdirect-access-external-data", we get:
>
> main:
>         addi.d  $sp, $sp, -16
>         st.d    $ra, $sp, 8
>         pcalau12i       $a0, %pc_hi20(environ)
>         addi.d  $a0, $a0, %pc_lo12(environ)
>         ld.d    $a0, $a0, 0
>         ld.d    $a1, $a0, 0
>         pcalau12i       $a0, %pc_hi20(.L.str)
>         addi.d  $a0, $a0, %pc_lo12(.L.str)
>         bl      %plt(printf)
>         move    $a0, $zero
>         ld.d    $ra, $sp, 8
>         addi.d  $sp, $sp, 16
>         ret
>
> then the linked binary triggers a SIGBUS.  Ideally this should be
> detected by the linker at link time, but currently the BFD linker fails
> to detect this error (FWIW this flaw is caused by a really nasty method
> for the medium code model implementation).  So to me -fno-direct-access-
> external-data is the default.  I also grepped for -fdirect-access-
> external-data in the kernel building system but I've not found any
> match.
>
> Are you using a different version of Clang, or maybe Clang has some
> configuration-time option to make -fdirect-access-external-data the
> default?

The clang enables `direct-access-external-data` by default in PIC and
disables it by default in no-PIC. This also applies to PIE. [1]

I found that clang PIE in different default states for different
environments. For instance, cross-compile is off, while native-compile
is on.

>
> Note that to translate a TU for a normal (dynamically-linked user-space)
> executable on LoongArch Linux, -fdirect-access-external-data should not
> be used (because copy relocation is now considered a bad idea and we'll
> not support it for a new architecture).  Fangrui?
>
> -fdirect-access-external-data can be used in KBUILD_CFLAGS_KERNEL for
> avoiding GOT in the main kernel image, OTOH.

I also saw that compiling vmlinux already includes the `-fno-PIE`
option, which for clang is `direct-access-external-data` enabled.

>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>

[1] https://github.com/llvm/llvm-project/blob/llvmorg-17.0.4/clang/lib/Frontend/CompilerInvocation.cpp#L1654-L1659

-- 
WANG Rui


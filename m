Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A77C5E16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbjJKUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJKUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:13:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2413C4;
        Wed, 11 Oct 2023 13:12:53 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.201]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8XkP-1rd3321Guf-014Paf; Wed, 11 Oct 2023 22:10:25 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9DCA03F840;
        Wed, 11 Oct 2023 22:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1697055016; bh=5Fr/47OcVCuPllaYQgCL+zdi7dPjAjL3MNWZhdULIc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=5WImRH0w1AH69SJDHrWAjBqhWAtqvRtsHukVpQNPqSKcrMzjMa8QWAh7Sy2kg/Nii
         cNKr21hCCqvUTUPfee6kxSqzD2EW093Yu8e5H/j30R+OnBFpAlQ1Wl4y/NvNCujB6z
         7ZYgYAxnN9X+ortJfAYnkbWwxYwRsiCYWqBUTebE=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id ABC4A251E; Wed, 11 Oct 2023 22:10:14 +0200 (CEST)
Date:   Wed, 11 Oct 2023 22:10:14 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 4/5] kbuild: unify vdso_install rules
Message-ID: <ZScBJp-nen5wDRkT@bergen.fjasle.eu>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231009124210.1064021-4-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:GUfrfLlCUzJuMEjs4zRXdY1OuzE+qTNGx7LxKM1S1e9ReRxprWw
 QTcaTBx+t0EkTRqYWkYL67T9+ycHGZaqicx6qJ56Gqgjv4SNCVgkolt4r+0ZEgWqOlo+M4w
 O8j6dJv9DPnZVx+Re6NhFwDsF9/Jz5Qda20FlFD/v/59oC+e5T2V9+yc9jzxg8tnQCrfW6W
 OrXnxMb3y1nL8PBSSLcbA==
UI-OutboundReport: notjunk:1;M01:P0:qNyXQk5UllI=;y8DdQd/Ft0LT6jsPRdxBN+G4s3G
 /dPQre51e0CezAsPaxbY0go4zVXCq8l3VMpkyVphD4Ebwcnjz+yzK136vs00yapmqCWX36hT/
 NXmFHSZPlveUU24GlvQpwQSfgBPFheOuYdWZ35ro+lccjF8o31Ku/tPMdS9Pujb2cTCvxqNt1
 YOrApfMBQsAPir8jbcWo2AgKTVph8uZ3jsZ3LCAcswn+cdhrq42B/LqbewNWUjiiwo5NovQ7X
 KczDAQqgpbn9krt6MUFokSGSf3DvdFlDVMUKZGZgwbrZfOPuw/cOsdtbQ2xOIFPb8FOeGaU4s
 RgBvvpLkUenKwOP64pryV/oQxby40IsynMJSdNBalDtN4+OBMp7xTvp4Yf3o+vZDiq4u+MezG
 QfVIdR7NUXg8uRejQT7mhDc1iQdstXDgUTjxcYZ1i4wAdVyM+mlbmvg8RMHvE3TEUtYJu0ncX
 tRgSfaauZifFKtrHuhbLXLavl3huWpgpu0RWAGz81ZsUpOhWCICM/mHV4FcpbP5T9CWTiBkis
 mPZHClPSJs65ACtPtoxIsDkhpilDa5GshzZto25RU4ZIGsjGoqzVgp0iOnsXVecB/pM4AUuou
 mwDo2Ma5gAipHcCF5iRss67DeGqV71qkwu/ptgiyW2DxZvLGkUr/h6qanW5CpLU4MHrTsm8hK
 Cp+rJaZ5AYXBRGNj214Og75oBWIjsHuD4DYBxg8+rXMpyOx+x5ZtTkbWOnLFu8FwD89cmvH9v
 KY3zlZ2a/om9/rt6NHMJllhWVKYOei5LUAspSIVv6BwmkUXg+6sT/x1OpzQmUUNpemJ733l0v
 CkyBea3IC9dW/+Z7vwOLn8v7m049Ze4jE2lDVYGp9qKvbSMV/X2j9My9xYcX70Pb5JlP7OLGG
 PMQHHGIOP5jvwVQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Oct 2023 21:42:09 GMT, Masahiro Yamada wrote:
> Currently, there is no standard implementation for vdso_install,
> leading to various issues:
> 
>  1. Code duplication
> 
>     Many architectures duplicate similar code just for copying files
>     to the install destination.
> 
>     Some architectures (arm, sparc, x86) create build-id symlinks,
>     introducing more code duplication.
> 
>  2. Accidental updates of in-tree build artifacts
> 
>     The vdso_install rule depends on the vdso files to install.
>     It may update in-tree build artifacts. This can be problematic,
>     as explained in commit 19514fc665ff ("arm, kbuild: make
>     "make install" not depend on vmlinux").
> 
>  3. Broken code in some architectures
> 
>     Makefile code is often copied from one architecture to another
>     without proper adaptation or testing.
> 
>     The previous commits removed broken code from csky, UML, and parisc.
> 
>     Another issue is that 'make vdso_install' for ARCH=s390 installs
>     vdso64, but not vdso32.
> 
> To address these problems, this commit introduces the generic vdso_install.
> 
> Architectures that support vdso_install need to define vdso-install-y
> in arch/*/Makefile.
> 
> vdso-install-y lists the files to install. For example, arch/x86/Makefile
> looks like this:
> 
>   vdso-install-$(CONFIG_X86_64)           += arch/x86/entry/vdso/vdso64.so.dbg
>   vdso-install-$(CONFIG_X86_X32_ABI)      += arch/x86/entry/vdso/vdsox32.so.dbg
>   vdso-install-$(CONFIG_X86_32)           += arch/x86/entry/vdso/vdso32.so.dbg
>   vdso-install-$(CONFIG_IA32_EMULATION)   += arch/x86/entry/vdso/vdso32.so.dbg
> 
> These files will be installed to $(MODLIB)/vdso/ with the .dbg suffix,
> if exists, stripped away.
> 
> vdso-install-y can optionally take the second field after the colon
> separator. This is needed because some architectures install vdso
> files as a different base name.
> 
> The following is a snippet from arch/arm64/Makefile.
> 
>   vdso-install-$(CONFIG_COMPAT_VDSO)      += arch/arm64/kernel/vdso32/vdso.so.dbg:vdso32.so
> 
> This will rename vdso.so.dbg to vdso32.so during installation. If such
> architectures change their implementation so that the file names match,
> this workaround will go away.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks for cleaning this up!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

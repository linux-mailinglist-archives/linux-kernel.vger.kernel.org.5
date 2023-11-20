Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459F07F127A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjKTLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjKTLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:52:52 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F29E9F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:52:47 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6AF3940E0176;
        Mon, 20 Nov 2023 11:52:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HXxpPNQd3fZY; Mon, 20 Nov 2023 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700481162; bh=ITi3Gn+m3vTTDynqZAFETeYNR+5doeRxRkLicXZ5pNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5zCaZK53qu3MRozLRxvKT2tUip1HALtua9N58GpmZ3NayN6S4TMBhMfPQMYb04CO
         svVjWrV8YSvUuiNNbD16FdQWv2RAwGmZxaF86P4pVrvHk/NlX6n0laeV6L85raIBnN
         gN0SFE5P9FNs5rvQ06Xb200hVC44euHfn/inpkCwcN/WmWvHdG611Iy6km581AnEQP
         vttiR8c7GSp6Oz1TBpFud46FIn86x6X/EdWFzZG5FtnkTjb4COTWiD91UDIHLtCgRY
         2gJUovI0B1NrbhRuFzTDXc6322PzqayNDDUOdz7SB9qdO3MkG0fU1kwBjjehtNCvlY
         dF4mRv49K9DhPgwwDV9L2xJTbqwnFcVsu7Yb+/8OrsPw3AG+f8/Xcadks9dSo+ZhWA
         lZ8KxlquUk/rMWib7aiuv+5xI36bBoXrOIRNQHUeZqKoQUCiRuflMpab+g1aPgz7yb
         iGGZ37USmgXRyF2dBrggZ9n92Xo6QWiUJSIYIxdcChUOYvNC2uDyQnJiO5tIembhSY
         mVndbw/bhkfago0IyTQ+tYc7ekGx32QWwR15aPripvC4sKaZlArhcKdJV0mHVT0E4q
         P5164PMCQBnUlEIzLTDSoIFslOf/3CTN5SWB7aNrMkil9BdPTSr+4IVliJb87peY3I
         2Crc6uAnnDf6JZPjFx0xgkLA=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0E4E40E0031;
        Mon, 20 Nov 2023 11:52:25 +0000 (UTC)
Date:   Mon, 20 Nov 2023 12:52:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231120115220.GEZVtIdEcA5z1Gxdwc@fat_crate.local>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk>
 <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 04:50:06PM -0500, Linus Torvalds wrote:
> Sadly, we don't seem to have any obvious #define for "this is not real
> kernel code". We just have a lot of ad-hoc tricks, like removing
> compiler flags and disabling things like KASAN etc on a file-by-file
> (or directory) basis.
> 
> The purgatory code isn't exactly boot-time code, but it's very similar
> - it's kind of a limited environment that runs at crash time to load a
> new kernel.

So I've been trying to do a proper and clean kernel proper from "other
objects" split by not allowing kernel proper crap from getting linked
into those other objects.

Because the same thing happens here: the sha256.o object gets included
from kernel proper:

$(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
        $(call if_changed_rule,cc_o_c)

and that object has the alternatives sections:

  [ 7] .altinstructions  PROGBITS         0000000000000000  00000be8
       000000000000002a  0000000000000000   A       0     0     1
  [ 8] .rela.altins[...] RELA             0000000000000000  00001190
       0000000000000090  0000000000000018   I      16     7     8
  [ 9] .altinstr_re[...] PROGBITS         0000000000000000  00000c12
       000000000000000f  0000000000000000  AX       0     0     1

and in it there are calls to rep_movs_alternative which the linker tries
to resolve, leading to that failure.

And we don't need those damn sections and we can simply do objcopy
--remove-section but then more sh*t happens, see end of mail.

So I'd really like for us to have a rule (or a couple of rules) which
clarify how other objects should include kernel proper stuff. Because it
is a mess currently. Pretty much every time we try to include some stuff
from kernel proper, those other builds fail.

I've been trying to disentangle the compressed kernel on x86 too, this
way, and we have had some success in defining separate facilities which
can be shared by others:

arch/x86/include/asm/shared/

but it needs a lot of work and policing... :-\

So I'm open to ideas...

Thx.

arch/x86/purgatory/purgatory.ro: in function `sha256_transform_blocks':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:123:(.text+0x801): undefined reference to `__fentry__'
ld: /home/boris/kernel/5th/linux/lib/crypto/sha256.c:132:(.text+0xfde): undefined reference to `__x86_return_thunk'
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_update':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:135:(.text+0x1005): undefined reference to `__fentry__'
ld: /home/boris/kernel/5th/linux/lib/crypto/sha256.c:137:(.text+0x1071): undefined reference to `__x86_return_thunk'
ld: arch/x86/purgatory/purgatory.ro: in function `__sha256_final':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:141:(.text+0x10f1): undefined reference to `__fentry__'
ld: /home/boris/kernel/5th/linux/lib/crypto/sha256.c:144:(.text+0x1204): undefined reference to `__x86_return_thunk'
ld: arch/x86/purgatory/purgatory.ro: in function `sha256_final':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:147:(.text+0x1295): undefined reference to `__fentry__'
ld: arch/x86/purgatory/purgatory.ro: in function `sha224_final':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:153:(.text+0x12c5): undefined reference to `__fentry__'
ld: arch/x86/purgatory/purgatory.ro: in function `sha256':
/home/boris/kernel/5th/linux/lib/crypto/sha256.c:159:(.text+0x12f5): undefined reference to `__fentry__'
ld: /home/boris/kernel/5th/linux/lib/crypto/sha256.c:165:(.text+0x13bd): undefined reference to `__x86_return_thunk'
ld: /home/boris/kernel/5th/linux/lib/crypto/sha256.c:165:(.text+0x13f7): undefined reference to `__stack_chk_fail'
make[4]: *** [arch/x86/purgatory/Makefile:92: arch/x86/purgatory/purgatory.chk] Error 1
make[3]: *** [scripts/Makefile.build:480: arch/x86/purgatory] Error 2
make[2]: *** [scripts/Makefile.build:480: arch/x86] Error 2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

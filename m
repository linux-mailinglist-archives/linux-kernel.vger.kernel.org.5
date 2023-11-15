Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C97B7ECB02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKOTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKOTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:10:08 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB537C7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:10:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7BFBA40E0032;
        Wed, 15 Nov 2023 19:10:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sd4vaiG5L_sC; Wed, 15 Nov 2023 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700075400; bh=2L6bBSOEIxLUM46VfhXj4EAqxacbXr1fxz8KBrPopbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yf7mrVH5CHxhNc3AhayfwLGYL/ttPb2RRBXH+bgaDFD2ffg6OXfhuwMCkF4Id2YgT
         tQB1w+dGpmU4ictK0YEp2r6s1onnnsiTxzskS2GugGiAzsE4xqI5rbApmryGjFCLlj
         +zh13Rhgy8POL0Mv374xo2XwE1O1cMscN6X2Z/kOMi65vuoqtzk7mnLLaqnlvbuCUs
         94YdHRZmkOcIOAIkY+7YxEBPzC1/ZQulZ4U4GkogqwHCNZtwaAMkwLDxdQ+NBMw0hB
         LGBweNG7Kkhu7QNnXeok6/0+xFY6XK/8uT5z5jRVpgZJSgwSNBCq2ygD6iujKrM4g0
         Z1/JQzCvDyMFUmtPcxbio8T+MElUQ5J35q/JJnDYSkBwB/DX+cGKyHeJ2YxCk7GOE5
         kZSkIqDpcyIH2DaDk94soxLEhjrr+Ad/lIrWK9xc38M9Ym1HZQz0VzSH/zCMShwdvB
         OujD1HHUgnufgSjoAJILTMIm08XdxaBq+8ZbC0bwYZfiQenvjL2tLnhREWJjgsFsf6
         DUqcYYJUVwabqpRgkE51nUI9S39xHigDx6C2fZwKlsIqrylQvHBp8uZ7osRlcwGHpT
         lS22IDeests0T5pnIBinaOAv7Rb8PTX6UZoCH6gEIdkoSBf6vN3P085YEjlu/9XPmy
         wdnEHSfN8oO5DMKoTgFhzzOY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E30E040E0030;
        Wed, 15 Nov 2023 19:09:43 +0000 (UTC)
Date:   Wed, 15 Nov 2023 20:09:38 +0100
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
Message-ID: <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 01:38:18PM -0500, Linus Torvalds wrote:
> It's probably completely broken. I particularly worry about "memcpy()"
> being used *during* the instruction rewriting, so the whole approach
> with ALTERNATIVE() is probably entirely broken.

Should we define an alternative_memcpy() which is used *only* during
rewriting so that this becomes a non-issue?

> But I'm cc'ing Borislav, because we've talked about the whole "inline
> memcpy() with alternatives" before, so maybe this gives Borislav some
> ideas for how to do it right.

Yours looks simple enough and makes sense. Lemme poke at it a bit in the
coming days and see what happens.

> Borislav, see
> 
>     https://lore.kernel.org/all/CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com/
> 
> for some truly crazy code generation by gcc.

Yeah, lemme show that to gcc folks. That asm is with your compiler,
right? Version?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177527EF285
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjKQMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjKQMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:50 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF131BDC;
        Fri, 17 Nov 2023 04:18:36 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A684240E0032;
        Fri, 17 Nov 2023 12:18:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6UHlTXeIIHUw; Fri, 17 Nov 2023 12:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700223508; bh=uhqSMbAQ6tKqqSsHNkN4uyWbdflMXxxQkEYG27efuk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYfdUEeXscHP0Wfu7zGGHOAUc211uhIaY+OTbQcF9SWKsdU2+J4dftB1lAvWxGkr+
         XDFiY9DOps5b4H4avJA/sMA1O9E38LPy0XtrVFPdCggIQEEns82iasP/gMpJ75O8Bq
         +6IYu22DjziXl+MTzldfmfjTG8inMP/1QEN2ndd1ijcdUHun7zYNhuYIdwgxN/rcxR
         8c6WC9naejeLD4dgr3+rEk23kZJgqQIUfzJeY0O6uOzbBldhDf7ela/gO5MAwcbqQe
         6ujT/ISyZQTGR8wpjbegYHrrd2z+W/OkjiN5ixRwRmDjzIlUfzMOlUu50g4T6vUg5S
         tMA/WNSJOJEOUl4nPfma4gbMiDFLt99fqq+GLIl+l7i3prbqJy3UMoCAiajTlxxDIG
         ezBc8/PU0PIqc1pIM6wNIwKearLHhR3u7+zVfjkH4xHRcAm3g6IP6XCZcGZ4RJ0nR4
         uFgILE6GfgKTCvZCAOlTjm+8sd4wxlBmhouFv3r0DNf9mEziAImd4XJqwDgtL4odKC
         F/oMHkh/2kzhrp1OrpSaWQxUyqXfaMXDNpZhIUA6CL1TfkxwiBZ1H9SJAkizcr3rmu
         QIBrBrdZqIchep1+guL6vofXMwGG4uY6vjN07dVoCiYlxQ9dqDNNVVfk+6JyJZWVED
         kdaDj5Z29pmb9jhrWOriCNT0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3F4440E0030;
        Fri, 17 Nov 2023 12:18:06 +0000 (UTC)
Date:   Fri, 17 Nov 2023 13:18:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>,
        Richard Biener <rguenther@suse.de>,
        Michael Matz <matz@suse.de>, Jan Hubicka <hubicka@ucw.cz>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Message-ID: <20231117121805.GEZVdZ/QhoeBytHf5o@fat_crate.local>
References: <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
 <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local>
 <ZVdYE3haicxr1lF/@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVdYE3haicxr1lF/@tucnak>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ SUSE gcc folks.

On Fri, Nov 17, 2023 at 01:09:55PM +0100, Jakub Jelinek wrote:
> Sure.  -mstringop-strategy affects only x86 expansion of the stringops
> from GIMPLE to RTL, while for small constant sizes some folding can happen
> far earlier in generic code.  Similarly, the copy/store by pieces generic
> handling (straight-line code expansion of the builtins) is done in some
> cases without invoking the backend optabs which is the only expansion
> affected by the strategy.
> Note, the default strategy depends on the sizes, -mtune= in effect,
> whether it is -Os or -O2 etc.  And the argument for -mmemcpy-strategy=
> or -mmemset-strategy= can include details on what sizes should be handled
> by which algorithm, not everything needs to be done the same.

Good to know, I might experiment with those. Thx.

> > > IOW, my assumption was just broken, and using
> > > "-mstringop-strategy=libcall" may well be the right thing to do.
> > 
> > And here's where I'm wondering whether we should enable it for x86 only
> > or globally. I think globally because those stringop heuristics happen,
> > AFAIU, in the general optimization stage and thus target agnostic.
> 
> -mstringop-strategy= option is x86 specific, so I don't see how you could
> enable it on other architectures.

Yeah, Richi just explained to me the same on another thread. To which
I had the question:

"Ah, it even says so in the manpage:

x86 Options ... -mstringop-strategy=alg

Ok, so how would the same option be implemented for ARM or some other
backend?

Also -mstringop-strategy=alg but it would have effect when generating
ARM code, right?

Which means, if I have it in the generic Makefile, it'll get
automatically used on ARM too when gcc implements it.

Which then begs the question whether we want that or we should let ARM
folks decide when that time comes."

I.e., what happens if we have this option in the generic Makefile and
-mstringop-strategy starts affecting ARM expansion of the stringops from
GIMPLE to RTL? Does that even make sense?

> Anyway, if you are just trying to work-around bugs in specific compilers,
> please limit it to the affected compilers, overriding kernel makefiles
> forever with the workaround would mean you force perhaps suboptimal
> expansion in various cases.

Yeah, perhaps a good idea. gcc 13 for now, I guess...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733678D31F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbjH3GFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbjH3GFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759BBCCA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EECA962A06
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A41C433C8;
        Wed, 30 Aug 2023 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693375508;
        bh=pIEAeMZU01cu0V/hi9qtT63KB+MWUtdcr1EXhtHOuRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8OsP4zv5gzmP0uGgcaIUG2DAQ0joO2f/CK6fbztCn0jfdksVQo5gAYHk+oH/MrR/
         lRm9VHJKmtt40ME7QrBDJTwrEQg4H35WualfNFeVeASfHdZY9y+SsrjSjkJDs458Z0
         yL6MRusr7zwvmNRShKVDXaL21Fgxg92ojLW/ADuI5Mh+jNL7KabkJtUP/VxZ83s9OT
         3ip+bUlaOfSCG6YSLGILSBBaW34wFy5KIAtU7oN0ShKz/xrtKgpltOcMzAtzjiUcFc
         Fes8/pQKkmhDHSGGCYF8wOzMz4xL8E3D5HKx42HyOpsSVYfG+6Z2BTHqQHrgDzDMpl
         IuIXyz5rHXaYw==
Date:   Tue, 29 Aug 2023 23:05:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, Enlin Mu <enlin.mu@unisoc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
Message-ID: <20230830060506.GA1015@sol.localdomain>
References: <202308281119.10472FC7@keescook>
 <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
 <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook>
 <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
 <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
 <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
 <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 29, 2023 at 11:43:37PM +0200, Ard Biesheuvel wrote:
> On Tue, 29 Aug 2023 at 20:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 29 Aug 2023 at 10:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > This is an oversight on my part. The diff below plugs this into the pstore code
> >
> > Hmm. My reaction is that you should also add the comment about the
> > "Work around a bug in zlib" issue, because this code makes no sense
> > otherwise.
> >
> 
> Naturally. But pasting the comment into the email body seemed unnecessary.
> 
> > Of course, potentially even better would be to actually move this fix
> > into our copy of zlib. Does the bug / misfeature still exist in
> > upstream zlib?
> >
> 
> I have no idea. You are the one sitting on the only [potential]
> reproducer I am aware of, and there is nothing in the git (or prior)
> history that sheds any light on this. Could you copy one of those EFI
> variables to a file and share it so I can try and reproduce this?
> 
> > Also, grepping around a bit, I note that btrfs, for example, just does
> > that Z_SYNC_FLUSH, and then checks for Z_OK. None of this Z_STREAM_END
> > stuff.
> >
> > Similarly, going off to the debian code search, I find other code that
> > just accepts either Z_OK or Z_STREAM_END.
> >
> > So what's so magical about how pstore uses zlib? This is just very odd.
> >
> 
> AIUI, zlib can be used in raw mode and with a header/footer. Passing
> the wbits parameter as a negative number (!) will switch into raw
> mode.
> 
> The btrfs and jffs2 occurrences both default to positive wbits, and
> switch to negative in a very specific case that involves zlib
> internals that I don't understand. crypto/deflate.c implements both
> modes, and pstore always used the raw one in all cases.
> 
> The workaround in crypto/deflate.c is documented as being specific to
> the raw mode, which is why it makes sense to at least verify whether
> the same workaround that pstore-deflate was using when doing raw zlib
> through the crypto API is still needed now that it calls zlib
> directly.

I get the "pstore: zlib_inflate() failed, ret = -5!" messages on my system too,
so I looked into it.  What's happening is that the pstore records are coming
from the efi_pstore backend, which has pstore_info::bufsize of 1024 bytes, but
they decompress to more than 1024 bytes.  Since pstore now sizes the buffer for
decompressed data to only pstore_info::bufsize, lib/zlib_inflate correctly
returns Z_BUF_ERROR.  (BTW, I write "lib/zlib_inflate", not "zlib", since it was
forked from the real zlib 25 years ago.  Regardless, the problem isn't there.)

I think we partially misinterpreted the functions like zbufsize_deflate() that
Ard's patches removed.  They seemed to be used only for getting the worst case
compressed size for an uncompressed size of pstore_info::bufsize.  Actually,
they were used both for that, *and* for getting the uncompressed size to try to
compress into pstore_info::bufsize.  (Which is very weird, as these are two very
different concepts.)

So I think first we need to decide whether pstore should try to use compression
to fit more than pstore_info::bufsize of data in each pstore record, as opposed
to just shrinking the size of the record actually written.  If yes, then this
really needs some more thought than the previous code which seemed to do this by
accident.  If no, then the new approach is fine.

BTW, what happens if someone was using a non-DEFLATE algorithm and then upgrades
their kernel?  Decompression can fail for that too.  So maybe pstore just needs
to consider that decompression of pstore records written by an older kernel can
fail -- either due to the algorithm changing or due to the uncompressed size
being too large for the new code -- and silence the error messages accordingly?
How "persistent" do these persistent store records really have to be?

- Eric

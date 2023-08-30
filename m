Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21BB78DE56
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjH3TBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbjH3HtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B5CD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65EB61D3C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1B9C433C7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693381742;
        bh=k+OdBh89bRxDLuMzRYHEmSAql9hShlElCSNl+dLLJzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K5l/B60DmuykqTr13G2jeK/nFZxALXdPgWHl8yzR5h0AM37fnKdBI2JvEQG2ysH7E
         8ESjnQORYm/Drzz7DXTUZFHP334U9rN85Q7xfpKWmp323wbo0XcsNTXjSgmwmlMCut
         /6ZJlmbLwRV959akGfY47439A8uJKnJFGGK5R8DHBthgbOSXCq81yJ8IlsOqEnepMn
         4WuOCWCnkGm2weeSR4e6VKhX+s6cQTtkV1a7Vn5A8/Dgrod/K/DVb5FovCfOSMVads
         LafirqQhbMYX99M5toxHSBnXlYQaXf6DiybYjb8vYVs1suLR+nuW8S3gtezq/VX4n1
         8sY37jyQyavBQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-500cd6261fdso276320e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:49:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzqJ6d/qEW9QlWxEsThyD5gGNRKM40lqIjKPdThSVtJQ5AWQur
        k8pgoEBfHGmFG36SK4UG69hh/0Nd67hyLnhTQUM=
X-Google-Smtp-Source: AGHT+IFFHDYupi8OfE4IhRwOSWw9K1gflO0cOxtq8b9mCxuDWVaauv+JuR/FyP/B/2qk6irIU+A6DX/oUtS5i8vl5y4=
X-Received: by 2002:a19:2d4c:0:b0:500:7dcc:621 with SMTP id
 t12-20020a192d4c000000b005007dcc0621mr872194lft.31.1693381740148; Wed, 30 Aug
 2023 00:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org> <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook> <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
 <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
 <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
 <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com> <20230830060506.GA1015@sol.localdomain>
In-Reply-To: <20230830060506.GA1015@sol.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 30 Aug 2023 09:48:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZ11VS=Tr8i5oKsdXkAuGt+k5GLUvVqzrYBg6UEs=HQA@mail.gmail.com>
Message-ID: <CAMj1kXGZ11VS=Tr8i5oKsdXkAuGt+k5GLUvVqzrYBg6UEs=HQA@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, Enlin Mu <enlin.mu@unisoc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 08:05, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Hi,
>
> On Tue, Aug 29, 2023 at 11:43:37PM +0200, Ard Biesheuvel wrote:
> > On Tue, 29 Aug 2023 at 20:04, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, 29 Aug 2023 at 10:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > This is an oversight on my part. The diff below plugs this into the pstore code
> > >
> > > Hmm. My reaction is that you should also add the comment about the
> > > "Work around a bug in zlib" issue, because this code makes no sense
> > > otherwise.
> > >
> >
> > Naturally. But pasting the comment into the email body seemed unnecessary.
> >
> > > Of course, potentially even better would be to actually move this fix
> > > into our copy of zlib. Does the bug / misfeature still exist in
> > > upstream zlib?
> > >
> >
> > I have no idea. You are the one sitting on the only [potential]
> > reproducer I am aware of, and there is nothing in the git (or prior)
> > history that sheds any light on this. Could you copy one of those EFI
> > variables to a file and share it so I can try and reproduce this?
> >
> > > Also, grepping around a bit, I note that btrfs, for example, just does
> > > that Z_SYNC_FLUSH, and then checks for Z_OK. None of this Z_STREAM_END
> > > stuff.
> > >
> > > Similarly, going off to the debian code search, I find other code that
> > > just accepts either Z_OK or Z_STREAM_END.
> > >
> > > So what's so magical about how pstore uses zlib? This is just very odd.
> > >
> >
> > AIUI, zlib can be used in raw mode and with a header/footer. Passing
> > the wbits parameter as a negative number (!) will switch into raw
> > mode.
> >
> > The btrfs and jffs2 occurrences both default to positive wbits, and
> > switch to negative in a very specific case that involves zlib
> > internals that I don't understand. crypto/deflate.c implements both
> > modes, and pstore always used the raw one in all cases.
> >
> > The workaround in crypto/deflate.c is documented as being specific to
> > the raw mode, which is why it makes sense to at least verify whether
> > the same workaround that pstore-deflate was using when doing raw zlib
> > through the crypto API is still needed now that it calls zlib
> > directly.
>
> I get the "pstore: zlib_inflate() failed, ret = -5!" messages on my system too,
> so I looked into it.  What's happening is that the pstore records are coming
> from the efi_pstore backend, which has pstore_info::bufsize of 1024 bytes, but
> they decompress to more than 1024 bytes.  Since pstore now sizes the buffer for
> decompressed data to only pstore_info::bufsize, lib/zlib_inflate correctly
> returns Z_BUF_ERROR.  (BTW, I write "lib/zlib_inflate", not "zlib", since it was
> forked from the real zlib 25 years ago.  Regardless, the problem isn't there.)
>
> I think we partially misinterpreted the functions like zbufsize_deflate() that
> Ard's patches removed.  They seemed to be used only for getting the worst case
> compressed size for an uncompressed size of pstore_info::bufsize.  Actually,
> they were used both for that, *and* for getting the uncompressed size to try to
> compress into pstore_info::bufsize.  (Which is very weird, as these are two very
> different concepts.)
>

Agreed. The whole point of that worst-case logic is that a given
buffer may expand due to compression overhead, so the input should be
consumed in chunks of a fixed size N, with the buffer space sized
according to worst-case-comp-size(N) (although storing the buffer
compressed in that case is also pointless, as we have already
established). The existing code seems to do the opposite: it consumes
the input in chunks of worst-case-comp-size(N) in order to store it
into a buffer of size N. This happens to work because this code only
ever operates on ASCII text but it makes no sense whatsoever.

Another reason to get rid of this stuff - it is seriously broken.

> So I think first we need to decide whether pstore should try to use compression
> to fit more than pstore_info::bufsize of data in each pstore record, as opposed
> to just shrinking the size of the record actually written.  If yes, then this
> really needs some more thought than the previous code which seemed to do this by
> accident.  If no, then the new approach is fine.
>

Given that only deflate is left now, we can easily bring that back,
although I question the utility. However, deflate being the default,
this is going to affect many people and so I think bringing it back
makes sense on that basis alone, but only on the decompress side.

> BTW, what happens if someone was using a non-DEFLATE algorithm and then upgrades
> their kernel?  Decompression can fail for that too.  So maybe pstore just needs
> to consider that decompression of pstore records written by an older kernel can
> fail -- either due to the algorithm changing or due to the uncompressed size
> being too large for the new code -- and silence the error messages accordingly?
> How "persistent" do these persistent store records really have to be?

This was mentioned in the cover letter: pstore is a last-resort
diagnostic facility, and given how pointless all this configurability
was, I seriously doubt that the removal of all those algorithms is
going to have an impact.

In any case, I'll rate limit the error so it doesn't clutter up the logs.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030C578CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjH2RbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbjH2Rao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8AE47
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A8B65E99
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE2C433CA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693330184;
        bh=wxc7lS7TdEjzyQkI9iT+9kMmWYL5eP2WidZiG7Nsr/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXdFoy7kzAYFSC9pAOfoj9yLzM1uyA1+Xmms7ygZyTpqOQlN63i3AGSjWdl/JlnHO
         Ap27oi2vNhVI0VjIChJCmeL0gOLXOSWFeq6HPryaxKadjm+7M/T8yYznJRxtfFzTrB
         pAgiM5FCVnbQBXpMRnh56/LMDV75u4B0EKwVVyDvTpfhxeI7lGIvZsTbC4qLkRGjI8
         Z7/kBtKBVWpGMSCSUSSOnaQjvqLwvQcp6gVGawZJfO0/+GPcQZqHXMQ8vZUIPGcIDK
         Y8wHtLXpOmrgMv75M1APLkm80Zgo2Ghfp+cArSyr1yq/fgCIwX0ySwhkOMF5Vc9qfL
         NFjT1t1nCuHjw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500913779f5so7469570e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:29:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YxX5Pc7mWl5whfx76y4LVZkAytm+zpSLih0PSUWERMdIxhMW/5Q
        KFuYeLGa/g0sbJaPyMdnwIIL5It5iuE/HrysP+Y=
X-Google-Smtp-Source: AGHT+IF/AUzk2BeDpgrW007Ee0VXkV9Mic26v2Wf2P6Ye2QEhq305zGKdCSK3zaY1HAm6YWd0hWUNvJd4zpQkmSSX0Y=
X-Received: by 2002:a05:6512:3b28:b0:4fe:ecd:4959 with SMTP id
 f40-20020a0565123b2800b004fe0ecd4959mr27143609lfv.32.1693330182551; Tue, 29
 Aug 2023 10:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org> <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook> <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
In-Reply-To: <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Aug 2023 19:29:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
Message-ID: <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 19:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 28 Aug 2023 at 20:44, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Aug 28, 2023 at 06:44:02PM -0700, Linus Torvalds wrote:
> > > The only thing that is new is the kernel pstore implementation. Why
> > > was this not a problem before? The warning existed back then too, but
> > > I never actually got it.
> >
> > Right -- if the compression method from before was different, it'll fail
> > now. (i.e. we removed everything but zlib.)
>
> I don't think that was the case.
>
> Looking back in my logs, I see lines like this:
>
>   Aug 07 16:59:29 ryzen kernel: pstore: Using crash dump compression: deflate
>
> and while it appears F37 used to support other formats, it does have
>
>   CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
>
> so it should all be zlib-compatible from what I can tell.
>

-5 == Z_BUF_ERROR which is only returned by zlib_inflate() in one
particular case (according the the kerneldoc):

    In this implementation, the flush parameter of inflate() only affects the
   return code (per zlib.h).  inflate() always writes as much as possible to
   strm->next_out, given the space available and the provided input--the effect
   documented in zlib.h of Z_SYNC_FLUSH.  Furthermore, inflate() always defers
   the allocation of and copying into a sliding window until necessary, which
   provides the effect documented in zlib.h for Z_FINISH when the entire input
   stream available.  So the only thing the flush parameter actually does is:
   when flush is set to Z_FINISH, inflate() cannot return Z_OK.  Instead it
   will return Z_BUF_ERROR if it has not reached the end of the stream.

and the crypto compress wrapper for inflate does

        ret = zlib_inflate(stream, Z_SYNC_FLUSH);
        /*
         * Work around a bug in zlib, which sometimes wants to taste an extra
         * byte when being used in the (undocumented) raw deflate mode.
         * (From USAGI).
         */
        if (ret == Z_OK && !stream->avail_in && stream->avail_out) {
                u8 zerostuff = 0;
                stream->next_in = &zerostuff;
                stream->avail_in = 1;
                ret = zlib_inflate(stream, Z_FINISH);
        }

IOW, it does not use Z_FINISH but Z_SYNC_FLUSH for the primary
invocation, and only stuffs in one additional NUL byte if it returns
Z_OK instead of Z_STREAM_END.

This is an oversight on my part. The diff below plugs this into the pstore code

--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -593,7 +593,13 @@ static void decompress_record(struct pstore_record *record,
        zstream->next_out       = workspace;
        zstream->avail_out      = psinfo->bufsize;

-       ret = zlib_inflate(zstream, Z_FINISH);
+       ret = zlib_inflate(zstream, Z_SYNC_FLUSH);
+       if (ret == Z_OK && !zstream->avail_in && zstream->avail_out) {
+               u8 zerostuff = 0;
+               zstream->next_in = &zerostuff;
+               zstream->avail_in = 1;
+               ret = zlib_inflate(zstream, Z_FINISH);
+       }
        if (ret != Z_STREAM_END) {
                pr_err("zlib_inflate() failed, ret = %d!\n", ret);
                kvfree(workspace);

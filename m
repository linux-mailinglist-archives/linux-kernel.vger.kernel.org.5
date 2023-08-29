Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74F78CEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjH2VoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbjH2Vny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21DCC4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E30664360
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FED0C433CC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345430;
        bh=RubBQKJk0catIhkgbnT+vDevLqqcLALStgFqU1Xx3VA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFC0EcgYzA7PyN4rTC7RQVp26lsn79cx2tpY7EzvFzmD/51RB2XloyqxpgxlzGUHH
         j39hG2a54rvkEmbf0SJi8mPtui/tbAUZmoPXu9x9OZEyWKDLT+s2DJpBmIJOG94OMm
         PNRsCBFmi3beD9z5tNLWBv/cjFNjMGu6IzECxZ7IWc+70J5xuaR9w7j5+PbctcpX4M
         2o9xqLP4qnaEbWlJDafozWDmK13muTk82aCygpBjD/JsLGUFilVwgaJ3lrqPo0/s2E
         n168RtPHWGvjtKQaZPE141raeMLzBFG5O6oTaPnZq5dSgBfRTQKoij7Wx3B3PbZVTq
         RJB9ZtFh1IHww==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4ffa248263cso7681937e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:43:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQ/bFLAatI+WsOk99kjU0QmzSb0aj4EmTKHm5PjbhizqCT1x6A
        QMPcObolI69txjRFx/qCoB+kow3uiagEsDA7lGw=
X-Google-Smtp-Source: AGHT+IFONhkxT4XcF5CVb2RVFUgNptSxMvj/0pdnrg7Bv9aGticaOob0X5gR0bF+/EydE3uRcx1QMe4WEDdShSFq3Fk=
X-Received: by 2002:a19:8c1c:0:b0:500:a2d0:51b6 with SMTP id
 o28-20020a198c1c000000b00500a2d051b6mr117243lfd.37.1693345428565; Tue, 29 Aug
 2023 14:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org> <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook> <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
 <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com> <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
In-Reply-To: <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 29 Aug 2023 23:43:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com>
Message-ID: <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com>
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

On Tue, 29 Aug 2023 at 20:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 29 Aug 2023 at 10:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > This is an oversight on my part. The diff below plugs this into the pstore code
>
> Hmm. My reaction is that you should also add the comment about the
> "Work around a bug in zlib" issue, because this code makes no sense
> otherwise.
>

Naturally. But pasting the comment into the email body seemed unnecessary.

> Of course, potentially even better would be to actually move this fix
> into our copy of zlib. Does the bug / misfeature still exist in
> upstream zlib?
>

I have no idea. You are the one sitting on the only [potential]
reproducer I am aware of, and there is nothing in the git (or prior)
history that sheds any light on this. Could you copy one of those EFI
variables to a file and share it so I can try and reproduce this?

> Also, grepping around a bit, I note that btrfs, for example, just does
> that Z_SYNC_FLUSH, and then checks for Z_OK. None of this Z_STREAM_END
> stuff.
>
> Similarly, going off to the debian code search, I find other code that
> just accepts either Z_OK or Z_STREAM_END.
>
> So what's so magical about how pstore uses zlib? This is just very odd.
>

AIUI, zlib can be used in raw mode and with a header/footer. Passing
the wbits parameter as a negative number (!) will switch into raw
mode.

The btrfs and jffs2 occurrences both default to positive wbits, and
switch to negative in a very specific case that involves zlib
internals that I don't understand. crypto/deflate.c implements both
modes, and pstore always used the raw one in all cases.

The workaround in crypto/deflate.c is documented as being specific to
the raw mode, which is why it makes sense to at least verify whether
the same workaround that pstore-deflate was using when doing raw zlib
through the crypto API is still needed now that it calls zlib
directly.

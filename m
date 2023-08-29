Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860678CBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjH2SEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbjH2SET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:04:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E74194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:04:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so71990671fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693332255; x=1693937055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVOPb4HIzmrMIe5EILAu9JN7T0Dc5vqs0skLV2r/rbw=;
        b=XmzQDvVmuEqnfU3Juva/MaMhdq0i3Kfv8fZaAmMWJA7rM79hEhyEpxvLfT/HaJ4rI1
         +V7uTZVwPqTtfYQQ27Jqc9siDHKsrQ3XcQtC+KogCKXDOw7hg5nW2UUHWg7z6My+KkbF
         3uXjBUqMer0Oq9dC175JfKuqcfgYDE+P/uov8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693332255; x=1693937055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVOPb4HIzmrMIe5EILAu9JN7T0Dc5vqs0skLV2r/rbw=;
        b=GL9rOfkEHslik9aM6dydYVippZheLtbX7cRnVHb8dZKTZ19VT9sApoO6NxhHbDHmbj
         1dpeEu+EXmdjHYif7Lzueno5+bIQVuPJ90dF6bm7zRMiY+jkye78CXwXxODThyxsgIPL
         3K3bxa+AP8N+EaUcNHHMZ5GHmi2Aj4KQcy3ql2tkvKUQnkBA+zpgKAOYEh1Ks4/oyIXm
         b+XBHpePqhSZng40t4WG22nAJhmrGqGWlPrLue7wX465MysFfATj5y6BFmqj9T0jhIku
         OhlST9iuf+P86sWrsIRCH4wBD08r9+ixGxpa0krTaZa3v1BB9LCtRiFPJGsuMhms5Krf
         FaAA==
X-Gm-Message-State: AOJu0Yw4514+L11XnVdNjXrBdG3Ev8cZB5tbOaV3eFdneMSWgkN45Rr0
        iZxNsdPtfj91XiOdRW+k9ZXtWmzxLrNXrm9C46Q+22j3
X-Google-Smtp-Source: AGHT+IFqKb7ewkwSrD1CrzJ9R3R1ab/du31biSUl+d7RPZQt73BeUJePgfPvzKWp9M8Dl/x+9toa2g==
X-Received: by 2002:a2e:854a:0:b0:2bc:eaec:e23f with SMTP id u10-20020a2e854a000000b002bceaece23fmr52295ljj.43.1693332254750;
        Tue, 29 Aug 2023 11:04:14 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z10-20020a2e9b8a000000b002bcda31af0fsm2227884lji.74.2023.08.29.11.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:04:14 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so71990341fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:04:13 -0700 (PDT)
X-Received: by 2002:a2e:874c:0:b0:2b9:aa4d:3719 with SMTP id
 q12-20020a2e874c000000b002b9aa4d3719mr66996ljj.12.1693332253492; Tue, 29 Aug
 2023 11:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <202308281119.10472FC7@keescook> <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org> <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook> <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
 <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 11:03:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
Message-ID: <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>,
        linux-kernel@vger.kernel.org, Enlin Mu <enlin.mu@unisoc.com>,
        Eric Biggers <ebiggers@google.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 10:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> This is an oversight on my part. The diff below plugs this into the pstore code

Hmm. My reaction is that you should also add the comment about the
"Work around a bug in zlib" issue, because this code makes no sense
otherwise.

Of course, potentially even better would be to actually move this fix
into our copy of zlib. Does the bug / misfeature still exist in
upstream zlib?

Also, grepping around a bit, I note that btrfs, for example, just does
that Z_SYNC_FLUSH, and then checks for Z_OK. None of this Z_STREAM_END
stuff.

Similarly, going off to the debian code search, I find other code that
just accepts either Z_OK or Z_STREAM_END.

So what's so magical about how pstore uses zlib? This is just very odd.

             Linus

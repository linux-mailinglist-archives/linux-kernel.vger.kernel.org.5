Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B647D48F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJXHuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjJXHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:50:14 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA98EE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:50:12 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-457e36dcab6so3480601137.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 00:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698133811; x=1698738611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZE7XIsMiCUi3JKd3SPomLA7US0XZO9rx0ByHQaJB4g=;
        b=H8t+8+Cr0d/2gVQj3LiUHgjX4Fk7LuX3L/6yDuOy+/TcMjUmbOTRTQXSJjZoPRG7Fv
         F/m7oTvejAF3EaZWdi9XthDIe2QAuEFJHkdv/sqxOUjVBVh8LSaoXd3DESz89ZtdUHaG
         CX9L6R6t1RGNVGoJEmgwN6RSxj+iuO8QnvrxmdlgWr2pkxqkNqKwUcikxOkr97+FOwUi
         fETPs7l5YZ0THUgFRoR483rkDMlAidyGzOBlNXlZt9rSP+qQKPR559Pzla5a7iwk+SFg
         HxRJDnahNqqQX12OTl1PKUpDy5LqP7wDJseiTd8At3w+zX/kPVbGjLIeGN6V4Q+IHd4e
         aaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133811; x=1698738611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZE7XIsMiCUi3JKd3SPomLA7US0XZO9rx0ByHQaJB4g=;
        b=oBUMI2QdI13ElRHiok7vSwzTY43b/hRkXRX9lPQYu4ykKAiyjTrYEmtdyds4HNxlFX
         8xQCec0m6ohHELBaaxRjWZEXvED0cA7yRTFp/xQL2Xa10eG3ob/FZzdJqlzZC5LZeZ/g
         J/ikShD0aqXCLU6M8L6/dz7LyAsorCOZK6iuqNVjGawByb0EZ50GPvZv62+J4kbcD3Bp
         JTU+tBchpG1jdvzoSC1mymGPIENKIhPSfCqgxlRo5/x3cBHd3ik9V8B9ANnr/jUV+ogc
         IcYQEhH/e+QaJrIzX5+WN8yc9bc66Qe90PxTkNuT9pc21GUnW4L7WF3L0BwOUJExMswu
         E+Gg==
X-Gm-Message-State: AOJu0Yxuz8+RVH8pJYl0t04JFIY6C11CrPgR/Ih6t0lpYDxuFz4P9Hpt
        wBOqOTsB6XPbd2oobbHvLYH0sYrtRmToe1vqyyKryA==
X-Google-Smtp-Source: AGHT+IGwu9GdRFq9XAPrEmJXirS3r9/lI8b9aPDEJowUtsOtQk6U/vdFv5hY2u/1EpolLmaMqiH76eXmOaINFL+gqyU=
X-Received: by 2002:a67:c896:0:b0:450:cebb:4f15 with SMTP id
 v22-20020a67c896000000b00450cebb4f15mr6824109vsk.1.1698133811022; Tue, 24 Oct
 2023 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231023233704.1185154-1-asmadeus@codewreck.org>
 <20231023233704.1185154-2-asmadeus@codewreck.org> <CANpmjNOUSci41NssMKgrNjC5P0doPWPekiizMOfjrr11CV-ogQ@mail.gmail.com>
 <ZTd13Eh1ryuyQqyr@codewreck.org>
In-Reply-To: <ZTd13Eh1ryuyQqyr@codewreck.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 24 Oct 2023 09:49:32 +0200
Message-ID: <CANpmjNMGbzg7MLFY-hpA0=bt24bMkmfTE9cvSjWTVLLG20WLNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] 9p: Annotate data-racy writes to file::f_flags on fd mount
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs@lists.linux.dev, ericvh@kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        syzbot+e441aeeb422763cc5511@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 09:44, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Marco Elver wrote on Tue, Oct 24, 2023 at 09:12:56AM +0200:
> > > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> > > index f226953577b2..d89c88986950 100644
> > > --- a/net/9p/trans_fd.c
> > > +++ b/net/9p/trans_fd.c
> > > @@ -836,14 +836,16 @@ static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
> > >                 goto out_free_ts;
> > >         if (!(ts->rd->f_mode & FMODE_READ))
> > >                 goto out_put_rd;
> > > -       /* prevent workers from hanging on IO when fd is a pipe */
> > > -       ts->rd->f_flags |= O_NONBLOCK;
> > > +       /* Prevent workers from hanging on IO when fd is a pipe
> >
> > Add '.' at end of sentence(s)?
>
> I don't think we have any rule about this in the 9p part of the tree,
> looking around there seem to be more comments without '.' than with, but
> it's never too late to start... I'll add some in a v2 after we've agreed
> with the rest.

Sounds good.
I think if there's 1 short sentence (1 line) comment, it's more or
less optional. But I'd insist on punctuation as soon as there are 2 or
more sentences.

> >
> > > +        * We don't support userspace messing with the fd after passing it
> > > +        * to mount, so flag possible data race for KCSAN */
> >
> > The comment should explain why the data race is safe, independent of
> > KCSAN. I still don't quite get why it's safe.
>
> I guess it depends on what we call 'safe' here: if we agree the worst
> thing that can happen is weird flags being set when we didn't request
> them and socket operations behaving oddly (of the level of block when
> they shouldn't), we don't care because there's no way to make concurrent
> usage of the fd work anyway.

Yes, that's reasonable.

> If it's possible to get an invalid value there such that a socket
> operation ends up executing user-controlled code somewhere, then we've
> got a bigger problem and we should take some lock (presumably the same
> lock fcntl(F_SETFD) is taking, as that's got more potential for breakage
> than another mount in my opinon)
>
> > The case that syzbot found was 2 concurrent mount. Is that also disallowed?
>
> Yes, there's no way you'll get a working filesystem out of two mounts
> using the same fd as the protocol has no muxing
>
> > Maybe something like: "We don't support userspace messing with the fd
> > after passing it to the first mount. While it's not officially
> > supported, concurrent modification of flags is unlikely to break this
> > code. So that tooling (like KCSAN) knows about it, mark them as
> > intentional data races."
>
> I'd word this as much likely to break, how about something like this?
>
>         /* Prevent workers from hanging on IO when fd is a pipe.
>          * It's technically possible for userspace or concurrent mounts to
>          * modify this flag concurrently, which will likely result in a
>          * broken filesystem. However, just having bad flags here should
>          * not crash the kernel or cause any other sort of bug, so mark this
>          * particular data race as intentional so that tooling (like KCSAN)
>          * can allow it and detect further problems.
>          */

I think this sounds much clearer. Thanks!

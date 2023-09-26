Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF517AE83A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjIZIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:41:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADD97
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:41:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad810be221so1030564466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695717691; x=1696322491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFWrsoW4uNhqV0CxpxdAxPRUEmdQJwwmxY6JAL4tAZc=;
        b=4y76pwsSHQ1jolHRYQ9LBmyEoooVg5c6W0oMp675RqvV5Vv9Shbd4FP/PYdA0Ds5Lb
         OvxOYgrZnnvjqkyoYbK6ELnTm94uXfAmuORz8gxCWu4WsrGtJN8KjrIYcp6STosOlSCS
         7jRanLsqujZ+l5fktqpQB66OdEeuH0aCuGqqr3j9TnjPC+ji3LY7iBfulXdaJZBkKqtX
         cjysTbNajf6Y58STfRf7JZ758Lsa6mDku0J0MZMzfZLmK6uo0XlEkj6XfMTjWP9PgrDx
         QZYLVoWgcUluLd6YItUHAH2HbtYMkv0H4My0/SNExOX2eFncUIwrQuu0q/wH/VUEq1gO
         S57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695717691; x=1696322491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFWrsoW4uNhqV0CxpxdAxPRUEmdQJwwmxY6JAL4tAZc=;
        b=O2ZgEIFYDXO8sSRhAQZXSd4bp1wD83wvdVsZWIyXy8qqQwZVrVOfOfE1FGpoAgABGJ
         Ec4vD0NXMMOkC4zBBqbtnuMajucPfPS1rnmumvIwdUOLJvOncYqca3oFbmP5JPCgRHfw
         NmFH4mDIx9YIksqFtr8eOvutX2qDpKpqMa1GsIcVypUiQhVI9/unK//OG5BUj/Emxz3w
         /cjl5ZW00UbI4qsbSxnNLaJLojOyabNN0KOwOwsplHCpgjjlRXfljvM1/BJjsRlLldkH
         ngFS8gcRyYT6rdeiFLt2CdAaqOlesbaVjTPH5D1Y6jN8PS0vB8sn0rZTMMtVS3NTY5D+
         3fKA==
X-Gm-Message-State: AOJu0Yzb3cEHK13NDt3VN79j+HuGGvFTTJcH5tfKQ80h1Whez6FR+t5I
        2fz1kYEHep+n/QzDt7hLzr5xsK9qneTdqzDGfOxmIQ==
X-Google-Smtp-Source: AGHT+IFnlAV0ixfWXVd7v6IEYdyAKxGRYvU1ns24lPtiEkc11WdiAOY4l02gkYVu0p5p6HA+HAggXHzdCjBC/Ggmq+4=
X-Received: by 2002:a17:906:2202:b0:9a4:88af:b7b with SMTP id
 s2-20020a170906220200b009a488af0b7bmr8190922ejs.62.1695717691523; Tue, 26 Sep
 2023 01:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230925172037.work.853-kees@kernel.org> <20230926045721.GA3118@sol.localdomain>
 <CAFhGd8q_GsawVXmwft=2g8bU+9Z5sM-q2Siajk2geL6cPQUiQA@mail.gmail.com>
In-Reply-To: <CAFhGd8q_GsawVXmwft=2g8bU+9Z5sM-q2Siajk2geL6cPQUiQA@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 26 Sep 2023 17:41:19 +0900
Message-ID: <CAFhGd8pq5mQkj8nvuYwOBmgHvo8FEw=9g+XUeLd_hdR0cHKrNw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: hardening: Add __counted_by regex
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:35=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> On Tue, Sep 26, 2023 at 1:57=E2=80=AFPM Eric Biggers <ebiggers@kernel.org=
> wrote:
> >
> > Hi Kees,
> >
> > On Mon, Sep 25, 2023 at 10:20:41AM -0700, Kees Cook wrote:
> > > Since __counted_by annotations may also require that code be changed =
to
> > > get initialization ordering correct, let's get an extra group of eyes=
 on
> > > code that is working on these annotations.
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 737dcc7a2155..741285b8246e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -11405,6 +11405,7 @@ F:    kernel/configs/hardening.config
> > >  F:   mm/usercopy.c
> > >  K:   \b(add|choose)_random_kstack_offset\b
> > >  K:   \b__check_(object_size|heap_object)\b
> > > +K:   \b__counted_by\b
> > >
> >
> > Are you sure you want to volunteer to maintain every file that contains
> > "__counted_by"?  That's what "K" does; get_maintainer.pl will list you =
(and
> > linux-hardening@vger.kernel.org) for every such file.
>
> Do people call get_maintainer.pl on specific tree files as opposed to
> invoking it against a .patch file? In the event of the .patch file
> "K:" should only pick-up what's in the patch and not read into the
> files outside of the context that the diff provides.

FWIW, b4 just uses the patches and not entire files:

   ...
    try:
        tos, ccs, tag_msg, patches =3D get_prep_branch_as_patches()
    except RuntimeError:
        logger.info('No commits in branch')
        return

    logger.info('Collecting To/Cc addresses')
    # Go through the messages to make to/cc headers
    for commit, msg in patches:
        if not msg or not commit:
            continue

        logger.debug('Collecting from: %s', msg.get('subject'))
        msgbytes =3D msg.as_bytes()
        ...


>
> If needed, I could send a patch adding a "D:" which would only
> consider patches and not tree files -- reducing noise.
>
> >
> > Other users of "K" have been surprised by this behavior.  It seems that=
 most
> > people expect it to only apply to patches, not to files.  Given that yo=
u're
> > interested in using this functionality, have you considered updating
> > checkpatch.pl to handle it in the way that you probably expect that it =
works?
> >
> > - Eric
> >
>
> Thanks
> Justin

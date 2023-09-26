Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341207AE82A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjIZIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:36:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF6497
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:36:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c1c66876aso1013446366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695717362; x=1696322162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjnOqBYDIBukB8OfPAJ6Ctq72GgFY1Pbrxf/0XUTr0U=;
        b=RMWwc3FK1XzQMOtYTT5NXG/VxUD4MG+CKKlaThaj32zMhRNI6jWFMuCbLJvC7MaosK
         X3PqKNzwNp78NDljLsaXeVu6m5UkfGGoEhXA8Cyy6ukhBFLSNQKLfNnEi45HI8/mJkzr
         9cbh45p43dyYoJX2ukXDTG+jypVuos1XQ+Gdni6XD1ZjFcL8k0hIuml8FhEYoLe6hSx9
         geTD/7t/RnrM4cTNj5LABjbZQzDFlBg571mc/PJy+pVgboJlPZm8GJ5jDsWrBeaeceCK
         t48EQW/5POT/z9v/dTKStyppDrnCx13jC38kpsiR0cMkXGB+9+kGCCHys34ef19DPknA
         RZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695717362; x=1696322162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjnOqBYDIBukB8OfPAJ6Ctq72GgFY1Pbrxf/0XUTr0U=;
        b=gAE+NiSN1xgyBjf6/3eVo5UUHIpP40EU4UpJkzNCfeXJfncff6oo0vZ2gNru2IFttC
         4uOkY5UY0ajWTuXWl482bDF9O4r4HN3e2Yga+If6sew36qCQfktuwKEt3u8yK1vSygAM
         LSVBlE6ElRJJSPyOB89bPZWKjpX5gGY/pmVaNWliavoSywLJjwpQFV9Z7K6VgHwGZKMd
         bO1/R2Jb/B5Yngm+m4M6Dfxkc3tZbBuWKxHTPiQ0vclgDtk2TZ5xZCqNxI+zDtQRt/fs
         4iLehbRjq6j+8yMOxXjNXnxOVz7X4hkeCrdkNTnRb5k5xMKmQ/nGuN4LGp78sceOnTrd
         2yRA==
X-Gm-Message-State: AOJu0YwUMpJ4daylbp/TKZJoVB0RG5sEsx2+RbgwDam8yzuqpp7F4/SU
        L0cVRbnPgEbBcWzsV5JV5eq5LD0Pi/a1940um38VJA==
X-Google-Smtp-Source: AGHT+IE591DZVU2mJKfq33uK6SQBvR3uoWMKY6HLmrVDjaQ2l1qfraVqaMTyJdeqZwIRRA66fsONQh2x5kKbTHwP2xE=
X-Received: by 2002:a17:906:1ba1:b0:9a1:e233:e627 with SMTP id
 r1-20020a1709061ba100b009a1e233e627mr8324753ejg.42.1695717362060; Tue, 26 Sep
 2023 01:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230925172037.work.853-kees@kernel.org> <20230926045721.GA3118@sol.localdomain>
In-Reply-To: <20230926045721.GA3118@sol.localdomain>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 26 Sep 2023 17:35:50 +0900
Message-ID: <CAFhGd8q_GsawVXmwft=2g8bU+9Z5sM-q2Siajk2geL6cPQUiQA@mail.gmail.com>
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

On Tue, Sep 26, 2023 at 1:57=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Hi Kees,
>
> On Mon, Sep 25, 2023 at 10:20:41AM -0700, Kees Cook wrote:
> > Since __counted_by annotations may also require that code be changed to
> > get initialization ordering correct, let's get an extra group of eyes o=
n
> > code that is working on these annotations.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 737dcc7a2155..741285b8246e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11405,6 +11405,7 @@ F:    kernel/configs/hardening.config
> >  F:   mm/usercopy.c
> >  K:   \b(add|choose)_random_kstack_offset\b
> >  K:   \b__check_(object_size|heap_object)\b
> > +K:   \b__counted_by\b
> >
>
> Are you sure you want to volunteer to maintain every file that contains
> "__counted_by"?  That's what "K" does; get_maintainer.pl will list you (a=
nd
> linux-hardening@vger.kernel.org) for every such file.

Do people call get_maintainer.pl on specific tree files as opposed to
invoking it against a .patch file? In the event of the .patch file
"K:" should only pick-up what's in the patch and not read into the
files outside of the context that the diff provides.

If needed, I could send a patch adding a "D:" which would only
consider patches and not tree files -- reducing noise.

>
> Other users of "K" have been surprised by this behavior.  It seems that m=
ost
> people expect it to only apply to patches, not to files.  Given that you'=
re
> interested in using this functionality, have you considered updating
> checkpatch.pl to handle it in the way that you probably expect that it wo=
rks?
>
> - Eric
>

Thanks
Justin

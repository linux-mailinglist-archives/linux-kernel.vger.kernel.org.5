Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C38807393
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442542AbjLFPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379162AbjLFPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:17:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DA4DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:17:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a06e59384b6so124004166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701875864; x=1702480664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZJM1Env+eEXFazDQzwu0LsFevasaND9E0B7qCoSTyU=;
        b=DSZKvOSJKt1hcYYXh6N2a+Xk3C09d5HhpoWL/zzE+w0mQjlHdBzXfJSkBk1j8LGzWD
         6pdWFgtseulRGPC94si9TmcsA6IGoOvtPvEHEdXuPtBKGsNX1x/Qdvx8DLISME4wvZqT
         SvbWl21j3z+XUVPabn3SCNmwoweBZ+l+41eHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875864; x=1702480664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZJM1Env+eEXFazDQzwu0LsFevasaND9E0B7qCoSTyU=;
        b=I9MbigfCfgtc30X21ycPaSKUGumUZp6UmAAgPzHYKHpX6EK5jmvqrCQocoSPVgf7TP
         QvqA71gpZBNW5ilXPgZNQLaX8kAlDRyoCORGMHc7j7I4qWo0/bvioqX9ePnml55fH/kH
         CiVeKz/0D0wypuTKX4IrD7uW7ID2TwtgveLCtTy+FtgyNOZ3HiEG+rI1r6LV5uOZa0nj
         QyFuJBwU6JHd8RbZMyGg7JTTrN3SVUJHG28ZvzT19bQ2B1qfYivbTFqJEhFVzEE1Nq3R
         jTuMpVPrtHoU4IzuvRltNt/cQBVKp5qYv9T0s8J2kJ/wT4IZKmphqI0MSRNKE78+l+Du
         nmRg==
X-Gm-Message-State: AOJu0Yyd7IqJs61zohLxBgkNdjypbfc0lNjl+9+VV5abx/Vh7gjWv02x
        Gy7SthCb/aMLmFoK6WuJ1ENCoVFWnSogH+3nFpqD7als
X-Google-Smtp-Source: AGHT+IH+5O7ytxRIaXrSJhQNDyucM2mESPd1bfdB+nn+5UOJXCQaQzPPlC3lGgK6vmUYA5D0IGkV5g==
X-Received: by 2002:a17:906:1d4b:b0:a1c:f3bf:23d with SMTP id o11-20020a1709061d4b00b00a1cf3bf023dmr739209ejh.142.1701875863713;
        Wed, 06 Dec 2023 07:17:43 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id lg18-20020a170906f89200b00a1b7f4c22a7sm49883ejb.82.2023.12.06.07.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:17:43 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b35199f94so76935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:17:43 -0800 (PST)
X-Received: by 2002:a05:600c:3b22:b0:40b:4355:a04b with SMTP id
 m34-20020a05600c3b2200b0040b4355a04bmr89811wms.6.1701875862555; Wed, 06 Dec
 2023 07:17:42 -0800 (PST)
MIME-Version: 1.0
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com> <20231206113753.GB81045@aspen.lan>
In-Reply-To: <20231206113753.GB81045@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Dec 2023 07:17:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7K5d8Dg+W5qaB_Kg8LuzMdMFEKZ2FfFC3qp2xAPMfKA@mail.gmail.com>
Message-ID: <CAD=FV=W7K5d8Dg+W5qaB_Kg8LuzMdMFEKZ2FfFC3qp2xAPMfKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-trace-kernel@vger.kernel.org, jason.wessel@windriver.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 6, 2023 at 3:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Dec 05, 2023 at 01:41:57PM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Nov 19, 2023 at 4:10=E2=80=AFPM Yuran Pereira <yuran.pereira@ho=
tmail.com> wrote:
> > >
> > > The function simple_strtoul performs no error checking in scenarios
> > > where the input value overflows the intended output variable.
> > > This results in this function successfully returning, even when the
> > > output does not match the input string (aka the function returns
> > > successfully even when the result is wrong).
> > >
> > > Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> > > simple_strtoul(), and simple_strtoull() functions explicitly ignore
> > > overflows, which may lead to unexpected results in callers."
> > > Hence, the use of those functions is discouraged.
> > >
> > > This patch replaces all uses of the simple_strtoul with the safer
> > > alternatives kstrtoint and kstrtol.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#si=
mple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> > >
> > > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > > ---
> > >  kernel/trace/trace_kdb.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > > index 59857a1ee44c..3891f885e4a6 100644
> > > --- a/kernel/trace/trace_kdb.c
> > > +++ b/kernel/trace/trace_kdb.c
> > > @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv=
)
> > >  {
> > >         int skip_entries =3D 0;
> > >         long cpu_file;
> > > -       char *cp;
> > > +       int err;
> > >         int cnt;
> > >         int cpu;
> > >
> > >         if (argc > 2)
> > >                 return KDB_ARGCOUNT;
> > >
> > > -       if (argc) {
> > > -               skip_entries =3D simple_strtol(argv[1], &cp, 0);
> > > -               if (*cp)
> > > +       if (argc)
> > > +               if (kstrtoint(argv[1], 0, &skip_entries))
> > >                         skip_entries =3D 0;
> > > -       }
> >
> > Similar nit about braces as in patch #1. tl;dr is change the above to:
> >
> > if (argc && kstrtoint(argv[1], 0, &skip_entries))
> >   skip_entries =3D 0;
>
> Surely that should be:
>
> if (...)
>         return KDB_BADINT;
>
> There seems little point switching to a "safer" API if we just ignore the
> errors it provides us.

Ah, sure. I have no objections to that. Note that would have also been
possible with the old code, which did still do awkward error checking,
so I assumed that it was a conscious decision. ...but I'm definitely
happier with the error being reported instead of glossed over.

-Doug

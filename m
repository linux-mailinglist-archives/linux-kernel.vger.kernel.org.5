Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD47D5971
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjJXRIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjJXRIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:08:46 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFCF10D0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:08:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9beb865a40so4367194276.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698167322; x=1698772122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4gL1zk6o610KyaQl0n4olXPspFqgwU/6otslNbLOBs=;
        b=WF/ZULq8VLYX+rkQgSzXWZrKSvXHNHZ6NF3OqyAi34Nnivy6FLhrH2v8sdnXbG67p1
         q0yyqKGcyhSAuEovArml+Gi+wzBhVXEQEBlX75iObbHZ4fQuyXYt2sOCOUwvIJQXLubW
         nPJl0SIhwuhRCn9UKmXO2o3WJrPSkwpImtxdQZ5R75Qg3XPxbHSufp1iVMhUxsRieViO
         9+PZZTQKLLeEbnNJUa+bs+/D7r/8B5NHTUOMcAVuFBmrfj/lVFOKAfNnRg3xy70eEqdE
         pb1lnrkXEBpoAJLPzu0vH5E1JkO94J7HnBfCZ/IoG/MwWk6OxfCqDT7Ys+nqika6DVBm
         ZNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167322; x=1698772122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4gL1zk6o610KyaQl0n4olXPspFqgwU/6otslNbLOBs=;
        b=Lg7IUgKSFJ4gXn4gulJ5/Kvtp/svcFRkDGVAIiBqdRDDSa0DtJ1gejvsj8lpMllt4s
         rvyo6Xpo1OD/A4BeJ6/lRGqH018L2g5psEhtS/V41W2cZfr7fQl1Ep8PBXiIdojOp3Pf
         TqlYLNbN/jJ3GHJ1+eM9zDIDZh/HC4y2F5IfE0gzFxlsW3VpmjPVwqQa0R4AyAc89DRA
         j1Uy2WXodlY9Gbi/U49uLpIFFKsE/9+ZEQQ3LSBCaBsVe6vylv3g4m3m3uTZRsbrMXWq
         NiCK4yZvr5ldJWtitSu5aOZ1oS2VER99ygo/VAKePnTX882DaLFPX120Bb4frroY+rHF
         2Bcg==
X-Gm-Message-State: AOJu0YzvWQqeWYunk/z8gqcaMI441wFJEK/M7oMGaUuuw7uEX/2q+yvf
        PcmHgV6kZRDFT140EKTKaW2hK4O82X7natqVvwHozIwumeQIe+i9LAI=
X-Google-Smtp-Source: AGHT+IEMmbQmG6h1tUrhQzAtYVSW2KBkX5EctfRJdNr5PWSZ9TzjtzLouFsrreJlLUyO/+017lL6xIP52peq9IVt2Zw=
X-Received: by 2002:a25:d107:0:b0:d9b:6262:43be with SMTP id
 i7-20020a25d107000000b00d9b626243bemr12726896ybg.16.1698167322201; Tue, 24
 Oct 2023 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
In-Reply-To: <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 24 Oct 2023 10:08:29 -0700
Message-ID: <CAJuCfpFY0JF3trYVmp5YjY3A8cH8TejrscRpA+Mjro4aA-TO6g@mail.gmail.com>
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to string_get_size()
To:     Andy Shevchenko <andy@kernel.org>
Cc:     akpm@linux-foundation.org, kent.overstreet@linux.dev,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 24, 2023 at 7:26=E2=80=AFAM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> (Minimized the list of people for my review / comments)

Thanks! I'll let Kent address your feedback.

>
> On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > The new flags parameter allows controlling
> >  - Whether or not the units suffix is separated by a space, for
> >    compatibility with sort -h
> >  - Whether or not to append a B suffix - we're not always printing
> >    bytes.
>
> ...
>
> >       string_get_size(nblocks, queue_logical_block_size(q),
> > -                     STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> > +                     0, cap_str_10, sizeof(cap_str_10));
>
> This doesn't seem right (even if it works). We shouldn't rely on the
> implementation details.
>
> ...
>
> > -     string_get_size(sdkp->capacity, sector_size,
> > -                     STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
>
> > +     string_get_size(sdkp->capacity, sector_size, 0,
> > +                     cap_str_10, sizeof(cap_str_10));
>
> Neither this.
>
> ...
>
> > -/* Descriptions of the types of units to
> > - * print in */
> > -enum string_size_units {
> > -     STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > -     STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +enum string_size_flags {
>
> So, please add UNITS_10 as it is now. It will help if anybody in the futu=
re
> wants to add, e.g., 8-base numbers.
>
> > +     STRING_SIZE_BASE2       =3D (1 << 0),
> > +     STRING_SIZE_NOSPACE     =3D (1 << 1),
> > +     STRING_SIZE_NOBYTES     =3D (1 << 2),
> >  };
>
> Please, add necessary comments.
>
> ...
>
> > +enum string_size_units {
> > +     STRING_UNITS_10,        /* use powers of 10^3 (standard SI) */
> > +     STRING_UNITS_2,         /* use binary powers of 2^10 */
> > +};
>
> And what a point now in having these?
>
> I assume you need to split this to a few patches:
>
> 1) rename parameter to be a flags without renaming the definitions (this =
will
>    touch only string_helpers part);
> 2) do the end job by renaming it all over the drivers;
> 3) add the other flags one-by-one (each in a separate change);
> 4) use new flags where it's needed;
>
> Also see below.
>
> ...
>
> >       static const char *const units_10[] =3D {
> > -             "B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> > +             "", "k", "M", "G", "T", "P", "E", "Z", "Y"
> >       };
> >       static const char *const units_2[] =3D {
> > -             "B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "Yi=
B"
> > +             "", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi"
> >       };
>
> Ouch, instead of leaving this and actually "cutting the letter" with NO* =
flags,
> you did something different.
>
> ...
>
> Now the main part. Since in 50+% cases (I briefly estimated, it may be mo=
re)
> this is used in printf() why not introducing a new pointer extension for =
that?
>
> Yes, it may be done separately, but it will look like a double effort to =
me.
> Instead it might give us a possibility to scale w/o touching users each t=
ime
> we want to do something and at the same time hide this complete API under
> printf() implementation.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

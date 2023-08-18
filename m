Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C5780D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbjHRN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377552AbjHRNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:55:57 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A18730F1;
        Fri, 18 Aug 2023 06:55:40 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44ac6638896so337283137.2;
        Fri, 18 Aug 2023 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692366939; x=1692971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8dyaMP5WDxRHd9ZM8bWsUhmoJPqOQ2ga6SD6mQ7ndI=;
        b=K+8xOnhtm11gTD90HVTObvdtxwFsFNs+zH7LeXEBsdHtFemiTpV1/lSITaaeqWO0hr
         YmRkSMiQI+DSH2wQTThE53YYjCYcp03e6SrsQx+UKE4LGTg3YzRAx96OcHuoojYaodG6
         OQUBDR0zJXbDeoC3VHsR4HjY9Mw8ARGPhF7q1BuBhF4mofj3xjPRyT4eXJd8gZWL+Sti
         ADFS6vl62cPa5xL/0iRHpkxNs+o2vmuuTrvz6/SoPWzd4d1Py4dJ23O3mQM6g+nT3Aab
         +yCCJaUahPKhwsszKAPfLGkcvYMWqJzmvk9p4aNjoY5MaxGn26NEkVOnrIhYDByEStFm
         CeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366939; x=1692971739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8dyaMP5WDxRHd9ZM8bWsUhmoJPqOQ2ga6SD6mQ7ndI=;
        b=K+b0QGsqI7HlV5t3iK2bvBCFmxpIWHke5YKdOVMHkyidnxoHnWRYpfVwMcWGtQxUV2
         r9vW+HkMUIonE+FqZFSmagRowBxRbdbpgv033nMyIWJQ9w80MFsvLOzygbfiRLFoZy5B
         jiOHe6VvXxRaz6Ez4CevQubHGFb/IYUZQEjYy2JY64M7M7wqXzy0XOdzPuc7yxLrwfhD
         om7OEFR4UN5Quod8tAC4iGxj1maQVXRjUXb8UtOpspFbJlAcLwhhu+FcSuMx2AQUL+pr
         WcH/odMJtsfc45X6ZxVIJJciQorMbQHLyahHlkeurIS/ANLUz5rpeQYN2j7ZnaUNZt9l
         d5Hg==
X-Gm-Message-State: AOJu0YxiFlAK8WaEkF2Tb3h/x971RgQaBEc0jEZXMmYf9mSkGCkokYKn
        +qDmh3m6YeGjJEhMrGXPCkbsyCGezvThYJyHQho=
X-Google-Smtp-Source: AGHT+IFrCRLTNRgPTTNHjMzwnqIM7dVHZYEcWvL2Hz8300cgggq3pRRqCLwdqe5F/BFP4dXJnZj/s0MpntDVuIOyhqk=
X-Received: by 2002:a67:bb14:0:b0:443:60d7:3925 with SMTP id
 m20-20020a67bb14000000b0044360d73925mr3465636vsn.20.1692366939262; Fri, 18
 Aug 2023 06:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230807171143.208481-1-cgzones@googlemail.com>
 <67cee6245e2895e81a0177c4c1ed01ba.paul@paul-moore.com> <CAJ2a_DdLR40CB6Ua5cNjYhtexNmGkzQRsVrJn+dhVaZO-aVKsA@mail.gmail.com>
In-Reply-To: <CAJ2a_DdLR40CB6Ua5cNjYhtexNmGkzQRsVrJn+dhVaZO-aVKsA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 18 Aug 2023 15:55:28 +0200
Message-ID: <CAJ2a_Dfz6anX5FaTL0OsmwC6Yji=3Po=uNBWhTuvE2NUReXL6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] selinux: use u32 as bit type in ebitmap code
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 17:00, Christian G=C3=B6ttsche <cgzones@googlemail.c=
om> wrote:
>
> On Thu, 10 Aug 2023 at 01:07, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Aug  7, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzone=
s@googlemail.com> wrote:
> > >
> > > The extensible bitmap supports bit positions up to U32_MAX due to the
> > > type of the member highbit being u32.  Use u32 consistently as the ty=
pe
> > > for bit positions to announce to callers what range of values is
> > > supported.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v3:
> > >   - revert type change of unrelated iter variable
> > >   - use U32_MAX instead of (u32)-1
> > > v2: avoid declarations in init-clauses of for loops
> > > ---
> > >  security/selinux/ss/ebitmap.c | 29 +++++++++++++++--------------
> > >  security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
> > >  2 files changed, 31 insertions(+), 30 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebit=
map.c
> > > index 77875ad355f7..a313e633aa8e 100644
> > > --- a/security/selinux/ss/ebitmap.c
> > > +++ b/security/selinux/ss/ebitmap.c
> > > @@ -471,18 +472,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
> > >  int ebitmap_write(const struct ebitmap *e, void *fp)
> > >  {
> > >       struct ebitmap_node *n;
> > > -     u32 count;
> > > +     u32 bit, count, last_bit, last_startbit;
> > >       __le32 buf[3];
> > >       u64 map;
> > > -     int bit, last_bit, last_startbit, rc;
> > > +     int rc;
> > >
> > >       buf[0] =3D cpu_to_le32(BITS_PER_U64);
> > >
> > >       count =3D 0;
> > >       last_bit =3D 0;
> > > -     last_startbit =3D -1;
> > > +     last_startbit =3D U32_MAX;
> > >       ebitmap_for_each_positive_bit(e, n, bit) {
> > > -             if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) =
{
> > > +             if (last_startbit =3D=3D U32_MAX || rounddown(bit, BITS=
_PER_U64) > last_startbit) {
> >
> > I'm getting worried about what might happen if the ebitmap starts to
> > contain bits near the end of the range, e.g. U32_MAX.  When lastbit
> > was signed this was a non-issue as we could set it to a negative
> > value (-1) and not worry about it, although the maximum value
> > difference between the signed and unsigned types would eventually be
> > a problem.
>
> For the maximum bit of U32_MAX `rounddown(bit, BITS_PER_U64)` will
> return U32_MAX-63, so it does not collide with the special
> last_startbit value of U32_MAX.

Also the current implementation is not safe for bits in the range
[rounddown(U32_MAX, EBITMAP_SIZE), U32_MAX], since the highbit and
`startbit + EBITMAP_SIZE` calculations are not checked for overflows
(since EBITMAP_UNIT_SIZE is not a power of 2 (it's 6 on x64).

>
> > While looking closer at this loop, I'm now wondering if we shouldn't
> > just rewrite the logic a bit to simplify things, and possibly speed
> > it up a small amount.  How about something like this:
> >
> >   count =3D 1;
> >   n =3D e->node;
> >   while (n->next) {
> >     count++;
> >     n =3D n->next;
> >   }
> >   last_startbit =3D n->startbit;
> >   last_bit =3D n->startbit + find_last_bit(n->maps, EBITMAP_SIZE);
> >
> > You should probably verify that there isn't something stupid like an
> > off-by-one bug in the code above, but I think it is a lot cleaner
> > than what we currently have and should resolve a lot of the type/math
> > issues.
>
> I think this loop does not work, since in the binary format the map
> size is 64 bits (and thus we need to calculate the number of 64bit
> nodes), but the kernel supports (depending on the architecture) 32bit
> maps for the in-memory representation.
> So the number of in-memory nodes might not be the same as the number
> of nodes in binary format.
>
> p.s.:
>
> Looking at the patch again, `rounddown(bit, BITS_PER_U64)` is computed
> twice and last_bit can probably be dropped in favor of e->highbit.

The last_bit comment can be ignored, since last_bit is the highbit for
the mapsize of the binary format, so it's no equal to e->highbit
(which is relative to the in-memory mapsize).

>
> >
> > >                       count++;
> > >                       last_startbit =3D rounddown(bit, BITS_PER_U64);
> > >               }
> > > @@ -496,9 +497,9 @@ int ebitmap_write(const struct ebitmap *e, void *=
fp)
> > >               return rc;
> > >
> > >       map =3D 0;
> > > -     last_startbit =3D INT_MIN;
> > > +     last_startbit =3D U32_MAX;
> > >       ebitmap_for_each_positive_bit(e, n, bit) {
> > > -             if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) =
{
> > > +             if (last_startbit =3D=3D U32_MAX || rounddown(bit, BITS=
_PER_U64) > last_startbit) {
> > >                       __le64 buf64[1];
> >
> > Similar to the above, I think we can probably rewrite this to simply
> > walk the ebitmap nodes and write them out.  Using
> > ebitmap_for_each_positive_bit() seems overly complicated to me,
> > although I may be missing something important and obvious ...
> >
> > --
> > paul-moore.com

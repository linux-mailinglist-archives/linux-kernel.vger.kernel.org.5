Return-Path: <linux-kernel+bounces-108676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8D880E47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161A5283CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4D38FA0;
	Wed, 20 Mar 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoxnuzYo"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599138DF1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925636; cv=none; b=BOZ4DMzp4crY9sRy0N+Ab8bJCSC1Wc1qJ1dtPuvXlEp1qMAf/fCLbOVeymFUkFrIf1+JTbBS7+W+8m4FbZI4zcoHOFmIgVxcVKn3UFaQP8cqAuvPEz+kT0ejyL477IHP0c95HwkwxjyBfRGuBxlbSWhncy5NYQVj7xYabOt5f2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925636; c=relaxed/simple;
	bh=nzO/zX8U25jXb1Wzac3nvYcDSqqV9PNzs02ywde09k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8G33tOyFeFzEHRuLBmPicrb9glQmSwvdzpcP+YI+TUH/th+/rd39i/9jCpJK2a/OQQJ0IMc20OEnEPJSLbyEh1m4iPYtZkDfpMiUMuCm9uuqC+XHJIEZkfecweSNLxTXpVO0lyFhTs87WSVwFtW576V7Lv8mBmSHMYwq84/E04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoxnuzYo; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so86742031fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710925633; x=1711530433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFmoFRtiVhYlElRiuwA4am3p/eGR8EbCAnxSr4G2ILo=;
        b=XoxnuzYoW3EtlLnGE6XRRPZjZmxzHHjNappotHjuTxUdv/nD7yRrWcNg3AGlCGaHJy
         g7q/J0k4Y9BAT2IZQPY/4TBYVRCh1kfqGIzzV86pYvIISSxwj+wW8MhuULOo7eWocAaL
         nZTgh4mq/X3fvQgDruaqXobTxGXnsE8UON/R88+tGTfCBHyEmGEDME4yZ5e8UuRI5gcq
         Bvv/IrZT+QM+3f906cWuQss4CxSCSYNholO1bWFx0dyRoR12mXxcjj0OY8gdO6jYookd
         yRd97rv/yC7mJ5DaVyWv956c6P22kVW5/O9payAnXpmKPLI9cljtmkoTEMGoTF14/+AR
         l55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925633; x=1711530433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFmoFRtiVhYlElRiuwA4am3p/eGR8EbCAnxSr4G2ILo=;
        b=PsBBeEvd1pkFH+34gL+KyEFIrISBSkKEq7U1dlRFFq3DLJV17LgvFEFNUY++LmijzP
         6LQSBEE1u3Q5ZknwLBmrR1iUiMbX/C2tfxl00UZJ+ml4jC4OjA82mfRi7dSwJpEZWVAf
         VESb8YkAozTPW868qepYaMOa1S9Z+kfD4ItSBubO5tTVf50oWJfHE3mTh1hoiz9UUHfp
         5k1lzboyAIAtFCrF4MJYjOatbU1Gn3dttnB5SY1MuYuA+Mn4r6AbbGJy+WB5uwmG5kzo
         j7vALIqnn8/oQatSZcnI5GoEXBNVJmtPpWLYj4I2SVncJLT2zorzK3aBY18i3RvquBTv
         aF0w==
X-Forwarded-Encrypted: i=1; AJvYcCVuSZL5oQ2fiVIcXvfb0DTlsTmiG8nE/ydiurNPv5Lf/n+m3RX6ajdnXPM+RRhDQ1y/P8/uHeOVJQOQq5jKSqZP4NZHuXS55E66R1/Q
X-Gm-Message-State: AOJu0Yx3m0Q0E+LL2ClLlRYGYyvYRc/fqfnpY4uuq4DQmq82/GAfuMiw
	tuTNtA2lx+51uwA1znrDJir+GerioHkobw2GzL/pZ6KB+FRX7n9fBtSu3/wybYhwsrot6LaQvjA
	JPg8ya4ROd/sSMkCYfNY9Gv6pR/PiOmaa0zBiAC9ZwNs=
X-Google-Smtp-Source: AGHT+IGaGyGcpZ4Pq4dMwDtqGwnGEpDwAFYCPeLs/Lld6/x5pNmN+CjRzLTdQxlIZ7nYjd+t07CHSYfFCNsq1cmZCM0=
X-Received: by 2002:a2e:9956:0:b0:2d2:bbd9:ebc9 with SMTP id
 r22-20020a2e9956000000b002d2bbd9ebc9mr916489ljj.24.1710925632383; Wed, 20 Mar
 2024 02:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319092733.4501-1-ryncsn@gmail.com> <20240319092733.4501-5-ryncsn@gmail.com>
 <ZfoPjUyPiXpFSxA4@casper.infradead.org>
In-Reply-To: <ZfoPjUyPiXpFSxA4@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 20 Mar 2024 17:06:55 +0800
Message-ID: <CAMgjq7BGN9SknnXF+doO-3p18OOYRzB0D5PMdwwstpCXtxj47g@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/filemap: optimize filemap folio adding
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 6:20=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Mar 19, 2024 at 05:27:33PM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Instead of doing multiple tree walks, do one optimism range check
> > with lock hold, and exit if raced with another insertion. If a shadow
> > exists, check it with a new xas_get_order helper before releasing the
> > lock to avoid redundant tree walks for getting its order.
> >
> > Drop the lock and do the allocation only if a split is needed.
> >
> > In the best case, it only need to walk the tree once. If it needs
> > to alloc and split, 3 walks are issued (One for first ranced
> > conflict check and order retrieving, one for the second check after
> > allocation, one for the insert after split).
> >
> > Testing with 4k pages, in an 8G cgroup, with 20G brd as block device:
> >
> > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> >   --buffered=3D1 --ioengine=3Dmmap --rw=3Drandread --time_based \
> >   --ramp_time=3D30s --runtime=3D5m --group_reporting
> >
> > Before:
> > bw (  MiB/s): min=3D  790, max=3D 3665, per=3D100.00%, avg=3D2499.17, s=
tdev=3D20.64, samples=3D8698
> > iops        : min=3D202295, max=3D938417, avg=3D639785.81, stdev=3D5284=
08, samples=3D8698
> >
> > After (+4%):
> > bw (  MiB/s): min=3D  451, max=3D 3868, per=3D100.00%, avg=3D2599.83, s=
tdev=3D23.39, samples=3D8653
> > iops        : min=3D115596, max=3D990364, avg=3D665556.34, stdev=3D5988=
20, samples=3D8653
> >
> > Test result with THP (do a THP randread then switch to 4K page in hope =
it
> > issues a lot of splitting):
> >
> > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> >   --buffered=3D1 --ioengine mmap -thp=3D1 --readonly \
> >   --rw=3Drandread --random_distribution=3Drandom \
> >   --time_based --runtime=3D5m --group_reporting
> >
> > fio -name=3Dcached --numjobs=3D16 --filename=3D/mnt/test.img \
> >   --buffered=3D1 --ioengine mmap --readonly \
> >   --rw=3Drandread --random_distribution=3Drandom \
> >   --time_based --runtime=3D5s --group_reporting
> >
> > Before:
> > bw (  KiB/s): min=3D28071, max=3D62359, per=3D100.00%, avg=3D53542.44, =
stdev=3D179.77, samples=3D9520
> > iops        : min=3D 7012, max=3D15586, avg=3D13379.39, stdev=3D44.94, =
samples=3D9520
> > bw (  MiB/s): min=3D 2457, max=3D 6193, per=3D100.00%, avg=3D3923.21, s=
tdev=3D82.48, samples=3D144
> > iops        : min=3D629220, max=3D1585642, avg=3D1004340.78, stdev=3D21=
116.07, samples=3D144
> >
> > After (+-0.0%):
> > bw (  KiB/s): min=3D30561, max=3D63064, per=3D100.00%, avg=3D53635.82, =
stdev=3D177.21, samples=3D9520
> > iops        : min=3D 7636, max=3D15762, avg=3D13402.82, stdev=3D44.29, =
samples=3D9520
> > bw (  MiB/s): min=3D 2449, max=3D 6145, per=3D100.00%, avg=3D3914.68, s=
tdev=3D81.15, samples=3D144
> > iops        : min=3D627106, max=3D1573156, avg=3D1002158.11, stdev=3D20=
774.77, samples=3D144
> >
> > The performance is better (+4%) for 4K cached read and unchanged for TH=
P.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/filemap.c | 127 ++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 76 insertions(+), 51 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 6bbec8783793..c1484bcdbddb 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -848,12 +848,77 @@ void replace_page_cache_folio(struct folio *old, =
struct folio *new)
> >  }
> >  EXPORT_SYMBOL_GPL(replace_page_cache_folio);
> >
> > +static int __split_add_folio_locked(struct xa_state *xas, struct folio=
 *folio,
> > +                                 pgoff_t index, gfp_t gfp, void **shad=
owp)
>

Thanks for the very helpful review!

> I don't love the name of this function.  Splitting is a rare thing that
> it does.  I'd suggest it's more filemap_store().

Yes, the function name is a bit misleading indeed, I can rename it as
you suggested, eg. __filemap_store_locked ?

>
> > +{
> > +     void *entry, *shadow, *alloced_shadow =3D NULL;
> > +     int order, alloced_order =3D 0;
> > +
> > +     gfp &=3D GFP_RECLAIM_MASK;
> > +     for (;;) {
> > +             shadow =3D NULL;
> > +             order =3D 0;
> > +
> > +             xas_for_each_conflict(xas, entry) {
> > +                     if (!xa_is_value(entry))
> > +                             return -EEXIST;
> > +                     shadow =3D entry;
> > +             }
> > +
> > +             if (shadow) {
> > +                     if (shadow =3D=3D xas_reload(xas)) {
>
> Why do you need the xas_reload here?

This part of code works based on the guarantee that If there is a
larger entry, it will be the first and only entry iterated by
xas_for_each_conflict/xas_find_conflict. I added an xas_reload is here
to ensure that. But on second thought, this seems not needed indeed.

Will it be better if I write this part this way?

+ shadow =3D NULL;
+ order =3D -1;
+ xas_for_each_conflict(xas, entry) {
+           if (!xa_is_value(entry))
+                    return -EEXIST;
+          /*
+          * If there is a larger entry, it will be the first
+          * and only entry iterated.
+          */
+         if (order =3D=3D -1)
+                  order =3D xas_get_order(xas);
+         shadow =3D entry;
+ }
+
+ if (shadow) {
+          /* check if alloc & split need, or if previous alloc is
still valid */
+         if (order > 0 && order > folio_order(folio)) {
+                   if (shadow !=3D alloced_shadow || order !=3D alloced_or=
der)
+                            goto unlock;
+                   xas_split(xas, shadow, order);
+                   xas_reset(xas);
+          }
+          order =3D -1;
+          if (shadowp)
+                   *shadowp =3D shadow;
+ }

>
> > +                             order =3D xas_get_order(xas);
> > +                             if (order && order > folio_order(folio)) =
{
> > +                                     /* entry may have been split befo=
re we acquired lock */
> > +                                     if (shadow !=3D alloced_shadow ||=
 order !=3D alloced_order)
> > +                                             goto unlock;
> > +                                     xas_split(xas, shadow, order);
> > +                                     xas_reset(xas);
> > +                             }
> > +                             order =3D 0;
> > +                     }
>
> I don't think this is right.  I think we can end up skipping a split
> and storing a folio into a slot which is of greater order than the folio
> we're storing.

If there is a larger slot, xas_for_each_conflict and check above
should catch that?

>
> > +                     if (shadowp)
> > +                             *shadowp =3D shadow;
> > +             }
> > +
> > +             xas_store(xas, folio);
> > +             /* Success, return with mapping locked */
> > +             if (!xas_error(xas))
> > +                     return 0;
> > +unlock:
> > +             /*
> > +              * Unlock path, if errored, return unlocked.
> > +              * If allocation needed, alloc and retry.
> > +              */
> > +             xas_unlock_irq(xas);
> > +             if (order) {
> > +                     if (unlikely(alloced_order))
> > +                             xas_destroy(xas);
> > +                     xas_split_alloc(xas, shadow, order, gfp);
> > +                     if (!xas_error(xas)) {
> > +                             alloced_shadow =3D shadow;
> > +                             alloced_order =3D order;
> > +                     }
> > +                     goto next;
> > +             }
> > +             /* xas_nomem result checked by xas_error below */
> > +             xas_nomem(xas, gfp);
> > +next:
> > +             xas_lock_irq(xas);
> > +             if (xas_error(xas))
> > +                     return xas_error(xas);
> > +
> > +             xas_reset(xas);
> > +     }
> > +}
>
> Splitting this out into a different function while changing the logic
> really makes this hard to review ;-(

Sorry about this :(

This patch basically rewrites the logic of __filemap_add_folio and the
function is getting long, so I thought it would be easier to
understand if we split it out.
I initially updated the code in place but that change diff seems more
messy to me.

>
> I don't object to splitting the function, but maybe two patches; one
> to move the logic and a second to change it?
>

I can keep it in place in V2.


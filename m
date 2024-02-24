Return-Path: <linux-kernel+bounces-79819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B786272A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFE52823C7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216E14CB41;
	Sat, 24 Feb 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlk8V58z"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380B1CD14
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708804914; cv=none; b=tG10p0kfruKb4gUXyq8CCIVSksql3BqYkld5doSz8pj5gMRp3QZQBGoURN8S9xvp6RgIkmRG2kCPw/DNiFPwfoQ8+yskGWW1qJNORKtVpG/2YiXgae/CRoJ4pN9SXS+Xd8+lqNbwvlCXxqnQQRLc0TD99S43Qk9Oz7zyM4i2K1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708804914; c=relaxed/simple;
	bh=FkkIX7ff0GH1hNUeJLjrSyJaFKKYMJWWsy5nkRfLtYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a05fXDAi6AX/lp0n+2HzAR+AVCUsXxPHrUw/6EmbadW8/ZWksF65qd6ixB3PJnWkkDz+eJ/ruLPduIvzrk7T2ZLO2TPt+mX+8I2qFzUs/366++gSqTt8gFbJWTqY38bhhPs8Tru+vcIktIhWVTwqEUbh81wrbb6afNzZ0ozqtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlk8V58z; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d643a40a91so1095228241.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708804912; x=1709409712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhvY0oAhlso/vm21VK7DmsUYbiVSz8F5wQ+tQ3fpMMQ=;
        b=hlk8V58zHRx5PvRGEPa6eLNYAiT7Lrsh4LGUZq/73SCaza4v7LgvgImsIzzc3zSaoT
         f3imPt+PWrevjLyFa1KvFFW5MOSZ4dGtv40UghQV1qZ27Kr/sNYKRzcsFQc14auTmYmI
         3hAOjREI+pF/iR3jofwY8pGUvuatXeQ+Vuj67mxmVuGZet1ye+QfFdlk9+OTpwbVl/8e
         sy/BUk9+lceXiJJUYUatApLYigLQAn5h/l2be2/khlxUhbUqrIdfqln4dpT5QNKZzXJw
         OvLXQZ9P1iEXu0aqRSg5wOdxVy3WJ9VDbQXajaJQ6yx4uoSLpDhpFaOSphqiDFRlAigC
         rWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708804912; x=1709409712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhvY0oAhlso/vm21VK7DmsUYbiVSz8F5wQ+tQ3fpMMQ=;
        b=udzfAbOoa/ub4VQ+GClJZ90ziYoBWh5BIbg/FrQsikmrKee7bdjkkVLFWQzu3km43F
         hNkToU3BRW1cu5tbtYiP977AkWrTN880PVx8usejkK9AxCASvJpVtW33AwD2YqbfnsyA
         PQ7C5/0f6hgxTFYXqzVEHbwuK3XxAU58bAGCMnbdRWa/VSRRFXhzmO0+SVoJjuV55Jcl
         58JOiKMpcg2gMvn2cmwvUSe4U6xKGcuYMk0y249Y4PaNwSayCEQFWf/J53k+lPJVHLen
         xBnsSUpT/+6BqiZJauk8f3PNpW0G757EL/W62pPxk7EMoZDY4VnxbwysCKZW5Zx0xdpA
         60vg==
X-Forwarded-Encrypted: i=1; AJvYcCWJdoIzbabIsOuABpIE+/wltT4l3/s5KOlKpBosSUAWPdUbneSZMvJimzpmNJ/rD7VYMtel6cBeUJdHRLECLtfvT1ygRRFJv0a70EJs
X-Gm-Message-State: AOJu0YyjSR1g1ozYVjh2IIWP10+xlQZ1zlvJXhyfpkhM1r51lrlyny3D
	B+FwjD+YOt19wPRIThs4QdK8t65SjsXiFb3J4CZSQW2ZicJXJ7AeTquSLeMSjm3oCxBKDu7CVod
	bjra5/RjQ4+7IIWsoD/GxUeQLHSg=
X-Google-Smtp-Source: AGHT+IEOpO4xwFjEMMS4q1MPbiPIvWeVLimD16r3xLrW/831OCqy7UnLYv6Qc9PkJ5vDb9k1hoM7i5SGdG1bvcH+h6Q=
X-Received: by 2002:a1f:ed01:0:b0:4d1:3f5a:75ee with SMTP id
 l1-20020a1fed01000000b004d13f5a75eemr1790639vkh.9.1708804911975; Sat, 24 Feb
 2024 12:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4xZQGgzFxEMTJby5MBb22GKV3+X_pLdz1E-1m_hzM4x5A@mail.gmail.com>
 <20240224190724.45681-1-sj@kernel.org>
In-Reply-To: <20240224190724.45681-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 25 Feb 2024 04:01:40 +0800
Message-ID: <CAGsJ_4w5JF8zjsM=vEiArUpnvN9LjAdnUn98mEUJSAhg4Y9XjQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 3:07=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Barry,
>
> On Sat, 24 Feb 2024 12:37:59 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> [...]
> >
> > BTW=EF=BC=8C
> > Hi SeongJae,
> > I am not quite sure if damon also needs this, so I have kept damon as i=
s by
> > setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hint =
users
> > don't want the memory to be reclaimed, I don't know if it is true for d=
amon as
> > well. If you have some comments, please chime in.
>
> Thank you for calling my name :)
>
> For DAMON's usecase, the document simply says the behavior would be same =
to
> MADV_PAGEOUT, so if we conclude to change MADV_PAGEOUT, I think same chan=
ge
> should be made for DAMON's usecase, or update DAMON document.

Hi SeongJae,

I don't find similar clearing pte young in damon_pa_pageout(), so i
guess damon's
behaviour is actually different with MADV_PAGEOUT which has  pte-clearing. =
damon
is probably the best-effort but MADV_PAGEOUT isn't .

static unsigned long damon_pa_pageout(struct damon_region *r, struct damos =
*s)
{
        unsigned long addr, applied;
        LIST_HEAD(folio_list);

        for (addr =3D r->ar.start; addr < r->ar.end; addr +=3D PAGE_SIZE) {
                     struct folio *folio =3D damon_get_folio(PHYS_PFN(addr)=
);
                     ....

                     if (damos_pa_filter_out(s, folio))
                                goto put_folio;

                    folio_clear_referenced(folio);
                    folio_test_clear_young(folio);
                    if (!folio_isolate_lru(folio))
                         goto put_folio;
                    if (folio_test_unevictable(folio))
                          folio_putback_lru(folio);
                    else
                          list_add(&folio->lru, &folio_list);
put_folio:
               folio_put(folio);
         }
         applied =3D reclaim_pages(&folio_list);
         cond_resched();
         return applied * PAGE_SIZE;
}

am i missing something?

>
>
> Thanks,
> SJ
>

Thanks
Barry


Return-Path: <linux-kernel+bounces-28272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A782FC61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97B01F294FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9762557E;
	Tue, 16 Jan 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg6w+hKt"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486B1F613
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438523; cv=none; b=lvx3EeiR1wLQy33w6x8xjQCG6mmcACvOVq7CDqBB/dAMyNxOWVTu3pc/A8U/YCCIXHTG5nyRqNwCrruIi9cUndp1bd8LT+nzMcHQFjL9AiueqvVPkvvvqnHuruBa9cm09OV7ow2SSVb4SAkkrLJp0gWb6xt4Q/ppN8C9qo8Uz5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438523; c=relaxed/simple;
	bh=KJMSJ5YMtIUrpd2z3vBV4pMorEzbpfcRJrZOFXeistI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=joMAGpyZwKS/4E3KX3S5/CK0ttJvc5t/tQiAJ2/sSX+yoaUK8KMz+mg4hd7asKcth+S73lpmlhnwVVW50RNYYF+H0ubM23GgYGXcrq1C4zAwvbcU+99U3pnIMhKC4sbL738xk/wuJa3vkjeIUmlYSr8JCw+m717cqHBCgeAryZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg6w+hKt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cf765355ecso1405527a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705438520; x=1706043320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQdIf9/3seTYdpMLp0Hh9SVTTL4lH3XX6yFOdn4DVz8=;
        b=Dg6w+hKt+exjAt9luUTy/wCvDy1Lg92DcCh1rfibsl9DRMMoMmA1Fldh++tqLOUwbi
         CAYtUTa8WvD2DJ6lRAimpWK9e4jwb3x/sVwDeQ5gUqEq3NNGJml4g6hahWYlxRnnEGS+
         NoK2OMafOaBCJNQYhLPPzsiTWksVMvvroubJrTvCUuuS8zRVU4kLr1QgpvDUAgQB0N/L
         b9sLuGS6+gt466wsRHN9VSG1bWcLgvO8YQzYJlO0DQuB2DTBBC+xn6/Rdali7uqFp0KP
         7KbC+Go24w60wLZUpNMgkgDE23aiufV3nJuqMPb9JbQGSxymprmpL4TN8vmxlLuvllmK
         v2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438520; x=1706043320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQdIf9/3seTYdpMLp0Hh9SVTTL4lH3XX6yFOdn4DVz8=;
        b=T/HsKXLD43BBilLFq7IbVc8o7xjaJ0HngeCISB77F2A/im3ATOrqMADRO2nCkuab1c
         Vgum4BThSKrozwSFDqBoV/62xXI5H27BN330IblB1I3s6V/QmodJs+rjGjUvDFRHqWWb
         EbEFRPaXEqJIpGOsdbx+6DP0o0hBOYupXkKCRGeymR68ah+dzCZafuObdylTsu5Qvx8Q
         RkRqm+JVTKQAqnc2esMCeA9UoL73oMJo9EE2i89/YIkrx1Ibxb9Ogfpolc9pAU65OUxp
         1CJH3T1v9arbWguKW6/GeMmYAhIiLa6QTxAMByPWh3UEjUj98bVzuWUyYv2qLIBhNpEb
         7F9w==
X-Gm-Message-State: AOJu0YwkxTBev7VoYCxYlyOI8Ga2zFuE38sO5VWzlwwxwap5gZJYezkN
	TOPmqld8gjv2cQwUC8R3vsZ1nlf9DLrAScAa29A=
X-Google-Smtp-Source: AGHT+IFc2KL82NxqHyH1mi7Z+u4ztbfA0IHVeHJTHrf9apvxaY907fzHEBuQHG2Ze8BR6Ny0sq3JUTyqmn75o0o6+1A=
X-Received: by 2002:a05:6a20:958e:b0:19b:dd2:aade with SMTP id
 iu14-20020a056a20958e00b0019b0dd2aademr2926763pzb.114.1705438520639; Tue, 16
 Jan 2024 12:55:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
In-Reply-To: <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 12:55:08 -0800
Message-ID: <CAHbLzkp-s1rr3496rpgx_td75waE=P=sv=5OCK9HWvWjmz-0GA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > Hi,
> >
> > On 09. 08. 22, 20:24, Rik van Riel wrote:
> >> Align larger anonymous memory mappings on THP boundaries by
> >> going through thp_get_unmapped_area if THPs are enabled for
> >> the current process.
> >>
> >> With this patch, larger anonymous mappings are now THP aligned.
> >> When a malloc library allocates a 2MB or larger arena, that
> >> arena can now be mapped with THPs right from the start, which
> >> can result in better TLB hit rates and execution time.
> >
> > This appears to break 32bit processes on x86_64 (at least). In
> > particular, 32bit kernel or firefox builds in our build system.
> >
> > Reverting this on top of 6.7 makes it work again.
> >
> > Downstream report:
> >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> >
> > So running:
> > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux=
btf
> >
> > crashes or errors out with some random errors:
> > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 type=
=3D181346
> > Error emitting field
> >
> > strace shows mmap() fails with ENOMEM right before the errors:
> > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > ...
> > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot allocate
> > memory)

It should be due to the virtual address space size on 32-bit machine.

> >
> > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > enough. For reference, one is available at:
> > https://decibel.fi.muni.cz/~xslaby/n/btf
> >
> > Any ideas?
>
> This works around the problem, of course (but is a band-aid, not a fix):
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned long
> addr, unsigned long len,
>                   */
>                  pgoff =3D 0;
>                  get_area =3D shmem_get_unmapped_area;
> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> !in_32bit_syscall()) {
>                  /* Ensures that larger anonymous mappings are THP
> aligned. */
>                  get_area =3D thp_get_unmapped_area;
>          }
>
>
> thp_get_unmapped_area() does not take care of the legacy stuff...

Thanks for the report. I think we can just make
thp_get_unmapped_area() no-op on 32 bit.

>
> regards,
> --
> js
> suse labs
>


Return-Path: <linux-kernel+bounces-39485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A095A83D1EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5418A1F260AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297B10EB;
	Fri, 26 Jan 2024 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYHuFWvK"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8FA387;
	Fri, 26 Jan 2024 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231685; cv=none; b=Ry6Kd06y505CJXgcj1itO4QoQrDAPJ/hOiMh3R1DAeeuuiN0+ZqZ/XVJmwvcWkKXJggdkz43zfF4rTfYlb5i8gcTdLHnmN93TxccCOi7k2bYQjHVNIbqOTB1OdnYUo+qFyIOlrssDT5LncjpoyOC+CggMqy0SoMdgGXxFOChvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231685; c=relaxed/simple;
	bh=wppqGuChQbSUaLQ8QL8b8yX5LarATJPM1jUq1EFE/D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMRtWC11y2IuogxuiL7nwnCoWi7Mu0OYxieLqOlefKc2pWp3gR3xdiLiWWpEVOOhEG5zjH6UW2760DKwYFiSEXKOoVet+llHuq8jyIX6VhDYFBEkxzixhHUNJl+DbBSvqqg6ceHHoADGVG/Jd1C+IaBxv2J7L4S4l1QQfGpCLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYHuFWvK; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf3a04ea1cso17057701fa.2;
        Thu, 25 Jan 2024 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706231682; x=1706836482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wppqGuChQbSUaLQ8QL8b8yX5LarATJPM1jUq1EFE/D4=;
        b=nYHuFWvKYD28H2wzfyXd7ymBfBuoP0KCBKeemtVRWl8fXzTDDSImI5UrO21ehIzJ3u
         qCH4paXVMS1MpkaMWCBUL/ErOaaTUmhkVth/TpmryfkJ5itWTLWoZyuDQ0rMCvM/qlR7
         o6KCVmsvACXTz9nhncFP01AdwuH+kR8qzVehIqK5B8sqmf0cmQp9Wof41Hg3e1N0rM3O
         s19avtEObtfpCk4ln9iWwRqYVMUp0quejHulGxkbpVm642jksnj5VklzlO+g9/tiVkYk
         DXhxs8VfmFhDWhsxK7eFpaLurarHbql11Y4X2oqKiVAKZJ3mNTzoC2SRgZTxr1SjQj/Z
         nQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706231682; x=1706836482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wppqGuChQbSUaLQ8QL8b8yX5LarATJPM1jUq1EFE/D4=;
        b=q8MewPLtNXThRp0Qw+dhLX/LbuLJ/WFddCp1FFFnriRe99jvFnx7sK/LN6eWm/yHel
         bgORW+oQAl931gfuXePoOFkAxjIk//AxaFooiJI9OqlOeTLsuIBL3kLXa9Y8LhXwIcT0
         E4v47CzrwBFLoqlHKfouMUUlO+7SEuqaePu1xcGzLnET/00JNVis/1/YdyyS2GjJvQGZ
         f0LkyG2XFeDv2Vc7HFBxblFgPSqnHJuEhJKzEgmIj+yohkYxLEqQxMP+Y22fTTLWErxh
         LBgntFqrYuUAmT92nM7guu2syWNV/hINA1aYOI7n0cjwPsIrLwXUPJ73t6y2A4B9OOa2
         J3yg==
X-Gm-Message-State: AOJu0Yz0mzOr+Kw4GllXWH6I06GITSAWDrGDw6kZnlW8IN4egDNGf19e
	gIBlXOL7KZ+FUclP6oA1Fpe/Bj4fpVKs9sk3W7BAn/HvUfiOmx4wScSTGRcLBnBm7a2QqjcW0SO
	TK892useWWi2ymxzS2VU2wVmFDHo=
X-Google-Smtp-Source: AGHT+IGqBgKBURdVBKk6O/LPAZfFF7s0fMgud8iwQ9gos3lcZ5/ojQb3dHCHIg7xdrF9moKGDhfZhKBR4ARF3KP9x64=
X-Received: by 2002:a05:651c:794:b0:2ce:93b:ba6e with SMTP id
 g20-20020a05651c079400b002ce093bba6emr244626lje.85.1706231681456; Thu, 25 Jan
 2024 17:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org> <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
 <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org> <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
 <CAGWkznGJejDMZsryPpS-11mb50wMhhQe-=sNoV4_iO5ogVLtLQ@mail.gmail.com>
 <15d07953-aeff-460e-81fe-ea7fc2f6145d@kernel.org> <CAGWkznF_mQdA0ebTfyXKnJ0xu6v=iqhr9yDJ4DohL38mRgeTrw@mail.gmail.com>
In-Reply-To: <CAGWkznF_mQdA0ebTfyXKnJ0xu6v=iqhr9yDJ4DohL38mRgeTrw@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 26 Jan 2024 09:14:30 +0800
Message-ID: <CAGWkznHdE_zJ1pnxf-0-D3M=8aBwn-gFNte333WbKPioygGdLA@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:10=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
com> wrote:
>
> On Thu, Jan 25, 2024 at 5:54=E2=80=AFPM Damien Le Moal <dlemoal@kernel.or=
g> wrote:
> >
> > On 1/25/24 18:37, Zhaoyang Huang wrote:
> > > Actually, the activity information comes from page's history (recorde=
d
> > > at page cache's slot) instead of user space in step(1) and can be
> > > associate with bio in step(2) or iterate the bio in step(3)
> > > page fault(or vfs)(1)
> > > |
> > > alloc_pages
> > > |
> > > add_page_to_pagecache(get the page's activity information)
> > > |
> > > fs_readpage
> > > |
> > > bio_add_page(2)
> > > |
> >
> > set your prio here. No change to the block layer needed. That is FS lan=
d.
> Yes, that is what I suggested in patchv3 which keeps the block layer
> clean by introducing a set of helper functions which wrap up the
> activity things for FS utilization.
Maybe I misunderstand Damien's opinion which suggests iterating the
bio->bvec here via a new API. I think it is more costly than counting
activities when adding pages to bio and need more modifications on
each fs.
> >
> > > submit_bio(3)
> >
> >
> > --
> > Damien Le Moal
> > Western Digital Research
> >


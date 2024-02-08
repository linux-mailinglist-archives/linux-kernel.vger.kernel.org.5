Return-Path: <linux-kernel+bounces-57475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24884D990
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBCF1F232C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEAC67C5E;
	Thu,  8 Feb 2024 05:30:03 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DB67C51;
	Thu,  8 Feb 2024 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707370202; cv=none; b=qm1mbqY1XogGJWEZcbDcOp5y9GHo520Tu0f+jynCmmv+EdubMMYUZ/16pnqiOY+lTBf3VDSJcMRODmC70olcDL1DUfEXO1c4Hh7P82P4+rLabQg9fPqtrC+Q9NxkeaZhRDSRM9iDm8fk0PPe9/gWHsXAxR4zsSczJY7QsMkG3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707370202; c=relaxed/simple;
	bh=LSGhLsIEUn/a5N+Xif81iePzt9BrdznZDIftCEWCoSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nn41fUP0iMJ6IHu2fE0J46QrOdv2c1agIv+FBHKIjvuwC5gCDEQq/0EdTY+oo3sshlCYuIzfAAOrWBaU/cnE7RwNaIoPahmycRRFRkWSF/BGZEENUsQug/a3EPDBdaNi7ypYN18Mv23orkhhKYbNhQ+zzc15+6lJTNlErXxzUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so934579a12.3;
        Wed, 07 Feb 2024 21:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707370200; x=1707975000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np0WXML6XnfyYnvQ5Kz5GSWkppmE8CLxkStPxfJskEI=;
        b=pSwOBaqeyJ35qoibW13y68VwiHeqzYTbKyGdvI/iH8G6sDq3VboRdLCOw/5vsLWXm4
         ynSTPvv2Oh7Iq9vxZQFxaXxK7b5onLM+r/SfCzTgSSErr9YUmIR0AlI6kMskLNdgnV+h
         JebF0Faw5SskWeFnkZ57T8NnDGJ1IV7hmIuifaYweX93Nir3cIAMoeJqV/lTYRnqkZQy
         Wi2h+QZF6BrxZsFFEYp9sN/9q+MDSjRlrUbu1oi8N6AF7IaYia2Fu3C+buG4TVmfjRsU
         1bNs1eGKBPm3v73YL1rRdc9tfw6UMcuPUN1TeTbDKdoXG68bVA4mZLTKQ54UImWg0Afr
         +fDg==
X-Gm-Message-State: AOJu0YxIs1RHyssvhqwC4qFTOBKo4Jw3k5j0i7I/ffSxSB6Jc4RmpZkE
	u47aLJwRMhP7Sjq+lohqxiAdcyl8+y4tAAprrPrz/HWfq2OReLD3JhV/u7KnAYIpy5FGlUaIN5T
	KLx/Dz3/kHS3WtlUp9OLciIp8KHs=
X-Google-Smtp-Source: AGHT+IGvTl+ZP11IcRdz3/2WBLOG5nM8RrJ8DnAcBUA8U2fJjpj4v5W9LdevI4C7gBzBP9/uV4GBDbFfVkU60MfOKPo=
X-Received: by 2002:a05:6300:8082:b0:19c:6b59:b9fc with SMTP id
 ap2-20020a056300808200b0019c6b59b9fcmr7270336pzc.24.1707370200365; Wed, 07
 Feb 2024 21:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206130458.8867-1-adrian.hunter@intel.com> <CAM9d7cjiCT7C=WHd9EmPRRRQY=1aq8-NAGgRcZPWz-s=7Js3mw@mail.gmail.com>
In-Reply-To: <CAM9d7cjiCT7C=WHd9EmPRRRQY=1aq8-NAGgRcZPWz-s=7Js3mw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 21:29:49 -0800
Message-ID: <CAM9d7ciZuHzsi+nt190GwyfGYh5txLqDq6-2hOXLzJ+sibjaMQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] perf symbols: Slightly improve module file
 executable section mappings
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Adrian,
>
> On Tue, Feb 6, 2024 at 5:05=E2=80=AFAM Adrian Hunter <adrian.hunter@intel=
com> wrote:
> >
> > Hi
> >
> > Currently perf does not record module section addresses except for
> > the .text section. In general that means perf cannot get module section
> > mappings correct (except for .text) when loading symbols from a kernel
> > module file. (Note using --kcore does not have this issue)
> >
> > Here are a couple of patches to help shed light upon and slightly impro=
ve
> > the situation.
> >
> >
> > Changes in V2:
> >
> >   perf tools: Make it possible to see perf's kernel and module memory m=
appings
> >     - add dump to perf report (if no browser) as well as perf script
> >     - add 'perf --debug kmaps' option also to dump kmaps
> >
> >
> > Adrian Hunter (2):
> >       perf tools: Make it possible to see perf's kernel and module memo=
ry mappings
> >       perf symbols: Slightly improve module file executable section map=
pings
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Hmm.. this is not applied cleanly.  Can you please rebase
onto the current perf-tools-next?

Thanks,
Namhyung


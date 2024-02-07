Return-Path: <linux-kernel+bounces-55968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6D84C443
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED5CB2350B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F114A85;
	Wed,  7 Feb 2024 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz6evOHY"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378E12E78;
	Wed,  7 Feb 2024 05:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282070; cv=none; b=Um1HSCDkcVKYEN38vwJD/MZ+kWLkzmzrZE4AJOALRPs09/YhSkJz7vVVXmzRasWFQ7wRmM1CChJ02q+99Xg8FFN5ZJYxhBaIeh7vlJ6WUn3MeIrZoo5Oathj69hkiHqZ42kLUiExu/NrgSdEcuRgm861ADbQojhOvdTD1r3LqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282070; c=relaxed/simple;
	bh=tsFpYrFr6qvE492BrqJFsG8ASeO8HQ1Nge9WRSOJCsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBy1wojOI7Mqj7YL9odb/g2s2a4NINQ1ZwIksbnz0vaRDbc8MS3W4F/fm2XSWLpfg+dYOoDOMLMdoDLD4N8dQHVZoLx3B0SdDyfjaQI/xaGl6xv2Q8Cr0mmhDk8PdImitw06Q0DZughp6CvOgnN38S2JgpW4S90ehYeQHpPJ+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz6evOHY; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so121794241.0;
        Tue, 06 Feb 2024 21:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707282067; x=1707886867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsFpYrFr6qvE492BrqJFsG8ASeO8HQ1Nge9WRSOJCsE=;
        b=Hz6evOHYtsHwHjxWnIi3xgFfER+h4/jRxPZaKugMARiTiaKSTGANoIjhN62XWHa1c9
         yZpuuVevJeaQBworTq955avheeCHs6GyPqoWMbw+ZbhwIfEbO2G2oRpZBSYYIwNHtzYt
         wVZU187/uqSfaKZX1XivC0ROnPZeiW1kVD2AENt8ahJKvDB0ISkEOf7qVIIY0itNvqvD
         n5gdYs9UcVBXyvsfTOAWJV1RkNTs5vQO0//snaADTvew9+1htHFIeuFMANJnTOFbzis2
         sGzGqcdGM8sBPpiTHfSVtZeqzjRwHgBZYj40u0O1+fK9JvfGSDJhnNHezDXKPNNz5aIE
         WvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707282067; x=1707886867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsFpYrFr6qvE492BrqJFsG8ASeO8HQ1Nge9WRSOJCsE=;
        b=mJR81xizu5YR+IHMhzaNL+BFbVPoRKmfD65vt1ynu0hN3zqoRnpiescK4IpvQMiGOH
         jxqIDDgToTbkiNuHCKzMwADlPvPfno2aZuR0YCiPrLVsx+3NjyiWK+WjaPT223GE96bZ
         7VJY8rYXoJ24OgLqS2Tk+Fu/oArajCgwgBew1SveZ9eBY16sGa3gXwd6CWC5HKt5yNP1
         H/WsXxtOaVYMeqPPyM/OfezD1x6TWGdITBC+DaJg+ofE8w2Mvbk7NcyBlu6nBhUTLd3K
         l9BdDCV2JFFklT7EYQFf5wnx5LjDkBTjHKAb74CkUKLZkF+cO6+aaTsWBBZI58Z/dFNx
         yS6A==
X-Gm-Message-State: AOJu0Yxobe3ONeiXZtv+MtwVttTCbwCHX42H5lEpsmzp+38uTduXrB+o
	fQ96kgRgB0CGlS/ZrdY9AbZu6XDO1hmFw3zxWUhSQIdLN+qITpSjIg6fgryQPzxK585fgwrLMhw
	mPEzy7jmbRHQqJp0gBNzmO2CK3M4=
X-Google-Smtp-Source: AGHT+IG6OPhTyogu+ZqMppV8mfeNLy/Li51MZcTjoNGa0IAJPsuv+evtuXtnCGeM50wngAwfH4Gz047VCcACFOrg8tg=
X-Received: by 2002:a05:6102:3944:b0:46d:25e4:df10 with SMTP id
 f4-20020a056102394400b0046d25e4df10mr1580033vsu.30.1707282067271; Tue, 06 Feb
 2024 21:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206202511.4799-1-21cnbao@gmail.com> <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk> <20240207031447.GA489524@google.com>
 <79926b88-c1ef-4042-a871-61752d29c838@kernel.dk> <20240207032148.GB489524@google.com>
In-Reply-To: <20240207032148.GB489524@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Feb 2024 18:00:55 +1300
Message-ID: <CAGsJ_4yPChtForHNqqT_C7Yge6-0KvDDs=oNqqDuDXNwOeuXoA@mail.gmail.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:21=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/02/06 20:17), Jens Axboe wrote:
> [..]
> > >>> Minchan, if you have any objections, please chime in.
> > >>
> > >> Not Minchan, but I do have an issue with the title of the commit, it
> > >> doesn't make any sense. Can the maintainer please re-write that to b=
e
> > >> something that is appropriate and actually describes what the patch
> > >> does?
> > >
> > > Thanks Jens. I fully agree, I requested a better commit message in
> > > v1 feedback, we probably still can improve on this.
> > >
> > >
> > > Something like this?
> > >
> > > ---
> > >
> > > zram: do not allocate physically contiguous strm buffers
> > >
> > > Currently zram allocates 2 physically contigous pages per-CPU's
> > > compression stream (we may have up to 3 streams per-CPU). Since
> > > those buffers are per-CPU we allocate them from CPU hotplug path,
> > > which may have higher risks of failed allocations on devices with
> > > fragmented memory.
> > >
> > > Switch to virtually contiguos allocations - crypto comp does not
> > > seem impose requirements on compression working buffers to be
> > > physically contiguous.
> >
> > Yep, this is much better! Thanks.
>
> Thanks.
>

Hi Sergey, Jens,

> Barry, can you please send v3 with the suggested subject and commit
> message?

Thanks for your comments and improvements. will send v3 accordingly.

Best regard
Barry


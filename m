Return-Path: <linux-kernel+bounces-139629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B68A057C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8808028743D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0AC6217D;
	Thu, 11 Apr 2024 01:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCUjXXUC"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFFD6166E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798858; cv=none; b=svgQmR1EjXjqxlMidrb41zM6Y39U0p8A7jYcmEVBq1/KzokHkxgesRswJkoTEK3DaqwBrk1NT/VZgSLiFxLVkFCoZrjsYSyEzKvbB33hOa5TNDNWBhfcv0N2AvUQw0vf3NZlIKcS9rjlJQts4iI+JaOSZ8MX3xe1h4iDRH5MvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798858; c=relaxed/simple;
	bh=5+fNjU5bm/FNIY7nQA9jRzJPW0i8m68rgtoy0yqtfNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMY2byfJ87qnK2RR3HWdOYjexQRqfzn3y5LF0mljOQQjSqhPvX3OLx1KfFWfdZdQ7jhtlumy5V8VAezY3bAaVULmVja04kX2cZza2yhz16ix2tdzOAfBghf+aeQB9zzyK+z+1Icl1/npJPv6XnghF1utcft7EjIoy9/gx+OnGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCUjXXUC; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e043f577c5so220543241.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712798856; x=1713403656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfGZWRXSUIyqNHCgW8rswLstTfY/iXLOVHVR00RmzH4=;
        b=JCUjXXUCjklpCYsqmaYUgBZhq425TRC0RW6C8myUOo+9O6gs5rS7MjIsgOmasaR32a
         bSN7/i5JRVHv1urMSq0wu7U0u9Y5WvbyGJ4g/euoT5nm2sHt7ZDgYvVdd1sv7snP4eUi
         J4e09Zv2PcvQkYoK5IbVWv7OZaN1tIsJWcIAAY7y7+dhJpf5Y8+OVVFG0sjJHIF/Zw6/
         IHcJgeWrXfarBgzFmLJ5YkaOao96hBMuZ6Kmy0Q6uGeUEHSkaMW9IooCxR5OFV873wrF
         ir3VFmqBhMiQUqaa1Hd06EoHv36Pd9Us/JRVc/D/Px4x6SJG5fesOveVCFQ8oZcDTEou
         1fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712798856; x=1713403656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfGZWRXSUIyqNHCgW8rswLstTfY/iXLOVHVR00RmzH4=;
        b=h/RSaqekNeyN4+WMeu7Wrvmvd4cVBFhV9Nj5iILcWI6KNB5WHVJDpBIPHTycc4uf8C
         jugZaa9OVM5HWzWUnUTs8gWPjr/UZEedot2Da2lzBR6HKh7XKLL5qy0cC5k5Y6oCFHPt
         H6BwGAfKWVg2rpRfMRquUwCp8sywGHDWDsEIMz085nJ2L+JzVFT3f7p4/Pibc9Ub/AbD
         4sggWzvR/uup5lA3Fw9SFGGXOvXtzfwy0YpI3gW5BZ5XnGXblyC2nCBzdvOM3Xcsjm1a
         rq8VoWSBcdxuaOnfHH9jxXExomfvz2Ph/3tM4I8Avoz+P8nFYsllbxNN3Anul8yLHR3L
         OI0A==
X-Forwarded-Encrypted: i=1; AJvYcCXh9h4kV0Rh9CILpLL4wXLHwpY/YH9KiTWZKwyi+r3vHcywn6bNxZdtM10h4btARmWHGudcXm53H2lsgeNV67A9XWO/Ix0Sm3L1dUdg
X-Gm-Message-State: AOJu0YyJXMw9UJbTE3fNdeYnO4eVtFMQZNvPyBd9iMxZYzO/KwePR5xl
	V/yHuLAHzlGWsFMu+k1nDnLP3EJFDLGbwaQ/ZVIgNl90VFPmeZCOPC9d3xaI4KsPw0tci/OwCyN
	5iRFAeXSlm/gclkCmcyu6K8O2B4Q=
X-Google-Smtp-Source: AGHT+IHmvWK7mM9OMuV2oPFHDefXOfcfb7bhsM78G0eZItcfICf/zTcQHLgd7ZA4aMSK8YFfP4KkoDtw+3mjDAWuAww=
X-Received: by 2002:ac5:c956:0:b0:4bd:54d0:e6df with SMTP id
 s22-20020ac5c956000000b004bd54d0e6dfmr1117988vkm.1.1712798855741; Wed, 10 Apr
 2024 18:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-2-21cnbao@gmail.com> <20240410233759.274907-1-sj@kernel.org>
In-Reply-To: <20240410233759.274907-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 11 Apr 2024 13:27:24 +1200
Message-ID: <CAGsJ_4y-3h7MrWj__CuYa83XxDwj7xP0JzQJtkTCxwNCPUMB5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:38=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Barry,
>
> On Tue,  9 Apr 2024 20:26:27 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > While swapping in a large folio, we need to free swaps related to the w=
hole
> > folio. To avoid frequently acquiring and releasing swap locks, it is be=
tter
> > to introduce an API for batched free.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/swap.h |  5 +++++
> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 11c53692f65f..b7a107e983b8 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> [...]
> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > +{
> > +}
>
> I found the latest mm-unstable fails build when CONFIG_SWAP is not set wi=
th
> errors including below, and 'git bisect' points this patch.
>
>     do_mounts.c:(.text+0x6): multiple definition of `swap_free_nr'; init/=
main.o:main.c:(.text+0x9c): first defined here
>
> I think this should be defined as 'static inline'?  I confirmed adding th=
e two
> keywords as below fixes the build failure.

definitely yes.
It's highly likely that it was an oversight. we definitely meant
static inline for !CONFIG_SWAP.
Thanks! will fix it in v3.


>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4bf5090de0fd..5fd60d733ba8 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -562,7 +562,7 @@ static inline void swap_free(swp_entry_t swp)
>  {
>  }
>
> -void swap_free_nr(swp_entry_t entry, int nr_pages)
> +static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
>  {
>  }
>
>
> Thanks,
> SJ
>
Thanks
Barry


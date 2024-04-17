Return-Path: <linux-kernel+bounces-148767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69D8A8720
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62066B24E34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D5146D54;
	Wed, 17 Apr 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/n9nMdW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3213959C;
	Wed, 17 Apr 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366688; cv=none; b=fLAABZJMCjBsgm7c1LWO52BJz0rKbafdej7qVpxhLHGM7a0d/OCuwN/mr+Tsjx8wIEshwkHHm3h6K01RP/b5yDh2cCoUSC+YegDrf7fi/v7swXvg15rfBie56636hh+aeWZiEcJeaS89gP45SmL0RYKFttXN91t4PHThPACPxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366688; c=relaxed/simple;
	bh=t47REENBHgTyAJl5sSR4ulw08Cn/48ssyIZyYCkJm68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWk8hEQRcMXQ6HwastscPqU1pfLomFK8NiAFMXF4HHPgjvHpiCoQsqWdhxBXXet4KHXYwGbA6DuKrVBk9x+D7D11h4csxeqgnR3q5q1ddbT5ylxvm7j73u8hPu98nRQTH7IlJP1EnwYooHLdJxlo2nX0Kery/BszQIdiaY5qZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/n9nMdW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso4786829b3a.2;
        Wed, 17 Apr 2024 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713366685; x=1713971485; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpBZLOS2Fuv5Seble3BWO+qJ4xS8G4uoQZKUk1ZQWaE=;
        b=d/n9nMdW2p7+KUcP04l8N/XO17ounDBIb8OXQjwIwapf+2ZLa1FApEANc5oVHIkzMw
         AhIN18XG+vDGIkpWXe183Llzq3l4+P2MIiT3Tp6m31k6oeq8f63Xux8ssDgwcQRGVFGk
         A/Bz/rTr4ZE2T0ggprtPi5UOh1Zz76cESkBz5a0K5NoLhLvQtcM3prILTaaTO/wg5ze9
         3b5UIBMM2Gx4gFp8lPpYkQ0dMZ2PpTaSONOTgWACG1J2h92ACL3gbxNmYc0+BAoTIyks
         Zu2ptfAYAX+7vKVjIrboDel4F8T7zcOxQES0vU7NweXbPUSFV7oszHStMcvl28+lrMVq
         Ivaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713366685; x=1713971485;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpBZLOS2Fuv5Seble3BWO+qJ4xS8G4uoQZKUk1ZQWaE=;
        b=JhEmRQGcW4Ndy31sQoZe1ZUZmculsT9zfPlFDMjjb6XfA9O5G67mZ6WA5i7ZNSoqOL
         zTLLFn2E7yIkiA38nN0LzhJM2Qr3dCm5nzmFxZFA43vzroNoY21Rpkcqw3nHlm1MJUMg
         jixt7uyJPz7rGPEg1p+LwPG1+/+1ZsJoNxeDGTVN9bwRPIyO38OIiv/T76Tc8ITA+9GC
         aYMfvqpegend56Si3YtVUSYF+6knqqatwhrxRZFB08Tkkf4myemBjN7WY9qew6EVagqQ
         rw8j10dgql+/fM5lHtfD1gtmGIifZz199e47Y83oyvUvSXg4oC0IZ35+0+VmFSRgEyxD
         RIMw==
X-Forwarded-Encrypted: i=1; AJvYcCX7RT69z9/MAp7XuNBOv7maAZDAhpspwwkfsXdWRZZWAPcdBt6uXUnVLq9U1EFF2jXSIdjHIMoblKLKrU8fwOOSGy8DxVi13jASOnPC
X-Gm-Message-State: AOJu0YwVkFMpjcUlFE/ehA23TTXCifieM/d+7YLkpW9Zm3K2XYpmU6WH
	hXUg61Agaon8+/BqIGzwVJoaYup8U9bp4VxByi6h50OttMiPifO1
X-Google-Smtp-Source: AGHT+IF60I58mUil+yAvrTASGIidkjvHH9ReBEji9jXZNYg8MVFL+W19+1BbY1JcwK3yslsobpUhyg==
X-Received: by 2002:a17:90b:388c:b0:2a4:7133:7e02 with SMTP id mu12-20020a17090b388c00b002a471337e02mr14723720pjb.35.1713366685168;
        Wed, 17 Apr 2024 08:11:25 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id b9-20020a17090a010900b002a67079c3absm1608837pjb.42.2024.04.17.08.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:11:24 -0700 (PDT)
Message-ID: <17066b6a4f941eea3ef567767450b311096da22b.camel@gmail.com>
Subject: Re: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size'
 field for pfmemalloc
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 17 Apr 2024 08:11:23 -0700
In-Reply-To: <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-10-linyunsheng@huawei.com>
	 <37d012438d4850c3d7090e784e09088d02a2780c.camel@gmail.com>
	 <8b7361c2-6f45-72e8-5aca-92e8a41a7e5e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 21:19 +0800, Yunsheng Lin wrote:
> On 2024/4/17 0:22, Alexander H Duyck wrote:
> > On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> > > The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
> > > system with page size less than 32KB, which is 0x8000 bytes
> > > requiring 16 bits space, change 'size' to 'size_mask' to avoid
> > > using the MSB, and change 'pfmemalloc' field to reuse the that
> > > MSB, so that we remove the orginal space needed by 'pfmemalloc'.
> > >=20
> > > For another case, the MSB of 'offset' is reused for 'pfmemalloc'.
> > >=20
> > > Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > ---
> > >  include/linux/page_frag_cache.h | 13 ++++++++-----
> > >  mm/page_frag_cache.c            |  5 +++--
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/include/linux/page_frag_cache.h b/include/linux/page_fra=
g_cache.h
> > > index fe5faa80b6c3..40a7d6da9ef0 100644
> > > --- a/include/linux/page_frag_cache.h
> > > +++ b/include/linux/page_frag_cache.h
> > > @@ -12,15 +12,16 @@ struct page_frag_cache {
> > >  	void *va;
> > >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > >  	__u16 offset;
> > > -	__u16 size;
> > > +	__u16 size_mask:15;
> > > +	__u16 pfmemalloc:1;
> > >  #else
> > > -	__u32 offset;
> > > +	__u32 offset:31;
> > > +	__u32 pfmemalloc:1;
> > >  #endif
> >=20
> > This seems like a really bad idea. Using a bit-field like this seems
> > like a waste as it means that all the accesses now have to add
> > additional operations to access either offset or size. It wasn't as if
> > this is an oversized struct, or one that we are allocating a ton of. As
> > such I am not sure why we need to optmize for size like this.
>=20
> For the old 'struct page_frag' use case, there is one 'struct page_frag'
> for every socket and task_struct, there may be tens of thousands of
> them even in a 32 bit sysmem, which might mean a lof of memory even for
> a single byte saving, see patch 13.
>=20

Yeah, I finally had time to finish getting through the patch set last
night. Sorry for quick firing reviews but lately I haven't had much
time to work on upstream work, and as you mentioned last time I only
got to 3 patches so I was trying to speed through.

I get that you are trying to reduce the size but in the next patch you
actually end up overshooting that on x86_64 systems. I am assuming that
is to try to account for the 32b use case? On 64b I am pretty sure you
don't get any gain since a long followed by two u16s and an int will
still be 16B. What we probably need to watch out for is the
optimization for size versus having to add instructions to extract and
insert the data back into the struct.

Anyway as far as this layout I am not sure it is the best way to go.
You are combining pfmemalloc with either size *OR* offset, and then
combining the pagecnt_bias with the va. I'm wondering if it wouldn't
make more sense to look at putting together the structure something
like:

#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
typedef u16 page_frag_bias_t;
#else
typedef u32 page_frag_bias_t;
#endif

struct page_frag_cache {
	/* page address and offset */
	void *va;
	page_frag_bias_t pagecnt_bias;
	u8 pfmemalloc;
	u8 page_frag_order;
}

The basic idea would be that we would be able to replace the size mask
with just a shift value representing the page order of the page being
fragmented. With that we can reduce the size to just a single byte. In
addition we could probably leave it there regardless of build as the
order should be initialized to 0 when this is allocated to it would be
correct even in the case where it isn't used (and there isn't much we
can do about the hole anyway).

In addition by combining the virtual address with the offset we can
just use the combined result for what we need. The only item that has
to be worked out is how to deal with the end of a page in the count up
case. However the combination seems the most logical one since they are
meant to be combined ultimately anyway. It does put limits on when we
can align things as we don't want to align ourselves into the next
page, but I think it makes more sense then the other limits that had to
be put on allocations and such in order to allow us to squeeze
pagecnt_bias into the virtual address.

Anyway I pulled in your patches and plan to do a bit of testing, after
I figure out what the nvme disk ID regression is I am seeing. My main
concern can be summed up as the NIC driver use case
(netdev/napi_alloc_frag callers) versus the socket/vhost use case. The
main thing in the case of the NIC driver callers is that we have a need
for isolation and guarantees that we won't lose cache line alignment. I
think those are the callers you are missing in your benchmarks, but
arguably that might be something you cannot test as I don't know what
NICs you have access to and if you have any that are using those calls.


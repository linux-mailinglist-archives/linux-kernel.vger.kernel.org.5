Return-Path: <linux-kernel+bounces-21056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C282891F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB151F258B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4239FF1;
	Tue,  9 Jan 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvN3Fyf6"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F639FDD;
	Tue,  9 Jan 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1257731a12.0;
        Tue, 09 Jan 2024 07:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814703; x=1705419503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WczyQ1l8jHhZlEcIGinjqLaLiGU6nueDfrDaoUhkza8=;
        b=TvN3Fyf6k87SR+zPi7lOYo0zUO6Rv3MAgXwjlQyl0CUb6SHjRgit8iSKrqf7qaMZEC
         dZXEnTGOm9KhOhSco+tRffNUy/Po/SnQjN1+OWOQ1yqKafXD74H0DblVW4LjHkwuCuqF
         mvcgim21VkCuBNI3zTGSBXiVgDoOEYDGEqzuWiFnM38A38BuCXvKYyZwzu1NAfIp0a8J
         I6WtoV0q7JhJhr3kNdjQNJ9c3ksbohaNQ0UwT1Y4rrxzsWSnG1SGk9gJe14aXFTMIzWb
         C4ggJPcB9Ss0HpFNhf3WqX3xbcBfQui/bBLBNSJ55pKvaAK8vv4gOiEtmGzqLvGWPwVx
         Q1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814703; x=1705419503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WczyQ1l8jHhZlEcIGinjqLaLiGU6nueDfrDaoUhkza8=;
        b=J7f87pZOOidt0rawALuGNKEV/yI91teMPTuk5BKrn02HZWytyE0al0GS6SJANZ1v7n
         Qb1eleeVZH/Towrf0z495OvVvMgYBraexDyRoz1hVPZbOt7VDCRB8B5GpYmY8fnHfuya
         u3V2A2c4NYX0Xuf4I6PVyVbQd8soyyTqD40IEp+UfTW6W4IZjGx0pllLLg34ThyI990p
         1qSfgqF1IAUVHANKVpmn+HXXv5FY4nEa6EGuYDQ1dsSd4lSM0dFNEKKXaQQnZfaaXImx
         pt/sSW+766ABqnPkKl/E02Odu82+ewxR9Kg4uF/r1F3/KoVeB3Oxmep928879eGZAWs6
         I5AQ==
X-Gm-Message-State: AOJu0YzMzXwwEXJsXKFGLdra60Pooch9smSQqCZxY2xzi41z78ktGY/W
	7idQTdT0ZW5TAmb4i+T4G0Mnvwro7hTsZD5LNvPY6kbi
X-Google-Smtp-Source: AGHT+IHqR/5JV65k1KfF5hME9odf6td4CQBJxUxdK4tDc79VgoizfxPtfCJOhfd0MhXfSkP+QdpawpbmNCQ8m+sKO5A=
X-Received: by 2002:a17:90b:364c:b0:28d:7947:1da0 with SMTP id
 nh12-20020a17090b364c00b0028d79471da0mr1816952pjb.29.1704814702732; Tue, 09
 Jan 2024 07:38:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-4-linyunsheng@huawei.com> <f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com>
 <74c9a3a1-5204-f79a-95ff-5c108ec6cf2a@huawei.com> <CAKgT0Uf=hFrXLzDFaOxs_j9yYP7aQCmi=wjUyuop3FBv2vzgCA@mail.gmail.com>
 <f138193c-30e0-b1ba-1735-5f569230724b@huawei.com>
In-Reply-To: <f138193c-30e0-b1ba-1735-5f569230724b@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 9 Jan 2024 07:37:46 -0800
Message-ID: <CAKgT0UcujEktOnHx7mxWd+Jah1J9mHFWnTx35vc3x25uUadxaA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] mm/page_alloc: use initial zero offset for page_frag_alloc_align()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 3:22=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/1/9 0:25, Alexander Duyck wrote:
> > On Mon, Jan 8, 2024 at 12:59=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
>
> ...
>
> >
> >>>
> >>> 2. By starting at the end and working toward zero we can use built in
> >>> functionality of the CPU to only have to check and see if our result
> >>> would be signed rather than having to load two registers with the
> >>> values and then compare them which saves us a few cycles. In addition
> >>> it saves us from having to read both the size and the offset for ever=
y
> >>> page.
> >>
> >> I suppose the above is ok if we only use the page_frag_alloc*() API to
> >> allocate memory for skb->data, not for the frag in skb_shinfo(), as by
> >> starting at the end and working toward zero, it means we can not do sk=
b
> >> coalescing.
> >>
> >> As page_frag_alloc*() is returning va now, I am assuming most of users
> >> is using the API for skb->data, I guess it is ok to drop this patch fo=
r
> >> now.
> >>
> >> If we allow page_frag_alloc*() to return struct page, we might need th=
is
> >> patch to enable coalescing.
> >
> > I would argue this is not the interface for enabling coalescing. This
> > is one of the reasons why this is implemented the way it is. When you
> > are aligning fragments you aren't going to be able to coalesce the
> > frames anyway as the alignment would push the fragments apart.
>
> It seems the alignment requirement is the same for the same user of a pag=
e_frag
> instance, so the aligning does not seem to be a problem for coalescing?

I'm a bit confused as to what coalescing you are referring to. If you
can provide a link it would be useful.

The problem is page_frag is a very generic item and can be generated
from a regular page on NICs that can internally reuse the same page
instance for multiple buffers. So it is possible to coalesce page
frags, however it is very unlikely to be coalescing them in the case
of them being used for skb buffers since it would require aligned
payloads on the network in order to really make it work without
hardware intervention of some sort and on such devices they are likely
allocating entire pages instead of page frags for the buffers.


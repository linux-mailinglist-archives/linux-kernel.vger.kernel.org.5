Return-Path: <linux-kernel+bounces-104178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4387CA45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87DB281781
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F917592;
	Fri, 15 Mar 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJX63zFI"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC291758B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492883; cv=none; b=nPbZl4HC2S+ODVHRMcDBVSHk4ZoBGutzl9Laj29/YW+OKq5YJKGCyvp69lRP1yEDTktQewEeGV65PHiWfuT+ullzIcdGeHOAcx75bnJlnF0Vmob0ccltSAbEZ5134MM+1Cr4938mFVp46bPhAtbMpHPb0AfEcH0Do76M8I2M26U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492883; c=relaxed/simple;
	bh=JViP3qBKT7RU/Pd5K0c1eTAz9GvGwPTHyi66oSh3fRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUukr/6pl39CBEWkJffpZnc7IsCqatRCkXC8nUuhqb+8AbMkPobHu3adsYZU4dUtHhBA8XitJonXWD8jotqFadsQOfHLlzTce9IsinFA+5bekaYqAEXXjMARF/UcaB+VxZ9KVE7RhyVKK25ynm/ahQtpzijqtAuj8VNysBoWqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJX63zFI; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d43a43c525so127156e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710492880; x=1711097680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o3putACmh6pvZaB1O5h2PNuqzbzyiR0a61BH01Aa3w=;
        b=JJX63zFIvvIFJjPD7H5c+Bcf1BxQjR7L7gK9dXw7ZMGU0RVZK3YomBtAM1kA8bLbTF
         nrfrKNi/DWm4wtOfs4T8nq70fGHP3qr234HShAEiFiCGdqm6lxLc59JkqMkj0ADycZ2R
         Y+xJurkHDfJa5qdfzv7TvG+05oWHSb6a2r1IfRyn9jqZaFsd6w05woh4IC+6J4rDZWWN
         rB9/A7gjRaP2mHSGROjkACTQBe3atSHppZcOjZcuxznPOakb5Si6zq2saEQuKYhpm+Y4
         4BtaB992IubU1KxIpZvF7rQIH6qyVHtii4bOsYLkE0P0bW3zuACr2x7WKUhrpgqhBgUt
         LwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710492880; x=1711097680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o3putACmh6pvZaB1O5h2PNuqzbzyiR0a61BH01Aa3w=;
        b=VUsSpSM2Dq3DeQOkna0BoO6ZOdk6GJTOn3LDid7QIz9ZxzOZiHB12xJJmQ8grCyz4D
         eGJhNTiIettK/IXNLBqHT2IkJX94deCsCVh9Dj00JKdej5y+AVi0VAfptpsda2XeZspp
         nFx47k5pLwPKJLMFCuIg5h+Pv8gfqV/PGMaBjgghFsEREUtC0oESzvBH4xKs0fDQuAtn
         5ar8h8AsW6wBdSp9lKDdjyFU/NxdPiniPZHk7BguGWQbmmpb1hYu4tlFz1Sx1gVmdx2+
         ur0k7+SFoqPPqhrOLPuL/245Dg35vthzgim+0+t7BLgIQ3p+DjhU67wz3zjnDuEoCIXr
         yKTw==
X-Forwarded-Encrypted: i=1; AJvYcCVz499sATZ7+Ld/wRQ7zI7bvnrYJ5u6/JR6FGIX4srhGrkAK2CmH2p/CJpygjcNiJF6tqFx4W4D+mxS/FE3HJRXN5tEAzIeBHU5Lyqd
X-Gm-Message-State: AOJu0YwIgWJH7tGYM3JN+VmrHnWhTuQXJm4hKgc4iLj1qqLYWHV1BVVe
	RGoKmre6BsSSI8lzKtdWCRQhFjprRyerLkjeoYXviuF35YpuURfSO6YVRFF+Ga7hrB8aK6xdPM3
	ws4SpzJa3mcscX0HosVJp/eOsrsE=
X-Google-Smtp-Source: AGHT+IFlSc4YIzOGH+cEsPWh2+3iHLC7a0Om34IIVLdDjrq1H0WV778wAKns3zhweO54J/S3on6vzfpaTN1ik88winQ=
X-Received: by 2002:a05:6122:913:b0:4d3:3846:73bb with SMTP id
 j19-20020a056122091300b004d3384673bbmr5073768vka.7.1710492880515; Fri, 15 Mar
 2024 01:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 15 Mar 2024 21:54:29 +1300
Message-ID: <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > On an embedded system like Android, more than half of anon memory is
> > actually in swap devices such as zRAM. For example, while an app is
> > switched to background, its most memory might be swapped-out.
> >
> > Now we have mTHP features, unfortunately, if we don't support large fol=
ios
> > swap-in, once those large folios are swapped-out, we immediately lose t=
he
> > performance gain we can get through large folios and hardware optimizat=
ion
> > such as CONT-PTE.
> >
> > This patch brings up mTHP swap-in support. Right now, we limit mTHP swa=
p-in
> > to those contiguous swaps which were likely swapped out from mTHP as a
> > whole.
> >
> > Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
> > case. It doesn't support swapin_readahead as large folios yet since thi=
s
> > kind of shared memory is much less than memory mapped by single process=
.
>
> In contrast, I still think that it's better to start with normal swap-in
> path, then expand to SWAP_SYCHRONOUS case.

I'd rather try the reverse direction as non-sync anon memory is only around
3% in a phone as my observation.

>
> In normal swap-in path, we can take advantage of swap readahead
> information to determine the swapped-in large folio order.  That is, if
> the return value of swapin_nr_pages() > 1, then we can try to allocate
> and swapin a large folio.

I am not quite sure we still need to depend on this. in do_anon_page,
we have broken the assumption and allocated a large folio directly.

On the other hand, compressing/decompressing large folios as a
whole rather than doing it one by one can save a large percent of
CPUs and provide a much lower compression ratio.  With a hardware
accelerator, this is even faster.

So I'd rather more aggressively get large folios swap-in involved
than depending on readahead.

>
> To do that, we need to track whether the sub-pages are accessed.  I
> guess we need that information for large file folio readahead too.
>
> Hi, Matthew,
>
> Can you help us on tracking whether the sub-pages of a readahead large
> folio has been accessed?
>
> > Right now, we are re-faulting large folios which are still in swapcache=
 as a
> > whole, this can effectively decrease extra loops and early-exitings whi=
ch we
> > have increased in arch_swap_restore() while supporting MTE restore for =
folios
> > rather than page. On the other hand, it can also decrease do_swap_page =
as
> > PTEs used to be set one by one even we hit a large folio in swapcache.
> >
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry


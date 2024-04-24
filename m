Return-Path: <linux-kernel+bounces-157263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E78B0F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA667297191
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65C16D9B4;
	Wed, 24 Apr 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJJ/h/UR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9116D9A7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974039; cv=none; b=iYaAHGNMVBxGO9msTX+fRBBS3t+rJz0kY2hGBIYzRuhlf3cW/zHRMMqqVkf4eSAa4XrJSZEfmjAl0feGlQM8MquIt7XuceRDxx5ADEP/EP68J93GVj+LIQWJs2S2m/tFbpzNgS6OymYesadE14fCnmOtdmHKXiN8ijiaFv+IIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974039; c=relaxed/simple;
	bh=oSIBvEYFQufLOSeNuipcF2ID6LflJ0sn5E3+hyfo8Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTyAtQNTIiL4h9LmQsY8pDeaIgwVoeLv2sotqwi4+N6yuvwqekv66MSLJdxsMHbC5/nHjfvqsSjaqxQD+Po9h4pAve6FgUWgMdo9Os3Dx0IIVsD/TSLWKv4SN942QcHYZ+ye1mfapLyb8cbIdV8+sPILpXAK+3e/8R3VhhEvObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJJ/h/UR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so7196159a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713974036; x=1714578836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3Ja+jaSkELp7vBLaUnSL8GZmoPq70Ks0f4l99kb0g8=;
        b=JJJ/h/UROaCup6S1irkgR0Vdvh8nrWZqZqEjOyHhbd9Kj+gEZjBJ++hzy0zUn1RqPk
         Y+axKrB2Dvp/8g4uEs1cKyJJhsYvNke0ljMazIeZrZkG1A7knudE9YApK+HI55UHkkHf
         AYDYlPpDoVj6U085CbOd9veIQQWGTcbxzww2OLlj/gGpfjr9d2GV3WPyN82Ox0OunDjU
         a9UtQqD1K2jhiQXRPXMeTk2+xIyV5RidKAWw1E+nIYvrXH64SQCO/PL7/srElQUW+CVV
         DWlhk+LeNPoyqk7hJZAQjwDhHEzvUYaA/Yag/CjP4qz8eZa88aPUYCWq9JS8WwSExQ0n
         aSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974036; x=1714578836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3Ja+jaSkELp7vBLaUnSL8GZmoPq70Ks0f4l99kb0g8=;
        b=tbhXk4vc5fLWgaCcTEj1RukTINxEBR959SGm8qpYdou7aNzrwrI/WE0u9k5N7inUxV
         lFHOyO2E911AYXRZmEuoDzSRAv2khoqqXpmiWrJmpl4bhj2fPfx3BUsL8mAGa/UBdqkk
         XAb6TBsO9/olw/xmiVatY1Y4DS3tPTHIK9k9rLXfw5ut7k3G0UBU3v0T/OlN0NR37LRz
         SpO/+DFNQxTkxISngasAGDjULqorCIuRS79+Z0zw6cD0vYK8/ax2KGV+XwagIlyXchsT
         ALyAYsi0wceBVMljHKX+aLCLBCQsF/7j5F2vZ8aeytsgcFNcCIbuBucFXZdlNdOwu+QP
         aIPw==
X-Forwarded-Encrypted: i=1; AJvYcCXvYOWBouk98jh6JpPYBmBpeBwIS5i9+E6WTbRryVZUsqsvDonBN+UqnqgvY9k3crflE90HXVIPhCCN4xohXYyJYgq1goWOUtfedz6V
X-Gm-Message-State: AOJu0Yz0NHdwquT99ZEDs32LGXPBz6qMkQ8fUD/1Ecb65KZEDEsqq0UJ
	eymBRggs9Ovo3vIqkSJShtiK4eSJ4slOOoG2t/QTs/zAVjWQI/lk48exOeDgn75nX5px4At6EV+
	8xZEOSHfcTTXVtWJCPPDwLlHLmUA=
X-Google-Smtp-Source: AGHT+IFjKvi6QfjflndQwbsKf7w5wgwctDpZw6RyU5pA1ZD2JSee+utve+e7IEivlSkXJdvUjWBmhQKatm/ymrNWsfE=
X-Received: by 2002:a50:d717:0:b0:572:229f:c55e with SMTP id
 t23-20020a50d717000000b00572229fc55emr1881227edi.27.1713974036410; Wed, 24
 Apr 2024 08:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
 <11455268-d522-4b3a-8961-892e42cc50f0@arm.com> <a1196e94-a4aa-4da2-95fa-b835abf79560@redhat.com>
In-Reply-To: <a1196e94-a4aa-4da2-95fa-b835abf79560@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 24 Apr 2024 23:53:45 +0800
Message-ID: <CAK1f24nHs5CjEn4DHm46e6g=RUGQReztRZRUzHtYuqCmvACqaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: introduce per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:29=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 24.04.24 17:20, Ryan Roberts wrote:
> > On 24/04/2024 16:00, David Hildenbrand wrote:
> >> On 24.04.24 15:51, Lance Yang wrote:
> >>> Hi all,
> >>>
> >>> At present, the split counters in THP statistics no longer include
> >>> PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
> >>> counters to monitor the frequency of mTHP splits. This will assist
> >>> developers in better analyzing and optimizing system performance.
> >>>
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >>>           split_page
> >>>           split_page_failed
> >>>           deferred_split_page
> >>>
> >>> Thanks,
> >>> Lance
> >>> ---
> >>>
> >>> Lance Yang (2):
> >>>    mm: add per-order mTHP split counters
> >>>    mm: add docs for per-order mTHP split counters
> >>>
> >>>    Documentation/admin-guide/mm/transhuge.rst | 16 ----------------
> >>
> >> We really have to start documenting these, and what the sementics are.
> >
> > I think the diffstat is backwards; the series definitely adds more line=
s than it
> > removes. And patch 2 is adding 16 lines of docs, not removing them. How=
 are you
> > generating this? `git format-patch` should do it correctly for you.
> >
> >>
> >> E.g., is split_page_failed contained in split_page? Is deferred_split_=
page
> >> contained in split_page?
> >>
> >> But also: just don't call it "split_page". Drop the "_page".
> >>
> >> split
> >> split_failed
> >> split_deferred
> >
> > I guess we are back in "should we be consistent with the existing vmsta=
ts"
> > territory, which uses split_page/split_page_failed/deferred_split_page
> >
>
> Yeah, "thp_split_page" really is odd "transparent huge page split page".
>
> > But here, I agree that dropping _page is nicer.
> Right; we also shouldn't call it "thp_split_page" here :)

Yep, I understood. Let's drop the "_page".

split
split_failed
split_deferred

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>


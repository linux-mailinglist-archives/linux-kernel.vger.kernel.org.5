Return-Path: <linux-kernel+bounces-7854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F881AE49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB71C22795
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C39467;
	Thu, 21 Dec 2023 05:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ABY/yVnT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02E8F52
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42784b919b9so3142391cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703135662; x=1703740462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPm674rXSCwxQgD/8kQz5c0fP5ST0f+zOSOq7hzl6LU=;
        b=ABY/yVnT42/nsZCOCl/TqM5yYplC5Pc9c+9LoSVUvV8STZqjIMgPeRq1Up4BD4jyCY
         aiMvVtn8ZJEpSbCOAibm7WDJtdhJeCRMFklJm9Y3eOnEr4mMwXa5jWS4coHon8X5A2Rn
         Xkt2orvO1S5cXC2KxRtYuwBY6XmrCG30MN+ZpmBoJbUGqBF9/hjc7QdfxxXaCYBRBin4
         SbbEkM59HefKpL84n/6qC6wzSlH4Ojrp0oBQLq76wSlox/BmG3eyglE9chVCdPefPGDH
         hEU6P6bhJw+/h1RJmOLY3yHg/IiauU5XLJrJG6MY+H/kLuAtN16A3Ewg4n9PQyjw3ccB
         1p0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703135662; x=1703740462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPm674rXSCwxQgD/8kQz5c0fP5ST0f+zOSOq7hzl6LU=;
        b=n0jRnmV8V0AuJEb3RXoS922gpRLBYZoPhZII3c0d0O4TCG2FiNYx36yjMakpMAM2Zo
         96ly+UV8NSTKd8Kr3KMtIMCd0HNxo1cO+mx5ShJ2qGlnvSRFETMx1vPNajbMyVNllT71
         6peCQ0b4KO8HhL6Al21t0Ez1nBcZ+I8yqbGUzn/DDecnSEWrlwl/2dm/rqlygeD490KT
         NcV5QgBfteC2zwDKCBiw0TR2AaJ2je4hhy+KUfgJsh/w5GAuHihy9BqK90Q05QGc9Sud
         e5CZZYP8E3JHUnrC59IE2FhXX/D3IZr/aBzdNf2+9N4iLLbqh69ac0jpdbEfh23tYzuK
         jlGw==
X-Gm-Message-State: AOJu0YypIKaLppkBCX+jFJ0jNNDqHsQAqkXtvwcXRZZgvgrKKDOWxKMl
	h2HdXPv+UNfYbybws0iN7TCivGNnCRed60CD42OAJg==
X-Google-Smtp-Source: AGHT+IFIF1kvdOQPV+kJwz+HvYp+BsGI4zVt5IRuyYg3yYDH4YeYNF4H2ORzJCxlpNLtqey20DUdsVzsI8tO4OwIYkI=
X-Received: by 2002:ac8:5747:0:b0:412:14a8:24c8 with SMTP id
 7-20020ac85747000000b0041214a824c8mr31395413qtx.8.1703135661768; Wed, 20 Dec
 2023 21:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com> <ZYO8IqiHeqs8LktJ@casper.infradead.org>
In-Reply-To: <ZYO8IqiHeqs8LktJ@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Dec 2023 00:13:45 -0500
Message-ID: <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:16=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > This series frees empty page tables on unmaps. It intends to be a
> > low overhead feature.
> >
> > The read-writer lock is used to synchronize page table, but most of
> > time the lock is held is reader. It is held as a writer for short
> > period of time when unmapping a page that is bigger than the current
> > iova request. For all other cases this lock is read-only.
> >
> > page->refcount is used in order to track number of entries at each page
> > table.
>
> Have I not put enough DANGER signs up around the page refcount?
>
>  * If you want to use the refcount field, it must be used in such a way
>  * that other CPUs temporarily incrementing and then decrementing the
>  * refcount does not cause problems.  On receiving the page from
>  * alloc_pages(), the refcount will be positive.
>
> You can't use refcount for your purpose, and honestly I'm shocked you
> haven't seen any of your WARNings trigger.

Hi Matthew,

Thank you for looking at this.

Could you please explain exactly why refcount can't be used like this?

After alloc_page() refcount is set to 1, we never reduce it to 0,
every new entry in a page table adds 1, so we get up-to 513, that is
why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to
dma_set_pte() macro. When refcount =3D=3D 1, we know that the page table
is empty, and can be added to a freelist for a delayed freeing.

What is wrong with using refcount for a scalable way of keeping the
track of number of entries in a iommu page table? Is there a better
way that I should use?

Thank you,
Pasha


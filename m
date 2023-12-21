Return-Path: <linux-kernel+bounces-7867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7681AE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C442F1C22F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC868AD59;
	Thu, 21 Dec 2023 05:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ShvOMFA3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972D69479
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4277e7146abso2872151cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703137398; x=1703742198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ+7iBxo9UNCq3UACj5AX8FQW70FsoHbqWsLyZj82EA=;
        b=ShvOMFA3uNQFIQZt2ju8p0PAeyUOZ64TfXzGfs9tVm2AT8AvuREvrMq9Z0y31m5iyZ
         WmHYKiqJc57S1g3/I81oYPYKo56/BGSLX+PFxQyNxKBBlW64p4lXV4c+qPUGyNDZ+x1x
         Pr0I/wxVbmUP7f5C2o8zw4BG0ktyJTZ6bIxsXoPjUDldjslEPjsRD/v1ncxK4ihUI+TG
         N3l/q8cs0ZsIgVwfwClnB2G6/B5KeFyBph7/oeygobMp3v3+kAtmRG1vtCprnNph/LiR
         zGnFJ0vcvW2f81it90ghNGNpejdvN4ZpdmHLVu6hRYWdoiUU+X4+XW4YtZSYTQjLRH6T
         +VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703137398; x=1703742198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJ+7iBxo9UNCq3UACj5AX8FQW70FsoHbqWsLyZj82EA=;
        b=oVFGV8kirK+M2VjLu3XJ4xOwogYdDnTjdALam5IS4Ae6zdGNq91PgD3FlJI2ZNHqLa
         Xm0GyAIjHlO0L0Zx7hxifiuJ8p7563X3125SQeXp/pGWCFPwMJra8Wtg4/0ltX53FYug
         QEptUyTXoD/8ksfU7Z8pOAUoQQJiT63K+OajUqcq7UtxDSInnjT773NWwgRFDtwC2ICi
         6Zlawq/wXiHogN/Ea7yuHX4PC+TG2POFN1Og7mN1SbMq6PFvm29TJsKuT3o2ORy9iPug
         AGSVCQ4g/8VQtbFj6BLpeqzlhDVeY1sW7ubW3CIokam9sU4DwCelym6k14lDmhuNjnNc
         6s4w==
X-Gm-Message-State: AOJu0YwYqLfsF+h5WsRCN0MnVcDIICnAYJgv9zv+auAQuSMXk11F7Zfv
	Fs0AxhdcdFRagcv7H3yNw8Ru7wW46ZUF5/Zwt17GwA==
X-Google-Smtp-Source: AGHT+IGNTma27AOTaiFA00vgHacTFo9EKx6mq0wCyTNP+SSrAwuhug3Cmgec+ueQwp7aSP6EkRkWH5adx8HhrJdS1AQ=
X-Received: by 2002:a05:622a:45:b0:417:fe9c:6dce with SMTP id
 y5-20020a05622a004500b00417fe9c6dcemr28795825qtw.25.1703137398455; Wed, 20
 Dec 2023 21:43:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <ZYO8IqiHeqs8LktJ@casper.infradead.org> <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
In-Reply-To: <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Dec 2023 00:42:41 -0500
Message-ID: <CA+CK2bAHLpRWJfHCAPzAjSzF8Hue1wK_SW5GxSue9rOW6OtT5Q@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:13=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Dec 20, 2023 at 11:16=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > > This series frees empty page tables on unmaps. It intends to be a
> > > low overhead feature.
> > >
> > > The read-writer lock is used to synchronize page table, but most of
> > > time the lock is held is reader. It is held as a writer for short
> > > period of time when unmapping a page that is bigger than the current
> > > iova request. For all other cases this lock is read-only.
> > >
> > > page->refcount is used in order to track number of entries at each pa=
ge
> > > table.
> >
> > Have I not put enough DANGER signs up around the page refcount?
> >
> >  * If you want to use the refcount field, it must be used in such a way
> >  * that other CPUs temporarily incrementing and then decrementing the
> >  * refcount does not cause problems.  On receiving the page from
> >  * alloc_pages(), the refcount will be positive.
> >
> > You can't use refcount for your purpose, and honestly I'm shocked you
> > haven't seen any of your WARNings trigger.
>
> Hi Matthew,
>
> Thank you for looking at this.
>
> Could you please explain exactly why refcount can't be used like this?
>
> After alloc_page() refcount is set to 1, we never reduce it to 0,
> every new entry in a page table adds 1, so we get up-to 513, that is
> why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to

I guess, what you mean is that other CPUs could temporarily
increase/decrease refcount outside of IOMMU management, do you have an
example of why that would happen? I could remove the above warning,
and in the worst case we would miss an opportunity to free a page
table during unmap, not a big deal, it can be freed during another
map/unmap event. Still better than today, where we never free them
during unmaps.

Pasha


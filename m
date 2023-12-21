Return-Path: <linux-kernel+bounces-8602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA081BA09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F8283DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D848CCC;
	Thu, 21 Dec 2023 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dZdS4uUD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DD360AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-20439c8296cso110872fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703170738; x=1703775538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADgCcEWTSu7tJptHDbPcOYurSOtNDMB0td089W0nlvQ=;
        b=dZdS4uUDdHQuQs42RTv+7gtOCH97gogEzNytwLj5P9q+RwnIU07gNQ4+VJrVWtWxjw
         FpYonUSr58SI7ubLUzup04NESOWtvGm89+laqtDFLSLihhDjJpRlmuuCs+745mCGJHq6
         kG57/W8+r90AkcGeJeTrUrC5cIOqEWr6Y+zMLHdAmCv7B3NcS7Xmpu6fbdVB9z8nF+h8
         ALaUa4VLKIRI7JbqtZ7Nlpof5uwJYiT6SsfBiVz3gwxYAzt3+SAwvOrIlA9DO+BZnMR6
         uGCBIF/BwLTPo3ya1qEctYtz9UHmZKLLFIllIzEYVzOed9Exo9g9Wsapx9L9mWaSCT7c
         B8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170738; x=1703775538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADgCcEWTSu7tJptHDbPcOYurSOtNDMB0td089W0nlvQ=;
        b=s0FtjrdixpAgBABviQQylFIH5BimMo/1nimF1C00x++2vgajuYeYn8iBH2igfNRCif
         MVtUTBG6wKvLTexs0ZyHyYbzj5GxEhz1+wzciDO15Y0nceeJ4ed8VOT7QghAnYfTEz/w
         NRDQArx3XdYSRz0Gl5SZR+3Rzy3gkX8nCjAKcsSZ3ds+akATebX6i4MA/lxLepsyOU9z
         hcugP6iX0ceETmQWf/HHIjg+kV48cIhjyE4wWHsJ8FPfKKQpeXfIzWK0bRbdARYqdBlv
         LrGYEyh9uySMaHSsuTmr6u6XEdnUXLk+F52JK2XpQ53HCXqRAoPrxzeRxwKLJ3pbSkHx
         dENA==
X-Gm-Message-State: AOJu0YzpPZ6Y+eVSLQcYQATVj2Cl2KTCbm5fOsxsOOso0NIJcprmb+Kb
	q33yilmYdH5UQ012MrhiNQbL0DcwG44MI5GRTFl9o4oB+6G9k3wr5BA=
X-Google-Smtp-Source: AGHT+IETQwSqKPcARlSTqvGAKMyDahi+ld9dUal/ANt/1wL90IX8u4caH+uMMeSXpiFCQt+AXRLu31ANep+1kMW99Es=
X-Received: by 2002:a05:6870:148e:b0:203:30c6:295 with SMTP id
 k14-20020a056870148e00b0020330c60295mr1281924oab.0.1703170738280; Thu, 21 Dec
 2023 06:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221031915.619337-1-pasha.tatashin@soleen.com>
 <ZYO8IqiHeqs8LktJ@casper.infradead.org> <CA+CK2bBJuZPF5yC2Axo0S_P4ApjwgBWu9YwnDo+yOiOiL16Bhg@mail.gmail.com>
 <CA+CK2bAHLpRWJfHCAPzAjSzF8Hue1wK_SW5GxSue9rOW6OtT5Q@mail.gmail.com> <ZYRGSv0OzJknmVPY@casper.infradead.org>
In-Reply-To: <ZYRGSv0OzJknmVPY@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 21 Dec 2023 09:58:20 -0500
Message-ID: <CA+CK2bAjsv5CM8YhYeRFCwjN6OdqKZxvvOHs-CQgpVQFATS0LA@mail.gmail.com>
Subject: Re: [RFC 0/3] iommu/intel: Free empty page tables on unmaps
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rientjes@google.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 9:06=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Dec 21, 2023 at 12:42:41AM -0500, Pasha Tatashin wrote:
> > On Thu, Dec 21, 2023 at 12:13=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 11:16=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 03:19:12AM +0000, Pasha Tatashin wrote:
> > > > > This series frees empty page tables on unmaps. It intends to be a
> > > > > low overhead feature.
> > > > >
> > > > > The read-writer lock is used to synchronize page table, but most =
of
> > > > > time the lock is held is reader. It is held as a writer for short
> > > > > period of time when unmapping a page that is bigger than the curr=
ent
> > > > > iova request. For all other cases this lock is read-only.
> > > > >
> > > > > page->refcount is used in order to track number of entries at eac=
h page
> > > > > table.
> > > >
> > > > Have I not put enough DANGER signs up around the page refcount?
> > > >
> > > >  * If you want to use the refcount field, it must be used in such a=
 way
> > > >  * that other CPUs temporarily incrementing and then decrementing t=
he
> > > >  * refcount does not cause problems.  On receiving the page from
> > > >  * alloc_pages(), the refcount will be positive.
> > > >
> > > > You can't use refcount for your purpose, and honestly I'm shocked y=
ou
> > > > haven't seen any of your WARNings trigger.
> > >
> > > Hi Matthew,
> > >
> > > Thank you for looking at this.
> > >
> > > Could you please explain exactly why refcount can't be used like this=
?
> > >
> > > After alloc_page() refcount is set to 1, we never reduce it to 0,
> > > every new entry in a page table adds 1, so we get up-to 513, that is
> > > why I added warn like this: WARN_ON_ONCE(rc > 513 || rc < 2); to
> >
> > I guess, what you mean is that other CPUs could temporarily
> > increase/decrease refcount outside of IOMMU management, do you have an
> > example of why that would happen? I could remove the above warning,
> > and in the worst case we would miss an opportunity to free a page
> > table during unmap, not a big deal, it can be freed during another
> > map/unmap event. Still better than today, where we never free them
> > during unmaps.
>
> Both GUP-fast and the page cache will find a page under RCU protection,
> inc it's refcount if not zero, check the page is still the one they were
> looking for, and if not will dec the refcount again.  That means if a
> page has been in the page cache or process page tables and you can't
> guarantee that all CPUs have been through the requisite grace periods,
> you might see the refcount increased.

Interesting scenario, it sounds like this could only happen for a
short period of time at the beginning of the life of a page in the
IOMMU Page Table.


> I'm not prepared to make a guarantee that these are the only circumstance=
s
> under which you'll see a temporarily higher refcount than you expect.
> Either currently or in the future.  If you use the refcount as anything
> other than a refcount, you're living dangerously.  And if you think that
> you'll be the one to do the last refcount put, you're not necessarily
> correct (see the saga around __free_pages() which ended up as commit
> e320d3012d25 fixed by 462a8e08e0e6 (which indicates the rare race does
> actually happen)).
>
> Now, it seems like from your further explanation that the consequence
> of getting this wrong is simply that you fail to free the page early.
> That seems OK, but I insist that you insert some comments explaining
> what is going on and why it's safe so somebody auditing uses of refcount
> doesn't have to reanalyse the whole thing for themself.  Or worse that
> somebody working on the iommu sees this and thinks they can "improve"
> on it.

Yes, I can add detailed comments explaining how refcount is used here.

Alternatively, I was thinking of using mapcount:

From mm_types.h:
  * If your page will not be mapped to userspace, you can also use the
four
  * bytes in the mapcount union, but you must call
page_mapcount_reset()
  * before freeing it.

It sounds like we can safely use _mapcount for our needs, and do
page_mapcount_reset() before freeing pages.

Pasha


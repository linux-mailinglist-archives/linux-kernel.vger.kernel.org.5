Return-Path: <linux-kernel+bounces-2098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D5C8157D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831AFB2465A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E718EBC;
	Sat, 16 Dec 2023 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tieEw99H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7E18EA2
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so13685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702705341; x=1703310141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZxU/xNtlxK/F9kKvupxkk7sTWH9I5Xz1N4dDK+pUzA=;
        b=tieEw99Hjjw+rWgeTxz0a0kxlSK0/LTIosbSjYZDSN7toWs4Jc77n4O4LIQ4M4oIY5
         lW6cGNht9nt61ZjGusrIel8z6R9jDuWbVG+a1T5/MrYn+txXrfMymm6kJFU25p1XW29f
         hS7LfqGwCeaCuKGbTntZcukXQfYIDjHk5X6kFrsHEVgKxwo9aiSSVzmSQtse/fZnblMb
         ig5gwZINK0GAHtdVEk2SSkKmEEIlvmtQuYgyklQ3LJ2QfQ1xnx2gHxbch/BxWmTgh1oZ
         FDGLUIJtQN74qJmdoYP4GY/d7wHTs8bEePLwS/FdHG+8ZJ1iJsuauKBYay1N2qQXi3Sn
         97Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702705341; x=1703310141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZxU/xNtlxK/F9kKvupxkk7sTWH9I5Xz1N4dDK+pUzA=;
        b=EIVwEnL08quZeHdtiH4hNWOPwIZh9efP4Ms1Tr/4mZKTzjWQt5Z+MqZH0Ke4MXqx5P
         B5x1BEOM03nkGn8W1Ulw/emEGA+fDYu66v7buj3lbr1oxX+44494KlNEI4To8pqIuSdG
         cdzBvfDcMFCsShl55tvk7NWo2oFCB5HBhmGIpWOAJog+9Fflq8wz5QYGSm7GTzklUDWE
         XbqBWwqC3rn7vQ5R1ivJlO09lydhXSvfjGT3sADVq4LP2cghw1XVLiSdNFEKF8mFsnFF
         kMDGAIbu7HCrq827lhkunauE+C5CFh6RuP9CYu+1djCrQFV/tIbQW8IjuqJMnfmWMvpV
         o11Q==
X-Gm-Message-State: AOJu0YwUY5LG9wisv6kpaR+woHUB+70DwhbZqlybAPs1lJcUpK2H82le
	kT1eoMDViL3UoNhd/HgEjKudq2WDGX6bTK2QUIYL1dpc9LcA
X-Google-Smtp-Source: AGHT+IGBp8DgO64Esyen3cNHiFpC/h//ErNRoPzt7koddG8tG2ej6Wf+hjtuf/SKb+47LIi1BySk4yJ811YrN78xU7s=
X-Received: by 2002:a05:600c:68d0:b0:40c:f992:17b with SMTP id
 jd16-20020a05600c68d000b0040cf992017bmr5627wmb.0.1702705340931; Fri, 15 Dec
 2023 21:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
 <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com> <MW5PR11MB5907BA0C9546C069925C9955F293A@MW5PR11MB5907.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5907BA0C9546C069925C9955F293A@MW5PR11MB5907.namprd11.prod.outlook.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 15 Dec 2023 22:41:42 -0700
Message-ID: <CAOUHufbDzy5dMcLR9ex25VdB_QBmSrW_We-2+KftZVYKNn4s9g@mail.gmail.com>
Subject: Re: mm/DAMON: Profiling enhancements for DAMON
To: "Prasad, Aravinda" <aravinda.prasad@intel.com>
Cc: "damon@lists.linux.dev" <damon@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"sj@kernel.org" <sj@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "s2322819@ed.ac.uk" <s2322819@ed.ac.uk>, 
	"Kumar, Sandeep4" <sandeep4.kumar@intel.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"Subramoney, Sreenivas" <sreenivas.subramoney@intel.com>, 
	"Kervinen, Antti" <antti.kervinen@intel.com>, 
	"Kanevskiy, Alexander" <alexander.kanevskiy@intel.com>, Alan Nair <alan.nair@intel.com>, 
	Juergen Gross <jgross@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 3:08=E2=80=AFAM Prasad, Aravinda
<aravinda.prasad@intel.com> wrote:
>
> > On Fri, Dec 15, 2023 at 12:42=E2=80=AFAM Aravinda Prasad
> > <aravinda.prasad@intel.com> wrote:
> > ...
> >
> > > This patch proposes profiling different levels of the application=E2=
=80=99s
> > > page table tree to detect whether a region is accessed or not. This
> > > patch is based on the observation that, when the accessed bit for a
> > > page is set, the accessed bits at the higher levels of the page table
> > > tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> > > are also set. Hence, it is efficient to  check the accessed bits at
> > > the higher levels of the page table tree to detect whether a region i=
s
> > > accessed or not.
> >
> > This patch can crash on Xen. See commit 4aaf269c768d("mm: introduce
> > arch_has_hw_nonleaf_pmd_young()")
>
> Will fix as suggested in the commit.
>
> >
> > MGLRU already does this in the correct way. See mm/vmscan.c.
>
> I don't see access bits at PUD or PGD checked for 4K page size. Can you
> point me to the code where access bits are checked at PUD and PGD level?

There isn't any, because *the system* bottlenecks at the PTE level and
at moving memory between tiers. Optimizing at the PUD/PGD levels has
insignificant ROI for the system.

And food for thought:
1. Can a PUD/PGD cover memory from different tiers?
2. Can the A-bit in non-leaf entries work for EPT?

> > This patch also can cause USER DATA CORRUPTION. See commit
> > c11d34fa139e ("mm/damon/ops-common: atomically test and clear young
> > on ptes and pmds").
>
> Ok. Will atomically test and set the access bits.
>
> >
> > The quality of your patch makes me very much doubt the quality of your
> > paper, especially your results on Google's kstaled and MGLRU in table 6=
.2.
>
> The results are very much reproducible. We have not used kstaled/MGLRU fo=
r
> the data in Figure 3, but we linearly scan pages similar to kstaled by im=
plementing
> a kernel thread for scanning.

You have not used MGLRU, and yet your results are very much reproducible.

> Our argument for kstaled/MGLRU is that, scanning individual pages at 4K
> granularity may not be efficient for large footprint applications.

Your argument for MGLRU is based on a wrong assumption, as I have
already pointed out.

> Instead,
> access bits at the higher level of the page table tree can be used. In th=
e
> paper we have demonstrated this with DAMON but the concept can be
> applied to kstaled/MGLRU as well.

You got it backward: MGLRU introduced the concept; you fabricated a
comparison table.


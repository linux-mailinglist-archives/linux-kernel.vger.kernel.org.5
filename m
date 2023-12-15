Return-Path: <linux-kernel+bounces-622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14948143AE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A73281CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84B134BF;
	Fri, 15 Dec 2023 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSUETJ/w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117B510A17
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c38e520e2so45905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702629237; x=1703234037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH00aA121x0wt9tSYv6S52kB6dsUFNy2Wev1qwKspsw=;
        b=kSUETJ/woFRbUzlSBqWIfTwDiPb5FTvW1lrXytd8Qvq+eHIIfiSqGWDJjezXfoi4XT
         /YYtZs1MLgaAPxkPJrxoS+V/b+3Hu6mCnQNVbjvptQGDDIiwl+ev88jB8XVjrp7pPMpT
         IQBTLzcTp/zL9p0DecFpAEB5wcFG0mX0nx/nLDgLBqXRfmELy+P5B5KWObmcoiGQxEBA
         1FE0eDfsl6veGrHftp1FAfMVMbCANuGH3liF36DtS4Q5lBHZ6Y/XgBaPZrp8sutLErbj
         ZT0pAL3E2CdLXjk1xIIcgYq9jHm/6HCffhqxb49Yo3BRA64JzjQhHhMRd/YcKOtPQv6t
         bUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629237; x=1703234037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH00aA121x0wt9tSYv6S52kB6dsUFNy2Wev1qwKspsw=;
        b=Id7IlaKmpudnt704DMlhQvEHfmCl2DAnGIylGLOuLfh+MN5/8JY+Achr4lSo8F0XJx
         +ifpTYa+o+fIZwbDzdLR5ZybDeSI4biUjO3mq7uAVCJm63vqvv+noCixZOKLEDB5PRLZ
         QCiBBj1B5+NQ2HLhCxhMNF0q8cR4l/a01Yj1h9Gqffz6tdEHLGp6b9A24Dqu+jMqQvmh
         pZO4p2WqLBEfOe1X925htnVJwRX9JzWiL77TUxT9uzD3vbXpUybuKQYuI/2OKxvpyYfo
         m818H/lKJhrYmgA8oNoRemTscLjB3ZJRhUzBxwQm6tAffP1HDQyE+CpA7snTsmN4G+q8
         WDOA==
X-Gm-Message-State: AOJu0YzkXEvfiRQJflbPHkQa6Zveu2GW/LYz7mfzX9J3PzvgFaqql+nq
	YEZBbmJkRwkAWVpdVd8Ev+yi0tMqXn8x6hepHQaMbQ==
X-Google-Smtp-Source: AGHT+IHCuoXmKPQdsauUyid8g8apT+ABo8Z6QF3/4ZQ1AenTe8DJq9g9olKXx/VBUVe3CcDC3sKuimKTrwfQbh2Q6qU=
X-Received: by 2002:a05:600c:5113:b0:40c:329:d498 with SMTP id
 o19-20020a05600c511300b0040c0329d498mr624641wms.1.1702629237109; Fri, 15 Dec
 2023 00:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215074619.173787-1-aravinda.prasad@intel.com>
In-Reply-To: <20231215074619.173787-1-aravinda.prasad@intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 15 Dec 2023 01:33:18 -0700
Message-ID: <CAOUHufZW8ZbNDnu3Cfc61oJ4FkXK+AbT90XpS5Ei++1_5mcFFQ@mail.gmail.com>
Subject: Re: mm/DAMON: Profiling enhancements for DAMON
To: Aravinda Prasad <aravinda.prasad@intel.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, s2322819@ed.ac.uk, sandeep4.kumar@intel.com, 
	ying.huang@intel.com, dave.hansen@intel.com, dan.j.williams@intel.com, 
	sreenivas.subramoney@intel.com, antti.kervinen@intel.com, 
	alexander.kanevskiy@intel.com, Alan Nair <alan.nair@intel.com>, 
	Juergen Gross <jgross@suse.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:42=E2=80=AFAM Aravinda Prasad
<aravinda.prasad@intel.com> wrote:
...

> This patch proposes profiling different levels of the application=E2=80=
=99s
> page table tree to detect whether a region is accessed or not. This
> patch is based on the observation that, when the accessed bit for a
> page is set, the accessed bits at the higher levels of the page table
> tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> are also set. Hence, it is efficient to  check the accessed bits at
> the higher levels of the page table tree to detect whether a region
> is accessed or not.

This patch can crash on Xen. See commit 4aaf269c768d("mm: introduce
arch_has_hw_nonleaf_pmd_young()")

MGLRU already does this in the correct way. See mm/vmscan.c.

This patch also can cause USER DATA CORRUPTION. See commit
c11d34fa139e ("mm/damon/ops-common: atomically test and clear young on
ptes and pmds").

The quality of your patch makes me very much doubt the quality of your
paper, especially your results on Google's kstaled and MGLRU in table
6.2.


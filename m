Return-Path: <linux-kernel+bounces-23987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B982B4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10661F258FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844ED482CD;
	Thu, 11 Jan 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3M7p5k/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4D15E9B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso52530351fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998163; x=1705602963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+9IdcfjTa3iO0dEF90n8tIKBurthG1aFX3cozD5M7U=;
        b=Q3M7p5k/dTuOXct4M50OPwAdPIaiuWiVKB2YvE+DYrEWIM+aMkx8BN4zSaSgEuBJO9
         VJkM61UPTSnXFnHeuwLDj58kv75aCstVQCnI1iwNFhKLPu9Ijw8gCgBn+DkA34ozq6rQ
         ritgR79tF1ohrNHypHdgb649jLwJSZnYIO9WACcFsfhdu7yAoNyyW0s7NXigYvEzNS9X
         sT+4K4l20bVOVB4PkVNbE/ihQzwjXeo6zaGT4h/EtypD14w6waDoRiBg0v2M2eIxfL7a
         hIpUmUkh9D+Niu1vvjWfXdI8HY2G2Iz0Cj4wg2jTxXhzCbcG0VaKvR+JC1uK5BDhhxkq
         xVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998163; x=1705602963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+9IdcfjTa3iO0dEF90n8tIKBurthG1aFX3cozD5M7U=;
        b=Nw+NPoegwM7jGArOaDDLPk2nBhlZBC1xVFMGFKr2r43r1wyqfgT11qm535UUIcKmXB
         x7B7ECTc2Lk6t8+87X3kTBBZt4vY8Bl+cm7o/RunGrhowvoP6EAQfTSYWPmUNJFB4lAy
         9ZprmL4dIKM+bTP9wXOIdQ3jGivwxzhSi7K2MvPxdFNXKKSA4uRRNasRvTECcmUtrF/N
         HizvSqlCQKANphAqseI8xgNxITwngENUTLeNLnLUiUy9/LTyUMoEXqR+pVcmegvihqgw
         mkk3GskdG5/eJvcZjBruZoAcXXcnbBapJSHycY7Jlo0Sno6rgQOIiz81+s6sKoTgD2FP
         Pr2w==
X-Gm-Message-State: AOJu0Ywy4OndJep4vNo1yT6fGnLLJTmXtLFE6GI1mqPtB9NoGj8AYEu5
	k2Wo02XSVzM+IB0KyO1dTNpIgjE3kYq+zpzU+rjN6GP8nqYnqO0g
X-Google-Smtp-Source: AGHT+IHknuIFSutD90DRwrXE5mAgq1JxeMGNP64vG2FKj0TtltHD/vv70cWZa1XEeucUa8Dj4SkdsLRMAawZ0DuIB54=
X-Received: by 2002:a2e:8096:0:b0:2cc:d4f3:aa3d with SMTP id
 i22-20020a2e8096000000b002ccd4f3aa3dmr141473ljg.11.1704998163135; Thu, 11 Jan
 2024 10:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111183321.19984-1-ryncsn@gmail.com> <20240111183321.19984-4-ryncsn@gmail.com>
In-Reply-To: <20240111183321.19984-4-ryncsn@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 12 Jan 2024 02:35:46 +0800
Message-ID: <CAMgjq7B-RSmDp_z4+JnE2gGgv=Hhgntgn3pwxpke=6VrnTVYtw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm, lru_gen: try to prefetch next page when
 canning LRU
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=BA=94 02:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Kairui Song <kasong@tencent.com>
>
> Prefetch for inactive/active LRU have been long exiting, apply the same
> optimization for MGLRU.
>
> Ramdisk based swap test in a 4G memcg on a EPYC 7K62 with:
>

Hi, my applogize, I just realize I forgot to fix the typo in title
right after I send the patch... it should be:
mm, lru_gen: try to prefetch next page when scanning LRU


Return-Path: <linux-kernel+bounces-149265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2A8A8E51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C0A1C20E20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF94280C14;
	Wed, 17 Apr 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="nm8wEsSq"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDE171A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713390455; cv=none; b=pInEXAerYo67VY9Je/xcteLWIsG8GAZbFAZUktMEzl/gFH5fQs/shhOUaxp6sTJJPYl+gIdcCN2mQLZryZZwnJtCJ5S3L/E/rxqcfrqtyiIAcwySzIJgy5q5yLNlPe2ICNIHVJRid3s32QVVy+XJz4xNtlr2hkBazMvaNrVW7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713390455; c=relaxed/simple;
	bh=9n8aoljlS75OypXFfvihsUi54EFsm65ZrG/89JossSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU+GvzTxewqdo/1wYIonSPSj7lClMGd2k+ZIulOlJJaR5r06E6HezMlgbSpXEBQvRJ/SvoIN+Bmw30SEPb1zxB1RWRbK2PRnYbvlkh9eVVJNDbc8xx2/LXHFUMLH+13CBhdjLmv2If5kjdn/H5V9d2cVLeGnwtTf3pQoTYJ2D6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=nm8wEsSq; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa2dcd4454so148581eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1713390452; x=1713995252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmulQn+gdZ586eXpEQk2xoZjXqI9D8aPenCnZ4BNJ8U=;
        b=nm8wEsSq+mGOmCMRMp/rDkjDNQLdwjOHwUMWk1fTVLoMFmc6g1WqKFvm03jdOSQS7X
         hBdaumIQUUEjIHjONZXtbhVBNCU3zwx9HQh7XS89wZ0j1hw8VnDtr2S50WSIFvXp9xS0
         JX91uRSCrtyvofaYTtBzsUUFN47h4a5j7t+uTilq1km/4kwTouPlyQ4zYKmkxsFVzEs6
         m4tDJzZk2jPqsIezLVZzy1Oj8EQddE5P7QopzL/r8dyWsCbmM713Dudk+uZF2C7qQ8KA
         5m394HdkKXAFAyOw0W5zY1zxURT6t6LZ07/SDbtIkGu3w/9LemCeL+NFamPkTLIi8WsS
         iN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713390452; x=1713995252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmulQn+gdZ586eXpEQk2xoZjXqI9D8aPenCnZ4BNJ8U=;
        b=VVn62aAx22C2Gnm/LNdIdklZ/Phur+4PVjEQnN9kE8P85U2OnOw/MAlwo13k8htKCE
         f9RUpZwe0uODqG2Cb7Z319npdR9juj3gZk4cLNugg/GOt/B15R5avczWtLMHKihewKZY
         3v1u43QWlYN/W2wTTU0OY7qed39JJ69DtLK9oum8OUvm81wIiaPWIBEEEUsAqdksN/lB
         HMdjSkVaVtF+HoUjhUoH4e6TWmZu5850uCYWN9E7Vis2A0F7Cx0TxjnHJVtyxiF6xDfn
         5gofi6fEIlNOsGYIWy1UyvvoV0Xf0gPkjBbLQRKHRB79yg8g5FoNhDOQeYwrAbA3P/LX
         zb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYUZA4oPSbaP+EvitrrzCMR2QGmXXvxHfZo0g6AGaysflwQMVJ5QiRKC6qtAJehRMPxjEfF1AfetUFsivp2s3gmi4GOk2fD1Cj3bFx
X-Gm-Message-State: AOJu0YzhmVWPyOGg1CXS370bfeixmZzAWkuri20HDqG7tXD3TSfiLGUH
	TAog0mhMAichDqTBN+fq/7omdzBkoenAp/WSoVBg9qzBi6Vb3s+QQYLt9jJHV9g8NumFfnLKnDq
	ASJik669Ekn/wKvUHVmiJCw6rTX3V45CG+UWAvw==
X-Google-Smtp-Source: AGHT+IFltKLNyXvfsZnHJ8aQZWbDyz1ZTSN1F2IAMVstdK4F5vJWK81F/masRDC8TL+WYVAEdp+qq40PFv4FFf+vxlM=
X-Received: by 2002:a05:6359:5347:b0:186:1ec5:493b with SMTP id
 ns7-20020a056359534700b001861ec5493bmr1032975rwb.0.1713390452577; Wed, 17 Apr
 2024 14:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417212549.2766883-1-peterx@redhat.com>
In-Reply-To: <20240417212549.2766883-1-peterx@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Apr 2024 17:46:56 -0400
Message-ID: <CA+CK2bB9x+ErL+Kx+50DL-8gRSYW6vFen+bFe+cgXPKfuwpG3g@mail.gmail.com>
Subject: Re: [PATCH v4] mm/page_table_check: Support userfault wr-protect entries
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Nadav Amit <nadav.amit@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:25=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Allow page_table_check hooks to check over userfaultfd wr-protect criteri=
a
> upon pgtable updates.  The rule is no co-existance allowed for any writab=
le
> flag against userfault wr-protect flag.
>
> This should be better than c2da319c2e, where we used to only sanitize suc=
h
> issues during a pgtable walk, but when hitting such issue we don't have a
> good chance to know where does that writable bit came from [1], so that
> even the pgtable walk exposes a kernel bug (which is still helpful on
> triaging) but not easy to track and debug.
>
> Now we switch to track the source.  It's much easier too with the recent
> introduction of page table check.
>
> There are some limitations with using the page table check here for
> userfaultfd wr-protect purpose:
>
>   - It is only enabled with explicit enablement of page table check confi=
gs
>   and/or boot parameters, but should be good enough to track at least
>   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
>   x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
>   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], whi=
ch
>   is similar.
>
>   - It conditionally works with the ptep_modify_prot API.  It will be
>   bypassed when e.g. XEN PV is enabled, however still work for most of th=
e
>   rest scenarios, which should be the common cases so should be good
>   enough.
>
>   - Hugetlb check is a bit hairy, as the page table check cannot identify
>   hugetlb pte or normal pte via trapping at set_pte_at(), because of the
>   current design where hugetlb maps every layers to pte_t... For example,
>   the default set_huge_pte_at() can invoke set_pte_at() directly and lose
>   the hugetlb context, treating it the same as a normal pte_t. So far it'=
s
>   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() =
as
>   long as supported (x86 only).  It'll be a bigger problem when we'll
>   define _PAGE_UFFD_WP differently at various pgtable levels, because the=
n
>   one huge_pte_uffd_wp() per-arch will stop making sense first.. as of no=
w
>   we can leave this for later too.
>
> This patch also removes commit c2da319c2e altogether, as we have somethin=
g
> better now.
>
> [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/
>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Rename __page_table_check_pxx() to page_table_check_pxx_flags(),
>   meanwhile move the pte check out of the loop [Pasha]
> - Fix build issues reported from the bot, also added SWP_DEVICE_WRITE whi=
ch
>   was overlooked before
> v3:
> - Add missing doc update [Pasha]
> v4:
> - Fix wordings in doc, use more elegant swap helpers [Pasha]
> ---
>  Documentation/mm/page_table_check.rst |  9 +++++++-
>  arch/x86/include/asm/pgtable.h        | 18 +---------------
>  mm/page_table_check.c                 | 30 +++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 18 deletions(-)

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha


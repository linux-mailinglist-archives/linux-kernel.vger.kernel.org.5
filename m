Return-Path: <linux-kernel+bounces-85839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E686BC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FB01C22FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359C13D304;
	Wed, 28 Feb 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZEdSrAA"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6D13D2F2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162310; cv=none; b=EzeS83S6NYOr+TvIRZrgtbFzkmWP7KHgygchIuDX/4VRWtAWubQsgmyhxAoChIk6N8/pWDUuEV8v+GXMJDqZ+yQUPRzCXFWlCy9W0THvE4JrrXIlPB+qfNUOf0jfSM1+ly/tmN+pWVunjJBsfFbpnH1AvBy6hEYszpgeZtAEAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162310; c=relaxed/simple;
	bh=1PRdfMtS+AJe7vKkktEZrVdDpgYrCNHily3OOONKHOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyLlvxFKMuSOtesTFXIHIPu8v21uNt2xQnkYU0d6cL3DFsDmprOeRKoYzLROeNDlpYKkw2UgPao/aZOye7s6/lrrarOe29tuUvU7DXqnj7XFMvpcTXc0omchApGuK2FS6iYQ2CK5VfCkAy1uakBQBhB3Mc8WXzjZA3WGD96Fm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZEdSrAA; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d147f87bb6so86598e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162308; x=1709767108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgfsSS2pCIePMWBGptAQ7Z9dl3gs0fMNB2rNkVErCLs=;
        b=OZEdSrAAfvrYL7bXpA9ZDCgAO/HH2AujDuqd2wX11O3RLqA6zubKBzwek15Esx+4d2
         D5piX+Oxs1P1tAJ1RSiyQW1NPxcfVZ+LymCk/TG9kX3GGyPYiyfcHJO+QJ3Opk88zKS/
         2T16PDJNWb6bzdhIec/aNJFIUl2EFyR5ok32KBrldMPEvhsQMVJPVFo4mCziP5uSSWet
         nvZkmEqffnQygisIByk9CwQJY3Hd1lsNaBln70u/p/SNhDInWN9Drqk3bTiPakXQXXa3
         Vr4/s8kG6Cp7UvczS2oN3SepKghiONfWHYCheGxatzamGfG9kdklYnTj+xn21p0BJD7V
         Yu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162308; x=1709767108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgfsSS2pCIePMWBGptAQ7Z9dl3gs0fMNB2rNkVErCLs=;
        b=M6rxdCfNHOXlI6LeYdnzvzulkQD1et5aLc2L8Ltr+4gtv2Ax6cpSBJQIIEKQ9bbS0y
         tzfwYdTXYVLDDep4mqrPT6yRrTndHVe9hjVPSqhySRV8K62fuUQe2wuZjYsHVOnWv8Lq
         9g5Hei7vUEGDSRbWEbDRJ4Ew1THDNaZe4UD/WyyC6nLHFds3qzb2xMhec6k8/qSKI2MT
         YhdrMRrp/WMjveZcmiUUVOQA5hOFYvYMB4F1GnU0qaGRRXo8oOBB+e1iJxBgUbWH4mkN
         oTS+Ixw1pWEB5nrF1xNF5ay7/7q87Lts5bc92OmXaF3u5wiWalgshFOpmSiEJdppZs/1
         roEA==
X-Forwarded-Encrypted: i=1; AJvYcCWXiec54pDkqKpWHKOdbsgN314JzEoZjR8h7iDwRBheefLkqdDk416y8S2ZQnl8ldKE4QrpKuyckbuPXgzwU837AGU0v+xy2GU+zPEG
X-Gm-Message-State: AOJu0YyydQLLCqM2e2dfz/tR1QP8xwioIeLT5jYgG13VCtCyWj7d61Dt
	fym/EalxYKkDBMR91tK0ZUbtOBU+a/VnhLBaENb1a4HHkEixFoLZcNs+NXtAbUvQlUJfci66ygg
	xii6+m2kxqnzCM4mawnGyJFj+Lio=
X-Google-Smtp-Source: AGHT+IECs8iMY1YnYPJpryVfFh8VT25O/SfR3YnlQmuu+oyBiX4Kuyt6DsSjCaMbB4d1WSsWdF//N3m6ojejD1lNTxA=
X-Received: by 2002:a1f:e4c4:0:b0:4cb:56c5:580e with SMTP id
 b187-20020a1fe4c4000000b004cb56c5580emr345301vkh.11.1709162307693; Wed, 28
 Feb 2024 15:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-5-ryan.roberts@arm.com> <20240222070544.133673-1-21cnbao@gmail.com>
 <1a9fcdcd-c0dd-46dd-9c03-265a6988eeb2@redhat.com> <CAGsJ_4zWU91J_71zVjKua-RTO4hDUJMkL7z_RP1GnYf3W1dNEA@mail.gmail.com>
 <a4a9054f-2040-4f70-8d10-a5af4972e5aa@arm.com> <CAGsJ_4zEKDVM==0KaFOb_UgO3GZ7ag2DW3sBLA-t9Tf0gAAnww@mail.gmail.com>
 <1d9b85ce-63d1-43b4-a4ad-b9c1d89f952b@redhat.com>
In-Reply-To: <1d9b85ce-63d1-43b4-a4ad-b9c1d89f952b@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 29 Feb 2024 12:18:16 +1300
Message-ID: <CAGsJ_4xZDiqHwqeyX03rZDuSXGJ+Nye7stGj=3JYZ8Gu2ys5Tg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, chrisl@kernel.org, 
	surenb@google.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:34=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >>>>>
> >>>>> To me, it seems safer to split or do some other similar optimizatio=
n if we find a
> >>>>> large folio has partial map and unmap.
> >>>>
> >>>> I'm hoping that we can avoid any new direct users of _nr_pages_mappe=
d if
> >>>> possible.
> >>>>
> >>>
> >>> Is _nr_pages_mapped < nr_pages a reasonable case to split as we
> >>> have known the folio has at least some subpages zapped?
> >>
> >> I'm not sure we need this - the folio's presence on the split list wil=
l tell us
> >> everything we need to know I think?
> >
> > I agree, this is just one question to David, not my proposal.  if
> > deferred_list is sufficient,
> > I prefer we use deferred_list.
> >
> > I actually don't quite understand why David dislikes _nr_pages_mapped b=
eing used
> > though I do think _nr_pages_mapped cannot precisely reflect how a
> > folio is mapped
> > by multi-processes. but _nr_pages_mapped < nr_pages seems be safe to
> > tell the folio
> > is partially unmapped :-)
>
> I'm hoping we can get rid of _nr_pages_mapped in some kernel configs in
> the future (that's what I am working on). So the less we depend on it
> the better.
>
> With the total mapcount patch I'll revive shortly, _nr_pages_mapped will
> only be used inside rmap code. I'm hoping we won't have to introduce
> other users that will be harder to get rid of.
>
> So please, if avoidable, no usage of _nr_pages_mapped outside of core
> rmap code.

Thanks for clarification on the plan. good to use deferred_list in this
swap-out case.

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


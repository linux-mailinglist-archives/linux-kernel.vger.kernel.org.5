Return-Path: <linux-kernel+bounces-21690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA058292CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6FC7B24835
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC34689;
	Wed, 10 Jan 2024 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyN2KNCF"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74C1FA6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd56dac1adso31383161fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704857751; x=1705462551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAtbAqBqpbMowm+Bo4+mhDNB5Xj5y96f9fpVSyKbNyc=;
        b=HyN2KNCFlV0GoSLzjApJOIgLVgaUl5KO//L6r9wjh3oEY+jL69p+GBji9X1LTn7Y/3
         EPumOgZinOxQSwNm5IfHTElghfnblrgi1KPPlt4DouzOJscchsV7vghe9M1czyuxtKuQ
         vaH1JnRNMSgzlP5AdNn1HYqkU47sQJ9LzTDOH+GEHzrm5AYP1OQNlC89LB51wrjDFcWL
         y+PvMMr9dlG5RHOlXWvfllOeJHzdsi0Mf/dMQLqqb/efE8GdS+543R9HCoHZlCDslHnr
         NFN2GFQXQCVh8Uynz+vxOHOpdWY1EFYpiE8laY//i+vwS4HFNh0b43pgCRIHjRwhJAHw
         dTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704857751; x=1705462551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAtbAqBqpbMowm+Bo4+mhDNB5Xj5y96f9fpVSyKbNyc=;
        b=E+i/MjkYo50OHmAbRY2Vgp2wfH0fWxsbYLpsVpaT4tAr4l0RPyMTjOrKFncBMCd/I3
         oh0wFQtDpCtX6vMp8Z5dNXbFsqq9+5VTeOX6RQu06Da4KvTIJLKbVtgbYkHPevsTSDkD
         Wyd3JLmpKbbuxVeCCA5cymdiV04+2UbRtIQ9tPa0sD4VivLhekrL/nd4wX2vGTLaxvwX
         8Q6qFVWvQW/cBt7L4sgxpJnxF1e8hzcA4CCcjqrJo/vDyasUGcf2EMbxwhpig/zQJjKW
         mbww73o3T6TIXNMcGWPcbTQSlKCw4hFdUOth3ILfUTIjS90c899wJrkxwJFoRZW54Wai
         tx0w==
X-Gm-Message-State: AOJu0YznxX8WfZL9KGUeZMkZFQ9by/LtMDvej2s4MgYH6WlBUGZvvua7
	N2lIxxjM1i4ikvYubTHRPVu/cq4F3sZtZaDPHLc=
X-Google-Smtp-Source: AGHT+IFABm1wwLGCemQUNH/kzgc/mO+J8eaHGimAlF8bank3Z3kVYl/IbYvA6UAlxLubCWKC53xdJs2mzmA99c1D4aY=
X-Received: by 2002:a2e:9ed7:0:b0:2cd:56ab:caa1 with SMTP id
 h23-20020a2e9ed7000000b002cd56abcaa1mr166538ljk.5.1704857751029; Tue, 09 Jan
 2024 19:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-10-ryncsn@gmail.com>
 <871qar9sb2.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871qar9sb2.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 10 Jan 2024 11:35:32 +0800
Message-ID: <CAMgjq7CkKZ9-ogkU52xwQ1YRj+-jwt4fpOLhtKkumVc8ky3OFQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] mm/swap, shmem: use new swapin helper to skip
 readahead conditionally
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Currently, shmem uses cluster readahead for all swap backends. Cluster
> > readahead is not a good solution for ramdisk based device (ZRAM) at all=
.
> >
> > After switching to the new helper, most benchmarks showed a good result=
:
> >
> > - Single file sequence read:
> >   perf stat --repeat 20 dd if=3D/tmpfs/test of=3D/dev/null bs=3D1M coun=
t=3D8192
> >   (/tmpfs/test is a zero filled file, using brd as swap, 4G memcg limit=
)
> >   Before: 22.248 +- 0.549
> >   After:  22.021 +- 0.684 (-1.1%)
> >
> > - Random read stress test:
> >   fio -name=3Dtmpfs --numjobs=3D16 --directory=3D/tmpfs \
> >   --size=3D256m --ioengine=3Dmmap --rw=3Drandread --random_distribution=
=3Drandom \
> >   --time_based --ramp_time=3D1m --runtime=3D5m --group_reporting
> >   (using brd as swap, 2G memcg limit)
> >
> >   Before: 1818MiB/s
> >   After:  1888MiB/s (+3.85%)
> >
> > - Zipf biased random read stress test:
> >   fio -name=3Dtmpfs --numjobs=3D16 --directory=3D/tmpfs \
> >   --size=3D256m --ioengine=3Dmmap --rw=3Drandread --random_distribution=
=3Dzipf:1.2 \
> >   --time_based --ramp_time=3D1m --runtime=3D5m --group_reporting
> >   (using brd as swap, 2G memcg limit)
> >
> >   Before: 31.1GiB/s
> >   After:  32.3GiB/s (+3.86%)
> >
> > So cluster readahead doesn't help much even for single sequence read,
> > and for random stress test, the performance is better without it.
> >
> > Considering both memory and swap device will get more fragmented
> > slowly, and commonly used ZRAM consumes much more CPU than plain
> > ramdisk, false readahead could occur more frequently and waste
> > more CPU. Direct SWAP is cheaper, so use the new helper and skip
> > read ahead for SWP_SYNCHRONOUS_IO device.
>
> It's good to take advantage of swap_direct (no readahead).  I also hopes
> we can take advantage of VMA based swapin if shmem is accessed via mmap.
> That appears possible.

Good idea, that should be doable, will update the series.


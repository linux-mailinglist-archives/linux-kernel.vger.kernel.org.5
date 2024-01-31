Return-Path: <linux-kernel+bounces-46587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091D18441B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23EA1F277AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE038286B;
	Wed, 31 Jan 2024 14:20:34 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370F82862;
	Wed, 31 Jan 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710833; cv=none; b=f+jlE5QwzajWS6rYT0p1w4klR5714/Ps+p3HY6XPCH4CgxlKKy5kcP6F+empGPUlcG7dZYIlZPJ6wGOFnhsGl7Vi2W1ZdtnacQiKDyal8VSozqsHLpnUUdjqoX1jwUb0qdccHJX/ZMVqveH3IIAK4joHh5MXInU2pBKaDPTivZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710833; c=relaxed/simple;
	bh=xris7o8yXlcSUmSEHHExzupHTnepUyEcoByrAEK7LLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNVCNtzfD9r2oC3kCWdgTRE6o8gm3Y2/xFjqm2cU1EMCKkXzkxEBUzg2Gx/TADgOMFdJ85Xf1RTPejLii2v3/bpKASSJMjecM/9j9Dpl/D7duLai2Izt+2bZGZM5Q8Sy1H88+hkHT/MJGNHPGHEeqzKgZdx1DdVwGtEUIqhJ7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-214289d3a8cso179928fac.0;
        Wed, 31 Jan 2024 06:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710831; x=1707315631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6eQzKUzkhghuoMWMIet5Cb7oA4QoF5Z4EgT5biPHZk=;
        b=LEY6AhVTOPcJHlktZlhh0d8mhTDz+5J3AvCAKUIlYCFBjb76UN+o1uTKly2/70fP9d
         Q6Lz1h4v8QNVljtH3XeRcdl0kvIvoZx8KGXpWEho6JrK8pbql83tKLcri0CVAPd1q5c6
         u9v5rVYNUS7h8CGPi9PGj9UkSN/0tfJDDHNz1gbTPMjl4roPp4PoM/rQ+ofjK0xXIh/C
         6JmmCmCYiZnYm2KXSVxAW6ci5EeCjHkWZBFRS04sH71/V1g8L3umt+nhwX1wWF2aSWar
         ZdWmK3UgzZRNMigrU0bUXnmqz1vCdlQOXpvEmTNJ6sNsBW5G0hNoOluZeMX9dIZcikmV
         my1w==
X-Gm-Message-State: AOJu0YzFzhXRBQvHYNmg8xsM+ZeSRJWgyUnlz3NWFS+5WQZMwHkaQ5Ia
	eVPxS2nuQP0Db5l6nNlfuAn3Q5IXzMXpCe3qtKNtag0LefGt17PeUDtDafOiV0y8J8GPpo/SMpG
	E4gkBoFO4IPI66S/1iP8exvyR+n0=
X-Google-Smtp-Source: AGHT+IHuOpuKPfGHvA4B/OmaY0pqcuUtMVo3hwvEVlQveYhC3fMNzFHMcjrp0rNxSaoeOr4uV+EMIUkBdlZRDUf/9E8=
X-Received: by 2002:a05:6870:92c6:b0:218:566d:d3cb with SMTP id
 g6-20020a05687092c600b00218566dd3cbmr2080559oak.1.1706710831320; Wed, 31 Jan
 2024 06:20:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705927916.git.quic_nprakash@quicinc.com>
In-Reply-To: <cover.1705927916.git.quic_nprakash@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 15:20:20 +0100
Message-ID: <CAJZ5v0idcSPdwp7=WED0hYJ9s1KY_9w8Rkut8PCVGh56L0F5JA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PM: hibernate: LZ4 compression support
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Yan-Jie Wang <yanjiewtw@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	quic_pkondeti@quicinc.com, quic_kprasan@quicinc.com, 
	quic_mpilaniy@quicinc.com, quic_shrekk@quicinc.com, mpleshivenkov@google.com, 
	ericyin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:16=E2=80=AFPM Nikhil V <quic_nprakash@quicinc.com=
> wrote:
>
> This patch series covers the following:
> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
> used in the next patch where we move to crypto based APIs for
> compression. There are no functional changes introduced by this
> approach.
>
>
> 2. Replace LZO library calls with crypto generic APIs
>
> Currently for hibernation, LZO is the only compression algorithm
> available and uses the existing LZO library calls. However, there
> is no flexibility to switch to other algorithms which provides better
> results. The main idea is that different compression algorithms have
> different characteristics and hibernation may benefit when it uses
> alternate algorithms.
>
> By moving to crypto based APIs, it lays a foundation to use other
> compression algorithms for hibernation.
>
>
> 3. LZ4 compression
>
> Extend the support for LZ4 compression to be used with hibernation.
> The main idea is that different compression algorithms have different
> characteristics and hibernation may benefit when it uses any of these
> algorithms: a default algorithm, having higher compression rate but is
> slower(compression/decompression) and a secondary algorithm, that is
> faster(compression/decompression) but has lower compression rate.
>
> LZ4 algorithm has better decompression speeds over LZO. This reduces
> the hibernation image restore time.
> As per test results:
>                                     LZO             LZ4
> Size before Compression(bytes)   682696704       682393600
> Size after Compression(bytes)    146502402       155993547
> Decompression Rate               335.02 MB/s     501.05 MB/s
> Restore time                       4.4s             3.8s
>
> LZO is the default compression algorithm used for hibernation. Enable
> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
>
> Compression Benchmarks: https://github.com/lz4/lz4
>
>
> 4. Support to select compression algorithm
>
> Currently the default compression algorithm is selected based on
> Kconfig. Introduce a kernel command line parameter "hib_compression" to
> override this behaviour.
>
> Users can set "hib_compression" command line parameter to specify
> the algorithm.
> Usage:
>     LZO: hib_compression=3Dlzo
>     LZ4: hib_compression=3Dlz4
> LZO is the default compression algorithm used with hibernation.
>
>
> Changes in v3:
>  - Rebased to v6.8-rc1 after resolving the minor conflicts.
>  - Link to v2:
>  https://lore.kernel.org/all/cover.1700048610.git.quic_nprakash@quicinc.c=
om/

I've applied the first 3 patches in the series (as 6.9 material), but
I'm not particularly happy with the last one.

First off, I'm not sure if a kernel command line parameter is the most
convenient way of selecting the compression algorithm.  Since (AFAICS)
the restore kernel will detect the compression algo in use anyway (or
at least it can be made do so), a modparam should work for this and it
would be far more convenient to use.

Second, if I can be convinced that indeed, using a kernel command line
option for this is the way to go, I don't particularly like the name
used in that patch.

Please feel free to send a replacement for patch [4/4] separately.

Thanks!


Return-Path: <linux-kernel+bounces-152334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6818ABC8D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA484281979
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930CA2E648;
	Sat, 20 Apr 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVDDcPQX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372211713
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713633913; cv=none; b=qVk6iyNx2uJPEjLBvfdw++VfIESJSD8gNeCAe4ZvoUgSMa4K0AW+OtGd8oonTZg9niA5K7dHPs0PWMBfigcPma1fERdI3xojeQeziXH2CtHjfENRcgUd9244K2YD91drL7iF5IjKtofm257/YRoC5i6ZIGPDTPi8O0QvB+muyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713633913; c=relaxed/simple;
	bh=j1xfjnsCF34meu1A9kQelj5+XFQx97KLyQHFHKbnQDA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=rcgMPCUnnr6Pz1HeF+edoM+hOHSZOTWaS9g/LwBTOFTMJHmxzMYWD3IWbLUtkvJ74YNjx9DzsAZ3TcKV3EuHqBKqbtJuU/hs5qvQaIiDTMZ3hY68KqqFq/pBhNleuPPyrL0wlI8DoZxZaUU7gwP0k/g6nkTUnzAg9J0oA0A579M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVDDcPQX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713633907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0O5Kqv+lWIEjkECM3hCos+L1qfRqovCo3P8M8cYHn5A=;
	b=ZVDDcPQXo3ncZ5TFGRKOizmo6NwmIYZWh7lTT4DKWb1xJ7bauKWMbRI24iB2QCmduiwHmv
	A7U4osxkoa58waEHg5ZS7usVnPq8MtJ8zJAZRwsq+A0+4zWDGJGmW8VYKtmPUbSERX6oPc
	WiJwtPkRwQtM9CYnDxoYRAO8BfW0tdw=
Date: Sat, 20 Apr 2024 17:25:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: shakeel.butt@linux.dev
Message-ID: <e42db54b94ebf8ca3ee14bb41850184750d2b23c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] memcg: simple cleanup of stats update functions
To: "Johannes Weiner" <hannes@cmpxchg.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Michal Hocko"
 <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240420132326.GE1055428@cmpxchg.org>
References: <20240419233949.2326100-1-shakeel.butt@linux.dev>
 <20240420132326.GE1055428@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

April 20, 2024 at 6:23 AM, "Johannes Weiner" <hannes@cmpxchg.org> wrote:



>=20
>=20Hi Shakeel,
>=20
>=20On Fri, Apr 19, 2024 at 04:39:49PM -0700, Shakeel Butt wrote:
>=20
>=20>=20
>=20> @@ -2983,10 +2984,6 @@ void mem_cgroup_commit_charge(struct folio *=
folio, struct mem_cgroup *memcg)
> >=20
>=20>=20=20
>=20>=20
>=20>  #ifdef CONFIG_MEMCG_KMEM
> >=20
>=20>=20=20
>=20>=20
>=20>  -/*
> >=20
>=20>  - * mod_objcg_mlstate() may be called with irq enabled, so
> >=20
>=20>  - * mod_memcg_lruvec_state() should be used.
> >=20
>=20>  - */
> >=20
>=20>  static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
> >=20
>=20>  struct pglist_data *pgdat,
> >=20
>=20>  enum node_stat_item idx, int nr)
> >=20
>=20>  @@ -2994,10 +2991,12 @@ static inline void mod_objcg_mlstate(struc=
t obj_cgroup *objcg,
> >=20
>=20>  struct mem_cgroup *memcg;
> >=20
>=20>  struct lruvec *lruvec;
> >=20
>=20>=20=20
>=20>=20
>=20>  + lockdep_assert_irqs_disabled();
> >=20
>=20>  +
> >=20
>=20>  rcu_read_lock();
> >=20
>=20>  memcg =3D obj_cgroup_memcg(objcg);
> >=20
>=20>  lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> >=20
>=20>  - mod_memcg_lruvec_state(lruvec, idx, nr);
> >=20
>=20>  + __mod_memcg_lruvec_state(lruvec, idx, nr);
> >=20
>=20>  rcu_read_unlock();
> >=20
>=20>  }
> >=20
>=20
> Best to rename it to __mod_objcg_mlstate() as well to follow the
>=20
>=20naming pattern for whether caller or callee handles IRQ toggling?

Will do shortly in v2.

>=20
>=20Otherwise, looks great to me!
>=20
>=20Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks a lot.


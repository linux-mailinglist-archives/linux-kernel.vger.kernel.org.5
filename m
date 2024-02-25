Return-Path: <linux-kernel+bounces-80285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95685862CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324691F221AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F92182AE;
	Sun, 25 Feb 2024 20:42:54 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E281C02
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893773; cv=none; b=DplyB8tMt2q/fb2kg9hAdN0f+WNeNwyupz5wweoJi3/F7vlmpfUhm2KoTUFvpGRkyI/UAptXlQr32lUurDZZYtAgy2bUbctUPkiRUTMu0178IMaWR9SzpPiMX2YqHXc6Lc4Y2nJumw5AdWOk34Jv5gqXNoU3nU2f8QXmxap6m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893773; c=relaxed/simple;
	bh=6B2FPR0QtxIfLR9Z3LlBHaeW9kudIYhVc3AQxfyaVh0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uE/X1V8pbYHZGpX5/4LTQED08mhXaF6XUc23XKqecgohSnjf0+u8SzBh6lao99+a93gutjMlYai58QFkR35mjp1xaVtoa3Ju1j+cpubujNsUCO7bHGukFS58pyf86sYzMKOdEAnG4R4Fwzpoa3mL05fsFvWNALWRsdctZgQtGcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 31EB96340E18;
	Sun, 25 Feb 2024 21:36:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 3qNwxpp1w0yq; Sun, 25 Feb 2024 21:36:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DAEFC626FAF3;
	Sun, 25 Feb 2024 21:36:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tQZ0bj8G_Pvz; Sun, 25 Feb 2024 21:36:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 994C664507DE;
	Sun, 25 Feb 2024 21:36:39 +0100 (CET)
Date: Sun, 25 Feb 2024 21:36:39 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengming zhou <chengming.zhou@linux.dev>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, vbabka@suse.cz, 
	roman gushchin <roman.gushchin@linux.dev>, 
	Xiongwei Song <Xiongwei.Song@windriver.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Message-ID: <1319891481.98257.1708893399313.JavaMail.zimbra@nod.at>
In-Reply-To: <20240224135217.830331-1-chengming.zhou@linux.dev>
References: <20240224135217.830331-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: remove SLAB_MEM_SPREAD flag usage
Thread-Index: BV6LRmY6creq3OFHfuv/zJQa5hNMcA==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengming zhou" <chengming.zhou@linux.dev>
> An: "richard" <richard@nod.at>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-ke=
rnel@vger.kernel.org>, "linux-mm"
> <linux-mm@kvack.org>, vbabka@suse.cz, "roman gushchin" <roman.gushchin@li=
nux.dev>, "Xiongwei Song"
> <Xiongwei.Song@windriver.com>, "chengming zhou" <chengming.zhou@linux.dev=
>, "Chengming Zhou"
> <zhouchengming@bytedance.com>
> Gesendet: Samstag, 24. Februar 2024 14:52:17
> Betreff: [PATCH] ubifs: remove SLAB_MEM_SPREAD flag usage

> From: Chengming Zhou <zhouchengming@bytedance.com>
>=20
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
>=20
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Applied.
Next time please add a reference that makes very clear why such a flag
is no longer needed.
It took me a few minutes to figure why SLAB_MEM_SPREAD is
now a no-op.

Thanks,
//richard


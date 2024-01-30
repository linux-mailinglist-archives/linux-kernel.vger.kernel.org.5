Return-Path: <linux-kernel+bounces-45288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF08842E18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2CAB25FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA76E2AC;
	Tue, 30 Jan 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LKerDBWl"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF455E63;
	Tue, 30 Jan 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647313; cv=none; b=hZEEjzZsWjhfHAn/aQ6GpKsmzVWZG7dMDx0bn1USB/9EDDeaKal3A4cQARhE010E4KIJMun06iUjbtssU72w/wtt6pKFKVP5nzWlR6fwmZahL4HdvwugSQqGXDm76sBN/T1kdrfetXyPUdR76NgcJOK6ZuaBuaRfGq2ZYhtXOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647313; c=relaxed/simple;
	bh=3lWoI4fp1UvbzI7RP+651lFdJtAzivLl8NKwpRSUtwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xiyf1uyux/dS9bKEOcotJdXXRSwceZJoSikcKyQc++NEu9ujlokBVIhvjPA04Y9RQ89XqPrMsUX/k7+VwnlzOfL9VfblUW0FN9+bpP4bG6yFE4MCVBIk5v0ZbS6HOZNWwae9seLiFl/EN1tNafe8eECIV/7II2ycapeWe58/+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LKerDBWl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3D11341A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706647309; bh=XW/VGubkQ/xLI57k4zHcflysiAno5fvazmiEwifngHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LKerDBWlc+0O2wjQbP1fsylKo/gqAXP9YmnvBFU6XxXu+hXT9p9GVkrw8L8wEWqJK
	 dbGX5F2Uc2xDqgKbIP+G3LGWYVcK0zSuZZJegxtSP6JqPWkJFJYvUdZ0RXh3fUjtTW
	 ShnUwMt709ara0myE7jAgQ/RIVrvxp0+OPkDzk9xFDbqZqZUlBq0MT+xTIu+OezcCL
	 EgpUKVziE6FgPu/pIqKRJS4M18vKt1X6GT33+bt1JY7uFc1RrKVlGp1Wo0thtUri1c
	 uRgWC3+aQenij13dYrjnXm1LoJq2TvW002TyqnMARsXnOeaMNrzgQmIdwRaBpKhZ+e
	 hcP6Y4Zftnajw==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3D11341A47;
	Tue, 30 Jan 2024 20:41:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: first translation for locking/
In-Reply-To: <20240106233820.30454-1-federico.vaga@vaga.pv.it>
References: <20240106233820.30454-1-federico.vaga@vaga.pv.it>
Date: Tue, 30 Jan 2024 13:41:48 -0700
Message-ID: <871q9yblkj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> To begin with:
>     - locking/index.rst
>     - locking/lockdep-design.rst
>     - locking/lockstat.rst
>     - locking/lockturture.rst
>     - locking/locktypes.rst
>
> And RCU/torture.rst to avoid broken references.
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/RCU/torture.rst                 |   2 +-
>  .../translations/it_IT/RCU/index.rst          |  19 +
>  .../translations/it_IT/RCU/torture.rst        | 369 ++++++++++
>  .../translations/it_IT/core-api/index.rst     |  12 +
>  Documentation/translations/it_IT/index.rst    |   1 +
>  .../translations/it_IT/locking/index.rst      |  20 +
>  .../it_IT/locking/lockdep-design.rst          | 678 ++++++++++++++++++
>  .../translations/it_IT/locking/lockstat.rst   | 230 ++++++
>  .../it_IT/locking/locktorture.rst             | 181 +++++
>  .../translations/it_IT/locking/locktypes.rst  | 547 ++++++++++++++
>  10 files changed, 2058 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/it_IT/RCU/index.rst
>  create mode 100644 Documentation/translations/it_IT/RCU/torture.rst
>  create mode 100644 Documentation/translations/it_IT/locking/index.rst
>  create mode 100644 Documentation/translations/it_IT/locking/lockdep-design.rst
>  create mode 100644 Documentation/translations/it_IT/locking/lockstat.rst
>  create mode 100644 Documentation/translations/it_IT/locking/locktorture.rst
>  create mode 100644 Documentation/translations/it_IT/locking/locktypes.rst

Applied, thanks.

jon


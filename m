Return-Path: <linux-kernel+bounces-103661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40987C286
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C07B21CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9CB768F2;
	Thu, 14 Mar 2024 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akz8x/La"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611F763FB;
	Thu, 14 Mar 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440436; cv=none; b=ONZBHUWSNw/9HuEqz3ApurWa0a/koh7fnePYClQfTBVsyYkbgD6k1TmdmVkCqpy57VwLgn23fyBvz1HBjm8IEbOmEQM9GKgto694oIWUbHv49/hgo77spIhUiMhzXMpDvC2uc6iBqPny/ScQEq2cQcn3eQsm4B8xmbt386YDp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440436; c=relaxed/simple;
	bh=cupGIYIVve9aQcafgMSEc6NGWaSioxOEh6ILdwcTumg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llsNK4SDUED15GUwWg7cQzU9NIOrlGKQoVHNbw7EE6ZvPSwGxG0cvMF6iwKejFhkrraQ0XB97R8wdJcNd96wq2WUO0R+p73PJBvkTSls7gflHM+BNkjntoarHnWLfWZWjPJ07jZf1s7XtfkNnSDGxd6pq/libJ08Xh8xMKbGrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akz8x/La; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14720C433B1;
	Thu, 14 Mar 2024 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440436;
	bh=cupGIYIVve9aQcafgMSEc6NGWaSioxOEh6ILdwcTumg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akz8x/Lar3H1CIuFLysuBt+sFcBVNNbwj9qZTm3q+vr1Jgr4IV13w/rgnQEg3u+/6
	 aFryOQ7vKxOvd92pW7HrNhZCbWRRtyRAsZwj6aMqLnv7ucZ1uPrvxd7oJAOScrJmQL
	 p8x1ABJnYMo/Z4iHAUDfZIejw9R0yYi27Pmoqj2z479pVxGg9EmIrIabJr46FO9QCq
	 z+gvtBjfwJJ15PSKTT2GBP66UX5gOb2EMumQ8+3RD4a2QMy2PvZ/MTuDD4dX+rbLVP
	 lz53/QeHjfSMuXSzoEFfo9flZInXQiQInwYGKw/esevv4JfHvBlVYERiuF5pvOj/qJ
	 XmxvuSayZvdvQ==
Date: Thu, 14 Mar 2024 11:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dst_cache: add input_dst_cache API
Message-ID: <20240314112035.69dbcd20@kernel.org>
In-Reply-To: <b90d127a-ec5a-4c24-8ddf-4c592dae28f1@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
	<20240307171202.232684-3-leone4fernando@gmail.com>
	<20240308195529.57b1a4fa@kernel.org>
	<b90d127a-ec5a-4c24-8ddf-4c592dae28f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 15:04:02 +0100 Leone Fernando wrote:
> Thanks Jakub. I'll fix it and submit a v2.
> What do you think about the patch in general?

Dunno.. it's a bit hard to judge how much benefit we'd get
in real life scenarios. But I'm not a routing expert.


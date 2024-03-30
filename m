Return-Path: <linux-kernel+bounces-125575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAAA8928F0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABDC1F22379
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9941FC8;
	Sat, 30 Mar 2024 02:49:26 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADF7F8;
	Sat, 30 Mar 2024 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766966; cv=none; b=PcxKRKxMNSyRSQUL3DGss9Nmugwn2XQtSydE0+uYSW9Bkve3wZvuJ9wuXZmVAkHfJ8Kr7W7igQ7Sw3GT4E0+h+nzLx+07Y3eggQzR6LlZ/MjqJyFG/3tv1chYbSJyhmNSOev1spWWvAXCq3Pr6TEplouyIxUKNUMeELkAEfRHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766966; c=relaxed/simple;
	bh=pL9ngU64QmuxTsqpXRZjDyYozx6BpHmA//xJidWv/7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrmFkw97iunruDs5wTpM1MGkw9G5NZ3W4C0UdRazDDV3KcKCh8viX1YzEs4YIu4/OGo9WTw5lJcpN49QW8aXGnCwUB9J5+4OaOot97sLrKdNLFKHBp2zpB4YQPXuIzanGU/BNPPRfjW7NVoOwzqGB0lv59MPuRmVYd/cQFuAEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 83D6CA03E3;
	Sat, 30 Mar 2024 02:49:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 7C41C20023;
	Sat, 30 Mar 2024 02:49:14 +0000 (UTC)
Message-ID: <58ca38fdae3f702ed4f2982572f614ef7e3e8df8.camel@perches.com>
Subject: Re: [PATCH v3 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
From: Joe Perches <joe@perches.com>
To: Charlemagne Lasse <charlemagnelasse@gmail.com>, Barry Song
	 <21cnbao@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, Andy Whitcroft
	 <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	lukas.bulwahn@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, Xining Xu <ma.xxn@outlook.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 29 Mar 2024 19:49:13 -0700
In-Reply-To: <CAFGhKbz70E3vihRkG4Hi20Tw8i7mGp=Z6j+NnELDTJd9cj9+Aw@mail.gmail.com>
References: 
	<CAFGhKbz70E3vihRkG4Hi20Tw8i7mGp=Z6j+NnELDTJd9cj9+Aw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7C41C20023
X-Stat-Signature: ahd4889d3buy7csum8fppgsyx9aet8p3
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182ixsgRuJvfW1EIGVXG+exdT6cq+Q07KA=
X-HE-Tag: 1711766954-123668
X-HE-Meta: U2FsdGVkX18U38tiELtR0yLbd/Ts7qkdsdb2KC8+I6gGZ1FYtnv4VVtVejBWWKkyrRo8x7O/YTYgfjdZ6xz62P2KFU0bZRurplBRteOo9TUkaN+2Xl0LsHV9KMgNTggRksCxtKKUGb+nCyJBn0VK1xOwR3+t9HAkKdMKP4yByZ30Twc1jAi75eVdfS/ct39RWmE2Fq0t6Ha/634qevTPZgVO6OpIhgf21EbTYmPC7Zp/w/9G+cYxHcGmwnQrlkByEGtwm8YynBUhL8WzU/cj8tjZ5VX5hU4rMJta+89prA0JB7q/AjfVlmroH4joVWrbqBewp1srHd+xcjWzgz1EEa8boxwuyt+90bw/9o4K4oZWBlf1TDKa7q/EiYG/scNa

On Sat, 2024-03-30 at 00:08 +0100, Charlemagne Lasse wrote:
> Hi,
>=20
> Can this patch please be dropped from Linux-next (currently via
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm#mm-everything)?
> It is obviously wrong when dealing with named variadic macro
> parameters:

I agree it was a bit early to add to -mm but
there is a fix for (most of) that coming up.



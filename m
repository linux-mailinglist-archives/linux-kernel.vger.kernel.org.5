Return-Path: <linux-kernel+bounces-105899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39A87E62E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B22B1F22459
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890A2C6B1;
	Mon, 18 Mar 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="L5cgQpGN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FE2C690;
	Mon, 18 Mar 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755081; cv=none; b=Rwm9sMhXMVBKYgfxbAksl4iIejBThEAoAUGm1OZ59YRxWzvqeQ+8AL3Yk/wFd/Rlhhcy/wCTftrw72u6PY+k5bi9QfuvOcigMkCOfvHpacX/yIedniJulekP7hzT9ba+VfX7hU0SzMmswk905NrUW6YrieR92gavW5ONUDwz6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755081; c=relaxed/simple;
	bh=clpK5/hgFVQ6y90q1invbFi5wfYWxiwpju2/zLJ8Y54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3ZwTI+pjrSrUc1mLNW28E0RAKAWBc7aFBf1WuQEds5Had33WlKUE4S53OzIFaRsK3H8yaQoE9mEAQGBA0iEpDj/AV68CbYjQBf6EqJGnwatYPWHW1O5aSjyXVhX78ro7lERTAKN8IcmxADMJgQIFNxNfNBQh32nNkwYwS1pBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=L5cgQpGN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB435418C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1710755079; bh=hY9sbxkA5b6oOGMua/46fI6ru6HCKNfDB3qjt/oFvo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L5cgQpGNOm5JQBBcDMO4RiLWnpGAb5uEm+VzSHXa5pmsXvBG319mqekWL+FTeRMQL
	 37MM+oW3ffLH1Xj6apOtRu/+ejQV72Bpt6t4aVE11GaGUkTMqkLRRZhWA/UqpnVUSX
	 oC5SO+SqP0Q+3hmdQaEaoActH8NnpIh8o0wkZPXyBSK9XVWO7aOVk2HyLXuZu7yBnk
	 JrAq8GukSMuNtpcVpEJOkQICmenDbo9VZWECDO8KxEWOBva4tgP29yxh9qYOc8oAKM
	 Lai9Scdh29v1+vFX7STlmT3KOuB7mX83qbIG58ovt+9+Kk6Of/YFC92qMt/2goFTyp
	 14+cB1idlmM1g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EB435418C4;
	Mon, 18 Mar 2024 09:44:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v1 0/4] docs: verify/bisect: install, tainting, and
 finetuning
In-Reply-To: <cover.1710750972.git.linux@leemhuis.info>
References: <cover.1710750972.git.linux@leemhuis.info>
Date: Mon, 18 Mar 2024 03:44:35 -0600
Message-ID: <87a5mvan7g.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Here are a few small improvements for Documentation/admin-guide/
> verify-bugs-and-bisect-regressions.rst.
>
> * The "improve install instructions" aspects (link to distro docs, Arch
>   support) were brought up on the list and in a chat.
>
> * The "check tainted status" thing was something I had forgotten; I
>   noticed this aspect should likely be covered while doing some early
>   work to better align Documentation/admin-guide/reporting-issues.rst
>   with this text.
>
> * The rest are minor fixes for things. Many are things I noticed while
>   working on the above changes. Quite a few are also things Petr Tesa=C5=
=99=C3=ADk
>   brought to my attention (many thx!).
>
> Ciao, Thorsten
>
> Thorsten Leemhuis (4):
>   docs: verify/bisect: improve install instructions
>   docs: verify/bisect: check taint flag
>   docs: verify/bisect: drop 'v' prefix, EOL aspect, and assorted fixes
>   docs: verify/bisect: remove a level of indenting
>
>  .../verify-bugs-and-bisect-regressions.rst    | 389 ++++++++++--------
>  1 file changed, 211 insertions(+), 178 deletions(-)

I've gone ahead and applied these, thanks.

jon


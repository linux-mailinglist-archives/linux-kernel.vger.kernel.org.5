Return-Path: <linux-kernel+bounces-163664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E278F8B6E27
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2781C20E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C81C6608;
	Tue, 30 Apr 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YA/7nQ35"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561A129E6E;
	Tue, 30 Apr 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468751; cv=none; b=Yl2JZSaAIHK0f6Rt+1hc9sjeBHpA4cXDaEWoHK9ED+iUmDt7LB9oqlf4BgyjGnEAris//qEwfJxjoWt7gETtL1uteZpxB4FDy1wd3dMGkTcX6bF0oibDTlYK0ptG9U3XVUvq5ANdBB3kmb63hXtsgpbYCeKfwlfnkIrNFdFwqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468751; c=relaxed/simple;
	bh=nJLw8ZzNkHNxUi0RWmfswS2AiqmNNWu4fMk4lAvCziY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=sbRPBteVbfUpCI2fXJ7LMcLsOgsdkm70TcKFgDtkom9Syok+y8kMXUkvRZu+WGJRwOSYeX3b9LgNn+SqaFEPBzcWGsKf8S3tknHhN5w2GhqSllDEKmbOGBGcZ0qF1MZfiw5KCDb6lPlx36AZTA0SdtASNenhkD93Y4QJVoIvl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YA/7nQ35; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714468721; x=1715073521; i=markus.elfring@web.de;
	bh=nJLw8ZzNkHNxUi0RWmfswS2AiqmNNWu4fMk4lAvCziY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YA/7nQ35u0kJEg0FSF8UrZNkzte5ooB3jtBpE2Rdi+zYdC3hgcy8exhdzfyApNjY
	 58hitwap4e8JN6RQmFY9Dlu+yms30IyXqgcL+/a1xWiWGMWgQF0K5Z1lEtoJb7UWj
	 hYmOL5WXrqGWkbvsh6CBFD7UXUQeL4GBPSG5/HfzYzXFJnewkLeN9x6i1/bIdoxfy
	 4YuOSxp3HX+q/dpsc3+5LdYDfJs037p1fM3WEc/rxR624GOfxZgQutsJKXZ9orgjS
	 uaddWT4fKxTILEwNx5ynqbFnJP1GaKUyxooWuGH3wbMI3qMYhHfiFbXjy4XD87RLM
	 M3aVQOiBt3vyTww0JQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjK2-1sqnog3znW-00yQhv; Tue, 30
 Apr 2024 11:18:40 +0200
Message-ID: <7d4a29a1-26d2-4b22-8823-ce8e7f9ac534@web.de>
Date: Tue, 30 Apr 2024 11:18:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Youling Tang <tangyouling@kylinos.cn>, linux-bcachefs@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Youling Tang <youling.tang@linux.dev>
References: <ww5fcxuzfcgttglsr6cpnrxufeusw4ixe76iqp7mab3djlyfje@zozue6qvxhzy>
Subject: Re: bcachefs: Fix error path of bch2_link_trans()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ww5fcxuzfcgttglsr6cpnrxufeusw4ixe76iqp7mab3djlyfje@zozue6qvxhzy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8JGAxKe1KPyVXekngDfxeASqhnsNJcNDH5Oi18Aw2cRMyhF6Jt3
 iEPn4suDWuGcgZp7U9kX7SZpuaSz2PtLj9PCd9KWByfLbn0sudLzTEApmkJ8Z5QJEVfVr+Y
 oarf2KbY23l1hLnQKWf0P2wOIAWwK0NzF2WNuA29iKKW1nKn17bdveWhnVDt+UW1GdslcMS
 7EqHUHolqPCCVF9cyHZvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kBKqZET/k9s=;aI40zUrPaZ3NOHwVe3EQtPL9N1H
 /GkmdmvCi5AY9YcgBQ08ZmsUeH3QI8YFvHJTzlyAv/IxOryjtLMQ4nSApcn9Lp90I1XfvFSRQ
 u4GSol2OxMeW1ixGekmVsNys8n9aG76Z3ooJ3KmTVwo2h+7tBZeemWLDBWxrk9S/lBdRhmMtc
 1R0Yu9boNGtBs9ODrAg5v2OlUH1H5HxLVxz3XSuEeimH6g8Ujz+V0ihp4owzBrkoFiEO4uHbQ
 0sRbdolTa+gAHThUOpG1ExGOIyV0oKiIAksFZgx8k1yz/VUrLKeMzWdsTJeXMrqcO+hBWHqny
 xZdBn+UINmy1mZoIwYCuwYEH21G2gj1wOEGWbJhykamWm26xb2JkfE+XGwdOj7S/7IWysr0wO
 h5cf3vsPpk9WpJaxU2fqhAtHeMRh0D38SV/RkvJxDU6O+Z+Xta0QseHdax8hapz7LytPcxckS
 uNdxfBtuYpBj69or8gUQ9TwhuLzDWBJQ7DWtU5zIdsY6zLqm1WS0EkpeoCEbLSJBRCXn9I6Qm
 CZl8NR5rk+RdTLgDRXORyomg7DE+SANCNH8DAairTHrKJovLubZumvphLhBlVjOpMrDBSksJR
 AV5jbHoKaxyq9Wh1QREfpBsB16tk9rkJX7LAi4Td+UAfoH62y1f0Mgx/6VpZcV2BIjqkBoiYs
 /TSuSK6l/lEzmx9dG2cMo95biXxql0oGipEnvFEWJNEYYE5TikNWbSEPmWfjJh67ADJ8fYghU
 LOaMEJ02dxztEsLKOZorvAcIA+jvVBIjZFSByRxafAollnLFVyI7s+bIopS0fCCcZz5Lqt64p
 mEVSNkWBJo6xLeZ7MJp9hoLjhQfOi/N+oBY73qkI1cuBA=

> > In bch2_link_trans(), if bch2_inode_nlink_inc() fails, it needs to
> > call bch2_trans_iter_exit() in the error path.
>
> Thanks - applied.

https://evilpiepirate.org/git/bcachefs.git/commit/?id=3Dd04db1c7653dee5ee5=
f918ce951c05eefddad7eb

Would it have been nice to add the tag =E2=80=9CFixes=E2=80=9D (besides an=
 imperative wording) accordingly?

Regards,
Markus


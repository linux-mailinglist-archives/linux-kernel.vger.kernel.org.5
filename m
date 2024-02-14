Return-Path: <linux-kernel+bounces-66039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30118555BD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35261C21DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4611419A4;
	Wed, 14 Feb 2024 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B6C6M4z5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD71420A6;
	Wed, 14 Feb 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949695; cv=none; b=punQBtdPgugiMMiVywP4fvzuJOm8WBH8IwA/ZzPKpH6zQYOgTNlYEIRGpCYgTKzXv5HA8Nwhx0n9YWkyMtnB403l/30WihKhrrh2lI+EQMnMqnEVeqxxC+xl/5422of/etQwR44ztn+lW51Pij/PoQDNV7/FfbRA+1pngb0kqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949695; c=relaxed/simple;
	bh=dr6lNGuiUFMOm6kjpti+lKwB4aZCdRAyvldzrQmbQbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FnGuA2GncxqL6CCXzyoIOu19qvEAsWzmKr1PdEJ/3CQJTq0Ml3JzdJjT7P47ocvceyugANHOGAMzZFeYgEO1XcLiX81xYX0p8PV2V46G1OG/syWG/Pa3pJRpvlkwsj1RxNnZRkb4VsjNwQ87HqgBqk8Y2Avu5LRuqNE4NADkKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B6C6M4z5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53DD642A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707949693; bh=vI0aS1kD+SnlU/BjSQqS1ZEksgUoJ9xDBQO/bMscYvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B6C6M4z58fkKyB07kJhbOm9zdZOptNZnvd+xTGiko6/QLgUFZi5Sgr3Jl6uOnZ9Cs
	 i3l3dHsFb4DwXoK6qQB1D4P1liLU5va89iEnGU5RinUKNkA/s5n+44jLEyyn79A1B+
	 3FqlI+x6BwjVDuyaTve514dB79+CZLszKOoLlKmfy8DVi7Bkd84tjSfgULZuhCK9e3
	 FApoaNwIVyqsH5dJLTq1aGNqbsQuAiCctq+pNY/l/ZExDzhDB33ObyFkXICrFgup2t
	 cNo9ozqV/FGF1X611a3s9Z6ucXFTlKiLwYuJCt0+TNTE/zHI0+Sy1QC0cZRprD6mHt
	 kVZj4xQ6IeY3A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 53DD642A45;
	Wed, 14 Feb 2024 22:28:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Davide Benini
 <davide.benini@gmail.com>, Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: remove unreferenced and not translated page
In-Reply-To: <20240209222115.31505-1-federico.vaga@vaga.pv.it>
References: <20240209222115.31505-1-federico.vaga@vaga.pv.it>
Date: Wed, 14 Feb 2024 15:28:12 -0700
Message-ID: <87le7mznnn.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> The netdev-FAQ page in the italian translation was creted to avoid
> having broken links. With the evolution of the documentation this was
> not referenced anymore, but the page never removed.
>
> Reported-by: Davide Benini <davide.benini@gmail.com>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../translations/it_IT/networking/netdev-FAQ.rst    | 13 -------------
>  1 file changed, 13 deletions(-)
>  delete mode 100644 Documentation/translations/it_IT/networking/netdev-FAQ.rst

Applied, thanks.

jon


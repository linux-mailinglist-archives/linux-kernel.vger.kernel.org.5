Return-Path: <linux-kernel+bounces-128235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A07895816
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96AA1F23714
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299712F370;
	Tue,  2 Apr 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QBAAVXWR"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FE1292D1;
	Tue,  2 Apr 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071381; cv=none; b=KetN5XnT2qsmga176/xa60c9PEym+Ix29GuOUnhSui+Pa4MhAmL5Cj4//JVMPFCddrZxxZrAk++qQRvB4ifiYEjnRaapIIsM8nPfhckRkPFklugMZUVyhb/Xev6hY8J2mZmFAzDNBDHIfjGpGp+mnqRVDecVHhaEtdFcppk64Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071381; c=relaxed/simple;
	bh=ek19Ml/mwYrElDd6takIRjoVjc1fk5mNaHyfdnJ2o5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThPFLsXSlclmAA89O58N/dIbb/SAfFp6yhEhpFcXg8wWl9t9sueFpQy/Ou7bnfJogDTWLN+IBD6t0i36+VSBeoP0y6ErdntKMppOjDokTWkw/MC31E/SDHBfPx2iC+Ku+yo1rUMldWG4y/AZRMQ9WUNjDuUKr/n5DVs/E78g87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QBAAVXWR; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E492F47C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712071379; bh=eJ2hKe0Q1Pm85tLtJokbtgjTKDauiW11RJmwbOy5CCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QBAAVXWRj9AkYFtgN3J2bmEfTFCDyGXRrC0GqAtRdsL1Jxcgr3Gx5OBBfLB9lPPJB
	 0oT67V3xuv6vgENsPffOmaRJ3y3qnGeE5dy8YFHVjkH8xbX+vYYXoCn+DhvHoT6cKU
	 bRdHzlQ8SQoAPiKC5WPQEiuoUzPSJY7k92NpI52sFVd6uJ4576zr8UIpTOGpuD464x
	 t2KATBqf6kB87Uy+OabZLKDx7i+tG8Be2up7osm6rJ7moMiE11wPnxC7Cjk7hmIMOq
	 rLzeV7WPovfiq9vAqktHcO29i+Cct0qx7tnAUVVPs08+xz7BF35biiZMFYOhs9xEyG
	 TnHZlwy6HA6ig==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E492F47C1D;
	Tue,  2 Apr 2024 15:22:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Hu Haowen
 <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags
In-Reply-To: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
References: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
Date: Tue, 02 Apr 2024 09:22:58 -0600
Message-ID: <8734s3yejx.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> The updates from commit ae67ee6c5e1d5b6a ("docs: fix Co-Developed-by
> docs") in v5.0 were never applied to the Chinese translations.
> In addition:
>   - "Cc" used wrong case,
>   - "Co-developed-by" lacked a dash,
>   - "Signed-off-by" was misspelled.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../translations/zh_CN/process/submitting-patches.rst     | 8 ++++----
>  .../translations/zh_TW/process/submitting-patches.rst     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

jon


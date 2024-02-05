Return-Path: <linux-kernel+bounces-53096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3954884A09E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECDBB22EF5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268044C66;
	Mon,  5 Feb 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Eivg2FMt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5445941;
	Mon,  5 Feb 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153892; cv=none; b=PAjhpFfQ8uYALjhr5WkZ/tnWhlquzwaEr8XLnqU7P4BproKhGc+HU4oF/AlxfU7iEvG/2drA+Ew7CveIdJUHQsbUhIwzmgUd5nGyheBTHAQp/b6KvaccStAlJnZ0TsF46LBTx5eqrcCoeqreF7O1DF8QC+0exndwyWe3qWcQS+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153892; c=relaxed/simple;
	bh=qwqCvMF+PIbl16OVgkf+2TCi5yui9ioUyHJRsouWKks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N+7f4hcfNeorT+kvBsTdoRnw4DYZUjPput84d3yc7MtqkOcMt0GIXCicOQznNd5G4KqvpMoAPwO2MlsTJrDSdB/CEoy59IPlYjPjEjqVuuHDLoBr8U9aKphBZMTEJqdUig9Wx+9F/vL3fkYgZgOc/D9ij9ajVjadsI6Dl4x8NgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Eivg2FMt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EFFB945AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707153890; bh=yfpllgzWBFP/zgAYSr+xda2U05jDfEi2qKsvLe7I8UE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Eivg2FMt4Q4y1ZOkc06YU37qoFiuTvOCiqEOx6dW0GQr5ZVKqHJapAJmQsF0R1GEq
	 zUjyQIjXje2vWPSMAwL+Y3PaqRdwt0v1vh/Wywc3O0BQTcR/mFQ2gXqBnwCqNeCBU7
	 Ju0uFrMC8+B2RVVcfx/bo0uNr5MGYAUkeGyqqJyNGGIuYzioumpBWL6XQUa/PTooQh
	 TMqyTrZfUrRzA1hNM4tCpisR9JGsKaaiF5gTxx1hhSE1OaLnVOREYqNYVsXXOtWfBU
	 TSEKXm0jSo6TQxh1XFYrnzxZ775PVuf9iHfwcW3Gkm1/8w6eIIfvuW1K0ZKiMjNdX9
	 INtxJgoA9wxTw==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EFFB945AC9;
	Mon,  5 Feb 2024 17:24:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>, willy@infradead.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 thorsten.blum@toblux.com, workflows@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] Documentation: multiple .rst files: Fix grammar and
 more consistent formatting
In-Reply-To: <20240205000117.3285-1-thorsten.blum@toblux.com>
References: <ZcAFi9ZW07fOLQaW@casper.infradead.org>
 <20240205000117.3285-1-thorsten.blum@toblux.com>
Date: Mon, 05 Feb 2024 10:24:49 -0700
Message-ID: <878r3yvn6m.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> sphinx.rst:
> - Remove unnecessary newline
> - Fix grammar s/on/in/
> - Fix grammar s/check/checks/
> - Capitalize heading "The C domain"
>
> changes.rst:
> - Remove colon after "pahole" to be consistent with other entries
>
> howto.rst:
> - Fix grammar s/you will/will you/
> - Hyphenate "real-world problems"
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes in v2:
> - Preserve Reviewed-by: tags
> - s/on/in/ in sphinx.rst as suggested by Matthew Wilcox <willy@infradead.org>
> ---
>  Documentation/doc-guide/sphinx.rst | 7 +++----
>  Documentation/process/changes.rst  | 4 ++--
>  Documentation/process/howto.rst    | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)

Applied, thanks.

jon


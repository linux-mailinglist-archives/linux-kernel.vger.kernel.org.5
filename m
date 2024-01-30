Return-Path: <linux-kernel+bounces-45299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C8842E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A206B1F281F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76E7AE54;
	Tue, 30 Jan 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cFQwocNa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A649762F2;
	Tue, 30 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647828; cv=none; b=KWOIM+7WSk9S23pOsYnHBWs2qsMXl8oR+80FXOQOguJ1GZwTmA9RnOAibMbkm2X3a+5lyga3eDcRrGRl+1kD3kNlNcEqSdEJTU9cM+YBMEqvnw5YumI9uHW/a88RDGEWNaNp7C0nqrV89midDKDWjT0rW+fB2jSIrF3TgQ3v/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647828; c=relaxed/simple;
	bh=6Tedb7Dj+/odnHs4h8iRSDGO1llbomw/c2z4zGiG7ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubdDE2T54LwDuWpuLT1vVoxUkSj7IsnfE5I2oUxKy7fXzKPgb8w4CDolx/qwPGS+LE+gY0SBouxCKVd6t0cYDa5ZjH86TiUOSlWtup267VoUev00ZwBFUr3lTOkAABob80N7vdspF6u2SOunY4fW0f/ZO95FQ78LBYEYFaUof2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cFQwocNa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0C1141A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706647827; bh=6Tedb7Dj+/odnHs4h8iRSDGO1llbomw/c2z4zGiG7ZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cFQwocNaSvgU4kMXJA9nACpCV9oIQcGJtYhaFInXCd3Y8swcnxihbC+uzB6ZdvZ28
	 pGk4swOVNhaKYzw3n9JZFaOE0ulj23uUZCsexZ+zxN0UnGHdVmR3lkYL83BLZ7aaHo
	 Dn3Q/zHd883/JPUBwV/4fFUgjFjMj0pCKWzbIcBDfqeRIqb3SxhevmwBJbpoKQ3fOu
	 UrIH61SemDyMGmeaoHb4rjMlT+n+9YZzr0/uxWS8bVYvbf1aFbhvbE1g0beR2do0R/
	 k54tzOFWAazLWxG71QaxUgWELXr30sJGIGot/edDrTW3uvRepoGj+jl3prTyYeS0i7
	 LLzRVr1KouYwQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D0C1141A47;
	Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: first translation for locking/
In-Reply-To: <20240130202340.tmppiux5oiwvrtij@numero-86.vaga.pv.it>
References: <20240106233820.30454-1-federico.vaga@vaga.pv.it>
 <20240130202340.tmppiux5oiwvrtij@numero-86.vaga.pv.it>
Date: Tue, 30 Jan 2024 13:50:26 -0700
Message-ID: <87ttmua6lp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Hi Jon,
>
> I hope you are doing well. I do not want to disturbe you too much, I'm pinging
> you just in case this patch got lost.

Nope, just finally catching up after the merge window; I think I was
applying it exactly as you were writing :)

jon


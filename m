Return-Path: <linux-kernel+bounces-72032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB9E85AE0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156421F22D53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5105476B;
	Mon, 19 Feb 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sJxe9nxh"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCF53E2B;
	Mon, 19 Feb 2024 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379510; cv=none; b=XzRumFwzw355hnhOLo4d/pRshEPUTeDpeAuMCGxSZNtVK/DTWM0LvDUezQOoHrurFa0EBRUpZ993P+HkoHCxkGZrUd7M0ob8oPznxoBqVlLFfggniLfTRf3ab2/sFmZcrZYI1TJr15cEopx8X3peG09Tkkw/s135ptN0P1f3h/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379510; c=relaxed/simple;
	bh=vRW11XbFfoaGIb4WC2HvUdVW74zOyp+Ix++rI0wiSE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dLx0f39sLkM/pVTK1A5IAOb9NS0cSRHss1Qc85Y7J3mFVb5yXwtXEeU0It3uiP681H4HHm5u0U417d6TKzKMDtLf0IHEXdz5Ugn9CD5bbagd5yzUdeoOX8ubKn7QALyZVXxyPkb7eLEjvp4bRTdPMzD7YIdQ134Js3I30WsOuSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sJxe9nxh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DDB4D47A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708379508; bh=rm6ybMXn3hJiiMKwvjsdFGz2P/M85CFwBhFz/mMDk90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sJxe9nxhwz3BH+qAJDemC/Oly3IaRkz2FjsbnCtONgfoSQ12U/NTI5RyZ3x2EPuVW
	 w0fJn4JtqvFfnzsohtkb1P5bACjEEHTjt1cWUKjE8QNzpfiSECO1fbVhwPXsrjik2o
	 7/7yLD3dzHoucvJOoQRish9LjQWjbjJWyNuLeHKHizDm/rWTTzKvmquBZMF2OkKh+K
	 xOaUxstSlTRs+n5LsMrj1hbNx/pYRKcI8b+j+66gcG8hwtG4S6LFVYEO9B8hy5fX7R
	 LNy/hO0SZKOWlmK8+0ryO7+bsQgRAfrQULAnxtCZ7jHlGl/dCUHuN89bVJnPxWfSrC
	 c/5mklPkBxsCw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DDB4D47A99;
	Mon, 19 Feb 2024 21:51:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kalle Valo <kvalo@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: MAINTAINERS: add "Profile" keyword entry name
In-Reply-To: <87zfvwbyu3.fsf@kernel.org>
References: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
 <87zfvwbyu3.fsf@kernel.org>
Date: Mon, 19 Feb 2024 14:51:46 -0700
Message-ID: <87jzn0m8b1.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>
>> The HTML output of MAINTAINERS file prints "P:" for subsystem profile,
>> e.g.:
>> 	Status:   Maintained
>> 	P:        process/maintainer-soc-clean-dts
>>
>> Use "Profile" as this entry name.
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Heh, I was confused what HTML file Krzysztof was talking about but after
> some digging I found this:
>
> https://docs.kernel.org/process/maintainers.html
>
> This is very useful! You can link directly to entries[1] and it's easy
> to read which makes it easier to talk with non-technical people.

Non-technical people like ... maintainers? :)

> Jonathan, I wish we would make this HTML version more visible, for
> example what about adding a link to the HTML version in beginning of the
> file? And maybe add a short introduction text at the same time? I can
> send a patch if there's interest.

I'll certainly entertain a patch but ... I feel like the same could be
said for any file within Documentation/.  Perhaps we should make the
rendered docs on kernel.org more discoverable, but I'm not sure that the
maintainers manual is the place to start...?

Thanks,

jon


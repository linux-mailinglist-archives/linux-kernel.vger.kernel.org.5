Return-Path: <linux-kernel+bounces-58793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7290884EBD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117251F27693
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881F5025F;
	Thu,  8 Feb 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B04zQJA5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48F482F2;
	Thu,  8 Feb 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432285; cv=none; b=jPZUDdAV13HSfQdvB8qFlBVDvS8cS6LR8k9oIvCW6B6PyxFeds02uRhphOKLZM6oJnAuqQiAppGHLI+/HCQeF5pgHuGQQL7GDyMaf5SzkYiqZxRqD3LGcF2J0XPZwMTOt1XcpLX0+BMbLgMNsvx1sZcpNHGBXWJ9lq/6HokpFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432285; c=relaxed/simple;
	bh=/B8xXcTxjdOHJVhrRcWzpHUAuYn5pfdJfz5RXSdLrBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1SsfEuaLAyBiwUpLsPCh2CM20l0+h/yOLM2sh/6Q/BoYIxwQ+KbvpOrcJQHEbHQ9Hq12IF62dJ7KGFeKxSOrWehNCxVKB38IAkAX0zF6+3IyRAnP6lLzpbJ3PUtKVbNr2alB+MOX8g5NcY39GN1tN37WoVNtKQZUm+szI1MBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B04zQJA5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 42A8145917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707432281; bh=o5yBgG2xVlqiQ0cKTX9ROwpCkBnnd2ehpKLHgSwa8P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B04zQJA5XC+oPtrrybtOyZZlyjzRxJqHkmzp6kkCL0uON9ES+cFHZPBL8xI6HpDAw
	 yJSKFAtghGXSiA5OuX/n1RDn3Kqacp8KD5sx5aI6dnmQTcB58sGmJkj4wYL5HHA3qH
	 ocQvZQ5R1uhmwwygNCaeLddnDFpa3ieJHJ5hPrNr7e+24qoYO5A9MkpsU7U94jdtU5
	 t9pNv8/UOUO/4oKPzYWyr8TmPR82CtvD/Y0p5s47BUpa9YMRntSo9l4fVn8pK9Kzak
	 cIw0ovKDogVav3NBTRWNZpTkMEb5Z/lSleC77FK48gCvMOskl1IDVFeKLStiIWdM21
	 lLPyCrBY5dcnA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 42A8145917;
	Thu,  8 Feb 2024 22:44:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Federico Vaga
 <federico.vaga@vaga.pv.it>, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] doc:it_IT: fix a typo in the config name in RCU torture
In-Reply-To: <20240207150322.20238-1-lukas.bulwahn@gmail.com>
References: <20240207150322.20238-1-lukas.bulwahn@gmail.com>
Date: Thu, 08 Feb 2024 15:44:40 -0700
Message-ID: <87mssafuef.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> This issue was detected with the scripts/checkkconfigsymbols.py tool.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/translations/it_IT/RCU/torture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/it_IT/RCU/torture.rst b/Documenta=
tion/translations/it_IT/RCU/torture.rst
> index 79d9e6932acc..189f7c6caebc 100644
> --- a/Documentation/translations/it_IT/RCU/torture.rst
> +++ b/Documentation/translations/it_IT/RCU/torture.rst
> @@ -129,7 +129,7 @@ Uso su specifici kernel
>=20=20
>  A volte pu=C3=B2 essere utile eseguire RCU torture su un kernel gi=C3=A0=
 compilato, ad
>  esempio quando lo si sta per mettere in proeduzione. In questo caso, il =
kernel
> -dev'essere compilato con CONFIG_RCU_TORTUE_TEST=3Dm, cosicch=C3=A9 le ve=
rifiche possano
> +dev'essere compilato con CONFIG_RCU_TORTURE_TEST=3Dm, cosicch=C3=A9 le v=
erifiche possano
>  essere avviate usano modprobe e terminate con rmmod.

Applied, grazie,

jon


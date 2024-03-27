Return-Path: <linux-kernel+bounces-121816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4BC88EE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98722A2977
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CA14D71E;
	Wed, 27 Mar 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b="PfRN27M5"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0281D12FF9A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563486; cv=none; b=KoLmbZ0yh4yH/UE4CcBdYhXm+ZgVs7VPxbVNk3zKSDtf1BwCVNOU3jGz0OODdv6mOSvHi0Jw3eUNh+5lfJYJdyn4Yula1AvYYwoK4wkfc0LaiDZIrqFcIbavaroikRsTbrfrORyUV1dmWDKDkJm7ka5US4XhqdLK47mTd90faMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563486; c=relaxed/simple;
	bh=VAyUWNYNPMX4OP1b9CFLlH6ZChBVF3mzA8JMTJaUOj4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Chdf5F+9gAR4QZ35W4i820/xcPKmqnhtDOYbMZQrlunPIQPqxT28Yx/ok4C9ZMLC5tBUK6iGy++6lUij8od4VTnYAmBmi9SS/L4T3KImlXVVH3hHclUy8E6XfQx7h+JMPU/F1BStaDCD1msZhWLX1EdXOVi8oDXe8GUof3Nt7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=jmoon.dev; spf=pass smtp.mailfrom=jmoon.dev; dkim=pass (2048-bit key) header.d=jmoon.dev header.i=@jmoon.dev header.b=PfRN27M5; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=jmoon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmoon.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jmoon.dev;
	s=protonmail3; t=1711563474; x=1711822674;
	bh=n0sCsQWUGk8m/rGNztaZpyJM+gFbxgaWYiByS+llbD4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PfRN27M5cH66kxlwMm8gcLuWpAiZWGFZLoC29EZOwKQOx9ITTox9cyxCsjVw94D8z
	 v3clP8AgFjquzSwJjsaJ6oxyDLPRv8RXT9wUPFP/EF6aqQEtpGQCsfRxjP0pP+4lQC
	 5z6BSDGZJ2XKBCH2YEThVziRT1q8ruMR5wl4koFhqxHbJp0IsCTjg9UbNlbM6bmaSc
	 S73RMsEODWrua1baR+Y2y4aD8QdE2xYOq1ldJHx0qMhd4yhv7updD7+TlszbqNBu5M
	 iIWW8pn633xKrvNoeVMmjU11/IgY58LvGHXTj4UY4v0MClLlfQ5p9vH8G1L9DuWoIB
	 HuuieGUvvxNKg==
Date: Wed, 27 Mar 2024 18:17:48 +0000
To: Jackie Liu <liuyun01@kylinos.cn>, masahiroy@kernel.org
From: John Moon <john@jmoon.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check-uapi: added arm64 support
Message-ID: <D04QMF0IN7CH.2DPU99RSEZJDM@jmoon.dev>
In-Reply-To: <20240327103547.25695-1-liuyun01@kylinos.cn>
References: <20240327103547.25695-1-liuyun01@kylinos.cn>
Feedback-ID: 18069581:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 27, 2024 at 3:35 AM PDT, Jackie Liu wrote:
> By default, `uname -m` of arm64 will return aarch64, and the correct sour=
ce code
> directory cannot be obtained when the script is executed. In order to sol=
ve this
> problem, it is necessary to correct ARCH=3Darm64 when aarch64.
>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  scripts/check-uapi.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/check-uapi.sh b/scripts/check-uapi.sh
> index 955581735cb3..1c39d13b90b8 100755
> --- a/scripts/check-uapi.sh
> +++ b/scripts/check-uapi.sh
> @@ -408,6 +408,8 @@ check_deps() {
>  =09ARCH=3D"${ARCH:-$(uname -m)}"
>  =09if [ "$ARCH" =3D "x86_64" ]; then
>  =09=09ARCH=3D"x86"
> +=09elif [ "$ARCH" =3D "aarch64" ]; then
> +=09=09ARCH=3D"arm64"
>  =09fi
>
>  =09local -r abidiff_min_version=3D"2.4"
> --
> 2.33.0

Good catch. Looks good to me!

Reviewed-by: John Moon <john@jmoon.dev>



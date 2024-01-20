Return-Path: <linux-kernel+bounces-31836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95E83354D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8431F1F2337F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4E10940;
	Sat, 20 Jan 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gYRcVsdm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97D815;
	Sat, 20 Jan 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705765091; cv=none; b=QVnOaET80z3yRcIoQ7rqm4+3tBXHxD/9jHexaNZP4qgW5NblP+7M9czEOWyHH4CVmzQKSI3F+9Sgs9u+300kjjoOO5wKICA8Bt80ELTB3k8OWHD98kA4Jv67AOYyKgeg35GXddtW4X1IkJuNCk4ks/3RoesKCYCwAMkNAWBMg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705765091; c=relaxed/simple;
	bh=+7JxOe39CRONjhHqKrzwmZc/MrbEySCQI0hhkyXStG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iB13y57OjnFDXpWXKdTWhq9tOiW86i38xdMGoBHfG2HN/8D9Lvx3aCmiHvl+SBzp/daLMc6Z05kxN/IT2/XsXjitBz3hKSB/YOPu+hQ+Zku6iw36vQFLvUHaW7TCBufA268/lxJR+Tq0kbaFvUKWSdfSAReUbf1Yk0205NXb8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gYRcVsdm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AE6292E5;
	Sat, 20 Jan 2024 15:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE6292E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705765080; bh=wLcEhQw1Jjvzq1l7OVP1geKXt6JOGfTdP5+FiDy1DZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gYRcVsdmgQzJyo0RJRaYNzgjiCxu65oUfBLpjzWTgE9xzAH1UPQlaEkJvD3WeHU5i
	 vNsxCgDjHZ8bWBrAWhewo0nvxiZFVEZC0+RL+NjrW9trhfrED+0KJ6eSpHuvTVLHyV
	 qQ8ZcTh+9bBEwxKP7DXk0OOVj7VXyDP+l4AGsqi+xsns+lD/xD8r6NSjl+qrW7GQ83
	 tp9oWgO15NBfOFoNAtdsPdfmCCS9jWvGeNr1IQwCJnYd7s5hlatJ0dIqusLGrmaIwx
	 4N9K7HT0D+PMA7yzpPIfZoowgEt9acsGbsMAPnmC2Y7M2ylt79eeTGXerxkF7OsyDg
	 hp52wrG7ElXzQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Erick Archer <erick.archer@gmx.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN/power: Use kcalloc() instead of kzalloc()
In-Reply-To: <20240120122204.4287-1-erick.archer@gmx.com>
References: <20240120122204.4287-1-erick.archer@gmx.com>
Date: Sat, 20 Jan 2024 08:38:00 -0700
Message-ID: <87a5p0rp5z.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Erick Archer <erick.archer@gmx.com> writes:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, in the example code use the purpose specific kcalloc() function
> instead of the argument size * count in the kzalloc() function.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  Documentation/translations/zh_CN/power/opp.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/power/opp.rst b/Documentati=
on/translations/zh_CN/power/opp.rst
> index 8d6e3f6f6202..7470fa2d4c43 100644
> --- a/Documentation/translations/zh_CN/power/opp.rst
> +++ b/Documentation/translations/zh_CN/power/opp.rst
> @@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
>  	 {
>  		/* =E5=81=9A=E4=B8=80=E4=BA=9B=E4=BA=8B=E6=83=85 */
>  		num_available =3D dev_pm_opp_get_opp_count(dev);
> -		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
> +		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);

Without addressing the validity of this change, as Hu says, we should
never change the translations without fixing the original as well -
otherwise they aren't really translations anymore.

Thanks,

jon


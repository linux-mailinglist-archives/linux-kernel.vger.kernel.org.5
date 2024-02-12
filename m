Return-Path: <linux-kernel+bounces-62300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E27851E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B76B2277E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DCB47F6C;
	Mon, 12 Feb 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijI2R8Nl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE347A6F;
	Mon, 12 Feb 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768021; cv=none; b=WsjDOFrG5g8OISS21/730vB28c/lcjQBV4RiXOpfJxYspQcdFQq2RTfOIWFK+o3VdOkEriBkQf+5zBsXn0FrDbY/IpBwrNEBf5TIhIpdUE8dAO1JQ83BurrZXfHAH0Fbldk3LbsGdO6vl72pU6QZRVDd1R6dHSQYMk2ip6F22vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768021; c=relaxed/simple;
	bh=wyl9knvIggF/HM3rHnTsgcR+8vF6KjdZXU5A19UcB/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=O30ueeZeTpFU0MjAVVCVt3bmA6cERjaK0wOmzLPJ4uwc8dJ4974OaEhN7IfTciXCNB1B0QZgRFaBO5Qyd4UjB82gnrffje108VxowanNwBxQqRZwZoC5kFfwg4sJRjBFbRDzaA0NiX/j4RZ/gxA2jaJPPU/oUwyGCJU4WuxSbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijI2R8Nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C506C43390;
	Mon, 12 Feb 2024 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707768020;
	bh=wyl9knvIggF/HM3rHnTsgcR+8vF6KjdZXU5A19UcB/o=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=ijI2R8NliQiyAoV+aL+oTS+R9fytpZ6NTSIctPqirhj1N3sDZ8EmPwjNFJ7xOJB2W
	 a8slDzuJcRRoqd5cKuLXyQIOy6r1geDT/KE1yuYP1/WlL9uERCbEs8QwfnWPcYTDJn
	 29ZJaWjJ3r/5CdTZGsKmCCteJZF6gJWiZFFD7du4Y/EnCaZJR7aLRJIoS/8RiJRqNa
	 gYchRXhge/hqSaOmxshAiej/ub8yhkuChVhWwhMD6cOAcWipQDrRGnuR3Pr6837z3G
	 CAlTOO3xiiln2aVAnsAHVIhhhPd4IVfaeR1cR9y6gg2iHHnAryD6QG52eIgY4RMypp
	 I9MQuV5NgNBYQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Feb 2024 22:00:17 +0200
Message-Id: <CZ3D8KKRVFH4.Y7KBNMB4YXTS@kernel.org>
To: "Randy Dunlap" <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>,
 <linux-sgx@vger.kernel.org>, <x86@kernel.org>, "Kai Huang"
 <kai.huang@intel.com>
Subject: Re: [PATCH v2] x86/sgx: fix kernel-doc comment misuse
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240211062434.16351-1-rdunlap@infradead.org>
In-Reply-To: <20240211062434.16351-1-rdunlap@infradead.org>

On Sun Feb 11, 2024 at 8:24 AM EET, Randy Dunlap wrote:
> Don't use "/**" for a non-kernel-doc comment. This prevents a warning
> from scripts/kernel-doc:
>
> main.c:740: warning: expecting prototype for A section metric is concaten=
ated in a way that @low bits 12(). Prototype was for sgx_calc_section_metri=
c() instead
>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: linux-sgx@vger.kernel.org
> Cc: x86@kernel.org
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: add Rev-by: Kai Huang
>
>  arch/x86/kernel/cpu/sgx/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -731,7 +731,7 @@ out:
>  	return 0;
>  }
> =20
> -/**
> +/*
>   * A section metric is concatenated in a way that @low bits 12-31 define=
 the
>   * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of=
 the
>   * metric.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


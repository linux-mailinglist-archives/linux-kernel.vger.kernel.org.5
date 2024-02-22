Return-Path: <linux-kernel+bounces-76967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EBA85FF29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B37281920
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D989D156985;
	Thu, 22 Feb 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KelkGL01"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EB1552E5;
	Thu, 22 Feb 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622334; cv=none; b=WD/yrcOh7NyGMJ8Dmy0hZWuWV8DV+uyfZ0MHlrifY2EyRTOe7EWe5GWUS2Jq2Vpb+m+c9m3vuCJQUNzkyIQEPaE7SIfjiKb9YLjeEO2IWQruj64W+ZtQwwv2EHGTYixrk149Q5o3Hp+Mp0Djq1Mm4KO52H0e6UEkIsWHa1lqpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622334; c=relaxed/simple;
	bh=6W9R+2RnX+xJriKLEePGAOhhbohzlAhcx1GzJMdmf0g=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DIJgQ7Vp0R3NP5o1VhfkR1DHr9lqqJ8e+hMZSxR4zWdY6Tt7GLF8vlzOX0EPrj+rMP1bsY+w5g46CJCvWZYK2lS5mT1Jj19TNVMHNnlvYT4yzGR8ZBdLIQMNVdSK7TKtSxSSjk/lnQVdzIb4/WRcR5jP/d91ovPBneKbY6xsxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KelkGL01; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4129017c942so514355e9.2;
        Thu, 22 Feb 2024 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708622331; x=1709227131; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qH1aFezfITjBuqwMChIdF7KsoU18GtIL2VZPCgKWDd0=;
        b=KelkGL019BpF+fvrjxUkpTgKKnolgzoQvtlei3Z0cRQW6U5RMb3YnVO480ZtYiu/zw
         YWBAajxH6rsW69KO8zkB4dgP9bXnjUP+aUx/NFh6mJqmD6Re7H4R52J/wTmOADJvMLko
         /eMa3IiMDYq0BL6yNt+4CR7ZOD8+CSdN4aB5zT0PoNW9RrgN8rD70bX7YKCt4b1fbAJi
         G0sUG6qOUndIrvhiqJANeKQ27eQb21aJd1JrM6Qs15IK5BW6p7LdBtjWt/NXqdebbZLQ
         DdR82HrGH+zcJtn6JjGViCaGKaRg8IYvQhnZ1+itwQ7ORuJFyzAtk1G2Ru1YI2PWPiIM
         PB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708622331; x=1709227131;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qH1aFezfITjBuqwMChIdF7KsoU18GtIL2VZPCgKWDd0=;
        b=k9OtwEV5w3RqGdlo6oHpNG0hRGGJJM+kaA3GhGJGSKqXU9+4o/ENeFILI5FJCz2AGc
         VaQGYIAXLTfe1ee23XHr3MuIYjkrTdDjpe1dTBtyUGOx0g1jr0HlkkTbqjDvjmOI6qk4
         zpH0LtDhCJBLoLCwJLY2maeNC4jdR8K1h/wLbm9zwjhJnXxd50pXn1USy9cF+EdZzFnr
         WVBQ0sSzqkJQp82Ir+PhDzXTio9hoJLReqvw6f8pRTjQHLKRW5x3RRwef28BmOGTftOn
         halyJoj+Ww6OFGhoRMF/MvozjMcDUDwrnB+3pPxk7sDB62o8H4D6sFxFDq8yG0lC8+b9
         Tzag==
X-Forwarded-Encrypted: i=1; AJvYcCU9tmpJ7uTKYWvBPLZHO90RhXpw8FPq8hWNi6yg1h1FZxMGS+vYi0oxtqWG40LZos5lqRgslc5X2tZAt6YChDuCF6IGDCt/w0de8A2+Sp9Gy9Q8yucShhSeBbi/j7TMOnrtdos5zRoQWxs=
X-Gm-Message-State: AOJu0YyKR2wcA5oK0/hM2WEkG5317jnQaoo7X4Z2jD/6M4qB7Woqr3qz
	/YshTEYZERJ+6tm0ms1NRh+hFGQAWz0ZvBTkG+hGYQHu5Gelub+l
X-Google-Smtp-Source: AGHT+IE2Ut5Z5WGiB1oJq6SYb9mJspdyJBkPJmLGA9MdcsroVviXKZsZ4S2RZI9rejkwWRorYX4dQA==
X-Received: by 2002:a05:600c:1d8d:b0:412:749d:a931 with SMTP id p13-20020a05600c1d8d00b00412749da931mr4278401wms.14.1708622330531;
        Thu, 22 Feb 2024 09:18:50 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n9-20020a056000170900b0033d5fab6781sm12464851wrc.96.2024.02.22.09.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:18:50 -0800 (PST)
Content-Type: multipart/signed;
 boundary=366b5e636869f080d569d9729819056cc7e75300287e346f441a79f3504a;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 22 Feb 2024 18:18:49 +0100
Message-Id: <CZBS2E10TRA3.23RY1MDLKZCD4@gmail.com>
Cc: <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] ARM: tegra: nexus7: add missing clock binding
 into sound node
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Jonathan Hunter" <jonathanh@nvidia.com>, "Andre Przywara"
 <andre.przywara@arm.com>, "Manivannan Sadhasivam" <mani@kernel.org>,
 "Romain Perier" <romain.perier@gmail.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Robert Eckelmann" <longnoserob@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240129181049.89971-1-clamor95@gmail.com>
 <20240129181049.89971-2-clamor95@gmail.com>
In-Reply-To: <20240129181049.89971-2-clamor95@gmail.com>

--366b5e636869f080d569d9729819056cc7e75300287e346f441a79f3504a
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jan 29, 2024 at 7:10 PM CET, Svyatoslav Ryhel wrote:
> From: Robert Eckelmann <longnoserob@gmail.com>
>
> A recent rt5640 codec update requires mclk definition in the
> device tree. Without mclk defined sound will not work.
>
> Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi    | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

Thierry

--366b5e636869f080d569d9729819056cc7e75300287e346f441a79f3504a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXXgfoACgkQ3SOs138+
s6HJQBAAwbAKrqwAHtiVCCnNzuqO5jBE+I7O3Z1dXXWSBlZm55IVRoGnRidMNqRL
o63gO8ic4dDZhqYZEQNLq31BWbFEgBMzgcmuxTnUp1UlyUd64llg7o+T2nQfGVdO
VepkCixttejCGlxRY6W/HNqYjz6vZwJqtEmlggtOp9OpWdepamKSSIH1kVDjdUsA
lKqCj8nTZwLy7CbA0+ak2IPEBeJKsyspEMY+iUoFWkfw9at3siJ8/k70yTCFl2Sb
m2n3ijm7TIEYipBEGho6qW02xIco9gGBwKrPG5kUGuCNjdqobPB51qeXdgT4Ouas
ZSCXMPBYgNL3cE/2wLUaII1eqQ5BZBQlnEkPI40vP5cEGa18nrIPwyoDof7ivtyJ
rDBeILTGf643lZ4Mk7Bduy280fQEfh3XQ7T7UeCcpRhd9dKuSqXIn5P9WaeFDSGE
hoKl+C+h8RVw6kw2aGr5K0U+7tZcA3nB77ftTZmcUWHFN39QOXnBsNiqXxXGT+3b
WtLXxqReMGAx/FEtabFdpqGUaALRjg1vT90yGYgPAZUwAaGFXhPyRcyduyborZbt
HTUAG5jplm2lzYDgmZDGXuEw4SC/HPVed8rFlAoeesuIpjlpNjT+AyY6BtERt6rc
aawMu9IzNR/EA1g/FjyUY+IokeQ/4Axncae5ZK0xJxic1zLwOkI=
=UPpn
-----END PGP SIGNATURE-----

--366b5e636869f080d569d9729819056cc7e75300287e346f441a79f3504a--


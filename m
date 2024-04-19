Return-Path: <linux-kernel+bounces-151382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44D8AADE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8651C20E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4383A0B;
	Fri, 19 Apr 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grVz/ZfM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97010823CD;
	Fri, 19 Apr 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713527021; cv=none; b=k6ZZk1Npfd6ANV0TgFFZKassqshtZB0lNTyZHMNe1TbrmWjwGzDvxB3DdIlQOB0t+vQcNSpq9Qv0i0G0Ou3Y3BUo83Ge+dj6kws6GJL5Uz9YLyZ1A2LJScq9tO85MGdga/f8loCj6DClX7AnHt4XiXuxQTAp084Sc4BrC/WStvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713527021; c=relaxed/simple;
	bh=SDvfATrblJtPqZDTN7fh/edFPyM7fxdzepU5ARPOsWc=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=P/ftbQgec1uv33yjG7A0818PQsWqG4vAEZOHBUPLo/qVwlT8R0z7FQ1lCU5ds2vNmazcqYmk4iMzbpqstnoZahSVL97rEG8HsEdE0MIe7tjNhX7IPS3U4LWUScuH3YyfIho43tnvw/9QpNswnhq+3XG3m8QYPWfqGJhRpN/xAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grVz/ZfM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5568bef315so342585566b.1;
        Fri, 19 Apr 2024 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713527018; x=1714131818; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPmc/4owH0Pg8veXJQwI9dmpvZJBxyntKU7M+g1uaFk=;
        b=grVz/ZfMT9wMJCmTaCITODRg79/VrzkRoJfjr9ziY51rSOduQURg79stCDkRISNyyA
         JuS/b5JYRL7nP+L/kkLJdX7QFqsYSfd1scaZ5BuH0zqpS2ltzzXKoww1te+HrKdlwQqV
         uNfbndhGhxvFcO1dkSjNRsRfktyBOuKXgXwU4RUqF5jGqk9kOjgrwCZS2Vn8y8wV+gOk
         14FkZc8+cuE80Q9ibPBpUgpA7UtrAL0MQzHiTcUVCWMzg5uu2qvl+hJReNcEVoJs5hJT
         JutBa1/QMEFD4Uo8DUnFNe2r+3b+mcUxF+1Q7hqtqF7HZON7HqQnt8dsLTMIxABBsC6k
         i1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713527018; x=1714131818;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPmc/4owH0Pg8veXJQwI9dmpvZJBxyntKU7M+g1uaFk=;
        b=Oeu06Gwq7lqI83FwV4esFRhFXdXCh7/MLRb29XDvJyClsySH/Ck93zV8nxUYoGVuz5
         urfEvB67fUmrVwNMFgDN54U0nXGQS8ZsVVTTE0+1A/OI0mjLRva6wF9AH33n6re6JGoz
         fIXl4q+AHuZe8v85G9hbNS4B1sN9p0kfs9QlRJVOwO00hGV1c7v7Yv69tGVnRWc77S4C
         7gecj+WXJCI+NCTkRYgmTJhWgZ5mKAN3aYPewPTjQS3pb6pf0AjvSRAHuLMrF8mThilH
         zvdGlwhrzRp66pQORWXbJVKHGlq6i8TzA2YmoNz76nxoPXOgiEMTfv2fcDW44Brv/UNj
         eehA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9HvELL8h0BcNjBEYRwJ15jUIVXDdSvBy0FFoP5ps/LnlJrhonhHZwEx62oN/GC2xaEGrI2qCsmkM+d3g9mlq5xlFXCZENaPGni0qT/UqAjGmpN4osbv7H8MmoqeRPYXVwwVx3uZptMslwCCLSpMsjp0Uf9BNSkauvOb9I61EZLYQioEiQvlxZ8k9FnEHbcxQaj7JKrhNXI1cLUW/qu7AQuKcMreVpdU=
X-Gm-Message-State: AOJu0Yxey/fHhjRTu2x0wpHj8iweufiY4S6xjhQ15miuOUjZ/o5ZGvKy
	MZobpf5Sbe7CWm5toYxIAbhNDSmN56bkGwG+1Bn4D7qcIuKPtqmWhSDxBQ==
X-Google-Smtp-Source: AGHT+IFykUUUAzq/W+0l/J+OAX/yXPPrTNgr8YSO1afm1yc2CAy5Yyng3dbPqvfDPcrV9eUUNptLbA==
X-Received: by 2002:a17:906:c792:b0:a51:89f0:10ee with SMTP id cw18-20020a170906c79200b00a5189f010eemr1767493ejb.37.1713527017912;
        Fri, 19 Apr 2024 04:43:37 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm2102530ejp.171.2024.04.19.04.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:43:37 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=8684f2cf78213ec7087df5092a7d7066a1b5db537e70331ea50ea029c8c7;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 13:43:37 +0200
Message-Id: <D0O2MSGJKP3R.1IVH4XRHNQPPD@gmail.com>
Subject: Re: [PATCH 1/2] crypto: tegra - Fix some error codes
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Dan Carpenter" <dan.carpenter@linaro.org>, "Akhil R"
 <akhilrajeev@nvidia.com>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, "Jonathan Hunter" <jonathanh@nvidia.com>,
 <linux-crypto@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>
In-Reply-To: <ec425896-49eb-4099-9898-ac9509f6ab8f@moroto.mountain>

--8684f2cf78213ec7087df5092a7d7066a1b5db537e70331ea50ea029c8c7
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 17, 2024 at 8:12 PM CEST, Dan Carpenter wrote:
> Return negative -ENOMEM, instead of positive ENOMEM.
>
> Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/crypto/tegra/tegra-se-aes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8684f2cf78213ec7087df5092a7d7066a1b5db537e70331ea50ea029c8c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiWOkACgkQ3SOs138+
s6GABhAAqlXi1IpsMIZfT/CDoIc9CMp1WGhlFEeE1SoYD1Rfef4DiAr/iYlj5D3i
SIwuriO4sg7YpBcGGslg4Jl6fNnIaHOYKnVm4sOTlHX91C4k9sfaQ5CbgrOegsPU
leBy7LLvni7c2XWE1PTGDiZw7iiN07K4UiO4x1Xm3SObqkEBfEylLwCbrrWd6O1M
9QSySZqjtIt1rMDiDnGIy3WabuuH91KlC4x2KAyRDSipui8iV0F3k4Kd1ztukVlZ
6hKYpeKtQm8CLgIPUSZ4GHi5NhpYM5vGr42F3wH4qtwR+VF3vViiz+UOOEiZTHGd
oUa9SmtRJ+lTnUFkWbrQL9hCNEphrH708dGOTljwLTJS65Aehqvx/awB8tsAywj+
76eRFXQAMDDjDTAjl9ETkvdf73HptwIOpSe2oFSq8CYAofQNzGAKKZ+59gQIAkx5
lWgjypYeV0KL0evK1WlwSXlpdkDEZtaSR3Ovmzbr4wFrhLZbfspW9oq7wDU34uOS
eLs+EvOD5vANXEUDAvyo24B9ExYKjiNV5B4OiKo2BRXE+P1m0tpKAWYOn1b8UYZX
6eKEgxW/RzzaIKczYqxfqyHJn4i5RqKtVJiNOv1NI4p2ukfbsMeEx52cimLs5fOc
6kl+w+NojIQJiBt8S1kW6jCM0CcGmim1opGqasmNDcaBowlLjUs=
=qa7Z
-----END PGP SIGNATURE-----

--8684f2cf78213ec7087df5092a7d7066a1b5db537e70331ea50ea029c8c7--


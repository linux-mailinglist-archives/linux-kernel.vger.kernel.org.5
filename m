Return-Path: <linux-kernel+bounces-55109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EC84B7D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5292B1C22A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCB113248A;
	Tue,  6 Feb 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9lEpONE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421B132470;
	Tue,  6 Feb 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229594; cv=none; b=Vp0gsk3GQCmgVkmiWTIDa2Ay7Gclu6x7e20ysBZMDFEhKga0fl2AG+iCNXxWeP8YpGay0Ns5qSaRyHNmSmEKLRymk9SdCsQtzfyrRO+/xOdeJVxjk+TMYk+GTHBoHKTSpT9gMIxLaus/gV/vvY649Y76kwTkVXWaXhjoxdFg/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229594; c=relaxed/simple;
	bh=taq3L64tS+RfH9YfYPFNeFpcjYXgKL0N5wcIij3VlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gk58LWfjCNW9hAEPlVGSf+Ombb76KIo6TCeWnhB91zYSjWetwmP8GE2l9aUPRg+qEGZiiKgG68FS7VlrhCFft5fzfyBlg5696sBhUFRogIJnHY4sV8B63YEwksnzIvXW53+lpI1vRZy6iBz4wiK0fDPKm49y8v8rPaD0a8VQ4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9lEpONE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296a79e6295so1448767a91.3;
        Tue, 06 Feb 2024 06:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229592; x=1707834392; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vepv8gImWkrfazjZUAn5WGfDhRJsgg43sIyFpGXYJ9M=;
        b=L9lEpONEIVMKYDbzV8+nggk7IT0FHn3Rv8+BupX6bnrQVCHXKJtxkIlY5xGiz7AOIc
         fA1p73OQApxx7JauZA385QfHpl5ZSgDjaQ8usJ8mYtIYhL8dFlUDBvrvVsp2EmU6N4hK
         kCm/CzDxT1OtBeAOpB6IafNeZpOs1Gj4bCiwF9vPOXEnV7rP4aRs06bInV49qRvK9Zmb
         HeSNDR8HAMFLtP1bq7Xjm25fW1atL1O32tt9gyomiAbP7YYiyYP1c8DWOTTM1goIsG6s
         PfccKuHierMq378FLDUTHj9kNemQOYtO1a80TjM2CfFOJ3WGL9rSsm2Xd1OxZts8JIv/
         AVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229592; x=1707834392;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vepv8gImWkrfazjZUAn5WGfDhRJsgg43sIyFpGXYJ9M=;
        b=KrsCEaDhvyhdHtlKdl7K8p6sjy298C9KJv2OVnbpLbESCz3G9rr8b8FZAQWnR/Qlsw
         DhCfVjxN5T5EuKBAORQMuP+EN/VR2fEObL+0+j0w7F1+NKSdcCb03sEnmj87ILcFzVpA
         WhcnPf2c1CPyS0+yutv7VLRHHL334vlRlArlRtCewePRAnS/lNZmnMauVc0Unr8cE9HO
         M0GfIEFX15KkCh7pDO6jx6+/ExAsZDnCaCZV8QzYkDUVqw1SXXuUVt95kx+yFUFrYRPE
         b02M0n4plZcMFdmyZARpx5PQELlZj3/7zl9JLzHVRN2N4B5ysvJwaDrqqMgxQENWK0Mn
         LU3Q==
X-Gm-Message-State: AOJu0YytbX2lZ0uSNPoMoiOTuM5xrQy9N23GC3A/11AOCf0YBIEXXPpK
	sbD27wmRDko/OpEH0RqChQFDF2YWakoRPmBdoHB6+X0ffsJJEsNRcs5tqZnDkhg=
X-Google-Smtp-Source: AGHT+IHl2YgqTMoNDArOCmuLDpGdPBbWrUfiPN4l9/AdbsTVNrbm4QibQ7L5yMQh8tORExTmqsju/A==
X-Received: by 2002:a17:90a:cc07:b0:296:7bc4:5926 with SMTP id b7-20020a17090acc0700b002967bc45926mr2443348pju.10.1707229591722;
        Tue, 06 Feb 2024 06:26:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+rFbZ74k3LfMZ/G0nWeH2mjyOUw920dnpViVfOaF/T2/Gkbqa0MTAs8IPluUW9U9dHWRln57IBMyxDbQQHqZsFjmY2/T8ssDhWKSDw+COQHT5njgxtDUC4eA3OSRbak2CVAKhKO2zo6ygMG3L8Ypbv1BvnZRVosSn0R1tNKJ5WcUPArYQVkq43Vrl1GPrCxRWwaXPxGKybjFDuf4C2mRhYE/IBCz6CA==
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id rs16-20020a17090b2b9000b0028ce81d9f32sm1691461pjb.16.2024.02.06.06.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:26:31 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A7E9C19F45418; Tue,  6 Feb 2024 21:26:27 +0700 (WIB)
Date: Tue, 6 Feb 2024 21:26:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Crypto <linux-crypto@vger.kernel.org>
Cc: Robert Elliott <elliott@hpe.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
Subject: CONFIG_JITTERENTROPY needs more explanation?
Message-ID: <ZcJBk_NQvLzwzprn@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hYAR6xZuukOnsZ1F"
Content-Disposition: inline


--hYAR6xZuukOnsZ1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Bugzilla,  Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
wrote a question on CRYPTO_JITTERENTROPY description [1]:

> The desciption of the CRYPTO_JITTERENTROPY kernel option in crypto/Kconfi=
g has an incomplete sentence:
>=20
> | This RNG does not perform any cryptographic whitening of the generated
> |
> | See https://www.chronox.de/jent.html
>=20
> This was introduced in a9a98d49da52 ("crypto: Kconfig - simplify compress=
ion/RNG entries") - please fix when convenient.

Can you explain why the Kconfig description says so?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218458

--=20
An old man doll... just what I always wanted! - Clara

--hYAR6xZuukOnsZ1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZcJBjgAKCRD2uYlJVVFO
ow6EAQCJoHqhJD+AlrQLLEYQkqyNhWj5+L603+KRtq46AQnYswEAvg4r3SdcmCer
GvKsc+stQA1iEsntUUGblTylFpskdwg=
=VHpG
-----END PGP SIGNATURE-----

--hYAR6xZuukOnsZ1F--


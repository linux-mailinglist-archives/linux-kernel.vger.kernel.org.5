Return-Path: <linux-kernel+bounces-141773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC18A233C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D071C2156D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B65C96;
	Fri, 12 Apr 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fykoWlT+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDD33F7;
	Fri, 12 Apr 2024 01:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885561; cv=none; b=jebKYkvr4Qbkysfymcox8N2qVp5YtEapcdKRWvstWCa7fW/9JkgrTBBgWAbpUstOPyyR2Gh8xekH65dC4hNqi7OoNsOy8QmJoCfm5RMzxO546pWzRGFGaoHZiX9mXRQgdADvAqSt1ShI2QA2/ZBiycZSmHGBI65Z7G6fWstzCTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885561; c=relaxed/simple;
	bh=PU27nh4ICcMKtfoWAY2oTKn4uNtsFsaFulZ55C62uGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsJWrLU4VtFf4Yd0z8LyQoqDVPWo+lUyaM+3aMM0kcaAIrE0Rh6H2x/QXq+Cb/Qzpq/KJsuwXPDmatSuQuY+l4BnB+U35S335BATvXAJpPNZnIdNQWGpOtygeGJW4fGMEoF20NJzvmox9k73TRq7PMH2juPzoWreUmrqwIkfh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fykoWlT+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecff9df447so482767b3a.1;
        Thu, 11 Apr 2024 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712885560; x=1713490360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU3sSS4eDu0gFlOQ+EtChbXI75mbMnya9v5nETYuAbM=;
        b=fykoWlT+0mSi0WrWVQIdcVJTec42twBxxpZjZ+A8QQKFejrMJKD9AfTFLEM5N3yOUH
         u2kfu/udjKSpbuJ/XG42dl73HAmGEAB61/UJsKtzCDgfM6166slk2uHbmFizGFquFQ3+
         vGMKjkVJKO8YGOMOMd8nNXpobPWwHaH+lJGVw6fqtgZeE6FYkHPlym3BWce79A+AQv9q
         AQSTj4u2oIsaT3O69X4ju5UnDFE4ujWWic4YTP8kaabN0Nn/1uz6rJM/y1uSKvUIOxIZ
         FybqrwWeKJ7vvZHnpHmud0mBBGF/yCRZyeyIr1nSuOxGfDVHhFstfjG3sOY6s7hz2R4p
         8m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712885560; x=1713490360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU3sSS4eDu0gFlOQ+EtChbXI75mbMnya9v5nETYuAbM=;
        b=gT0sXVkaVJIB1ORL3/9RJbj1/xgGRZWbKjLBGxhZ3MUNkwL6tQ48FbVax9HtIb+7Aj
         wO5qGA5dK6i+iz7ZyNplkfQY3uUG8iljba6j3Sw3oNihzXjiWScvw3+oXrxfWGHol81B
         +O2Q51MPbNiLOcU2uXxibJCYHgv8+NAM9IrEOgKfdrdi1o+xf4U3RYmn0ZmZ2TZx1OrY
         q3rcgccqLW9QzrP6Pc2rHugTe3rAgZYD/Q6U3EogsTWA0SGCnahS1vyfaBuJ6kjAKa2A
         YfIu7unfkCwGzNUfgB8iPPy1FUTS0/7nXbkaoS98hpmh57aRUu3ykUti+f7YEim+yZ9P
         FhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTAiqYe6DwK0Vq1tmaT4zAmKRUTrWWOBYxHK2nPOUZdR9CMdkxtV8FfWTUbWJQPdIx7XeSQxd53Usf8vjzlhKFGYGNpssn/xJ7cmS7Pa5kD9l6FOU1BPO39zvMqwXPN4BdnjmF
X-Gm-Message-State: AOJu0Yyi9hGFm+jKrEoHDCfwGqex80l2amYkOBNNMYUwBtxrN+TkNrjI
	tXd/lI8iXJri71afVhTgnhOLF/V4Kwk96SRa5FTjQEtdMwwMea+O
X-Google-Smtp-Source: AGHT+IEfQBpInoWg7ls3MpIafYuMBgkN2A6xBoM+hy3ZDJ1AN48nI79H4kzzTR2Jkb2hBKd8AtqDsA==
X-Received: by 2002:a05:6a20:9496:b0:1a3:bfce:ec9e with SMTP id hs22-20020a056a20949600b001a3bfceec9emr1557696pzb.18.1712885559704;
        Thu, 11 Apr 2024 18:32:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i89-20020a17090a3de200b002a005778f51sm1920924pjc.50.2024.04.11.18.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 18:32:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 14281186BBCA4; Fri, 12 Apr 2024 08:32:35 +0700 (WIB)
Date: Fri, 12 Apr 2024 08:32:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <ZhiPMz1V4TwH_wKb@archie.me>
References: <20240411095420.903937140@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KD2kvVoGn2JSdYIW"
Content-Disposition: inline
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>


--KD2kvVoGn2JSdYIW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:54:28AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--KD2kvVoGn2JSdYIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhiPLwAKCRD2uYlJVVFO
o+FUAQCBcW+tpaOSaAinvPSnFZyQ1A+fI7JgTPvpQRLT6x0bTwD/VBb1rpYSBLEK
0FgrnPcLWyxBzYmF/u+FgiSn5adh9wc=
=MQEi
-----END PGP SIGNATURE-----

--KD2kvVoGn2JSdYIW--


Return-Path: <linux-kernel+bounces-74157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28985D091
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885A528831E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C13611B;
	Wed, 21 Feb 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dge1XcLl"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B1365;
	Wed, 21 Feb 2024 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497744; cv=none; b=GPIkj/qKXpg/aJNYQi3zKVT8TxwVAg/3ji4E6Ebj7xpz5zBRYeyTPJHo8eWdXRSMmMtWzj7cpwzU7eC6SLR/I9W+pZK5Trgxe3cG/fuDL33HoSs+w7KauzZ9ihIKYQy3CTCoGsBxc3DyE7/XM46RP/vfbEtDlAvv65ip+C3pjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497744; c=relaxed/simple;
	bh=VNdJmD/gpyse/FMH9lufHreZgd3FLHQhGe9fMKcG+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKCZtgH6emYx1PW6X2U4anEayBOF9WUP0j/KxhKTmfw2cnGIBf1bWMmr0FKhp10MAKLLhXCl8BcFrWQ4moXQBgl/nKddv1bJvYLGJU4WsLceJ6i07x+TsWgB25kydQvHzxcaEEQKa7qQ3ULi84l+6qtYUTqx0m2uE0QbnzgSYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dge1XcLl; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e461a9e40eso605777a34.2;
        Tue, 20 Feb 2024 22:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708497742; x=1709102542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qepPg3+JSFA4GPvBKRhv/lZipuP/R6kgkTa4naVw58=;
        b=dge1XcLlHmZDLPKBloNzE9MOZL8rsE2q1ZdPG3mrNG/LooEBvtbdL4irDHWmrG/TLC
         JfRGGZzcGFTO2rBehvlx5bVP8/+Vebu2kbUcsctkRsy0zQd2HWS4CKAhZ4xjFMQbqMzN
         0L2e12tQKjaPpgbcd+HDQmmEhUaFQ5u2YBBsHBkC9+BAr0+6NU5bptASAUv58ohAz78p
         J/TxIqlIP+V38J248mQnI/RguPCCyYAlWlTRzqrzMuMe38vsBQFR8OduhDN3lf9+M/KQ
         k4W/pWjrUnzXBCwio+sRKtoifdURQlZROPnYLKoOaJBFU9ziDNNH36nI248smO/O6ShR
         WByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497742; x=1709102542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qepPg3+JSFA4GPvBKRhv/lZipuP/R6kgkTa4naVw58=;
        b=lBkLyWwxinoru4Hzb/o+5wE4ddeewhW2KqQDsnueynmIL+ZHmJ2tB++LNyYrMBai6u
         M/Wq+ap8m5O6WGqPxYG5wBF2UXDh2qslj+4Sx6+ObT0ncv6aYRSZCxa8pFsSlvIAiQbA
         nbWl9gQSjPdJ88LHuCbyEq6MRTzV0I4Ankg1+M2kzZFt1Ncgh6g/kH5UlHuUINN1Mb4D
         J+PokFUTyrs9xbXTOKytQjvIk7IOie6sOaQyIAWB/Go3leGylms3o5WgeObBtvWktbEP
         jJ58sQWD7KVV/hSrjJWsvuWcqS+sD3+8ZF0FUxMMs26u9sxBfr2TK4W4n+K5OdqM0UEs
         ugvg==
X-Forwarded-Encrypted: i=1; AJvYcCW9wc5SWk4Q40ya3arkjqOEpsuRA+JCqshOcnPOa3sfb8KBtCAQZqyxKqlK5rTyEuKOYtIk0eaDgvMtKaGGWTUDJuyVyXTzA0g07QPwckZeyCw8iNFrFC+s58ZK08HwfYXdom+B
X-Gm-Message-State: AOJu0YwXNJtst5euha6Nf4F01WUVuOm+qnOzoXknlCGUf8+zPXZS1wtT
	2WPUCKnsck3+MHXkbBvIbufB1WntdT0FpQNGASJdAWFe7Rww+j9PWks+p8zHttc=
X-Google-Smtp-Source: AGHT+IFX2wH+plNNcu1hJmDhVaeR7nE/+xXlIrJD4rY1IqlkWMMc9Bz7kLC8LWre+uDoFlouYw/hgA==
X-Received: by 2002:a05:6830:12:b0:6e2:d9a0:b2b0 with SMTP id c18-20020a056830001200b006e2d9a0b2b0mr18278306otp.0.1708497742019;
        Tue, 20 Feb 2024 22:42:22 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 5-20020a630f45000000b005d30550f954sm7667671pgp.31.2024.02.20.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:42:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D76C318468568; Wed, 21 Feb 2024 13:42:17 +0700 (WIB)
Date: Wed, 21 Feb 2024 13:42:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/331] 6.6.18-rc1 review
Message-ID: <ZdWbSQMfQoHUZFMH@archie.me>
References: <20240220205637.572693592@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xfP/hcoK8GryOZ4A"
Content-Disposition: inline
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>


--xfP/hcoK8GryOZ4A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:51:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--xfP/hcoK8GryOZ4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdWbQAAKCRD2uYlJVVFO
o8gSAQDcSoCptSpp/zoQllZP4KjRqZXxe+YdNcfeyiCxVWalRwD/TXM0d9CHkfig
QgHIDWMCF5pGxWzKdg02GHHmkFstiwQ=
=OaW4
-----END PGP SIGNATURE-----

--xfP/hcoK8GryOZ4A--


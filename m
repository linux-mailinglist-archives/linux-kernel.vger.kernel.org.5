Return-Path: <linux-kernel+bounces-74177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42985D0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950B3286391
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB03A1DA;
	Wed, 21 Feb 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqw2l35X"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19C39FE0;
	Wed, 21 Feb 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498734; cv=none; b=YLQ/DZezSi9qoeo39QGVNJUea4Jy6bfMUP7F5Rljt65K89Fqm0FbrvXmwFhthZ2sS6TjK1JI200s1bTvdyLN9qjU8Jl95oerAv96knDr29WlGqiP6dkBoeTR46FwOQxnaKSogys27gCSw4k+dgbP/uawDK/WtdvPs3DTwcvYECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498734; c=relaxed/simple;
	bh=esYaMcSp0zrdIXaMpGrKr2iJnH9k7dzBw0jMQRzQ+i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuoUf9tbuz5ZOfotFtxpxJCJxf6bVwq5n7BWlI/DmzoV3XGJ8MHNBFQXLvDrMBiGklZPbrQPAttBhUIogTBIgOa2T3WrBtU4b1y3Zak0A44IHhRldF//QDXanRy3WGa4wWufaPEtrJPPhdtEqb/5STSVZNolFIbetolzeq/ae8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqw2l35X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc13fb0133so2076115ad.3;
        Tue, 20 Feb 2024 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708498733; x=1709103533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrTzttb3S5N87z0vQ+akgGn/f9AZy21TXyym/YWd6l4=;
        b=jqw2l35X1LbePJ8H7AWrMxZgDXmfuv6e31u21MMoJBO9yI/wO2OIUoV54b+A6ZFVej
         0TxlR64ZDvKJqi4luGCqdAbC4IKHsQhwaa8GlU669rLRtEuf60MBAmkcuJzTvmq/pH5l
         gB0pzRyHqLxIcK5/8ZFM/hlvG9ccm7OVmBJZhtdghxuud225Bx9gakmm8fFD4Ntqjpos
         8xfmp3HLTC1QmlGNZ+vyLBuVMPLtUUzV9i3rDr30IhVOhp2A6blQUT24msoByC9ZZK2g
         EHAurNrf+GWLLd438wS8JDkm4hybBHQmca61ksH0xoycy2+Qo1Ts5lSrRbGSD7AgGgv8
         2J8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498733; x=1709103533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrTzttb3S5N87z0vQ+akgGn/f9AZy21TXyym/YWd6l4=;
        b=eutUy/EsmIcFMikyjFJlB1tDSV/GYfpa0wTPcakVvmaxMG9hYqQpGuBZrrlczZa0WW
         Oday3eM7AXhCRTfgEqySlNwP0FoqTng0YsRef7ObzVHsB0L3zXHtryIjfjpoHxRNslZQ
         lHAZjVnPj+Em/E3iDiZtHBxUKXBNBZ2W2lbTTTAFdt0ukr1xWrlaqk6lpaDXXPdVKaax
         xKDrpDfG60Qo4/7bCqwvIJUfL0ugofTlfAoit/mm8Ur2h8qtAiRl5CijQ4VxVIdBWIJq
         QwgbXfToGgfYInR29vluwabuqbDcEaNCtKbyKfyrCurvWeaVV9FoHA+5olARsqg13e+R
         iGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVnyefet95miB0OHEyI0Nbl3sdzVrG5PT9M3Kf3aJtts85vUk40xAMn939HQuTQf+rtJBO4Xo/ILHSB2eM8POFypuJu0wLrt4Gvbvu3NyxW4aVguyCQizGjhnzC+VR9Q9u+4CfU
X-Gm-Message-State: AOJu0YyDg7RRLv2qxIBKNOA1DbVo2AwFool+lB+mbDmDqeXbmKZiPwLD
	AmsWvjQk7yrSGbYyeQR/llCvuHTisUPpYACoIcmZjf3IvDlD0gYn
X-Google-Smtp-Source: AGHT+IHkL0orzm61AWV2LyAwg/yFw2+V5wvEMjWMHHT03HgbgkpZEPjN9GNQNW9YUUHxFa+rAFwlww==
X-Received: by 2002:a17:903:22c5:b0:1db:ccd1:41f7 with SMTP id y5-20020a17090322c500b001dbccd141f7mr12761795plg.56.1708498732840;
        Tue, 20 Feb 2024 22:58:52 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001da2951a788sm7324035plb.304.2024.02.20.22.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:58:52 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id B44F91848BD3F; Wed, 21 Feb 2024 13:58:46 +0700 (WIB)
Date: Wed, 21 Feb 2024 13:58:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
Message-ID: <ZdWfJqvTeaAsM437@archie.me>
References: <20240220205633.096363225@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uK4LsNMgGQp4a8h4"
Content-Disposition: inline
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>


--uK4LsNMgGQp4a8h4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 09:52:39PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--uK4LsNMgGQp4a8h4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdWfIAAKCRD2uYlJVVFO
o50YAQD0j9xM0KbrlQWp9tg4pXWjbhDEfZ/ktJ4Ny4cU/pJc7QD9GQzQiKYphDJH
CseSofHsHBQR9bMwv53u50uBgg01IQ4=
=R86Y
-----END PGP SIGNATURE-----

--uK4LsNMgGQp4a8h4--


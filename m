Return-Path: <linux-kernel+bounces-156258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDB8B005D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2661286211
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C2143C4E;
	Wed, 24 Apr 2024 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9QNpGI5"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426013C8F3;
	Wed, 24 Apr 2024 04:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931587; cv=none; b=s+pmJACCzQZY8DLHhbuxgOVHvtji9uze13Pphjks9sYOyEnjGz78YkCMAEX0hHeclUIvuXUb7X9KwbjV6lRjabQt24KxNuNkhHhKcvgQcC+nas7BPMvLy2uX18LLO2xNqYjocvj+iCzsC89J6YDQkbRm/ytn+3d8sleZhCS3Ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931587; c=relaxed/simple;
	bh=f1Dv5zv6/MeC05k9gFS4Dtb4TNI1V2WafkMkhzGBORU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h39cNmJ2LUJb//m7i650391JTLP4BrOH3Aw5MZuCYWYInpckq9U+1cteLA5/Um7HE61lRmIbrB3aO8PeZatPFNsraBPsJq1NrwJB82Chn5uzoaZEZt6a09fjE9ADT7R2x0MOlWNWPgpKs89TjUrY6nGb7LSg8EsivjaJpd9PRlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9QNpGI5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e3c3aa8938so44711005ad.1;
        Tue, 23 Apr 2024 21:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713931585; x=1714536385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/O6yWeew57XxnKc/kCg+J/zVlCaUNwIlMUpnlR1Sd4=;
        b=d9QNpGI5OoFGtkk/q3lHtlXUgrzv9wMZKLbI3cxk2FSA8PQeMSEHhoxrUoh/EReNMm
         7BQBw+CCSXYjFO4WUogx2NBHyKES56BUu/MguIMZi2fvNIEi8dC6+utepSGXFyzwbJuz
         lN1RZCQrdrEt4XL+A53ZH6J3NylzE5XNei0+Awigf46eZa4FyZ2XqHIXsAaXbvfe3X2e
         MtuYkjFIwpgTX3ubCOOg3wxrBca90bEt7S96eleMzxuK4w9NICYiVQ/A7IKdWQIoD/VI
         Ff2pnzNK114/vA0ANKdKGUZzDmFpk8cQ7ppRp9v1hs0X3sNxb09vMp869rJsARdEzrZE
         NJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713931585; x=1714536385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/O6yWeew57XxnKc/kCg+J/zVlCaUNwIlMUpnlR1Sd4=;
        b=ByB5KB27DAhJNPcFNeiHKcWRn5xJJq/FWJuFhQ0d53bjUmPgplS5tAQu3UA2rzvp5p
         vBt9RehTO2EG19fqyygwxjHUeD301gVz9mK9d7S9LOBpvIHDVUP/3+6mcXA6NwBNR1dZ
         p3YwiNjMgOCwHofVpknJIzwznPmjBlVRAJTS+HKfP5jFkEoqLflvBuwnyaTdIdRpaAuR
         g021wuQ4iFqrD5KbbFryBpjqOzyuvacgBur2oEmEkZkZQYXBsBUmD7qwuA8valpcJHJe
         ZwGVbEM2J2go3kfbfXh8NZJm7DVflgXgP6kOKb0wy6IN7/rL9jY/vsZZZsYwnUB2HVQI
         hB+A==
X-Forwarded-Encrypted: i=1; AJvYcCVk+65pkLWTyaySeqTogJGhDZT1BVsswgN98tc7Ur7N+VILzWX0PbGT/CC5hKyjEcgz9lK0hTtpgX6TMGHj8YRzM5Ojlf4hRSA+RNNu5Gpg9eM/VXPUcEZt/xUby2i88wkX3oGN
X-Gm-Message-State: AOJu0YztVU2HsXZU9HkPBcte//7DtgSRMDyYYwhcUr5Khg/apWfrA4ib
	k0631i3zsuysMLoMp0q/fCnNhjPX0ZTyB1dltJYEyy84hBshFlp9
X-Google-Smtp-Source: AGHT+IHtBD+jhtIDvgZAHS2pfecScdht7j9Q0KeyrXlemvT0eMOOuJ+KhlcDzUOxFyuoNdDvoRRjpw==
X-Received: by 2002:a17:902:c40f:b0:1e5:5ccd:30e1 with SMTP id k15-20020a170902c40f00b001e55ccd30e1mr1274214plk.65.1713931585179;
        Tue, 23 Apr 2024 21:06:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ki14-20020a170903068e00b001e434923462sm10876342plb.50.2024.04.23.21.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 21:06:24 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EF44F18462BD3; Wed, 24 Apr 2024 11:06:21 +0700 (WIB)
Date: Wed, 24 Apr 2024 11:06:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
Message-ID: <ZiiFPdhkEOcw9j6L@archie.me>
References: <20240423213855.824778126@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kMDSqLl10Vx85l4k"
Content-Disposition: inline
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>


--kMDSqLl10Vx85l4k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 02:37:02PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--kMDSqLl10Vx85l4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiiFOQAKCRD2uYlJVVFO
o9hmAP9A+ekpvYbmpT+rVVsRulkomktuJw0Js1RqLr5qxc6MRQEAjPuOsaPLop0p
JnLG2tN2FAMS0dBZpY72nwhdw6fwmA0=
=n4ej
-----END PGP SIGNATURE-----

--kMDSqLl10Vx85l4k--


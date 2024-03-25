Return-Path: <linux-kernel+bounces-116764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4C88A390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0578A1F38C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15DB158D7B;
	Mon, 25 Mar 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzJNPFYJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76413C3D2;
	Mon, 25 Mar 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360515; cv=none; b=hbjakyH73x2G5SrjnrVC7sWzROXA4Z9jjmPdeqmQVDTglO/74rG87VM0+usz2njTKa3XmHrchp4KT85bJQe4ZhSFBrxOUyxwF9ZmsuRzf486pGv7oSOF2E5AkmpGhCUsgZKNIuTFCPaqsFj6x01zPVwO98lXKLS4d8cCfyoDy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360515; c=relaxed/simple;
	bh=Sjjpd0e5L6/6IHS3PxHBjSD0ESGeyO/POIt+kwNDIDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns7brd0bbsuLI6+7uol537W06QARUnWoLplsTc65OCnJfYYVqn3W3ST1hHBBifk476WEGKLHFyq6RrOCMnG7hWF4kZn3e8MswFV+b00QC1PIYk8KCatDM9uO8iYDopib/pwhmXX1HwkZbFfKZ0Z8ali8oEHxcIjcxORr/WSGNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzJNPFYJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dde26f7e1dso29248805ad.1;
        Mon, 25 Mar 2024 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711360513; x=1711965313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wUCky1hR6lYs2+y+tVEc6I8rhJ8fPBV7+LaM66mMDQ=;
        b=KzJNPFYJJYp5rkaN7lIi9RSQXwbWCWuC/zkze+8luKnjEiL8LIsbCgjSFYkroL2u46
         rZo7YS/zCZzdRUEvkJxhqBgDp4dZh/FqgfkpWpiseUsKPOctTGDQFB2xEvb3DNM+b5Ja
         dSjYXz9GvGq4CbHr5AXl7WbhdZRwVJgvYYvVxwGVa+CqMTIWTj8ywQDimncR5rMxAmRY
         cFw7yXkX8KPHcnVbrq29cQMOSUcWtB31g29GXQ6gK1B9UUx6OyIOnO2/pC1emXIxWNEJ
         IRckgKj79J6MlapH5NvehgeWV+6bBdOG/HglTWxMdK5VxAc/vnXWUU8aij2OuBVJWHjr
         Kvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711360513; x=1711965313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wUCky1hR6lYs2+y+tVEc6I8rhJ8fPBV7+LaM66mMDQ=;
        b=gQYgQEhRVAkcfCljrOnAFoAGMZSu5NQUE9R4ZEQWhp56nC3VZqQ9jD44DXFv5I/24S
         crNDv7UsLVj3FxIX/zI55YxgqoKBL9fyiWjWlpB9jZH7+mSgzTWERtUrxpR349iKYT8V
         rmAdGb6R7fvlG8tm3elD2mR2Hs7QxaY9YQJ7O87jzH06H0jjl5xpWVVq84WOczEXWpb9
         YTMA3Ovkg6FqGhhhpCC83mVkkpSSlqnmqLqlRjIU5nzrV3LghyuwpNq4n7aXVmWIPuNQ
         l3Oz2ewTbeK8JMBJXtH9h6ehrMTomVYV2uHZ3jlpMfIXQ7Eiz3CzHZ7PfMT6ef99rXfN
         F3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUcYwxTrByvTkc3L1LygGnh6BvsoLDnGxWP9w18sH4bQh13wrtVytXju7Dxl4MsF5D7hKk9q3laUpWZXx4WZxtIqhWYVmwQD5Vs+h5+ESlOyZ/6pkUW0sJENWxSAcOr2Le8GJto
X-Gm-Message-State: AOJu0YzX9DlGcuQyACzsKbN3o/WeMctPfRMA4SKi+bUvpvHFSPKKSmVd
	sJhiy1dCLENKg2G7J7NpLSYoHdTycZ6t9TQgdCnaei132IxxvgHhzNKDVHTvS5g=
X-Google-Smtp-Source: AGHT+IGK0FJmKHRVnk2WArpCghu8kTZcuRCabePkI7qYLmNOFrIBc1MK4b0Vh5g1H/diRuqn/Arq8g==
X-Received: by 2002:a17:903:22cb:b0:1e0:26ac:8234 with SMTP id y11-20020a17090322cb00b001e026ac8234mr7355496plg.18.1711360512998;
        Mon, 25 Mar 2024 02:55:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001d8f81ecea1sm4430360pln.172.2024.03.25.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:55:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0813818469084; Mon, 25 Mar 2024 16:55:08 +0700 (WIB)
Date: Mon, 25 Mar 2024 16:55:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
Message-ID: <ZgFJ_H2HHwTGFg8Z@archie.me>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VgRQLFnf84aRFWUP"
Content-Disposition: inline
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>


--VgRQLFnf84aRFWUP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 06:22:59PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Tue Mar 26 10:34:31 PM UTC 2024.
> Anything received after that time might be too late.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--VgRQLFnf84aRFWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgFJ9wAKCRD2uYlJVVFO
o5hLAQDTxIxJU4ZwdJI9EJfYJohft0xL6TnU/2LW1jeq6UpBhQEA/Da8+KyolhU9
Q1G0vcUfFJBTbT2e/b/zHZ9mrbjBkQo=
=oyZa
-----END PGP SIGNATURE-----

--VgRQLFnf84aRFWUP--


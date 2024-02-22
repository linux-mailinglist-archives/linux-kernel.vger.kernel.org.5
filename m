Return-Path: <linux-kernel+bounces-75941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E3D85F0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034511F230B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56870F501;
	Thu, 22 Feb 2024 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX55Ekxo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF96AB9;
	Thu, 22 Feb 2024 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580014; cv=none; b=clT0FEEMyHkoguQQ7IDS6qsfXIAy0ERvoR0sla86SzrnUoLD/tBqX6VJ9hqQJutLezQ4FiOPNyb90zl5gYtcXr4eHl7UBfTgaBK33bEC4q8aS/WSWLQDG5D8QqafG8JdrwNa+lHoYCs45SKGFly1BtmDWpe9qpM4UtJS/gagzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580014; c=relaxed/simple;
	bh=SjP09MIy5YrK4sMKfNGCxf0ioGyri+S9EeUXCbe6IgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPLzap7YgeLp3kkmL/0L9f+A5mh7I+HLErehGnPEXeg1JaUHiRBET4JNN+8CVtRvbUCVdbmhNidS+JLlNs0glHfXeAm/wWxQ9CmgW9nbMNNZ1yidXYqkPrqmTsZRDvfakKo//Ek0FVUGGsLDEBmbLjurT/lvQk01tIBnbkowVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX55Ekxo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7881b1843so11509025ad.3;
        Wed, 21 Feb 2024 21:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708580012; x=1709184812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+lHBLhqVXp2YQ4A5zGdD+Duum45+0C9WP1ZVERV5iA=;
        b=jX55Ekxo3naOffJlxlwHZ6ZMjREnztlrw42rDpoXk0xdx32DaSJFm9UFVo0zV18I74
         mJh8Dm/ZtR0CwlGxqYg+esXeU9OXjP4fLPhOYDLYAyvTCUnJWzV3RLsjPpCv7a1pj8sA
         08VqYhrKUGuGJ/ua3B507sy3ZXdk7gpFuNyQKNwdwNc/AMN9Q7lpijaZY4aywZeFjQwF
         KM921SZoL6Q1bN9AKYWgnXyYrjLfz22TzBSmyV9qmM3E3ENUnlpRW5k7cN4IeSUqzmC4
         FKM5e0odhSGLDQdqk0kvNkvTu4ted0Q+EQk83TKNxLfB5BZpVrQ4kv5cirsA0o6pw/EW
         AIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708580012; x=1709184812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+lHBLhqVXp2YQ4A5zGdD+Duum45+0C9WP1ZVERV5iA=;
        b=oOoQTmWCOx3mgpig6akbfah1toI7OGrzXHKpC9uEoGhkPa1jgCsZ5bK9wDQC0gcLW/
         Nm5HTJP6dhNqHIfBWzlHsMa2pHOQtf9jFciP1MNGaw00RpNzaYv5KDq32wMDTB7DXnrR
         d/fOaDhwiqmqbPI5mW5hODXwHD/Ea+3OsztyRZPZxojf3fYWQ6fpTtkL+KBWtNtQakw2
         Oe6AkZiMrOk8eFeMYBCRTNsW0HJhmKYK6OlsAs0s+tl3F2g3sXigtbfheXKJqTmkkQHS
         WAw+JDSb35a5N9YtO49J6LQ7sZ1IBAi2igFZTNOf5OzFtBMU9QttLu1Y8gdY0LsHI5CH
         Kryg==
X-Forwarded-Encrypted: i=1; AJvYcCX+1UcYN/5X08C/DYbTgG8YrAlEls5C4m8qSLnauy95KPvtLjo4mkzird3ArOoYTdlBTd/tlzkofpr6Wt1DybQO68H0AJUHcCZ0ottCvSy+BTJ5sh2clOHk9FLJX5ut236hVD+O
X-Gm-Message-State: AOJu0YxvOzSP7XmJvsE0z8hK6miO0Wkcor/PbxGlBdmzLo+nXElwxbEP
	8/Vg6e7dvK61NhDvXeGhu+vU+yUl1KyXaCznBqMe3eGzwACn5qR7
X-Google-Smtp-Source: AGHT+IGvqYjMRMIOhHwvjPVPpo/zs2OklMM3A/J93Dc3dUWoGR2+XWobHkvolqz2mp8VEWV+kjpTqg==
X-Received: by 2002:a17:902:eec1:b0:1d9:3bb5:2819 with SMTP id h1-20020a170902eec100b001d93bb52819mr15940134plb.34.1708580012496;
        Wed, 21 Feb 2024 21:33:32 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001db67377e8dsm9034917plb.248.2024.02.21.21.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:33:31 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 71003184796FC; Thu, 22 Feb 2024 12:33:29 +0700 (WIB)
Date: Thu, 22 Feb 2024 12:33:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Message-ID: <ZdbcqQYF0cD-uG8H@archie.me>
References: <20240221125951.434262489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kYz+BPLFKsL1ZW2w"
Content-Disposition: inline
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>


--kYz+BPLFKsL1ZW2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 02:01:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--kYz+BPLFKsL1ZW2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdbcpAAKCRD2uYlJVVFO
o68oAQCyGaN9p3WdnCO8ttpfii3cSp0ajf7AZq/wLMAiO+sbWAEApc1c3se98ZTx
dxNmNbEINMT2967mVg+PIstUm+Bruwg=
=Sm9h
-----END PGP SIGNATURE-----

--kYz+BPLFKsL1ZW2w--


Return-Path: <linux-kernel+bounces-150924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70E8AA6C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B791C21945
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5058522E;
	Fri, 19 Apr 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETnQlEf4"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4515A4;
	Fri, 19 Apr 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492001; cv=none; b=jNem/X2rLkw2c9L8VRahdXxogVakoR/IGk9sMpEEBSR9a/ZkgI4UqOIzlDhqmIW0kJ+Jz5NxcKfdCFt8rpFJPrXXa2Ylwk+BkPdlLkVndHKKbmAHULWs46ilDRcFj2QR94o8+cz/Ut+s6KCB4Tqvoyf0h+fXWVFSSeBW6WlGuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492001; c=relaxed/simple;
	bh=U15wHKiXJz+UAewqp3I99CVx19+Elwdt8W0AkboPOnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+nw3CCDH6zm5kogTa50X86U3BcgeM5vY8vvOcvvEvjZ6Yiif6UItLBm4TcSPTr9eO9eopHHPEDCz8FKPIPE7De/BzLf7lgJv8MGgkw1Cv1SSanrWf+6ruCpIHbjhU4uVsTKuvqyEq00yzfmcUg/Aq51eQmf4QvriKHvNhAmJPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETnQlEf4; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ec61aaf01so895651fac.2;
        Thu, 18 Apr 2024 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713491999; x=1714096799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7UsqjLF6p+rOxF77sH0DzgaFyS/y7xOl8bY8Z+x2gc=;
        b=ETnQlEf4bLXYXzfqEMB5RbeKma4chS7SUHZt3QTPvBQcXKWDISBD9+5ty+K1y6OKxR
         plKaYYCqM0OJzPm1uFGOjDVvPEJV76t7fM55I0LawsCah9YNXpRt9ln3ShaL5yMfrteE
         vhqkRExR8jyDIqRqddCBEklGWQU+FNvchcptfiIpW9DTEoldJORmMoCbgd6INJR8Emzq
         Pe6aiOSNAhG4u6QuWz5SJgn06qDtoR/1k8IZ84uiusGccjefCLJTmsAztlfKeCQI4Xtp
         2oVM3FicE78gzU49d8X/Uc5abu7RV22/nZ21W/gYeZ9lQLaplYHOCLxCWAgePkwoEXoj
         zL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713491999; x=1714096799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7UsqjLF6p+rOxF77sH0DzgaFyS/y7xOl8bY8Z+x2gc=;
        b=YDyZ+BXqrG8Hb58FbCFyvJXpzjiBKG8Ve6KurBiWDcrOD9Bqk3SN7tLL85RKkCiLda
         Te7FYMsobIarsrNLp15EEGGsyOcjTQ7N/TN7MLIVcXSIxZbcWwwxdBxKxqGnfMr4aa3d
         pd4BQWrpjVUquC5uNH8HlpkidUVe/5/Fn6aIkMNrAmMP0rTcDtoGkbXfHEqOmADCDPQv
         3FJ7Ftm7iwIhxnBnDM24x3cIVmO3Cui0Me4V31yun0Tccrk27Z+LEjma1sSaH9ubJZ2A
         eKZ0pKZi+cWV59rSfzjEnkMCNnGz9DD5hGzfNuIIYesbdFu6NbC+AK8tz0jDPYSu6EfO
         8cBw==
X-Forwarded-Encrypted: i=1; AJvYcCVOhbnvLO8AuiAqPmdThc7fuEsvom4+5ZOP2e6gzrA4SrjdbeK0+EPPqJJZTcwg0Z3qVdqxiGS1DCF1M7QFgPXLGiDAgwVxdHRp8s4nYuwZCRCR4BZz7mdSTrM3HRvFYhHfxpjFuJf9FHt4COcb4eQpOr6SfieUNrz33LiB6Uk1
X-Gm-Message-State: AOJu0YxqhvTO8OPx1wmpdsr8FO4JDg5oH5P9EvNJ55dUqa9oHq8XjiND
	PjOZXuJekucIjgtu9SodYyy03SGDMfjf1enIQnncfbMvkuusuek2
X-Google-Smtp-Source: AGHT+IGbPA6YguzFp6v14XTnIVRVB02tJsa0tQ23CSuQpqg9QoSXSFrLb5ClChLXM80nH8MWd5UNFQ==
X-Received: by 2002:a05:6870:a18a:b0:221:bd93:2940 with SMTP id a10-20020a056870a18a00b00221bd932940mr856396oaf.27.1713491998593;
        Thu, 18 Apr 2024 18:59:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006ed26aa0ae6sm2164641pfb.54.2024.04.18.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 18:59:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 92CA218462BBF; Fri, 19 Apr 2024 08:59:55 +0700 (WIB)
Date: Fri, 19 Apr 2024 08:59:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v3 03/10] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <ZiHQGzn0lo4W6lez@archie.me>
References: <20240417085347.2836385-1-danieller@nvidia.com>
 <20240417085347.2836385-4-danieller@nvidia.com>
 <ZiCHotDYOfkPrDUt@archie.me>
 <MN2PR12MB45173BA707E5B2669B3DEB52D80E2@MN2PR12MB4517.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BL4X0qERPrez1XZs"
Content-Disposition: inline
In-Reply-To: <MN2PR12MB45173BA707E5B2669B3DEB52D80E2@MN2PR12MB4517.namprd12.prod.outlook.com>


--BL4X0qERPrez1XZs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 07:41:08AM +0000, Danielle Ratson wrote:
> > On Wed, Apr 17, 2024 at 11:53:40AM +0300, Danielle Ratson wrote:
> <snipped>...
> > > +The firmware update process is composed from three logical steps:
> >                           "... consists of ..."
> <snipped>...
> Hi,
>=20
> Since it is the only comment, can i maybe send a fix for that later if ne=
eded, and let this apply?

IMO you can apply the wording suggestion above if you wish.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BL4X0qERPrez1XZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiHQFgAKCRD2uYlJVVFO
oyr9AQC16falnU/ha2FNAAQXDxTaB1K1iY7uL4QgZYu95JHkrAD/c3GQR68NGN42
FiQG/D9aL0z1VJLplWY58k4ynoQkZgw=
=IGRH
-----END PGP SIGNATURE-----

--BL4X0qERPrez1XZs--


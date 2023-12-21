Return-Path: <linux-kernel+bounces-7808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6681AD7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90852835A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEE65249;
	Thu, 21 Dec 2023 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuweDkXY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36B4A19;
	Thu, 21 Dec 2023 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso364095b3a.2;
        Wed, 20 Dec 2023 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129322; x=1703734122; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cwy609ViDO/5NGng780dz2Zp63VE09X7quZEZMkNVo=;
        b=UuweDkXYNG7TvokCgZUI6iiWpO1b/oEc61DvpZ0oYaal5frSWave4akjw9F3vGnVH9
         1ksNr8ECIboUqgEABgfwLXO5edW+MQcIhb5lxSiXE38wZjNE8sojd7yiMFTFhYeCwyFf
         ihs8iWtrtPUrI+gZn6KFpJwZgldlWv7C6Z6ZRSifpIrC1LKct4Hyq6BChk5Og1O3atc9
         y/0YD/M/7mHMdwsvniFPzl5waOjsrNado+foyILZ7SFUmFft7GJFgHT6Smfr/IWNZQSF
         aVWDR00RUNCbzH9Zy/YL8iD9kYPmHfHOXmfUU+wxY2CTmtTgYkcpbbj2EMaQREykEJ7G
         QYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129322; x=1703734122;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cwy609ViDO/5NGng780dz2Zp63VE09X7quZEZMkNVo=;
        b=TnomvDpQklWpxQ/sIXYJrRd2GQEXrcdmSwRwJ8urPIea2GN7QCGLW/bwQ1QDmLE48R
         zJPOu11/S70/5VXkUZBITRfKVOA1kHTr3nJVIZKeuaAbC4aLXU/3H6PhHOZKIhAX3hGO
         PoylbHiXc1xSPnIxcH5P6AlpYVpRJsysp4OgSJ96OP955wKbc6r/b4JdmsGnOlHChUw1
         DmQHi+ZTb6xNfu6Tt4cITbgRh0wjSY9aXXSugN5gSKakYbYhJMjPPV1Tom594UKVgs1n
         fPfJxJhNOO5AW5+pkcJgZojQ3NvL/mqEqILMNQffTZLsrgKv3jx8Ds0pcXMAAn4wBj58
         3RUw==
X-Gm-Message-State: AOJu0Yw+aBU9GfrXfqY4LRD8WCx1+3hR2dC6COBfRDzMAU6wvuRcob9q
	zBwPFRnXOQKffyP3Yu4lFl4=
X-Google-Smtp-Source: AGHT+IH00C6bByvTzePNj6kiL3xYMrwqwS66Re6fu1otTnsCDa97TAOATj8PHde+3hqCHgKc+xTfCw==
X-Received: by 2002:a05:6a21:a59e:b0:195:7f2:d556 with SMTP id gd30-20020a056a21a59e00b0019507f2d556mr175918pzc.76.1703129321812;
        Wed, 20 Dec 2023 19:28:41 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x29-20020a63171d000000b005c60cdb08f0sm537606pgl.0.2023.12.20.19.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:28:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 135E41028B29B; Thu, 21 Dec 2023 10:28:36 +0700 (WIB)
Date: Thu, 21 Dec 2023 10:28:36 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux ALSA Development <alsa-devel@alsa-project.org>,
	patches@opensource.cirrus.com,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Andy Chi <andy.chi@canonical.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Luka Guzenko <l.guzenko@web.de>, Yuchi Yang <yangyuchi66@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	Lucas Tanure <tanure@linux.com>, Fae <faenkhauser@gmail.com>,
	Albert Tseng <tsengalb99@gmail.com>,
	Lukas Voreck <overloader@tutanota.com>
Subject: Fwd: No sound drivers on HP Envy x360 ey0xxx
Message-ID: <ZYOw5OVHGugrEP30@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+dEZltS9BeS27wKC"
Content-Disposition: inline


--+dEZltS9BeS27wKC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm forwarding a Bugzilla report [1], as many developers don't take a look
on Bugzilla. The reporter (Lukas Voreck <overloader@tutanota.com>, Cc'ed)
wrote:

> On an HP Envy x360 ey0xxx (and probably similar devices) there is no soun=
d from
> the internal Speakers whatsoever.
>=20
> Currently I'm using the patch found here
> https://lore.kernel.org/all/20220811053950.11810-1-faenkhauser@gmail.com/=
T/ But
> with newer kernel versions that patch wont work, It will fail to build (t=
ested
> with 6.6.6)
>=20
> This is my first issue here and my first encounter with hardware issues, =
if I
> can provide more Info, please let me know

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218280

--=20
An old man doll... just what I always wanted! - Clara

--+dEZltS9BeS27wKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYOw4AAKCRD2uYlJVVFO
o+30AP9EIaHIVpT2Tk9XjLbrg50ewBz3Z3mvGhVSq6v27g3+HQEA6qlS4qEIndJ2
SDQa7Hq1fx5Hiw8C+z8pJ9doxVysyQo=
=qIw/
-----END PGP SIGNATURE-----

--+dEZltS9BeS27wKC--


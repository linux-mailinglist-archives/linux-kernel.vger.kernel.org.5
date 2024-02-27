Return-Path: <linux-kernel+bounces-82857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32235868AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96BD287233
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69245646D;
	Tue, 27 Feb 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8SwlXJA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21955E68;
	Tue, 27 Feb 2024 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022135; cv=none; b=bF0HEm3eDCYyIS24Wv5xV4w/i4DsJuNkcxb5WmFhznq3Xt3QvZZbnRLCrcB2WDxOMRt9uFVUN5fHs5rXniOewzFUaAtHMZEw7EvkqaPwf8HPIQmQkz9phCg28fqT94HkB/cLxjOQ7KIXRR3XtkhcWhRpsozCXA9bGjwbP9W8GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022135; c=relaxed/simple;
	bh=t8XyXwJueF6HxJmYKGaSm2h/RD9rlpNIcEUyHMTJ/DU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I7PU11HaXhdTRH/TpEUMNKurMMtxMPdmomB2QQhEpzO/H9lgMLBjBPMgIbEY8JKpFkH8W60TOtv/n+B1BzY/o1B7eXHbrszhwW0m0Ht/MrZwq7VmNLqaN0HwblM/ZgKljofhrvqo0wD1P67zuiLNJ6wY0QrWeKIpKjsDAf+hU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8SwlXJA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbd32cff0bso29358145ad.0;
        Tue, 27 Feb 2024 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709022133; x=1709626933; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HI5YfceekB134PHWb0mBfyFs0SgDHAdBofq6LRbVyTI=;
        b=e8SwlXJAjMfyTdrCTbMJ7NcCxNSbz49fni+pb386qsKtw0uV95KLPbIQVuMIAXw4kY
         GmrgAfhA8N7eRgt8Vtyl+v29F/7+3oPQZPMg8KX+AFJ1IWFnHpex6/Ld6x9SLDygHnjF
         /nb08lJR9sFbQGvM1T6A5yo2ORtUU6caTpYo1dznwF+ACnFBPdJx5aZ4PAdjRMaNRB4N
         JTy+58RVDlV6S2MkMDtfprae1KHM3tmeYDsSb6/g9b0NjvlxlM68rGlpTlfTjscYN2nD
         WbEGUeAdXtCWJI0tkr7GujnWOeuShz0ZXKswIS41nOv5qqoTutUNiADt831i5U6MyW6K
         mFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022133; x=1709626933;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI5YfceekB134PHWb0mBfyFs0SgDHAdBofq6LRbVyTI=;
        b=iNe84ZAKu0QRlNEbYo6ZEkOAAcZ80PxyDf2k5r9W6xb0tzh0L3Pt+fs+ST0uxBGDVr
         a/Ykk1mmwzTDIVYInVZvTYuhxD9TSQ9l4wtjOtI5ANywN4tuUrs3rA+HazB9Z3fEHijg
         NwqCAZ4Zc2tRjgGIKpQZKH6Rcsf8VYoFqtMh+e2TlFQBENDoCDMMYVziB+AUeb9/gQdU
         MsUuxH0+mdKMVqCiixhS1w4jhZcmrzCLRaMh8l59BeJANJDy29nj/QemS1STnpjrG8bo
         zjLft219gD/1brRKHNiIsQB8VjBN0Uri0qxg4NeR0kNuCxuZ/gnRjfEYSbT+1CvS4ZBj
         aNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgTQdkaZrsMH3MjRfq0PC5j6JQqL259S9aQrWFEVO7GYxKkNfRxHUNVzPIo0NNbVvffE8Kwj4xdFWct3FX3PwprJevlBsqcjJVToytf1RQzpKdxHmmwZbbc7W3L8LTjk32w0egpMHL2IsgaA==
X-Gm-Message-State: AOJu0YyCxoC8LGOKfw0EZEE8OryuX+B/Ycd+xlG4buoYzvxkQMYgjvvU
	qXJIWedeeSs32wjc4CxAOAVGdUvCnPkhzU9A391tHWeCEwCvoIrH
X-Google-Smtp-Source: AGHT+IGDA09K8zrsriDSFT8spOeGYcIHZEHFUGp2L17AIuv+iVn/gIpntlin4+FCyzYHZVImkWLF0g==
X-Received: by 2002:a17:902:8644:b0:1db:5ee2:a772 with SMTP id y4-20020a170902864400b001db5ee2a772mr8267708plt.11.1709022133042;
        Tue, 27 Feb 2024 00:22:13 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id lo7-20020a170903434700b001db5fc51d71sm952788plb.160.2024.02.27.00.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:22:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2732D184CED9D; Tue, 27 Feb 2024 15:22:09 +0700 (WIB)
Date: Tue, 27 Feb 2024 15:22:09 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux x86 Platform Drivers <platform-driver-x86@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Stable <stable@vger.kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>, danilrybakov249@gmail.com
Subject: Fwd: Continuous ACPI errors resulting in high CPU usage by journald
Message-ID: <Zd2bsV8VsFJMlbFW@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pgDDeVc61kq9FJT+"
Content-Disposition: inline


--pgDDeVc61kq9FJT+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Bugzilla, danilrybakov249@gmail.com reported stable-specific, ACPI error
regression that led into high CPU temperature [1]. He wrote:

> Overview:
>=20
> After updating from lts v6.6.14-2 to lts v6.6.17-1 noticed high CPU tempe=
rature and lag. After running htop noticed that journald was using 30-60% o=
f CPU. Afterwards, tried switching to stable, or lts v6.6.18-1, but encount=
ered the same issue.
>=20
> Running journalctl -f gives these lines over and over again:
>=20
> Feb 19 21:09:12 danirybe kernel: ACPI Error: Could not disable RealTimeCl=
ock events (20230628/evxfevnt-243)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for GPE=
 08, disabling event (20230628/evgpe-839)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for GPE=
 0A, disabling event (20230628/evgpe-839)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No handler or method for GPE=
 0B, disabling event (20230628/evgpe-839)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for fix=
ed event - PM_Timer (0), disabling (20230628/evevent-255)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for fix=
ed event - PowerButton (2), disabling (20230628/evevent-255)
> Feb 19 21:09:12 danirybe kernel: ACPI Error: No installed handler for fix=
ed event - SleepButton (3), disabling (20230628/evevent-255)
>=20
> My system info:
>=20
> Laptop model: ASUS VivoBook D540NV-GQ065T
> OS: Arch Linux x86_64
> Kernel: 6.6.14-2-lts
> WM: sway
> CPU: Intel Pentium N420 (4) @ 2.500GHz
> GPU1: Intel Apollo Lake [HD Graphics 505]
> GPU2: NVIDIA GeForce 920MX
>=20
> I've pinned down the commit after which the problem occurs:
>=20
> 847e1eb30e269a094da046c08273abe3f3361cf2 is the first bad commit
> commit 847e1eb30e269a094da046c08273abe3f3361cf2
> Author: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Date:   Mon Jan 8 15:20:58 2024 +0900
>=20
>     platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
>    =20
>     commit 5913320eb0b3ec88158cfcb0fa5e996bf4ef681b upstream.
>=20
> <snipped>...

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218531

--=20
An old man doll... just what I always wanted! - Clara

--pgDDeVc61kq9FJT+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZd2brQAKCRD2uYlJVVFO
owXDAQDniDPvwOEXBwUgqdr22mZnIQ+QPQ2O2jmn/xMKKlPADQD+LvJ6iqLHXsP0
Co46z6CIKqlwUj55oTqUrYdKKCkqlgs=
=7XYF
-----END PGP SIGNATURE-----

--pgDDeVc61kq9FJT+--


Return-Path: <linux-kernel+bounces-112432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070C8879BA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EBA1C20C54
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475A54675;
	Sat, 23 Mar 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="q8pqdray"
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52A53368;
	Sat, 23 Mar 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214640; cv=none; b=F7kiMwhDP9gp/XFbbNDIEAc+vx6z39UEskZvHciV4G1DwNxz/+XzKWWp3lSqOPC0VbAxXd2doHSQKkfvSoH1zIPG++Ik0Vvsse2yRpZGEUOnDoAcbZxitqx4dnPoOUNc2M0ix5UwdDoQPGJW+e3ZShWhigykddTwKIce2H0M9/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214640; c=relaxed/simple;
	bh=hLd9g0J+arhug+21RAMsKmSEAuU65lTeZKlInmYv/o0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlfN1Ffp/Q6Q5aOTEeKuYXoFB2m+Yic1Z5O2VZCynNu/8Fj4RyWGLmz60z+MNQ8rwrxjex8Mt7DmcVPUmTPylQ9zUQMYmHS2p1bjCSsDLqy/ccG0wBBWeyxOPgA3cjCd5bHOeLj9hVGnWWpIEpbcuK9H6uEuRz3veXJDd08fg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=q8pqdray; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1711214635; x=1711473835;
	bh=hLd9g0J+arhug+21RAMsKmSEAuU65lTeZKlInmYv/o0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=q8pqdrayecYfqrEuANc8LK9O5kKn9h5cphBj9UumlvrDAVHKSrVxzDyJE2t5F9b5U
	 Aoe807R7CUJOlv+pR641GkAk/wGuHw7meGMLJ8NaMEhV4Ioy9ZqOMXRlCmENkIR4kx
	 wQ1PREruEKOtR/cuJpiK3T1YjVqs2XTlJsp1Zb4yaHWnxK8G7ef9ZhOsDYPDevV0YN
	 eCAPYjydSRmeXZQHdKCl14AACNpfJQ2z2bvbscO93RsszIIHZyE/VbP7x64/fisf5B
	 bL5eQRQCWVvObycGUmNrwGekIkkQ2xdxsv6RCs2dgNNj2tbqOMFYmotGoFOZ2M2KTe
	 8+NbVT+9gnO9A==
Date: Sat, 23 Mar 2024 17:23:38 +0000
To: Linux regressions mailing list <regressions@lists.linux.dev>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>, "saravanak@google.com" <saravanak@google.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Fixing the devicetree of Rock 5 Model B (and possibly others)
Message-ID: <28S1EMw5YOnQIBpQ8_qaZZ6c9Go-j6-lLuWWbRpe6-MtRUd7Ay-uXq8JHbVVtJv3LzpxjI8jYg7ukNntbN22PVV-hOWbuTY8FNWgvM4zSwI=@thefossguy.com>
In-Reply-To: <092a7c4c-0a75-4b27-acec-385fdcfb9f7a@leemhuis.info>
References: <tQ0L3-34g4t-mzfQIP6KDe5OYelGnEo6Udzq6Kb_nEcljppSQUXOktpE__nL-CdLOu9gW-4tIIbjtSbqrdCrjEkdhZLPiiHTqRcCB6WORuM=@thefossguy.com> <092a7c4c-0a75-4b27-acec-385fdcfb9f7a@leemhuis.info>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------f1e788887cf9d788045acc7ae71ae8322eea6a98cb58be5654c24d039bf47d68"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f1e788887cf9d788045acc7ae71ae8322eea6a98cb58be5654c24d039bf47d68
Content-Type: multipart/mixed;boundary=---------------------ae8a0b7b1b36c345004b08b7de4976a5

-----------------------ae8a0b7b1b36c345004b08b7de4976a5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Saturday, March 23rd, 2024 at 22:47, Linux regression tracking (Thorste=
n Leemhuis) <regressions@leemhuis.info> wrote:

> =


> =


> On 23.03.24 18:02, Pratham Patel wrote:
> =


> > Since the introduction of the `of: property: fw_devlink: Fix stupid bu=
g in remote-endpoint parsing` patch,
> =


> =


> There is an earlier bug report asking for a revert of that patch:
> =


> https://lore.kernel.org/all/ZfvN5jDrftG-YRG4@titan/
> =


> > an issue
> =


> =


> Is your problem maybe similar to the one above?

I don't get that exact message in the boot log but yes.

> Ciao, Thorsten

 -- Pratham Patel
-----------------------ae8a0b7b1b36c345004b08b7de4976a5
Content-Type: application/pgp-keys; filename="publickey - prathampatel@thefossguy.com - 0xF2DDE54D.asc"; name="publickey - prathampatel@thefossguy.com - 0xF2DDE54D.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - prathampatel@thefossguy.com - 0xF2DDE54D.asc"; name="publickey - prathampatel@thefossguy.com - 0xF2DDE54D.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWmZjR2RSWUpLd1lCQkFI
YVJ3OEJBUWRBa2VYM3NrdFI1R0lZQTM5VXhoRTlZcitZMy8zd0ZXUmwKZlZ5T1hsaWdnS2ZOT1hC
eVlYUm9ZVzF3WVhSbGJFQjBhR1ZtYjNOelozVjVMbU52YlNBOGNISmhkR2hoCmJYQmhkR1ZzUUhS
b1pXWnZjM05uZFhrdVkyOXRQc0tNQkJBV0NnQStCWUpsOXdaMUJBc0pCd2dKa01lcApYbTlkS2Er
V0F4VUlDZ1FXQUFJQkFoa0JBcHNEQWg0QkZpRUU4dDNsVFJRTDQ4NE9oNDE3eDZsZWIxMHAKcjVZ
QUFDYlFBUDlMc1NwUlQwSTV2TC8ycHpBa2F2UVhLdStWR1BRMk44RUVYZGpSVkRseGl3RUFwMVpS
ClB0M2k5RG9qcXg1OE9MQ2R3N2xHMlVwdkJGZ2dCeGVrV216d1dRbk9PQVJsOXdaMUVnb3JCZ0VF
QVpkVgpBUVVCQVFkQXJlOWp5aVR3VFBGSjNaazJvTVd0ZDVxSi9zcWNKRUZrckZxNUpVVzRWalVE
QVFnSHduZ0UKR0JZS0FDb0ZnbVgzQm5VSmtNZXBYbTlkS2ErV0Fwc01GaUVFOHQzbFRSUUw0ODRP
aDQxN3g2bGViMTBwCnI1WUFBRFRGQVA5WUZIL0FxKzVFd3pHQ0xJZWhNNGJsUW5hK2t0cnNPRWlw
VllVTVZMd0tjQUQvVktHQwo0eFRtTENUQUNDcFNqRjdVRzBVY2NNOVU0T21ZV2RlVU9HUk1hd1k9
Cj01cTBtCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
-----------------------ae8a0b7b1b36c345004b08b7de4976a5--

--------f1e788887cf9d788045acc7ae71ae8322eea6a98cb58be5654c24d039bf47d68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmX/D/UJkMepXm9dKa+WFiEE8t3lTRQL484Oh417x6leb10p
r5YAAHYlAP9lfb3BSFKYtWm/S0bfoj6e7K4Y+l8y9pnmg7U4pWoPkQEAjxWI
9LvXFmeUGLD2Z2Lu+WoJ7RU/hCOljmBRtQHtEgU=
=V9PA
-----END PGP SIGNATURE-----


--------f1e788887cf9d788045acc7ae71ae8322eea6a98cb58be5654c24d039bf47d68--



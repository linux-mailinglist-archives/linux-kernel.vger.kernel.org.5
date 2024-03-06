Return-Path: <linux-kernel+bounces-93957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1B87377D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4991F216E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17167131735;
	Wed,  6 Mar 2024 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVMvs5C1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82612C52C;
	Wed,  6 Mar 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730747; cv=none; b=Qnv3Hm6HKtMkxcNi//Ta9b/aI9jVefffGXGDmG3DCvyOTSwQnNGA4STZq2322IUyJ/UH0wGSVcm0Jh4C1IFJ227BC0aPpINpFHt0dycKBHYi8eeR7i9HYo7+gjBEpCVsVxUQWwLiz1EjuRqhq1GbRONvBMa0LnMsWsMnrhYcm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730747; c=relaxed/simple;
	bh=znAyfDfvPiSviTV5pIub082WYjH2lOSzE/FbF134A/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea0/44K6fXLSdmKa3B1CtuEo7ePicgwkC2qE5RFVW+tboTmSrbUJ1RaUKZZUyOV0vfcajIcEf3D5f/gl//V46Jtr54AZmvlYxO5NKwBA3yz6Q2iWzTn2Bs7VPqkUw+BB0KuEKDrdtGf/Ns6c9b3YES/84q/bTF+W7wdaKNgZSJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVMvs5C1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0959AC433C7;
	Wed,  6 Mar 2024 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730746;
	bh=znAyfDfvPiSviTV5pIub082WYjH2lOSzE/FbF134A/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVMvs5C1r6AHhJG0OMp/scMB7a3gfIlKXUGEzYyQSL0onk3LqodbHIAoliGJAI12U
	 yA5WDwHxgOX9v3wMlpNK37wfr01qfw0ymE9WvUVzjKlI4GdXX76gebXupkrs1nYslU
	 wTgLCcUYOLZIDP3sIDpjNTL6Q+NcHKOVjb8BJpa0aJqvOs42IBrrw0HdysE0kpEH/K
	 7UKNl0NdDTm6W6euovVNrxXyInMY2NFx7FOQylFsX0XQVzDWS/HSTgLME93VnZyxrT
	 Jc5vTAX645NO/I8e0qIzAXXlO6hVo5YFFo7AwVoxbGMhdsft36pIYZlvYYCK4DstQ1
	 +4YI2cXXMrbYg==
Date: Wed, 6 Mar 2024 14:12:23 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
Message-ID: <ZehrtwSDQV-X7BXV@debian>
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian>
 <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
 <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naiMyB7E1A9ldgjP"
Content-Disposition: inline
In-Reply-To: <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>


--naiMyB7E1A9ldgjP
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 6 Mar 2024 14:12:23 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options

On Wed, Mar 06, 2024 at 08:02:10AM -0500, Oliver Crumrine wrote:
> Hi Alex,

Hi Oliver,

> Type into netcat, not the program I sent.
> My program is the server and prints out whatever it recieves,
> along with some other stuff that lets you know which options
> are supported.

Nothing either.

$ date; nc localhost 8888 -u | ts
Wed Mar  6 14:09:38 CET 2024
foo
$ echo $?
0


$ cc testDgramSocketServer.c=20
$ date; ./a.out | ts
Wed Mar  6 14:09:05 CET 2024
^C
$


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--naiMyB7E1A9ldgjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXoa7cACgkQnowa+77/
2zKoXg/7BBATtPrwKlIT8X1yCNo4xxJpc2tN3XxJkGWpvuA3dtJzYNn4oJjZ+zZ4
KnxkZbcAgxGiHxHF32viqu//xbSur+7+ECnhn55mrmGnAzg72SYsjlHe7FxDrisp
GcxncrYURVIeZJsnuJYeTXW7qdrAoiudbllSsMClT+Xrf2nHoERD7lhgWGl7u29k
TtzemTrmHGB5A/5S1E8Lr7dNpHnBMLDQ2kJFB6b61P14d195miflYx2jeQ72FRoq
flfqGJRkQnFJHxQg8APti0ui/NznzyqHlYVVtIlycaT1MqrZYBz3Vd17BwRciQLb
B+jiksHuSEdVAHMnv12dzGVf/mDg7raZ6u1V72Zo3ReoNCB6n5y+eg7kzcLwKwkq
L/vaF8M6maXCCNxGkSOIcgZANkA0x4tLYWdIRa1sErE8xWEzcyRk3Bln/k6D2zzO
RBcIvaxqeAmj0y+0FNqDDIDJ9aM4JVjlDZmAFx1aMdD4sJTWJ8JHWFapzKENbAs4
sNiCUqnN0aAZdF1lN3Epxb+YMOshxreJp9h+aaxuJ6bMckh1sy5vvG3vK28D8Q4H
Q8xDeohjHhgi0SgChrPFNjdIUWBjZTCpS+QG3zvXd5phLGtIkRanHqHm4GoAwRqe
4JqO60btSrRIySoND/99INv2BfhjS1PMYIQysiTHb0Aa2UVimbc=
=PSrm
-----END PGP SIGNATURE-----

--naiMyB7E1A9ldgjP--


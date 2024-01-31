Return-Path: <linux-kernel+bounces-45938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B33843815
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D2D1F25831
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A658207;
	Wed, 31 Jan 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRfNtHzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902058108;
	Wed, 31 Jan 2024 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686963; cv=none; b=ocp3bTR9zdoNo56Mt5lS84+Kp923C7/abx5nOyoA+dNws+nBcPkiBseVZwLWJF+orNQU/g7D0oq0oNrJr+rvtpzfiORIvNdds0ujjTnpjN46+OgaapwvZX0zIaFbFfCiwumoXy6CgQWDZjFTLShfsAmxuwC8SYoI6rb+D08Pq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686963; c=relaxed/simple;
	bh=Wbcp7koPRxXu2bkDffYsNjnA80y7HrspVM0b9HnQegc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ+3o1wkqYlHM0/AphFzDdtT57ClzaOLXqkVpEUoMp47kb6Mg2hdsv3o349wHJvG8YAELnCihSwbjpwlP01Bl/xuqExLYsXgnctIx9aXuMCY3ZbZ1lT0/cu/MUFMeTBEiBM/Sd6l7a5674g7Cylvww0QVtO0IQMRLbbyOO7pBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRfNtHzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9478DC433C7;
	Wed, 31 Jan 2024 07:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706686962;
	bh=Wbcp7koPRxXu2bkDffYsNjnA80y7HrspVM0b9HnQegc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRfNtHzN3ON+SLCKG/4tTFQFvso/AwPY2mwZcsKaAvDdkPlFoaJl7lE400e2thxov
	 RmJdjCVPpaanot8lrhVBJ2yj0imiUVaM6/j1qJpFNm8g9Y9mnDmD+lnpHjvJOO4U7O
	 payx3qb7fX2YyBK1zzCA0U513Ovt25G+kOBp2zbZrj5mFIghQCeTN9lkBeayPMjXIL
	 0mkrPgg+FlyRu1tX+O037HVU438yPUtRDOzK/71jcxqdyat2PjYzUUZInKoZqB2giI
	 EEh/wH8vEvA3HxmciwF2cLR+/0qoFkavOxeTkCqt40os6/WnBwgYnZRtrcTKo7JhTw
	 J8ebG8JxKOnWQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rV5F3-0000000041E-0Ybb;
	Wed, 31 Jan 2024 08:42:41 +0100
Date: Wed, 31 Jan 2024 08:42:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pci-current tree
Message-ID: <Zbn58XcoOXauLUjN@hovoldconsulting.com>
References: <20240131125843.29e54460@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GjSVFlK1+j0Pd+dz"
Content-Disposition: inline
In-Reply-To: <20240131125843.29e54460@canb.auug.org.au>


--GjSVFlK1+j0Pd+dz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:58:43PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the pci-current tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> drivers/pci/bus.c:440: warning: Function parameter or struct member 'top'=
 not described in 'pci_walk_bus'
> drivers/pci/bus.c:440: warning: Function parameter or struct member 'cb' =
not described in 'pci_walk_bus'
> drivers/pci/bus.c:440: warning: Function parameter or struct member 'user=
data' not described in 'pci_walk_bus'
>=20
> Introduced by commit
>=20
>   69fb843fdbd9 ("PCI/ASPM: Fix deadlock when enabling ASPM")

Bah, I added a newline after the opening /** when moving a comment
without noticing that the kernel doc comment was malformed.

Bjorn, you could either remove that newline or squash the below patch
address this.

Johan


diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 116415f91195..826b5016a101 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -425,9 +425,9 @@ static void __pci_walk_bus(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void
=20
 /**
  *  pci_walk_bus - walk devices on/under bus, calling callback.
- *  @top      bus whose devices should be walked
- *  @cb       callback to be called for each device found
- *  @userdata arbitrary pointer to be passed to callback.
+ *  @top: bus whose devices should be walked
+ *  @cb: callback to be called for each device found
+ *  @userdata: arbitrary pointer to be passed to callback
  *
  *  Walk the given bus, including any bridged devices
  *  on buses under this bus.  Call the provided callback

--GjSVFlK1+j0Pd+dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZbn57AAKCRALxc3C7H1l
CPpAAQC4RNRa7mhHKoWOZh7t9zxoRLj/MyUUw9Ekqb21tHB4UwEA1DpbLPPMAXVC
xiWFBkDiW7pBKBbBrlltq1Ca8/5OwAw=
=6Txi
-----END PGP SIGNATURE-----

--GjSVFlK1+j0Pd+dz--


Return-Path: <linux-kernel+bounces-124247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E00891458
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BDF1C23449
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC142064;
	Fri, 29 Mar 2024 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yZ2NEKlu"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C441233;
	Fri, 29 Mar 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697348; cv=none; b=e4Jj11/YqQYFQ/L6YBQdOge29fpDoE3ig9qDGavTkThBkaPtLcCUHiT3LENirpJ1oIESzF3trKvE0hmOn3nQmsrGtIy88FK+fDAABNcgPYgygDC3jYB06ProhJrwFQVV2b14PHmwbCdPh+jN3R2FNeSqf9xDSk6cEQoWHzfZxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697348; c=relaxed/simple;
	bh=1cmDBy8dYrXEta4fjcrphoU72ogCv98mdd+8+tvN7TU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqWcDbk84PCxf9aqzHuIHbW8tNeuEaRP7F1tJby5RxDxG9+3RApq6HwfO8cReav3BLugB+Qxwb2ys0LmwiVDHb/uVJWMMo33tg/qtdecUVdRRZQI9AaQOErI2+fq5QDxDdUB5ULKGWweij2/fG7tSEB13CM6z/TFiFZ6MIR9wD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yZ2NEKlu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711697346; x=1743233346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1cmDBy8dYrXEta4fjcrphoU72ogCv98mdd+8+tvN7TU=;
  b=yZ2NEKlu7UJfrtHOePY42sQoTVZ9srk/ol8WSAjGE+TCHxRIjp0Faamv
   KI1y7EYkFTIwa7PWLr65G0ZaDO1W1ghM9aYCxcr3meFUOQ1SD9BwHZX0B
   AkFCpU8etOPF2AoWTKeeE6JahbLwRTqlxVKxSZlSmuA154MVqVMcXkc8G
   pomqP3xuITEtL9o45ZsBSU3qX6R+rW8a8EdmOJfiye9TcgtqSC1XVk9ub
   uSch6BBbEYyEY1q3NFZKNLK4mQegmWT3UKOmb7c55VBwMjLzjuy7pLrC6
   rHI4yXl6oOzZv1zqLXxu/cJmLABUM0Ndouzke8W6fd3MAk3e+ghjop7Uy
   A==;
X-CSE-ConnectionGUID: dIC902tiRuyKClhJh9dfVQ==
X-CSE-MsgGUID: GdK04AE1QKylRlLI485iMw==
X-IronPort-AV: E=Sophos;i="6.07,164,1708412400"; 
   d="asc'?scan'208";a="185882733"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2024 00:29:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 00:28:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 29 Mar 2024 00:28:45 -0700
Date: Fri, 29 Mar 2024 07:27:57 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Conor Dooley <conor@kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing
	<kernel@esmil.dk>, Samuel Holland <samuel.holland@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, Andy Chiu <andy.chiu@sifive.com>, Jakub
 Kicinski <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: RISC-V for-next/fixes (cont'd from PW sync)
Message-ID: <20240329-fanning-woven-7dbb6cfdde9b@wendy>
References: <87ttkro3b5.fsf@all.your.base.are.belong.to.us>
 <20240327-irrigate-unread-d9de28174437@spud>
 <CAHVXubgMTe83sYaNO+SG=90=k5scaQrpApveTCO163MhUc1tdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y/2CbQmcronQVXbs"
Content-Disposition: inline
In-Reply-To: <CAHVXubgMTe83sYaNO+SG=90=k5scaQrpApveTCO163MhUc1tdA@mail.gmail.com>

--Y/2CbQmcronQVXbs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 07:46:38AM +0100, Alexandre Ghiti wrote:
> On Wed, Mar 27, 2024 at 9:32=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Mar 27, 2024 at 08:57:50PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > > Hi,
> > >
> > > I figured I'd put some words on the "how to update the RISC-V
> > > for-next/fixes branches [1]" that came up on the patchwork call today.
> > >
> > > In RISC-V land, the for-next branch is used for features, and typical=
ly
> > > sent as a couple of PRs to Linus when the merge window is open. The
> > > fixes branch is sent as PR(s) between the RCs of a release.
> > >
> > > Today, the baseline for for-next/fixes is the CURRENT_RELEASE-rc1, and
> > > features/fixes are based on that.
> > >
> > > This has IMO a couple of issues:
> > >
> > > 1. fixes is missing the non-RISC-V fixes from releases later than
> > >    -rc1, which makes it harder for contributors.
>=20
> The syzbot report [1] requires fixes in mm [2], if we don't update
> fixes on top of the latest -rcX, we'll keep hitting this bug, so
> rebasing -fixes on top of the latest -rcX is necessary to me.

No non-ff rebasing of branches unless its 101% required, please. This
seems like a justifiable reason to merge the rc it appears in into the
riscv branches though.

> [1] https://lore.kernel.org/linux-riscv/00000000000070a2660614b83885@goog=
le.com/T/#t
> [2] https://lore.kernel.org/all/20240326063036.6242-1-osalvador@suse.de/

--Y/2CbQmcronQVXbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgZtfQAKCRB4tDGHoIJi
0tiOAP4xrV2ls9KTOiepY1R3DQ4qiVounWXxYFc7g1IeQp60DQEA4pgF02ZVfCYK
LekKEkPD/qHka7u0tB7awW+UGsTp0gs=
=wq1B
-----END PGP SIGNATURE-----

--Y/2CbQmcronQVXbs--


Return-Path: <linux-kernel+bounces-86873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51786CC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0C02865BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55413777D;
	Thu, 29 Feb 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="o+9pjhFN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5C137768;
	Thu, 29 Feb 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218214; cv=none; b=aOTHeofMMsS/cvcceK+FIwWOWJCF07ghcirhonKa5me4CZILQ72WJr3v4j9TcsuVSs5IrguL9Jtkf+PZUbi/scitHu6ND+WPrLm1lKj578CaBwQ5fSRDHtw0OLeKNZE7SOup0TlRNu2TtQI7ZsKYwDbjZeyC70BrI5TXUwcULQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218214; c=relaxed/simple;
	bh=TOTjG3XFCu+SOCsoJWQ+YdswTrZJGHoVHpqHXU1UTDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTleNRhZpAcizv1LD27skUPKpYjVhgb9JWXU6X3TTlNkclkwmT0khVbgfQmKu+R/Q+/gS9hJmFO7Ax+zYLKSSCeKDxr2FGhmtiB8cOfTFBF9yzX20/ZQdRHzmisLfOiPIihsTzCalUsrSrxaj1a1UiTSQn++vynaCDJgDvEt5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=o+9pjhFN; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709218211; x=1740754211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywrhZUKaJjcwpmTB5QYutRLtgp1qQnXwV/7znwi7QCg=;
  b=o+9pjhFNznvq8PmgIQJRwnr2a9RoPaLXdGEWR9ygWMTTrYLmJgOZP1Is
   +eCfOFEGYPMoPYxSr+YqHh+RCD+dve2hRx9OFQVBT9506zW+0q4eGYdOL
   LBICRjkB/85DWZMsuxn7YNEEzHW0E0hxWS2pLWAdDmHZjgX5EriGV0TBn
   3O/cIZKtJc8uereRiwO/hp4v/pCzAtsiwnrsm1M2gk3x79ZaW8vb9Pjzm
   jSm0htccKjXWYlv/PyCqQhGAPaC5pbU/oXVDivnBFXPsjStZhLEDO6RXc
   nqQLm2CMSzinUB+vmcfeAVMwUR59IGTZgRo7DqErvfw9wKEbjMCMlrpbp
   w==;
X-IronPort-AV: E=Sophos;i="6.06,194,1705359600"; 
   d="scan'208";a="35668392"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Feb 2024 15:50:05 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B61DA280071;
	Thu, 29 Feb 2024 15:50:05 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, Lee Jones <lee@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file patterns in TQ SYSTEMS BOARD & DRIVER SUPPORT
Date: Thu, 29 Feb 2024 15:50:04 +0100
Message-ID: <7803640.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231123113245.23542-1-lukas.bulwahn@gmail.com>
References: <20231123113245.23542-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hello,

Am Donnerstag, 23. November 2023, 12:32:45 CET schrieb Lukas Bulwahn:
> Commit 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees
> and drivers") adds some file patterns for files in arch/arm/boot/dts/, but
> those patterns do not match any files in the repository. Hence,
> ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about broken
> references. The files of interest are actually in the directory
> arch/arm/boot/dts/nxp/imx/.
>=20
> Adjust the file patterns to match the intended files.
>=20
> Fixes: 77da3f22b3d5 ("MAINTAINERS: Add entry for TQ-Systems device trees =
and drivers")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

any feedback? Can this be merged?

Thanks,
Alexander

> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df7a57ac864e..1e439b08d5d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22084,9 +22084,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
>  L:	linux@ew.tq-group.com
>  S:	Supported
>  W:	https://www.tq-group.com/en/products/tq-embedded/
> -F:	arch/arm/boot/dts/imx*mba*.dts*
> -F:	arch/arm/boot/dts/imx*tqma*.dts*
> -F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
>  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




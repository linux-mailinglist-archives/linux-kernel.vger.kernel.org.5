Return-Path: <linux-kernel+bounces-83096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02371868E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CE1F231DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8313956A;
	Tue, 27 Feb 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aSOu/gAU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BCC1386B9;
	Tue, 27 Feb 2024 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032083; cv=none; b=s8Pb6eQOssUad9OqwZBYl0h+9HPY+1VYvVIHrzRCydBBZo1yKOZZ+eS+8oqd60xMnxZMcC30hqx0hWu68gVez4rIsLwEhksQ68bDanRBaXlNnwyqb62/4rs/gfM8fL+h127kJyTIE5lBDA6bo0T+J9AcgeFAvboaS7A7ND69/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032083; c=relaxed/simple;
	bh=91zHcn3MJxhMJjDwzdIUiuB3M2CKCuchs9SG2CkeaW8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzso4UM252QBjrPuoK9rzd4gSW+iJBYNhTwnyrnUPdwrOOEAzzKknHmmyTaBFWdcl20xOAMzXoHY1banCgeW8E/UpdlgsjRzuUPHvHyfOO53sFOqMazPigO6H0NZOzw3zT+W4cumKAtMu2jF3poXdNQoun4xZU0CPoFz7L5+4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aSOu/gAU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709032081; x=1740568081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91zHcn3MJxhMJjDwzdIUiuB3M2CKCuchs9SG2CkeaW8=;
  b=aSOu/gAU5Ra83maQjMsOhJ7PqR3PgFutLGdKf2J7bUrWCh0j4PkDOLaH
   /wUz2la/dKPxCj520aXmrIZVX6mfY1NQP5VgmtUrqZ/RrqnOjNzSzMFBK
   V07Z1xH3JEwFQs8plnVTI+jjmNgzo755jb3krej79SRPzv/qyWF53tfwb
   xz9dLPumiR/iz0haPx0RTVFVvA5+US4SrguKok/oRYu/5Npl0oLgzfwyb
   sDfO7q4LvGr6mT+r1CU8wCW5XOMb8hsW5keFluGEUeN7GspUCz9bTwZY3
   Gu42bX1OXG9ffkEsdRDiHhsUfAJy24BHQCtfBmU2ZASgRYsFtEqKyRtvH
   g==;
X-CSE-ConnectionGUID: ISOzzPUQSGWIbJkVIBtfBA==
X-CSE-MsgGUID: eG+1hg29Rg+lI88KmeakeQ==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; 
   d="asc'?scan'208";a="184154380"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 04:08:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 04:08:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 04:07:58 -0700
Date: Tue, 27 Feb 2024 11:07:15 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: <linux-riscv@lists.infradead.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	<linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
Message-ID: <20240227-lifting-durable-484a2f1ddedc@wendy>
References: <tencent_61DFA8E0B13696A3256E538C4BC856633406@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k8Kp3dpRM3Rjn4tM"
Content-Disposition: inline
In-Reply-To: <tencent_61DFA8E0B13696A3256E538C4BC856633406@qq.com>

--k8Kp3dpRM3Rjn4tM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 04:05:07AM +0800, Yangyu Chen wrote:
> The BUILTIN_DTB_SOURCE is only configured for K210 before. Since
> SOC_BUILTIN_DTB_DECLARE is removed at commit d5805af9fe9f ("riscv: Fix
> builtin DTB handling") from patch [1], the kernel cannot choose one of the
> dtbs from then on and always take the first one dtb to use. Then, another
> commit 0ddd7eaffa64 ("riscv: Fix BUILTIN_DTB for sifive and microchip soc=
")
> from patch [2] supports BUILTIN_DTB_SOURCE for other SoCs. However, this
> feature will only work if the Kconfig we use links the dtb we expected in
> the first place as mentioned in the thread [3]. Thus, a config
> BUILTIN_DTB_SOURCE is needed for all SoCs to choose one dtb to use.
>=20
> For some considerations, this patch also removes default y if XIP_KERNEL
> for BUILTIN_DTB, as this requires setting a proper dtb to use on the
> BUILTIN_DTB_SOURCE, else the kernel with XIP but does not set
> BUILTIN_DTB_SOURCE or unselect BUILTIN_DTB will not boot.
>=20
> Also, this patch removes the default dtb string for k210 from Kconfig to
> nommu_k210_defconfig and nommu_k210_sdcard_defconfig to avoid complex
> Kconfig settings for other SoCs in the future.
>=20

> Changes since v1:
> - remove default y for BULTIN_DTB in any cases
> - remove default DTB_SOURCE for k210 and moved to its defconfig file
> - remove building dtb object file for other SoCs
> - reword help message to say N if unsure for BUILTIN_DTB_SOURCE
> - reword commit message
> - v1: https://lore.kernel.org/linux-riscv/tencent_AB625442CC1BCFF86E04D7B=
5891C43719109@qq.com/

This section here (the changelog) should be below the --- line so that
it does not get into the commit history.

Otherwise
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--k8Kp3dpRM3Rjn4tM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd3CYwAKCRB4tDGHoIJi
0nqDAP9ZSWhGK0NbSy2naaZGv5BXsi+RLfI7+rTaQogrTDN45QD9F4Dn8U8zNXOG
7jz12a3xzz+19gUbN2sU+O8G2vwdoQ8=
=7IVR
-----END PGP SIGNATURE-----

--k8Kp3dpRM3Rjn4tM--


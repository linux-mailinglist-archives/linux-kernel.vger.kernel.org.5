Return-Path: <linux-kernel+bounces-78329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46F8611F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BB1282482
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D625F7CF2E;
	Fri, 23 Feb 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RBRfgEUu"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30873F0A;
	Fri, 23 Feb 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692706; cv=none; b=B/8UcA8myFjmYH5Bewgnpa3I81YhM/SpdjEGKvSIk95Xon8Aqk4f42YqPyGeQWKh0oGNF7k8KrQASh/4yRpPTCxs/RBca9ExGRGdOSJ/QNKnwsxg1knIu9lU3wxdEhS/V4Ap1Lmzrwr7DT39LwgT6IgZvXZnA/U0IFKfBH5lzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692706; c=relaxed/simple;
	bh=WLDHP3Pmi6fiyPlExmfFMkvWm7uWSWkNRrejelK8FGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8kKgE+H8Iij+cY3w5C9hdA46+O3OcTaGO3nhE4/8zBiYhrt2wlp4DnlYdJPwuqD4JcclLO/UMec2S8VqIKEqT4pBugEwdMWbHI1xgtudnZcDeuTW4hQxjH+LVrm/BpfbN8jOU4kvj8VWG9cnWTsegTwsODMkHmC5qDjOnV2Ti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RBRfgEUu; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708692703; x=1740228703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCMZi11A1E2YMpLas5B8w2A6YUXUmq8oj7oBAEFAisI=;
  b=RBRfgEUuFEjaCYq04c+kGGnPvS8EJtPRYzOw/+whnWlfjax5uR3HW8Z2
   ytQPH8ICPV/24QEtXb7iBRSs49z+6ZpATg+7sloxAt5zYzItfGCKP/FTj
   ITCz+E+AE3CiQRWah/rSsae0iQ4wOPUzNJKq924JhYNPLRvluTxdOD7BQ
   y7cNlycpCXeDhSIMjjgvsYzOXXRqNziMVdZEvXVOBW5Mj2IdNA6CAPTtu
   0fV5GF0rvBt0dgMY80feOAXdAMt4EVzJkJNtY1v0VKmkrPxVusYtJU7st
   Jnvrx+niT2TXMHTUWze+whUNBy6VvUG6kxn6BLNR9s56g4G0ptyyiexTX
   w==;
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="35568140"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Feb 2024 13:51:40 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9D5F8280075;
	Fri, 23 Feb 2024 13:51:40 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de, marex@denx.de
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix LDB clocks property
Date: Fri, 23 Feb 2024 13:51:40 +0100
Message-ID: <1979964.usQuhbGJ8B@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240223091522.2880155-1-victor.liu@nxp.com>
References: <20240223091522.2880155-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 23. Februar 2024, 10:15:22 CET schrieb Liu Ying:
> The "media_ldb_root_clk" is the gate clock to enable or disable the clock
> provided by CCM(Clock Control Module) to LDB instead of the "media_ldb"
> clock which is the parent of the "media_ldb_root_clk" clock as a composite
> clock.  Fix LDB clocks property by referencing the "media_ldb_root_clk"
> clock instead of the "media_ldb" clock.
>=20
> Fixes: e7567840ecd3 ("arm64: dts: imx8mp: Reorder clock and reg propertie=
s")
> Fixes: 94e6197dadc9 ("arm64: dts: imx8mp: Add LCDIF2 & LDB nodes")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Thanks.
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index 9ab9c057f41e..bfc5c81a5bd4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1824,7 +1824,7 @@ lvds_bridge: bridge@5c {
>  					compatible =3D "fsl,imx8mp-ldb";
>  					reg =3D <0x5c 0x4>, <0x128 0x4>;
>  					reg-names =3D "ldb", "lvds";
> -					clocks =3D <&clk IMX8MP_CLK_MEDIA_LDB>;
> +					clocks =3D <&clk IMX8MP_CLK_MEDIA_LDB_ROOT>;
>  					clock-names =3D "ldb";
>  					assigned-clocks =3D <&clk IMX8MP_CLK_MEDIA_LDB>;
>  					assigned-clock-parents =3D <&clk IMX8MP_VIDEO_PLL1_OUT>;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




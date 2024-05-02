Return-Path: <linux-kernel+bounces-166990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752F8BA301
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA0C1F245CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F49175551;
	Thu,  2 May 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElpTu5xx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1157C94;
	Thu,  2 May 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687693; cv=none; b=Z7bb7BY5+3EjKjIaWEgAl7MFOqibfItUPDASRPSU3VGmIendAZrHj1mq2knqvNdcXhRKUvqU4dSx82RyKKUv74eTR0PP8EDL7/K62Sz1sDOqsWYyzkLW18BAZQMItE5jsDNc13RRyxvmjgSDdgNpcINa2EHfoJ2Na7Axn8B50aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687693; c=relaxed/simple;
	bh=cSANErKMObf9NcEc3inF4RRCpSSxHvJpKviDOhPVmmA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VyURsm6NTFXqbClgvcXtz1eP9qKJh+D32j+gfBeliqcrrxSQpoC31l5NEY/Z++E5cWqPMKJtVT87VTrcGNeZjDdt3Cvu/xVV6Qe8dSj4887FrkcU1xu/JvUB4fNx2skbK+71+POpJNxvtFuQv4MNV/WonBUh1+wWMqvQT+4Vfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElpTu5xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBAFC4AF1A;
	Thu,  2 May 2024 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714687692;
	bh=cSANErKMObf9NcEc3inF4RRCpSSxHvJpKviDOhPVmmA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ElpTu5xxSPMOj5k/4UL9XZWNAQS2SHdDSklZoNs99G/RM2pZjH6Fb1qZZBezlyDxp
	 UHzERTN9Xkk2QzqSPqfIhh0bBjc0TKWraQhWvZ5Vyo+JwGol7n0P41FJhncmBm+g0d
	 RlykMIaMrYSB5y4ZJRUy02vmMwbImrWJWBA4YFueqphO9m0EE/e9kXX5NGxCcRSGaP
	 npwQtFCmGUiQ9ro/XuAtgeMw+aiJhvOPpKpmmSxzj0PNVoVP9t7XKn9iXC6NXhKFG9
	 C7cM9ZVgx1w8vWLCsoTdjpfxh9JuEj3ufYEZHmXglkfC46zDwS3il4oDX1y901h2jr
	 ZCnYKng2Nnzcw==
Message-ID: <2e05b0e246431d9dcf28c7135fff8231.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240502034247.2621996-1-quic_mdalam@quicinc.com>
References: <20240502034247.2621996-1-quic_mdalam@quicinc.com>
Subject: Re: [PATCH] clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: quic_mdalam@quicinc.com
To: Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, quic_srichara@quicinc.com, quic_varada@quicinc.com
Date: Thu, 02 May 2024 15:08:10 -0700
User-Agent: alot/0.10

Quoting Md Sadre Alam (2024-05-01 20:42:47)
> Add BRANCH_HALT_VOTED flag to inform clock framework
> don't check for CLK_OFF bit.
>=20
> CRYPTO_AHB_CLK_ENA and CRYPTO_AXI_CLK_ENA enable bit is
> present in other VOTE registers also, like TZ.
> If anyone else also enabled this clock, even if we turn
> off in GCC_APCS_CLOCK_BRANCH_ENA_VOTE | 0x180B004, it won't
> turn off.

Are you seeing problems where we need to send this patch to stable?

>=20
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Any fixes tag?

>  drivers/clk/qcom/gcc-ipq9574.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> index 0a3f846695b8..f8b9a1e93bef 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -2140,9 +2140,10 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src =3D {
> =20
>  static struct clk_branch gcc_crypto_axi_clk =3D {
>         .halt_reg =3D 0x16010,
> +       .halt_check =3D BRANCH_HALT_VOTED,
>         .clkr =3D {
> -               .enable_reg =3D 0x16010,
> -               .enable_mask =3D BIT(0),
> +               .enable_reg =3D 0xb004,

You could be more explicit in the commit text that you're changing the
register offset to the voting register.

> +               .enable_mask =3D BIT(15),


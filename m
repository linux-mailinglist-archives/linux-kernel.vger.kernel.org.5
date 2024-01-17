Return-Path: <linux-kernel+bounces-28727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996C830247
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5A528435A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE113FF6;
	Wed, 17 Jan 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJON6iLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10105CB0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483598; cv=none; b=MhSZJuZe81MxfA/TvjEGIU/YAUglUhz1TD+Sz4mtQveAnXkYxynJygP2+JFbC3nFqt2QsgHjmdQWaL7Je6UWh/h5pXyQlCpxFdCylr4IWw9kyZNd3oofCHtMlyMpDbhzHGbtdZUCRMFlX9DECec9kNzb5bcQkWQ8/qspX3v4l8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483598; c=relaxed/simple;
	bh=1DCjJH54rV/tEEn68lwaeQDLNsZ2ay4x/ceIAvvm/cY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Uk+kfRqrIE+AoL6+mwKfgkhdm8qZI08RvXUKvIseW/Tipf1q4MwN6i1IFscDYmM5ZV/RhX8+xwWLRCT1SzxWv7pDw59ochBkPqc2uHxxoToY4sI0/stFFIoW1/E3h14U8B3eGqWdke0l3sJrrnrM7l9qQf6rmDlgMvXThgdiizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJON6iLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3650DC433F1;
	Wed, 17 Jan 2024 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705483598;
	bh=1DCjJH54rV/tEEn68lwaeQDLNsZ2ay4x/ceIAvvm/cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJON6iLKiEC+Ah4ul4Q7K8vRk+XPUIrWurVASdbmOV4eum3M7H5Ps2yaOIq8huoDr
	 keWgVV5b2DqC5csfWzDqLgdlx12QqXujg0w3UJAsDaz0jl0JP4JNOi1t1ExK0twrtG
	 iqAf6xJbrvp2B1TxWBK4Ru0UJlVAi9frWwHdovmzXGbunXNTN+Vt0jFpKl0Xhp3s8m
	 72vMdYCky8h5yDTJntZBPmWB4xAYR9aGUsMNuaIfZbPi2B7gKsAvvgVDQ4/0jX2U/f
	 eR6glTnjel4GswwhYvvc1+4ySL1x0GolZN03BFs0ynIjaIeMs02xSUwiF4/iN7dFCy
	 qvbRnPgxdLiyw==
Date: Wed, 17 Jan 2024 10:26:35 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 0/4] Support for Simulated Panels
Message-ID: <x6wi5xnihnbpqsujjfjfw3ft6njncruta5l3xa44pds5oxmdkw@mmvv4bciy65s>
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpb5itbob25r5zbr"
Content-Disposition: inline
In-Reply-To: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>


--tpb5itbob25r5zbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 16, 2024 at 02:22:03PM -0800, Jessica Zhang wrote:
> This series introduces a simulated MIPI DSI panel.
>=20
> Currently, the only way to validate DSI connectors is with a physical
> panel. Since obtaining physical panels for all possible DSI configurations
> is logistically infeasible, introduce a way for DSI drivers to simulate a
> panel.
>=20
> This will be helpful in catching DSI misconfiguration bugs and catching
> performance issues for high FPS panels that might not be easily
> obtainable.
>=20
> For now, the simulated panel driver only supports setting customized
> modes via the panel_simlation.mode modparam. Eventually, we would like
> to add more customizations (such as configuring DSC, dual DSI, etc.).

I think that it's more complicated than it needs to be.

Why do we need to support (and switch to) both the actual and
"simulated" panel?

Wouldn't it be simpler if we had a vkms-like panel that we could either
configure from DT or from debugfs that would just be registered the
usual way and would be the only panel we register?

Maxime

--tpb5itbob25r5zbr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZaedSwAKCRDj7w1vZxhR
xcXFAQC2vlK6rC0kPPMhQNqaVADKPb9+jP+ijLXYrxyObs4hdQEArKGgOi6aBD8m
0s6XBa7wPWL+OiwvdJJBXlcRYS7anwo=
=pZtR
-----END PGP SIGNATURE-----

--tpb5itbob25r5zbr--


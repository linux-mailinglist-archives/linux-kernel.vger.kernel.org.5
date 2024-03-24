Return-Path: <linux-kernel+bounces-112647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C20887C82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6C2B20CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6917735;
	Sun, 24 Mar 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="eg84ZX3U"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8128E7;
	Sun, 24 Mar 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711279321; cv=none; b=apXo1OS2fDEEh3A8xdFACNbdeqIe4vDhupWlpMavz9qsdwkp6imv7eIhQhoiNpSRfVvK1DZz55l8gE4Ir0dPPFaLizljqmS2wpKzL69nzi/S1kwz+ANxmztSydw6Y6731b3OTCRZUEOl9mJ38GFAQ4LZpFxeqGaWkt5zTBluzV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711279321; c=relaxed/simple;
	bh=CHiCwMJx97a7aFumYdhFFpr0BdNcgHlVnJDNYCZsuPM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDsWHMOrsNXr1/NANQNa3dMLmVjPWaiMqi0xE+uzZxbjOix5R6QxfHO7GGo4m+4aeppUilkL5Z5RhACkHe/uJ/mulTsD7pPZObGfc9BvWEsuPhPmfMzxwW1TZEdaFsDK9kMEVdNhdTyDowFLEwoZDPrIoKmjUpz4QTqymUMoyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=eg84ZX3U; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1711279308; x=1711538508;
	bh=CHiCwMJx97a7aFumYdhFFpr0BdNcgHlVnJDNYCZsuPM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eg84ZX3UbyCWGStzmB+0bD9GjZ4fgn606vz6QIfuD/mQdedzWjM1fPiCFs9FZGStY
	 XjL4X7RfBy10J554SUUVuqDECeCmSDw1lIVcGGnobLQw/38l+yS9ArM9a5Jfx0fSWo
	 f3V6zmmgDXQ2PRcz8GivkibgkC/Dr/ZSl+QBeh7zgRGfBFSRH5+jthYV6cw8LJtbIG
	 jpr1ZB8XX8yQRvxTna40ASXtf8+JD3DorFCB3EK1ogRJNOQM/J5KftxDxDHYO6tNau
	 UZMb0XZhw28aBJjTjILCDze3lF//FGIz1IjXaOoRRjh8CS5hBNRsgHV9pI+qTsMUnc
	 SRECmoe9eVr8Q==
Date: Sun, 24 Mar 2024 11:21:38 +0000
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: disable analog audio for rock-5b
Message-ID: <TbQeSy-AWAKVHo2Alb8hXUvplVNvohDJ2ztRM1x3Fo5PMmGLMsJxtHR-OIms9FlUshfUD9x45EghBCB9gVtcUPlxeMRUJQ_C95DVhu3AJrk=@thefossguy.com>
In-Reply-To: <0005257d-8022-4a66-a802-0c920d259ccd@linaro.org>
References: <20240324062816.145858-1-prathampatel@thefossguy.com> <0005257d-8022-4a66-a802-0c920d259ccd@linaro.org>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, March 24th, 2024 at 16:15, Krzysztof Kozlowski <krzysztof.kozlow=
ski@linaro.org> wrote:

>=20
>=20
> On 24/03/2024 07:28, Pratham Patel wrote:
>=20
> > The addition of `of: property: fw_devlink: Fix stupid bug in remote-end=
point parsing`
>=20
>=20
> Please refer to commits using commit sha () syntax, as mentioned in
> submitting patches.

Noticed that in the wiki but didn't do that since the commit hash for the c=
ommit
was different in each branch (of the stable tree). Maybe I should have copi=
ed the SHA
from Linus' tree. I will do that.

> > + /*
> > + *analog-sound {
> > + * compatible =3D "audio-graph-card";
> > + * label =3D "rk3588-es8316";
>=20
>=20
> Do not comment out code. Instead disable the nodes and provide
> appropriate comment describing reason.

I tried changing the status from okay to disabled. That didn't work. The SB=
C
still locked up during boot.

> Anyway, this does not look like correct solution. DTS is independent of
> OS, so bug in fwlink does not matter for DTS. Either DTS is a correct
> hardware representation or not.

I agree, it's not the correct solution. It is a temporary workaround for th=
e regression
caused. I will send more patches once I receive a few more RK3588-based SBC=
s and investigate.

 -- Pratham Patel


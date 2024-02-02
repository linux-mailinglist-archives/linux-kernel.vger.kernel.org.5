Return-Path: <linux-kernel+bounces-50144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BE38474D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069B91C22547
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2FA148313;
	Fri,  2 Feb 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phYJAnaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3EF2E3E1;
	Fri,  2 Feb 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891648; cv=none; b=AHNBMpMGLhRgjYn9VXWPuBWo0BhZu+ZGu0G6HqwzV5jBBPinm7tnaSZrw2um0p8NwYiM4S7YoLI54u64cNUPLXmq8Ci4s9/8xnVN5FA8WEQHtxDRzFcDE2PoMUsitolQA/F1h40SZmWr2eWIMxD/P/nPlKmlfZlw29IZjudZeuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891648; c=relaxed/simple;
	bh=EYo6WqoGFpyqCfVMnDxKGo8I30FFMCSMN/sRDEPXn7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo8vGUd+ifaCvWzcvMRJ9HjFJ173CjRrctGAASvFKj9GMMzJtrMSQbDu3IibfX8beJAUNGe1hDiO2S4VCEV/B0bNZJw6Dt0rOVrB1Zg59PMQcphef/6eYKsJYs10CXM9cLSHP3XRrlZVc2g+GY7Elm2bJ/JPGHu8O6Y56DAnPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phYJAnaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD7C433C7;
	Fri,  2 Feb 2024 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891647;
	bh=EYo6WqoGFpyqCfVMnDxKGo8I30FFMCSMN/sRDEPXn7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phYJAnaGm3QAJTy3o2MktiN0Erb03lDq8tG0t+i+brLU20Nfc8qglRmbeDJVjRcng
	 pnCScgF7sBOK+u3lc+oPlpgQWGq99H84ng97s/OkHZP8/bVqdPTTZhDWj6CsVLoCu+
	 DZ9bMezyaj6rzP9b4ps9A2xxuXbaqwlaIMpFrjTAOS8tDKi07ROjx4ScmiPG8YCLh0
	 UFx6ewi1eEKvyTnpTEBpXbIXODSvB3lRmwUlTiykxyuVkDs1I8EMp37NCoh2zrO6zA
	 HqEmJx54LxUPBayIrZDLqTWo7XKu1OEjeNFzqJpxj92OmgheJrKm70bY//bFyrNUGW
	 SHl+1aVOpDd5w==
Date: Fri, 2 Feb 2024 16:34:02 +0000
From: Conor Dooley <conor@kernel.org>
To: AS50 WTLi <WTLI@nuvoton.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <20240202-boney-clerical-bd4205dd6aa0@spud>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
 <20240123-bottle-elevating-9fbba5424014@spud>
 <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>
 <20240123-brewery-roving-b9ebc70468f4@spud>
 <591e12e6-117d-28b5-986c-83414ebc6b4e@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OWik59nRW/RnzmqE"
Content-Disposition: inline
In-Reply-To: <591e12e6-117d-28b5-986c-83414ebc6b4e@nuvoton.com>


--OWik59nRW/RnzmqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 02, 2024 at 06:04:12PM +0800, AS50 WTLi wrote:

> The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.


Please fix your mail setup, the quoting etc is broken (html mail?) and
you have this footer there, which is not really compatible with working
with public mailing lists!



--OWik59nRW/RnzmqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0ZegAKCRB4tDGHoIJi
0reyAP9WgT8B2fRzo0EUizrv75crTAufITGT8IWw2JoIcu+dhAEA9OycBbKIAzok
h3dn8+MmDvn0KryHB9fYcZ2xteMggQw=
=nyeW
-----END PGP SIGNATURE-----

--OWik59nRW/RnzmqE--


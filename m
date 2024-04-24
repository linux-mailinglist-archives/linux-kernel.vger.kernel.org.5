Return-Path: <linux-kernel+bounces-156446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6588B02E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BA28399D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE0157A58;
	Wed, 24 Apr 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JUGgeN2e"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3A1426F;
	Wed, 24 Apr 2024 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713942516; cv=none; b=H7Jj4yojL7VbW7o7uMxlhCC5jDkU3K1q6o4zOtaw94Uy1Abx6Oj/7OgrBpj4AzDdpBJ2S+5HOqEk+prVthPVBG+8bdoyo8iC5ZgJ1AOQetkBm0ej/CgZFgUJGBRAY4JODqV421Xb5nd4HiRmcOM+x5vOOpZSDoUZ0rFtSlfSBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713942516; c=relaxed/simple;
	bh=kV6bt9MVCBDrWZ2MIsEdFT+u/Y+Kdv74iX/cKWP5UzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PQormqZd3Tv5sVH25nlrWtjLkOexyqRFAo8y00NbCDIDirFX0aH4WDm2M2Cc7INKdH0/29VysAOQQzbAJqLm+xzglnQLi5fYZxZjLjXHmgeDJk8RF4eUGZRNqRj+I7XyLSSpmvMliXjAX2yNFfUZrIa761h8Gw2sEb1x7HCRu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JUGgeN2e; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Vyxos/vEvitTxZQEE9q6g2NbgtilZPAvA7YmJTUsvKI=; t=1713942513; x=1714547313; 
	b=JUGgeN2eSv2WOqLRmjr/SbhnN7Juz+uUqhXtNZDXwlK9cfUY/TIqTBjLfzLwfQSGo3e7zkod1js
	Cz1mRiN75sZASqAipEB+Wk6PMPmVnHEpp0Gb7/GdfN2E/QdnwZczX7JxsKRlLpPgv8HdKPQa10ZGN
	EaN41mbpI5L42BX32rUMC/lU2iRh7+YEmvRjxm9OIxJKNeXs1ylxBQ/Wtut8kTPmMNAMlFa2KkBMX
	elJ6AYQvP6VNl2m/JKWmBjYnc+0ZsfVZNOFKlBArPsnXwmkvGv+pZIVOU7LY56aPXz1mC9ANz3DVS
	vuS8ahvo7sEVqvRcNGiWUMIdT+Y0pu+ue+KA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rzWjx-00000002tFP-3XeK; Wed, 24 Apr 2024 09:08:25 +0200
Received: from [80.95.105.245] (helo=[172.16.2.143])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rzWjx-000000018gM-2bLz; Wed, 24 Apr 2024 09:08:25 +0200
Message-ID: <dc7797641f9b9a2e5581ac8396ac75260b691e6c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: j2: drop incorrect SPI controller max frequency
 property
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 devicetree@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Date: Wed, 24 Apr 2024 09:08:24 +0200
In-Reply-To: <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
References: <20240322064221.25776-1-krzysztof.kozlowski@linaro.org>
	 <171394121882.41568.17609347008268237958.b4-ty@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2024-04-24 at 08:48 +0200, Krzysztof Kozlowski wrote:
> On Fri, 22 Mar 2024 07:42:21 +0100, Krzysztof Kozlowski wrote:
> > The J2 SPI controller bindings never allowed spi-max-frequency property
> > in the controller node.  Neither old spi-bus.txt bindings, nor new DT
> > schema allows it.  Linux driver does not parse that property from
> > controller node, thus drop it from DTS as incorrect hardware
> > description.  The SPI child device has already the same property with
> > the same value, so functionality should not be affected.
> >=20
> > [...]
>=20
> Month passed, no replies from maintainers about picking it up. Dunno, loo=
ks
> abandoned, so let me grab this. If anyone else wants to pick it up, let m=
e
> know.

I'll pick it up this weekend.

Sorry, I have been quite busy the past weeks with my dayjob.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


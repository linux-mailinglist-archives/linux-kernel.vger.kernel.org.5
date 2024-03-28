Return-Path: <linux-kernel+bounces-122488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0B88F866
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0071C23FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266750A7E;
	Thu, 28 Mar 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="l0gc7oAI"
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F01E89C;
	Thu, 28 Mar 2024 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609717; cv=none; b=DB4e+gqEx4eVnBwi+bfKG49KFmkHBk1DNK40d+uj0YFglwxuZ+xKFWytt7MZuIGc77+HGTm3Jd73emnWoaYjY1BRFkXsD05xqs0EOIyv2sXJOzoh/c8DMldYJEfsidVputMwcSTnH4DaBWRHNuSFoRr4/bTST7wzrzwI5zy5QI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609717; c=relaxed/simple;
	bh=NLxYzsGbGFyjFImux9Rc3XPHCem2ccxWyYmv24Ct/2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Xq5UAkiTETwPlZ+1wjVl4+svEclINjcTd+fS89Rh0a49Q9LLJpuA7e5lX/3QwhAN3RK6VC4f1TusSnfj/jNlgOHpkSX9rdW5xZReqbjGLIk0rOtvPkbRf6oafzCA9vFys4EaHBon3Xz4TbMnJKWJ7iYKphL9zhYgU9q2KIfC3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=l0gc7oAI; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:To:From:Cc:
	Subject:Message-Id:Date:Content-Type:Mime-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LE+PCSOHRzOHjXaYAf54q5i1UdCGrlB6HB15OyYUkrg=; b=l0gc7oAIJqWk9rBkCtBf3gqvab
	Hv/NY3RfPnvnJJpYc+dUCASxCy6FhVwV5Z7vKtv0CJAknRcRFCpMJQCC8JmBxNDs0imyo8DbTUcQp
	6sfyinvlWthNZ79UWnQk9BP886NW06lrqRfW6jb/lfC1QyjuSi/DOH9enK6mURBRkEKAMXSRr6sbI
	pwruCcVT6QxuFA/wZqBuTU7LnoGVtiXFnfniU0YX0N9NjH/2jrWui05fWZ0PSH6E3EdQ1yylJMFca
	N0LZGqE1d7d5NuxkovX+A6AuBMozX/dC35Ben1Re0gnT74c1TJQU4r21oeTyUmof/VzC79ckpVQLD
	nCN7f2Pg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpjsD-000Nm2-5j; Thu, 28 Mar 2024 08:08:29 +0100
Received: from [185.204.1.225] (helo=localhost)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1rpjs6-000Gud-4q; Thu, 28 Mar 2024 08:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=685e7272893909941bbddb0bb8d364638ad9500b3f9d32cffeb73f746d40;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 28 Mar 2024 07:08:20 +0000
Message-Id: <D05701GE187C.3VLOERXP8B3NR@folker-schwesinger.de>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add enable-strobe-pulldown to
 emmc phy on ROCK Pi 4
Cc: "Vinod Koul" <vkoul@kernel.org>, "Yogesh Hegde" <yogi.kernel@gmail.com>,
 "Heiko Stuebner" <heiko@sntech.de>, "Chris Ruehl"
 <chris.ruehl@gtsys.com.hk>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Dragan Simic" <dsimic@manjaro.org>, "Christopher
 Obbard" <chris.obbard@collabora.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
To: <wens@kernel.org>
X-Mailer: aerc 0.17.0-82-g6ffc0ed5991b
References: <20240327192641.14220-1-dev@folker-schwesinger.de>
 <20240327192641.14220-2-dev@folker-schwesinger.de>
 <CAGb2v64cF2fuW7vKq_=AhY+ciAp8t=fxT23AFJWB1qOv1xWuNw@mail.gmail.com>
In-Reply-To: <CAGb2v64cF2fuW7vKq_=AhY+ciAp8t=fxT23AFJWB1qOv1xWuNw@mail.gmail.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27227/Wed Mar 27 09:33:27 2024)

--685e7272893909941bbddb0bb8d364638ad9500b3f9d32cffeb73f746d40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Mar 28, 2024 at 6:39 AM CET, Chen-Yu Tsai wrote:
> > @@ -648,7 +649,8 @@ &saradc {
> >  &sdhci {
> >         max-frequency = <150000000>;
> >         bus-width = <8>;
> > -       mmc-hs200-1_8v;
>
> Shouldn't this be kept around? The node should list all supported modes,
> not just the highest one. Same for the other patch.
>

This is not necessary, mmc-hs400-1_8v implicitly activates the
corresponding HS200 capability, see drivers/mmc/core/host.c:

if (device_property_read_bool(dev, "mmc-hs200-1_8v"))
	host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
/* ... */
if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
	host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;

Kind regards

Folker


--685e7272893909941bbddb0bb8d364638ad9500b3f9d32cffeb73f746d40
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEABYKADgWIQQFbmi0A2l3pTuK+esCQHEyPYq7fQUCZgUXZhocZGV2QGZvbGtl
ci1zY2h3ZXNpbmdlci5kZQAKCRACQHEyPYq7fRRlAPsHldRKc1S1b2zdwEFymTnt
XA+bgHUm8ffUEy+vUfQWbQEA6YyYuwS22VINEn1TKGAClheEqRN7FIjoWeLPq8Kx
QQQ=
=Vc3P
-----END PGP SIGNATURE-----

--685e7272893909941bbddb0bb8d364638ad9500b3f9d32cffeb73f746d40--


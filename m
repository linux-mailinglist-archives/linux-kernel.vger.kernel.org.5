Return-Path: <linux-kernel+bounces-131095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EF89830D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218D91C237D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23CF6BB4C;
	Thu,  4 Apr 2024 08:20:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB90D210E4;
	Thu,  4 Apr 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218811; cv=none; b=a/u3c6CfXtzb0uMcyqYYeehGVZMYt1Q+fCYqbqfuA9MZXqcuYPVhQZYXoYSbrOFGDnDepq6ZsoWmvP6+6LfTQCPvRIXmRZMIIYmEBLHfnrneKSdQ58P9ZZ8EPcOZHpCmPXV9M5lbG91wXaw1ysBA+XPSsIphDbQWaa3YMbaFd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218811; c=relaxed/simple;
	bh=mmezumSzrWKb3Sds5kLWejXi3P1O5zmXFus/Nf1TYQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9C5Nt0FKqKhNEziQq8vXfub7dSPm5gfhV/7WuK2pVCSILVMcUGpGpKtEcoLELbpbiLeBa0RvxwvFD7bok/re8FwMicJdWUXgRPVJGwG2UhZnzQHS+oSUtR6w0jfCuLikXRJmpyXCsiN1hS6O76vkf+8M1M4kWZULKKvgCa7ixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rsIKC-0007uM-Vh; Thu, 04 Apr 2024 10:19:57 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Shreeya Patel <shreeya.patel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
Date: Thu, 04 Apr 2024 10:19:55 +0200
Message-ID: <28071718.gRfpFWEtPU@diego>
In-Reply-To: <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
References:
 <20240327225057.672304-1-shreeya.patel@collabora.com>
 <3049149.687JKscXgg@diego> <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 4. April 2024, 08:15:50 CEST schrieb Krzysztof Kozlowski:
> On 04/04/2024 00:48, Heiko St=FCbner wrote:
> > Am Mittwoch, 3. April 2024, 13:24:05 CEST schrieb Krzysztof Kozlowski:
> >> On 03/04/2024 13:20, Shreeya Patel wrote:
> >>> On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzyszto=
f.kozlowski@linaro.org> wrote:
> >>>
> >>>> On 03/04/2024 11:24, Shreeya Patel wrote:
> >>>>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel=
@collabora.com> wrote:
> >>>>>
> >>>>>> This series implements support for the Synopsys DesignWare
> >>>>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
> >>>>>> and HDMI 2.0.
> >>>>>>
> >>>>>
> >>>>> Hi Mauro and Hans,
> >>>>>
> >>>>> I haven't received any reviews so far. Hence, this is just a gentle=
 reminder to review this patch series.
> >>>>
> >>>> Why did you put clk changes here? These go via different subsystem. =
That
> >>>> might be one of obstacles for your patchset.
> >>>>
> >>>
> >>> I added clock changes in this patch series because HDMIRX driver depe=
nds on it.
> >>> I thought it is wrong to send the driver patches which don't even com=
pile?
> >>
> >> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
> >> Please get it reviewed internally first.
> >=20
> > For the change in question, the clock controller on the soc also handles
> > the reset controls (hence its name CRU, clock-and-reset-unit) .
> >=20
> > There are at least 660 reset lines in the unit and it seems the hdmi-rx=
 one
> > was overlooked on the initial submission, hence patches 1+2 add the
> > reset-line.
> >=20
> > Of course, here only the "arm64: dts:" patch depends on the clock
> > change, is it references the new reset-id.
>=20
> Wait, that's expected, but it is not what was written. Claim was HDMIRX
> driver depends *build time* ("don't even compile").

Trying to do a full build (kernel + dts) will fail, because the the
device-tree patch references the newly added reset-id .

So you end up with a dtc error. Same with the binding.


I think in the past to uncouple this we did reference the id by number
first:

+      resets =3D <&cru SRST_A_HDMIRX>, <&cru SRST_P_HDMIRX>,
+               <&cru SRST_HDMIRX_REF>, <&cru 660>;

Had the id-addition separately and then a later series for kernel x+1
to convert from 660 to SRST_A_HDMIRX_BIU .


> > Am Mittwoch, 3. April 2024, 12:22:57 CEST schrieb Krzysztof Kozlowski:
> >> Please do not engage multiple subsystems in one patchset, if not
> >> necessary. Especially do not mix DTS into media or USB subsystems. And
> >> do not put DTS in the middle!
> >=20
> > picking up your reply from patch 4/6, there seem to be different "schoo=
ls
> > of thought" for this. Some maintainers might want to really only see
> > patches that are explicitly for their subsystem - I guess networking
> > might be a prime example for that, who will essentially apply whole ser=
ies'
> > if nobody protests in time (including dts patches)
>=20
> There is no school saying DTS is allowed to be in the middle.


I think I wrote exactly that in my original reply :-)

Am Donnerstag, 4. April 2024, 00:48:38 CEST schrieb Heiko St=FCbner:
> Of course you're right, the "arm64: dts:" patch should be the last in the
> series and not be in the middle of it.


Heiko




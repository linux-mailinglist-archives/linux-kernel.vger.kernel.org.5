Return-Path: <linux-kernel+bounces-131082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D598982DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB993282CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F267A0E;
	Thu,  4 Apr 2024 08:07:53 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C7433B0;
	Thu,  4 Apr 2024 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218072; cv=none; b=XKXyf33IHzaW7EQT8KB7hNt9wtnM7woQZ4ph8FUljSHqsUcK6+HhJZRtR1WPkdSPe9x4/Y2r4cqRJFL7sAQiaYAhh6+Ll34+L5NxFOilLhALv0Cqeb8V7+GSMrdQmeD1b8pgg5K9Qr0ZAV8ju/sOAN7p8NO7dwGO1LOjxvjUSds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218072; c=relaxed/simple;
	bh=rExwqTNfKLv3TIywfVqg5viYD88ixVjYzp96V6sW5qE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=gLSgULOX5A1PctiVTRhCbFFfwyL/vFKbONgkGrM8WufBUZxGG9vV9lsuDw+sEyqxQWHt0Csv12eWq5EYLGCdNLCGGCYPem5jb5KyFn7cXVv0uzBx4IOldSRqzpt8PxBA/ZvurC6gLxxZmh/XNk0LfYJgJOLg5SraoPZPeek61TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 0F869378209A;
	Thu,  4 Apr 2024 08:07:47 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <35f774-660d3b80-3-513fcf80@97941910>
 <86150c89-11d5-4d52-987e-974b1a03018f@linaro.org> <3049149.687JKscXgg@diego> <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
Date: Thu, 04 Apr 2024 09:07:47 +0100
Cc: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <36bd27-660e6000-3-6c1c1e00@12777057>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, April 04, 2024 11:45 IST, Krzysztof Kozlowski <krzysztof.k=
ozlowski@linaro.org> wrote:

> On 04/04/2024 00:48, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 3. April 2024, 13:24:05 CEST schrieb Krzysztof Kozlows=
ki:
> >> On 03/04/2024 13:20, Shreeya Patel wrote:
> >>> On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzy=
sztof.kozlowski@linaro.org> wrote:
> >>>
> >>>> On 03/04/2024 11:24, Shreeya Patel wrote:
> >>>>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.p=
atel@collabora.com> wrote:
> >>>>>
> >>>>>> This series implements support for the Synopsys DesignWare
> >>>>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
> >>>>>> and HDMI 2.0.
> >>>>>>
> >>>>>
> >>>>> Hi Mauro and Hans,
> >>>>>
> >>>>> I haven't received any reviews so far. Hence, this is just a ge=
ntle reminder to review this patch series.
> >>>>
> >>>> Why did you put clk changes here? These go via different subsyst=
em. That
> >>>> might be one of obstacles for your patchset.
> >>>>
> >>>
> >>> I added clock changes in this patch series because HDMIRX driver =
depends on it.
> >>> I thought it is wrong to send the driver patches which don't even=
 compile?
> >>
> >> Hm, why HDMIRX driver depends on clock? How? This sounds really wr=
ong.
> >> Please get it reviewed internally first.
> >=20
> > For the change in question, the clock controller on the soc also ha=
ndles
> > the reset controls (hence its name CRU, clock-and-reset-unit) .
> >=20
> > There are at least 660 reset lines in the unit and it seems the hdm=
i-rx one
> > was overlooked on the initial submission, hence patches 1+2 add the
> > reset-line.
> >=20
> > Of course, here only the "arm64: dts:" patch depends on the clock
> > change, is it references the new reset-id.
>=20
> Wait, that's expected, but it is not what was written. Claim was HDMI=
RX
> driver depends *build time* ("don't even compile").
>=20

For some context, when I was testing the downstream driver against the
device tree, I saw some failures because of the missing reset ( which I=
 am trying
to add in the first two patches for this series )

..
	hdmirx=5Fdev->rst=5Fbiu =3D devm=5Freset=5Fcontrol=5Fget(hdmirx=5Fdev-=
>dev, "rst=5Fbiu");
	if (IS=5FERR(hdmirx=5Fdev->rst=5Fbiu)) {
		dev=5Ferr(dev, "failed to get rst=5Fbiu control\n");
		return PTR=5FERR(hdmirx=5Fdev->rst=5Fbiu);
	}

shreeya@shreeya:~/collabora/rd/rockchip/linux$ make dtbs
  DTC     arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb
Error: arch/arm64/boot/dts/rockchip/rk3588.dtsi:187.23-24 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:419: arch/arm64/boot/dts/rockchip/rk=
3588-coolpi-cm5-evb.dtb] Error 1
make[2]: *** [scripts/Makefile.build:481: arch/arm64/boot/dts/rockchip]=
 Error 2
make[1]: *** [/home/shreeya/collabora/rd/rockchip/linux/Makefile:1392: =
dtbs] Error 2
make: *** [Makefile:240: =5F=5Fsub-make] Error 2

Sorry for referring this as a driver build failure but I am sure you wo=
uld=20
also have not been okay with the above issues.
Ofcourse I can simply remove this dependency from the driver but maybe
that will affect the functionality and I didn't want to send a buggy pa=
tch series.

My intention here was just like Heiko said, to keep all the dependent p=
atches
together. I didn't know that would be a trouble for Maintainers.

FWIW, HDMIRX patch series was reviewed multiple times and that is why y=
ou
see a Reviewed-by tag from a Collabora Engineer. Sometimes the things t=
hat look
problematic to one might not look the same to others and that is why I =
asked you
to provide some more details about the problem that you were seeing.

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/=
merge=5Frequests/21
https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/=
merge=5Frequests/17


> >=20
> >=20
> > Am Mittwoch, 3. April 2024, 12:22:57 CEST schrieb Krzysztof Kozlows=
ki:
> >> Please do not engage multiple subsystems in one patchset, if not
> >> necessary. Especially do not mix DTS into media or USB subsystems.=
 And
> >> do not put DTS in the middle!
> >=20
> > picking up your reply from patch 4/6, there seem to be different "s=
chools
> > of thought" for this. Some maintainers might want to really only se=
e
> > patches that are explicitly for their subsystem - I guess networkin=
g
> > might be a prime example for that, who will essentially apply whole=
 series'
> > if nobody protests in time (including dts patches)
>=20
> There is no school saying DTS is allowed to be in the middle.
>=20
> Other schools are indeed saying that seeing DTS is good and
> recommendation is to post it separate and provide a link. That's way =
you
> avoid DTS being pulled by Greg, media or networking.
>=20

This was my mistake and I simply forgot to remove the DTS when I was
testing the driver for the last time before sending the v3 upstream.
Adding it in the middle was incorrect, I should have added it as a sepa=
rate
patch but honestly this has always been very confusing and the expectat=
ion
differs from maintainers to maintainers.

> >=20
> > On the other hand I also remember seeing requests for "the full pic=
ture"
> > and individual maintainers then just picking and applying the patch=
es
> > meant for their subsystem.
> >=20
> > The series as it stands right now is nice in that it allows (random=
)
> > developers to just pick it up, apply it to a tree and test the actu=
al driver
> > without needing to hunt for multiple dependant series.
> >=20
> >=20
> > Of course you're right, the "arm64: dts:" patch should be the last =
in the
> > series and not be in the middle of it.
>=20

I will make sure to correct this in my v4.

Thanks,
Shreeya Patel
>=20
> Best regards,
> Krzysztof
>



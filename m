Return-Path: <linux-kernel+bounces-94479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9E874062
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495E61C21657
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AEA14036B;
	Wed,  6 Mar 2024 19:28:31 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342D692E6;
	Wed,  6 Mar 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753310; cv=none; b=LXC09vLRyXFAxC8sV2TTKedzNUsAmZ6ecRIOcdkAbig7MjOxCXc9iEevIM7rhn7BwlaZS5mYCr7Ammm2ADlYmcw7VGyNWMiXd9NV8f7658foL+RtAH4T/+tpJNWFR3j3F988RuHEsKkKosGvp5uDgxMqWsIrkl9KNos/vcapjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753310; c=relaxed/simple;
	bh=CDUCX+fLbgrh7BbmfBBqG2J+zTPmFsBzl3wcitwg1ZI=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=Fsuf9ZSu6QAa4T/msAaS9/4HfHOutl0Uc6oK34EZ+0oXsjGasDsY36IBlgTvOrfCj6cLuKUydgX5AqlHc7bc7TXa4h8dNhpzkvi4UnUPj+n8ZUZ40/cMY2NNUtTk2uRGbJeAHIX9byIq8lOw9Xf01sXbjvBLILiRUnqRaJqf/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 4A61337820DA;
	Wed,  6 Mar 2024 19:28:25 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <6040170.44csPzL39Z@diego>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
 <7657358.31r3eYUQgx@diego> <45138-65e76d00-9-580ee380@232156106> <6040170.44csPzL39Z@diego>
Date: Wed, 06 Mar 2024 19:28:24 +0000
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, nicolas.dufresne@collabora.com, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <ca099-65e8c400-33-2b230d40@237921438>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 4/6] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Add device tree support for HDMI RX Controller
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, March 06, 2024 01:50 IST, Heiko St=C3=BCbner <heiko@sntec=
h.de> wrote:

> Hi again :-)
>=20
> Am Dienstag, 5. M=C3=A4rz 2024, 20:05:02 CET schrieb Shreeya Patel:
> > On Tuesday, March 05, 2024 19:41 IST, Heiko St=C3=BCbner <heiko@snt=
ech.de> wrote:
> > > Am Dienstag, 5. M=C3=A4rz 2024, 13:36:46 CET schrieb Shreeya Pate=
l:
> > > > Add device tree support for Synopsys DesignWare HDMI RX
> > > > Controller.
> > > >=20
> > > > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > > Co-developed-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > > > Signed-off-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > > > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > > > ---
> > > > Changes in v2 :-
> > > >   - Fix some of the checkpatch errors and warnings
> > > >   - Rename resets, vo1-grf and HPD
> > > >   - Move hdmirx=5Fcma node to the rk3588.dtsi file
> > > >=20
> > > >  .../boot/dts/rockchip/rk3588-pinctrl.dtsi     | 41 +++++++++++=
+++
> > > >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 55 +++++++++++=
++++++++
> > > >  2 files changed, 96 insertions(+)
> > >=20
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/ar=
m64/boot/dts/rockchip/rk3588.dtsi
> > > > index 5519c1430cb7..8adb98b99701 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > > @@ -7,6 +7,24 @@
> > > >  #include "rk3588-pinctrl.dtsi"
> > > > =20
> > > >  / {
> > > > +	reserved-memory {
> > > > +		#address-cells =3D <2>;
> > > > +		#size-cells =3D <2>;
> > > > +		ranges;
> > >=20
> > > add blank line here
> > >=20
> > > > +		/*
> > > > +		 * The 4k HDMI capture controller works only with 32bit
> > > > +		 * phys addresses and doesn't support IOMMU. HDMI RX CMA
> > > > +		 * must be reserved below 4GB.
> > > > +		 */
> > > > +		hdmirx=5Fcma: hdmirx=5Fcma {
> > >=20
> > > phandles use "=5F", but node-names "-"
> > >=20
> > > > +			compatible =3D "shared-dma-pool";
> > > > +			alloc-ranges =3D <0x0 0x0 0x0 0xffffffff>;
> > > > +			size =3D <0x0 (160 * 0x100000)>; /* 160MiB */
> > >=20
> > > The comment above that node, could elaborate where the value of 1=
60MB
> > > originates from. I assume it is to hold n-times of 4K frames or w=
hatever,
> > > but it would be helpful for people to be able to read that.
> > >=20
> >=20
> > right, we did the following calculation to come up with this value =
:-
> > 3840 * 2160 * 4 (bytes/pix) * 2 (frames/buffer) / 1000 / 1000 =3D 6=
6M
> > and then we do the 2x times of this value to be on the safer side
> > and support all practical use-cases.
> >=20
> > I'll add some more details to the comment in v3.
>=20
> thanks, that will be helpful for me and everybody reading the dts lat=
er on
>=20
> >=20
> > >=20
> > > > +			no-map;
> > > > +			status =3D "disabled";
> > > > +		};
> > > > +	};
> > > > +
> > > >  	pcie30=5Fphy=5Fgrf: syscon@fd5b8000 {
> > > >  		compatible =3D "rockchip,rk3588-pcie3-phy-grf", "syscon";
> > > >  		reg =3D <0x0 0xfd5b8000 0x0 0x10000>;
> > > > @@ -85,6 +103,38 @@ i2s10=5F8ch: i2s@fde00000 {
> > > >  		status =3D "disabled";
> > > >  	};
> > > > =20
> > > > +	hdmi=5Freceiver: hdmi-receiver@fdee0000 {
> > >=20
> > > Maybe rename the label to "hdmirx:" ... that way in a board enabl=
ing the
> > > cma region, both nodes would stay close to each other?
> > >=20
> >=20
> > Umm we already have receiver in the name so I am not sure if adding=
 rx will be
> > a good idea. I was trying to keep it consistent with the names used=
 in other device tree files.
> > In case you still feel otherwise then do let me know, I'll make the=
 change.
>=20
> I'm somewhat partial to the actual name, I was more getting at simila=
r
> names to keep things together.
>=20
> General sorting rules are that &foo phandles are sorted alphabeticall=
y
> in board devicetrees.
>=20
> So having
>=20
> &hdmirx {
> 	status =3D "okay";
> };
>=20
> &hdmirx=5Fcma {
> 	status =3D "okay";
> };
>=20
> in the board dt, makes them stay together automatically ;-)
>=20
> So if it's hdmirx + hdmirx=5Fcma or hdmi=5Freceiver + hdmi=5Freceiver=
=5Fcma
> doesn't matter that much, just that they share a common basename.
>=20
>=20
> I really want to stay away from allowing special rules for things as =
much
> as possible, because that becomes a neverending story, so it's
> alphabetical sorting.
>=20
> But nothing prevents us from naming phandles in an intelligent way ;-=
) .
>=20

Makes sense to me, I'll use hdmi=5Freceiver + hdmi=5Freceiver=5Fcma com=
bination
to keep it consistent.

Thanks,
Shreeya Patel

>=20
> Thanks
> Heiko
>



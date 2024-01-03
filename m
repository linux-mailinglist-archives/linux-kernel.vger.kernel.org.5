Return-Path: <linux-kernel+bounces-15150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13A8227CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE7828419F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9495D15AF4;
	Wed,  3 Jan 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="gvkkEwF3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562913AD4;
	Wed,  3 Jan 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4T4bq41RG0zDqCy;
	Wed,  3 Jan 2024 04:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1704255024; bh=Q4QSWB4lpoWhI6LvZXYA/LFlYxYL0e3ql56uc4uLsUs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gvkkEwF3/QebBiVMO+2/EJNfLPfOgE+cXeV60VrcsObrJdNuBzSfA7e5nNjsFJ6nx
	 dMQepmLCj7aRiupGy83fdalGF5X8v3/jNOakJSaoNGxu9xNU7TF0bVMlyj/1N9FWKZ
	 ++l1Gi8E+caHIQDYeaxPZpZu+INxm9+u8YwevTBM=
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4T4bpx2l20z9vy5;
	Wed,  3 Jan 2024 04:10:17 +0000 (UTC)
X-Riseup-User-ID: 405420CC388E9EF22FE493B6FCB7CB07418DA6345B23D1C17FCD1E61398A9170
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4T4bpp3Bf5zJmps;
	Wed,  3 Jan 2024 04:10:09 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Manuel Traut <manut@mecka.net>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Danct12 <danct12@riseup.net>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v3 4/4] arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
Date: Wed, 03 Jan 2024 04:09:55 +0000
Message-ID: <4814116.aeNJFYEL58@melttower>
In-Reply-To: <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
References:
 <20240102-pinetab2-v3-0-cb1aa69f8c30@mecka.net>
 <20240102-pinetab2-v3-4-cb1aa69f8c30@mecka.net>
 <775vjfucu2g2s6zzeutj7f7tapx3q2geccpxvv4ppcms4hxbq7@cbrdmlu2ryzp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, January 2, 2024 6:07:56 PM UTC Ond=C5=99ej Jirman wrote:
> On Tue, Jan 02, 2024 at 05:15:47PM +0100, Manuel Traut wrote:
> > +&pcie2x1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pcie_reset_h>;
> > +	reset-gpios =3D <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
> > +	vpcie3v3-supply =3D <&vcc3v3_minipcie>;
> > +	status =3D "okay";
> > +};
>=20
> Does it make sense to enable this HW block by default, when it isn't used=
 on
> actual HW?
>=20

PCI-E is hooked up to a connector in the schematics, so I think it make sen=
se=20
to enable it when there's one available.




Return-Path: <linux-kernel+bounces-69794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BD858EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70591F21CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222EC1DFF2;
	Sat, 17 Feb 2024 10:18:33 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A91DA4D;
	Sat, 17 Feb 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165112; cv=none; b=EmlPIHaBxFnW28TcEm5/O7uQw65FwE5rc3edjYt8OFgShpP6FJbfONnaMgt8qpw89QA7A6OKf4XksfrLy3peikHOvhSo2iadGiANEFOjcjTcsEXJ27Hif3Bh9CCoAMvt4VC2vKok6QZCbLUkYUvofJUHRbizD01fyxv6piYCTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165112; c=relaxed/simple;
	bh=aiFXE/BsRYzdZHdcp09zHfmeNqtnl9tESEV5498+qxQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=bKiXFJorHsREdlF4YIdjyh2sGgWuLGamUq4iF4gQVbSiDVhGT1FM7pwNpNVxYkR0tIsKYV1QeA/qXg+xlguhjb8b2eYeEQQWxt3DePJc1z8Ncc8KBjBDsR1K3i/avwZ1oA0mpNbCbBiD3X/Uk4Ahxxk3wRY0efh6TGfuMbmCmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 1A47B3780A0B;
	Sat, 17 Feb 2024 10:18:27 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <0c2f4d92-afa9-46f1-844e-994bd45924ef@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-2-shreeya.patel@collabora.com>
 <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
 <30d2-65cf5980-3-2ec9f500@242931553> <0c2f4d92-afa9-46f1-844e-994bd45924ef@linaro.org>
Date: Sat, 17 Feb 2024 10:18:26 +0000
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1b9-65d08800-3-19290580@120474537>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/4] =?utf-8?q?clk=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_rst-rk3588=3A?= Add BIU reset
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Saturday, February 17, 2024 13:47 IST, Krzysztof Kozlowski <krzyszto=
f.kozlowski@linaro.org> wrote:

> On 16/02/2024 13:48, Shreeya Patel wrote:
> > On Friday, February 16, 2024 15:33 IST, Krzysztof Kozlowski <krzysz=
tof.kozlowski@linaro.org> wrote:
> >=20
> >> On 16/02/2024 10:49, Shreeya Patel wrote:
> >>> Export hdmirx=5Fbiu soft reset id which is required by the hdmirx=
 controller.
> >>>
> >>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> >>> ---
> >>>  drivers/clk/rockchip/rst-rk3588.c               | 1 +
> >>>  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
> >>
> >> Please run scripts/checkpatch.pl and fix reported warnings. Some
> >> warnings can be ignored, but the code here looks like it needs a f=
ix.
> >> Feel free to get in touch if the warning is not clear.
> >>
> >> Please do internal review. The internal Collabora review would tel=
l you:
> >> YOU MUST run checkpatch. Then you see errors, so why do you send p=
atch
> >> with errors to the mailing list?
> >>
> >=20
> > I am sorry but what errors are you talking about?
> > I don't see any errors reported by checkpatch :-
> >=20
> > shreeya@shreeya:~/collabora/rd/rockchip/torvalds$ ./scripts/checkpa=
tch.pl hdmirx/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch
> > WARNING: DT binding docs and includes should be a separate patch. S=
ee: Documentation/devicetree/bindings/submitting-patches.rst
>=20
> Here.
>=20
> >=20
> > total: 0 errors, 1 warnings, 13 lines checked
> >=20
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fi=
x-inplace.
> >=20
> > hdmirx-v1-1602/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch has=
 style problems, please review.
> >=20
> > I see the above warning but that looks like a false positive to me.
>=20
> Why for your patch it would be false positive and for all others woul=
d not?
>=20

OK, now I see what you meant. Since we are touching the include file an=
d C file together, this warning was generated.
It was a bit confusing to interpret this as the warning also talks abou=
t Documentation which we didn't touch at all.

Anyway, I will create two separate patches for this in v2.


Thanks,
Shreeya Patel

> Best regards,
> Krzysztof
>



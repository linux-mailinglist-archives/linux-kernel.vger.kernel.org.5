Return-Path: <linux-kernel+bounces-69804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E461858EC8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B963B21919
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FB64B5B1;
	Sat, 17 Feb 2024 10:36:53 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A842561C;
	Sat, 17 Feb 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708166212; cv=none; b=gwpMI5zfYDzZek3v3zH8SbKHdsi6OiE/xifvETBfTPjGVGvcYQBLpHAIhOcq/Euvn0g03jm2nX78mnmygviEbkQ9ZpQzYYOK5y3qBWVbDo6iBlPaYtPvX6bdl9yXzw6VG9LwSEa1Ec4jqy1F7q7CnhcKsWHE2XnDXQWWxyErkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708166212; c=relaxed/simple;
	bh=ZVR8hDHjpLVM5b5FKvHzG7fTS1EYfdQFOAaGI1+undQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=BOdwSKdu+Bj8fVWF33Ui+r8iTIUlnpZFyspO6sGzplktvdDi9n5Szx93aa8HNFk++YGK31KrX8abtaiyfwcQuv1di1OMBzFLWaVPUbQdJdcXYZdBlrjRp+RlRFpyAPDw1tahqSY6MId40XY2fiHV4SVUbcL5gKXA308CMZevn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 2999A3780A0B;
	Sat, 17 Feb 2024 10:36:47 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <c8cb8fd4-a67d-4982-b1f8-6fedbb7e9a4f@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-2-shreeya.patel@collabora.com>
 <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
 <30d2-65cf5980-3-2ec9f500@242931553>
 <0c2f4d92-afa9-46f1-844e-994bd45924ef@linaro.org>
 <1b9-65d08800-3-19290580@120474537> <c8cb8fd4-a67d-4982-b1f8-6fedbb7e9a4f@linaro.org>
Date: Sat, 17 Feb 2024 10:36:46 +0000
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1aae-65d08c00-1-625abd00@109408603>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/4] =?utf-8?q?clk=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_rst-rk3588=3A?= Add BIU reset
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Saturday, February 17, 2024 15:50 IST, Krzysztof Kozlowski <krzyszto=
f.kozlowski@linaro.org> wrote:

> On 17/02/2024 11:18, Shreeya Patel wrote:
> > On Saturday, February 17, 2024 13:47 IST, Krzysztof Kozlowski <krzy=
sztof.kozlowski@linaro.org> wrote:
> >=20
> >> On 16/02/2024 13:48, Shreeya Patel wrote:
> >>> On Friday, February 16, 2024 15:33 IST, Krzysztof Kozlowski <krzy=
sztof.kozlowski@linaro.org> wrote:
> >>>
> >>>> On 16/02/2024 10:49, Shreeya Patel wrote:
> >>>>> Export hdmirx=5Fbiu soft reset id which is required by the hdmi=
rx controller.
> >>>>>
> >>>>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> >>>>> ---
> >>>>>  drivers/clk/rockchip/rst-rk3588.c               | 1 +
> >>>>>  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
> >>>>
> >>>> Please run scripts/checkpatch.pl and fix reported warnings. Some
> >>>> warnings can be ignored, but the code here looks like it needs a=
 fix.
> >>>> Feel free to get in touch if the warning is not clear.
> >>>>
> >>>> Please do internal review. The internal Collabora review would t=
ell you:
> >>>> YOU MUST run checkpatch. Then you see errors, so why do you send=
 patch
> >>>> with errors to the mailing list?
> >>>>
> >>>
> >>> I am sorry but what errors are you talking about?
> >>> I don't see any errors reported by checkpatch :-
> >>>
> >>> shreeya@shreeya:~/collabora/rd/rockchip/torvalds$ ./scripts/check=
patch.pl hdmirx/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch
> >>> WARNING: DT binding docs and includes should be a separate patch.=
 See: Documentation/devicetree/bindings/submitting-patches.rst
> >>
> >> Here.
> >>
> >>>
> >>> total: 0 errors, 1 warnings, 13 lines checked
> >>>
> >>> NOTE: For some of the reported defects, checkpatch may be able to
> >>>       mechanically convert to the typical style using --fix or --=
fix-inplace.
> >>>
> >>> hdmirx-v1-1602/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch h=
as style problems, please review.
> >>>
> >>> I see the above warning but that looks like a false positive to m=
e.
> >>
> >> Why for your patch it would be false positive and for all others w=
ould not?
> >>
> >=20
> > OK, now I see what you meant. Since we are touching the include fil=
e and C file together, this warning was generated.
> > It was a bit confusing to interpret this as the warning also talks =
about Documentation which we didn't touch at all.
>=20
> Really, no documentation touching? Care to check the full path of the
> files you are changing?
>=20

Well, I meant the dt-binding doc for rst-rk3588

>=20
> >=20
> > Anyway, I will create two separate patches for this in v2.
>=20
> I think rules cannot be clearer:
> https://elixir.bootlin.com/linux/v6.8-rc4/source/Documentation/device=
tree/bindings/submitting-patches.rst#L13
>=20

right, it was my mistake and I think after this nice and kind feedback,=
 I'll never make the same one again :)

Thanks,
Shreeya Patel

>=20
> Best regards,
> Krzysztof
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com



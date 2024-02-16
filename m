Return-Path: <linux-kernel+bounces-68594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D92857CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5FF1C22337
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FD1292D7;
	Fri, 16 Feb 2024 12:48:22 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9477F19;
	Fri, 16 Feb 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087701; cv=none; b=BRT3XEdcgrjH03os8Jv2FB4l96b99hO8InGkfHsciE1CraZB67Ea9ErUeg52xxkkwePZ5Dh54FPnNwPOVOc032L2QlVcIml2kszx15LZdpGfvifn7b/tyCJstSZBV04A1vjYfCmktk18xG51Idql7+P+8gg6wJHpZ5sDncLvBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087701; c=relaxed/simple;
	bh=ltOuHVrVTKLOnrB7B0KVPfUJ1r7SOLDqXbub8Kj3btc=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=NqThNQyIzvUIo72IGXGwmjnv+VLKyzD7vxAzwGfRK5fAwkVHoKM7PRclUPQC2kXDVEKNqrsFgBuxLf3MD/3lS8p9loqPZ3xp305SScjeAcdPgg5AQ/adst8bnPG7RC0Cu0rhQjcAy6IlYc3s6XFZzrPI4d5R8HvNsLZIVNHLXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1b:c794::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 4636B3780626;
	Fri, 16 Feb 2024 12:48:10 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240216094922.257674-1-shreeya.patel@collabora.com>
 <20240216094922.257674-2-shreeya.patel@collabora.com> <237e690a-2f49-4046-b054-3a878eed6748@linaro.org>
Date: Fri, 16 Feb 2024 12:48:10 +0000
Cc: heiko@sntech.de, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-dt@vger.kernel.org, linux-arm@lists.infradead.org
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30d2-65cf5980-3-2ec9f500@242931553>
Subject: =?utf-8?q?Re=3A?= [PATCH 1/4] =?utf-8?q?clk=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_rst-rk3588=3A?= Add BIU reset
User-Agent: SOGoMail 5.9.1
Content-Transfer-Encoding: quoted-printable

On Friday, February 16, 2024 15:33 IST, Krzysztof Kozlowski <krzysztof.=
kozlowski@linaro.org> wrote:

> On 16/02/2024 10:49, Shreeya Patel wrote:
> > Export hdmirx=5Fbiu soft reset id which is required by the hdmirx c=
ontroller.
> >=20
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> >  drivers/clk/rockchip/rst-rk3588.c               | 1 +
> >  include/dt-bindings/reset/rockchip,rk3588-cru.h | 2 ++
>=20
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
>=20
> Please do internal review. The internal Collabora review would tell y=
ou:
> YOU MUST run checkpatch. Then you see errors, so why do you send patc=
h
> with errors to the mailing list?
>=20

I am sorry but what errors are you talking about?
I don't see any errors reported by checkpatch :-

shreeya@shreeya:~/collabora/rd/rockchip/torvalds$ ./scripts/checkpatch.=
pl hdmirx/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch
WARNING: DT binding docs and includes should be a separate patch. See: =
Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-in=
place.

hdmirx-v1-1602/0001-clk-rockchip-rst-rk3588-Add-BIU-reset.patch has sty=
le problems, please review.

I see the above warning but that looks like a false positive to me.

> Best regards,
> Krzysztof
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com



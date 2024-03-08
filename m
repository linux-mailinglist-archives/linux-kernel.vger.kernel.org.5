Return-Path: <linux-kernel+bounces-96746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738348760F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129441F22800
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C080535A7;
	Fri,  8 Mar 2024 09:29:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B16535A0;
	Fri,  8 Mar 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890196; cv=none; b=tvH1TyAHsWKReHnnVSaXYzTh/EerCXFyggkr1oB2Yy9BFQ0nOtaXjSVqfw2Xn0GOTDMDEzKVU+mCdxvkMs5xhuLM3RWcaBz8F/fU1bdFZ7/bJQlU7sIL0efLt5y4NRmvQ7k9iAd8lhyTbeOV86h8LcBAHLKfxqe4Tw8lr3qLZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890196; c=relaxed/simple;
	bh=786vdokxTRB7TIzU3GEVcMj1xNGQkjpS6CAsEOD9jyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpRX5/AaBVmvguSzk5H3OnjMDNTMQ0W+y7MT7y0AbZ1uF/LGx4mBy35DJ2u9dIFmpjcYfrjKouWcewVNP87hN7jfdmps8TZ7LXbvsiptxL1kwtziHloCfR0WTZlLpX4PNTG+YKvPYF7o2AEhnXTAgnEDu6v0MTun6RuNntsQwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1riWXu-0006Te-Rf; Fri, 08 Mar 2024 10:29:42 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Iskander Amara <iskander.amara@theobroma-systems.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 vahe.grigoryan@theobroma-systems.com,
 angelogioacchino.delregno@collabora.com, dsimic@manjaro.org,
 alexander.stein@ew.tq-group.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on
 RK3399 Puma
Date: Fri, 08 Mar 2024 10:29:41 +0100
Message-ID: <24965019.EfDdHjke4D@diego>
In-Reply-To: <ffc940bf-b9df-4731-a34d-f725a6d6d7f1@theobroma-systems.com>
References:
 <20240308085243.69903-1-iskander.amara@theobroma-systems.com>
 <ffc940bf-b9df-4731-a34d-f725a6d6d7f1@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 8. M=E4rz 2024, 10:25:43 CET schrieb Quentin Schulz:
> Hi Iskander,
>=20
> On 3/8/24 09:52, Iskander Amara wrote:
> > Q7_THRM# pin is connected to a diode on the module which is used
> > as a level shifter, and the pin have a pull-down enabled by
> > default. We need to configure it to internal pull-up, other-
> > wise whenever the pin is configured as INPUT and we try to
> > control it externally the value will always remain zero.
> >=20
> > Signed-off-by: Iskander Amara <iskander.amara@theobroma-systems.com>
>=20
> For the whole series:
>=20
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> @Heiko I think this may match the criteria for stable backports?

at least patch1 does ... it definitly should have a Fixes tag though.




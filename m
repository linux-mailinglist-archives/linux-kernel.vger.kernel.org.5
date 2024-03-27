Return-Path: <linux-kernel+bounces-120666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7EF88DB40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A741D297CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202E4E1C6;
	Wed, 27 Mar 2024 10:30:09 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170744C600;
	Wed, 27 Mar 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535408; cv=none; b=WEiWSGdn9/3mp/M2wO+QlviDZDZ/haUZ+uEaFdG+6U9VtMuALPYNR/2l0pBRfgLuSsnZYQ6XwW3dPjjJYWjVYFuEuOVVTQvxsAlEBzJc3zV3e5o2oK9AZMYA8XwL9I1TYphaZHSBdYpB56SrixE4RZV2b1nEOQBkkQfKW0zxIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535408; c=relaxed/simple;
	bh=jtZZXCHrSFJnjpMKsJwYkQXpJHGZCw8ofi2fnou5F4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4qgk0Q6cRhLyrC8VEvs7mcdLt84bUC+/71FLJ2ryT6cRdyaYrZ0b8sztvrxs6gTW+GJZ/sxly9oK61ZA53HnttG279hC1F1s9PWZRM3PxsMGpMGfO9n1wRmUGZVfAgWJWnByho/dKjdbr5n/vsjtjdf74VzxmnVi4OGRrhOqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpQXg-0005y5-Td; Wed, 27 Mar 2024 11:30:00 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 boris.brezillon@collabora.com, linux-kernel@vger.kernel.org,
 kernel@collabora.com, sebastian.reichel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
Date: Wed, 27 Mar 2024 11:29:59 +0100
Message-ID: <6007945.alqRGMn8q6@diego>
In-Reply-To:
 <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
References:
 <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Montag, 25. M=E4rz 2024, 17:19:04 CET schrieb Dragan Simic:
> Following the approach used to enable the Mali GPU on the rk3588-evb1, [1]
> do the same for the Pine64 QuartzPro64, which uses nearly identical hardw=
are
> design as the RK3588 EVB1.
>=20
> The slight disadvantage is that the regulator coupling logic requires the
> regulators to be always on, which is also noted in the comments.  This is
> obviously something to be improved at some point in the future, but should
> be fine for now, especially because the QuartzPro64 isn't a battery-power=
ed
> board, so low power consumption isn't paramount.
>=20
> [1] https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebast=
ian.reichel@collabora.com/
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

as lore.kernel.org and therefore b4 seems to be on vacation today, you
get a very personal "applied" message ;-) .

So, applied for 6.10 after the core rk3588-gpu-series from Sebastian.


Heiko




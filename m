Return-Path: <linux-kernel+bounces-39294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08283CE43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FA629D13E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C543113A255;
	Thu, 25 Jan 2024 21:12:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD28413BEAB;
	Thu, 25 Jan 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217158; cv=none; b=pTJ0hk4qv2UE2n6d1FuSvi8IUPIza4bWoDxtUG/lhokmYx0it/4Pj0ibi7vzgACrCsLi4TpYqvc1FqHqZ4VefOarhZzajGVpvzyLJjq14ehIUQSRJOL+6THYGvRvOum3ccCzP3mJ6qeeID7z0/kzKbjm7dKmEdQJr8ayWDKMGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217158; c=relaxed/simple;
	bh=vd6/DXjKhlsGcZeIq12IfQ0wreBg6NM9pi0RXu+VKEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYla5NC+rhKLtc7cCiG8eUySV51tKF5pGvOBCR1ac0Ebl9GPD1Lhui1UzzrzVMy+T3iGIqF4be90roVaXUiagmrlPixDP8SvzmmAtMwvkW9kOof/p3F1wMGUpCMVsaWQsAx28iJLyouhYv5VfOkBTHA0EdJhotUYB/NuYR3M81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71L-0002EX-AC; Thu, 25 Jan 2024 22:12:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Alex Bee <knaerzche@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	David Airlie <airlied@gmail.com>
Subject: Re: (subset) [PATCH v4 00/29] Add HDMI support for RK3128
Date: Thu, 25 Jan 2024 22:12:12 +0100
Message-Id: <170621707729.1872080.13318760381519094242.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 22 Dec 2023 18:41:51 +0100, Alex Bee wrote:
> This is version 4 of my series that aims to add support for the display
> controller (VOP) and the HDMI controller block of RK3128 (which is very
> similar to the one found in RK3036). The original intention of this series
> was to add support for this slightly different integration but is by now,
> driven by maintainer's feedback, exploded to be a rework of inno-hdmi
> driver in large parts. It is, however, a change for the better.
> 
> [...]

Applied, thanks!

[27/29] ARM: dts: rockchip: Add display subsystem for RK3128
        commit: 695b9b57443d88a1c8e0567c88a79d1a4532c75e
[28/29] ARM: dts: rockchip: Add HDMI node for RK3128
        commit: 3fd6e33f8fde16869d4cd9cef71ca964b2b0789b
[29/29] ARM: dts: rockchip: Enable HDMI output for XPI-3128
        commit: 5aab66e319df2a6fc4ab06bcb4bd974c1ac4927e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


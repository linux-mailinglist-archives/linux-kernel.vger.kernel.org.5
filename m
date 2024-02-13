Return-Path: <linux-kernel+bounces-64144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD11853AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DE1F2168C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180D56768;
	Tue, 13 Feb 2024 19:16:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CA85FDA1;
	Tue, 13 Feb 2024 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851788; cv=none; b=Afi99DQt6KPwpZIAErCOVuIpJ+yHaHgHGFA/i3FCyIi1woFC901MA60p2aQ32HaSniRPRFzsWiFFkpxdSmn+NX5dHCK/10/S15FQlAgMvHrsO11B50CHLGG95n8XJNh22kPSsnxhWBuCkLXs839rf2/SVJMUm9KU5SpVKqnFCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851788; c=relaxed/simple;
	bh=JDruW73T8aVgn0UsrJsnkY1enu25P7RrfjkCwjMsI9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOLWiIOQoycf7fM3b6ZSgc2kP5qaiTC9B2ETqmi9KrqUJfbpFgZXIHRqPDjnOzntu+8iWaN+IpHlRJzskBzkvJrAnXyB7oJAZOPvB4Ziim8VQfvYveiYybNUdzUPwVN9QWQ/R1tBDig6KHaMt4Lop9p4dFRCG2/ZqkynGiqLXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyGV-0008FY-D6; Tue, 13 Feb 2024 20:16:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1] arm64: dts: rockchip: rk3328: Drop interrupts property from pwm-rockchip nodes
Date: Tue, 13 Feb 2024 20:16:17 +0100
Message-Id: <170785172859.3347621.16554815233925268437.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <5551846d-62cd-4b72-94f4-07541e726c37@gmail.com>
References: <5551846d-62cd-4b72-94f4-07541e726c37@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 5 Feb 2024 00:16:43 +0100, Johan Jonker wrote:
> The binding doesn't define interrupts and adding such a definition was
> refused because it's unclear how they should ever be used and the
> relevant registers are outside the PWM range. So drop them fixing
> several dtbs_check warnings.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3328: Drop interrupts property from pwm-rockchip nodes
      commit: 1bbd894e2ae67faf52632bc9290ff926d9b741ea

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


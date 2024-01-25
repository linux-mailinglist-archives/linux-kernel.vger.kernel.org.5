Return-Path: <linux-kernel+bounces-39290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3F83CE39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F47B23B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC04713AA2E;
	Thu, 25 Jan 2024 21:12:29 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40D13A25E;
	Thu, 25 Jan 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217149; cv=none; b=IRrlq5UXBuHKOjWWYI3Osz2ZweuRuEvCuhvzPJ83jGdJDp/5GmvdRTW7FNVrUcgjahz+xS5VQrxHqi8bfsWy9muD/rJvUs7Ssje4eWaajGturkkGTwn0l5dn9w2E9D/5zLN2GaX14KnmQjFDT8Fo1LxKfLjE0n/PSWTZxMhoXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217149; c=relaxed/simple;
	bh=ohXjUPrjw+hEn8teA76MoXUERbqdff+6IDsYfu9Rvaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upNvHboxWcoqX2CDrXTZX4rdUlMkx/J6ZidXBHScUY4ESMXf74o8Sj8ssAJrbdrsNdcM3dj1AHEdcNlK13Em+zN0c6F0V+t0/ZVWwNBfUVa/5M+4s490su4Y0fnKZR4KqslvRkkiKEe4Yy4t2D7SBxHjHyzuRulPHGbARWPjJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71J-0002EX-Sr; Thu, 25 Jan 2024 22:12:22 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: conor+dt@kernel.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	Iskander Amara <iskander.amara@theobroma-systems.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
Date: Thu, 25 Jan 2024 22:12:10 +0100
Message-Id: <170621707722.1872080.5468349555925757842.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103164734.1151290-1-iskander.amara@theobroma-systems.com>
References: <20240103164734.1151290-1-iskander.amara@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 3 Jan 2024 17:47:34 +0100, Iskander Amara wrote:
> Two pmuio domains on ringneck are not defined:
> 	1- PMUIO1: supplied by vcc_3v3 regulator(PMIC RK809)
> 	2- PMUIO2: supplied by vcc_3v3 regulator(PMIC RK809)
> 
> The reason why no functional effect was observed is because of that
> the above mentionned PMUIO domains were supplied by a regulator
> which is always on.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add missing definition of pmu io domains 1 and 2 on ringneck
      commit: 16a9c74012c4e4bff6d493832cd648b486046ce1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


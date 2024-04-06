Return-Path: <linux-kernel+bounces-133870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A689AA21
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05F81C211E0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A639FF4;
	Sat,  6 Apr 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/S//RIe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E69D383B2;
	Sat,  6 Apr 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395187; cv=none; b=Atw5937KX/3AVdPogS0bGp4NHYp4q7vBHi0pYS5zYD8s2hb9NOhmLFQI/QAESMtoluyVQO/fv+zrjXM19i8wc2x10ek1IbLQ5iVfPCTPqTea4yGMwa/GQvP3a7VDs+SPUkHhSEgCYdlQpR0EV/MfbCivdj16BqFu1iHHx79THeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395187; c=relaxed/simple;
	bh=ZszyxTgj8EnYtTuGNwhBJNSzLvn+uASx2IZx41dSrN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kaUb+gXDbXhSF8oLm3TZwe83nZRV9NGZKok+LE2SFsy9fDJiGh1JePo0C7DmIxeDZxoW4sY9vR+SMp6M916gAX9tiTV2n0mgxwHozX+/rbj4u+tXpe6tlBt65fSCJ/bJOZbbbDurwJiy11fum/DnnFA1FwtmJg36Vcu6CFCf1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/S//RIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0387DC433C7;
	Sat,  6 Apr 2024 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395186;
	bh=ZszyxTgj8EnYtTuGNwhBJNSzLvn+uASx2IZx41dSrN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S/S//RIegxSFn0baXqS24IoG5k/cCwd0QHq6+/TG/px0q/G4vbzjQt3CS1rCI9Sfb
	 79e71HDf79008J3/hSjstjqxKc6n6UKpooTPTMF9OqoyVP9DLWYcQjzN/Jx4WtP3Jm
	 vHwmykKoniJ8lTkQFq1wYycXt8kwbXwBSMm54AhkEwAlAu0QOzo5pIts56x1c3W7Wm
	 7Wqp3n5z4Y1hJU9f9rwQ5vrheMPSRstxdZ5cnr5rjVdKbsLo2j8vL8eOty+6Zcr0fZ
	 HSnNDyT0K33hMUjL27D6bEwId/2CqR6jghbjIPMxDrUDoO5ocMKswmjMdYaqRI1vVq
	 JYpnGTyGqRRog==
From: Vinod Koul <vkoul@kernel.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org, 
 alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
 martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH 00/17] HSI2, UFS & UFS phy support for Tensor
 GS101
Message-Id: <171239517860.352396.12091328444055090399.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:49:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 04 Apr 2024 13:25:42 +0100, Peter Griffin wrote:
> This series adds support for the High Speed Interface (HSI) 2 clock
> management unit, UFS controller and UFS phy calibration/tuning for GS101.
> 
> With this series applied, UFS is now functional! The SKhynix HN8T05BZGKX015
> can be enumerated, partitions mounted etc. This then allows us to move away
> from the initramfs rootfs we have been using for development so far.
> 
> [...]

Applied, thanks!

[04/17] dt-bindings: phy: samsung,ufs-phy: Add dedicated gs101-ufs-phy compatible
        commit: 724e4fc053fe217d0ed477517ae68db11feab1f5
[09/17] phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PMU regmap
        commit: f2c6d0fa197a1558f4ef50162bb87e6644af232d
[10/17] phy: samsung-ufs: ufs: Add SoC callbacks for calibration and clk data recovery
        commit: a4de58a9096b471f9dc1c2bc6bfaa8aa48110c31
[11/17] phy: samsung-ufs: ufs: Add support for gs101 UFS phy tuning
        commit: c1cf725db1065153459f0deb69bd4d497a5fd183
[17/17] MAINTAINERS: Add phy-gs101-ufs file to Tensor GS101.
        commit: 0338e1d2f933a4ec7ae96ed1f40c39b899e357d7

Best regards,
-- 
~Vinod




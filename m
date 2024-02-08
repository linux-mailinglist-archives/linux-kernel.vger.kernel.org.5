Return-Path: <linux-kernel+bounces-58100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D8584E14D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8AB1F28604
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63EA763EA;
	Thu,  8 Feb 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxUNIzFX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D35763E8;
	Thu,  8 Feb 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397336; cv=none; b=tcs+/zOKIY/8+OYRng7/o7ewfJRfSrBoS5FPTlMOpFTLkksbtuxyZowyLwR0gmpG9RDyleW3iVXN0PLYzcAAsavC2shMP3zxtmN8KTf5nABa/M/Xw1D2GsKhEGAeyIdYkus2nXMKqxRuN79pDhmoyNZk/IzzQCTanTfnzYLn/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397336; c=relaxed/simple;
	bh=1/ZcB85VTiWJxSjhx6tddkaZnh0Je4mDKQb/OgO8pGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZA9n5D/IPxzyikwS+l5k4p1ZBi0Y0KBVOfZC1iTBKdH10EjqT+ZDa3zSRbV/tlk76jjvWeRfnTI57PDXWWIkrkM5jxB5SnnE7tVCkLhYxN+kn8SkP0ehSmuuV0oULdVOkaTtqkEWLBTGJolwzOftwP1GBGkZhp5tE7MLm4a0UxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxUNIzFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8840BC433C7;
	Thu,  8 Feb 2024 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707397335;
	bh=1/ZcB85VTiWJxSjhx6tddkaZnh0Je4mDKQb/OgO8pGo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bxUNIzFXQIJw0M/5T4LD28dVrdY4qMWRTVI56hcJkpNW0LyZ0DTyFrLmeNJXybjyq
	 RoV+IhZJJSde8foWXmLrpyxw9GqD/iu6UuaFJlsW4vpByf4Lv+K0SEXC6DW5GYFAEx
	 NaZrMLFo6SmFzQVedpwSfd39NNg4xENW8yw5+rwAZ/15vQBM15deXrlaT6+wA6cm11
	 Hp2uVdQ5Uxm39ZkKozQLKAomoBLPrV9O8oCTeiV1eooYBLmSVu9uRABTpmK1qlDc+r
	 G0Gck5/M9xswTtWg1B8is16mcj6AbamVZLnbd9Qd5TFRyETNpsPMbDuJLDgM6klmIg
	 ESzkD8talrQ5A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, afd@ti.com, srk@ti.com
In-Reply-To: <20240204090336.3209063-1-s-vadapalli@ti.com>
References: <20240204090336.3209063-1-s-vadapalli@ti.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: syscon: Add
 ti,j784s4-pcie-ctrl compatible
Message-Id: <170739733329.994918.10245368447305915989.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 13:02:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 04 Feb 2024 14:33:36 +0530, Siddharth Vadapalli wrote:
> The PCIE_CTRL registers within the CTRL_MMR space of TI's J784S4 SoC
> are used to configure the link speed, lane count and mode of operation
> of the respective PCIe instance. Add compatible for allowing the PCIe
> driver to obtain a regmap for the PCIE_CTRL register within the System
> Controller device-tree node in order to configure the PCIe instance
> accordingly.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: Add ti,j784s4-pcie-ctrl compatible
      commit: 90ba55d8e3bce146a7368d271cea1b7a1d0643bb

--
Lee Jones [李琼斯]



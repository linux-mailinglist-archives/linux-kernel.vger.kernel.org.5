Return-Path: <linux-kernel+bounces-119585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5043A88CABC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CC71F837C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2BB1D539;
	Tue, 26 Mar 2024 17:26:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7A1CD31;
	Tue, 26 Mar 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473963; cv=none; b=SnV9Y/hudVGI0rmigLLJSlItwoUhA+erwmkKrFtlPpgiqmhrEq3rZxMJ73zpDV1QckhGim1tIz6r/vmDJo3NByX5KAv7RGX0Otg/96HKd/dSYcd9knUWyqbW3JkdbZOLKrttvSLP3Cvig7FTJzBXHIeNCJNUoHYjHiwJ8CnXOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473963; c=relaxed/simple;
	bh=bQOtfnvUNAhvnWjm4rdyKLtn+HaabaUAG9lOjm3y6/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0XIJdGS8d6HcqqJN0xEJPae+a4HVDZu/4jHYCl6hpAsN5b2c7O8Ouj4JAtAMeR/wXQ5aVOLOo/COMdykZuhrvsk+DcIUWISNFcebVUt47j0PQ1TB2bMFaSyXLujP6O6HrcoIG1hp06XQnbkCeNZbHV8l5vlTYKK5CmDFlbO29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpAYb-000658-AE; Tue, 26 Mar 2024 18:25:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: rockchip: add wolfvision pf5 mainboard
Date: Tue, 26 Mar 2024 18:25:51 +0100
Message-Id: <171147393347.1162935.10169333694073762099.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
References: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 15:22:30 +0100, Michael Riesch wrote:
> Habidere,
> 
> This series adds the device tree for the WolfVision PF5 mainboard, which
> serves as base for recent WolfVision products. It features the Rockchip
> RK3568 and can be extended with several different extension boards.
> 
> The WolfVision PF5 IO Expander is one example of such an extension board.
> The corresponding device tree overlay is also included in this series.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: add wolfvision vendor prefix
      commit: 37a6d5864fb8226c97eefa59a79de57571e1fee8
[2/4] dt-bindings: arm: rockchip: add wolfvision pf5 mainboard
      commit: 6be2ad17acb76c47e544864467680a7b738d7eb8
[3/4] arm64: dts: rockchip: add wolfvision pf5 mainboard
      commit: 0be29f76633a447e15fc58066ea47688974e68d9
[4/4] arm64: dts: rockchip: add wolfvision pf5 io expander board
      commit: 28799a7734a0e1a38d01b511ca08d33d8cf91b6c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


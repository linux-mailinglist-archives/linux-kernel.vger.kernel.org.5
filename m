Return-Path: <linux-kernel+bounces-84179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D972786A362
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9C1F2E39D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372A5646D;
	Tue, 27 Feb 2024 23:13:43 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378255E50;
	Tue, 27 Feb 2024 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075623; cv=none; b=rJVmM+EvYTfephj+ofO5RKDfKVPWn3IwiAaxRKXVmDrkoMecKASQxCdT0PXo8oOHmTFAdbdJsf+zGUpKeVMD11jOjFmxmcVizT668QthbCvcvS0Bkj47VFRI8uagl8qiFnFfVA3uCvUr7jYIX2MyRRCA/MiiRSiTEvNbk6ywGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075623; c=relaxed/simple;
	bh=qRT4W6Kb3eyr4B1pclJLgJ/8oCEYeLJZdZtYRdksBWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2WtJNhkFvIGoFogAgiWrIrfj9flm99C3t8adFENbFzGX35L6lw/4K3e+7Wt1AazaQbQTLWbLBWvC80fXSltdNy487DgUDj3VVIejVG8QdaUXpJH8S7B9JKA95OyPuCk2dYNSTfwWhRSxRoLGfpkzKiMcHJLgmoETm7O/rkQyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf6dY-0002LS-1X; Wed, 28 Feb 2024 00:13:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Tim Lunn <tim@feathertop.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Andy Yan <andyshrk@163.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Tianling Shen <cnsztl@gmail.com>,
	linux-kernel@vger.kernel.org,
	David Heidelberg <david@ixit.cz>,
	Jagan Teki <jagan@edgeble.ai>
Subject: Re: [PATCH 0/4] Fix vendor strings on Rockchip boards
Date: Wed, 28 Feb 2024 00:13:20 +0100
Message-Id: <170907558762.800427.12078271862090822070.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214040731.3069111-1-tim@feathertop.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 15:07:27 +1100, Tim Lunn wrote:
> A couple of rockchip boards incorrectly list their vendor as Rockchip
> when they are in fact not manufactured by Rockchip.
> 
> Fix the vendor strings to correctly list the manufacturer
> 
> 
> Tim Lunn (4):
>   dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
>   dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
>   arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
>   arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
      commit: db51e128df1010653aab71c07e06280e37fecaeb
[2/4] dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
      commit: a03fd4b3bebc9775c921a965c4c22b1a0d3a2503
[3/4] arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
      commit: 437644753208092f642b7669c69da606aa07dfb4
[4/4] arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
      commit: 7ec958ed6a32daad36918d200b594f33cb4e0dd7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


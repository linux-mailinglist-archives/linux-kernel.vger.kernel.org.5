Return-Path: <linux-kernel+bounces-56593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7097184CC4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35961C21EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F37E56E;
	Wed,  7 Feb 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRulxDwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974807E586;
	Wed,  7 Feb 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314493; cv=none; b=RZ40Kb2qa9F23WT7P1C43gacJ8iCJsq9Uok+/Tq3IoRiRJ012xqLyzaAOSLgg7uLWHvimaV+m1jb3gB97udoGsowpgojacYNPMv3P3UAFF23A37Wnn5qpAg40WkmQA8jEH5EvCSbqCg+5gl2urfgZqULrTDNcdSQhr27dDHpVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314493; c=relaxed/simple;
	bh=g3Z88DUNdFcDu+TkPwpM/lXAN8LWu5w+gBGr1EpmKz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0ZjnrBRiayR/gW3zVyR26vHOCUdhuY0xgp2DPQcj/AQPkqvHjKZ0vqgRfUgcD9oKq07G3NOh0d0fJZgpKjqnP+4hsq2MLMM2U8TUQSX0LUfj1EtEfu9XKK0EgqNzoH9jKJQiZ5mD0vl6DwAwuaFjBUMCWj/3+h1sFFFyZ8S4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRulxDwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7FAC43399;
	Wed,  7 Feb 2024 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314493;
	bh=g3Z88DUNdFcDu+TkPwpM/lXAN8LWu5w+gBGr1EpmKz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JRulxDwtEBTvF/i1yphRDtxYZsJHZ3RoXyDmR0n20YayYd3ONvQFTdgJXhRAxzmGZ
	 gy7IYcUWCGcjxAT9YcYGMYu3IT0be4Xt0Ye8/E/6JxJ7t40YjKGCSgwmQsLaMlHQLs
	 UPWeFhafDy9VRlvQBtYE3hBGYj1aqYQqh+O1WERtnIG+TprXL/ih29DUpbrroPOb6k
	 hJ0KVsG0fgj0CYAQrhScp5mdH3ZpXQTQrWaRIP6osmTy3FZ+VArt5vsPnNB8C2U0Rp
	 YLnhKpBJClH5KwYXXFi52cG1cOhAKb+Lxj9+bfwUGtraZPN26DgOMngx/knYXongCD
	 D8EvOFZVgV+xQ==
From: Vinod Koul <vkoul@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Phi-bang Nguyen <pnguyen@baylibre.com>, 
 Louis Kuo <louis.kuo@mediatek.com>, Andy Hsieh <andy.hsieh@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240111101738.468916-1-jstephan@baylibre.com>
References: <20240111101738.468916-1-jstephan@baylibre.com>
Subject: Re: [PATCH v5 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Message-Id: <170731448892.147119.12389092200889790020.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 15:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 11 Jan 2024 11:17:30 +0100, Julien Stephan wrote:
> This is a new driver that supports the MIPI CSI CD-PHY version 0.5
> 
> The number of PHYs depend on the SoC.
> Each PHY can support D-PHY only or CD-PHY configuration.
> The driver supports only D-PHY mode, so CD-PHY
> compatible PHY are configured in D-PHY mode.
> 
> [...]

Applied, thanks!

[2/2] phy: mtk-mipi-csi: add driver for CSI phy
      commit: 673d70cb3c652ad6d97594e03225bbdf20226216

Best regards,
-- 
~Vinod




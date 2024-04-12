Return-Path: <linux-kernel+bounces-142596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18F88A2D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BE11F21867
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C94757304;
	Fri, 12 Apr 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIaWQ8Nc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1315813E;
	Fri, 12 Apr 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921781; cv=none; b=o4ucrPICItJIAD2B3WoMr5NkuC+VOQn/hy6VEXk+yg7QcxKfu2LfeIl8gd+nZaIaS1UySbzdbXpWWTicMRA+ViVurzYyM+IBfY0IxsIBksptPdCAR0aKhjT3AQRyf/VS3bsMQFXfRMUmpn9SoMVJBkT8vYWAMNNIyIvYwCO0NM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921781; c=relaxed/simple;
	bh=SKyjWHd+tVc2A4+hwCP2t2bgzxmSvGBlmggLzxosv+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bYb9fb16l5sCkYdUufbC1R45rlcEzmkQ1+bmv6RYKQ33gkMXlMjAHSPSpadod3wqP0fN6cRK/YkPYxvKmHwgiJtR41iM6caycRD9k5M9ChxbqBPDD4EMw2U3/yX7Oq1cLAjBnkv5h3o9kXlESe3FG410xkulzZhcbc7BKK69/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIaWQ8Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5DCC2BD11;
	Fri, 12 Apr 2024 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921781;
	bh=SKyjWHd+tVc2A4+hwCP2t2bgzxmSvGBlmggLzxosv+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qIaWQ8NczYgf3PaOoQztrWP5AuN5wOvfXJhhIg6YZtgW1Skk8AdSOjylb3cXZHUIB
	 ZDdbd/xFz7yyqlT0P5p3dbKggDcmVufHALGjG9ao9i1eXs0iX4GyFE87lPVOqwH9gM
	 MS5OLIBWPZ2FlGtXcbSDUDaVp9ofmr+66rZUO0k99Qbxupl+UmMi8rdTxvnwKvIOKy
	 /YQTba3t/JlY0s0R3nBHyobijKuaNfd7hSnp2sY3keILfr5QwOosI/uDpTn4HA0kn/
	 k20BpRch0BosRVCOzPx5dWNSEocHxNId5Vvab/xCJgPSdAJSYJcaPH/n0y24ohlC3X
	 PhKdp29SfzZrA==
From: Vinod Koul <vkoul@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCH v5 00/10] RK3588 USBDP support
Message-Id: <171292177636.599803.10340214164260431529.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:06:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 09 Apr 2024 00:50:27 +0200, Sebastian Reichel wrote:
> This adds Rockchip RK3588 USBDP PHY support, which is used for two of the three
> USB3 controllers in the RK3588 (the third one uses a different PHY, which is
> already supported). The USBDP PHY offers USB3 dual-role and DisplayPort. The
> driver and bindings being upstreamed contains the DP parts, but only USB3 has
> been tested by me (upstream does not yet have a DRM DP bridge driver for this
> platform).
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: phy: add rockchip usbdp combo phy document
        commit: a75d8056e9fefa82ca2bd75a32febc44411cc5c0
[02/10] phy: rockchip: add usbdp combo phy driver
        commit: 2f70bbddeb457580cef3ceb574506083b9272188

Best regards,
-- 
~Vinod




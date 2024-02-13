Return-Path: <linux-kernel+bounces-64147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3759853AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82062B211D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350960B91;
	Tue, 13 Feb 2024 19:16:33 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E0608ED;
	Tue, 13 Feb 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851792; cv=none; b=kFTPchVWvfSJg6jVTHGvP82Gccohz9UJ1/qUgPdMyJdFG/O6vIADQAFbBMu9geQqyMn9c3tj4B37zAGMkty2e6ZHN3KsNZEZAtGXnzKPmiPqQBSK257+x4H8lCxMiNsm00u6iVjbZb6co1jC3NhDH9+M3UoV0ITFiaIdAS9ZAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851792; c=relaxed/simple;
	bh=796ITKA5NKbvgrvrDteJ4BlEpLdbe/hqK4/1B7W789c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8iYta1wUD1fHJ7ql7r41Ou6CSHuiUS44IH5bwuw+4nxQa352RhecZ+p08Xe5ZsDuLhpygTCOnZU6oXZJX9CV4o01vBjvgbEewZNdF6wAX6vm1PPAx23LqXCftDzrZU5Aq5gHBaASkbHvP5LWSUGknE70wSCcvL+Qph6XCZlVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyGX-0008FY-2h; Tue, 13 Feb 2024 20:16:25 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>
Subject: Re: (subset) [PATCH v2 00/12] RK3588 USBDP support
Date: Tue, 13 Feb 2024 20:16:21 +0100
Message-Id: <170785172853.3347621.6269747485696963458.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 17:32:34 +0100, Sebastian Reichel wrote:
> This adds Rockchip RK3588 USBDP PHY support, which is used for two of the three
> USB3 controllers in the RK3588 (the third one uses a different PHY, which is
> already supported). The USBDP PHY offers USB3 dual-role and DisplayPort. The
> driver and bindings being upstreamed contains the DP parts, but only USB3 has
> been tested by me (upstream does not yet have a DRM DP bridge driver for this
> platform).
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: soc: rockchip: add clock to RK3588 VO grf
        commit: c110b7e2d6bdad21caab3f4706a969b05aff7f62
[02/12] dt-bindings: soc: rockchip: add rk3588 USB3 syscon
        commit: 85a33544afa8895803798553c7510658dcbd3546

again just grabbed the grf bindings for now :-)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


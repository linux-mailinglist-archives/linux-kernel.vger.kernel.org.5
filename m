Return-Path: <linux-kernel+bounces-142595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09C8A2D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D82878DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93A56B79;
	Fri, 12 Apr 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWpWX4Ke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F51E531;
	Fri, 12 Apr 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921776; cv=none; b=oZnMpw0uGXoqBQldL5GtGT00eO+ac/rI393ADa1oyOXv8dDR0S4rUjU9EuCGZd5S1HuZQjgz2t2BBu6+g9Y1KGKeaTuGYyvW1658hucoIEldHRVGFVrWn39vIF5xc+STiFnAeEmVQw8WJhb2gM0Bkuv2La8byaBxzUuyuGYbygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921776; c=relaxed/simple;
	bh=5BQ14V4MwSIWKlfSozpghxE/dQxOXZmas/FIhoygFxI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nR9qDrTWVVBm/W80GGMBqOIKp+gxirpPzlzTS6CjexEA0aPAzzm8nDnNp5wE+oLKMRCxNqHiX6DNl8Jfc6SOLUVxl1bOIw3xbYQW7VRe+rSh7gvicIWOgfTkLwNEAeBknvhiNZHiI4Wxd1Oye+LpuUwamBPVJpQqe2hPOXmfLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWpWX4Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5279C113CC;
	Fri, 12 Apr 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712921776;
	bh=5BQ14V4MwSIWKlfSozpghxE/dQxOXZmas/FIhoygFxI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=AWpWX4KecPLDinQNtzsEukig5u9fLIEmD9bql4YmS4yCGoqoymU0Ec8riXMDGc2Kw
	 mDZbX6G2+BXQYLh+QO1+hbac7ZLpkujAM6S63jGC46gumbiuE9fYWYxuzyCotphhBf
	 Y1gJnbhYV8wyfXji6hpKFd2VjMDOUR4J5lZstFro1JDIxLxqpHXBHmoyLhLCGBsvXU
	 oEKChHMkhBjZX8zZyYMUyAywc3XD0Yv7tiu4EQVH6G1K8hypBrlUovB+RO1+6FEyjI
	 okhTGpOfR64FRpVyvpFCrmBXO3YVFT5l9umiwpKN9efS1MKboixziSgC97dX7C3ssH
	 NLVQO8cCXcEUw==
From: Vinod Koul <vkoul@kernel.org>
To: Bc-bocun Chen <bc-bocun.chen@mediatek.com>, 
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Qingfang Deng <dqfext@gmail.com>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <da5498096f71a40ca1eac4124b7bb601c82396fb.1712625857.git.daniel@makrotopia.org>
References: <da5498096f71a40ca1eac4124b7bb601c82396fb.1712625857.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add
 new bindings
Message-Id: <171292176938.599803.1671196467939559140.b4-ty@kernel.org>
Date: Fri, 12 Apr 2024 17:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 09 Apr 2024 03:23:54 +0100, Daniel Golle wrote:
> Add bindings for the MediaTek XFI Ethernet SerDes T-PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> via USXGMII PCS:
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: mediatek,mt7988-xfi-tphy: add new bindings
      commit: f482f76c9d0933b91f32f170fbc421a4d0ebaf56
[2/2] phy: add driver for MediaTek XFI T-PHY
      commit: ac4aa9dbc702329c447d968325b055af84ae1b59

Best regards,
-- 
~Vinod




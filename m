Return-Path: <linux-kernel+bounces-64151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31F853AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A45285FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3818376FA;
	Tue, 13 Feb 2024 19:20:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C110A3A;
	Tue, 13 Feb 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852007; cv=none; b=pfbTCCWW7j6Ak8lq1gSbA4XhoEVvIfzUzjJGozjaiD9/ZfWofb/OImoT2r3mDxu1ryvspr2FdrE2sTZFPoYSobSNICbRdgpKiGJe56yhU/ibMdzeHqUrlVcYA5tJJuUAE5XusMRdk0+/D/5LrJDBqart5LJ0kmwnvWixoBtAXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852007; c=relaxed/simple;
	bh=L6CFmHzcsf+jEGi+d8zlHyKMcEu6Clt494lEjZjuXkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zphjq+hoR3T0ZXY5fbKdPaGC6WXtIDT9KssgPmxWxR8/w/of9j22OzZNk552xBZlijutx6Nlv2482mNiu9qI+aLGUZRYPKcbRGTwKsBUxoJ6qbTPJOm1FreVmdVO2MPdaZsxPj/r9+gdBQ+rapefkVKzDkuLsnD/SrjaD5SxzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZyK2-0008K1-KX; Tue, 13 Feb 2024 20:20:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: robh+dt@kernel.org,
	Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	daniel@ffwll.ch,
	linux-kernel@vger.kernel.org,
	markyao0591@gmail.com,
	devicetree@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	linux-rockchip@lists.infradead.org,
	airlied@gmail.com,
	andy.yan@rock-chips.com,
	mripard@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	tzimmermann@suse.de
Subject: Re: (subset) [PATCH v2 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi: remove port property
Date: Tue, 13 Feb 2024 20:20:01 +0100
Message-Id: <170785199080.3350387.14199175297568955666.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 22:14:29 +0100, Johan Jonker wrote:
> The hdmi-connector nodes are now functional and the new way to model
> hdmi ports nodes with both in and output port subnodes. Unfortunately
> with the conversion to YAML the old method with only an input port node
> was used. Later the new method was also added to the binding.
> A binding must be unambiguously, so remove the old port property
> entirely and make port@0 and port@1 a requirement as all
> upstream dts files are updated as well and because checking
> deprecated stuff is a bit pointless.
> Update the example to avoid use of the removed property.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi: remove port property
      commit: 0d192c4c72ce00ab07a6b27f068607e21f754a46
[2/6] dt-bindings: display: rockchip,dw-hdmi: add power-domains property
      commit: 6b1f93ea345947c94bf3a7a6e668a2acfd310918

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


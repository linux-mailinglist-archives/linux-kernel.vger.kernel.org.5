Return-Path: <linux-kernel+bounces-64181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D6853B46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC8F1F22526
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44860B92;
	Tue, 13 Feb 2024 19:38:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9F60263;
	Tue, 13 Feb 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853088; cv=none; b=nc3vlukIFcVBNJd0DlKjLm0c+9RA/CAEemnICWrvOZulURCapOv4CU+10+4xXr3rRd6cz37LQyn+HT155C+d1WvSGvWS+zKvgPgGDwRPDYrDFrHFjfPsLLC+DKnS4y/fU6asQrvNCjQx5KtWmu0kw8dIdZh+vPTudzcP7R7PcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853088; c=relaxed/simple;
	bh=JkmSYhTnmZJuD999KjySt31TPwjCHTcMbGt10eY9U6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwluGUsa+txvl6y+JJObO7Z8C1pHayEBxrPSkcCrMQfB0QTo/+XQF9+0WUl5KJRp4dPx7Q1VEJcoDU8lKuAA1ZFUcEaQNhH5UB94XqBUrbbJ9bP42kbV4pBBp91K3soIsmlb4tJLYyYYtVZjmhwxj2483KrxcxDmnlUSHr4EGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZybL-0008Re-Bt; Tue, 13 Feb 2024 20:37:55 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: robh+dt@kernel.org,
	Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	tzimmermann@suse.de,
	conor+dt@kernel.org,
	mripard@kernel.org,
	dri-devel@lists.freedesktop.org,
	maarten.lankhorst@linux.intel.com,
	linux-kernel@vger.kernel.org,
	airlied@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-rockchip@lists.infradead.org,
	andy.yan@rock-chips.com,
	devicetree@vger.kernel.org,
	markyao0591@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	daniel@ffwll.ch
Subject: Re: (subset) [PATCH v2 1/6] dt-bindings: display: rockchip: rockchip,dw-hdmi: remove port property
Date: Tue, 13 Feb 2024 20:37:51 +0100
Message-Id: <170785305473.3362031.5919338158795795118.b4-ty@sntech.de>
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

[3/6] ARM: dts: rockchip: fix rk3288 hdmi ports node
      commit: 585e4dc07100a6465b3da8d24e46188064c1c925
[4/6] ARM: dts: rockchip: fix rk322x hdmi ports node
      commit: 15a5ed03000cf61daf87d14628085cb1bc8ae72c
[5/6] arm64: dts: rockchip: fix rk3328 hdmi ports node
      commit: 1d00ba4700d1e0f88ae70d028d2e17e39078fa1c
[6/6] arm64: dts: rockchip: fix rk3399 hdmi ports node
      commit: f051b6ace7ffcc48d6d1017191f167c0a85799f6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


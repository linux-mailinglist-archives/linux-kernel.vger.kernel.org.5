Return-Path: <linux-kernel+bounces-51599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9238F848D0F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3C92828CB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6F22081;
	Sun,  4 Feb 2024 11:17:48 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3421A0B;
	Sun,  4 Feb 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707045467; cv=none; b=lIRH7AgceuvgES17MM9IiywvXHJDyFBi5PpL9FXLBftn3ODDD9urPqE+puYRyEVXcEnJ4v9R/KbapZ7RpIM9nUAzBcxOKTSl2qLJNkVNwL+LRstZdoSduv8MFuMcA9nm8c4LFkqq8EkUm6zhNKNeaZ2exS/lTHBxyidx7O/ifro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707045467; c=relaxed/simple;
	bh=HLi6qiYI3ScE3SqyEmd+G0EqimCKMkgSKEPxljgFyRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4yPJDk+QgZDHr/DF+ywYrvvQ1+NAWLaddTCqwm7Rfd6wKrO3nYq3iaoJG/gjDUy5PbqO6+BmTy3ldxzx/wbxBp4rwaOKrtlzDZ6Sn3xNrSyiRk/0fL70o47PNEuuUAUMXfiOIyzh5CiWLefUBlIOtssa6wTpTqyfD3t0fyOi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [185.175.219.2] (helo=phil.fosdem.net)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rWaUq-00051V-9E; Sun, 04 Feb 2024 12:17:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Mark Yao <markyao0591@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Ondrej Jirman <megi@xff.cz>,
	Maxime Ripard <mripard@kernel.org>,
	Segfault <awarnecke002@hotmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Manuel Traut <manut@mecka.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnaud Ferraris <aferraris@debian.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Danct12 <danct12@riseup.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Sun,  4 Feb 2024 12:17:08 +0100
Message-Id: <170704542194.2517832.14847139781169519437.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
References: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 10:48:41 +0100, Manuel Traut wrote:
> This adds support for the BOE TH101MB31IG002 LCD Panel used in PineTab2 [1] and
> PineTab-V [2] as well as the devictrees for the PineTab2 v0.1 and v2.0.
> 
> The BOE LCD Panel patch was retrieved from [3]. The function-name prefix has
> been adapted and the LCD init section was simplified.
> 
> The PineTab2 devicetree patch was retrieved from [4]. Some renaming was needed
> to pass the dtb-checks, the brightness-levels are specified as range and steps
> instead of a list of values.
> 
> [...]

Applied, thanks!

[3/4] dt-bindings: arm64: rockchip: Add Pine64 PineTab2
      commit: 6a0a5a2a71b3e3c4ae1ee0b34a496cbf2d980832
[4/4] arm64: dts: rockchip: Add devicetree for Pine64 PineTab2
      commit: 1b7e19448f8fbeee23111795f67a003431c40b27

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


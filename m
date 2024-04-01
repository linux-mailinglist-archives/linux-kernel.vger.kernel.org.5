Return-Path: <linux-kernel+bounces-127112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B78946D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F51BB22A38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F945647B;
	Mon,  1 Apr 2024 21:55:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536F54FA3;
	Mon,  1 Apr 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008547; cv=none; b=g95+NVp/PErnivTxyI+6cm0A2tjkP7Z2zjriuC94xH/4WMF+VwDVjrbtClzp+vkFfWfzXZaRC+3pvQt+N05KJtf2ycPAzeBw3Is+t1cmYJapc3Um5c8F56S89QCfU6T0JcFdD9S993iwV6KkWuAOus0NJPNcVe2iZN7H1OCHxDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008547; c=relaxed/simple;
	bh=SLDJIERheNfUmBzUlRQUpcaN7KdpDzJPhxkw7n6gOoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRZaMwhMPKkGrwPgWotm/EocVcbuHqTmMq+6q5K3qiElMTX255KRXjBj1vxCb/HHlbbLe6JePM3GTHCV1rdtpq/+YkkTpQRBqjotPCgpI4tsFegJOAFNpXDbIsill1W2k4x09wWXv6Vz7wL0VBxBYpbH1pbTzIHVUtKdvBn3vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rrPcs-0008FL-EU; Mon, 01 Apr 2024 23:55:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	sebastian.reichel@collabora.com,
	dsimic@manjaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Enable gpu on Cool Pi CM5
Date: Mon,  1 Apr 2024 23:55:29 +0200
Message-Id: <171200852040.1394042.3630896312135424469.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240330100134.3588223-1-andyshrk@163.com>
References: <20240330100134.3588223-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Mar 2024 18:01:33 +0800, Andy Yan wrote:
> Enable mali gpu node and add the board specific supply-regulator.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: Enable gpu on Cool Pi CM5
      commit: 3436ded09656f1f49e064c5e791656acf0dd25c5
[2/2] arm64: dts: rockchip: Enable gpu on Cool Pi 4B
      commit: 604552d0102c4260ef2561b8c84f849e43731678

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


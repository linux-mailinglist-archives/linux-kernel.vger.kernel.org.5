Return-Path: <linux-kernel+bounces-155442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4D8AEA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF681F25A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183C13D622;
	Tue, 23 Apr 2024 15:15:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE713D60B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885345; cv=none; b=PZXhsv1zvzPO2T/4tF5IU3lQeHQ9yPhJN6fSL/H8GSJQokggV2UNCZA9rQcGtcLOGG+qVriv//wViy05tG1NNu27y9SCJpkWdPAnWkA+uJuqTpcaSPwZ/rIKURYJUIF+hFQqDQlpm2lwH8Aexo79TF9bzNcvGi3AvZ4hmrshP8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885345; c=relaxed/simple;
	bh=6v5GyFShmTfKZZ+Wcv7fAd2rfQZzAU3G70hLmcIvOgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDy4GmAlOlc6DDr1eA04REsnpnLQGuhCpPvcO5z9RR0LqK5bL5Drv+yJWTUDYnHAl0fbACEpIrA9mej63gPwO6FsZdDO2vWZ7damj1EczkzT7DlUtNqDaamdyOprc7hQ0+6dIxjIIMJWDA5dvvxUJp/Od+JLPOuKn/8axWzZw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrw-0007PZ-Q3; Tue, 23 Apr 2024 17:15:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2] arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
Date: Tue, 23 Apr 2024 17:15:34 +0200
Message-Id: <171388532516.2652222.6081857561844972520.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422143356.2596414-1-heiko@sntech.de>
References: <20240422143356.2596414-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 16:33:56 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The association of uart2 to the q7-uart pins is part of the module
> itself and not the baseboard used. Therefore move the pinctrl over
> to the tiger dtsi.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: move uart2 pinmux to dtsi on rk3588-tiger
      commit: 5adbad5c464a708a87cf5ade1bfe2ca947bb2f82

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


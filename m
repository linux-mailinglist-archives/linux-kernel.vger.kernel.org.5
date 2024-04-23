Return-Path: <linux-kernel+bounces-155443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2168AEAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CCE284E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9614D13D63B;
	Tue, 23 Apr 2024 15:15:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0F13C83C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885346; cv=none; b=rBt/JBnPy2Af4Y0CNnPO7KUBjipmJz/DTi1RJLg8AGt004VorsKSSjDIpYPB5EG6qOyCsru0JQCdKZTCcOy+JgPszf62UDpgx2gRPtvUCThIb/Ls45JF6o9p5mjE58Rn8YYwXbFmhbYRZMwfYBiQAc5UJ2WG44w7uu7obnHoPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885346; c=relaxed/simple;
	bh=BzKFBfREng1DaUi2BYK+U0VsdFDGvcEGhXl9ywpxAbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0t7AleqltnBxe58gj8M74mLp651NZC6X0VDakAjjM7NdQEiihSyhFbh4KcAhGjJqn+jF8GGCzZtNCyrJwKiwMqNmj2LbYds9T431LTrW4ep2zQw4DEzKd35KBongKqB62ZGU7KILoSzmAzOxi21a1o9DxUejeAjPFGwaBBusKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrx-0007PZ-6b; Tue, 23 Apr 2024 17:15:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@theobroma-systems.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jonas@kwiboo.se,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
Date: Tue, 23 Apr 2024 17:15:35 +0200
Message-Id: <171388532516.2652222.6525742292784507990.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423074956.2622318-1-heiko@sntech.de>
References: <20240423074956.2622318-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 09:49:56 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Jaguar SBC provides an M.2 slot connected to the pcie3 controller.
> In contrast to a number of other boards the pcie-refclk is gpio-controlled,
> so the necessary clock and is added to the list of pcie3 clocks.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
      commit: 0ec7e1096332bc2b9bc881c21cfd234058f747b3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


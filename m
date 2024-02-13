Return-Path: <linux-kernel+bounces-64180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D78853B43
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3227128A659
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFCB60884;
	Tue, 13 Feb 2024 19:38:01 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35260872;
	Tue, 13 Feb 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853081; cv=none; b=j4rdCiv3XibAWLLQPLmhRJROYdfOY2kLRy+RcKuIHeGBZuYmRBIVAqQZOXUFIRgZ42tRLPM4fNy/eAgw/k4UbC97V4Hai1R0TIBqCg6EBq+zv9Q5/0m8M+n10NT2f/TzHu9E6jQXzq0SjHl0htraUPF5YnTqsSssGK2CmzE49Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853081; c=relaxed/simple;
	bh=x4xP/vK/0oYv9pFF/6r9U+e1fxp88CWNK5xtRAtKR7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CwhlBRNwt+NsiS4EFvG2jURrgELxsehG/x+DcOlh5uDlr3WTBDrblHAWnAHssiJJQnnzq5+f/XtHCbxcLucLjA82fFm2Iy/8IR4ahbxSbdw1s3V74I/dlvFf7BSgTWylL7Doow/LGc9A4biOHEbhTZYfC7GkdE9mG/akMQa5DWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZybL-0008Re-Tk; Tue, 13 Feb 2024 20:37:55 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Trevor Woerner <twoerner@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: rockchip: rock-pi-e: adjust phy-handle name
Date: Tue, 13 Feb 2024 20:37:53 +0100
Message-Id: <170785305473.3362031.7094478212374122329.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116204103.29318-1-twoerner@gmail.com>
References: <20240116204103.29318-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 15:41:01 -0500, Trevor Woerner wrote:
> The rock-pi-e currently comes in 4 board spins, the latest one (v1.21)
> swaps out the Realtek 8211e PHY for an 8211f PHY. Therefore modify the
> phy-handle name to be more generic.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: rock-pi-e: adjust phy-handle name
      commit: abe3426c8176b2713713e8ba7cbc7cecc5dedd81

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


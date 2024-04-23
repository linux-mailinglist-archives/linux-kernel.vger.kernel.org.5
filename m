Return-Path: <linux-kernel+bounces-155487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD658AEB43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DEF1F21D00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9296A13C907;
	Tue, 23 Apr 2024 15:39:21 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387A017BA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886761; cv=none; b=qquzmm16nKotxMGmVo9kIAPItH17YrNd7f4e1fr5bnII9vrQI+jD0YWynXFWaYVfb52tIL4Go+RBZFyGFopCaX8u7ZbfJWqsoRGePNE2v9jYsxgYwsSif7/kygbDJwz2YcJSpcgW83v5hGjr4/ohQYwt3fdkHvonqabL0LB/WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886761; c=relaxed/simple;
	bh=cslmGCu362775E1z1FvIh5QstMCGKuJeX1EcIk+xFqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruYmb6RxtLYXckCkP0cZX6TmK8ZMCyo+6SPY1jQ9yonbjGKIO9BbNjahk7vkyDcz8Tg/irRlkA2UV23zVThLvdZUSjtzu3gyQHOqooe4gW08e+shmvhuH34DB+Jzl6EyQ1Vj18xPa+F9sePDUOGgn1fcYEC3fGDSAkIZX1dHPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzIEn-0007h9-G7; Tue, 23 Apr 2024 17:39:17 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@theobroma-systems.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add support for the dual-role dwc3 controllers on rk3588-tiger
Date: Tue, 23 Apr 2024 17:39:14 +0200
Message-Id: <171388674746.2655666.4254972955805866845.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422163951.2604273-1-heiko@sntech.de>
References: <20240422163951.2604273-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 18:39:48 +0200, Heiko Stuebner wrote:
> A comment fix and then the addition of the nodes for the dwc3 controllers
> using the newly merged usbdp phys.
> 
> changes in v2:
> - split out extcon addition into separate patch
> - fix comments in patch1 to cover all affected controllers
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: fix comment for upper usb3 port
      commit: 3482efee1144262dc839792103e6a9e29defecbc
[2/3] arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
      commit: eabb53f5dacfd643b5255f35bad30b8f914decdc
[3/3] arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
      commit: d7b83921d098bd76623381f75f5cd2296f1315cc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


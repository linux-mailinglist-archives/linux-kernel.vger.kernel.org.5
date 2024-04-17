Return-Path: <linux-kernel+bounces-149253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F88A8DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B052A1C217CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466B81734;
	Wed, 17 Apr 2024 21:24:51 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14C651B1;
	Wed, 17 Apr 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389091; cv=none; b=IjpewgyTzf6526fqbenW2M2vU9uvKOe/XLDRUx0Ku6ApaiF8nTZNDwtY6pYgRl3JHTJA0qxbr7DstjgPJA8oxsH/JH53mi8voKVgg9vQz4H+3CN3fLJBXaHtQ0wFpadKON1R8XFD6NYsCY2wbs5ownE5IWtTVkRWSkmXzSGQlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389091; c=relaxed/simple;
	bh=RWDxjloe5cXNXdqvw/yn3xa3ExBr7v6ehROmnvloNjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHhgRiU43cE+NcvX2jXPiwNhGxfw5KieNFsqCo4u4oIc+xMU0EYW4kXdusyhxa7LDi9xRmknl+I58MuFmVhuwYB9v+scTi5n2lEGFoCZl7WkbRi0ldw4RXVSN3T4YKyXecKyU90/Yy1pawuoCykGI6UxfsNKlCbljfpHht0ACso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861917.versanet.de ([94.134.25.23] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxClk-0007Yy-Mb; Wed, 17 Apr 2024 23:24:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Michael Riesch <michael.riesch@wolfvision.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add wolfvision pf5 visualizer display
Date: Wed, 17 Apr 2024 23:24:34 +0200
Message-Id: <171338906385.2268267.11350398666302673626.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
References: <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 14:54:09 +0200, Michael Riesch wrote:
> Add device tree overlay for the WolfVision PF5 Visualizer display.
> Since there shall be additional variants of the WolfVision PF5 display in
> future, move common definitions to a device tree include file.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add wolfvision pf5 visualizer display
      commit: ecca3b96aa849bf7a6e704567c5f71bff912cec0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


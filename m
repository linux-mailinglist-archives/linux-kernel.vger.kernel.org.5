Return-Path: <linux-kernel+bounces-137921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0569389E990
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9D51F2394E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D617F3BB35;
	Wed, 10 Apr 2024 05:15:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577E2BB04;
	Wed, 10 Apr 2024 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726122; cv=none; b=lcegDLjuPRnVS0KGp2E7SamyxtMRB6+3hSeJ1OBEcvKNYMOPAfhzpt8R230INy1Jz+qPOFembvtSN4uLhbTnwyqKRtB6q9OYm1JGZnhZDle9brpJHsAF13CAQMlNU2fv4bT7+CpWyBHY2Y9LdC49uRkAQof4ebZT2/kZFe8w8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726122; c=relaxed/simple;
	bh=uqHdCvKwLUkUq6lL1NYuIJsLFUDJ/F9OwTDrDtKlWLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aB9imxt08aNByIqqgiPJAXFMSpGTCV0hGLrVaQvxszc5PG0F7gxajDcJ7xyq6UJVesW51JkIFKbjQljXW0CMFDqy/qW4oxBoqcuhTsONFwofYL9ZRlq/MESr9MM1rHTPSW/G8E4eY4JCvzmieEEC5rP95N3SksLhThF0DkVX6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIl-0008Ut-Sa; Wed, 10 Apr 2024 07:15:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 0/2] clk: rockchip: clk-rk3568.c: Add missing USB480M_PHY mux
Date: Wed, 10 Apr 2024 07:15:05 +0200
Message-Id: <171272604794.1867483.1180962337998524101.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405-clk-rk3568-usb480m-phy-mux-v1-0-6c89de20a6ff@pengutronix.de>
References: <20240405-clk-rk3568-usb480m-phy-mux-v1-0-6c89de20a6ff@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 05 Apr 2024 09:38:35 +0200, Sascha Hauer wrote:
> This series adds a missing clock for the Rockchip RK3568.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: rockchip: add USB480M_PHY mux
      commit: 575bc7b477e3f6c505f49c3d99d7be965594d640
[2/2] clk: rockchip: clk-rk3568.c: Add missing USB480M_PHY mux
      commit: 007bd99669eae90f23817023dc78dbb38e76437d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


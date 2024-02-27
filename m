Return-Path: <linux-kernel+bounces-84176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F686A363
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC55B29804
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E355E50;
	Tue, 27 Feb 2024 23:13:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16255E40;
	Tue, 27 Feb 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075607; cv=none; b=B8s/mVHco+eT+25NT/nEC0qeOntO2B1ji6W2fH/sQFWBuALZElUBmMVJqGTvGWzxX/0Te1X5j2QyCr3M4CjizWXKSwmn7K4nfytitXH7CDrRP26vRSEUh7lrkaHeZjsB+/S0gOdMohVTXWIi+bUEWkIf6u5wUxUYWo82nJffXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075607; c=relaxed/simple;
	bh=iqlzanjjoDzr969gMl+yTwN1UP8rWB7P+HuMBTc2AOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNxl9Pys+QCu2BSTdrMhEhFSSzWoN/EQ3j9NLPxkYEsGqaLhRBlcBLf76Lt/u4Zlo8tfCp/68wrWffMK2xGUBFcWJUNQXzdJIqQgLEDO1fUPRKWKdiglHbE/XEnkZFzd6glNDAvtj+Kcs7B0AQDybja9ALpIsnu4PskUl3QtRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf6dW-0002LS-Qq; Wed, 28 Feb 2024 00:13:22 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Cc: Heiko Stuebner <heiko@sntech.de>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	Michael Turquette <mturquette@baylibre.com>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] clk: rk3399: Allow to set rate of clk_i2s0_frac's parent
Date: Wed, 28 Feb 2024 00:13:18 +0100
Message-Id: <170907558758.800427.1636847983598079220.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240217193439.1762213-1-megi@xff.cz>
References: <20240217193439.1762213-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 20:34:38 +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> Otherwise when when clk_i2s0 muxes to clk_i2s0_div which requires
> setting high divider value on clk_i2s0_div, and then muxes back to
> clk_i2s0_frac, clk_i2s0_frac would have no way to change the
> clk_i2s0_div's divider ratio back to 1 so that it can satisfy the
> condition for m/n > 20 for fractional division to work correctly.
> 
> [...]

Applied, thanks!

[1/1] clk: rk3399: Allow to set rate of clk_i2s0_frac's parent
      commit: 1361d75503fccc0e6b3ecbcd5bb53bbdfdc52f0a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


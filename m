Return-Path: <linux-kernel+bounces-133865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401489AA14
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E2B2242E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8F52DF92;
	Sat,  6 Apr 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur8iN5Y+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154692C6B0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395134; cv=none; b=m1pwoNRyoyOTFneqXCcRZuMiRDtyHKTj9Ge2UWP5VVNpXfK2EI//1T4jHLQVYn2JuASy8px9D/T3nhvtb+LP9ujzEZlqOseWrz4e3wmf41dVw6AH8/6z1sf3fgfwARcncnZLTzJ82A0M4bVWoRgPJZZ/vZkSdz5qs3rqzGzzfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395134; c=relaxed/simple;
	bh=Er4JcBK8oVKacOWZrB83ZPrQHBqLGkadS25ZLuXo7u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lw0reSfJaogtTuhOld6KcO/Sv7jmpSEeS6608O4hl2u36bE7w9svhFXvCZ8KnCWsaeT6Tp+tJTB+3s+BxCvgBj2FLh3OsepQestRW1NaF7WaHjtuWrUKuOFPw5cS/7uWgmIYT4v0sIfZNi8+K9/tZBDW7p/fUIFspJtRbfJ9pbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur8iN5Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268DBC433A6;
	Sat,  6 Apr 2024 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712395134;
	bh=Er4JcBK8oVKacOWZrB83ZPrQHBqLGkadS25ZLuXo7u8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ur8iN5Y+2bsn0Dok/kMeBopZHu03jO0v1a45izq2LsCQ9mLIV9kIil4hK633s8pwA
	 XrQKrnENnQkSjb9beUqVtXoRjRCTh36v8N3rCMlRWon7S488/6R71PyQlPMFLtZhp2
	 ef35ScHjZxTw6bAtjWE985GAo6it3vw+7bv5uwDbG8ADEauIuz5AjQ8aedM28FNGyP
	 ixc56niq0UFZ35gRSqeFJSzbIt5VkTL71VUQ0apq0fFTig7HqE0Md3/MSi2T0Hwx8o
	 +p3r6pMeJOZwJ1z04FeE3GWZkZsyEC7nENVoL9ljECI+ZGLmpvNorIuzU+Y3CI6vwy
	 YWXurXoRsvgeg==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Tomek <mtdev79b@gmail.com>, 
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
References: <20240404-rk3588-pcie-bifurcation-fixes-v1-0-9907136eeafd@kernel.org>
Subject: Re: [PATCH 0/3] RK3588 PCIe bifurcation fixes
Message-Id: <171239513079.352254.15391125336022363426.b4-ty@kernel.org>
Date: Sat, 06 Apr 2024 14:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 04 Apr 2024 19:11:25 +0200, Sebastian Reichel wrote:
> So far the RK3588 boards supported upstream do not make use of
> bifurcation, so it went unnoticed that this feature is broken.
> Michal Tomek tried getting a CM3588 running and noticed some
> problems. These patches fix the bifurcation problems on CM3588
> and also work fine on Rock 5B and EVB1.
> 

Applied, thanks!

[1/3] phy: rockchip-snps-pcie3: fix bifurcation on rk3588
      commit: f8020dfb311d2b6cf657668792aaa5fa8863a7dd
[2/3] phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits
      commit: 55491a5fa163bf15158f34f3650b3985f25622b9
[3/3] phy: rockchip: naneng-combphy: Fix mux on rk3588
      commit: d16d4002fea69b6609b852dd8db1f5844c02fbe4

Best regards,
-- 
~Vinod




Return-Path: <linux-kernel+bounces-155444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7538AEAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424FB1C23AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02E13D8BF;
	Tue, 23 Apr 2024 15:15:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE713D61E;
	Tue, 23 Apr 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885347; cv=none; b=RP/wi08L7szs+Ux/5FU5LO4/UtLkPbldE+a3YsHCZQ6/aFhmCHP+0qxrvtXQLoDwNDF1mxlFDRQch8GSp6dLdmsWnQ0iU99V8Tu6qOdB8wITdPRB48gdsjR2TvvOVRQaXiKEzEB96Jg255xcYoivmVkklft7hv6jipAg1NUPqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885347; c=relaxed/simple;
	bh=6AY4Q8t6gcZCgb3xiM0r/Q68W87/07cL3TLUcrT/CQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cw1UW3qIXhwZX8FpbYpuYIAgkAcU6CqgBw5ztuD71+1aUJk4/Cw8pA6ABJ08ilu3a9nC/vHlZZpqMiRzTbvycv+KABl5qTF8bZZWXw4tsqiJH5bSRkJFhXIiMF9M1eMC0qlGsNDb5FFqb7OdWU/FO/5WKnAGq5Nb5O6scXr30u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrx-0007PZ-P3; Tue, 23 Apr 2024 17:15:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	weizhao.ouyang@arm.com,
	robh@kernel.org,
	sfr@canb.auug.org.au,
	conor+dt@kernel.org
Subject: Re: [PATCH v5 0/3] Add ArmSom Sige7 board
Date: Tue, 23 Apr 2024 17:15:36 +0200
Message-Id: <171388532518.2652222.7856355087807197549.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240420034300.176920-1-liujianfeng1994@gmail.com>
References: <20240420034300.176920-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 20 Apr 2024 11:42:57 +0800, Jianfeng Liu wrote:
> Changes in v5:
>  - Rebase to next-20240419.
>  - Add missing commit tags.
>  - dts: armsom-sige7's led-0 is green, not blue, change "led_blue" to
>    "led_green", "led_rgb_b" to "led_rgb_g". And Weizhao's reveiwed
>    tag to devicetree is removed.
>  - Link to v4: https://lore.kernel.org/all/20240416034626.317823-1-liujianfeng1994@gmail.com/
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: add ArmSoM
      commit: d21ca7a353d3677f0b9c730fb37f7abd373cc9ea
[2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
      commit: 90a5434fc4b4c09fc0b5e4364e8594dabeae0d8d
[3/3] arm64: dts: rockchip: Add ArmSom Sige7 board
      commit: 81c828a67c78bb03ea75819c417c93c7f3d637b5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


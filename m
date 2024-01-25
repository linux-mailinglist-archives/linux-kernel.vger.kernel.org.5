Return-Path: <linux-kernel+bounces-39288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1283CE34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE6C1F21C48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59D13A24B;
	Thu, 25 Jan 2024 21:12:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CC5B210;
	Thu, 25 Jan 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217146; cv=none; b=KnzYAb71NanOXwUbOnxRe+OkjoFtvEina/erfhYlTUrUQhtUoSHYojGfJZC7J3oX0w061D192/ajSMFlbjCvwuekWRAK6tCWVrIIu4y+Lj9zFZNDbeJ6ruqQnjWvCsnjzYawdCCntF73egRZNAUafn6ZHgUT4zMltxadOf2cfvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217146; c=relaxed/simple;
	bh=h4Xrfn55CaRNWXoatvRE2RMHHkjSzFiWLO2LPsmVK+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxH20wL6KTdD6CMFYiRKsmFSG8CJCw0HSnIQ2ZPtidwfUT3SVtE2KxVUq0vGZQpVSu990V97gJxXuDZwnsNUxV6SDkRqbsw1SYc4xOHj7oBoaDF6lIykN+YB5w0eoWh7+0+9Fob17TdzGZspM6IQkgq/DGgfw5uAvKLTt+lb2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71I-0002EX-R1; Thu, 25 Jan 2024 22:12:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: John Clark <inindev@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas McKahan <tmckahan@singleboardsolutions.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add sdmmc card detect to the nanopc-t6
Date: Thu, 25 Jan 2024 22:12:08 +0100
Message-Id: <170621707730.1872080.3618881192574509697.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231230165053.3781-1-inindev@gmail.com>
References: <20231230165053.3781-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Dec 2023 11:50:53 -0500, John Clark wrote:
> The nanopc-t6 has an sdmmc card detect connected to gpio0_a4 which is
> active low.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add sdmmc card detect to the nanopc-t6
      commit: d8bb6c2311b6b2aad11b937f96db1d6c3393246a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


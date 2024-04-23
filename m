Return-Path: <linux-kernel+bounces-155488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1E8AEB44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1899D1F21E02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746A13CA83;
	Tue, 23 Apr 2024 15:39:23 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AE136652
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886762; cv=none; b=ENVgqwSti4Yfu2kr67MA8v0ui551DtjTUITioJWaljTs8WkSMy9CP4gPbpcG0VZhSNccDmoOMwOTB1KmocvzAGNQfY4aQJqvr01VMg3axpBMYqIktp4owza6yNPjRrzSA/u87gzanTW+SzZuwUca1goYrsPXHPI1rariqMZxGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886762; c=relaxed/simple;
	bh=JBTaxV3IaLghfoW6IabfI1Kp6C0x05xHyAQUUmNFtyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmBTKLcQNZGlYn6i1c07Q3o1HC9Lg2FH0Nk3HNCezZv4awEspabC4Fibvx6yJCc3A3EBbMxs4KVmu0m+jf0UVIG8s3M8wKjlG4OW+a7lpOORJuqxK1YjDHENy71euG3MshJVSEv6+LSPasiFlwNhPH6yQ56cl9csBzv3YvLnPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzIEn-0007h9-41; Tue, 23 Apr 2024 17:39:17 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	quentin.schulz@theobroma-systems.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
Date: Tue, 23 Apr 2024 17:39:13 +0200
Message-Id: <171388674749.2655666.16806219158016791877.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240423114635.2637310-1-heiko@sntech.de>
References: <20240423114635.2637310-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Apr 2024 13:46:35 +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The clock-generator of course only produces a 100MHz clock rate,
> not 1GHz.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: fix pcie-refclk frequency on rk3588 tiger
      commit: 0eb2a93518fb4728bd1d55fcd3b57fce4797ef1d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


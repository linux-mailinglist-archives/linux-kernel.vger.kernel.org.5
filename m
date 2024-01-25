Return-Path: <linux-kernel+bounces-39291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9883CE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F1C1F23AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B513B793;
	Thu, 25 Jan 2024 21:12:32 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357305B210;
	Thu, 25 Jan 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217151; cv=none; b=bP80pUX/1VT5ziEamP6NrfGBMBEsYx0IqvuDd2M6L8LXCEbPmFWIJjozWvReYLvEd061Fay4rNPAqoaJN0xWKevlOgdl5gllYVd366+AW+bZ7QhjeQWNQQCgO2a/2If1s0s0PFF35O1n0cFeb0VTG7RcCbZ0r8mz3sfcv9qhvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217151; c=relaxed/simple;
	bh=jQM8+5MPqVlXWq9K1B46QM3OSIBEUylTNizwEtLKRBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpLljC1sGNgroigjn0uyg2NOf9Gta9pP3EupCpV4lvyF+/VEj5nDlNBqjd0/Grc8CqHk1DJSWMDt4R3qhMe02NRqGQmlGwuKq3Ag4yqf+KDITZW00wCD1/UmuaWJjNAFo3MiZsxxwe4P93+COn3CCjuAmj6wCQiBHxWOIUFB+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71J-0002EX-Dt; Thu, 25 Jan 2024 22:12:21 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: John Clark <inindev@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas McKahan <tmckahan@singleboardsolutions.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: nanopc-t6 sdmmc regulator
Date: Thu, 25 Jan 2024 22:12:09 +0100
Message-Id: <170621707730.1872080.11556854185558963327.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240102024054.1030313-1-inindev@gmail.com>
References: <20240102024054.1030313-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 2 Jan 2024 02:40:53 +0000, John Clark wrote:
> sdmmc on the nanopc-t6 is powered by vcc3v3_sd_s0, not vcc_3v3_s3
> add the vcc3v3_sd_s0 regulator, and control it with gpio4_a5
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: nanopc-t6 sdmmc regulator
      commit: 6cb02674a061e4ef4f437ab60c91038d4c0d85ef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


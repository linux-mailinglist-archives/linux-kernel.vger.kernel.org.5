Return-Path: <linux-kernel+bounces-39299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9D83CE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FED1C22816
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9BF13A256;
	Thu, 25 Jan 2024 21:20:01 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578E745C6;
	Thu, 25 Jan 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217601; cv=none; b=FAi+eePRrBsUMcsori6pPmM0Fi8gHk8HydnTuh80Kax7oiQBUAXeKgp8zGaK+T69Z/8UiUCSq1EPnNVCUs7zllQg5v2NDz3/OccmYtmCkiuhNZZcBxe1xqZ7xP60gI50hKxOqLsqKuuq/GyONH8EUToIzJ9A8qMMlHVRNSB7tHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217601; c=relaxed/simple;
	bh=j3M72225OlajdMGRTYtofLwKFN7ylMogm7QsS2fiSBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NISH1zz3MgA8x8vYzze8P7AXi29XvZi3gpTEMXSVLly77MCFurd2H/c693qBUmQiw+OqPeNVvgbgQvsyWVkXCs9NZnlhEjJ+B+RdClHlQGJYisy8c0oG9/b43eAKHgEyDEiqEimthVI7JI+Dh+QIrWRjMgns0mtcVd+BkUlQgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71M-0002EX-6i; Thu, 25 Jan 2024 22:12:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Hugh Cole-Baker <sigmaris@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Thomas McKahan <tmckahan@singleboardsolutions.com>,
	John Clark <inindev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power
Date: Thu, 25 Jan 2024 22:12:15 +0100
Message-Id: <170621707724.1872080.11814565221156143986.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109202729.54292-1-sigmaris@gmail.com>
References: <20240109202729.54292-1-sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 9 Jan 2024 20:27:28 +0000, Hugh Cole-Baker wrote:
> The NanoPC-T6 has a Mini PCIe slot intended to be used for a 4G or LTE
> modem. This slot has no PCIe functionality, only USB 2.0 pins are wired
> to the SoC, and USIM pins are wired to a SIM card slot on the board.
> Define the 3.3v supply for the slot so it can be used.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: enable NanoPC-T6 MiniPCIe power
      commit: d235e65adf00f6db09331874c5a987b7fe18023b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


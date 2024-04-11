Return-Path: <linux-kernel+bounces-141477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779568A1EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E79E1F2A19D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30417328B6;
	Thu, 11 Apr 2024 18:30:28 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DB205E24;
	Thu, 11 Apr 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860227; cv=none; b=Cv1fvbah+x3sZ5PnggjRPCUEBmq4aInubY/w45dXzJeq7p/OvGMYyySAbW8LklQQrlJgJpHYAh/W4GrqQAcp8Ei4/znnh2bJ+2o9nZ46a0PNjMNjxmWnPaTKuq4JmiOewsxVwOQgicuCU22SLbAM8WCY4EsT1149FJwhK3LUE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860227; c=relaxed/simple;
	bh=ZfVS0RMB3WAqrsq3cAe0QGn6vm75CRNlmh+v40r0sbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOJgWPB/Q57YcMgQBpzmLtauzPY2lxnZ+DBBLd3Zlfh3KSja/H0UsuDKqKiGO6D+ZAynRlWAFKHkgIjUjapppg7EDtBUoQYY2pso/NaFIpboQScd0VvUHsn5SPcWSOFlBF+A9kwOuH3VY+4zy8z6nNTPSkbLYZ5YzYE4nVRDIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-67.ptr.icomera.net ([185.104.138.67] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruzBa-0001so-N6; Thu, 11 Apr 2024 20:30:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	efectn@6tel.net
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	sebastian.reichel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org
Subject: Re: [PATCH 1/9] arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2
Date: Thu, 11 Apr 2024 20:29:50 +0200
Message-Id: <171286007463.1886699.8424532199460774699.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
References: <5a7bd2cd8703e51382abfc11242de59d45286477.1708381247.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 01:34:17 +0300, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> This commit adds 5V fixed power regulator and CPU regulators to Khadas
> Edge 2.
> 
> 

Applied, thanks!

[1/9] arm64: dts: rockchip: Add cpu regulators and vcc5v0_sys to Khadas Edge 2
      commit: 925273ba9e71184a6dcde0f902b4245ed64885d1
[2/9] arm64: dts: rockchip: Add PMIC to Khadas Edge 2
      commit: 3b5d2327cb749017322ce09f7107cdc82f1a92fa
[3/9] arm64: dts: rockchip: Add TF card to Khadas Edge 2
      commit: 4a3afe9cf3711f222a9dadf50bd2e9770bb6a095
[4/9] arm64: dts: rockchip: USB2, USB3 Host, PCIe2 to Khadas Edge 2
      commit: f786eda805aa91340e151322ccc6c0ba4a591f9f
[5/9] arm64: dts: rockchip: Add ir receiver and leds to Khadas Edge 2
      commit: af6943f502b6db1ba3bc5199069c662218e23261
[6/9] arm64: dts: rockchip: Add saradc and adc buttons to Khadas Edge 2 and enable tsadc
      commit: 25e31aaebed4b0e242d9a71170f8dfdf9cc8a304
[7/9] arm64: dts: rockchip: Add SFC to Khadas Edge 2
      commit: 8711dca3b5f7a3834ae1129512f98a2367940a07
[8/9] arm64: dts: rockchip: Add UART9 (bluetooth) to Khadas Edge 2
      commit: e438acfda8a0088a3c7f450a7ffefeb56074e41e
[9/9] arm64: dts: rockchip: Add RTC to Khadas Edge 2
      commit: c0b3c764b64a5c8eee056e62580de0f44e7dcd0f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


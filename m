Return-Path: <linux-kernel+bounces-46113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF3843A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03E028DC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE255FBAF;
	Wed, 31 Jan 2024 09:12:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889460DCC;
	Wed, 31 Jan 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692338; cv=none; b=J30SHwc61Omdtn0qbOZ1QjWXBQBD9kSZ1hY0JsAiyvKai1vuy9AVCt/VV+8F2SGeP81fC4qTWE9kW8tP0BJGPT5mttLEFN1Gla1dvbsCCxRn2fC3BpsbFnKFw5MPmem+YeQPfTezakDLKz13APlIfNVQZp7gJMwp1SQm/YQTAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692338; c=relaxed/simple;
	bh=D80N2vifwpdm81cX5xhckzyaCvMCtfIkuavJQlBm2YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaQlH3qghnhBNxQHM5NKzhwPyfO8oS6Nmppb+jlCJ0epUy7/wBZcyZkstHBxq+K5vaBNOv9ArPx1Sc+u81JSoFDZ0lhFd3p/afxNU79PiLlJn3smy7cmTNHFtukFtRS1Kkn4xKFp5tNKTdQ1QdFXN/SUPhpHjGLiYIW+eAmRuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875af6.versanet.de ([83.135.90.246] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rV6dZ-000364-MD; Wed, 31 Jan 2024 10:12:05 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexey Charkov <alchark@gmail.com>
Subject:
 Re: [PATCH v2 3/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
Date: Wed, 31 Jan 2024 10:12:04 +0100
Message-ID: <2168725.pYTLVKaXyH@diego>
In-Reply-To: <20240130-rk-dts-additions-v2-3-c6222c4c78df@gmail.com>
References:
 <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
 <20240130-rk-dts-additions-v2-3-c6222c4c78df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 30. Januar 2024, 19:21:15 CET schrieb Alexey Charkov:
> By default the CPUs on RK3588 start up in a conservative performance
> mode. Add frequency and voltage mappings to the device tree to enable
> dynamic scaling via cpufreq

Please add a paragraph describing where the opp values comes from.
Probably just the vendor kernel, which is fine, but I really like to
document that these values have some sort of grounds ;-)


Thanks
Heiko





Return-Path: <linux-kernel+bounces-87154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63D86D05B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4E1C21823
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231A6CC0E;
	Thu, 29 Feb 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C30cjscs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBE4AED8;
	Thu, 29 Feb 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227108; cv=none; b=WQudx63kkEPlP8HIPKeA8dUk7xk5/+WpUR+Lm8e0Uobde7esXJ/zqvh1Eh3mj+mB9cdqI0eyo4JxBm4Ghe08XPymTNkvDW4XBb1aIxd4gkceM1mwUbY2OD4D76GjlrLtjFq06sH9o2nR5hEtFbP8UHiAEGbR8gH0IH1a+hv9JoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227108; c=relaxed/simple;
	bh=+ZMo9iEMsSfz6V8Ou27C1FUbJqgrktdBSS/LmjvzYAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lK7/kiCF1WRURLM6ux4IfVEzhmBK/YcvyxmJXxZZDg7RR977uVgBKOC6lUHwO5vVM/cKqqudSGhYUQi0n1RjmHqXWYd7GGyKMBD13EyOw90xw5DUFRh8vuSB2p2kTFmq6m/BwNl7K8qqQdLpmgFtiwys98O7K3/2E7aPrNQWd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C30cjscs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA16C433F1;
	Thu, 29 Feb 2024 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227107;
	bh=+ZMo9iEMsSfz6V8Ou27C1FUbJqgrktdBSS/LmjvzYAo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=C30cjscst84mSSST8nBsirG+OfbAQON5hFMVORfzIaT1fNwG5X2+Eo6SpO4rI7iJs
	 xpe9SXUxPA2WiVTbFKr2YOw6Ocub3AxcAqNwQHOa+qt7b7nUrT3YhZjbiQWmY18Y6X
	 b4/yNIMexku+SIWin/2r1UxmIxA0+JQx+h0NgWyYexKVW4RaSLmbHm58ngpsnbfnR3
	 Erb/sTy3XbNfAbA5gQzsjrBkZgTIDiOtKUSK7+qkGdSyxF71kv+Z3xwia2VpVlLCvG
	 sHVznouwYKssgYFofqxmogJ4JYHg5WPCPWPrxuRFj2aF/UcO5oI3G7tRwps0B5YiwP
	 rGqIFLAUDa7KA==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240223112223.1368-1-zajec5@gmail.com>
References: <20240223112223.1368-1-zajec5@gmail.com>
Subject: Re: (subset) [PATCH] dt-bindings: leds: Add
 LED_FUNCTION_WAN_ONLINE for Internet access
Message-Id: <170922710524.1611805.15418765168874516395.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:18:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 23 Feb 2024 12:22:23 +0100, Rafał Miłecki wrote:
> It's common for routers to have LED indicating link on the WAN port.
> 
> Some devices however have an extra LED that's meant to be used if WAN
> connection is actually "online" (there is Internet access available).
> 
> It was suggested to add #define for such use case.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for Internet access
      commit: c0ef9799df8756968c236720658e492fbe636064

--
Lee Jones [李琼斯]



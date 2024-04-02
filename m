Return-Path: <linux-kernel+bounces-127321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF548949AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89450B25009
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611B1401B;
	Tue,  2 Apr 2024 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="KQ2inAUl"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AA72CA9;
	Tue,  2 Apr 2024 02:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026553; cv=none; b=THySLI7k4D1uX5VnUIJB835GW7XEmm+u8Z0qnZ/y+GiHyUJfg1qZOpmJBE1I+HK9nsQfxCUQSVjIpTrw7xN9k3XfMzA+DZoDFpWZ5DMMnBpFRx9fOOOqrQxJuiq8+PIbJyOtv+lD6/LyUOkQFlJb3EAnlnj6JqqvxJ1aDiIW5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026553; c=relaxed/simple;
	bh=2XxlTwkV2RXhvAN4lsefPHFdrwKpoUD9ZvP4It6xCrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNw+3VK8u+aWCOLSeBRWKM/6/mNiJu7s1Hx0h29Nt+e5jcxbKlQMolz6+OfwUaqAFjtwFzKe/Qm7nT/vOUkHTgzX2IHHARAsWLF8CJhJcCqPmve0AZA23RRdEs67g3f2E3BFsOQNuqoTk/+JlHJ29u+oGDOkP8rmECxMDYjOCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=KQ2inAUl; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gWzTiP/4gt9taJuh7HtRu++n48u/+Sj2ewJjuoCFEPo=;
	b=KQ2inAUl8l+yj6skJIHA7KlAGpy4YZHgR1U4rcxurwNbV8w2ZMcL+M2g5M9EZ0
	7lXIh5kLLfH644lAUkdEj1zo/qjFrnQ0D5xuV5yBD1HYUhX+Ab+f/VoQ50kd9H7d
	c93BghKrMQuZzarmiAoURElTExo6aFJLfbDe0o6/ze/6M=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADnThiFcwtmFtmiAg--.40474S3;
	Tue, 02 Apr 2024 10:55:03 +0800 (CST)
Date: Tue, 2 Apr 2024 10:55:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6qdl: mba6: Add missing vdd-supply for
 on-board USB hub
Message-ID: <ZgtzhYBEM5QJSela@dragon>
References: <20240314141736.2943858-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314141736.2943858-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:C1UQrADnThiFcwtmFtmiAg--.40474S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDge0ZVszYdRR2QAAsN

On Thu, Mar 14, 2024 at 03:17:35PM +0100, Alexander Stein wrote:
> This adds vdd-supply powering the USB hub.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied both, thanks!



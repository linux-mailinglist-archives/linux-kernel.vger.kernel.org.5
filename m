Return-Path: <linux-kernel+bounces-98253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB8877776
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37B91F21A6D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E538391;
	Sun, 10 Mar 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsuHvhEb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29047376E4;
	Sun, 10 Mar 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710084047; cv=none; b=f4ERa8iZy+crI3CDXUuSJJlIAYZVTyN9pSGe8TXmcuOgyyd04pj+XdBCNWze/23lQL0l6vpesdoLDTwmU61e2DETV3802ALLy7ZA6baFOcrhVkQq5agtXQC1UXeM5Mn7WxTE9SqZlIBzuHnLBnoOJYyhri8YMCBdpzf+bHyaq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710084047; c=relaxed/simple;
	bh=PXEHdBG7DpAwhjsI0kbk36x2YP6uL6i2ijlDK3FO7Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF2T7s9MyqO7/THu2vptp4DFQE/fA68PdrqZeweWyalf0TPw/gpwtJaNx63/s6TDba6mEyGGW4EfJIBThtaIaCwmzTkNcxDIpGUf96vRqV3iQSIUP4RF9Z8fQ0V77HZ1BBMqNvKRkXJRx4dgCg1lsBMfHHiR1V5JEu/TfAZVUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsuHvhEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF87C433F1;
	Sun, 10 Mar 2024 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710084046;
	bh=PXEHdBG7DpAwhjsI0kbk36x2YP6uL6i2ijlDK3FO7Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WsuHvhEbz6GeNan0BMDBFrwZZF1YQE7zqfD8H2fhnlPAb3k997cGdL6pHZ61uCYYV
	 7BBQACImCQPGAYIJjAFLolioqBCAEs3+D/pHWqj7jK6l72qeF/72s9ayFQsXAHYqOK
	 BoIrfAnUkqSGRd1ASJJhNGT0HNbKKP9c77fQJ9QyrziONdmWDq5mByP+vfkKwNd5D3
	 AmaUH7zAMFXZZ8R7c2cjEJ1ESJ3Spa/2I3l9ENYww4jSmKtdX1Xbiq0Eu+lwknu5vd
	 m4Bkjr2W+b0OESZMvmI/IdpKgtVGtOZBLmitqSZqQLqG6DsWLOQ1MjUc2I7DuRmNlv
	 HgrD192dE1JaA==
Date: Sun, 10 Mar 2024 15:20:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>
Subject: Re: [PATCH v5 0/2] iio: adc: ad7944: new driver
Message-ID: <20240310152029.6f9cc8e8@jic23-huawei>
In-Reply-To: <20240304-ad7944-mainline-v5-0-f0a38cea8901@baylibre.com>
References: <20240304-ad7944-mainline-v5-0-f0a38cea8901@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 13:48:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This is a new driver for the Analog Devices AD7944/AD7985/AD7986 family
> of ADCs. These are fairly simple chips (e.g. no configuration registers)
> but do have some unusual SPI configurations. The initial driver is only
> supporting the normal (4-wire) SPI mode.
> 
> This work is done on behalf of Analog Devices, Inc., hence the
> MAINTAINERS are @analog.com folks.
Series applied to the togreg-normal branch of iio.git and pushed out
for 0-day to get a head start. This is now 6.10 material given timing.
I'll be rebasing my tree after rc1 at which point I'll fall back to my normal
togreg branch naming.

Thanks,

Jonathan


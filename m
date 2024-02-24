Return-Path: <linux-kernel+bounces-79761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38286265B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1044928276C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C3481B7;
	Sat, 24 Feb 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBWZLwnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3814B820;
	Sat, 24 Feb 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708795874; cv=none; b=roY976YpHNO/orpoQHsaj63orej9IMq1JANe7j1rsuLl+CsmJl06hIX6V6ak8P01h8Y9hPvNM9NADTNH45VKtEeWKkbeOZoqsb6iZL37wDsZ0FBRvX7ybH/QUOXPsKcLrv2CFSWejrD0GQVu2jMTN9jlG7WkaZ4at9PU5xWVnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708795874; c=relaxed/simple;
	bh=WfWJQwTKNHoF6gInRBujgT3QRX8Cge62nrn0wrcBk7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ai+JUnwMiPWtebWV2HL4Bce/kBpejR2UkhrluJsKPHwBa3YOYW7G30+jfiI69LI/x0ucbIZ2OnmXBs6nOK9BEKmidv0rxkuaNdQE0lrjpERST97phlnokUU+nHCu7bRCeFBrmbRG7G6+uXUw/ggIpP0kRWX761MOJlt94vy3vIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBWZLwnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A9EC433F1;
	Sat, 24 Feb 2024 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708795873;
	bh=WfWJQwTKNHoF6gInRBujgT3QRX8Cge62nrn0wrcBk7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBWZLwndv9Xl9V2tCMhVRZ9F/sBbs1f0OKypavZCY3kKUGvjqM8KDq2YNcWQJNvNk
	 WCzbXRlX2vQvoFOLgDWsjXgXQ5Rc7ldcpfRC2wOvS2dXJ8eEdKptYgRGTIwZVlH6eq
	 gBxXprjkZ8ChP6xiJmS3hbi6brvG6WgIt5Jq8TiCPHWcwIAf8Gv4j3lqxkoYU8tZ8L
	 Yqq345IF/Uyba5jgF/2cSIEdsN8BS6OXYOXROpsp75z6ZxxNW7TtXGRsUUbuARnmKC
	 AYCus8Y63bnbK34hAnwR3esoQiaIV9767dyoi7wQHJ6GA2AEozZWK7sgbbDXUnD4HP
	 98cOTnr1j3lNw==
Date: Sat, 24 Feb 2024 17:30:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Leonard =?UTF-8?B?R8O2aHJz?=
 <l.goehrs@pengutronix.de>, Mike Looijmans <mike.looijmans@topic.nl>, Haibo
 Chen <haibo.chen@nxp.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Lechner <dlechner@baylibre.com>, Ceclan Dumitru
 <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v15 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240224173055.2b2e067c@jic23-huawei>
In-Reply-To: <20240223133758.9787-1-mitrutzceclan@gmail.com>
References: <20240223133758.9787-1-mitrutzceclan@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 15:37:28 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Ok, in the interests of perfect not being the enemy of good enough.
I'll leave the supplies for now.  There are lots of existing drivers
where we don't list them as required (because my understanding of this
changed in more recent times).

It's been on my list of jobs for a really boring Friday afternoon
to bring them all inline with the convention of if it needs power
on the pin, it's required, so what's one more? :)

As Nuno pointed out, patch 2 clashed with work already upstream to
allow firmware to have the final say on interrupt types. I think
I've resolved that correctly.

I tidied up the docs ordering issue Andy noted.

Also, ad_sigma_delta is namespaced. So added
MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA).

Make sure you test your patches with a modular build
on a more recent tree - that change was early last in 2022!

A few lines in the driver were too long.
I don't mind them going over 80 for readability reasons, but
not over 100.

Anyhow, with those changes (and please check I didn't mess things up!)
applied to the togreg branch of iio.git and pushed for now as testing
for 0-day to get a look in.

Thanks,

Jonathan


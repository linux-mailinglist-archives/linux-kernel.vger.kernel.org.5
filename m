Return-Path: <linux-kernel+bounces-89748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A086F512
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A2A1C20C68
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21DDDBB;
	Sun,  3 Mar 2024 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9naefPk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA1B641;
	Sun,  3 Mar 2024 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472241; cv=none; b=UawQYFvpclbS6YdvSEAkYI6ByKyMeqClrq0sBTBBmzmsTk9OssqAVAeXmyFYjREzUlqZyvf/BFLqFcqRijMG8Hxn0v8xC5dklXU9StwCiSyF/4MFCCifGU21Leu/KIbI8mCz3MSfkzeMM5rUbicRRd2pw0u88boUHg6nGeTWjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472241; c=relaxed/simple;
	bh=5HABLV55vqFa2+LegG4ZksipXRJADsbLdJAjy9nIQ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h40/7y7fn5sqpq1B6mYDsOmEWnNSQSIs0av2aveZPCD0hh6gSm/ahTHZ3dZJUyzv/c2nm/Xwl4qOylZ4O86GgOyAqFzpv7incZcYHBcpIOVenOVN4XrFqMG19QN1IT4F7Xv8BtglphetRSZgkp1GM2vV6fx9oo7AIimV0qAJt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9naefPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB8BC433F1;
	Sun,  3 Mar 2024 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709472240;
	bh=5HABLV55vqFa2+LegG4ZksipXRJADsbLdJAjy9nIQ+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9naefPkvKMLjWvIuGRit0366N+wl1LWzPPQWhwVcS41ZSW6cb8MI9J64A3LU2wK5
	 UAaux1cgpqerz0jeQ8MjItQmvyEP+vwY4F7Slrw/RByq8AuYhKUMQEyhSJy1VbU5gr
	 LJoQx1CmjZgAn3+PMAtNXGyJQjTZEmrWrHnysw3OUL1IrRzSv3ki23vg//o2TiHsbf
	 +OOPq71O0kKVhrJABjZ4teTddDc+ToC8RUo7pQcXAENCwPWkdtipDvtxLCjeiw48h5
	 2metudhex+DFbTMxedtLbbC6pbap5ZOcP5aLDNN/dgwRb3+54kNH4El/JB/p3K/bfw
	 z1/00aB2jVf4Q==
Date: Sun, 3 Mar 2024 13:23:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <20240303132346.3db77d20@jic23-huawei>
In-Reply-To: <20240229-ad7944-mainline-v4-1-f88b5ec4baed@baylibre.com>
References: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
	<20240229-ad7944-mainline-v4-1-f88b5ec4baed@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 10:25:50 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

One trivial comment. If this is all that comes up I can tweak that whilst applying.

Jonathan

..

> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ single, chain ]
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +
> +      When this property is omitted, it is assumed that the device is using what
> +      the he datasheet calls "4-wire mode". This is the conventional SPI mode

Stray "he"?

> +      used when there are multiple devices on the same bus. In this mode, the
> +      CNV line is used to initiate the conversion and the SDI line is connected
> +      to CS on the SPI controller.
>


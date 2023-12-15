Return-Path: <linux-kernel+bounces-1583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2E4815078
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D74D1C23C14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FF4644B;
	Fri, 15 Dec 2023 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8l3aiKs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488A45C12;
	Fri, 15 Dec 2023 19:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78C9C433C9;
	Fri, 15 Dec 2023 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702670307;
	bh=WktlHPcDnXFuW2QURC0LlGsjDQwWzmThP/asKuQf/t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8l3aiKssMpKyMvn5xx8gismsYfjStPiWAB0Rqt6SNXgJ0YaExPFtOBYxNfxlzU8p
	 E8kZqYFunlnb8bkOPXZhGYnVwWYCBOWoeiDincON0PZi/FyiZAz4bjpTnPg21PMz6k
	 tG0b5+8SVP/iE8v+WC5fjSgYpdt1o6V3A5UngM2TC/jrP5yKWlzEVeMfg9QVxBitRU
	 Ei9Nx8Sy/T4STNhyBEyV8dZ8rN2DJq8qlRSd59kSHRGPcGIP5eNmU+Qhjue5hq3llO
	 lwFsuKRVSmSGPkogoPhukujgF8fuVfJCAixZuHDDfwQZfzn68NtFxQP3eq65Z/7fsK
	 hPYXYNqynH2WA==
Received: (nullmailer pid 294181 invoked by uid 1000);
	Fri, 15 Dec 2023 19:58:24 -0000
Date: Fri, 15 Dec 2023 13:58:24 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
Message-ID: <170267030121.294057.12194823106863106161.robh@kernel.org>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
 <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>


On Fri, 15 Dec 2023 04:32:02 -0600, David Lechner wrote:
> This adds a new spi-rx-bus-channels property to the generic spi
> peripheral property bindings. This property is used to describe
> devices that have parallel data output channels.
> 
> This property is different from spi-rx-bus-width in that the latter
> means that we are reading multiple bits of a single word at one time
> while the former means that we are reading single bits of multiple words
> at the same time.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> The rest of this series is ready to merge, so just looking for an ack from
> Mark on this one.
> 
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



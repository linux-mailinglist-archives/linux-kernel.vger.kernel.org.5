Return-Path: <linux-kernel+bounces-27055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B382E9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E76D1C23059
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8810A2B;
	Tue, 16 Jan 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bKPsEzxb"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE310A1B;
	Tue, 16 Jan 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8AD8FF804;
	Tue, 16 Jan 2024 07:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705388978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUvUcReGBkElI2bmZKIO4xQ6SjA4NJ7bZ4nmKyK7rFY=;
	b=bKPsEzxblr3OEfqCH5RxNFVqs9iTZyN9I7oFT2CKPJSeJx0AB+NoP4uHsoOcTfMU/A2fjt
	OzM2OXeg4hrs+cc0MRlgJG0bF2LTDQHBlwrhTqMHrLXVWcwguKPo3SOsxF348wksayN09+
	uJ2ehU5VT4RD20/jFueTGl0rDIZRy6RlwrNyi0kIjPzpDuyLAgmKMdtiUcRmTZ/zLRn4fc
	rPWHfHFXXHzCcwX13w6fiXq0ypvp5vZnZPiiiGsNBh8SLJQLNIiV1wD3T2isJAgePMrnET
	Fq3GxDjvsCDvgG2LR/qU6EQ/lFQPaqgXvl5xfzTKbNuQv3SMJkqfdM0Q2l63IA==
Date: Tue, 16 Jan 2024 08:09:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: dt-bindings: Do not override firmware-name $ref
Message-ID: <20240116080937.3f66ee0b@bootlin.com>
In-Reply-To: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
References: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Krzysztof

On Mon, 15 Jan 2024 19:20:17 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,easrc.yaml        | 4 ++--
>  Documentation/devicetree/bindings/sound/infineon,peb2466.yaml | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
[...]

At least for the infineon,peb2466.yaml,

Acked-by: Herve Codina <herve.codina@bootlin.com>

Thanks for this patch,
Hervé


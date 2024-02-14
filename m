Return-Path: <linux-kernel+bounces-64948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BD854508
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7971F2C5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83412B6A;
	Wed, 14 Feb 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXREtOAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B012B60;
	Wed, 14 Feb 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902575; cv=none; b=RVmyo+hje+3GTDlAGmhwQ3/bcSsiWvBKqDA9hADVUG6HAxMFpqHzmFNCyGTYAtjTTgHkv8WtNQYbPIXWNlgqxwCc6genKZbiANWsfZ7xN5Cj7bRJ9Lk8AWHZZuSmyQPYxTZmSwJU9ITTQVQnK4qYJxalAnLP+ViDBfPXpNPAfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902575; c=relaxed/simple;
	bh=WCHyzEMYsmkXeKhRjOyGsH4SWHf2Zvhc93CpPJCsZ70=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=sb7fNq3ci6+/8x7F3trFoAopuLkFL06uG/rWRjABHGBwNtdf1zTYtdHfHMhuRsHPYdYe0wTSuaeZ4OlPm+NXVlo3b9XWVx/9bX5/7QqsxyNHYgumq8s/BBZHE69P1y2eOedXMnu7tJ8uq1AZbrdOxcJojirC798QVrVbUJgu9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXREtOAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F1C433C7;
	Wed, 14 Feb 2024 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902575;
	bh=WCHyzEMYsmkXeKhRjOyGsH4SWHf2Zvhc93CpPJCsZ70=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sXREtOALLSk9HLU/IAkBc01Hi9HoDS6Or5Sv/JMYpiKFgjkf4xdspqPQGqomiYxx5
	 sxP35EhvKauE8uaveXi5cS95yAP+lYX9o6/0qZTE+6tJO9q/t+yDkCi/VAluBT2zWV
	 cCrcJ2ODMKPizw3HZ2OhChXVBvhxP3PpQor4m1akf9gHQ68SftBeCa/1txMmLcx4Uc
	 FsxTu5hCf/edc1IXOClP9fmCJgRiiCzRhjpvoTgjeuuIShtxgS3/j7nX/nbN1CorHs
	 VldjhSBRZRuJVzQhmponH0NXjJ8r3p0Km2t4aDMLZ0QigKFVT2JEj4DcpiFLaS6vuG
	 yR1WPHXGFGKJg==
Date: Wed, 14 Feb 2024 03:22:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, alsa-devel@alsa-project.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Mark Brown <broonie@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 linux-sound@vger.kernel.org
In-Reply-To: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
References: <20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com>
Message-Id: <170790257251.233964.609546720299928474.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: sound:atmel-at91sam9g20ek: convert
 bindings to json-schema


On Wed, 14 Feb 2024 12:10:06 +0530, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 60 ++++++++++++++++++++++
>  .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 ----------
>  2 files changed, 60 insertions(+), 26 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml:26:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/atmel,at91sam9g20ek-wm8731.yaml:27:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



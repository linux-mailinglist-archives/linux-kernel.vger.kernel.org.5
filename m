Return-Path: <linux-kernel+bounces-78795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772D8618EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832AB1C241E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF85012C536;
	Fri, 23 Feb 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsK4nZ6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97212B177;
	Fri, 23 Feb 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708292; cv=none; b=DzaXB09YXvnM2aaH6FE5WSYxmOE0qNN5MkOIOUWuu9vtEorB0ZSEomA4Lebv/sJo7jCjbd0oxWezKn+fD+OWmInfpSAXtospH+7/MW8WtcB/CW2vVIwNuSFpSEiYLtYSeIzjDjHknv4wOFdXgFBmliJHminlBRsraaHeOoVXOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708292; c=relaxed/simple;
	bh=t5HCx4cvs0gthNnbExRKTIw8NVyKOY2gSVioN6v9/n4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PjV+YXDD/kBcbPP+j4xCiUQVmV+mJnflevCZKRNctogXp+KIVP1/BOn1fZsAU3M6RFTd9fLt6DDgrN+HL122lK3qWQM3yckHFKJHc6ghtr5uHGYgTKxSPmznxV4NflPOjBfs4rGZDUsdC1mqx+Fobg2qO9P/HvxBhd5qF0n5v4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsK4nZ6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D6BC43390;
	Fri, 23 Feb 2024 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708291;
	bh=t5HCx4cvs0gthNnbExRKTIw8NVyKOY2gSVioN6v9/n4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jsK4nZ6ECzmXipw9oRr58YOdR+jTrlFEDKMiA6G6E7iKpLfcWyenpbvJlVPvyuqCz
	 KxjJsBwJUtf1d7491WyRrcLFcJ/iRYCmq89nbXBBTA49uh3tD77r+YOj2SW2/PemRU
	 DXX/Z7aE2uGCd7ds6EawPpftsV+vGaIV1nl/du8uZ/J4Vrben6inJ3+Q6o1k1n4Byu
	 wQEjbJjaqVLTN83qLNYbfTdL4Sihz81z5SZg82xUpAqZz809VJdt/MrGxI03f8hamD
	 iZO1lebclGp4PD8GoCGnK77KRZ9PdTSKDtDjPv/OE60SQMLsnaudykVDtGBjOSKfpB
	 dZI33GGdRH3DA==
From: Lee Jones <lee@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>, 
 Balakrishnan Sambath <balakrishnan.s@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240223-b4-sama5d2-flexcom-yaml-v2-2-7e96c60c7701@microchip.com>
References: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
 <20240223-b4-sama5d2-flexcom-yaml-v2-2-7e96c60c7701@microchip.com>
Subject: Re: (subset) [PATCH v2 2/2] dt-bindings: mfd: Convert
 atmel-flexcom to json-schema
Message-Id: <170870828885.1762468.16286629959924191287.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:11:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 23 Feb 2024 14:46:23 +0530, Balakrishnan Sambath wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> 

Applied, thanks!

[2/2] dt-bindings: mfd: Convert atmel-flexcom to json-schema
      commit: fddc5d727e4503481db8dce243ad7355c40f45db

--
Lee Jones [李琼斯]



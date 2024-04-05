Return-Path: <linux-kernel+bounces-133251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0132B89A13D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008BF1C23718
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262416FF31;
	Fri,  5 Apr 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EEXXnvfl"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520A16F85A;
	Fri,  5 Apr 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331057; cv=none; b=pTTgC17zeovay7u9OXZfZpeIu9+nWPcaOr83Jq7v08W/NTwMv1q169jekf+XbJhczxKyinSqqln+dp8IywXZxLTW7PWsW8COgyWedOR5FicZlAgseQNhG6VXDX79chyoyE+9mXVYxuoj+sse4Wps9YPnYjMsSX9T7x/hZv4nW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331057; c=relaxed/simple;
	bh=sMNJIxBprxubhaye0IIgUc67P+qbDko1VoABUsSnzLk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SDR/u2fOcJ+3nNBaUAOIC66Sqptfde3qT7D0+CQpGFTaeFIZ9Qtu33bpKGykRVc8AHPUt5tvEerWS8JH6N5O2Cu8bPKRsDnPoN3RBkHVjUapkefjvrHVwE5p6Ormnbrb6qSrKh5ACNV6esnRH4FpEhQf6/XdTGZVhVS2VRel5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EEXXnvfl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32547FF805;
	Fri,  5 Apr 2024 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712331047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7b788CjK3FnCFFobILff+QLbjBhrb4RBIAYgwhlFDXs=;
	b=EEXXnvflfhiQ9MbzcRVhPb0/yry6uUKXweIpal43BcouwwWH3gkOwZfPJkXJkoO/eL96OA
	0940EHWPnzpPNq5/+pGw2Wt1knW5fINQBj+dulrpMMtf75NQCWhWb0PRqbDai6wKVkJbr3
	nYfzAwWUYGH+3J/EbTAleGeeu9tVS0ZFkB/uKqMf+eotQFTElTfT/Uc02mIfjm9BbN7XOy
	D16xyjHtuLh96zwaDry97wNls4nU8JZSZG7LxsJy2pGRILvP8Ieorkb1ATSMoGP/mJo3gq
	C9tf/tR3hLqHcXhGebfpxOQgne7D234N1lr5aPCAmJ041L0iJectYrGvw0eodg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Apr 2024 17:30:45 +0200
Message-Id: <D0CAP2UDPY4N.1TX594UI2CAN6@bootlin.com>
Subject: Re: [PATCH v2 00/11] spi: cadence-qspi: add Mobileye EyeQ5 support
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Mark Brown"
 <broonie@kernel.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Vaishnav Achath" <vaishnav.a@ti.com>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

On Fri Apr 5, 2024 at 5:02 PM CEST, Th=C3=A9o Lebrun wrote:

[...]

> Changes in v2:
> - Rebase upon v6.9-rc2.
> - Fix dt-bindings commit subject tags.
> - Take Reviewed-by: Krzysztof Kozlowski on dt-bindings commit.
> - Add dt-bindings commit to order compatibles alphabetically.
>   adding EyeQ5 compatible can be taken alone easily.
> - Drop patch taken upstream:
> - Add To: Rob Herring, following get_maintainer.pl recommendation.
> - Link to v1: https://lore.kernel.org/r/20240308-cdns-qspi-mbly-v1-0-a503=
856dd205@bootlin.com
>
> Krzysztof: unsure if you want this. It is second so that commit
> spi: cadence-qspi: switch from legacy names to modern ones

Sorry for the weird formatting; b4 saw those two lines as trailers and
moved them last I guess. Proper formatting is:

Changes in v2:
- Rebase upon v6.9-rc2.
- Fix dt-bindings commit subject tags.
- Take Reviewed-by: Krzysztof Kozlowski on dt-bindings commit.
- Add dt-bindings commit to order compatibles alphabetically.
  Krzysztof: unsure if you want this. It is second so that commit
  adding EyeQ5 compatible can be taken alone easily.
- Drop patch taken upstream:
  spi: cadence-qspi: switch from legacy names to modern ones
- Add To: Rob Herring, following get_maintainer.pl recommendation.
- Link to v1: https://lore.kernel.org/r/20240308-cdns-qspi-mbly-v1-0-a50385=
6dd205@bootlin.com

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



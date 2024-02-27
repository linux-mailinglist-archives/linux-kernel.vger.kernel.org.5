Return-Path: <linux-kernel+bounces-83596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BA869C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D37D1C22734
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606F1487FE;
	Tue, 27 Feb 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rpr67OC1"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A11487D8;
	Tue, 27 Feb 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051164; cv=none; b=RAaFqNeKTHcoga0NmqTc/Fc1HMUY5kcPxJnA8ODVwzqL/c6ZMxLI4CklrZLfB4Gd0GVPzhyBdFl5UwHmFfLxds4GHdqZTVroCqKWEftPiA7YLMe0gTRE9QM610Yr2bkbm6602ZUcTFbzP9khKlxSovrucbiCvf4QLx4qRxwJhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051164; c=relaxed/simple;
	bh=0IOZC4PA4LjZ43fvl+0/P7+zntPaeuYpVR/JDgMNoXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Os7ROm/3k64+xkuliLYqEbcY8X4ignfxoenm9GHN+YrDngkmGG58gQA2fnmV7c6XCZwsgN5qNI+OOu0S1HfjzHwBwxoi3D/ggKrtmYUE85QvXafiPQ0yADOL7djOanBXfM7YjIeGkT0Qp5BOf59kRXzxFpYS0UQByj26Nwp9rFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rpr67OC1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BBC97240010;
	Tue, 27 Feb 2024 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709051158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EL5MTBosVVpIu4g1wb/cAbzOuqrbIGwThm3GnF6MkU=;
	b=Rpr67OC1kRV904+6zCmMNThxo+4lX0RuA05YUSCsxPgZpJqnPom867O6bpfxMhFT6Yltsn
	B//pM+2XaXNfouWq45mJrypBW1Bh8wkCjA7vIB2AVyh8ojgmrAE8x18GvaP920C5gLr/i5
	aYEyo3Ksc2s0ukh/U4tqI8yGiMqxrYEGL56cphIXiqP6QfM/VJGmX76C1PN3Z6cj+cJNeq
	BigspfVeLFEbaDd1oacroFL+YC9e8p+mGcp66xxH3KtjTtcs8XpskZAVRK7EqMMdv0m5t0
	Bl21c9JFSiGphOuRXfJaTmGUf0REI1iXi3x9WQPx45I/OZCoD39Wt7R4WtDXRQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
Subject: Re: [PATCH v5 00/10] dt-bindings: marvell: a38x: add solidrun
 armada 388 clearfog boards
In-Reply-To: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
References: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
Date: Tue, 27 Feb 2024 17:25:56 +0100
Message-ID: <874jdtkh63.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hello Josua Mayer,

> Dear Maintainers,
>
> The initially merged device-tree for Clearfog GTR devices contained
> various subtle mistakes and omissions:
>
> - missing board-specific compatible strings
> - missing pinctrl entries
> - missing second sfp connector
> - invalid sfp loss-of-signal gpio
> - mismatch of labels between dsa ports and enclosure
>
> Most notably this had caused functional issues with the sfp connectors.
>
> This patch-set first converts the existing armada-38x dt-bindings to
> yaml, replacing invalid soc-only compatibles with specific boards that
> already exist in tree and represent the three SoCs (380,385,388).
>
> Secondly for clearfog gtr pinctrl nodes are added for all referenced
> gpios for independence from bootloader defaults. U-Boot is shared
> between armada-388 clearfog and armada-385 clearfog gtr.
>
> Further remove an invalid io from the first sfp connector description,
> and add descriptions for the secondary sfp connector which is driven
> by dsa switch port number 9.
>
> Finally labels of dsa switch ports were updated to match the enclosure.
> That patch is not suitable for stable.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>


Rebased on v6.8-rc1, fixed merge conflict and applied on mvebu/dt

Thanks,

Gregory

> ---
> Changes in v5:
> - remove empty lines between description and items yaml entries
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - bindings text to yaml conversion is now single commit
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - added bindings for some existing a380, a385 and a388 boards
> - removed code from commit description
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - Link to v4: https://lore.kernel.org/r/20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com
>
> Changes in v4:
> - dropped invalid soc-only armada-38x (txt) bindings
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - add bindings for armada 388 helios-4
> - updated yaml whitespace indentation count
>   (reported by Rob Hering's bot)
> - Link to v3: https://lore.kernel.org/r/20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com
>
> Changes in v3:
> - armada-38x.yaml: removed '|', no need to prerserve formatting
>   (reported by Conor Dooley conor+dt@kernel.org)
> - update commit descriptions to clarify confusing board names and
>   compatible strings
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - send to all relevant lists
>   (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
> - remove duplicate binding for clearfog / clearfog
> - Link to v2 (patches 0-2):
>   https://lore.kernel.org/r/20231224143750.5604-1-josua@solid-run.com
> - Link to v2 (patches 3-8):
>   https://lore.kernel.org/r/20231224143850.5671-3-josua@solid-run.com
>
> Changes in v2:
> - removed changes changes to gpio numbers because they were wrong
> - added bindings documentation
> - Link to v1: https://lore.kernel.org/r/20231223212930.14624-1-josua@solid-run.com
>
> ---
> Josua Mayer (10):
>       dt-bindings: marvell: a38x: convert soc compatibles to yaml
>       dt-bindings: marvell: a38x: add solidrun armada 388 clearfog boards
>       dt-bindings: marvell: a38x: add kobol helios-4 board
>       dt-bindings: marvell: a38x: add solidrun armada 385 clearfog gtr boards
>       arm: dts: marvell: clearfog: add pro variant compatible in legacy dts
>       arm: dts: marvell: clearfog-gtr: add board-specific compatible strings
>       arm: dts: marvell: clearfog-gtr: sort pinctrl nodes alphabetically
>       arm: dts: marvell: clearfog-gtr: add missing pinctrl for all used gpios
>       arm: dts: marvell: clearfog-gtr-l8: add support for second sfp connector
>       arm: dts: marvell: clearfog-gtr-l8: align port numbers with enclosure
>
>  .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 -------
>  .../bindings/arm/marvell/armada-38x.yaml           | 70 ++++++++++++++++++
>  .../dts/marvell/armada-385-clearfog-gtr-l8.dts     | 38 +++++++---
>  .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |  2 +
>  .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 84 ++++++++++++++++------
>  arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  5 +-
>  6 files changed, 167 insertions(+), 59 deletions(-)
> ---
> base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
> change-id: 20231226-support-clearfog-gtr-l8-sfp-d87ae715a787
>
> Sincerely,
> -- 
> Josua Mayer <josua@solid-run.com>
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com


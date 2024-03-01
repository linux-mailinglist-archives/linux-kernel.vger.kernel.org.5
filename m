Return-Path: <linux-kernel+bounces-88660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99186E4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6DD1F23DB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172670CAE;
	Fri,  1 Mar 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eaQFp5bZ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107338DC3;
	Fri,  1 Mar 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309115; cv=none; b=eL6/Vw27B2wp+mwIK+cbXj+AaVm1HQy8zOQF4xJxl3ZIWtCWMfS6ZQs9yw+8pzMbb/WfepGEyMOWQG4ktyRQ6Byzvf3g7qZVKyV88oJ8UCVoz5VHR2PHbo7lLDkzaS78tFWEqOCghq5kZDjRMIxAA7jNTD/jnuukns1ptvSTQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309115; c=relaxed/simple;
	bh=GdiD6GetYQ7plMbY7Z0t9eGPdeIDnAI9+mc+CerOGzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRy0dqbU5TEspWf1UeVKmVg3nAvYZYuDCR00uZGWZK1DgFcnxh+IgzkNfYVGJMLCCMOhzXqFm//iSl2r6MSFRDqXOqp3oExcY/+8zZYjIMM1SlaVfTUL9Z3KtX0jSHuBLAna3Or4AzSbFgkWFAK1DdlbIPPpy7Tfe4m2zwRHs50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eaQFp5bZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95E3824000A;
	Fri,  1 Mar 2024 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709309110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zelpl9Plgt9LUl8SLGJpDVPo1sGxGYnWY3UETmUttgY=;
	b=eaQFp5bZScbGwpgadNiS1YbG9levV0au38YUoIL0hxygwV7g6FeLLeW96RsgM2JSK5/y/v
	IuCyA/Uvy9RhUykUMzyHdX2sgVoaCwGHteXQclYrhITtGzJOMUov52/XHPBOPSkV/GSbCB
	Wdmx1iozjOr2wkzXLy5PlzSWYmJni6Rr4WFJWzpNtnLXMXlqu0fvj+gm/VmlOVzhDX98Ch
	8jGtXh86+iVXDMVRzC91FwJrUBqzt/5jEGy3DZEUJ30aOVDoeq7iTj7tefQaFWSuRO8ig4
	OFRefvZWHEGSzHjLQ8YYJYMjHLCghOIQV8v1JDJ1TW/teic2A7i5MmwAix6yrQ==
Date: Fri, 1 Mar 2024 17:05:08 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com, mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v9 0/3] Input: Add TouchNetix axiom touchscreen driver
Message-ID: <20240301160508.GA190983@tpx1.home>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
X-GND-Sasl: kamel.bouhara@bootlin.com

Le Fri, Mar 01, 2024 at 11:39:05AM +0100, Kamel Bouhara a écrit :
> Add a new driver for the TouchNetix's axiom family of touchscreen
> controller. This driver only support i2c and can be later adapted for
> SPI and USB support.
>
> Kamel Bouhara (3):
>   dt-bindings: vendor-prefixes: Add TouchNetix AS
>   dt-bindings: input: Add TouchNetix axiom touchscreen
>   Input: Add TouchNetix axiom i2c touchscreen driver
>
>  .../input/touchscreen/touchnetix,ax54a.yaml   |  62 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   7 +
>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/touchnetix_axiom.c  | 669 ++++++++++++++++++
>  6 files changed, 753 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,ax54a.yaml
>  create mode 100644 drivers/input/touchscreen/touchnetix_axiom.c
>
> --
> 2.25.1
>

Above is the missing changelog:

Changes in v2:
 - Add device tree binding documentation
 - Move core functions in axiom_i2c as we only care about i2c support now
 - Use static function when required
 - Use syntax dev_err_probe()
 - Add an hardware based reset

Changes in v3:
 - Remove irq-gpios property in dt-binding
 - Use a generic node name
 - Fix issues reported in https://lore.kernel.org/oe-kbuild-all/202310100300.oAC2M62R-lkp@intel.com/

Changes in v4:
 - Cleanup unused headers and macros
 - Use standard kernel type
 - Namespace structures and functions
 - Use packed struct when possible to avoid bitfield operators
 - Fix missing break when address is found in axiom_populate_target_address()
 - Split reads in two steps for the reports, first length then report
   itself so we only read required bytes
 - Get poll-interval from devicetree
 - Add VDDI/VDDA regulators
 - Add a startup delay of 110 ms required after VDDA/VDDI is applied
 - Remove axiom_i2c_write() as it is no more used

Changes in v5:
 - Fix wrong message constructed in axiom_i2c_read
 - Delay required between i2c reads is >= 250us
 - Do not split report reading in two phases as we'll
   have to wait 500us
 - Use lower-case in properties names
 - Make regulators properties are required in dt-binding
 - Fix bug report: https://lore.kernel.org/lkml/202312051457.y3N1q3sZ-lkp@intel.com/
 - Fix bug report: https://lore.kernel.org/lkml/6f8e3b64-5b21-4a50-8680-063ef7a93bdb@suswa.mountain/

Changes in v6:
 - Fix missing unevaluatedProperties.in dt-binding
 - Use __le16 to correctly deal with device endianness
 - Use standart kernel types s/char/u8/
 - Use regmap api as driver might support spi later
 - Use get_unaligned_le16() for the sake of clarity
 - Use devm_regulator_enable_optional()

Changes in v7:
 - Remove startup time from dt-binding
 - Fix usage table not correctly populated

Changes in v8:
 - Fix missing call to input_report_slot_state()
 - Fix issue reported in https://lore.kernel.org/oe-kbuild-all/202402020623.8T1Ah513-lkp@intel.com/

Changes in v9:
 - Fix issue reported in https://lore.kernel.org/oe-kbuild-all/202402201157.BKo97uWl-lkp@intel.com/
 - Rebase on v6.8-rc2

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


Return-Path: <linux-kernel+bounces-85162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3713D86B151
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAA71F255B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7E1552F8;
	Wed, 28 Feb 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gmI4s1wk"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F514DFEC;
	Wed, 28 Feb 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129397; cv=none; b=VJQUzlpbFSwGyMaVEDjsUjY49uPmmSsctAYi5IM5bWI93Ro1XMcQyTjLeYKUjuLRgfIMGAXqsF03rL3IvxyJPsTatqxn2uSNYqTKohuRNdNXqBvXfc2N/pLSj2PbnV+XBIFCwFKxXlgGD5HJsoTOTzxCDKQf5LKlsEd+779iatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129397; c=relaxed/simple;
	bh=zi3a7WfmF7xz9jF+a+/dTYIv2tudbxNO9bYJhYApnzc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ajEOHRkffrt/F2X/SoI1MjMkEjMaZjYuIdu1P873YJnNLhyeLagWBoSHOHEScm1mCzRmZhhQ7UNxRGuXAan9NG1vf9/QZ/zWckWOEiSZXC+MwG9FKuKASzRTTq/599j/ZrPFLxZbJciLLUSanF87oaHI7szU3najZtWxOE5wlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gmI4s1wk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76AFA40005;
	Wed, 28 Feb 2024 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709129387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puqEcgLYqO4kSzlmDT1lfSiSE31NVMpyJtiG4ww78PM=;
	b=gmI4s1wk+Tj5gPLF+YDaTM6UQxYm/c92oIwgbV6hRXLmPx4jzrmTbMiScHOJqapnckd/tX
	L65N6a5jBnPnMjnBhY4qEgnTFtroYXRWBbi44BuZ0ZWTNoQeyty89WLqRhRp9nKUsHTY/e
	s76HPhEhrbPhVkTI14tBc3L/a8yqJ62Vba+3yCJ0wsi3xD6h32OIdsOOC5TbXqWjIZHPq/
	WCff3oNNpJp4/f9AC8U49kH2hcRgwgBtDfEiObN9pfHxGYn+Cm0NuSddNSUY1u/073HNEQ
	rlpq4rNOOpbJNeLhpW0QyiOVqhmDLKncD93HCaZ+pDXpnprhYrrNNzJT+dPzFw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 15:09:46 +0100
Message-Id: <CZGRSWQT1FZ0.2YQ0R8UD86L2U@bootlin.com>
Cc: <linux-gpio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Stephen Boyd" <sboyd@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>, "Philipp
 Zabel" <p.zabel@pengutronix.de>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Michael Turquette" <mturquette@baylibre.com>
To: "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 02/10] dt-bindings: soc: mobileye: add EyeQ5 OLB
 system controller
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-2-c57fbda7664a@bootlin.com>
 <170905191234.4042659.13935993184407860612.robh@kernel.org>
In-Reply-To: <170905191234.4042659.13935993184407860612.robh@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Tue Feb 27, 2024 at 5:38 PM CET, Rob Herring wrote:
> On Tue, 27 Feb 2024 15:55:23 +0100, Th=C3=A9o Lebrun wrote:
> > Add documentation to describe the "Other Logic Block" syscon.
> >=20
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 94 ++++++++++++++=
++++++++
> >  1 file changed, 94 insertions(+)
> >=20
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/s=
oc/mobileye/mobileye,eyeq5-olb.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/cl=
ock/mobileye,eyeq5-clk.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/s=
oc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: clock=
-controller@2c: False schema does not allow {'compatible': ['mobileye,eyeq5=
-clk'], 'reg': [[44, 80], [284, 4]], 'reg-names': ['plls', 'ospi'], '#clock=
-cells': [[1]], 'clocks': [[4294967295]], 'clock-names': ['ref']}
> 	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eye=
q5-olb.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/s=
oc/mobileye/mobileye,eyeq5-olb.example.dtb: system-controller@e00000: reset=
-controller@0: False schema does not allow {'compatible': ['mobileye,eyeq5-=
reset'], 'reg': [[0, 12], [512, 52], [288, 4]], 'reg-names': ['d0', 'd1', '=
d2'], '#reset-cells': [[2]]}
> 	from schema $id: http://devicetree.org/schemas/soc/mobileye/mobileye,eye=
q5-olb.yaml#
> Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example=
dtb: /example-0/soc/system-controller@e00000/reset-controller@0: failed to=
 match any schema with compatible: ['mobileye,eyeq5-reset']
> Documentation/devicetree/bindings/soc/mobileye/mobileye,eyeq5-olb.example=
dtb: /example-0/soc/system-controller@e00000/clock-controller@2c: failed t=
o match any schema with compatible: ['mobileye,eyeq5-clk']

This series depends on 4 patches from previous revisions that got taken
into clk-next. Those are v6.8-rc1..clk-mobileye on the clk remote [0].

Without the 4 patches I've reproduced the above warning; it disappears
once they are applied.

Have a nice day,

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=
=3Dclk-mobileye

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Return-Path: <linux-kernel+bounces-30162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758DA831AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37827287D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5172560F;
	Thu, 18 Jan 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Cp+PxdUJ"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B024A0B;
	Thu, 18 Jan 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585398; cv=none; b=de1HJWL55+QTPYA0L4l8GF5+scjNsx/0FQ2oWByJw7FEHIg/+Q1Utj9dST85HUbhIC2/EWve6b5jhV/7DKTaqm/i230+BEIO305ojqIxXlJtcetTF01HGyZmPXsL6vlqsuZJXgm1hGpbA7vI6d3bTIhrx+kVTm/uEmp3Ann7dTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585398; c=relaxed/simple;
	bh=Ja9BoTNSArKJ+F58kV7azM46qj6/hpbKD7iIT+NTPeI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type; b=jB3cjCyj2rnMkF1CrU7hLz1LpbUzJWqLrGzkt9ugyIVNQnmDFIa/DG5FwRs66YjMR1TisMO1/3Pym+6iY4utCB54YafMxAiw5FrnyvblUJOMEE7LbfvjLxNR3Z4jxXzDg0yJDILUxXlRwBaCZIpInq5BnCCaLSWLlZ8M3J4O1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Cp+PxdUJ; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQSfn-0004uE-Cn; Thu, 18 Jan 2024 08:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=efuuIR75Ne4gKzieuxB6GvMLRG+XlSIaY1YCAUIZ41I=; b=Cp+PxdUJgklim1u1yQzh
	lAjlcVHem0BTU2KRX7KFjrght1MTX21VTE3dmGgvxnfzdkJLElplkm9kPTbpY66pVtoHeyIhkVnkw
	94O3lDor6XvajCmWc0/MjWDvhXUCoGx65vqOEJipZkM3k5Eyvh+lV53ssImg1I9ldXLsPbLJ/oc01
	taG0QsaKxKkzk4/WYmVbEiyiO5V4pR/5ZYuLSb0C5BhU50iizWlpDKqJEVZGkdoJQEQ2SIdSVUpsU
	4AA8RiRj+mdgBo3FG/Txlv+ugq12eBqJdMV/CyAN/kHUqu2+yUk389/9BJ+zFJSGcLO8Ot3bX403Q
	vfrnyndX3/nCyQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Conor Dooley <conor@kernel.org>
Cc: Primoz Fiser <primoz.fiser@norik.com>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  Stefan Wahren <wahrenst@gmx.net>,  Christoph
 Stoidner <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  upstream@lists.phytec.de
Subject: Re: [PATCH v2 2/2] arm64: dts: imx93-phycore-segin: Add Phytec
 i.MX93 Segin
In-Reply-To: <20240118-regretful-viewer-8d7dfc7a0802@spud> (Conor Dooley's
	message of "Thu, 18 Jan 2024 10:19:23 +0000")
References: <20240117074911.7425-1-othacehe@gnu.org>
	<20240117074911.7425-3-othacehe@gnu.org>
	<c1ef5c08-1ae9-4a22-8ca9-47673c023e1e@norik.com>
	<20240118-regretful-viewer-8d7dfc7a0802@spud>
Date: Thu, 18 Jan 2024 14:43:07 +0100
Message-ID: <87jzo6vjtg.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hey,

> Please do not order properties alphabetically. Instead, please read
> the new documentation on property ordering that makes explicit what
> has just been convention until now:
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst?h=for-next&id=83a368a3fc8ae8538bccb713dc0cae9eacc04790#n112

Thanks for the link.

I have a question though. Regarding that section:

--8<---------------cut here---------------start------------->8---
/* SD-Card */
&usdhc2 {
	pinctrl-names = "default", "state_100mhz", "state_200mhz";
	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
	bus-width = <4>;
	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
	no-sdio;
	no-mmc;
	vmmc-supply = <&reg_usdhc2_vmmc>;
	status = "okay";
};
--8<---------------cut here---------------end--------------->8---

The documentation states:

--8<---------------cut here---------------start------------->8---
Order of Properties in Device Node
----------------------------------

The following order of properties in device nodes is preferred:

1. "compatible"
2. "reg"
3. "ranges"
4. Standard/common properties (defined by common bindings, e.g. without
   vendor-prefixes)
5. Vendor-specific properties
6. "status" (if applicable)
7. Child nodes, where each node is preceded with a blank line
--8<---------------cut here---------------end--------------->8---

All of the properties in my example are falling into the "4" category I
guess, except for "status" that should come last. Now, how am I supposed
to order those properties? I had a look to other IMX device trees and it
is hard to establish a pattern. Pinctrl first, then alphabetical order?
Anything else?

Thanks for the guidance,

Mathieu


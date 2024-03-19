Return-Path: <linux-kernel+bounces-107527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3B587FDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A3E283FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BD5813F;
	Tue, 19 Mar 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YS75RVrQ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1525A4C7;
	Tue, 19 Mar 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852073; cv=none; b=b+WfVWvEbaexoSyU4MMPYfEp3dwHWPrNLlN7+3eJswpMMwA2I0g6eZXSoT77jCU+7Gz7lT38MYyVB+ogrOj9DBl8E4UIbFh6YcdObhgXlGmXtq8RcuJrPtVXYXYXZOC9MUzf/zy2U1bcDMCNZUnsnDg1NlkMwVroITIQcmtLjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852073; c=relaxed/simple;
	bh=GrOBN+jSBZcF9nUlKAzK4ebUgJNLCytGla0/AzR1dkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQk/e76j0mcWacPxweT27Q9a1fe9ylPFm2dSS52cJqFVytlKbJn/nY5fywIlh75g7KsgRpjS9h7OUPKxIHqjzELnBwgL5q3yXRUDw13nIWdeRviXG4RWwcXyU61FvaqupLchoZf481MSjFg+6zPllhS+oheuFafQsM2Y4eek+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YS75RVrQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 19DAF1FE22;
	Tue, 19 Mar 2024 13:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710852061;
	bh=0qZGsVKIae4qmkuLNwqJ6ZjQTeE2rCbR5WVNuV1x93g=; h=From:To:Subject;
	b=YS75RVrQSWd1FtU2qy5WyArZ4+QuY0XtFTlKvhf1dLNjMGtsaww8yVxEo+PRa040G
	 30sFZixixFqk3QoE/55h8U6vR+i2Uq5u+YYGcKppYc/2fcglE3j/iwDl3nOypaaPrq
	 pV9EBagJh39FaKs60QzKVBfStu/fHzSTYtBmjHGqlsNYehJgrlPioHfIBllGiVixFV
	 BQSG7jKPYzc0d0KbxNWA/qjaHsE2DTt3qqCnTIIRJKw8Akw0VVdoHtTOrKXvMwMads
	 OLjC6Va7+pap1eGCsBRC3jyv05TGx8RQTLue3vsV0FT3BoPLRA7ZbYuhmvpR8owL/V
	 T9UOmuOoLY8sg==
Date: Tue, 19 Mar 2024 13:40:56 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Silva_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Message-ID: <20240319124056.GA13970@francesco-nb>
References: <20240312144956.40211-1-francesco@dolcini.it>
 <20240319120717.e2p65ricusxuz3wm@subatomic>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319120717.e2p65ricusxuz3wm@subatomic>

Hello Nishanth,

On Tue, Mar 19, 2024 at 07:07:17AM -0500, Nishanth Menon wrote:
> On 15:49-20240312, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > TI SDHCI IP has a hardware debounce timer of 1 second as described in
> > commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
> > debounce timer"), because of this the boot time increases of up to 1
> > second.
> > 
> > Workaround the issue the same way that is done on
> > arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts, using the SD1 CD as
> > GPIO.
> > 
> > Suggested-by: Nishanth Menon <nm@ti.com>
> > Reported-by: João Paulo Silva Gonçalves <joao.goncalves@toradex.com>
> > Closes: https://lore.kernel.org/all/0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com/
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > index e8d8857ad51f..a9bf2c17f95a 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> > @@ -1441,8 +1447,10 @@ &sdhci0 {
> >  /* Verdin SD_1 */
> >  &sdhci1 {
> >  	pinctrl-names = "default";
> > -	pinctrl-0 = <&pinctrl_sdhci1>;
> > +	pinctrl-0 = <&pinctrl_sdhci1>, <&pinctrl_sd1_cd_gpio>;
> > +	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> >  	disable-wp;
> > +	ti,fails-without-test-cd;
> >  	vmmc-supply = <&reg_sdhc1_vmmc>;
> >  	vqmmc-supply = <&reg_sdhc1_vqmmc>;
> >  	status = "disabled";
> 
> Minor style comment based on recently added https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
> ti,fails-without-test-cd comes after vqmmc-supply and above status.

Whoops, you are right, of course, thanks. I'll send a v2 once the merge
window closes and rc1 is out.

Francesco



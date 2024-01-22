Return-Path: <linux-kernel+bounces-33111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312C8364BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3B288A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63213D0BE;
	Mon, 22 Jan 2024 13:49:09 +0000 (UTC)
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6433D0B4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931349; cv=none; b=F8wKSAPp/0gVYUkkEr0rjRsW9fIm56nF1wHc4O+F145L6t/AdyodA54ZyH2fEJlUssfBg6cwh4h9y21t9n9dOEIRlHPyyH5dXL4dwPMu1j7qcF0W4rK/OtOIoAExd7ZnSPYmHy63g+KVKzWt/PgEL29bcndj1SAz/O6pW003qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931349; c=relaxed/simple;
	bh=HzGar3lPrx516B+Rz9JdR66wQRHDFkVanbk8QWDlmoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKIiXY0/7zrlzwlDk6pU/KYFgSsTH5T01ScKSBH7mHZ66syhLSFPlDnYUmCNIVfIgz7p66ENia/FZeF+XrOQf3KO30NQ7uaxExcC0gzQDjdhh77tfZU8TxNq2lhKcw55WGurJUn2lJ56Jb91QXmXQ5A1ZVpy+6GgmAf0Ky6TG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (82-72-63-87.cable.dynamic.v4.ziggo.nl [82.72.63.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B91341FA5B;
	Mon, 22 Jan 2024 14:49:03 +0100 (CET)
Date: Mon, 22 Jan 2024 14:49:01 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Martin Botka <martin.botka@somainline.org>, 
	Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8956-loire: Add SD Card
 Detect to SDC2 pin states
Message-ID: <iatieesr52v5au4kkovw3gc34tn3snt454grq7le66oar6x7t4@4jfwxgxov36v>
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-6-7b186a02dc72@somainline.org>
 <9d3623f8-697b-44ab-a9eb-9d2d305b0e5c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d3623f8-697b-44ab-a9eb-9d2d305b0e5c@collabora.com>

On 2024-01-22 12:48:27, AngeloGioacchino Del Regno wrote:
> Il 21/01/24 23:33, Marijn Suijten ha scritto:
> > In addition to the SDC2 pins, set the SD Card Detect pin in a sane state
> > to be used as an interrupt when an SD Card is slotted in or removed.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >   arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> > index b0b83edd3627..75412e37334c 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
> > @@ -264,10 +264,27 @@ &sdhc_1 {
> >   	status = "okay";
> >   };
> >   
> > +&sdc2_off_state {
> > +	sd-cd-pins {
> > +		pins = "gpio100";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
> > +	};
> 
> Are you sure that you really don't want card detect during system suspend?

Does it make a difference if the rest of pinctrl and the SDHCI controller are
also turned off?

> You could simply add a sdc2-cd-pins out of sdc2_{on,off}_state and add use it for
> both default and sleep.

This sounds close to what Konrad suggested by using a new block wit its own
label rather than extending the existing state.

> pinctrl-0 = <&sdc2_on_state>, <&sdc2_card_det_n>;
> pinctrl-1 = <&sdc2_off_state>;

You said both, but it's not in pinctrl-1 here?  (And might unselect bias-pull-up
implicitly instead of explicitly selecting bias-disable via an off node?)

- Marijn

> Cheers,
> Angelo
> 
> > +};
> > +
> >   &sdc2_on_state {
> >   	clk-pins {
> >   		drive-strength = <10>;
> >   	};
> > +
> > +	sd-cd-pins {
> > +		pins = "gpio100";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		input-enable;
> > +		bias-pull-up;
> > +	};
> >   };
> >   
> >   &sdhc_2 {
> > 
> 
> 


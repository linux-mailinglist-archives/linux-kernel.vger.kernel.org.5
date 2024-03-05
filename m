Return-Path: <linux-kernel+bounces-92850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA38726DE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE681F26E53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3321BC26;
	Tue,  5 Mar 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3jyolA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C91426F;
	Tue,  5 Mar 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664433; cv=none; b=mYk3NG7+DeSi5KLtNik8hPoxerPpM78dhW5ZiQCMdbu/V7YaEhRROr8FwiE0qzbA4j43YP/znpCh1bKLV5P6gXb43rBI4r4ekDlpC1xYYAlm6oZswwyfhW2eS16D56GI586o/soaQNhCvRHTPdKJAGGovhk2kmrDipsniuL2rbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664433; c=relaxed/simple;
	bh=U5W8rIwEZ8/ChIKj7QRXxLhxjBrC54xOPyhXtwiEsTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8PgLUN1tvyDZNFelZWMShVfdRpx7gSeQFXkqLgJ31xTrmzAk+8Y7On6t5OF5ekxcH32hb2mo+SDnfu5aSj5yJmMNakndxoz4Eqg11U4SdOmTKquNxidpewpy/h1q1q/C55UAOu8K29T7DbJ6tYSZnEDDvtJvF9F7QMBU7OUp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3jyolA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D566C433C7;
	Tue,  5 Mar 2024 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664432;
	bh=U5W8rIwEZ8/ChIKj7QRXxLhxjBrC54xOPyhXtwiEsTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3jyolA5MxiqDI7nMAztHtXTKc9dynmmnSjCKq/Hlk2c0rTUGdJyqjNLwF97DgKzr
	 6BtUYTrwI1cv0w5+Py6IZr2gNWtkkP3FDYpmxas0QOk38wzrlHlAqPl0nikCFtq1C9
	 SZqjraoFI9twivNW2mn5C9yc2bHo726l0cE4c7gOqCjdVPlp4K0yN/vX18uCz2m0wL
	 j++Igw/AdYme20nxnNm0yMHXUW1xpSTd/g6OgceYhhOhgyF0VII7b5l7ZKhz4V5GRH
	 Ypdr9ComVFoxSK8rgamaueuTmigxDsS9aNAtEsGnKNqgNz8VpDluqyIGZY1h0uBUBp
	 J7W4WxfanWaFg==
Date: Tue, 5 Mar 2024 12:47:09 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Sriram Dash <quic_sriramd@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	quic_wcheng@quicinc.com, Thinh.Nguyen@synopsys.com, p.zabel@pengutronix.de, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, quic_psodagud@quicinc.com, quic_nkela@quicinc.com, 
	manivannan.sadhasivam@linaro.org, ulf.hansson@linaro.org, sudeep.holla@arm.com, 
	quic_shazhuss@quicinc.com
Subject: Re: [RFC 3/3] arm64: dts: qcom: sa8775p-ride: Enable support for
 firmware managed resources
Message-ID: <qbgyspabmohgwenj3mbpiebyll2jlgvbq5v5fm56mo2ixwgnee@nyjzjrspxrq3>
References: <1709657858-8563-1-git-send-email-quic_sriramd@quicinc.com>
 <1709657858-8563-4-git-send-email-quic_sriramd@quicinc.com>
 <b9142874-0afb-40a6-9008-b33bd8f56840@linaro.org>
 <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399555e8-d8fa-46b7-8b15-3d3a4a30809b@quicinc.com>

On Tue, Mar 05, 2024 at 11:33:54PM +0530, Sriram Dash wrote:
> On 3/5/2024 10:38 PM, Krzysztof Kozlowski wrote:
> > On 05/03/2024 17:57, Sriram Dash wrote:
> > > Establish the channel and domain mapping for the power domains to connect
> > > with firmware, enabling the firmware to handle the assigned resources.
> > > Since these delegated resources will remain invisible to the operating
> > > system, ensure that any references to them are removed.
> > > 
> > > Signed-off-by: Sriram Dash <quic_sriramd@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 96 +++++++++++++++++++++++++------
> > >   1 file changed, 77 insertions(+), 19 deletions(-)
> > 
> > Do not mix DTS patches with submissions to netdev or USB.
> > 
> > Please put it inside your internal guides, so you will not be repeating
> > this over and over.
> > 
> 
> Sure. Will take care. Thanks.
> 
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > > index 26ad05b..b6c9cac 100644
> > > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > > @@ -764,8 +764,18 @@
> > >   };
> > >   &usb_0 {
> > > -	pinctrl-names = "default";
> > > -	pinctrl-0 = <&usb0_en_state>;
> > > +	/delete-property/ clocks;
> > > +	/delete-property/ clock-names;
> > > +	/delete-property/ assigned-clocks;
> > > +	/delete-property/ assigned-clock-rates;
> > > +	/delete-property/ required-opps;
> > > +	/delete-property/ resets;
> > > +	/delete-property/ interconnects;
> > > +	/delete-property/ interconnect-names;
> > > +
> > > +	power-domains = <TODO>, <TODO>;
> > 
> > This wasn't even tested.
> > 
> 
> This is tested with the specific power domains in place
> of <TODO>. SCMI interface is used for the power domains.
> 

So you tested this on v6.8-rcN, but you're not able to upstream this
dependency? The code wouldn't compile if this patch is applied, so what
do you expect that I should do with it?

Develop on upstream, test on upstream, send code that improves upstream!

Thank you,
Bjorn

> > Best regards,
> > Krzysztof
> > 


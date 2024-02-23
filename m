Return-Path: <linux-kernel+bounces-77815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA4860A84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BF5288BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B925C12B82;
	Fri, 23 Feb 2024 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t6aquaMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18511CAD;
	Fri, 23 Feb 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667974; cv=none; b=lKo1Xb7ENviSm8Lffeo5ecCQw+hN4jRNEpdNBWUiBXjJ0VtKo9nLb3x/i2XZ66exFZU4jHe2ZqETzNP/F8fmj4UFetxtxCMg4QRU7cmHA3LGv8zDUWrSMNLUYgLEPK1t2DKOIeyBMzFGKfgY701M8RzVv+ajuwwzz66xSVBPfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667974; c=relaxed/simple;
	bh=h5EJyRMeUWX5mNv+NDV4aIHRv+177JouUHgeFau9w3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsbXdDqZ+KBiR62NdD1zGRIpBXWhMc9eVS5Io9cYfQ9gvtcNg0zPcucI2W8z7B0ywnCPHrsMKt32bYxG8L6A7CcDIzVChVyujKCesJZYTZg5YMEfbF8XPz0KwyETSVSoB2eRxVd3/o7kmkRSr7TkXpHxClh9mFFGpguIcL+CY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t6aquaMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED977C433F1;
	Fri, 23 Feb 2024 05:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708667973;
	bh=h5EJyRMeUWX5mNv+NDV4aIHRv+177JouUHgeFau9w3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6aquaMWSOOorVD+X5138C/MRM431DQsyY7U1T8Sq+csvmeRtnCPI6sMr6+XngMbt
	 6EoWlSUj5sdjQrwR7hoCTzW/6XIM62cctelx2kZj2Aq683RmQ+1O/EJ/EvqSHfB54H
	 vHNofa6C+M0kTt2grGGVofENipz8x0r2zscgy8JE=
Date: Fri, 23 Feb 2024 06:59:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
	perex@perex.cz, conor+dt@kernel.org, corbet@lwn.net,
	lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
	bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
	konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v17 36/51] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <2024022300-routing-baffling-7ce0@gregkh>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <20240217001017.29969-37-quic_wcheng@quicinc.com>
 <7dc9e80e-0875-4dfc-adf9-9bfad2fb8589@linaro.org>
 <bdc57138-e67e-47ae-8cf1-b8be5aeb2369@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc57138-e67e-47ae-8cf1-b8be5aeb2369@sirena.org.uk>

On Thu, Feb 22, 2024 at 04:50:08PM +0000, Mark Brown wrote:
> On Thu, Feb 22, 2024 at 05:24:58PM +0100, Krzysztof Kozlowski wrote:
> > On 17/02/2024 01:10, Wesley Cheng wrote:
> > > Add an example on enabling of USB offload for the Q6DSP.  The routing can
> > > be done by the mixer, which can pass the multimedia stream to the USB
> > > backend.
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > ---
> > >  .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> 
> > This broke next.
> 
> > Wesley, are you sure you explained dependencies in this patch? Why is
> > next failing on this now?
> 
> It's surprising to see this merged at all while the series is still in
> review?

I took the first 10 and then these dt patches as I thought those were
safe to take also given the review.  If I should revert them, I'll
gladly do so.

thanks,

greg k-h


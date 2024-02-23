Return-Path: <linux-kernel+bounces-77832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047DC860AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5071F24578
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D291D13AF3;
	Fri, 23 Feb 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xiTwVPlT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15212E45;
	Fri, 23 Feb 2024 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669388; cv=none; b=RkR4c/0r0aTwZGhJ7ayzWgaAntETg/dlTCCK+Q234cwGDnYAa0gceYVDA76G9DwvEWtM7UjqfMpzcRCcPs61lXWumz6GS3abhsB7ShJNLoJlwr6whwpOKvZEop4FFytbUVQrjZ0lWBx7q5yvBkKce0hpQAHBtq4BNWe1AHYWNV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669388; c=relaxed/simple;
	bh=E0nEqPdV2QlHfBxw2rYP1kW7aUMpkrIUH2IEVRz8+Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdyIO6LMYI3cgxhn+vrBE3bNiIAntHIJ2PyijmTad9kXYuGbsxjVUGKHPug8S0C5WmBOgHDKVx34EFWWOt5y2UooxjgCkjsFjBDGdqDY6670bMl3feSRS/66mSHIu7DZBw5ZAEiiEEFTyPA/ZHonr1v4+gOjaEfcJJ65PpOUpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xiTwVPlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983D9C433F1;
	Fri, 23 Feb 2024 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708669387;
	bh=E0nEqPdV2QlHfBxw2rYP1kW7aUMpkrIUH2IEVRz8+Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xiTwVPlTadYJUCbYRaOeLO2ibb8HrtR2M6XYADwpIfsigHwnxriJngyeqk5OZ1b5r
	 VfBsZGzawMJmDLSfopA0qKl34P6dpi0Q33ZTgREiACCotz5QGIDkinTyiEF4UWiUOy
	 CiQJdAj0wYjK+oj//dnPgCS94k1TQ0a6weahgmPU=
Date: Fri, 23 Feb 2024 07:23:03 +0100
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
Message-ID: <2024022359-harmonize-bath-4a7c@gregkh>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <20240217001017.29969-37-quic_wcheng@quicinc.com>
 <7dc9e80e-0875-4dfc-adf9-9bfad2fb8589@linaro.org>
 <bdc57138-e67e-47ae-8cf1-b8be5aeb2369@sirena.org.uk>
 <2024022300-routing-baffling-7ce0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022300-routing-baffling-7ce0@gregkh>

On Fri, Feb 23, 2024 at 06:59:30AM +0100, Greg KH wrote:
> On Thu, Feb 22, 2024 at 04:50:08PM +0000, Mark Brown wrote:
> > On Thu, Feb 22, 2024 at 05:24:58PM +0100, Krzysztof Kozlowski wrote:
> > > On 17/02/2024 01:10, Wesley Cheng wrote:
> > > > Add an example on enabling of USB offload for the Q6DSP.  The routing can
> > > > be done by the mixer, which can pass the multimedia stream to the USB
> > > > backend.
> > > > 
> > > > Acked-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > > > ---
> > > >  .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > 
> > > This broke next.
> > 
> > > Wesley, are you sure you explained dependencies in this patch? Why is
> > > next failing on this now?
> > 
> > It's surprising to see this merged at all while the series is still in
> > review?
> 
> I took the first 10 and then these dt patches as I thought those were
> safe to take also given the review.  If I should revert them, I'll
> gladly do so.

Now reverted.


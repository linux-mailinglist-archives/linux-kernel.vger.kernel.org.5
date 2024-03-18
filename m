Return-Path: <linux-kernel+bounces-105613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3A87E193
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EA1F214EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005A18C36;
	Mon, 18 Mar 2024 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diESgmM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6A168B7;
	Mon, 18 Mar 2024 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724921; cv=none; b=YdsC+vYz5bZWxmaX5CXVanU7tqxpvKAXb9pkvO/hX7gntvLpOzjU88j/KhbSHYRFBdmE8Cxx/W1If0T/YXJ6G2CGBqwI+ruKVgDX62mquHU+OVkJcSZnzM4YEsubqjZ4X3Hn2umO7YjLj70JRRbZVLsuORNfH9w76Ugqnr1ajX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724921; c=relaxed/simple;
	bh=A3qUIU4IJh6pUUkc9Ktbk9dFPj1Z12U4SirVZRl0r50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkY5yFOj6ajdYyRat6DKkeI/j9pHZj9RVF5AhQpVB4hz3QHr+U0kSC3rUFFnoCjvpSbKDvyqESd64CLbjDWXAtySa/jw0GT9ela20wDkp5FALCCUY6lV88+DKANz3yH8UqYrWmvkOKbvmQWzCfVDmxXaq16c/FY5JU2tGf+91tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diESgmM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF4C433F1;
	Mon, 18 Mar 2024 01:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710724920;
	bh=A3qUIU4IJh6pUUkc9Ktbk9dFPj1Z12U4SirVZRl0r50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diESgmM48596jTkyDf+MInkJK2vspnYwouovuMgtyXGWptRYplLWdkpVaIObbDyy1
	 bYEduc/wWJP5k2VR0w3KtmEv3OIENTS3bepfK6kiJ3v1zzGJWnHUX2+VXWAgSEQTpq
	 ZTPoo+g+Qc4zPULCw+RCwHdP+T5SS+AvpTX4cy7Lu4KbT1UYOMYKCnlHHpAs4cTFtQ
	 op12cnbg2KL65XLMjuoLhdxvf5sW3JMolFO4wN78FF7EpfCQFxyZ0l8A9IPpiCLZWd
	 vsUEvw1NS4v0ylNEW5D2/kk43aP8ckBulBjSCz3JN2TlscClkXoVNcJXmAWbKKJQhg
	 MkA1QcbD+BG/A==
Date: Sun, 17 Mar 2024 20:21:58 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add qfprom node
Message-ID: <gxi4klvxzwwyrwb2b4h7kmii5dx5mxdypxowwz3kyllvq6grss@6lahaospwtsh>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
 <1709727995-19821-2-git-send-email-quic_mojha@quicinc.com>
 <45fcf8fb-9d9b-4e6a-a7c5-9bfb96875e64@linaro.org>
 <69a8c14c-109a-103a-b8dc-d8e303c0f0d5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69a8c14c-109a-103a-b8dc-d8e303c0f0d5@quicinc.com>

On Thu, Mar 14, 2024 at 10:13:59PM +0530, Mukesh Ojha wrote:
> Sorry for the late reply, was on vacation.
> 
> On 3/6/2024 9:24 PM, Konrad Dybcio wrote:
> > 
> > 
> > On 3/6/24 13:26, Mukesh Ojha wrote:
> > > Add the qfprom node for sm8450 SoC.
> > > 
> > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > index b86be34a912b..02089a388d03 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> > > @@ -4575,6 +4575,13 @@
> > >               };
> > >           };
> > > +        qfprom: efuse@221c8000 {
> > > +            compatible = "qcom,sm8450-qfprom", "qcom,qfprom";
> > > +            reg = <0 0x221c8000 0 0x1000>;
> > 
> > Is is really only 0x1000-long? Also, is the base you put
> > here the ECC-corrected part (if that still exists)?
> 
> No, its not.
> 
> Entire fuse space is this.
> 0x221C0000-0x221Cbfff
> 
> ECC corrected range is this 0x221C2000-0x221C3fff and High level OS

That's 0x2000. Does this then also imply that the ECC-corrected values
are no longer mapped 1:1 with non-corrected, or why do they differ in
size?

> does have a access to ECC range however, they are not recommended for
> SW usage.
> 
> Above mentioned SW range(4) in the patch is  one and only accessible range
> available out of 0-7 SW ranges(0x221C4000-0x221Cbfff with each
> size 0x1000) and does not have ECC fuses.
> 

So you're saying that in contrast to other platforms, the 4th software
range, dedicated for HLOS, does not have a matching ECC-corrected
shadow? If that's the case, then "not recommended for SW usage" sounds
wrong.

> All the downstream use cases are getting fulfilled with this.
> 

You only need ECC if you're unlucky...

Regards,
Bjorn


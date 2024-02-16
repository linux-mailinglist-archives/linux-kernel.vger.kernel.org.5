Return-Path: <linux-kernel+bounces-69137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3510D8584EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE44028266B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5D13540D;
	Fri, 16 Feb 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvFwwYpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17751134751;
	Fri, 16 Feb 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106955; cv=none; b=hnn566D0FsMsLXa8iMxZlc2wsPoHi8qPFZ50iy6IXctIvas3COk7GHT9jwy2utMoXao360oskTXyifjKQJWxBZazKzioSgdGubZKVUR+p6JOtQtJiVgceARIv2MfhkX67JgWOm3tr/RjeAt2LyvfdUUYK26aiDpvPhcg2ck9Y0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106955; c=relaxed/simple;
	bh=gEiW2xpv104Z8gpM4qzqbYKLaODu05bz5fxABQE83wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcV8NBb0ot+Fe+b17AEKJGQMLI1U7rC5b4SAd6ZrjoMRyNLZSkaGdSHaboZosv36Y2MscVzS6wkBTgrKCmpdg/QC6+/b8dHAbzisiN3jHJaclMVQ1RBjVujyCQn24VCwrfgSkqJ7VU5Z3A6pJBJig7iXz9BuXpOztA1tY3MH5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvFwwYpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E855C433C7;
	Fri, 16 Feb 2024 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106954;
	bh=gEiW2xpv104Z8gpM4qzqbYKLaODu05bz5fxABQE83wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvFwwYpvsieJvyJnPOWN+cDgxBhuuJu1tT27tiz1r7V9bzV4pv8IcsrOBif/+FOHa
	 32BxZ4xkZBqPt/SPEEDsCGKZJcmHYrd4k/IP4JVHFjAozrv6MWU2oU0jz+wOQPyJLO
	 4ZU5MSWR7TpxC8JchbbQnucCTZTVAwL9FIwsF//GHAuBuRIeYuf5O1glp9gPDsnHvE
	 i6oVVk6S7NGCcBTtbr1+crfaKNQB4F3aIr+8lrqwws2gjns8T4QdY03J3MthQ9a194
	 u+ETklM29xQz7vd6biVoMvgT3MsvAyJWQ1hErvbGiyHSsFecfvkufz9mf+M9WXxyM3
	 bXckFaQUeJifg==
Date: Fri, 16 Feb 2024 12:09:11 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Stephan Gerhold <stephan@gerhold.net>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6350: Add Crypto Engine
Message-ID: <pbjbhnj4opt57xswk7jfg2h2wjdv3onmg4ukxn22tsjjsnknxv@m5gy44kkbvvl>
References: <20240105-sm6350-qce-v1-0-416e5c7319ac@fairphone.com>
 <20240105-sm6350-qce-v1-2-416e5c7319ac@fairphone.com>
 <ZZguvdJTyVgfxm4D@gerhold.net>
 <CZ6FYZLGWT3K.ZBHYDQ7TDN4B@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZ6FYZLGWT3K.ZBHYDQ7TDN4B@fairphone.com>

On Fri, Feb 16, 2024 at 11:46:49AM +0100, Luca Weiss wrote:
> On Fri Jan 5, 2024 at 5:30 PM CET, Stephan Gerhold wrote:
> > On Fri, Jan 05, 2024 at 05:15:44PM +0100, Luca Weiss wrote:
> > > Add crypto engine (CE) and CE BAM related nodes and definitions for this
> > > SoC.
> > > 
> > > For reference:
> > > 
> > >   [    2.297419] qcrypto 1dfa000.crypto: Crypto device found, version 5.5.1
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > > index 8fd6f4d03490..516aadbb16bb 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> > > @@ -1212,6 +1212,37 @@ ufs_mem_phy_lanes: phy@1d87400 {
> > >  			};
> > >  		};
> > >  
> > > +		cryptobam: dma-controller@1dc4000 {
> > > +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > > +			reg = <0 0x01dc4000 0 0x24000>;
> > > +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > > +			#dma-cells = <1>;
> > > +			qcom,ee = <0>;
> > > +			qcom,controlled-remotely;
> > > +			num-channels = <16>;
> > > +			qcom,num-ees = <4>;
> > > +			iommus = <&apps_smmu 0x432 0x0000>,
> > > +				 <&apps_smmu 0x438 0x0001>,
> > > +				 <&apps_smmu 0x43f 0x0000>,
> > > +				 <&apps_smmu 0x426 0x0011>,
> > > +				 <&apps_smmu 0x436 0x0011>;
> >
> > The last two lines look equivalent to me: 0x436 & ~0x0011 = 0x426.
> 
> I don't understand the IOMMU SID + mask really, but I think I've seen
> somewhere before like here that TZ can be a bit picky with the SIDs?
> 
> https://lore.kernel.org/linux-arm-msm/opqdrmyj3y64nqqqmakjydn5rkspizufyeavm7ec7c7ufqz4wk@ey2a7bq3shfj/
> https://lore.kernel.org/linux-arm-msm/11b5db69-49f5-4d7b-81c9-687d66a5cb0d@linaro.org/
> 
> I don't quite want to risk having some obscure use case breaking because
> we cleaned up the dts ;)
> 
> But if you're more sure than me that it won't break, let me know!
> 
> >
> > It's also a bit weird that the mask has one more digit than the stream
> > ID. And ordered numerically (by stream ID, first number) it would be a
> > bit easier to read. :-)
> 
> Sorting them is no problem, can do that for v2.
> 

Where you able to do this? I don't see a v2 in my inbox, am I just
searching poorly?

Regards,
Bjorn

> >
> > Thanks,
> > Stephan
> 


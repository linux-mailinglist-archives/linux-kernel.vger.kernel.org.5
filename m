Return-Path: <linux-kernel+bounces-68566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744D7857C86
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F24C1C226DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B2A78B6C;
	Fri, 16 Feb 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="kq6dHcdK";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="B0DLBi4z"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA42CCB4;
	Fri, 16 Feb 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086484; cv=pass; b=p+3/i3p+rCyfSqjL+334BhXvevN1umwVk+7xh3AOxzT9V3Eqh9/giqGUzVo/8AXXm1zYEYhm53ornL3vdNvEhJ/S/ddpCyrrTaTwfAKbPFa+XcLGtKUgzOmb6sSlpgqva3EnqJAzK5lfQkOBGgd5OibnpjYu6hh3TveR/dOaykQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086484; c=relaxed/simple;
	bh=KFV+aT1TFLyg4LrDxjI/psFcUhb+NLmzmx7k1wYWdIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKDkUsG27WbaGKTB3Oxvq0CIpJEYs/MOnNo+pubCIljMrmBFmaAsU7c1K/7zaY6aGcdIkmFPDylBHt/Rn+3gp8wf/Xmpq48dKQozOREFNrAXiBR3qqUEn17nPwcTzKU84ivG1h5EJNyfPg1jX65LHKkmRgYK7aT84ZZMAR2b6NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=kq6dHcdK; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=B0DLBi4z; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1708086470; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hhStsG9uNx0mxxlmk5xAsiFfbpz2jf0iY1s01F9NZ9pxvX6DTOTkV8DQDjqqcYAZSR
    iM2pDufb0CyvEq4M9aAK6nDjy8oFTrrEr8mQki/S9fm/+szyUkDtPFkPOVgbW8R/we7x
    Z0N4XZl2eOtX9I5D+9fswWLh6ScCiV2WiFcfp/lNFUR0k5vxgw/BsyBcXpevU1xuXLzW
    KuzK3vPwBxHTl6SuUlklCoqVdGVrkdZFqdyGY3tMiDB/bHcCrzRoxFV4bVMCet093hhi
    Nc+YqUBeB+/fGJpfpL2xVp/yum8TvEBMjuP3dQVF9Mr3yIlF5JIKeGOwzbol2H4qMlXt
    QYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708086470;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MepF5SC3Z5CxV0sO8a7Lrytfde/54TObZ+cQ71oOUQE=;
    b=HbvYBUOXptb8a67ow9peBoIv37lYB14il/7Y3MSrfvhXIYnwe4oJh2PY67RM9tKhzw
    jWqOFxM1LTflClQJDdOXuTYBox1vEIg9b719bVLzw7/O6XCSEcXRFHQI2PyEb9bd/ZAi
    7PoDnDa4yYgrhc5zX+S63XCeD0mEYy7VhuUTOKk4A/kG3aImOzNQQRQFwkV6qjKVe1Dg
    s3WULcs+HSlsD7EVO5sKH9+deXL6b5qg1PEM5VvcviRmEp/eTlY+PuW0PNVOO9QG1BUm
    oMOprdPTVpkXkbeALwEwvRE1d8xR9GRTHWWJ2IXaocb0II3H/xQ1HzzIul/fam/m5XM5
    S7dw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708086470;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MepF5SC3Z5CxV0sO8a7Lrytfde/54TObZ+cQ71oOUQE=;
    b=kq6dHcdKH7S72gPG20aOlKm2zyTSW4IoW0QXmAPpM0YrzoJc4B8tzx2e7/u4dYDOJN
    7IVPsE8/o+OnYaWqEwNbssTqTn4mpHQ1F4y7Qj7o4MOr1yvpUZbGB3uSZAynBlmAsnrR
    H/SqEAmjnAE5VcQZdI1Yd/to096KwBQrY0HxLfwvLvNutD2p49eda9Rj5LIO8s3z6IMZ
    63LfJW+EJT0D9fjghWqtOwlaeOQ31aFty+++2GQvP+bXAuUcuD2bgzROTKKKD8Hr54El
    8GwBFyLWv39PdGGf+qCVS643eoSWNr3q9p4CE2y0bA22q3GVjjb1+A76oIntZmjZ6O1F
    LnnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708086470;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MepF5SC3Z5CxV0sO8a7Lrytfde/54TObZ+cQ71oOUQE=;
    b=B0DLBi4z79yMro6JDuYNa7+FrvOQvptROEkcBKGOZchiv8ZxU8Xt6DStYW5EZpah0G
    B5ByicI1dIXwkF+TiqAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z+P1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.11.2 SBL|AUTH)
    with ESMTPSA id ze34f101GCRmFXb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Feb 2024 13:27:48 +0100 (CET)
Date: Fri, 16 Feb 2024 13:27:42 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm6350: Add Crypto Engine
Message-ID: <Zc9UvgAsTvazQ_HR@gerhold.net>
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
Content-Transfer-Encoding: 7bit

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

I'm afraid I can't really help with this kind of certainty. My knowledge
about proprietary Qualcomm firmware is probably even more limited than
yours. However, my personal feeling is that the "TZ wants X" arguments
are most often just as badly based on superficial knowledge.

In simplified terms, the SMMU has a number of components connected to it
(the crypto BAM, USB controller, UFS, ...). When the components make
memory requests they are identified by a number of Stream IDs (SIDs).
The purpose of "iommus" in the device tree is to describe all SIDs that
belong to a particular device. These SIDs are then all assigned to a
context bank that allows the device to access selected regions in RAM.

It shouldn't matter *how* the SIDs are matched inside the SMMU, as long
as they end up at the correct context bank. The SMMU will look through
the configured Stream Match Registers (SMRs = SID + Mask) to find the
context bank that is assigned to the SID. The docs say "If MASK[i]==1,
ID[i] is ignored.". This means a SMR with ID=0x426 MASK=0x0011 is
definitely identical to ID=0x436 MASK=0x0011. Having the extra entry
will make absolutely no difference to the SMMU aside from wasting a
pointless SMR.

The links you posted suggest "TZ" looks at the SMRs allocated by Linux.
If that is really the case then I would expect that to be fundamentally
broken. In my opinion there is absolutely no guarantee how or in which
order Linux allocates the SMRs. Such functionality would either be
extremely complex or broken in tons of edge cases.

TL;DR: I cannot provide proof that removing this entry makes a
difference. I can just say that I doubt it does, and if it does, then we
have far more serious problems. The device tree is supposed to describe
the hardware ("This device makes memory requests with the following
SIDs") and not fundamentally broken peculiarities of the proprietary TZ
firmware ("registers must be programmed exactly with these values").

Thanks,
Stephan


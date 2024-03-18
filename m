Return-Path: <linux-kernel+bounces-105686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A787E2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2145F2817C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5651F614;
	Mon, 18 Mar 2024 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIfMeZve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97A1D530;
	Mon, 18 Mar 2024 03:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710733038; cv=none; b=gZ7MZYgGuTls8XBwvApMA7gIVpJWj+UpTcNCLhC1jOZnrukil16vct7qwNlbDZLZcVn3QctMkWSOUpLBnKqY55rC/0Yl8IhiE3L/uRVg88+sJNdKyUXAULkzokKNqNozAPvRH41Hd7Qh29aBdjRuL+Zwt8ey9KBTCRG5uQX2+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710733038; c=relaxed/simple;
	bh=OtYNbsQDiWdUoo7LT1A1WLk7i98yL98HDFPaacqRjwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHufaLVcgh5KkESnyo5JgZgBnC70qUFfnIROqvxixMJBJWvtGPpAt8K28zb3VZM1LMiqbeyD1uyU4LxG9sAuVNUib6/RCpF6YihLq/NHtOjAi43YKzoLttYcncSORQnETQlx44/ep/NRYcE92PvgzAw4VAmwFUT3JAbS5vuMKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIfMeZve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C2C433F1;
	Mon, 18 Mar 2024 03:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710733038;
	bh=OtYNbsQDiWdUoo7LT1A1WLk7i98yL98HDFPaacqRjwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIfMeZveN5OCk18QBPfTD0sndOtEkG1C/4pQNBc1hok8JZcWfLhjB2nGWenYIxdy4
	 wynrBuJW0qhDlU6BzYYEblmJYe7KWxLFnkqYfAXuC34PR1jkOZrEne5ir4HmPiz4EH
	 n8KKCqoMoSnX2A2zsXytGzxR6Nw3XyVmu8z4eVdvcFplcqpvbxKkMxa2LVXNDJdgcA
	 eoKDC7Qpw4uMWn2XVh3IHHgapcMsz+0hh/Mg5DibI9YlbAWaJJR2mD9XGCj1ozYP3F
	 k7U62WcARSxR6yYcqFzKCXnN0R8p+IKv2P+GrxGZxxY/5795+uKCaEVtxsJ3dJvzRD
	 MxijlzD+C0xjA==
Date: Sun, 17 Mar 2024 22:37:15 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/21] arm64: dts: qcom: sc8280xp: Add PCIe bridge node
Message-ID: <26mic7smm2aez3enydiiuul2c5yru4kmx26n4mo63nvy4bscuv@jql4hhe3gia6>
References: <20240221-pcie-qcom-bridge-dts-v1-0-6c6df0f9450d@linaro.org>
 <20240221-pcie-qcom-bridge-dts-v1-9-6c6df0f9450d@linaro.org>
 <9d6c617a-bc3a-47c4-a988-b41b804d8cfe@linaro.org>
 <20240222053958.GF3374@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222053958.GF3374@thinkpad>

On Thu, Feb 22, 2024 at 11:09:58AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 21, 2024 at 01:39:01PM +0100, Konrad Dybcio wrote:
> > On 21.02.2024 04:41, Manivannan Sadhasivam wrote:
> > > On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
> > > for each controller instance. Hence, add a node to represent the bridge.
> > > 
> > > While at it, let's remove the bridge properties from board dts as they are
> > > now redundant.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  8 -----
> > >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 40 ++++++++++++++++++++++
> > >  2 files changed, 40 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > index def3976bd5bb..f0a0115e08fa 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > > @@ -733,14 +733,6 @@ &pcie4 {
> > >  	status = "okay";
> > >  
> > >  	pcie@0 {
> > > -		device_type = "pci";
> > > -		reg = <0x0 0x0 0x0 0x0 0x0>;
> > > -		#address-cells = <3>;
> > > -		#size-cells = <2>;
> > > -		ranges;
> > > -
> > > -		bus-range = <0x01 0xff>;
> > > -
> > >  		wifi@0 {
> > 
> > This doesn't seem right, pleas use a label
> > 
> 
> Why? A node label is useful if we want to reference it at the root level in
> board dts, but here it is not.
> 

Giving the bridge a label and then adding wifi@0 as a child using that
label in the dts is pretty much how we do for everything else.

I find this over-flattening hard to follow, but relying on child node
names when extending the structure or adding properties have bitten us
many times in the past.

As such, I think the desired result in the dts should be:

&pcie4 {
	status = "okay";
};

&pcie4_bridge {
	wifi@0 {
		...
	};
};

Regards,
Bjorn

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்


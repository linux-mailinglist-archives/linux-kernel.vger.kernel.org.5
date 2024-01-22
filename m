Return-Path: <linux-kernel+bounces-33817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B9836EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A14B1F24CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF2264AA5;
	Mon, 22 Jan 2024 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OPXwlR+s"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA046518C;
	Mon, 22 Jan 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944438; cv=none; b=bpzSEcJ34pgCkrW8OjYWHMNvSPBGS/kVRUIE5s5NUXIf9d+YcfYO0HDO8upYB1i6kiW5pwkCQPZGr5QBKsjphFrOpGdBiJB/0qAXO3utx4+c4QaZRJUo1vPhVY4ylB8oKRD+0hwgNED4tsKhbrTD2PQEwO1mqFd8oFfBgaQY6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944438; c=relaxed/simple;
	bh=vof7je9MuBULQhb/7HRQcAdNjAUHmwHcS70O92S/MCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8NSV4dX7PctF8XRtrnOFJ2DuBHmu9r+v9Io1nA9a3MLox/BYWgldc3w7AgJ9FOm4OK2ktlNn9phkmaEBCbwDhwIWbZP+XVCRKkKefwTmSkq2stjktvHsyayRYSCgjmXJ2kPuZhB/k+9djpwM9/3ET0ox8uH8gkz5Mr0IlMHhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OPXwlR+s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wSKAYF9IlX95zipvf0YSfJnTfG2ghF6yU76cWzKEMrU=; b=OP
	XwlR+s3tYyiMnAuHZeUMC0NgdVyHMwJHz+EXNQn0HiJN/iPHPx/LTEnFdlIEHlQEEhHmbH/QSGyjD
	tbEbEdubSV1aYnmlgzjHQIluTIxYdODhohY1AzSEmnb0pEmfnuFRXgWkEsohIDXFxPseJuRFhqvsh
	QbgyhLla6bf+eBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRy4e-005kPU-JS; Mon, 22 Jan 2024 18:27:04 +0100
Date: Mon, 22 Jan 2024 18:27:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq5018: enable ethernet support
Message-ID: <5d36f465-a9fc-434d-a777-bc9833f7d6ba@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556FA040B07F48AFE544680C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <b8510b38-3669-4a04-9ca6-dbe937ecbec3@lunn.ch>
 <TYZPR01MB5556603EA4C5D7BAF9C27C6AC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR01MB5556603EA4C5D7BAF9C27C6AC9752@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Mon, Jan 22, 2024 at 11:52:30PM +0800, Ziyang Huang wrote:
> 在 2024/1/22 0:45, Andrew Lunn 写道:
> > On Sun, Jan 21, 2024 at 08:42:36PM +0800, Ziyang Huang wrote:
> > > Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 120 +++++++++++++++++++++++++-
> > >   1 file changed, 116 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > index e502a3ecf4b7..b36e5c2136b7 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> > > @@ -94,6 +94,63 @@ soc: soc@0 {
> > >   		#size-cells = <1>;
> > >   		ranges = <0 0 0 0xffffffff>;
> > > +		mdio0: mdio@88000 {
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			compatible = "qcom,ipq5018-mdio", "qcom,qca-mdio";
> > > +			reg = <0x88000 0x64>;
> > > +			resets = <&gcc GCC_GEPHY_MDC_SW_ARES>,
> > > +				 <&gcc GCC_GEPHY_DSP_HW_ARES>;
> > 
> > What do these two resets do? An MDIO bus controller is unlikely to
> > have a DSP in it. That is something a PHY is more likely to have. An
> > MDIO bus controller does have an MDC line, but why is it
> > GCC_GEPHY_MDC_SW_ARES not GCC_MDIO_MDC_SW_ARES? So this again makes me
> > think this is a PHY reset, so should be in the PHY node.
> > 
> 
> IPQ5018 has two mdio bus. mdio0 is an internal bus which only connects to
> internal PHY while mdio1 is outgoing and can be used to connect PHY or
> switch.
> 
> So I thought GCC_GEPHY_MDC_SW_ARES is for mdio0 and GCC_MDIO_MDC_SW_ARES is
> for mdio1.
> 
> GCC_GEPHY_DSP_HW_ARES is seem like PHY reset. But if we don't deassert it,
> the phy node can't be scaned. So I add it here like what reset-gpios do - to
> reset PHY or switch.
> 
> > A device tree binding will help sort this out.
> 
> Base on the functions I explained, I can't write the accurate names and
> number of resets here.

Without a device tree binding, your patch will not be accepted. At
minimum, you need to describe your understanding of the hardware, what
you think the resets do.

Since this is an internal PHY, you know exactly what it is. So you can
use ID values in the compatible so the driver loads. The driver can
then deal with clocks and resets. With complex setups like this,
scanning is not always possible.

     Andrew


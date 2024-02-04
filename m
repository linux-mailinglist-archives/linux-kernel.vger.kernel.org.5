Return-Path: <linux-kernel+bounces-51751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06201848EE3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F1CB20E79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F3022612;
	Sun,  4 Feb 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qfAUkoX5"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07C225AA;
	Sun,  4 Feb 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060150; cv=none; b=CfZSCp4SRzEgKz0BxEX7afQsIPR62VYxaCv0xGFBe8BtpCwMCzMit4mor1LP0jJ2E0yksHKlXYlcHZIUb+518tFUYA9fVanMmFyNnAv59snkoQrHVJvF6864AkE5QnSc0k1IxYZjIYipruUWIgF1rYR74g6R3lANIbUPIypntjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060150; c=relaxed/simple;
	bh=HdEPymNokVINCHkSEa5LvnInxWnhWuDC0WVzzVWsEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2Ivk0PNrxYM5TVZBqlqe7s3gtpbRyu4PjZ2nc/Z8KYM6yELp1p6DFU0qh5PVFwhdOrbUil07uYildJoP6Dbxws1sNqrss52ONS8GAyTUp3fMO/XX+G06YInLXatBlM08V9PlyDibzGjBMb0gCQE0/7cAqjJnxJSIgL75OpXXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qfAUkoX5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nevq5mgSlVT/I2RCsRjjpab+WWwVDBjfunWL49iu92I=; b=qfAUkoX5Nn/s46SQ+3G23exnMe
	jIEsEzz6WSdE+V58VpbzM5cVDDquV5M8O4HPyNrl3O6kiSLToZDXaGD6J+Tz1/+aidUF9pzILNwfK
	4gdPqwfMgZmhBNM4QpFt6OSTizGoF/xWyejFIPKY14WMc9sHCxX0adLIfdht5SrZm1Gg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWeJt-006xv7-0q; Sun, 04 Feb 2024 16:22:09 +0100
Date: Sun, 4 Feb 2024 16:22:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 2/3] net: mdio: ipq4019: add support for
 clock-frequency property
Message-ID: <4cd01d93-7b6d-4766-8337-c4dc09aeedc2@lunn.ch>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
 <20240130003546.1546-3-ansuelsmth@gmail.com>
 <7d86388d-15f5-4e72-b99f-aee3b47a5232@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d86388d-15f5-4e72-b99f-aee3b47a5232@quicinc.com>

On Sun, Feb 04, 2024 at 05:59:10PM +0800, Jie Luo wrote:
> 
> 
> On 1/30/2024 8:35 AM, Christian Marangi wrote:
> > +
> > +	/* If div is /256 assume nobody have set this value and
> > +	 * try to find one MDC rate that is close the 802.3 spec of
> > +	 * 2.5MHz
> > +	 */
> > +	for (div = 256; div >= 8; div /= 2) {
> > +		/* Stop as soon as we found a divider that
> > +		 * reached the closest value to 2.5MHz
> > +		 */
> > +		if (DIV_ROUND_UP(ahb_rate, div) > 2500000)
> > +			break;
> 
> Hi Christian,
> Sorry for the delayed review.
> 
> The MDIO hardware block supports higher frequency 6.25M and 12.5M,
> Would you remove this 2.5MHZ limitation? On the IPQ platform, we
> normally use 6.25MHZ.

802.3 says the clock has a maximum of 2.5MHz. So this code is correct.

It is however O.K. to go faster, but since that breaks the standard,
you need each board to indicate it knows all the devices on the bus do
support higher speeds and its O.K. to break the standard. You indicate
this by using the DT property in its .dts file. For an MDIO bus which
is totally internal, you could however put the DT property in the SoC
dtsi file.

      Andrew


Return-Path: <linux-kernel+bounces-154570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED08ADDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC0282832
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5B23748;
	Tue, 23 Apr 2024 06:46:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EB1249F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854807; cv=none; b=qRHlXx8pFWgAkWlxHRMMUvFH+0G4xDtpKniQnV39ukjaiCcRz+Zdfsxst/8MN5sSNSnv6zhBrcznqzslFuEmrwHit6FFmgvhlFUskgL23L9L2jriVLtaMpYIi4p1dOrEBZ4UURRZjrnpAXcERHL5ykgnEv4REG2y6BteXE5ST/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854807; c=relaxed/simple;
	bh=+RRLL02QtmKJZU6WTR2j1pNuRlbjrSxTCoBs4ofOQcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bLKd16LvADrlk2WCd66Qzwd7+sBvp7qSdo7QBhMP77adZkaAPuMxJiE4m2YcmbY9uiNPpeUeVcSzh8wOXouy5XumCVM3GOEiaQu8kJaGLWYoDKOFQQHChbhAa3JYSv8bDrYrp/kMuHD/CN9CvyLXkVrEuQD5pKPOttBUDfYfPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rz9vQ-00085s-9n; Tue, 23 Apr 2024 08:46:44 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,  Clark Wang
 <xiaoning.wang@nxp.com>,  Linux Team <linux-imx@nxp.com>,  Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Jose Abreu <joabreu@synopsys.com>,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  imx@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/3] dt-bindings: net: mx93: add enet_clk_sel binding
In-Reply-To: <ZiYmpruU8JKuPVFb@pengutronix.de> (Sascha Hauer's message of
	"Mon, 22 Apr 2024 10:58:14 +0200")
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
	<20240422-v6-9-topic-imx93-eqos-rmii-v1-1-30151fca43d2@pengutronix.de>
	<ZiYmpruU8JKuPVFb@pengutronix.de>
User-Agent: mu4e 1.12.4; emacs 29.3
Date: Tue, 23 Apr 2024 08:46:42 +0200
Message-ID: <87il08k23x.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 2024-04-22 at 10:58 +02, Sascha Hauer <s.hauer@pengutronix.de> wrote: 
 
> On Mon, Apr 22, 2024 at 10:46:17AM +0200, Steffen Trumtrar wrote: 
> > When the eQOS on the i.MX93 is used in RMII mode, the TX_CLK must be set to output mode. To do this, the ENET_CLK_SEL register must be accessed.  This register is located in a GPR register space.   Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de> --- 
> >  Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 10 ++++++++++ 1 file changed, 10 insertions(+) 
> >  diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml index 4c01cae7c93a7..1d1c8b90da871 100644 --- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml +++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml @@ -56,6 +56,16 @@ properties: 
> >          - tx - mem 
> >   
> > +  enet_clk_sel: 
>  Krzysztof will likely write the same in a moment, but anyway:  Please no underscores in property names, see https://docs.kernel.org/devicetree/bindings/dts-coding-style.html 

That's what you get, when you just mindlessly copy existing property names :(
You are right, of course.


Thanks
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |


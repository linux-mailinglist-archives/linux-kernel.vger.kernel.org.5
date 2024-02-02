Return-Path: <linux-kernel+bounces-50616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB7847BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278B61F235A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892298529C;
	Fri,  2 Feb 2024 21:36:56 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBF47CF3F;
	Fri,  2 Feb 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909816; cv=none; b=iOlnJYuX9V/jRDbKpSQDlbVknX2qnA/n2OzoZZLRckPGt0ePLAxcm08ZRPHLoRAL6Q7SXsLjtRU0LxQ8qJ5oAenDm9YQ+bgHQC/Hs11vlFzIPJOw2SvUxXqhPpKjiTlEGPud0HYUc4R6QlZP2f6KdXtd2WdPh5gxUhhH+/UOWQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909816; c=relaxed/simple;
	bh=wcRhIvGHA+J82UxiABTG/8xiyiXgUs/xHOEBcQ1zOC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU7b5aZECH06uXXbwJcfh5VvXTq2cAcgpm5S1HUcU9d2zjJ7v5nt2x6qSYO+59fbje7TELorpUm6Nel9nUmz55iiH5zdFINl0WztmhLXE/LbYcAznnS/FIWW+S56jGgsO4cluuNG6hhX0rxc7FqSs1M/lCALmTrdFAOt6H10RdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rW1DG-0003VB-38;
	Fri, 02 Feb 2024 21:36:43 +0000
Date: Fri, 2 Feb 2024 21:36:39 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xfi-tphy: add new bindings
Message-ID: <Zb1gZ7BjJlGCw13Z@makrotopia.org>
References: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>
 <20240202212420.GA1561174-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202212420.GA1561174-robh@kernel.org>

On Fri, Feb 02, 2024 at 03:24:20PM -0600, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 09:52:20PM +0000, Daniel Golle wrote:
> > Add bindings for the MediaTek XFI T-PHY Ethernet SerDes PHY found in the
> > MediaTek MT7988 SoC which can operate at various interfaces modes:
> 
> This is v4 unless I'm confused[1]. Where's the revision history?

It's a new series only covering the XFI T-PHY driver.
However, I should have written a cover letter referencing the previous
series to netdev. Sorry for that and thank you for pointing it out.

> 
> Rob
> 
> [1] https://lore.kernel.org/all/b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org/
> 
> > 
> > via USXGMII PCS:
> >  * USXGMII
> >  * 10GBase-R
> >  * 5GBase-R
> > 
> > via LynxI SGMII PCS:
> >  * 2500Base-X
> >  * 1000Base-X
> >  * Cisco SGMII (MAC side)
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../bindings/phy/mediatek,xfi-tphy.yaml       | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> > new file mode 100644
> > index 0000000000000..e897118dcf7e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/mediatek,xfi-tphy.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek XFI T-PHY
> > +
> > +maintainers:
> > +  - Daniel Golle <daniel@makrotopia.org>
> > +
> > +description:
> > +  The MediaTek XFI SerDes T-PHY provides the physical SerDes lanes
> > +  used by the (10G/5G) USXGMII PCS and (1G/2.5G) LynxI PCS found in
> > +  MediaTek's 10G-capabale SoCs.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^phy@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    const: mediatek,mt7988-xfi-tphy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: XFI PHY clock
> > +      - description: XFI register clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xfipll
> > +      - const: topxtal
> > +
> > +  resets:
> > +    items:
> > +      - description: PEXTP reset
> 
> What is PEXTP?
> 


Return-Path: <linux-kernel+bounces-68652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CF857DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6465C1F27A69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD76212B166;
	Fri, 16 Feb 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iZOucqB8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1878691;
	Fri, 16 Feb 2024 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090843; cv=none; b=h1OUMlfxWNSBms5jfwq14DLur1cS/JkwagktF46q9y27veXhyfWqhrGYfzAJui6saW7c/l+LI8njyR0fVO5o3lZNgOppZvERNET+PS3NT26LJbz1rfuq8RyfIGNbIxXrURtCDucV1I/jTmo2X7N4A3jSlZepBrLAZ6bHsZLpE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090843; c=relaxed/simple;
	bh=hNzX6dDS/hbZQxh9BUHgA7vOQi6qxridm+BXtXVVHuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNPqNj8gCLwhkAvOQvfh8SDcY4N2LYT/wW9j3iY3C/q/vA6n7Thy2UaGv7FBxSjUilwD6aPAMTiRhJfLVZXWv/236E1g3tWuENRo0TPM93FmgIdSWWCiFQWkdSQXkHcowF6CMhJ1Ly1LphbiPilJRjF+95h+jOBws7/qvaSF7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iZOucqB8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GKVD50tTDfoR5AN5ZAfMW870T5tyYtBdIEeR8ZEXvJA=; b=iZOucqB8DUKXwKD16tvKpG+kbZ
	VH4PV+YSkBq/ECmL+M+4TUlerrWAWjIli7zFcXcPkD1fDi6ko3Haakd91S1vcxC0TmZW5tJxASFUg
	YmFgxC77XMCygGb8wPTJZ5KNxwHbe0NyfPcqJq71Y0rlX7BF7CT736E7pUhjZw3Ktvjc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raySP-007z4T-IA; Fri, 16 Feb 2024 14:40:49 +0100
Date: Fri, 16 Feb 2024 14:40:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Yang Xiwen <forbidden405@foxmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: net: add hisilicon,hisi-femac
Message-ID: <af8c6122-21ad-4301-8947-92f4687da09e@lunn.ch>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <20240216-net-v2-4-89bd4b7065c2@outlook.com>
 <170808424648.2323386.17364036307896639662.robh@kernel.org>
 <SEZPR06MB695975016141241B1B904F70964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB695975016141241B1B904F70964C2@SEZPR06MB6959.apcprd06.prod.outlook.com>

On Fri, Feb 16, 2024 at 07:53:05PM +0800, Yang Xiwen wrote:
> On 2/16/2024 7:50 PM, Rob Herring wrote:
> > On Fri, 16 Feb 2024 18:02:03 +0800, Yang Xiwen wrote:
> > > This binding gets rewritten. Compared to previous txt based binding doc,
> > > the following changes are made according to the TRM:
> > > 
> > > - No "hisi-femac-v1/2" binding anymore
> > > - Remove unmaintained Hi3516 SoC, add Hi3798MV200
> > > - add MDIO subnode
> > > - add ahb bus clock, phy clock and reset
> > > 
> > > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > > ---
> > >   .../bindings/net/hisilicon,hisi-femac.yaml         | 117 +++++++++++++++++++++
> > >   1 file changed, 117 insertions(+)
> > > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.yaml:
> > Error in referenced schema matching $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac-mdio.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: ethernet@9c30000: mdio@1100: False schema does not allow {'compatible': ['hisilicon,hisi-femac-mdio'], 'reg': [[4352, 32]], '#address-cells': [[1]], '#size-cells': [[0]], 'status': ['okay'], 'ethernet-phy@1': {'reg': [[1]], '#phy-cells': [[0]]}}
> > 	from schema $id: http://devicetree.org/schemas/net/hisilicon,hisi-femac.yaml#
> > Documentation/devicetree/bindings/net/hisilicon,hisi-femac.example.dtb: /example-0/ethernet@9c30000/mdio@1100: failed to match any schema with compatible: ['hisilicon,hisi-femac-mdio']
> Seems i forgot to rearrange these patches. Will fix in v3.

Maybe you can also improve your build testing.

We expect each individual patch to build cleanly, otherwise you could
break git bisect. So it is good the build your patches one by one. You
could throw in the DT checks as well at each stage.

      Andrew


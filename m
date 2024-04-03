Return-Path: <linux-kernel+bounces-129058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB37896429
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE80F284F38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BF487B6;
	Wed,  3 Apr 2024 05:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VUWmJBUv"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67846425;
	Wed,  3 Apr 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122518; cv=none; b=nodT2gLJJUTrjsH7SpQbChdWYeNI18eI53uQdQM9FgMYqqMrGtEO4jzg6i6hlKm/ihUl2iiVNWXaScGJiWBYpkDgG9SI6z/nA0GiV7UXwo46gTDF8QeOol08Rh87C2lI/Vw6ngwH9v5fpaKOQ7Cm0iDO3k6zR0nyHojhEq9EQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122518; c=relaxed/simple;
	bh=lMxvymsC09+6m8fLiId+kyMP7ByY8D87nMBeceHJKmI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TURopjuK1jWEKXK4GmOLINRAYFOmK+GFcSjKyVZFFxJvfpKG9SQcJAUIVhuT5lbZHsG4wwOR07Y2zPDjD7MxwG+8JDTbAWHPe/zvrRy/1lSliwQUBfHAHjwF1WDliZP42IunhrpCP+PoIy08U85Jp4KVcPSFxPqKb+b9F+GSxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VUWmJBUv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4335Z7gV069368;
	Wed, 3 Apr 2024 00:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712122507;
	bh=AL82zXtuvRcmpxlHne0BOkW4Z2nOXtBw/q/89BHzv+0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=VUWmJBUvVoplYWeGuTdknkAwSbea3JSfdMYPN31XZMWH2iRzYPh+LXWT8HjDAkjLo
	 w+U2Zpjpnff2TLeHbZ9W9pI2nhmUEE8HbKowORnc+llCRLTZPCExPwDQB/wKV0rrgk
	 ZitnZ5tyGVmvY5ZU0FASqvFWByViwbI1ZFAsLxng=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4335Z7TZ031875
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 00:35:07 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 00:35:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 00:35:07 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4335Z6rs059922;
	Wed, 3 Apr 2024 00:35:06 -0500
Date: Wed, 3 Apr 2024 11:05:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,am62p-cpsw-mac-efuse
 compatible
Message-ID: <aabea385-16e0-4116-a12b-3ce1e06574e3@ti.com>
References: <20240402105708.4114146-1-s-vadapalli@ti.com>
 <2e9b6a91-43d3-4b23-830d-40e607505d8c@kernel.org>
 <30065bdc-ccef-4610-b1c1-7661f801b8e9@ti.com>
 <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b1380a8-0136-4395-ba42-9bcff2e1bdb0@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Apr 02, 2024 at 08:06:27PM +0200, Krzysztof Kozlowski wrote:
> On 02/04/2024 14:30, Siddharth Vadapalli wrote:
> > On Tue, Apr 02, 2024 at 02:08:32PM +0200, Krzysztof Kozlowski wrote:
> >> On 02/04/2024 12:57, Siddharth Vadapalli wrote:
> >>> The CTRLMMR_MAC_IDx registers within the CTRL_MMR space of TI's AM62p SoC
> >>> contain the MAC Address programmed in the eFuse. Add compatible for
> >>> allowing the CPSW driver to obtain a regmap for the CTRLMMR_MAC_IDx
> >>> registers within the System Controller device-tree node. The default MAC
> >>> Address for the interface corresponding to the first MAC port will be set
> >>> to the value programmed in the eFuse.
> >>>
> >>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>> ---
> >>>
> >>> This patch is based on linux-next tagged next-20240402.
> >>
> >> Where is the DTS using it?
> > 
> > The current implementation in the device-tree for older TI K3 SoCs is as
> > follows:
> > 
> > 	cpsw_port1: port@1 {
> > 		reg = <1>;
> > 		ti,mac-only;
> > 		label = "port1";
> > 		phys = <&phy_gmii_sel 1>;
> > 		mac-address = [00 00 00 00 00 00];
> > 		ti,syscon-efuse = <&wkup_conf 0x200>;
> > 	};
> > 
> > The "ti,syscon-efuse" property passes the reference to the System
> > Controller node as well as the offset to the CTRLMMR_MAC_IDx registers
> > within the CTRL_MMR space.
> 
> Please reference upstream DTS or lore link to patch under review.

An example of the existing implementation in the device-tree for AM64x
is:
https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L697
It uses:
	ti,syscon-efuse = <&main_conf 0x200>;

and "main_conf" node is defined at:
https://github.com/torvalds/linux/blob/d4e8c8ad5d14ad51ed8813442d81c43019fd669d/arch/arm64/boot/dts/ti/k3-am64-main.dtsi#L40

Regards,
Siddharth.


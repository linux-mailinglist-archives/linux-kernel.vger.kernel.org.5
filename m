Return-Path: <linux-kernel+bounces-95863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750787543E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF839B23391
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E812FF67;
	Thu,  7 Mar 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lq+WBg8R"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E931DA27;
	Thu,  7 Mar 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829384; cv=none; b=FPHRU8kD853POyPLS3WsGWlRdfI8J1BUf6jmlOZNOUh/8iriOZitKhLfooVvF9W2ykhCl9NJZr06FOFRfJwyU8AidevY+e7ifA/DrVdVKx1/8EQ0inUv0r3e5dt8XFz9wWwdtVmYYWPcr3j9nuM4k3mD3ExivF+butVsEy+NFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829384; c=relaxed/simple;
	bh=G4o8N1NeVBsGufGC9BwR+lthg1Y27nwFooGVezVt96g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJPxf7Lo1gick0aXh7pec/+ZmhA514HJCmFKONE1gl7LuK5++0ph3DSnXn9BFkIjGFTNfhkVcDl3g4HgVMZkEhsiVCXHsyRzhyFPyTa/mNT16Sz7uvRcP35oB6Kr2dhm4KGtWO/pFc2UP36JwNPUoAGaiXOI5DSSLAALw1740XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lq+WBg8R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=1WYZfDzwGAqJU8Hrdq+9kEkrNFrZ6KcxJBYTknjo620=; b=Lq
	+WBg8Rw2WaS1YOsmUCo7vNALu8FOjy00Jh8uga9wQAeMe6/i+ZTIy1srpErzfiBiKhhqOVdN8UVrJ
	trWMH+8NcVOiLGbBc6DVL4LADHT9bo/n10u+oNxCQYcS+S0jK13geL+Qs7wZ6+aaEQnNMz6G8EOjm
	UjpjXfblZBSpIp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riGjV-009bQa-Ox; Thu, 07 Mar 2024 17:36:37 +0100
Date: Thu, 7 Mar 2024 17:36:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>

> >> +static int oa_tc6_mdiobus_register(struct oa_tc6 *tc6)
> >> +{
> >> +     int ret;
> >> +
> >> +     tc6->mdiobus = mdiobus_alloc();
> >> +     if (!tc6->mdiobus) {
> >> +             netdev_err(tc6->netdev, "MDIO bus alloc failed\n");
> >> +             return -ENODEV;
> >> +     }
> >> +
> >> +     tc6->mdiobus->priv = tc6;
> >> +     tc6->mdiobus->read = oa_tc6_mdiobus_direct_read;
> >> +     tc6->mdiobus->write = oa_tc6_mdiobus_direct_write;
> > 
> > This might get answered in later patches. PLCA registers are in C45
> > address space, VEND1 if i remember correctly. You don't provide any
> > C45 access methods here. Does TC6 specify that C45 over C22 must be
> > implemented?
> No the spec doesn't say anything like this. But, as C22 registers are 
> mapped in the MMS 0, registers 0xD and 0xE can be used to access C45 
> registers indirectly. That's why the driver implemented the above 
> functions. I agree that indirect access is slower and requires more 
> control commands than direct access. So implementing the direct access 
> of C45 registers will overcome this issue.

It is not just about performance. It is about compliance to the
standard. The standard does not say anything about C45 over C22. So
there is no reason to expect a PHY device to implement it. It might,
but its optional.

> > The standard does say:
> > 
> > Vendor specific registers may be mapped into MMS 10 though MMS
> > 15. When directly mapped, PHY vendor specific registers in MMD 30 or
> > MMD 31 would be mapped into the vendor specific MMS 10 through MMS 15.
> > 
> > So i'm thinking you might need to provide C45 access, at least MMD 30,
> > via MMS 10-15?
> Thanks for this detailed comment. If understand you correctly by 
> consolidating all your above explanations, the driver should provide C45 
> access to the PHY vendor specific and PLCA registers (MMD 31). As per 
> the specification, Table 6 describes the Register Memory Map Selector 
> (MMS) Assignment. In this, MMS 4 maps the PHY vendor specific and PLCA 
> registers. They are in the MMD 31 address space as per spec. They can be 
> directly accessed using read_c45 and write_c45 functions in the mdio bus.

Yes. I think this is required to conform to the standard.

> In Microchip's MAC-PHY (LAN8650), PHY – Vendor Specific and PLCA 
> Registers (MMD 31) mapped in the MMS 4 as per the table 6 in the spec.
> There is no other PHY vendor specific registers are mapped in the MMS 10 
> through 15. No idea whether any other vendor's MAC-PHY uses MMS 10 
> through 15 to map PHY – Vendor Specific and PLCA Registers (MMD 31).
> 
> I have given the code below for the C45 access methods. Kindly check is 
> this something you expected?

The code got mangled by your mail client :-(

> --- Code starts ---
> 
> /* PHY – Vendor Specific and PLCA Registers (MMD 31) */ 
> 
> #define OA_TC6_PHY_VS_PLCA_REG_ADDR_BASE        0x40000
> ,,,
> 
> static int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int 
> devnum, int regnum)
> { 
> 
>          struct oa_tc6 *tc6 = bus->priv; 
> 
>          u32 regval; 
> 
>          bool ret; 
> 
>  
> 
>          ret = oa_tc6_read_register(tc6, 
> OA_TC6_PHY_VS_PLCA_REG_ADDR_BASE | regnum, &regval); 

You appear to ignore devnum. I don't think you can do that. The core
phylib code might try to access other MMDs, e.g. it might try to see
if EEE is supported, by reading MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE.

	Andrew


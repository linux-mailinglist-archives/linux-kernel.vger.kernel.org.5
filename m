Return-Path: <linux-kernel+bounces-30723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9283238F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8EAB22BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137D1C01;
	Fri, 19 Jan 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="VdqIr0Fa"
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636515A7;
	Fri, 19 Jan 2024 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705633549; cv=none; b=cHw+xUYgO3NqU03FllzGbzJqGoF5axU8cIwrcb0LKuniCY2hdnnnttMox2GMnEqW6AnbVpXwRKMuK1fWECYQOrw+7GUXoCIwfDbtfCWY4ISzEwuILz5LAUpPVQWgsmnJmyEYwvj/UT2XNe5qv9gngjyIfNEHNmNUB+cNkJPd2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705633549; c=relaxed/simple;
	bh=MAH/+py/IyAwSUBrY2GBat3/b+orj4IxOAeho+Rq08Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VfG1k6nlkmAQRcDKBWJotIyWMxH1eTL4wTLEB7Y+WXjgasB4ARwW/XSrMiHcc9IwcatETOjM6euXSgGxomIhWCj7rsCQ0lNmLtX9JlISc3Vut5Hnk7k9vhgflyuRaiThTQkY64UwPIJ7lBkFsFAslDP0PLgcpj9eUyGI+kA5YSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=VdqIr0Fa; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 45EBB9400107;
	Fri, 19 Jan 2024 04:05:43 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id dsLRexoTBQ2g; Fri, 19 Jan 2024 04:05:43 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 16C8C940010D;
	Fri, 19 Jan 2024 04:05:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 16C8C940010D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1705633543; bh=XDyUQ14+bRC9vIc77iJw5gWqww9IgCSfjxNxBFV+/uY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=VdqIr0FaPJqNIRt2aCGNAvRF1dkYCOJEuhoWY3/irkhtU8ouz2kaQYFpPNJr18PRl
	 6dh+ndMzpu1SzzuxuJbFKHAwr4PeNd+KYKa6KbPMUXWdNh6SnqITLCd0xjLeM7u5wT
	 gpkGLQU+RdFPcI15Dp8q6aphgQ491LqB5+S/X6wlC809uxx4D8CuumELr49S4+PGMA
	 HBBdeQVy6oFgyZtsaafmmDsuBxc+4ma8iYHY8PyrRvELyaC2oJZHytwNfrittCesHR
	 nCfISRmlWpMlxx0Pwfy4dlX5JlbLLT4or5qaLkODZYcr3gKvqDQrzyGhPNAMsds6dN
	 iPl/7FSm8lbyg==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VDT-1pSJ9P0D; Fri, 19 Jan 2024 04:05:43 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id B434E9400107;
	Fri, 19 Jan 2024 04:05:42 +0100 (CET)
Date: Fri, 19 Jan 2024 04:05:29 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
cc: Andre Werner <andre.werner@systec-electronic.com>, andrew@lunn.ch, 
    hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
In-Reply-To: <Zald7u8B+uKzCn42@shell.armlinux.org.uk>
Message-ID: <48245ebe-babf-52ec-407b-9ce32ffe24d2@systec-electronic.com>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com> <Zald7u8B+uKzCn42@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Jan 2024, Russell King (Oracle) wrote:

> In addition to Andrew's comments:
>
> On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
>> +static int adin_config_intr(struct phy_device *phydev)
>> +{
>> +	int ret, regval;
>> +
>> +	ret = adin_phy_ack_intr(phydev);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	regval = phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_MASK);
>> +	if (regval < 0)
>> +		return regval;
>> +
>> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
>> +		regval |= ADIN_LINK_STAT_CHNG_IRQ_EN;
>> +	else
>> +		regval &= ~ADIN_LINK_STAT_CHNG_IRQ_EN;
>> +
>> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
>> +			    ADIN_PHY_SUBSYS_IRQ_MASK,
>> +			    regval);
>> +	return ret;
>
> 	u16 irq_mask;
>
> 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> 		irq_mask = ADIN_LINK_STAT_CHNG_IRQ_EN;
> 	else
> 		irq_mask = 0;

Unfortunately, I can not do this, because that phy ask for read-modify-write access to
registers and some bits in this register are already set after reset and
should not being modified.

>
> 	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> 			      ADIN_PHY_SUBSYS_IRQ_MASK,
> 			      ADIN_LINK_STAT_CHNG_IRQ_EN, irq_mask);
>
>> +}
>> +
>> +static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
>> +{
>> +	int irq_status;
>> +
>> +	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND2, ADIN_PHY_SUBSYS_IRQ_STATUS);
>
> Probably want to wrap this - if you're going to bother wrapping your
> phy_write_mmd() above because it overflows 80 columns, then please do
> so consistently.

Done.

>
> Thanks.
>
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>


Return-Path: <linux-kernel+bounces-102982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21287B96F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794E1283AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39064D9E3;
	Thu, 14 Mar 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XLg29xJo"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394C6BB56;
	Thu, 14 Mar 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405758; cv=none; b=n0zpEDXaNj5pFFlwTUdI3j4G07ZdkqxaBpSoSPxTaPyP+X0XCtWzyFTT3JUVEoMay3I3gifHVGxIcdXIX1YYPNwUABWkc6dr21S4FdWaOA+wOQ5cf99qoula1jpb3wbw9b5oEiHdV3Oa5uDkzQKL5bKCyI5e6Fr8o4KIEkNcYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405758; c=relaxed/simple;
	bh=V09Ma465F/F2Vxs9nvGPBppS3VEn8cxbnQDIcVk3LPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6gLVdBGy8+zhnMHffWkmWGrbXGyqtPifp4fhzuqtz9AePcRwssYJfHwStEyJMkcbFv8qSGsA0Z5oothNA3Zt2uDnSX/1SvsXJO6kK7TS1XUEPWL2NNRZ53+iLNVH2d3XauKB8EbA2SZVuP3RPM2IPNza0q7vJgk3dAdzMf9TlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XLg29xJo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cgbDTfEgEvEt8XT1jVPZh5fA/uBgksTawcns0Z7+nws=; b=XLg29xJoElFHyNco9ZF1wU+aYh
	pMsseZBR7m6lcEw86f/wn96fjQKOzQEySBdC2bs1Z5WnqY6lQeG4IlAF0qlyr/wULCuN8jRlOxPTz
	gTIpEq4B8daoJHVxBdMSNazW7JZmjZgpHywSeNfIwRJ6V6dHFsACg7Y3oQIqpuU21BdxxTmFca7i2
	oFW1lL4P8yMo0Aou7f2F9q8bAgWI5dZ8TFIugRtZJobG3NWCu04ATBpmmm9L8fUc6mnuaYLVxlztK
	3eWKFTCYA0K9ms40Vp1BoAXMpM+SiTed3ycSZ4p4x2dX1CD2XZ5F4QwwnYbTLTX/LclHGE6kQBpHh
	bpIRp1qQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53884)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rkgfV-0000FG-1i;
	Thu, 14 Mar 2024 08:42:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rkgfT-0005Jx-As; Thu, 14 Mar 2024 08:42:27 +0000
Date: Thu, 14 Mar 2024 08:42:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH clk v2] clk: clkdev: add error messages for name
 exceeding maximum length
Message-ID: <ZfK4c/wZX9RmBHXj@shell.armlinux.org.uk>
References: <20240314023909.871105-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314023909.871105-1-duanqiangwen@net-swift.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 14, 2024 at 10:39:09AM +0800, Duanqiang Wen wrote:
> if one device register clkdev with dev_id or con_id
> greater than maximum length, clkdev_create functions
> will not return err, but clk_find functions will not
> match the device, it's difficult to identify issues
> for developers.So add error messages for dev_id greater
> than 20 characters and con_id greater than 16 characters.
> 
> eg. clkdev_create(clk, NULL, "i2c_designware.16796")
> it will create clk_lookup with dev_id "i2c_designware.1679",
> because clk_name exceeds dev_id maximum, but clkdev_create not
> return err. when driver call clk_find functions, use "i2c_desig
> nware.16796" to find clk, it will return failed,but I don't know
> where the problem is. It took a long time to find the problem.
> 
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

This looks like v1 just reposted with a v2 tag. I don't see any obvious
changes in the patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


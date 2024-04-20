Return-Path: <linux-kernel+bounces-152179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9558ABA51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0358F281F04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43614A9F;
	Sat, 20 Apr 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZIjrckF6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195A134BE;
	Sat, 20 Apr 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713602248; cv=none; b=oyp8BbYLJ8iWIBj93w1oiNKnIFeqiI8lDmM9f03MuJ5wgVY/eVeAv99LCz/7uNtmO6ZwPYem8TS+xiA33YxskE9E0UElXSoq1iVdNfkZSn2JjbDM7e2UyOgQ7TU+WuPAqH0TAKCyw7TxIpPMnGovdkntHmEUxPdhxFuAsew92T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713602248; c=relaxed/simple;
	bh=pR41IxiqLUAoH+5KghyDbWvO8rxNhT9gOKkhaNznKQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozKFXj6YcaQEPWNTBz0yl7qTd4RwczGTesMOy9qtuvhGBO+fBMQpK//DKsFnLl0hwDMRMvUmm3PQsPuGFPyMyOkH6LeWgwpvZA2ICbeIXw3fOjcoXYG0ep1zfPjiyvA45XN2r88nr6/1tAOUUp0X5eRGGiwXnxuCfcsQ7dzq/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZIjrckF6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1PYQHneja0E79ojR73BwgQXJbhXd4M/m787FMcA0gBo=; b=ZIjrckF6gOgjT0ULtQcRrnPTvj
	Kiq0gMPC4AOdVTS+Ewq0sjSyFV2T13DErUoPP6L7f+PV4fxTdItPAD5Ea4OeGll/S8FNwKdScHQlz
	cTYu+HISSxfyViEmxJzm9f8JTjTYkGFRg1+CY5a9TdAsDE/a5DasNhIf2s4PX0LRwb6Q2hXAo5O92
	0v58Ex+UwnnOJDrAbvpXEYbecTHlkn70mxebfofXXu2FghO141qIwegVVLMjNTiPMq707C/2UEcAL
	nQ2LmpYBzO+2CwuB9dzGjKYmDEvT5BZKl4dczOu2XkinCO/07kYwgiLs7yP8cVJsi8x6EgkHoX81c
	mNgKLYWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47398)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ry6Db-0000DC-2c;
	Sat, 20 Apr 2024 09:37:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ry6DU-0000S0-8n; Sat, 20 Apr 2024 09:37:00 +0100
Date: Sat, 20 Apr 2024 09:37:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: renjun wang <renjunw0@foxmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: update fields of mii_ioctl_data for
 transferring C45 data.
Message-ID: <ZiN+rBvYQ6vktNCW@shell.armlinux.org.uk>
References: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Apr 20, 2024 at 08:41:10AM +0800, renjun wang wrote:
> The phy_id is used as u32 type in function mdio_phy_id_is_c45()
> with the 30th bit for distinguishing C22 and C45. The reg_num is
> also used as u32 type in function mdiobus_c45_read() or someplace
> else. For more C45 information needed and data structure alignment
> consideration, change these two fields to __u32 type which can make
> user space program transferring clause 45 type information to kernel
> directly.

You haven't understood the user API, and are making a change that will
break existing userspace users of this API. Hence this is not
acceptable.

mdio_phy_id_is_c45() is indeed for determining if the "phy_id" field
in mii_ioctl_data is indicating a clause 45 transaction. This checks
the following bits, defined using these macros:

#define MDIO_PHY_ID_C45                 0x8000
#define MDIO_PHY_ID_PRTAD               0x03e0
#define MDIO_PHY_ID_DEVAD               0x001f

and all of these fit within the __u16.

The format used by userspace pre-dates clause 45, and bit 15 was
added to indicate clause 45 along with the "prtad" in bits 9 to
5.

However, the kernel translates this data structure into something
that the MDIO accessors can deal with. See for example phy_mii_ioctl().

Also note that the old method of shoe-horning clause 45 into just
one set of mii bus methods has gone, meaning there is now no need
to convert from mii_ioctl_data into a 32-bit reg_num.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


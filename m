Return-Path: <linux-kernel+bounces-4501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0421817E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20CD1C21CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41072760B7;
	Mon, 18 Dec 2023 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S5ch7WhD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D951D14D;
	Mon, 18 Dec 2023 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ku82/a/J+0bFtIhYsVynfUEnaLEMFdenmJjJZ6ZQ1P0=; b=S5ch7WhD3leBOYhM3tR6+E2r/f
	vxE8UMfVsIbHLqtrP+yrS1J8Zrx2f1Wzh0XTsZzt4VPcZouwEz42d367o8/y9hImHwzVagfr2AqS3
	oFp3OmWN7HCNm4YoqcJIVPbklQbEOjukXlSnSqI/kP7vOzMfrtV4qmEuOVquqUNQ3ueM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rFNID-003HgS-0h; Tue, 19 Dec 2023 00:45:01 +0100
Date: Tue, 19 Dec 2023 00:45:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: Add BaseT1 auto-negotiation constants
Message-ID: <89f68405-2506-420b-952f-a168ebcb4d73@lunn.ch>
References: <20231218221814.69304-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218221814.69304-1-dima.fedrau@gmail.com>

On Mon, Dec 18, 2023 at 11:18:13PM +0100, Dimitri Fedrau wrote:
> Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
> auto-negotiation advertisement register [31:16] (Register 7.515)

Hi Dimitri

These two patches look good, but...

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

Also, its normal to include a user for new APIs. Do you have a driver
which will make use of this to advertisement modes?

Thanks
	Andrew


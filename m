Return-Path: <linux-kernel+bounces-146908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2D8A6CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A6928424A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D7712C55D;
	Tue, 16 Apr 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zaU4dryC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B91272AA;
	Tue, 16 Apr 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275218; cv=none; b=D+BJOgZz9v+7pavhxp320MbUdPZ0/EFDuj+/ZgfaqJXla3Bjss3XEGsTYqN1PVxOqq3KBCWcJzJhl/TTjP3aN9vnJu1i9Oc+TJIM+oBZVBXzNDn6hjaQf/Kab8R+hpxuLHomIfjHmoV235JMcoxoZhZrE88rTHGP3+BoZyJTtrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275218; c=relaxed/simple;
	bh=UFZS2qhw3Gwe+c8wfAS9gjs/ftg/X94cDZM2MpqoPnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfUNch0AL0YbYVNpStKxCUHI7jYhDZd18LRDoSapYWSdMrwNyDVWzxj+SPE2Kd0lAqUAI7jBHaf7aHe3M9+ea8CZGYmtO3yswTdIriIvmmD7KGBrQqZKyRIRxuTppsWQrvnqigVc5FcpwSsHY2hKnXX7qjon1swnlXQHFJpAF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zaU4dryC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kvfisbNrUr5sf0S3A1nPCGGsrN3i5lCUqXwLFDIDJxc=; b=zaU4dryChTbyn+h5fpt/46J1rO
	ZWaTM9ZCNkBg0FOdMH661xyOE4pMiI7WKHLbw0t5ng66WnojzXZEze5V6zyrZfYbHSzmhqBDGZ1SE
	cgYLgiXAaqwMMvKAuAeUaVvm6V3LJRBqiAkt5ibC3qPBEm0GUpw0Kj9mBVkMQlEX9BPY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwj8d-00D8ld-OM; Tue, 16 Apr 2024 15:46:19 +0200
Date: Tue, 16 Apr 2024 15:46:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416121032.52108-3-eichest@gmail.com>

On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> Add a new device tree property to disable SGMII autonegotiation and
> instead use the option to match the SGMII speed to what was negotiated
> on the twisted pair interface (tpi).

Could you explain this is more detail.

SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
the symbols 100 times when running at 10Mbs, and 10 times when running
at 100Mbps.

    Andrew


Return-Path: <linux-kernel+bounces-42020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51EE83FB0F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C442845D5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D545958;
	Sun, 28 Jan 2024 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RtIyJvUI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC814446C4;
	Sun, 28 Jan 2024 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485624; cv=none; b=k1fHkL5Nnx7rgHK9HnobvjvoTVVQlfOLVWWnoJultZn++ASFs9zohQWHuIA9gXfM/2C73bkXiHhAymX9kcD46dOuL0OkJYiUo/HXDPeMmYyKIxCEXDiUuK1NwBnIazP6oNo3xVLWWVk76/Vph8FjD11k8Nk6HFptJXSKAXp1pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485624; c=relaxed/simple;
	bh=D2h64xB7AeRWmzjQSt1q8TAHRk2bn1nMAKpKMVYIHio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf9L3FwxmGZqeqkdwiHJM3KvdeUFGvxR+gL5lyyTaJka6g/+T3RfuYpkiicaC+x5u4e/pq2vEuhcymZb8BjDKnh3SD+ImRAgeSFOtPRIjKvabU6QSex8jR1geO+PUvBdofDp/EJpEqiezvgpmKUyc+86IiO/TmI9YQvbrK1BLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RtIyJvUI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wi4DY+VFGMM6e16v/KYzVlwiaiEMggoMeZ5w7ONc4ug=; b=RtIyJvUIiNfZdvnjeHXdNFjEVR
	nWMFyywvSmUodtAfjGuIEGJ4nzzbt5NeRj5Ow269ddTY3kVq9kFIkj7fh6niexqMzzLTsyKGsU0f3
	eyPB2rSoP4RRi8XUF7XM6roi8se7sQpT7mtX3RS0UK7c02NiQzE6SB8990b/kb6vIHik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUErW-006Kh4-8H; Mon, 29 Jan 2024 00:46:54 +0100
Date: Mon, 29 Jan 2024 00:46:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/5] net: phy: qcom: deatch qca83xx PHY
 driver from at803x
Message-ID: <63049fa6-5216-4095-9f7b-04fd7995604b@lunn.ch>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120451.31219-4-ansuelsmth@gmail.com>

On Sun, Jan 28, 2024 at 01:04:24PM +0100, Christian Marangi wrote:
> Deatch qca83xx PHY driver from at803x.
> 
> The QCA83xx PHYs implement specific function and doesn't use generic
> at803x so it can be detached from the driver and moved to a dedicated
> one.
> 
> Probe function and priv struct is reimplemented to allocate and use
> only the qca83xx specific data. Unused data from at803x PHY driver
> are dropped from at803x priv struct.
> 
> This is to make slimmer PHY drivers instead of including lots of bloat
> that would never be used in specific SoC.
> 
> A new Kconfig flag QCA83XX_PHY is introduced to compile the new
> introduced PHY driver.
> 
> As the Kconfig name starts with Qualcomm the same order is kept.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


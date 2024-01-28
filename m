Return-Path: <linux-kernel+bounces-42017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D111583FB06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706AA1F2420B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35EA45955;
	Sun, 28 Jan 2024 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LID84rZs"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737513D3AC;
	Sun, 28 Jan 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485181; cv=none; b=jb9H8qcyv37+2vl5vgz1U4jVVDB5yHUoHGu8lT1GcaPhaBMW7NV1UjsH59WXHjVz2PxTKo4DDRIbhSLQ0DXEclV7kuY16zuTWqHIM558Q5ORgJK5Gmkmhfs04F7cb68m7a5yqCTtJsARMFZ+naTHxorI94To856OaZkQexM34M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485181; c=relaxed/simple;
	bh=klv3vuQo+hb1m3+FMLbRAXN16mOaWGAEUwEnkNLUEcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddJZ8wk4Oo/0KmwocMdmU8F/h2oCJKOWp7pT+aUezJydApJ0TsHSXCj6Ymy0EWi2B+BDSlL+BYBZD0fPEOZ9YJ37Di18jaK4uYpcVqWQRjPmQD8/qcMvC8f3B/EJCK5Afd6I1gWIKKQFvPWqATrjTh6BKkbnmtgCWUtUoeEBJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LID84rZs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LPsssRBPx5Z2pwuu2CcC7LuTz0azAkBhhjHkZHAuu1Q=; b=LID84rZs8jKYNNHqMqKLZ+J8+V
	OSeyA/ULZfiSX4KNVKQ4sV+Ww1AGoHKzg8rybh8MTLJClUuPeQHwLsndKtV36FtgLwSGd0yq+CBP8
	tBCzb51/2Fp/adBzaexfi8/L8fE9UZAjo+3q8NqpMeXMRz3Aj4u/9LjdIbULOyhJfhQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUEkC-006KeH-J0; Mon, 29 Jan 2024 00:39:20 +0100
Date: Mon, 29 Jan 2024 00:39:20 +0100
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
Subject: Re: [net-next PATCH v3 1/5] net: phy: move at803x PHY driver to
 dedicated directory
Message-ID: <5d76636c-0737-4189-81f6-b87a03aa5f24@lunn.ch>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120451.31219-2-ansuelsmth@gmail.com>

> @@ -36,7 +36,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
>  obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
>  obj-$(CONFIG_AMD_PHY)		+= amd.o
>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
> -obj-$(CONFIG_AT803X_PHY)	+= at803x.o
> +obj-y				+= qcom/

nitpick:

Please could you insert qcom before qsemi, so we keep it correctly
sorted.

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


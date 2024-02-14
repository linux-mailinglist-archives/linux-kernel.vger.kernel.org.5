Return-Path: <linux-kernel+bounces-65765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A948F85517E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C466E1C20A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641D12B16E;
	Wed, 14 Feb 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2HNwF6UK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45F129A74;
	Wed, 14 Feb 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933592; cv=none; b=ZMVT+IDGZ4PAirn8YRK/MS/pUyKWkHYHpG9H5yt0zHlGnPewzOwIy/Tbxyki79OWEbYJZhiHyz+sMUZ2T2UqId4tyMXykO9JdqNRNwAc/40oBORRT67mlpKKswEeZNskwkI8I34JlTAjeZKh2p4wqwvIcYujX/FS2xDAbIsX//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933592; c=relaxed/simple;
	bh=Dw80zWF0tvaZHmJNlHE2DtcVDtrIsNwJTAzdsUiupMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hmi+R7X4iyR/puFj4SEBaDG5whrj+phDYIv8vtOAdWMc3TLRRQKCzbZmjweI8yR89LHWOz16Iybb+y/DhpsyC+3SQUvjrGvPXo0SeMtsPYF00jptC+s8+EUSD8iPw5bOygujxOA+baa4G73rNs64yaHtA4JTwoSLorzswsHsPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2HNwF6UK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yjuukyO4NH4wsNzuTW5ue6r+n30kuSgrhuoOPD109OA=; b=2HNwF6UKBKiic0namuggXLVlyU
	4qjx0KcFXgjRJPIwjskhhQ6QMSfPRGDmRixexwIvmhQuvBEjXgLW2uposRZOQFQG6hExTpRrpOzDN
	DD+avU+cZ/c7VFh9iu9N9h+QWrPSkXSlHyv/PU/2fKLhc1n3sjikVNaQT7iaagCgHcvM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJY1-007oVd-O1; Wed, 14 Feb 2024 18:59:53 +0100
Date: Wed, 14 Feb 2024 18:59:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
Message-ID: <6fd8e93d-a391-4417-b282-e2018338d077@lunn.ch>
References: <20240212115043.1725918-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212115043.1725918-1-robimarko@gmail.com>

On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> Currently, we are checking whether the PHY package mode matches the
> individual PHY interface modes at PHY package probe time, but at that time
> we only know the PHY package mode and not the individual PHY interface
> modes as of_get_phy_mode() that populates it will only get called once the
> netdev to which PHY-s are attached to is being probed and thus this check
> will always fail and return -EINVAL.
> 
> So, lets move this check to .config_init_once as at that point individual
> PHY interface modes should be populated.
> 
> Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


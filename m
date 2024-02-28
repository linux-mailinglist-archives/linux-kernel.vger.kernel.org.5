Return-Path: <linux-kernel+bounces-85502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8086B6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33C7287702
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E640840;
	Wed, 28 Feb 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N5jYBfzS"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD279B83;
	Wed, 28 Feb 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143485; cv=none; b=WF7vzJRbaFjGvDgR4OKRtMetAV7cG6rOIFa7BQbm7tXxJVhKFzKE2Hhk5yd8GdZt1VajpK5AHe3ojTHRPMtlGS8ImtLnrpZ90JwyJG5am/PWlsRv0oVS2WkMlKZEgwg1N80oIIMz/229LPl5ry5mteEWRk2VdLXtRjEnoVvJapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143485; c=relaxed/simple;
	bh=2uZdEhXlLk6+Kihsqf5ShsnH4PpiXM/DSq0L4fxdcpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mirRT9crycp9g/VrY0pTPjBPsfJTEzdJ6L5S1x99vAWq5PjZwg2IJWz7zmikayzw3lzx/e0WyYlgZx2oa3y16IS/U08621rzsXpBkYK7nakVYplilwRvwNkjdsICVjGV2SDzIzP2iwSz61huzScxujMayjOJ/iTKcOba+4JvGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N5jYBfzS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4+3pSytnWQjK2YQrwpnYoErWsk0+5Bb2EK+jBbCnDEY=; b=N5jYBfzSgjDXobOuvQqxkmYWXk
	QImWXO4epRecr8Hcj7XH3FLIrGE9iMM5iGF1FoQtTTQLFwSeZCqZXQeTjo4mKQddHn5esiTlTg3rd
	DK1la7jWyH3cZYkfBITOKjSGJ7mJGHrDVQSZCn7kpsJqrjtj5Gwb+3Y52zRIZDHLMPSxqnT/BtbXo
	Luq6yWLSD1MoRZWOd+174E5Nt7zmTmBinvHjZZ92sYUc6xCPIepBYkcztiBhZAZJJM05JCMZKJf3I
	XNL1YJ1yzNbZkuIHozFSWERD3azo29pn98mFdU86Vh1+F/EScaRDJvfkoVZaORqtBEVAZkMT1BnwI
	YMVhPAsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33306)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rfOI6-0005QG-33;
	Wed, 28 Feb 2024 18:04:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rfOI4-0008Ul-6h; Wed, 28 Feb 2024 18:04:24 +0000
Date: Wed, 28 Feb 2024 18:04:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: fill in
 possible_interfaces
Message-ID: <Zd91qM1W/srGL/Jw@shell.armlinux.org.uk>
References: <20240228172452.2456842-1-robimarko@gmail.com>
 <20240228172452.2456842-3-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228172452.2456842-3-robimarko@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 28, 2024 at 06:24:10PM +0100, Robert Marko wrote:
> Currently QCA808x driver does not fill the possible_interfaces.
> 2.5G QCA808x support SGMII and 2500Base-X while 1G model only supports
> SGMII, so fill the possible_interfaces accordingly.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


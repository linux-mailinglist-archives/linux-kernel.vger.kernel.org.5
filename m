Return-Path: <linux-kernel+bounces-30331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C5E831D39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D893D285034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFFB28E2E;
	Thu, 18 Jan 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TbyIEquI"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE171E88F;
	Thu, 18 Jan 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594055; cv=none; b=fsP6MmQJsgX6oJVe88blqP4nw3TffwOKHY+pB+3hQhLOWvDWYJEBwVn0j9Ft2KfDuh7fF4wwuMW1Cz2F6gfmc9zk9YlAw7ei2shBuLYhDsEzo9DRY2raxu++/Pwb7CDnioaCkJc6n1skghYEvfgWi1MBc+vNoQIsu1pviQLsJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594055; c=relaxed/simple;
	bh=3T7ZxFRZznZp33Uckeh26hwEA7gDX3RAmrrvqu9q1j4=;
	h=DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Sender; b=L8bikQ4e+DbJmyBEfaRsuCfOxe3/XW38kteclhbTA0r4lk5wLUDZvlBIa/FXpgbq5DK8jcwzQicZrai1d0CokxxTAzlJkksS/aWdfFeyZIokEpZbHXQN3z71Yx2ucK++4TJmKzpjEwWYIBWvUeNI/1mQA1tbnIy3w37EVlFXQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TbyIEquI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kDnqCJc6DdlPkC0AYd50uBaKkZtlxVtjgN6JvECPsPU=; b=TbyIEquIRD1S0207D7QoRD0DZL
	wLyxrQ/QjWvcHfkRlGyM/4Tdrxxn0s1i1I3VAkS40hYxblU7YWvT1WHTjzjPxQ9Uh3Vuy/T8xnAg/
	IifACYSU2Gq+h7UzcW8tbSsVybtg1J04beB2tcbE1QTQ3QwXBSaQ6GjyuVhoa98K3XjZetCy4PtAp
	afDHhcUkrDzMUe/lKBxfAIQkErTweyAL3Nt++bKUeKzABf170xeixEQXstZzOjp1UxuAtpIrWe75o
	NXXqFBjyESoZwj01ZABE+QFTPwmnCDSkstL7hPTG66NXtI8iGWm+icZHfTzl3zo7MhzDOaGFHYaeW
	kSr+xOzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52464)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rQUvC-0005rd-1f;
	Thu, 18 Jan 2024 16:07:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rQUvA-0005qW-AB; Thu, 18 Jan 2024 16:07:12 +0000
Date: Thu, 18 Jan 2024 16:07:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1
 aliases to fix hctosys
Message-ID: <ZalMsJZKrpwncEDp@shell.armlinux.org.uk>
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 18, 2024 at 04:01:10PM +0100, Josua Mayer wrote:
> HummingBoard has two RTCs, first integrated within SoC that can be used to
> wake up from sleep - and a second on the carrier board including back-up
> battery which is intended for keeping time during power-off.
> 
> Add aliases for both, ensuring that the battery-backed clock is primary
> rtc and used by default during boot for restoring system time.

Given that the snvs RTC isn't battery backed, should we even be enabling
that in DT?

Also, have you seen any issues such as:

[    0.933249] rtc-pcf8523 0-0068: failed to set xtal load capacitance: -11
[    0.933505] rtc-pcf8523: probe of 0-0068 failed with error -11

which seems to be exhibiting itself on my SolidSense board?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


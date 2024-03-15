Return-Path: <linux-kernel+bounces-104852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD9F87D48A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9D284C48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC01EB2C;
	Fri, 15 Mar 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HCT3565W"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93850A98;
	Fri, 15 Mar 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531669; cv=none; b=SKhg1h7ikniLBmyg+mwBgTLmA+gT81ctDz3BDXb3kEw3WyUFaA5xhRxmy8PopHcHp8LIWZHQiauBzsCsSPs8bakd2JmK1tkGYzYZDcmRdv9wlyRj8NvVvbQiHRAUliSbGEqCN/Ye120DjQynKB/p8lEZ1DQsH7SXJHUZKkUFExY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531669; c=relaxed/simple;
	bh=wQsKLQ0NdCX2RthTgxbE0btGJZJeMYEad4qWY4DsOr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3EIjsXl3wk/fSs1ff0x5Hd3d7VaGEaG3Dcf9CCioDaYu4xHHoUtysQNoLzzBoPcWBcnQKCaT47Cxlsq8xGIDjqG6Y3CepyFqdZoHJMiVcskSh3ddq4nGcAu+Yl/94NALLj+aPEeWPk09IdlQ/RSAj9CwD7zm7CbpUGX5XQ8hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=HCT3565W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vMOcpYICmwo4NpAZCDNBpaBc/6gPeBk9CzUAQqBpilA=; b=HCT3565WV5UxuJ3TBs/5syfKBE
	V4P9LDnldEV0tQWyqel0o8jOh+aKI8AlpYnEbVxA7zJBobmemldHUiWr0ejxKyJAYlZwnazE3HrzF
	SvNajAtxCYWSpwQT1q74WfBLYSzZv+Bn8ylGD75grqz7+ShKh70Zq+CppW6zOK6vWS7QJ+JB6yzUN
	9xulcBZzWxk9I2FHGmk+RnY24ugj/5WUYifvv/kYEV4O4XxTIOjgXoB/eAF2TvlabFTsNB3BukIKU
	2p3EiIYFFdAwfIj9kEku9Y3b3jC1kcNfi3MhoW+57jSkjJDDyp9+pmOCxgplf3WdWbBNZwUnVyP1G
	qcEkNW0Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36238)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rlDQI-0001va-2k;
	Fri, 15 Mar 2024 19:40:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rlDQG-0006dz-Ut; Fri, 15 Mar 2024 19:40:56 +0000
Date: Fri, 15 Mar 2024 19:40:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 2/8] w1: Add w1_find_master_device
Message-ID: <ZfSkSPD4dMe7qqhy@shell.armlinux.org.uk>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-3-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-3-ayushdevel1325@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 16, 2024 at 12:19:00AM +0530, Ayush Singh wrote:
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index afb1cc4606c5..ce8a3f93f2ef 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -673,9 +673,9 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
>  	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
>  						sl->family->of_match_table);
>  
> -	dev_set_name(&sl->dev, "%02x-%012llx",
> -		 (unsigned int) sl->reg_num.family,
> -		 (unsigned long long) sl->reg_num.id);
> +	dev_set_name(&sl->dev, "%s-%02x-%012llx", sl->master->name,
> +		     (unsigned int)sl->reg_num.family,
> +		     (unsigned long long)sl->reg_num.id);

This is a user visible change likely to cause breakage. I know that I've
written programmes for reading the DS18B20 temperature probes that
depend on the sysfs device name remaining stable. The same is likely
true of other program authors.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


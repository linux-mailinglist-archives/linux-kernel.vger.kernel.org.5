Return-Path: <linux-kernel+bounces-91176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8678870AA7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FC1283968
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406279DD7;
	Mon,  4 Mar 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jncod8sh"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE479DC1;
	Mon,  4 Mar 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580454; cv=none; b=YmZQIyOu3sZ753EbEpOho+SWSds23IvNKSYNwR4IVgC3OoHkIjeinrN7wA+i4bavAQmntduCA9RdZOfTb9oT/FA3uvvrGcOncjLxBLgWocT5g0XB9OESqZcKdcvVnJhDeMfD1eF6FecPsMvb2oSUZMrTIykzGPXGyf8ccr1mlO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580454; c=relaxed/simple;
	bh=hANRgoNVGaZU4rZ+XDQgnMgAvRmbrD9MTNHj1xOU1c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABTt1oL4VkweFKeYZc7KpX0SMuLOeOa7+RZj7MXgSdP+cMOOevd/6NSsEeJxx/mrjBceFBxlSxK5wOUauqo6K825lEafns3hLaPrtlynYnUaG0ABNdgO3WmqGyRibgPhB/rPjgcBvDTzo3oZhDQJsEtBHZIMY0p/+QJ+6JzKxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jncod8sh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UFjQCiD5weQa18oNxEgo6gN7ayWqxgCNs3etg8HITds=; b=jncod8shLs0Tc/C6HJKYzYW0FL
	whcy1kq9S4e4SzhZtcuVjoJi8h3RAeSBt10loUEBobfjZJiv5zsZgO9eiJZ1NFduO3gNnp9axoWzj
	L2Ve3H4G/UiNhOEnqA/fvtDA08pijJ/ziBxzNoo9s+Fue7z+cumBoPlBzthwfhkIWsaLeSnNaOecE
	42C5dgx/Ap3QwpnWBUkC5aemWKxa+h/M0LRcw92juQWPHI+ujIvX2KJHHIIf7oZw7jySo6EqB3t3c
	9VMG0XO0TfY6Md0Zvv1uoflF0L1zzKzSlop8UW2CXm3pGsRCC4K+2fEftfrctASnKHhOd75i79CmP
	3GxQiZTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39752)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhDy5-00069q-17;
	Mon, 04 Mar 2024 19:27:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhDy2-0004id-Dg; Mon, 04 Mar 2024 19:27:18 +0000
Date: Mon, 4 Mar 2024 19:27:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net] net: phy: qca807x: fix compilation when
 CONFIG_GPIOLIB is not set
Message-ID: <ZeYglnW6/k0nvmiL@shell.armlinux.org.uk>
References: <20240304192244.2924407-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304192244.2924407-1-robimarko@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 04, 2024 at 08:21:36PM +0100, Robert Marko wrote:
> -	if (IS_ENABLED(CONFIG_GPIOLIB)) {
> +#if IS_ENABLED(CONFIG_GPIOLIB)
>  		/* Make sure we don't have mixed leds node and gpio-controller
>  		 * to prevent registering leds and having gpio-controller usage
>  		 * conflicting with them.
> @@ -749,7 +749,7 @@ static int qca807x_probe(struct phy_device *phydev)
>  			if (ret)
>  				return ret;
>  		}
> -	}
> +#endif

I know it makes for a bigger patch, but #if is not equivalent to if()
in terms of indentation, so the indentation also needs to be changed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


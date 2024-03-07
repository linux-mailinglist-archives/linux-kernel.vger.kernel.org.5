Return-Path: <linux-kernel+bounces-95545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36AF874F42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7A2283133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4C12BF3F;
	Thu,  7 Mar 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGr/UAip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56B12BF11;
	Thu,  7 Mar 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815125; cv=none; b=NcV77b09193P+UXmzpHLDv1cNB0O52seuQY7da8C7DZohF4LCgPv3hbmQl601Uw4rV7NVvd0lgmx6LLRltO3IZzf4vfQzwf3rEs8cxSvS+2aIh/g8TZ4Tg/VQ+s23g51297nu5aQRFW6HKA2YBI08nkwZk87lSBpJ0TKSK5aPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815125; c=relaxed/simple;
	bh=F+017n9B7NfetYykURBMitm53Dt/nbKvyxwK1iWVCh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgWOsl69ybu9+cbFHh8hfy2FFarhoXFkGjGQjhyBrYeVIdHCnQIzMdlYZdY+D73Jm1FBit54c+MbmBdNa0wfqpw85uTjgzBnpcYr+lgIzDhP4dto+Wvct4Vy3gnew633RM81RfDdX7tlruoElQkGcW+xp1HPq61Jestwo875/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGr/UAip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB16EC43390;
	Thu,  7 Mar 2024 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815124;
	bh=F+017n9B7NfetYykURBMitm53Dt/nbKvyxwK1iWVCh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QGr/UAipPL9hRG7YlXhccjACz/IAUzkKLO4yTNHUo1Bex3q1xN/56azgRPvIKhCPk
	 ikByu0vjE9989eRpzNO/RaWEuXuAMWqqjLJ/iz8vv0quSnCB6Wzt2mK1iCqH4BvUob
	 17/82OrsjRIhz2AeC/IZyElXmFC1DdKJCA9ym8jQKA/kbv/aeObuMKSj4kmUToV868
	 RaLMny1Ks3BbCleotgnBg2IL+DUcsLbw0XGDPZX77I6jeMpqfjrgf3gG1vPXG/ZGI7
	 cVDjc3nNescefnfoZviAXWyzpyqzHl3FyIiDx6p7PNk6PqMoNWYGjxI9xihlkulADr
	 G002ZaCvhUGjQ==
Message-ID: <bc361325-1510-4fe0-a7ee-bc5be0a1b4cc@kernel.org>
Date: Thu, 7 Mar 2024 14:38:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] usb: cdns3-ti: pass auxdata from match data to
 of_platform_populate()
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240307-j7200-usb-suspend-v4-0-5ec7615431f3@bootlin.com>
 <20240307-j7200-usb-suspend-v4-5-5ec7615431f3@bootlin.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240307-j7200-usb-suspend-v4-5-5ec7615431f3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/03/2024 11:55, Théo Lebrun wrote:
> Allow compatible to pick auxdata given to child platform devices.
> 
> No compatible exploits this functionality, just yet.
> 

This patch could be merged with Patch 7 so we know exactly how auxdata
is used?

> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index f76327566798..29fb24c811b3 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -62,7 +62,8 @@ struct cdns_ti {
>  };
>  
>  struct cdns_ti_match_data {
> -	bool reset_on_resume;
> +	bool				reset_on_resume;
> +	const struct of_dev_auxdata	*auxdata;
>  };
>  
>  static const int cdns_ti_rate_table[] = {	/* in KHZ */
> @@ -95,6 +96,7 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *node = pdev->dev.of_node;
> +	const struct of_dev_auxdata *auxdata = NULL;
>  	struct cdns_ti *data;
>  	unsigned long rate;
>  	int error, i;
> @@ -149,7 +151,9 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  		goto err;
>  	}
>  
> -	error = of_platform_populate(node, NULL, NULL, dev);
> +	if (data->match_data)
> +		auxdata = data->match_data->auxdata;
> +	error = of_platform_populate(node, NULL, auxdata, dev);
>  	if (error) {
>  		dev_err(dev, "failed to create children: %d\n", error);
>  		goto err;
> 

-- 
cheers,
-roger


Return-Path: <linux-kernel+bounces-161933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C38B537E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EDA1C20F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4B17C79;
	Mon, 29 Apr 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cx8ZJd96"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66DC2C8;
	Mon, 29 Apr 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380827; cv=none; b=vGXj9E4wMqBaXp3btfGJYQVWf3zNcnvGoq1xwtpo3zcafV//4yBCIplf5WhVGUth0/CSjRZJqrcksQ+zajX7Pau1MV8o3cr66HhUgRrPbd9q949Xgzd02rq8oHtxLW/lW0ruf+MI/AjceyPQ1kKr00rzj3qmPDvTQdLYt0laLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380827; c=relaxed/simple;
	bh=XxJMGad54tR9sirQj06vDhJW0TOP5mpqMJiFYt+RuPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ipM1+vYFuaYs3sNBwOHjF+1jXS1C2SlEDHup3aQcWn0NAlzPsH/GS/zPV4sa+GUD5byTqbq0DiE8xFiPgwF9G6vKgnlNvrDcp0j8XwfF6dLpaMJc/5Hc2QNT+4wty0cd2ZRD3j0jz60DOdmNK4QnchHyQzhrGzFhijDcCWKTYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cx8ZJd96; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T7ixZ9007532;
	Mon, 29 Apr 2024 10:53:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=PDnBIULbsSxakTpOd1Nm1WtFrD4kcum3r6evgJ4f4ys=; b=cx
	8ZJd96Uhy5fsInDA28xxjsDp188fEYLlEWtAt6Oe1LxNo3O6j1QyWLiHHiGYuJ57
	y3WtM0kRFbKbkeqRJ2Q2up7MfiST9GM/suENhxKwlO7PLFl/4bIYOgq2hOLdZEKU
	m5PE2G29eymm6Xl9xFrxOy7GOENbjgvF2mNKAX06OlsLkhUudwemF1ueAgsCTUnU
	KUmHHPKMGzKPAFTVtoGnC1ToIlHWgEXk3mY1PIzC+iQtSxybuPh3k6N4U9v6UuMy
	3ZSccP+1zXRPv3xFzTHjLCTiRpkPstvmUh61P0ACcaDSOCua4zVzkKlzBsbepBAY
	IozdqzjusGz4+6Algqmw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xscahufgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:53:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AD1524004B;
	Mon, 29 Apr 2024 10:53:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3E7D6216837;
	Mon, 29 Apr 2024 10:52:35 +0200 (CEST)
Received: from [10.130.72.241] (10.130.72.241) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:52:34 +0200
Message-ID: <d2432381-827f-4825-a450-9954f8291576@foss.st.com>
Date: Mon, 29 Apr 2024 10:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] media: i2c: st-mipid02: replace of_node_put()
 with __free
To: R Sundar <prosunofficial@gmail.com>, <sylvain.petinot@foss.st.com>,
        <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>, <javier.carrasco.cruz@gmail.com>,
        Julia Lawall
	<julia.lawall@inria.fr>
References: <20240427095643.11486-1-prosunofficial@gmail.com>
Content-Language: en-US
From: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20240427095643.11486-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02

Hi,

Thank you for your patch.

On 4/27/24 11:56, R Sundar wrote:
> Use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release and to simplify the error
> paths.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

I was not aware of this kind of auto release mechanism. Thanks for
bringing that to my eyes.

Now I looked in /drivers/media and couldn't find such structure. All
drivers seem to follow the goto error_of_node_put style.
As I'm unsure if we want to introduce such magic, could either Laurent
or Sakari comment on this ?

> ---
>  drivers/media/i2c/st-mipid02.c | 37 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index f250640729ca..d42a306530f3 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -715,31 +715,28 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>  	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_CSI2_DPHY };
>  	struct i2c_client *client = bridge->i2c_client;
>  	struct v4l2_async_connection *asd;
> -	struct device_node *ep_node;
>  	int ret;
>  
>  	/* parse rx (endpoint 0) */
> -	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
> -						0, 0);
> +	struct device_node *ep_node __free(device_node) =
> +		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 0, 0);
>  	if (!ep_node) {
>  		dev_err(&client->dev, "unable to find port0 ep");
> -		ret = -EINVAL;
> -		goto error;
> +		return -EINVAL;
>  	}
>  
>  	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
>  	if (ret) {
>  		dev_err(&client->dev, "Could not parse v4l2 endpoint %d\n",
>  			ret);
> -		goto error_of_node_put;
> +		return ret;
>  	}
>  
>  	/* do some sanity checks */
>  	if (ep.bus.mipi_csi2.num_data_lanes > 2) {
>  		dev_err(&client->dev, "max supported data lanes is 2 / got %d",
>  			ep.bus.mipi_csi2.num_data_lanes);
> -		ret = -EINVAL;
> -		goto error_of_node_put;
> +		return -EINVAL;
>  	}
>  
>  	/* register it for later use */
> @@ -750,7 +747,6 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>  	asd = v4l2_async_nf_add_fwnode_remote(&bridge->notifier,
>  					      of_fwnode_handle(ep_node),
>  					      struct v4l2_async_connection);
> -	of_node_put(ep_node);
>  
>  	if (IS_ERR(asd)) {
>  		dev_err(&client->dev, "fail to register asd to notifier %ld",
> @@ -764,46 +760,31 @@ static int mipid02_parse_rx_ep(struct mipid02_dev *bridge)
>  		v4l2_async_nf_cleanup(&bridge->notifier);
>  
>  	return ret;
> -
> -error_of_node_put:
> -	of_node_put(ep_node);
> -error:
> -
> -	return ret;
>  }
>  
>  static int mipid02_parse_tx_ep(struct mipid02_dev *bridge)
>  {
>  	struct v4l2_fwnode_endpoint ep = { .bus_type = V4L2_MBUS_PARALLEL };
>  	struct i2c_client *client = bridge->i2c_client;
> -	struct device_node *ep_node;
>  	int ret;
>  
>  	/* parse tx (endpoint 2) */
> -	ep_node = of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node,
> -						2, 0);
> +	struct device_node *ep_node =
> +		of_graph_get_endpoint_by_regs(bridge->i2c_client->dev.of_node, 2, 0);

Shouldn't there be a '__free' here too ?

>  	if (!ep_node) {
>  		dev_err(&client->dev, "unable to find port1 ep");
> -		ret = -EINVAL;
> -		goto error;
> +		return -EINVAL;
>  	}
>  
>  	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep_node), &ep);
>  	if (ret) {
>  		dev_err(&client->dev, "Could not parse v4l2 endpoint\n");
> -		goto error_of_node_put;
> +		return ret;
>  	}
>  
> -	of_node_put(ep_node);
>  	bridge->tx = ep;
>  
>  	return 0;
> -
> -error_of_node_put:
> -	of_node_put(ep_node);
> -error:
> -
> -	return -EINVAL;
>  }
>  
>  static int mipid02_probe(struct i2c_client *client)

-- 
Regards,

Benjamin


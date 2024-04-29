Return-Path: <linux-kernel+bounces-162839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F98B6142
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26D7284134
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27288135405;
	Mon, 29 Apr 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OLXnqBpe"
Received: from msa.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32610134725;
	Mon, 29 Apr 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416140; cv=none; b=c5qMg4tdWags7FLgeabS53bwb0fDs06gwoG/99Axp+h3v9LRub2G+ZPekm2jPMA1oHIxCinxjUDBat94IyHvadWzURxjIIfAhetYtv/45G0+8emSh/GQPulQ3NeNURVPtU2aSx/qHDHwjKJOKk7/nRI0u83XDCvai7nctRZhlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416140; c=relaxed/simple;
	bh=iEqKds8978Vw53F6+gIayrgICTbvNUp0FZfkv8g8X9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxVrOuq/Y/gDV1zSh3Uj9gxGaMs425HidZxpmMtux8k9aVBSEv3z5qXMAS2s1+mfO4dqFSUd4eX8hd80cSxpo/0W1/JZKYEE/GHD4eG2t1ZYFtPGJ4/OY3W1WZFNia3Yf66eIP2mKUOCmzrYjFKOOhC72i+BIXw4oUm+Zy1TZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OLXnqBpe; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1VvxsPXSuHa8W1Vvxso5Gw; Mon, 29 Apr 2024 20:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714416062;
	bh=Lw+0wwwgkPuPooUBjrUaQWJD8aF8/Gl4n3le/MiBo/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OLXnqBpeo/FVEpFz8kyco8u1g3XGhVWRrFluugAY/EMsA4Yb3HJaGkMnZ87vN7zCQ
	 uZAE2c1/skwhrjtRtXUBH24rkp41EsCpKoUwaZpTe0ieuPpsV9OitSWmv1UuISOI4k
	 O5nNljnOid/J1dUFVhSUmOOWwe4I3AIvx3nIclm7SL1N0wL1hJxhDeva6yjxDS8ijG
	 0QgRd2nCpzBZyoT0jRJLLnD8xqhjxRrh3kpYPyyQdgSBeQZJ4K9kPKJFjAa1DJsYxt
	 O2NXNujaXWWUjZ6kYnoc6cfGdKsOssUXEuUSWrXSynUfTsfCby7gbE+oSAiLYnzOEj
	 EWvblyYeMQJlQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Apr 2024 20:41:02 +0200
X-ME-IP: 86.243.17.157
Message-ID: <6df5d715-3e31-40a5-9db3-2c3b9f12efac@wanadoo.fr>
Date: Mon, 29 Apr 2024 20:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] media:cdns-csi2tx: replace of_node_put() with
 __free
To: R Sundar <prosunofficial@gmail.com>, mripard@kernel.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240429171543.13032-1-prosunofficial@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240429171543.13032-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/04/2024 à 19:15, R Sundar a écrit :
> Use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> ---
>   drivers/media/platform/cadence/cdns-csi2tx.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c b/drivers/media/platform/cadence/cdns-csi2tx.c
> index 3d98f91f1bee..88aed2f299fd 100644
> --- a/drivers/media/platform/cadence/cdns-csi2tx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2tx.c
> @@ -496,48 +496,43 @@ static int csi2tx_get_resources(struct csi2tx_priv *csi2tx,
>   static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
>   {
>   	struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
> -	struct device_node *ep;
>   	int ret, i;
> -
> -	ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
> +	struct device_node *ep __free(device_node) =
> +		of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
> +
>   	if (!ep)
>   		return -EINVAL;
>   
>   	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
>   	if (ret) {
>   		dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
> -		goto out;
> +		return ret;
>   	}
>   
>   	if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
>   		dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
>   			v4l2_ep.bus_type);
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>   	}
>   
>   	csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
>   	if (csi2tx->num_lanes > csi2tx->max_lanes) {
>   		dev_err(csi2tx->dev,
>   			"Current configuration uses more lanes than supported\n");
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>   	}
>   
>   	for (i = 0; i < csi2tx->num_lanes; i++) {
>   		if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
>   			dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
>   				i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
> -			ret = -EINVAL;
> -			goto out;
> +			return -EINVAL;
>   		}
>   	}
>   
>   	memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
>   	       sizeof(csi2tx->lanes));
>   
> -out:
> -	of_node_put(ep);
>   	return ret;

Hi,

Nit: return 0; ?

CJ

>   }
>   



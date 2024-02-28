Return-Path: <linux-kernel+bounces-85488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49286B692
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04011C23D96
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522D79B9C;
	Wed, 28 Feb 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKZhhflH"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA579B8B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143095; cv=none; b=BIyoKN//x7bjoFxunXjwBi5BDa69klr4EbL3PkOogBByPXp5nQ9CqAZ/vlV740+SheHlMMZsipWqkJ5u0qtsY0/vZFJCJuikIgW+kEg+cXUPGPKR2uOeu2lg957e1Zw0J8+wS9XyPaF1jINc5Yxx9EDOItdfeL1RXOZltZpdoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143095; c=relaxed/simple;
	bh=cwZiV52W0Y4J4E8o/fpSdIpBIClZMIEQbiWW06NOSag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/BbBH87cz0zB84VnxFr+BQvF0Y9dXkUcI6PD+4x9b1IqDKcL98iyoEQ/vBjmxy3tBaC0BLHHMTJD2/YEc6zpnr3zHxUR/gMyE60cYMsFvz09MWfosdQ6y+46sJESeZED5IHNgvgb90D7VTCj3+GrsDx1tqSAffQ7ciqPaUC2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKZhhflH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso1211948e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709143091; x=1709747891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jJWhDy/4v7p6ijvXOsuvAzvYiBXZd1/Rbd71b95v5s=;
        b=HKZhhflH8oebgM1wEmzKZCTJ10RlHHrhICV4QIzMsB4cxSowyjldig2JJG9bvwicQw
         PhzEAHNxM6jTSgMiNKqEbRKV0N0DdS/nzWgPmH+h4ZW5CEIsNMvgJuLVOn3KlxLeXBtV
         4x1o0ztGHAQWLX9bFzEgRSN9jBSWUoid5Q430C0SN3I2MFJ60TjDbE2h81QbCOUrDJjZ
         lCq54VZFvJCF9Z9j1U/eaVjK1cs0NNuSFSJTFfIRmQ9Qxf9WLGPuChNe+BfyvaRjot3h
         lt1dYi3T7YVhLTsY1XPBvHnwLWVEBs223CJsPKAfMSegPeV5gkQUThNVWmAd9cmSRSBG
         R4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143091; x=1709747891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jJWhDy/4v7p6ijvXOsuvAzvYiBXZd1/Rbd71b95v5s=;
        b=V5Asj2qvO/4MHVpyka7Ywq9/r92CXngJiNNxPcQ/gU3rtkft4CrtnqokcpWBfwahTQ
         7WaCR8C/ghtcsgmOD5UrHe9xRxu6oBqUEiz38ZQytxTfwLmUyL8dKFPiDMt9ldfdP51z
         C1AxECExdixmkVusuMYeyFarizc3SIlaO4ueuF+AsMss+dF1cj0iot7o69dk9RCwcdPZ
         BXgKFxbIXW6LAjxRXNM4kjDZjfZoAarOGjbrMQPXOs7kwYrDgW3P9NAk7aNQocuhVGke
         DcotZr7RxWCM9iXrpYdydW0KeDW4xnirdSGpwYJUEXwKIjYn1FAwNAUh+AwRXA4KcALr
         tnuw==
X-Forwarded-Encrypted: i=1; AJvYcCUeOeQHbUq6mPWDs59YKHJQeVcSRJ1LAyh7RJZ115O6iAWNkmVCQEb0TthJQJJfgoIYnLoRMR8nEYFmOeqBhfO6Fy+4MmNZYCpzqI9M
X-Gm-Message-State: AOJu0YzvXS5kUQ9aXjkd6R/cQcanr2QByGa+F4lpUIyaJghkpvtGcbXg
	hzpYXvQMGUfvpR4u0OPeFqmiefnoLHKe6s88apiXkVMqZWZGPRS4HIboRKPmXY8=
X-Google-Smtp-Source: AGHT+IGeMb8GvdN1GKFJ44gE1Wrb49Q1GOwh8I5mdv3/2IvchNoaxUJcJdry4KzXQeujNBKsOdl3zw==
X-Received: by 2002:a19:ae05:0:b0:512:c9bc:f491 with SMTP id f5-20020a19ae05000000b00512c9bcf491mr269277lfc.47.1709143091336;
        Wed, 28 Feb 2024 09:58:11 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm12637657wrb.68.2024.02.28.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:58:10 -0800 (PST)
Date: Wed, 28 Feb 2024 20:58:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <9ea38811-4297-424d-b82c-855ee75579f0@moroto.mountain>
References: <20240228150735.3647892-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228150735.3647892-1-lukma@denx.de>

On Wed, Feb 28, 2024 at 04:07:35PM +0100, Lukasz Majewski wrote:
>  void hsr_debugfs_rename(struct net_device *dev)
>  {
> @@ -95,6 +114,19 @@ void hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)
>  		priv->node_tbl_root = NULL;
>  		return;
>  	}
> +
> +	if (!priv->redbox)
> +		return;
> +
> +	de = debugfs_create_file("proxy_node_table", S_IFREG | 0444,
> +				 priv->node_tbl_root, priv,
> +				 &hsr_proxy_node_table_fops);
> +	if (IS_ERR(de)) {
> +		pr_err("Cannot create hsr proxy node_table file\n");

Debugfs functions are not supposed to be checked.  This will print a
warning when CONFIG_DEBUGFS is disabled.  Just leave all the clean up
out.  If debugfs can't allocate enough memory then probably this one
debugfs_remove() is not going to save us.

> +		debugfs_remove(priv->node_tbl_root);
> +		priv->node_tbl_root = NULL;
> +		return;
> +	}
>  }
>  
>  /* hsr_debugfs_term - Tear down debugfs intrastructure

[ snip ]

> @@ -545,8 +558,8 @@ static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
>  };
>  
>  int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
> -		     unsigned char multicast_spec, u8 protocol_version,
> -		     struct netlink_ext_ack *extack)
> +		     struct net_device *interlink, unsigned char multicast_spec,
> +		     u8 protocol_version, struct netlink_ext_ack *extack)
>  {
>  	bool unregister = false;
>  	struct hsr_priv *hsr;
> @@ -555,6 +568,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	hsr = netdev_priv(hsr_dev);
>  	INIT_LIST_HEAD(&hsr->ports);
>  	INIT_LIST_HEAD(&hsr->node_db);
> +	INIT_LIST_HEAD(&hsr->proxy_node_db);
>  	spin_lock_init(&hsr->list_lock);
>  
>  	eth_hw_addr_set(hsr_dev, slave[0]->dev_addr);
> @@ -615,6 +629,18 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  	if (res)
>  		goto err_unregister;
>  
> +	if (interlink) {
> +		res = hsr_add_port(hsr, interlink, HSR_PT_INTERLINK, extack);
> +		if (res)
> +			goto err_unregister;

You need to add the iterlink port to hsr_del_ports() to avoid a leak in
the remove() function.

regards,
dan carpenter

> +
> +		hsr->redbox = true;
> +		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
> +		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
> +		mod_timer(&hsr->prune_proxy_timer,
> +			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
> +	}
> +
>  	hsr_debugfs_init(hsr, hsr_dev);
>  	mod_timer(&hsr->prune_timer, jiffies + msecs_to_jiffies(PRUNE_PERIOD));
>  



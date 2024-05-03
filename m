Return-Path: <linux-kernel+bounces-168402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FD8BB833
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ACCEB22D31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E2584D1F;
	Fri,  3 May 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmg+Qkhh"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEC2C684;
	Fri,  3 May 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778693; cv=none; b=eOKZBSB684f50bqzjhSwQPuSJNGDgbr3PwxkystAR/6qylkSSHyBK4KrYX7GGd+NnYItvJIJcLLkSAzUtwtxEeVK9+nT+dzbqBdWOI8neYxLrNINgcClVZGHSilbup1yCoOZCv1m+9dotLNhwibKcsX0lyvA7fD4gRdPJQh2PtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778693; c=relaxed/simple;
	bh=qclEhbjs4p5LooWWIIlcQpj4kOjZk4MS39jW0HLkkV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdMRmE3B4tkoVilHaU02WOoV/9gTR5W95FLOHxPCHv2WIR2r/REEB+AInQKVInzpn2SS6SzY+H7TIu9IZa8INDxOe1S7GOPfVW4cYNw+/Oce1jHhRHo4cYJ5gKRpU2z49gl3zu5NP2k5ACOaVd65lYsCKAxrvIu0uF9T1M0ylfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmg+Qkhh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b37731c118so174925a91.1;
        Fri, 03 May 2024 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714778692; x=1715383492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zxymg49wnQnWbf83jyaR1CKpeQDHM/PXDFjlZvx0Qco=;
        b=Pmg+QkhhffSr1t7XwwsAaI/K/7Df7xmfP0mqPTT/IkA1uPQlJDd44vB/gkrk6uFPkr
         GFqrFSVzrZf3GSidHCuMD54wTiJzV73MTNqpTDos3OgZtAjWT/klJ0oavwui/H6gd2YX
         GpS2J2IZOsAyA3oKZo1xXJh9s3Lw6DJmacI60nDDVhlzFIyHLTbKpCXchLOb+4VvH0Ds
         UdlDENRyfz9354EYjF/GWBmgyagfwIwCyaO/2sKFC3bocmlILfvo1EkxbA2Vc+dLhs37
         t9nQHu+BGaNw/hKMOcQNdsb9dg6tlrlmgkW/7TtRwkJDw70jIy6p0BBagTBVN/S+D0z6
         1aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714778692; x=1715383492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxymg49wnQnWbf83jyaR1CKpeQDHM/PXDFjlZvx0Qco=;
        b=WEXidji5w4jSS0uuFfzKnq+XV2BUWtFgRSbOlLnmZNuGz5RvUY6e3ZdTnTaC9OdCte
         MzfqA8+/9DzSZONMYJiXJMRnO4zK0VwBsje5pdaJ1RrzoDx0JOeQcpKZTPCVX5XIbibv
         vBinquVNet5x5hl2l39Qg57w9JZTw3est+T5e9eiULHmztYcKH22yQ5kDIYV4M5ptgIE
         yihjaLDkKLDN6FKP1Cclnhb68GCEgPV20eXb9gr1uU7I8kgab1TlshIjm5umqVsNmRr8
         iM9UZk7eLTHFR/rGcC/lFY8unsfP6vCQZ4chCjkivqLgHvnXYEXx1Q47xExGUPKaehsZ
         hyeA==
X-Forwarded-Encrypted: i=1; AJvYcCVU9ZPFKO03hYRlcv+giT/TvzlPEbM4A4Tx7FqyMiHMZlsP1i8sJKjHWMfeM1lCOaVcuFvlF6fJi5rHzD4G9sHVCOd2/pt/HE/r3Yvbfr4DSOQj4lGC6PrPzZcw331c1wBXoWqi
X-Gm-Message-State: AOJu0YyKlckKw7l4MfOKJ+v1SQCo8gZGbVpPFucpo/MWC9Wu5OTtie3e
	J5+Uah/1EnnbUFqLLTGL6aQeSLCzTITmM00+DYHE3ra2tXWrp8QP
X-Google-Smtp-Source: AGHT+IGxCwwvgKhmpQnaCfyMGcWHVdltXWH3wJbc3BOIgjokebdcoiSqW15sgMz82ocYpdwWJ2hu5g==
X-Received: by 2002:a17:90a:d382:b0:2b4:3a1e:2400 with SMTP id q2-20020a17090ad38200b002b43a1e2400mr3803786pju.18.1714778691546;
        Fri, 03 May 2024 16:24:51 -0700 (PDT)
Received: from joaog-nb ([189.78.25.116])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001ecc9a92e1csm3791177plo.267.2024.05.03.16.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:24:51 -0700 (PDT)
Date: Fri, 3 May 2024 20:24:45 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-nuss: create platform
 device for port nodes
Message-ID: <20240503232445.oayegsi6au7qxgpl@joaog-nb>
References: <20240503200038.573669-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503200038.573669-1-hiagofranco@gmail.com>

On Fri, May 03, 2024 at 05:00:38PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> After this change, an 'of_node' link from '/sys/devices/platform' to
> '/sys/firmware/devicetree' will be created. The 'ethernet-ports' device
> allows multiple netdevs to have the exact same parent device, e.g. port@x
> netdevs are child nodes of ethernet-ports.
> 
> When ethernet aliases are used (e.g. 'ethernet0 = &cpsw_port1' and
> 'ethernet1 = &cpsw_port2') in the device tree, without an of_node
> device exposed to the userspace, it is not possible to determine where
> exactly the alias is pointing to.
> 
> As an example, this is essential for applications like systemd, which rely
> on the of_node information to identify and manage Ethernet devices
> using device tree aliases introduced in the v251 naming scheme.
> 
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 1d00e21808c1..f74915f56fa2 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2091,6 +2091,13 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  		if (strcmp(port_np->name, "port"))
>  			continue;
>  
> +		if (!of_platform_device_create(port_np, NULL, NULL)) {
> +			dev_err(dev, "%pOF error creating port platform device\n",
> +				port_np);
> +			ret = -ENODEV;
> +			goto of_node_put;
> +		}
> +
>  		ret = of_property_read_u32(port_np, "reg", &port_id);
>  		if (ret < 0) {
>  			dev_err(dev, "%pOF error reading port_id %d\n",
> -- 
> 2.43.0
> 
> 

Reviewed-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Regards,
João Paulo Gonçalves


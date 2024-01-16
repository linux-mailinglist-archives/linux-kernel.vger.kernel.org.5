Return-Path: <linux-kernel+bounces-27524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADBD82F191
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AA51F21A11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F71C2A8;
	Tue, 16 Jan 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0AYddCs"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6E1C293;
	Tue, 16 Jan 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-557bfc7f7b4so15186121a12.0;
        Tue, 16 Jan 2024 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705419090; x=1706023890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=221krRC7ofdY5easyx6siY67EfytMAH1SLyippKO7Co=;
        b=E0AYddCsaF0sfNaFsqw7NtBBuJoRY/A48tPjGVMOBKCPydfTtT0uU08Q4MYYMZwHKV
         /vvcyFLRX4a0QIU8pdsUZDmphtGHWWBRn2MzaRHinDtB9EAe31UbFpo0xPfyTn8xowTR
         pShfbBJxuXs3Vm1Sdy2c/WktFHDcwrLOzNibZEkzD6Q/Ro6Wgj0HI7AIl4OM6e6cBjyg
         NdflzjK4fGyX0FLIrSOu/PR2/DesaGfY6Kw+6Z8U1wmpZTEOmgBxK5PpUYDcyUsyYc65
         ok9r38IlCwU6SDkvrzw8rLpOPG56ZKIwd1/+46sx+AlrIgawgMuW9TmuRGlAY1lNNBSl
         aR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419090; x=1706023890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=221krRC7ofdY5easyx6siY67EfytMAH1SLyippKO7Co=;
        b=HkOplTRmhiWYFs1a62Wqcg+KaYMJiB1YGdrGDsy6UAIY59GBLpLd90DyrZJkyv2Cce
         OHCusP/3q4tI+XXv91alZd6J+7DuboCpGBNNPmRQTb2JBF7jW05qpquFQ/wtQv4sGkCl
         QJwspE3Sn6fOl1peao+sHD1pCMfTPGZgc5BSIqlwgZ+GPz7iaH2sO9nOxxWxOejdzg+k
         /uppiFPQjYfajUK/lxFUNB9OpG/AEdp2TAtXmxMPBtT49kCDihZPmBBMy0Zu/s32LFBg
         fkzzqzOlfauBo9rSIIQnE7N9VnTlzFKKYv/1OqtjKiaJH2E8L5BizUwJ18TVqcZsS7zE
         sgHQ==
X-Gm-Message-State: AOJu0YyPX9RVAzfBv0eSNWv27vhS0aRzLzosAOtCeBHOQdXs9pB7jTrk
	GQqJX2c24ANfF4OjQIn7QGA=
X-Google-Smtp-Source: AGHT+IH81ggMzsMJewkzpiK9FDnFaE4IbraNVrgUR68q8MTRoXnaAfE5cLC2RtGvw4RcPXngEliWew==
X-Received: by 2002:a17:906:5595:b0:a23:5939:759e with SMTP id y21-20020a170906559500b00a235939759emr7341358ejp.26.1705419089650;
        Tue, 16 Jan 2024 07:31:29 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm6648899ejt.4.2024.01.16.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:31:29 -0800 (PST)
Date: Tue, 16 Jan 2024 17:31:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com, andrew@lunn.ch,
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
	f.fainelli@gmail.com, hkallweit1@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	pabeni@redhat.com, sd@queasysnail.net,
	syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH] net/dsa: fix oob in dsa_user_prechangeupper
Message-ID: <20240116153127.ctjrxkvvchlgpbkx@skbuf>
References: <00000000000002faa2060f02e766@google.com>
 <tencent_293767377D86CBF3726365497A43BD445205@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_293767377D86CBF3726365497A43BD445205@qq.com>

On Tue, Jan 16, 2024 at 10:56:26PM +0800, Edward Adam Davis wrote:
> If the private data is not allocated memory when generating an instance of 
> struct net_device, i.e. priv_size is too small, then its corresponding private
> data should not be accessed.
> 
> Reported-and-tested-by: syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/dsa/user.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/dsa/user.h b/net/dsa/user.h
> index 996069130bea..9a40918ee7fc 100644
> --- a/net/dsa/user.h
> +++ b/net/dsa/user.h
> @@ -53,7 +53,11 @@ int dsa_user_manage_vlan_filtering(struct net_device *dev,
>  
>  static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
>  {
> -	struct dsa_user_priv *p = netdev_priv(dev);
> +	const struct rtnl_link_ops *ops = dev->rtnl_link_ops;
> +	struct dsa_user_priv *p = ops->priv_size >= sizeof(*p) ? 
> +		netdev_priv(dev) : NULL;
> +	if (!p)
> +		return NULL;
>  
>  	return p->dp;
>  }
> -- 
> 2.43.0
> 

The problem has been fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=844f104790bd

pw-bot: rejected


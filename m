Return-Path: <linux-kernel+bounces-19364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A329D826BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C938D1C2220B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06CE14019;
	Mon,  8 Jan 2024 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8xPtpx3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6814011;
	Mon,  8 Jan 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so22163035e9.2;
        Mon, 08 Jan 2024 03:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704711604; x=1705316404; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIBng4JuVPQpSbSQKIOiqlRMBF+3n9xAglfgloRNirA=;
        b=J8xPtpx3Yex3X/nxfPx3P5ScTW24ZXW3qCv63lVuiV9zZ/U9Fk4UE3IHICg9ZgN6yz
         1kKFSk7LVgpRjn3u8cHmAwDKxtxYAplsW02YdWuYBSzqVsJRpZbZV86UNrGBw4QyxPXT
         9uuHZK9XLjF2S0SsOetOFwJlNAbNFrOLxORsGl53eL0Vhs2WyKRMuQ3sQKc3xW8czOiG
         1l+EHe68vZrZ5nJ/41jujQwSL4V7F1Ev8cWL2ie1+eOEKKqHYdoAtutDIGQep+VN7cRQ
         iSXY5Zw8yDbYheUhubtYhMSn5qZwnv3VRPQ8vcPeA22ITcyFi34oTCqWzM6NJZCLwlLT
         YxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704711604; x=1705316404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIBng4JuVPQpSbSQKIOiqlRMBF+3n9xAglfgloRNirA=;
        b=GtJnMKBbJW3B/VRiX+SpQ+875UD7fUSw9w7KXRHY50ecQDubLp/OG7DYpRilfPJXS0
         Bm/sXkDhC+lsftTm/A7sEKXaTUsTUtty9b5HQuv3Ogod5C+zwfoq08OUoswVEHAch25P
         j4+O7wWugzXhFOcf7z9XZdLjYWYCyRAcaLP4bAQv4jbevIOKOhPq1hRKXC/FN9P8iw7x
         fhC0A4M4m9RUFYqutdtf339GmdjBZjBeRNxi0OKgylrUgCv5yd2Z7bj8QUKPv+3b1m8l
         YiQ3GdgfzhDACWY2COeXrOXY1xb9LGGfBGvXcjlAHnzHa2GFPg3+BtIylfEZtoKC0xfM
         +K/g==
X-Gm-Message-State: AOJu0YzlH/bcT+hQx/WWzbuiut8k38Fn5/XDfB+EBe3MaKp20P+JHh6S
	aEe7kJ6Z0siRtN6P+EHMdH0=
X-Google-Smtp-Source: AGHT+IEBWswSSTqUHQXeLimviaDVaUJBgApY2+RCvb65xSh5e8GhQ42o2NbrzJxniyY9J45B/T0DXw==
X-Received: by 2002:a05:600c:4e4b:b0:40e:44ad:2e47 with SMTP id e11-20020a05600c4e4b00b0040e44ad2e47mr874588wmq.185.1704711603527;
        Mon, 08 Jan 2024 03:00:03 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b0040e486bc0dfsm1924827wmn.27.2024.01.08.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:00:03 -0800 (PST)
Date: Mon, 8 Jan 2024 13:00:00 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: support OF-based registration
 of switch MDIO bus
Message-ID: <20240108110000.aujqhlufehngtkjj@skbuf>
References: <20240106122142.235389-1-arinc.unal@arinc9.com>
 <20240107195241.GB132648@kernel.org>
 <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65274929-fa59-482c-a744-6b9ce162ab46@arinc9.com>

On Mon, Jan 08, 2024 at 01:22:18PM +0300, Arınç ÜNAL wrote:
> > > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > > index 391c4dbdff42..39d7e7ad7154 100644
> > > --- a/drivers/net/dsa/mt7530.c
> > > +++ b/drivers/net/dsa/mt7530.c
> > > @@ -2153,17 +2153,25 @@ mt7530_free_irq(struct mt7530_priv *priv)
> > >   static int
> > >   mt7530_setup_mdio(struct mt7530_priv *priv)
> > >   {
> > > +	struct device_node *mnp, *np = priv->dev->of_node;
> > >   	struct dsa_switch *ds = priv->ds;
> > >   	struct device *dev = priv->dev;
> > >   	struct mii_bus *bus;
> > >   	static int idx;
> > > -	int ret;
> > > +	int ret = 0;
> > > +
> > > +	mnp = of_get_child_by_name(np, "mdio");
> > > +
> > > +	if (mnp && !of_device_is_available(mnp))
> > > +		goto out;
> > 
> > nit: I think it would easier on the eyes to simply
> > 
> > 		return 0;

Actually "return 0" leaks "mnp". An of_node_put() is needed.


Return-Path: <linux-kernel+bounces-16848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938648244DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8552863FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B0241F8;
	Thu,  4 Jan 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3rTLPuc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71E241E2;
	Thu,  4 Jan 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28e31563ebso72357766b.2;
        Thu, 04 Jan 2024 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704381756; x=1704986556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0yXAbaAJ66TkHbWq15zRnFaiYa65uZWNj5loVkRiAVs=;
        b=i3rTLPucKvEuBHFtrVFdIoqTo/cgYJXVP9uYKsrgNgQl6a7k5T0ICjhbwGeQqNPhN4
         XHlAvK8pubJEW4IZqQncOIItgcLqipkv7YqDKLFYpdpg+wmzW1CSNPC84eRJygkkWy+O
         zKXxsdD77vnueM4k9Cy2MnbXdw4RRud0iOMDoJDcEWi/BltR60ra4sgVSpCl5s8o2xjA
         0cO7MxeYoFZ/JPTdIiiElwRdubapFSkILEmJ4+EyvnbTlYN1ZAehTUlSEO8kckAp3Y5B
         jfTz6i/16fvF0xwoL7jQug0CkDZJ9VKFkNJU8Zjs33phSpy2P/7h0Xl0BGI4BGiOK9F+
         of1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381756; x=1704986556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yXAbaAJ66TkHbWq15zRnFaiYa65uZWNj5loVkRiAVs=;
        b=B4KlV7f7cuEX+mwos+60My1jr2loYu9uZDrUzFD8Yh+JLklLdPzP5Hu8gL/Njf9LN5
         yQHc5hrYYExtLQ1nugnaY0Dy+IBiVVPelS1xmHQB6ezCof/p3+k4qBPIckpMor3OMGv4
         y9rfroFahslppRAdhy7TD/9RgDEZDtJP5uMwTqWXgqzam9pqZ8g5bl6MMMXxNcnek9+6
         fVovl6hnFUWxTFHcfIeB7WGre7rvgvTWsf20W9tZGhHwp6FVph+pcSxCjonNxNt5qVnv
         0vV19RcVxU8wLowoLA1h5b+DqSKmjRWXuunWb84YbWcxjWVSg7EzpZ3/YZRI0Y0u87Xv
         v8/g==
X-Gm-Message-State: AOJu0YykfKsFlYmQFk15s0ex180YqROrbQAkVBw7jW9qla64QG3Sojjc
	dsnb4qOiol+JIyOLZYVS8HI=
X-Google-Smtp-Source: AGHT+IFaig8SeExL8gpob99TbO9syJO8daKzzf6+NKnsgHhhIwb1pKTLpp4QHIDVqUCo5i59VpnL9w==
X-Received: by 2002:a17:906:680b:b0:a27:43b7:ec7 with SMTP id k11-20020a170906680b00b00a2743b70ec7mr374799ejr.22.1704381755979;
        Thu, 04 Jan 2024 07:22:35 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id gg18-20020a170906e29200b00a28fa7838a1sm221054ejb.172.2024.01.04.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:22:35 -0800 (PST)
Date: Thu, 4 Jan 2024 17:22:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/7] net: dsa: mt7530: always trap frames to
 active CPU port on MT7530
Message-ID: <20240104152232.jkoqiuwk3rd24rpm@skbuf>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-2-arinc.unal@arinc9.com>
 <20231227044347.107291-2-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227044347.107291-2-arinc.unal@arinc9.com>
 <20231227044347.107291-2-arinc.unal@arinc9.com>

On Wed, Dec 27, 2023 at 07:43:41AM +0300, Arınç ÜNAL wrote:
> On the MT7530 switch, the CPU_PORT field indicates which CPU port to trap
> frames to, regardless of the affinity of the inbound user port.
> 
> When multiple CPU ports are in use, if the DSA conduit interface is down,
> trapped frames won't be passed to the conduit interface.
> 
> To make trapping frames work including this case, implement
> ds->ops->master_state_change() on this subdriver and set the CPU_PORT field

conduit_state_change()

> to the numerically smallest CPU port which the DSA conduit interface its
> affine to is up. Introduce the active_cpu_ports field to store the
> information of the active CPU ports. Correct the macros, CPU_PORT is bits 4
> through 6 of the register.
> 
> Add a comment to explain frame trapping for this switch.
> 
> Currently, the driver doesn't support the use of multiple CPU ports so this
> is not necessarily a bug fix.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  drivers/net/dsa/mt7530.c | 37 +++++++++++++++++++++++++++++++++----
>  drivers/net/dsa/mt7530.h |  6 ++++--
>  2 files changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 391c4dbdff42..436d5c311be0 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -1035,10 +1035,6 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
>  	mt7530_set(priv, MT7530_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
>  		   UNU_FFP(BIT(port)));
>  
> -	/* Set CPU port number */
> -	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
> -		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
> -
>  	/* Add the CPU port to the CPU port bitmap for MT7531 and the switch on
>  	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port that
>  	 * is affine to the inbound user port.
> @@ -3075,6 +3071,38 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static void
> +mt753x_conduit_state_change(struct dsa_switch *ds,
> +			    const struct net_device *conduit,
> +			    bool operational)
> +{
> +	struct dsa_port *cpu_dp = conduit->dsa_ptr;
> +	struct mt7530_priv *priv = ds->priv;
> +	u8 mask;
> +	int val = 0;

Longest line first.

> +
> +	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
> +	 * forwarded to the numerically smallest CPU port which the DSA conduit
> +	 * interface its affine to is up.

"first CPU port whose conduit interface is up"

> +	 */
> +	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
> +		return;
> +
> +	mask = BIT(cpu_dp->index);
> +
> +	if (operational)
> +		priv->active_cpu_ports |= mask;
> +	else
> +		priv->active_cpu_ports &= ~mask;
> +
> +	if (priv->active_cpu_ports)
> +		val =
> +		    CPU_EN |
> +		    CPU_PORT(__ffs((unsigned long)priv->active_cpu_ports));

I don't think the type cast is necessary (implicit type promotion takes place).

Also, it is customary to put {} for multi-line "if" blocks, even if they are
made up of a single expression.

But without the type cast, it could look like this.

	if (priv->active_cpu_ports)
		val = CPU_EN | CPU_PORT(__ffs(priv->active_cpu_ports));

> +
> +	mt7530_rmw(priv, MT7530_MFC, CPU_EN | CPU_PORT_MASK, val);
> +}


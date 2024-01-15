Return-Path: <linux-kernel+bounces-26505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B782E23A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1DB2204F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135021B297;
	Mon, 15 Jan 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/sq1Of5"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8F199D9;
	Mon, 15 Jan 2024 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso1853687566b.0;
        Mon, 15 Jan 2024 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705354643; x=1705959443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bpZXuxTCll8YyBXk7ascc8Zs2wHnoSmMilYdgRpGMyg=;
        b=d/sq1Of5Kis/OylxIB3SlRk2TmJCFtAe+vcYWrJFpWrs7NKxNvmquPZyz7HbC5+CNI
         gcPFZCOAOplJf++gYO099q3BEGDqyL0/OEwcgPQkoS10f+uDS0o/TfVJ5p+JOCgipKLS
         m6YZZ53KxTsbTGY8xULZMlseo+ioqXhpTuLE6miPCVgJzT39UYM4eK+r5DIFJxb/qZiI
         zx42w5ZPoAJlPUJcOifFa+tpLT2+L/GnMdaiMm+Yc75B++ZBT/hzwRAjkejSsKajsgbs
         oLP1qo9jVb3qZmos0EBApfphTyRwy2IGVUKiLMisXenBi9E1YBc7YqXVbZykJh9shREr
         jWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705354643; x=1705959443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpZXuxTCll8YyBXk7ascc8Zs2wHnoSmMilYdgRpGMyg=;
        b=ucYqz9O5RZUQAW6gUzu41RDRI7+64yV3VRUBbM8j7LDi+zKlSOkgMZQwQ2tG/IxZuP
         IFHVvroxEveKPSLq6qHfNvJhzrWWu6nEMMbrQ5gip2trwZg2vgBEqWgaLr3q6gnS7kF1
         amwFGfH3gvUL6NixVqag/Ssao2bDSiBW3eOIxnWAwbt7p1YCDjyIZD0lKoxXfc50EuKb
         VyzXFhCiiYYMqobjUn5w3tCdj09Vj0ZYVOKzhCyrloDVVOeJ7TI0kv/In2e7uY8puQfO
         pKd2mRT6qQMBdiYxgsJHjteBss5SaUcWhE8LNWnjF39UW6uupg/ztCd/EY3q0IfiSKc1
         Sl8g==
X-Gm-Message-State: AOJu0Yx4m46OYtGAE/40b2UlFwpeppMAuNd3SMl2zs0MT7X0NcE9lrTm
	1AKIj+o51Qun0c8Kwnfo10nN8Ej+EtYvnw==
X-Google-Smtp-Source: AGHT+IE10fMtaUsiAYNb4EjOpfYRAmVcn8WrWtsDg/nQyoNok54YoiMAF7YZfJtVLHXZAjFBrmuKEQ==
X-Received: by 2002:a17:906:bf47:b0:a2c:f62d:a598 with SMTP id ps7-20020a170906bf4700b00a2cf62da598mr6138308ejb.0.1705354642880;
        Mon, 15 Jan 2024 13:37:22 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906695100b00a26e53be089sm5690286ejs.44.2024.01.15.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:37:22 -0800 (PST)
Date: Mon, 15 Jan 2024 23:37:20 +0200
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
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net-next 6/8] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Message-ID: <20240115213720.vxlumsjwrjdkqxsl@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-7-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240113102529.80371-7-arinc.unal@arinc9.com>

On Sat, Jan 13, 2024 at 01:25:27PM +0300, Arınç ÜNAL wrote:
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 3ce4e0bb04dd..3a02308763ca 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -414,72 +414,56 @@ mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
>  }
>  
>  /* Setup port 6 interface mode and TRGMII TX circuit */
> -static int
> +static void
>  mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
>  {
>  	struct mt7530_priv *priv = ds->priv;
> -	u32 ncpo1, ssc_delta, trgint, xtal;
> +	u32 ncpo1, ssc_delta, xtal;
>  
>  	mt7530_clear(priv, MT7530_MHWTRAP, MHWTRAP_P6_DIS);
>  
> +	if (interface == PHY_INTERFACE_MODE_RGMII)
> +		return;

It would be good to add a comment here which states that the port comes
out of reset with values good for RGMII.

Also, there's a built-in assumption in this patch, that dynamically
switching between RGMII and TRGMII is not possible. This is because
phylink mac_config() is not necesarily called only once immediately
after reset, but after each major_config().

The fact that the driver sets both PHY_INTERFACE_MODE_RGMII and
PHY_INTERFACE_MODE_TRGMII at once in config->supported_interfaces does
not disprove that dynamic reconfiguration is possible. Normally,
interfaces for which it doesn't make sense to dynamically reconfigure
(they are wired to fixed pinout) have a single bit set in
supported_interfaces. Is this switching something that makes any sense
at all, given that port 6 is internal? It's not something that phylink
knows to do today, but if this is theoretically possible and remotely
useful, someone might end up wanting, in the future, to revert this patch.


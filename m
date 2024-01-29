Return-Path: <linux-kernel+bounces-43084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA18F840B66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6552228E34A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70211586D8;
	Mon, 29 Jan 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+FOuich"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640D156963;
	Mon, 29 Jan 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545681; cv=none; b=KjLO33dt1fkZeFP9EeSEN1QAAfhYgObYIIOHNMq3xo5FSbOPQdMF0Pk3tG80k49oznHjXdy38vhSV8Q5/H2o1FZ/Ca6/j+bIIk+iL/sR7mMvjQ6vTP3rcmjf4oML5S+bpTvXrDDwUcjN98yTFW1QyovWw0lptwPALCop6VMGehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545681; c=relaxed/simple;
	bh=CkQykIsUrm3sfSKR0V8g1q/+LCFk4Llq9v1g5jrzoS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7XVWM2+ToAf17pW9R5IaO2S7YrklqEFhR1vbn8YJQxbRzcEvx8NJj/TRFziFalospWtXmxbxJD3OWZsHb6mhU4jInoBbEaiaZ2+AxXd64b0h+sJJaiEZ8p8o0qW0vD8v6hvCIDQOWq+YHGnnsyJ7oHg4MUGW3jawwnaexUulA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+FOuich; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a350bfcc621so301994366b.0;
        Mon, 29 Jan 2024 08:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545678; x=1707150478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ekRXlRD9sMYvDhkEUn4vNmGp7PidTrPzm1ir271L0uQ=;
        b=I+FOuichFoO2vZfZYpQq3HerAKr/3plrUxvbfKljbGfuoOS52O6QSsBuRfG7DWqAth
         c13EyQcsIaDs749X+GfdYmliNaYuUc0RRVA7S2TnAO6nzwwnW4PcnQcKmWKipGfHy9JP
         z1HVHMszai/8pOn6Tay81IOOBpQza/vDUR3LUhaEs/RhrNxx58kDLH5qY2Z7hJ+zsG45
         7AQ76bwe1OqGlbtjTxbBgXBs+HAI/IigrQz+X17iksv+INMfxzhXDAzGYUzGFN1h7Qld
         t7bwVnUeL/B4beGVZu218kxp8j/QkHPLh4W/GiX4uw1yNGxtehzZkBZzduf3FZ2c8ECJ
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545678; x=1707150478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekRXlRD9sMYvDhkEUn4vNmGp7PidTrPzm1ir271L0uQ=;
        b=wAm6gPKFTLpq/rnv1HQx6RBw/qB4zpQdGMdeuEpo0cZFGYQdKMM0Ont/Y/4ByEzvVA
         8mdN7+DsRvqYtdsa0rY7aa/kxbqNhzJr2K+X6NhbcOlXLU66h1frP+SYvU7lHGmoihy4
         87anyLvOQ+FkX1PM4HoiT+rHFjURZj4VYEmzX3cw5Gmk8qHFz2kEomBIYbFfRZ4Q5DH4
         r48oeRTuKFJ3J4XeuseBhXTPI3SuW1W2ARHLe9FViACATnWs2ocrvI90nZ7EFOaJK/wD
         Uq4+RcY3I62yx7ZvHAj6L8i2AINdinHBTa3VNjkpFDXhg4YxDaHpFJDPj70e2zyOO7IP
         5wtQ==
X-Gm-Message-State: AOJu0YyHWqE3FwRxBmxIqpARkGjua5qNkv2xk8uNOXp/jGuSHB0zMlDr
	oC2FrLXLJKVsldXps1Hb7vzmG95+2qiHp67jO0vSzJ0bbD8hCim0
X-Google-Smtp-Source: AGHT+IEfp1ng4c16rTEjqdb1pWuJos1D0ck6ThBr47sPROdD23LYtXmEIBt7ZDzRCiDCnIKranZbGQ==
X-Received: by 2002:a17:906:28c4:b0:a26:90a0:696e with SMTP id p4-20020a17090628c400b00a2690a0696emr4775654ejd.41.1706545678086;
        Mon, 29 Jan 2024 08:27:58 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id u11-20020a170906068b00b00a2d49132dc3sm4037147ejb.197.2024.01.29.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:27:57 -0800 (PST)
Date: Mon, 29 Jan 2024 18:27:55 +0200
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
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240129162755.j3q3wxtovzv4sh3i@skbuf>
References: <20240122-for-netnext-mt7530-improvements-1-v3-0-042401f2b279@arinc9.com>
 <20240122-for-netnext-mt7530-improvements-1-v3-6-042401f2b279@arinc9.com>
 <20240129125241.gu4srgufad6hpwor@skbuf>
 <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431750cc-fb6b-4f7a-9123-b6986d359742@arinc9.com>

On Mon, Jan 29, 2024 at 07:22:28PM +0300, Arınç ÜNAL wrote:
> On 29.01.2024 15:52, Vladimir Oltean wrote:
> > On Mon, Jan 22, 2024 at 08:35:57AM +0300, Arınç ÜNAL via B4 Relay wrote:
> > > From: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > 
> > > Running mt7530_setup_port5() from mt7530_setup() used to handle all cases
> > > of configuring port 5, including phylink.
> > > 
> > > Setting priv->p5_interface under mt7530_setup_port5() makes sure that
> > > mt7530_setup_port5() from mt753x_phylink_mac_config() won't run.
> > > 
> > > The commit ("net: dsa: mt7530: improve code path for setting up port 5")
> > > makes so that mt7530_setup_port5() from mt7530_setup() runs only on
> > > non-phylink cases.
> > > 
> > > Get rid of unnecessarily setting priv->p5_interface under
> > > mt7530_setup_port5() as port 5 phylink configuration will be done by
> > > running mt7530_setup_port5() from mt753x_phylink_mac_config() now.
> > > 
> > > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > > ---
> > 
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> > I hope this moves the patch set out of the 'deferred' state.
> > 
> > ---
> > pw-bot: under-review
> 
> I still see deferred. I guess I'll have to submit this again. :/
> 
> Arınç

Please wait for a few more hours for one of the networking maintainers
to have a chance to see this and ask you to resend, if necessary.


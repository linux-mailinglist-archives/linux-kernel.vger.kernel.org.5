Return-Path: <linux-kernel+bounces-54036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077984A985
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341D4B24130
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C381748CC6;
	Mon,  5 Feb 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKz4TB+z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBC481BF;
	Mon,  5 Feb 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173029; cv=none; b=CbADypHTfz56XoMyNCCaXq/TF2QOnaAa0RtHdajwjwamGK1Zyv2zwsZiug3IlfQL3+G5mWGYMsIev4nfskuGBPYPKlaaEojwIk84Cn4s2vsLpn0oi11A7tiorCBs/m26aRXpGs5B/0w5NCEazQx6F55DH3lFm0n0Vz7cNoMetPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173029; c=relaxed/simple;
	bh=B5LFCChfXOV41x2TfdwcmAIvY8W+Ckng0SDd0NGO450=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEywcb9NxQzEcda/EqJbemm7cXAIEiP7Vy7nlbUEIBzMaEgCrdUmUy91SdeO9RyZnZBvWBTCp6n9BOhd7THYWv17AXR3XZWpDX4euy9PqegswlA0H4ByER+ULUechKscBrxFZNlF4NLsIV3cAiLyrPX0mFt+GuVlq9GFrUurziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKz4TB+z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511344235c6so6032321e87.0;
        Mon, 05 Feb 2024 14:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707173025; x=1707777825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B5LFCChfXOV41x2TfdwcmAIvY8W+Ckng0SDd0NGO450=;
        b=DKz4TB+z2Mzh81+kvdBIeXxgKHtE1bm/zcwRcG1GDYmBf+ieJjZV18zlujqeCyEVFi
         0nVbTDBPzfizjaY7Cg+9aGCTy78WfDY+qeJCrsfE6hAe/wPIw+9iRxhWvvCA8qoKbz/U
         OsXmVI23HvG2EnuBsVCrED9biPXD79nCUZBL4l00K2dWfDekUhitpUPr6TaYjo+K3a4O
         jgTXnUxq0b05+ycLyleb+kevfkYWyZpSISnnBEn1x8rKIl1zbmxPr6K0qBOu7+Hge2q4
         wpszepnx05dpRzuqa+Yg0xj86us35/7y2z+obFtpOcaTPQvRG1ghXVNPRRuay4tb3aRX
         jGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173025; x=1707777825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5LFCChfXOV41x2TfdwcmAIvY8W+Ckng0SDd0NGO450=;
        b=RMeqib7COP5TA4VBGf9k2UIu0HaFtu+QkFKOrYkx0r83RNqK0whLvgwfTMehvDJpCg
         TY5m+BY0LtfzESDF6m7LxOrXfWJtTVW6YpdPnYkobNF0oTdJLLS/ckDY6ItnqfcH+iqf
         y10q15rgsVS7oo7tvGrzd6szIuz71vioHhYUhf1PPgwSpm8/YXk0f7ZWQkm7syDMHCju
         pfHAIXvEXJHT9F332dFL8bVnM2o06Np0/CaUGjTO1vdGeBcGFv5utnXLx/rPvkkQ1n6J
         z8sSAKgPFBYURPsEQcd8lDKgNAUnE4RAyXszERGgrOsfHniMacowwKO9RNaANCfl77vu
         h0Bw==
X-Gm-Message-State: AOJu0YzgqiGFz4vIqH6gobWYkFvPAXdfKZ49M/bnNwM1qTzxDlYw1bsy
	DRuyexlJsGgefl36z8bGIP/lVc8cPAicq8OwQQUPa3RusQD91pe7JxMpamMNq3G2mSgoXvimDcB
	nFqDgyZde8Q28e4Wf8dE3/2TCieU=
X-Google-Smtp-Source: AGHT+IHseQXpYVdIoy5VWPKXjRpQk8S1Nl2OlAONy8uH9N2+8szilnpvFR6yjoGW8Wd1pLrXFfIn1CjMigxOSU9ivWc=
X-Received: by 2002:ac2:4aca:0:b0:511:3ef8:5 with SMTP id m10-20020ac24aca000000b005113ef80005mr572988lfp.34.1707173025259;
 Mon, 05 Feb 2024 14:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
 <20240130-realtek_reverse-v5-9-ecafd9283a07@gmail.com> <20240201224516.pujapjenqtyejihg@skbuf>
In-Reply-To: <20240201224516.pujapjenqtyejihg@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 5 Feb 2024 19:43:34 -0300
Message-ID: <CAJq09z4ForDXY322xceFJCaH5tiXKQKS=EgFMKbdiSNf8O1Lbg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/11] net: dsa: realtek: migrate user_mii_bus
 setup to realtek-dsa
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +/**
> > + * rtl83xx_setup_user_mdio() - register the user mii bus driver
> > + * @ds: DSA switch associated with this user_mii_bus
> > + *
> > + * This function first gets and mdio node under the dev OF node, aborting
> > + * if missing. That mdio node describing an mdio bus is used to register a
> > + * new mdio bus.
>
> The description has the overall feel of "Family Guy - Peter narrates his life"
> (https://www.youtube.com/watch?v=zw8zUMjEW0I).

Hahaha. Yes it does.

> You could be a bit more succinct and say something like "Registers the
> MDIO bus for built-in Ethernet PHYs, and associates it with the
> mandatory 'mdio' child OF node of the switch".

Done. Thanks.

Regards,

Luiz


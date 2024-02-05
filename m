Return-Path: <linux-kernel+bounces-53917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBC84A801
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5719D1F2B92E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A314134CCC;
	Mon,  5 Feb 2024 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixbk6ZDP"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB8134CC2;
	Mon,  5 Feb 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164981; cv=none; b=GXn8Am9a/rvGHCGlejjubBaYkvWEgWiG5ZC6mz3xA8sjxmQvrjyiuQY33G1zVs7mpQ+xrC1S0vu3/VzaDsa1r/37juv7Jmgi3E2bOcBY1GlL7hmU045BE0DBODEYOlleM6jPzgDLxs66J1YAWNaLgRVrKSueMXkVpNDQrQYV3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164981; c=relaxed/simple;
	bh=S0GzZeJ7TZ/R3/NxtXdzMehouUj/A+/TyzKjx/Jvwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HagOOB0KrGknkeuBQ7Nwi/cY638Eypd1qw0RFEmqzUyxv/NicRyoVEhaJJ0IRzy96Yy2bg/TsGB6cDp4zdc1U+XAOsVMoCOuJtj398uUrNARnxNMBigMmog+9iZSSILKKX3vkf5zMST5vEtu4jZ9vBXHy2pTOyiL2JoYG/2Gi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixbk6ZDP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so5780893a12.1;
        Mon, 05 Feb 2024 12:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707164978; x=1707769778; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2vwy1xdN4YRuSNz0Zmeo13DlHz09nwHWjHo8V3zYIM=;
        b=ixbk6ZDPKuJP22PNH+aZijhR3MA5QYUXinplrgx64oiUg39ZnFfsSYEcODJYZYrkNe
         ktgGxD0G5rBK9GqlsgJeR9p37DfvQpsKs0O52XX9cXifpsiuKqWNb4giDUv42+5En3uZ
         3rZaBddD39MDqeGdaWthsqogkyEC3/mBhinAUEOx1mzQrn5+Q4BuIUdHVc6bzS+5y+ME
         avJHr5ewQMqOODF7sSwCXwcSGK8PnLXjF+6iVQaaHWnesN3hBvdVB9iCLBV93kFr4bKo
         iuFvz6JbtVCUuAH0Mzw3tSb8h8lHVytqwIKiwHGPIQAZ5n45kvgImwcpo5pne8mia9v9
         ypaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707164978; x=1707769778;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2vwy1xdN4YRuSNz0Zmeo13DlHz09nwHWjHo8V3zYIM=;
        b=NJuuuSEpzGWkCp6zIgj5JsGJOmdp4amFPgDHEVutmDkJJdgNQQxKAkzWt3dgLeUKJO
         bL31lmFZDUK389bjFvjjDriVGATrZW6cJCuO33a5CxgLkeG3/ru7If6q5QSLpyA8MVWc
         Z9rhga5Vvnmq0ZZBUth754Bkiu3hwd8H4s81VF27qznHkdoNqa4vK3o3HTNESshNfSAD
         c/9Jx6UtCsp+FwdzTgyL3S3drF2BWvdWO5qqa5kA2ZXdTz3Vv5Yl6rpRV0V/BH5dsCce
         AU7uaeMP3vfN4uiJvT6n1JEB8C9regJY+j1L+fzC7Pe+y3XztuIM8q8Z8qLTtINCm3NH
         p79g==
X-Gm-Message-State: AOJu0YwzjivkfZhjoZBBFwNN1b6R2FpuCHRiK6OYzPRCFx3K/oKOk9h2
	SahFzelxViDSY6qNOBuqRn76WjjOmhm+vbj/0GKeI56ZsZCzd+Ia
X-Google-Smtp-Source: AGHT+IGLRUsRndFzILv8fnlMxBbqMi2GUbAGsIlK83rBGDc2eO+rtdn+PbtPCGEGLtUd6LttiUMHAQ==
X-Received: by 2002:aa7:c991:0:b0:560:535:864c with SMTP id c17-20020aa7c991000000b005600535864cmr300965edt.12.1707164978034;
        Mon, 05 Feb 2024 12:29:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUKrZurXEx9W3ZB7XvtgoqXBVoDOIiHWDUK0OxcbnUi1TvQBb6CqHTrO9FkFWqz66OVwTWge1zAbOwH8Xay+GG1fnqHREU/Plac7osLVVNe6J3OcVcKFONw8vGiWGnoC5EX8eSLZO+l2x3/AUHgM0scbA/Y+kTy8Klw3oNqwsVrgYrgn1YMLoOToLYIMryx3gKzPaNhCAlqVe81we1X2/Dm0eh4DDolBncvdnRRzfO1KIDJnrkUiX3IcIhUWgYp0goyUqEdfCDrnYlGZPcmxmRcqfOPEYpQzz6voNLSFvkv2KcpQiSeDrYRGhBcf27Wb5GMh2OU+RSh49vfiSFw8OrsZJUZTF3VqZXtlMJZAcgnUD8JF8D/OKM/I8AseGdelA3Br/w05YzQYPg/xovo1JoT4oa/2NNvIFk2hQjLqHhq8ayZZ8BlCWY6aJxUHkUaw9YD0wD54PQROFgp2W1PK8yNWLiUA1tEWvLa35hwKk6RSWUTK5aEs3H1aJSQ7Bu1Tz1zivVLr240evdu2sOw16xquFGF42BbW73B4/0fMc10tOhz6VfU+CEBvYWYQpxYL18BkHQrZL3RSXCf16RtjFPiUPEVn440SQj0Xn9B9nVOjh/9FmCwW2+GRXYTFwQK3hrAvnZDnKPFAY6K+Hq1YqbJg8ClLLLw
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7da4d000000b00560422bd11asm256428eds.30.2024.02.05.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:29:37 -0800 (PST)
Date: Mon, 5 Feb 2024 22:29:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
Message-ID: <20240205202935.tolbbwbtrig32jlj@skbuf>
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
 <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
 <e3b4add6-425c-46ca-9da5-8713055fc422@arinc9.com>
 <Zb0u8NY0q6ay17j5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb0u8NY0q6ay17j5@shell.armlinux.org.uk>

On Fri, Feb 02, 2024 at 06:05:36PM +0000, Russell King (Oracle) wrote:
> > > Given everything I've said above, the only way to configure RGMII
> > > delays is via the rx-internal-delay-ps and tx-internal-delay-ps
> > > properties. So, DSA drivers should _not_ be configuring their ports
> > > with RGMII delays based on the RGMII phy interface mode.
> > > 
> > > The above is my purely logically reasoned point of view on this
> > > subject. Others may have other (to me completely illogical)
> > > interpretations that can only lead to interoperability issues.
> > 
> > I will address this with the next patch series. Thank you for explaining it
> > in detail.
> 
> This is a good time to point out not to rush with the next patch
> series, as my email will _likely_ provoke some additional discussion
> from Andrew and/or Vladimir. So please give it a few days (maybe
> around the middle of next week) to give them time to consider my
> email and respond.

I agree with everything you've said. The only problem is that
Documentation/devicetree/bindings/net/ethernet-controller.yaml is
ambiguous on this topic (to put it mildly).

@Arınç, there are ways to handle the "tx-internal-delay-ps" in
mt7530_setup_port5() in a way that is backwards compatible. I don't know
about RX delays - the function doesn't handle them, and I don't have the
time to open datasheets now. You can take inspiration from
ksz_parse_rgmii_delay() and sja1105_parse_rgmii_delays() on how to only
fall back to the current logic to set the tx_delay if the more specific
OF properties are not present.


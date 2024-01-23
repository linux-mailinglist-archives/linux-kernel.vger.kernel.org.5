Return-Path: <linux-kernel+bounces-35586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610178393B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F691F2371B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E336088B;
	Tue, 23 Jan 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB/DiWid"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA06BB4A;
	Tue, 23 Jan 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024683; cv=none; b=f1A6UX24eLgMWP7KShHbUGdXYYo5f37io6c5VF+OizmHuncpGhOyNjN3UDwC4N8KL6YcR6fcNrm9/nXtNelbFXAxFB0VY8FtUtcS9yfL2zVqN9mG+MVWZzSQ6lC6RbY8NLgNnz3rr8hkWs81n2gxfoL44JnuHSBLzFyPvaiV7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024683; c=relaxed/simple;
	bh=rVS8jGbR1XkYYdRYiPqWd3eo7KWQ9uoG2lTEv7reHhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkQToUSmZ0d6nVHVqJvoUHrxUZwZ3e47uw7OlYfKVHTVBcjj+e7sfJg26eGdyHE9Jx4qMvWvqrk7/3B+GTek+msY+oo5R5uN0KjqPa237gWfJIEN0pGKV4ZZj5TmX2ADyYSQZB2uZ7pEuvKnNiq3pQluNEWlPQ2dmOmj1KG+d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB/DiWid; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so5608743e87.0;
        Tue, 23 Jan 2024 07:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706024674; x=1706629474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uyKGGaXH67qi8vCo0maX5/zi228Y+OGFXkTPJDuBuaU=;
        b=fB/DiWidXcfoGe+tqkkxStXuslmPJHkl8TwlP9TmNeukffaZuvABIaVpxIqSgwMqr9
         P7k7qN+N/XyK7t787EZ3DQesEEm6QkILlrIE4GpSgoC4juvJ5nVIKdeINmGzZ/2OH/iv
         jDjn3ttUyNYTEGKYL0egvNlsDNWyyRb6Rf3VBS+4aRy5/10x1Y5elwzBgBbo4lle9hqA
         6eHTifJPhSWgIwohEMXfo0/xvZKBujgqFLUuRvulusT/UT8cw9mFZLoRHf65OiAK4qCC
         DnfwiqnycBuULJHc+GxBqs1HZBGNqqvGwczd+udUB+4fwhDpSjMgQBTSQuwT+BY8t6ON
         twKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024674; x=1706629474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyKGGaXH67qi8vCo0maX5/zi228Y+OGFXkTPJDuBuaU=;
        b=vdBMkCumAs1lJaUHT6gBXtPjNr9tIo9MLoQqwgOcKHKfb5wT+FMcLtvRkZeVbeLBbw
         YonfIzJN6ACkU/lGplYnudYfyp6DLyc+XLqZdcn6sEC9lFjssTjwx88GwKqvjx3YQhi8
         1LE9xoJId/WMYp6kyrLW0R/Aa55JR1xK4xsN1ZwUIBPdOCUb0xv4hNwPDLaf56aG72We
         cBhOnUAlvOWRamstbfZFCsslCQkaR1FD/QhFkjCrZrdMENlzPp/FDmsYjTeuO1ygcP5t
         XlqHWRV5wRaZ9pXcsMBaYKsmr0+rgGZ4cUtqfLZGu3OQLvVyKcx5jnm2yhY4thu786L5
         CY2w==
X-Gm-Message-State: AOJu0Yzxm8k/ATojyEMj/cChwrV5AGsbhTry66bW7kiWevYand17vqWp
	K/kcaMhkUrkyTnFGpdsiMl1JkMUHl/H0K9yynvc88mz4UjO8Ltq5
X-Google-Smtp-Source: AGHT+IGvZs9WnjBR1iDMpj3ez0AwsvXopSSeTCvRBn1HLppGHnCqP0V6f1yZxITawki33y1vUZjNag==
X-Received: by 2002:a05:6512:ac2:b0:50f:1502:79e5 with SMTP id n2-20020a0565120ac200b0050f150279e5mr3271350lfu.14.1706024674068;
        Tue, 23 Jan 2024 07:44:34 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a28aba1f56fsm158225ejc.210.2024.01.23.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:44:33 -0800 (PST)
Date: Tue, 23 Jan 2024 17:44:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
Message-ID: <20240123154431.gwhufnatxjppnm64@skbuf>
References: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240122053348.6589-1-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122053348.6589-1-arinc.unal@arinc9.com>
 <20240122053348.6589-1-arinc.unal@arinc9.com>

On Mon, Jan 22, 2024 at 08:33:48AM +0300, Arınç ÜNAL wrote:
> These subdrivers which control switches [with MDIO bus] probed on OF, will
> lose the ability to register the MDIO bus OF-based:
> 
> drivers/net/dsa/b53/b53_common.c
> drivers/net/dsa/lan9303-core.c
> drivers/net/dsa/realtek/realtek-mdio.c
> drivers/net/dsa/vitesse-vsc73xx-core.c
> 
> These subdrivers let the DSA core driver register the bus:
> - ds->ops->phy_read() and ds->ops->phy_write() are present.
> - ds->user_mii_bus is not populated.
> 
> The commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus") which brought
> OF-based MDIO bus registration on the DSA core driver is reasonably recent
> and, in this time frame, there have been no device trees in the Linux
> repository that started describing the MDIO bus, or dt-bindings defining
> the MDIO bus for the switches these subdrivers control. So I don't expect
> any devices to be affected.

IIUC, Luiz made the original patch for the realtek switches. Shouldn't
we wait until realtek registers ds->user_mii_bus on its own, before
reverting? Otherwise, you're basically saying that Luiz made the DSA
core patch without needing it.


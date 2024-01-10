Return-Path: <linux-kernel+bounces-22585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4B82A00A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AFB1C214F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880074D135;
	Wed, 10 Jan 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf3Hjz3+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613114D581;
	Wed, 10 Jan 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2a225e9449so475552566b.0;
        Wed, 10 Jan 2024 10:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704909929; x=1705514729; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSgFVUPD+lhj2fkhdLXiapb7C+A3P82l8Au/eKfRJKw=;
        b=nf3Hjz3+IHgdlnIZ5natPk6EeddYVcTGuXoDF90at6+DkqJjLqlAeBFm2+0gze7EO5
         /ITQbZN46XoFIU99sUY+FrU3pUdNxrRl95e52PFnQ6KYEnzbuiJn+P8godhDr/vMLZwB
         NVE59C+vDdTGJh80gFCKIlcYLYDhO7y3eID75OnG+mgEKCaCXwPDyxn2WH4q1jc7pgD2
         q5Rev8SaC5DI5PZ/AdmdN1GtQ1baap63XzWuiUKLwmr/DBhGehRjWNaJtW1D2cRi3FK7
         rkL7RVkIbRdt44ybLPOstHM+gqAyw9A3A+pSS3XwjaX3Dn59ARqvLmuAovhVn9arEfAb
         /Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909929; x=1705514729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSgFVUPD+lhj2fkhdLXiapb7C+A3P82l8Au/eKfRJKw=;
        b=eLT5MVnkxrL+tgUJroNSAi+CkO5iPzZ2elAiTHJ4Ry8bahEPpf5KAlyH35SFfM/DuF
         qSHKAr/n3oV442j/WpBvlf3OUmPsO6g6mXL97GvZoYUQaq+GobRmKyknaAufwIMWqA56
         Jg+Zz6iNzJZfh1ccOY6L/mtplXjmZG55rq6kX9IXrgi6h+cg6x/BB6w5OTsbPy7fgK2I
         mmOMcWQV81U0zMzVJNqfXdQPdhOqEVu+pboVQ9eldBM4su8icz7g0E9PisA4XzbIUm/r
         EWLViNt5rLTfV2p0nKZNs5JBgDWvACDRwLBoK9S3pmfsDbGkLDDGeWRLAvLubvk9wzlE
         yvQQ==
X-Gm-Message-State: AOJu0Yz6zwvEuShXk59xmonYDXQdkIYkvYuiPopf1Ydxs377xHMBoFt1
	tqIqDFk91zQ1ambihTJDBfA=
X-Google-Smtp-Source: AGHT+IGbx7BchYP1qhwI8qDfBQPy+wc1dgtHkZDQ3u4HiZTqJo3HVnAOZSXIaR1m4CUy1jtou3dIyw==
X-Received: by 2002:a17:906:5fd9:b0:a26:874f:4847 with SMTP id k25-20020a1709065fd900b00a26874f4847mr804587ejv.65.1704909928742;
        Wed, 10 Jan 2024 10:05:28 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709060dd100b00a2689e28445sm2317376eji.106.2024.01.10.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:05:28 -0800 (PST)
Date: Wed, 10 Jan 2024 20:05:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Richard van Schagen <richard@routerhints.com>,
	Richard van Schagen <vschagen@cs.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 08/30] net: dsa: mt7530: change p{5,6}_interface
 to p{5,6}_configured
Message-ID: <20240110180525.wwxkkoqam37oqm2f@skbuf>
References: <ZHy1C7wzqaj5KCmy@shell.armlinux.org.uk>
 <ZHy2jQLesdYFMQtO@shell.armlinux.org.uk>
 <0542e150-5ff4-5f74-361a-1a531d19eb7d@arinc9.com>
 <7c224663-7588-988d-56cb-b9de5b43b504@arinc9.com>
 <20230610175553.hle2josd5s5jfhjo@skbuf>
 <22fba48c-054d-ff0a-ae2c-b38f192b26f7@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com>
 <20240110142721.vuthnnwhmuvghiw4@skbuf>
 <b47311f8-315d-46d9-bd5b-757141708a3f@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b47311f8-315d-46d9-bd5b-757141708a3f@arinc9.com>

On Wed, Jan 10, 2024 at 08:15:20PM +0300, Arınç ÜNAL wrote:
> __builtin_return_address(1) doesn't seem to work. I'm running this on arm64.

I can't tell you why either, I'm sorry. I can just point to the
documentation, which does specify that "On some machines it may be
impossible to determine the return address of any function other than
the current one". If somebody knows what this depends on, feel free to
interject.
https://gcc.gnu.org/onlinedocs/gcc/Return-Address.html

On my NXP LS1028A (also arm64) plus clang-16 compiler, __builtin_return_address()
does work with multiple nesting levels.

> This is very helpful, thank you very much. This is what I deduct I should
> do:
> 
> First patch: Get rid of cpu_port_config().
> 
> Second patch: Collect port link control register operations from
> port_enable/port_disable and phylink_mac_config to
> phylink_mac_link_up/phylink_mac_link_down.

I guess. Sounds good.


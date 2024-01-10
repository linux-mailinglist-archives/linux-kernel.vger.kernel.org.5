Return-Path: <linux-kernel+bounces-22596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E19082A035
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA6C287768
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6174D587;
	Wed, 10 Jan 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWpzSQJ0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CC4D114;
	Wed, 10 Jan 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33694bf8835so3760664f8f.3;
        Wed, 10 Jan 2024 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911041; x=1705515841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=81LggYl8Ad3OaI7g/+M//8UHKQbJy2MjL1R0gwI6OsE=;
        b=bWpzSQJ0oiyB7KT4uSqfOwYQIAatlLnCzGwY1XgVTBcXnsyUpxnQ2+AeDZFVb1o197
         bei2+k6cplQr3Av/qit7eej7NzASwePZ//+E2gSogdZJNkrKWastFzhKgcRknIxrGvCt
         fbn9GE2Ac74eg/2NMUFOc+kCjTwIdBBkXNRgUzaYLV+bbxcl3tPkhPt1f17XrWhuiAfu
         9DJjb99J6dFbwZlfAcEPpueeHgGSXP7sp9cvFbNX5RlON9sgBBka9C5Zx9H70clX0z1d
         Rs3uByz5WTyvrNbvg7E5aCMReHEOa1qw5/ComUCcweUy0wG0f3A0f25ZHp9RnaLPq/X7
         Ki6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911041; x=1705515841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81LggYl8Ad3OaI7g/+M//8UHKQbJy2MjL1R0gwI6OsE=;
        b=aaRWguPSP/lPbDShlcl9tJ8YBOA9YiKC3eAjJNCyGp+5L06IJHMVUQQ1cyUHCwLRuP
         YHTDRNQTVUUtGzFQ/XKKn4K33B8UMhn6IjeFUHPsoM/zmvHahPT+8cy8rQIppN9EaYy2
         P16q6n2HeEXhpERdve7I/fgKXsZfd4b0qjt/ctUQIZ9qIhU3oIikCPmFsbnJevBXnk2M
         mM3h6fbbzg3cToGAuaX7oqaK9HJlf6kVKHLxEtIjDRFPyS9ZiCMj7puqT1t8aKQB9VJx
         mJ/QuGsl47k5zEvnZvB8lGOSjUyuJ0xYNGA5oXu3QuCdh1oXnbZ0s1k0k1smSjijT6HF
         VCTA==
X-Gm-Message-State: AOJu0Yw5sxYuNz98XLlbCbozds8lQKBBnkRTJvF7uFMZRIeRgy2XcPsb
	NlSUgEAnp9RDekakiM7Jne4=
X-Google-Smtp-Source: AGHT+IHLwo386qOHgtlGpo5mH/d/XbKdDKeCID+7bVxNsNhEiOdF/O31xP8hq13jV9oOdwkmS7u7Rw==
X-Received: by 2002:a05:6000:1e85:b0:336:ca46:2ce1 with SMTP id dd5-20020a0560001e8500b00336ca462ce1mr624602wrb.122.1704911041215;
        Wed, 10 Jan 2024 10:24:01 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id r4-20020adff104000000b00336a0c083easm5469692wro.53.2024.01.10.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:24:00 -0800 (PST)
Date: Wed, 10 Jan 2024 20:23:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <20240110182358.ci7pg7ipcbsjxqjf@skbuf>
References: <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
 <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
 <20240109145740.3vbtkuowiwedz5hx@skbuf>
 <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a086b5f-b319-4f08-9513-a38c214e1da7@arinc9.com>

On Wed, Jan 10, 2024 at 10:26:54AM +0300, Arınç ÜNAL wrote:
> > Are there existing systems that use PHY muxing? The possible problem I
> > see is breaking those boards which have a phy-handle on gmac5, if the
> > mt7530 driver is no longer going to modify its HWTRAP register.
> 
> Ah see, for PHY muxing, the driver actually wants the phy-handle to be put
> on the SoC MAC, and the PHY to be defined on the SoC ethernet's MDIO bus.
> We don't even define gmac5 as a port on the switch dt-bindings.

I noticed that from the code already. Maybe I shouldn't have said
"gmac5" when I meant "the GMAC attached to switch port 5, aka GMAC0".
I was under the impression that you were also using this slightly
incorrect terminology, to keep a numerical association between the CPU
port number and its directly attached GMAC.

> While none of the DTs on the Linux repository utilise this, some of the
> mt7621 DTs on OpenWrt do. The change in behaviour will only be that phy0/4
> will be inaccessible from the SoC MAC's network interface. I de-facto
> maintain the mt7621 device tree source files there. I intend to revert it
> along with adding port 5 as a CPU port so that the conduit changing feature
> becomes available.

If OpenWrt kernels are always shipped in tandem with updated device
trees (i.e. no Arm SystemReady IR platforms, where the DT is provided by
U-Boot), I won't oppose to retracting features described via DT if their
platform maintainers agree in a wide enough circle that the breakage is
manageable.

BTW, besides OpenWrt, what other software is deployed on these SoCs
typically?


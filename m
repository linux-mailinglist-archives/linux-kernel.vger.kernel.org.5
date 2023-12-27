Return-Path: <linux-kernel+bounces-12235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38D81F1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFCC1C2257A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027947F57;
	Wed, 27 Dec 2023 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAwEygAu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B747A57;
	Wed, 27 Dec 2023 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4a222818so21858235e9.0;
        Wed, 27 Dec 2023 12:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703707341; x=1704312141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F/knE1RdGvxQU+ZfFNTNGYvbGggyDmP5kq99ZSddVPc=;
        b=dAwEygAu//qGGg1PtSr1rdYP/JW5IFE/fw/Jq03EGjH2nz99lXKQmRYKsjCLOBZUz6
         vr9iRAW3+rGVWzGBD0ubJQnoJniRe5PKr3R31p9iNbEIuh6kr5pZmaZAFTuA232Zxr3q
         bQOBGK2etx4WPqN+jCZpAylnZS7Mt93OWJ+hiIok5ukLPGVPm5iNfCV9XlQyH96FI9lK
         PO3m0M0lGkf3J1GTuM+nNrDS8CZtn0/N2ZexMbqBH1+H7qdtFffV9mMSC8TTMSYv35/y
         8c5Y6NEmFVEuuNUFfT8BIVyMkRCP8BsoylKTR2yW8L4GxQ14fccdUIN4wIm+ZsNgvDyU
         cs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703707341; x=1704312141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/knE1RdGvxQU+ZfFNTNGYvbGggyDmP5kq99ZSddVPc=;
        b=kjEY3qUEhsp2Z1t1bqYQEGdpz+bFDRgBb4aKUO3dgOmpSqB4O307eHisioMM4WZ5sZ
         gHH0EUyMfQm/oyaWkKL/wNnjkp9GcB2SrMbFcFWNtqvk+XRCtInlPcn0YB/v0kniofu1
         LhL6DmNB7wqF+wNiz8iH+mXKsYmpwQJMWMdfQQOshUm2c1HF/pZL7UXJ8hTOaKzNjA06
         7RiLnZRNC+Uh0yMdJNLJGSLnSHok2yuhqIyQf0N3oGfTBCmBgBkLcP1lzGLnKtQCGqef
         gyB4Qikmf3ASgqNyjHfLi3E3Qw7Fs+owH2RatgBXtbfyGo2v4flVux0Z2tOZ46KY9DZU
         RylA==
X-Gm-Message-State: AOJu0YyHmie19YiOwBj6+bC6HqLDFBe7oXZy230Qo8eLJIIX64/KIFRs
	AitGx7cuEZPXOMMA3dpQvVY=
X-Google-Smtp-Source: AGHT+IG11a2jEJ56aVZt743+Urcm+oZvsgxk0OjEW0YCylo3AApnPF7ZuFFcQ/IqgS9k8gVkMvV36A==
X-Received: by 2002:a05:600c:4503:b0:40d:3eb8:580f with SMTP id t3-20020a05600c450300b0040d3eb8580fmr4726111wmo.14.1703707340716;
        Wed, 27 Dec 2023 12:02:20 -0800 (PST)
Received: from skbuf ([188.25.254.72])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b0040d5b849f38sm5739904wmq.0.2023.12.27.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 12:02:20 -0800 (PST)
Date: Wed, 27 Dec 2023 22:02:17 +0200
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
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
Message-ID: <20231227200217.kdltxpmhvlp6z4cd@skbuf>
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
 <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
 <20231227191154.6jkqdlqdxciidpfw@skbuf>
 <bdbe24b2-30f6-48fa-b6eb-a1ae3afe9076@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdbe24b2-30f6-48fa-b6eb-a1ae3afe9076@arinc9.com>

On Wed, Dec 27, 2023 at 10:51:08PM +0300, Arınç ÜNAL wrote:
> I didn't realise ds->user_mii_bus is also used to store irq mapping for
> each PHY.

It needs to, if the MDIO bus does not have an OF description through
which PHYs can have an 'interrupts' property. But if there is an OF
description for the MDIO bus and the PHYs, I think it is strange to
expect PHYs to have interrupts if they aren't described in OF.

> Should we agree that user_mii_bus is needed for all cases or make
> another way to store the irq mappings?

I looked at the upstream device trees:
- users of arch/mips/boot/dts/ralink/mt7621.dtsi
- arch/arm/boot/dts/mediatek/mt7623n-bananapi-bpi-r2.dts
- arch/arm/boot/dts/mediatek/mt7623n-rfb-emmc.dts
- arch/arm/boot/dts/mediatek/mt7623a.dtsi
- arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
- arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
- arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
- arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts

and without exception, none of these have the MDIO bus described in OF.
I'm not sure about other device trees. But it may well be that the
situation where "MDIO buses present in OF need an IRQ mapping for their
PHYs" does not need to be handled.


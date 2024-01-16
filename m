Return-Path: <linux-kernel+bounces-27433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C520882EFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D1B285DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521281BDD8;
	Tue, 16 Jan 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZonI7C3R"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C51BDC4;
	Tue, 16 Jan 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so11838005e87.0;
        Tue, 16 Jan 2024 05:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412829; x=1706017629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dW5FNf3SVxNKeXJ6KjqfCxnz6/Fif4OHJfNExviaSBU=;
        b=ZonI7C3R5ztUXUG92m9VEAubzLZG5yNsJmuaIKwW8a/AxyqCWOKyd/JoNqZr43eB33
         Em3ceWgHZG/uDISQr8rCLGHnBYP/9EK3f8zTefvXHz36QIy2OZWRzXjFBiaHDVT3xtA6
         JU7T3iUn9Di7KwCU1dlahLy2Sr69THsqiywsuIXTASr0VFezB6S7gD3w6hluKf9GP6M5
         Xs1q6h4WeYmf5a/JLbdfk4NZdSrTqivoGU1c9J8UW6EMJP9ziJ8Paq6v5E7pSQOLGf8U
         U2UcmEu2NkhFrEPZstjDYFw7QUzb8gBgmEn0kNCB5Cugjd2jU8kNvjUFs98KU5yoPFKe
         IYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412829; x=1706017629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW5FNf3SVxNKeXJ6KjqfCxnz6/Fif4OHJfNExviaSBU=;
        b=aFfFUlXg1D/AQ5UjnnkXI9rJelNkIH1qgC3t25hfUdk6Zj2b8VnLnAfWHxsRChyCBM
         iAGorfLUvlbLMTCaB8b+V79PuH0Ry9DgazJik7HVBcc2HZoU2wA/S65vJmTTFBT3GkYY
         P2dZk0jwQ3gbOoMUHlHAAMjTM3dZpkXK9Fn6hUp0NLhgJXjAy9oelZSmotFmWgKnFr2x
         veLNvKlnKxe/a68GPWNo883NCWx+POueuQ008PI5Nnd0bjxsh3UuG7bWOo3DDEsDq9cl
         jTEFjekXC9HhDvBLDWyf0I1YRTRxlJyCqkUx9Qs4j3kf57kslNqS2VonY/D+lB+KBkxZ
         AN9A==
X-Gm-Message-State: AOJu0YwDL/6Yw570DK9HwK3A6YnX3BjMYSM5o5CfffQ3Zfjs9OEJ/RVF
	wX4tvnK/nWH56GWIP4f5Fyw=
X-Google-Smtp-Source: AGHT+IHKRlj+eXp66CDmv5XZ+8z5Yxa8Fx1bURNMREH+HS2jVniBejbf0RJ6hAQJU1DNZXvvI/xejw==
X-Received: by 2002:a05:6512:3f2a:b0:50e:b2ac:829a with SMTP id y42-20020a0565123f2a00b0050eb2ac829amr2482333lfa.32.1705412828757;
        Tue, 16 Jan 2024 05:47:08 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id ca13-20020a170906a3cd00b00a2c869be22dsm6192739ejb.143.2024.01.16.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:47:08 -0800 (PST)
Date: Tue, 16 Jan 2024 15:47:05 +0200
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
Message-ID: <20240116134705.mw2a2twoakw5b7jq@skbuf>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-7-arinc.unal@arinc9.com>
 <20240115213720.vxlumsjwrjdkqxsl@skbuf>
 <7f59d9e6-1653-4a8d-910d-5922452bb9e8@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f59d9e6-1653-4a8d-910d-5922452bb9e8@arinc9.com>

On Tue, Jan 16, 2024 at 04:09:18PM +0300, Arınç ÜNAL wrote:
> Do you mean by internal port that the port does not have MII pinout? Port 6
> of the MT7530 switch do. It is possible to have an external PHY wired to it.

Yes, this is what I meant by internal port. It seems I was wrong to
assume it is always connected to GMAC0.

How is the selection done between internal and external wiring?

If external wiring to a PHY is possible, shouldn't the driver accept all
4 RGMII variants with phy_interface_mode_is_rgmii(), because the delays
specified in "rgmii-txid", "rgmii-rxid", "rgmii-id" always pertain to
the PHY, and thus it doesn't make sense for the MAC to not allow the use
of the full spectrum?

> So it would make sense to design mt7530_setup_port6() in the sense that
> dynamic reconfiguration is possible.

Ok, you mean to keep the dynamic reconfiguration possible rather than
redesign to disallow it.

> I've tested to see that the core operations for TRGMII does not interfere
> so no need to undo them when the interface changes from TRGMII to RGMII.
> 
> I'll do below on this patch:
> 
> 	if (interface == PHY_INTERFACE_MODE_RGMII) {
> 		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
> 			   P6_INTF_MODE(0));
> 		return;
> 	}

Ok.


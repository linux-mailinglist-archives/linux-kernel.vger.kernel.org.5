Return-Path: <linux-kernel+bounces-49011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59A8464B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB71BB21A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9D047F71;
	Thu,  1 Feb 2024 23:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfO2deg1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643483F8DA;
	Thu,  1 Feb 2024 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831831; cv=none; b=IP0+1GypcMwIEhiyKvdFjS+W5JStGBks6WezC2eUKY8jyPP3sNFgxtdN9rB9cO7qplOLYj5FaS6yk9cgTzpqA8OU10kzeGx3S0a20+4n5N19sI4XUdCa+RgpWoypj7GNH3ynaK9IbbJAYTALBzP3+0k3b2rxg7jVBU+/RXHfMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831831; c=relaxed/simple;
	bh=adT4iPkCMRDOEL5rMrtGnul/qErFA+76SbIs85UohKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxWGFzrLJnKzzfFpYmjAE9TGQOhdJxv2ET8IQNftTxvkvSYSROXDEkPcw1fAK9OHx51DXaeXWGIEDFE7Y3V0UE+YXBdyjODN4uTtMHRD7+C+lqG01pUpfnV0X4W7v5Lfik7sUtX8S7Ily6QymmqeLwURNglJudvKKDXxpAKQZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfO2deg1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so1482224a12.1;
        Thu, 01 Feb 2024 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706831827; x=1707436627; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=adT4iPkCMRDOEL5rMrtGnul/qErFA+76SbIs85UohKw=;
        b=VfO2deg1Th8agzKwW/rDp3aZoJpf5TPb4tZ2bFCogNbslOoB1X0j/x7rtcP3QdOLJj
         wTOW1ruIVGhNA/LaNkiOP7nkY+/pPi4fa4/v7pc577D6jHFx3VDXyhV2yjG2AFHRO/Ez
         ebr4tcFwzFv8IdS+DchxVLOShAMfg+a3Ii5s5jqDtKG74L4qay0PlEWsZDbeGM2dVG0i
         O2bk0Xl9OZLFZsTN466vBuA5K86ATKxv7ZqJoBjyY/7x7kcZ4MIQ76ApanGBpHX907NY
         2Bh0pshgsbGWCeqDzGUdH/IDHuXevZVdvEAMSNiw5vUYlCpRXDw7Ea8isUopNXNRvTy+
         9v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706831827; x=1707436627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adT4iPkCMRDOEL5rMrtGnul/qErFA+76SbIs85UohKw=;
        b=h1dGSJsC0jm0BVJzjZ1TkrhuUgoSrOrLyoN4vvmD+lY1YOdv6yvrG6Dsn9vUxSEEYy
         7r1Zt3PeHsKi5FoYxMIJYxS2RAfxAfFe12ezAH3Aj+KAW9s/zmPKlpJ+cuCkDdiI2IVS
         TlyS87dKFsOSlNpTrARzNbSMLcc89sEjK6mJgfZQHcSE3+lqAn3BDjbV6O79uZbqQfX0
         HB4KyWMg/rOk9/xpAB9LyppUDOvAt77BqNIMu8hRMGVZ5+qK6p6l/42Crx9XsOUH0+YU
         Shio9YwKYaTvjOVgniqMoLeoVI7nJyIEVJxLVJOuGm+A+n+qz/8KYyBWl38jZVpQISC4
         zFBg==
X-Gm-Message-State: AOJu0YxRHX/o+Pr4Q697lvTDZOuTctxR4ABt2YskdRC1YZwU54bpp19t
	y1EAXkPlGfEhELVgT27jzVtDTCO2zjQlyojfshGJDlvNovJobIyw
X-Google-Smtp-Source: AGHT+IG3GRpEb6P3gOztp8VYIYCGF8w4fWoFWV2IqNBIPIZrFxFvH07VopDrgtziHJhcQ1hUKaZ8YA==
X-Received: by 2002:a17:906:6d15:b0:a35:dd08:c7ab with SMTP id m21-20020a1709066d1500b00a35dd08c7abmr2828558ejr.26.1706831827348;
        Thu, 01 Feb 2024 15:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVUl2qS8vXJYPNH/8CEBWNcoQvNoq8VNnDC5tiT41ug2qx6eB9httdjpfEMwq1/GeIzcQFfDnW3mKXY65DN75xVqDEvnMTCerLFrxvvOyFvezJ1SON+S1aj+OhUPRy5gm4dnsAoxWxbguCFfELUikvKYxwh7Fcr1gnoXhwxt3Qpi+yimXcBy/NHWY6OkacFyjE3LVc+5BYunCYhLNDTgi6jmlRF5ptJ/o3bHHHs5GwoJHT2G1AkfPZfTZc8i81lYlkl8jgvVADxirW3Kj/YzYqlh8vSrib4k3VoeaowMo3ZwwctSD6YCLjjxsDPWoKkjRza8v67yIQkF3b5r4abMlmi/bdy4gxkwi2ztKapPBTNn+sdwGhPkBKbA0Hkd+euAyC/hJkb0py1E2qcBCT83Ui9yAHyx7F/1cvOtWfZ+Swdg1HgDRKxMPa2YrSWCBHSHoTH9ga/2USLPtDxdxmu/7PAuTQ/Yz6tnK+gr+5fn6GcT3i2WBj9PI9kFIr0EW0ouCqqmeGd/c5nAf3C5qV2nfj7hIWRe7RJYblxAEx4V7LNlXExsWhaJ++GSB3yTs2WXWHy5yiE4jPqNpfC1OFgvnvwdd9tIkutlR66JRpfuESHB5O2NSbFOsVVzZaBoHALpjeJeLKrtEJoP3mibkjDIbPtO/bvUY9F
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vu12-20020a170907a64c00b00a31c5caa750sm277937ejc.177.2024.02.01.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:57:07 -0800 (PST)
Date: Fri, 2 Feb 2024 01:57:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
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
Subject: Re: [PATCH net-next v2 5/7] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Message-ID: <20240201235704.6wxbkpli3dk4pn4w@skbuf>
References: <20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com>
 <20240130-for-netnext-mt7530-improvements-2-v2-5-ba06f5dd9eb0@arinc9.com>
 <Zbkc4BRORWYu79GZ@makrotopia.org>
 <77c38489-8a73-4b00-bd82-48174b4d620f@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77c38489-8a73-4b00-bd82-48174b4d620f@arinc9.com>

On Tue, Jan 30, 2024 at 08:46:04PM +0300, Arınç ÜNAL wrote:
> would supposedly achieve 2 Gbps TX & 2 Gbps RX

Source? Commit 8efaa653a8a5 ("net: ethernet: mediatek: Add MT7621 TRGMII
mode support") says "TRGMII speed is 1200MBit.".

> Unless the MediaTek SoC ethernet driver somehow caps TRGMII to 1 Gbps,
> I consider this whole TRGMII shenanigans a scam

I laughed :)

You have to see whether the CPU isn't in fact at 100% already, becoming
a bottleneck before the interface speed does.

Also, mtk_eth_soc.c has an interesting comment "TRGMII is not permitted
on MT7621 if using DDR2" - not sure if applicable to your setup or not.

I just got myself an ASUS RT-AX1800U (uses the mt7621_asus_rt-ax53u.dts
device tree AFAICT) which I'll be setting up with OpenWrt in the weeks
to come, and on which I might also be able to run some tests from time
to time.


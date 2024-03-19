Return-Path: <linux-kernel+bounces-108153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DB18806BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BD4283043
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104EC4084C;
	Tue, 19 Mar 2024 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLasvxia"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F211CAB2;
	Tue, 19 Mar 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883895; cv=none; b=ZHmW9RSnYd8XJ+f2IvgLZ8knYzrmyaCPO5sZ8Nrf055v8ko5juOmdLKk+ZmzeHR0IMzkHQks18Y2sEmr1MGt1uflkcdTgDvruP8wK9NLZp8PcQ5xFYPtD+2PaLuGcaUvmoU1rFi9RIjjzVn70tGs8e9jz47M9k93GOK6sguSgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883895; c=relaxed/simple;
	bh=zjnqV7/l7F4oUWwdqs/u7Wk/yajYmYpGp8Fsqv6QLLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLoSZsw/jrbgyxdN6ufB0TaQtTYDoO3tN2uo8ucP/1qoP02H5pYDU7j1ieiFDnoxYipeV2z9hT/PuHaoIY52Y4Gf1zHlGx2E8TcObSDaWWvEI7kdwpzwCua51wj+TobLdGUsEwe2rKaZWZ4qdQj+ihNdYHhI8gsYDeLmLbP/LKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLasvxia; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21e45ece781so3976603fac.0;
        Tue, 19 Mar 2024 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710883893; x=1711488693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrrC27c+leVw8q3sOhDGD63wH3I4xP5q0fuuEBKNnzQ=;
        b=aLasvxiarRGmk9PiqaC7HqPAFipPOSQCNnYaicqQCxveQLCsrSdtUNSDg1FUD/eOtn
         ///QZtOHIj8L5q6hnh6e6aWM2ETUXODwszZWSnN2Q+xXO2fX3Awa+enOR1iyKaabFs5R
         H+lodF3MIr7SL7FDMSN8ea1YHy+QjiQYaFkj2fLz14h8wE2uM59x9zYYTDi9QEXBTe8f
         FGiuo4SQGZgFEcEmRf87MLY+bHkGfARgJFag8KcYEs7b39OVJfpzlD/IEVEpeeP462pa
         VtrZCwAcjdhlFk2F0OIzOtmNyQHszx5JKFw1XB1xkSrlNgxB2xKJ9dET1GzmSpxdQqrr
         cGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883893; x=1711488693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrrC27c+leVw8q3sOhDGD63wH3I4xP5q0fuuEBKNnzQ=;
        b=tb3mcFd2hIsRkwRejXoWIeESDDtoI9ATTiLzT3cQJKk6sH2EaQr0gzUp4tTObBqvET
         vvn/fqQAO7meDsYy3xX5hF2UZLXxnM7ud1ln5K79+64ZwXlJBMQfo94wx0AoUI206bPK
         rcuqpQt0M3lamuDwlNGJvQZFQMD44IYqOkeKzjkRypj0QyGdtcTce/devpcqCYjvkthO
         OREyad5yx0IIqDeQYEGFHR9eTAd0E9cw8gpOj38SBErzR110YXBQ9lkobKpcVSjpAicE
         aDCulQYiAOI80WXan7ZdAV7BSvF7Zbkfk2aV8gOCag4d57AkAS7mcc9rQGef8Nb/8ECr
         8I5g==
X-Forwarded-Encrypted: i=1; AJvYcCUxGoN1OK3C3FViQrxVVLLPdSpg8WZbSV1Bdw8BBBIYoH8KQ92ZwuI9Oh+01YrEOFo9SeU1cwcmRtudYJyVEfHXt1/Htdh5Q+yZbPSgf/9DbiwhlzdmdZMi6j7oglgAo6fHbqOt
X-Gm-Message-State: AOJu0YxgTmI0WQYipp3cKzqKnyG5ahxW7mGfixbGWemfp/uyANGn1wFp
	CbxNpuVzBT7fqs29keUuywWA4NgUVgujScWBPnL7gNc6ugmHhGNE
X-Google-Smtp-Source: AGHT+IGTbHkm/yZu+SFyFjorv7aR5q2Vk7pijIwUW83u6t5zXogAOTFA3W/xGBNXcrmlWiRg+MWmyQ==
X-Received: by 2002:a05:6870:9a16:b0:221:94bb:c050 with SMTP id fo22-20020a0568709a1600b0022194bbc050mr17101034oab.32.1710883892747;
        Tue, 19 Mar 2024 14:31:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h62-20020a638341000000b005dc832ed816sm9520138pge.59.2024.03.19.14.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 14:31:31 -0700 (PDT)
Message-ID: <38798882-c033-4949-9446-4c6f15c25ebe@gmail.com>
Date: Tue, 19 Mar 2024 14:31:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v>
 <ZfnYkuzuvwLepIfC@makrotopia.org>
 <00ec9779-19ce-4005-83f0-f4abf37350fc@arinc9.com>
 <6cb585f6-6da8-45a2-a28b-2fb556f95672@lunn.ch>
 <Zfn1DxkEa3u-f7l2@makrotopia.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Zfn1DxkEa3u-f7l2@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 13:26, Daniel Golle wrote:
> On Tue, Mar 19, 2024 at 08:38:03PM +0100, Andrew Lunn wrote:
>>> I would argue that EEE advertisement on the PHY should be enabled by
>>> default.
>>
>> That is an open question at the moment. For some use cases, it can add
>> extra delay and jitter which can cause problems. I've heard people
>> doing PTP don't like EEE for example.
> 
> MediaTek consumer-grade hardware doesn't support PTP and hence that
> quite certainly won't ever be an issue with all switch ICs supported
> by the mt7530 driver.
> 
> I'd rather first change the (configuration) default in OpenWrt (which
> is arguable the way most people are using this hardware), also because
> that will be more visible/obvious for users. Or even just make EEE
> configurable in the LuCI web-UI as a first step so users start playing
> with it.
> 
> After all, I also have a hard time imagining that MediaTek disabled
> EEE in their downstream driver for no reason:
> 
> https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/24091177a18ba7f2dd8d928a8f5b27b14df46b16

EEE tends to be an interoperability trap and typically results in 
unexplained link drops with different link partners which are difficult 
to debug and root cause. It would be great to have more context as to 
why it was disabled in the downstream tree to know what we are up 
against, though I would not be surprised if there had been a number of 
issues reported.

That said as an user, if someone has a well controlled environment, they 
should absolutely be able to turn on EEE and see how stable it holds in 
their environment.
-- 
Florian



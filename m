Return-Path: <linux-kernel+bounces-106134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2A87E9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3583FB21A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EA381DD;
	Mon, 18 Mar 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C37lTiKK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703062FE0F;
	Mon, 18 Mar 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710766681; cv=none; b=AJJoaqaxwuG/VICcBB580TZIXKWrKsy9vzQCnXMLkz6pU+AxrJsXvkSHK1DEaVI68xtLnaDyvkOes1YeN4G2T+iP+pgcaCXgyMNMA1UpMQTbUPK0rQSFj6SoGQY+DjsVdF1TX67zQGEvXtNrrYCb72nf803kJmq0Z+66AdIpgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710766681; c=relaxed/simple;
	bh=Arkuyti3ClBvR4I/qhMQ0peX5YA95IFt/w3Oz/USJ6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMwxWH7DsJivgOTakGt1tUbErwHWsnsED646bFeUTqWzDxtnMsM+yb/z4glLyHKtMv2ER80HdwAWUWKXtKO+AcbiC+KyjIWryuUv2yChB/VXYcldicqth6dkkua5eGm/LpvkAm1+JicdVfQ6a1IrOBdoau/Ckk4Q4BisKhR4dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C37lTiKK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def2a1aafaso16342505ad.3;
        Mon, 18 Mar 2024 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710766680; x=1711371480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=91nvf3PjawLKSdl1v7VHH49qCH92cS47sWWSsK7c8+4=;
        b=C37lTiKKwPqcyUwmBMxSE8PogjUzxgyaw+dFc/HfdnZ13A3P12r72UiPaDJFjajgDA
         pbZAFbpOCjIiuq4XpsTTo761F4nYccnKKzxE31uh/6Bu7QHs854fEUjgaP5ZvC/11QRA
         aFXuBUFTqiQ6LwUjSkT2zF2CLygV6/KfHPPH4uixm18IhxnvefH7D8cCT1I+qHK6Yldk
         ye4XfmSdg65C7bC6tM1p5TAzHuVxz0g8vQhvb5QSOfJQjY+LfuL9ZMcPUr+7/A8Jaeiz
         AwbVwfFgmYrpKIiPqnJng9yJnCbSYN2tJ/RxiGGoVJIsnFPcctxwcf8q96bUWCMqfyrr
         RrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710766680; x=1711371480;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91nvf3PjawLKSdl1v7VHH49qCH92cS47sWWSsK7c8+4=;
        b=HTrtgHB/BnKHe7VGUXmyn7bN15hnsgPcHNqTxzjr7ncNLtYDXgNjnpX5nSk35kuZ+Z
         1aJifXg1KM4NUQ2KDFAhUGkeZy1PtNX3CCN1Z/iI/LcYo4FHR/cDnB8GId1CbmE7fQEt
         inR64CtZ2YYkSZwPlTyre5ksJBGjXS56I3Lb+HlAZuhN2zCHpHdpcwNQQdYKxSPt3TOx
         5CDtbjI7RaQvEQOYpfxHr7ywr/2SR/2NwmhsaLSgv9gE7MQ9R9mjTpm4WMb4YaP6IcFf
         jN7n2P+WG4VenVnj58JTqp8Zqyrxmcpvxwu6Ydbwo4k0jKUvOaEBUnehdNIl6iVZMQbq
         GjFw==
X-Forwarded-Encrypted: i=1; AJvYcCVCS2a+gvZVkPfSzLUSmEixO7e1MF+vAJFOIAjo7dOxcQvwlTVFgLlIEpUQve37hiigDSx2HjqYtd2O/9Te01TErqiG8wm3/xuKIZCQ4JxAtwxw09AeGkc2fXHn76n8Ozehdl8m
X-Gm-Message-State: AOJu0YxfzTK5avJwq3KhLSMMYYaqtJ7DqgktPdIchjDiCUR4ElsV/btq
	AKLXXgLqn3hHsp8VfwHf1rRXGavLSB3R7jm8tUhAqVHv74Lb6P6v
X-Google-Smtp-Source: AGHT+IEfFrIFbvLrLZvtZuZGp3sq0hKMKWcdlRgs9E3Z/xL/2UEW01eq5JQ3D9lWNf8WMaqjw+UQQQ==
X-Received: by 2002:a17:902:e547:b0:1de:ff81:f666 with SMTP id n7-20020a170902e54700b001deff81f666mr8229243plf.21.1710766679628;
        Mon, 18 Mar 2024 05:57:59 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001db5b39635dsm9119591plc.277.2024.03.18.05.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 05:57:58 -0700 (PDT)
Message-ID: <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
Date: Mon, 18 Mar 2024 05:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
To: arinc.unal@arinc9.com, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/2024 12:46 AM, Arınç ÜNAL via B4 Relay wrote:
> Hi.
> 
> This patch series fixes EEE support for MT7531 and the switch on the MT7988
> SoC. EEE did not work on MT7531 on most boards before this, it is unclear
> what's the status on MT7988 SoC switch as I don't have the hardware.

We've received your patch series 4 times and this was the same thing 
with your previous b4 submission, can you find out what happened? Thanks.
-- 
Florian


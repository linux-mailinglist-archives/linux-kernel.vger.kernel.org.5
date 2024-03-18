Return-Path: <linux-kernel+bounces-106152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514AC87E9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0681F22243
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A538F98;
	Mon, 18 Mar 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI+0rc2H"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF213BBC1;
	Mon, 18 Mar 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767517; cv=none; b=Bdroqxj3RCUubQotzq5dWFzuRDOXSCbJB7QNJsw5xAFx2CLB0iGk9nI7iO9SoKFsUJVLie/IjeJfzUnPdxHeM5xx52HIp6iZS4Ml0Shr8R1vm/DDdN96JewfZzLtY/pIBt03Y26k0kfOvdZABnmRLIdzFG+nVHuafdR6VDYVUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767517; c=relaxed/simple;
	bh=tyFMDuuCeBtOYLIiMFvOO0NFCs9r8yz/TGZiHuyr4CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdfPpcNpC+AAenwfhcG5iO+7VYA6jNuExZ30TuD5MUdgOg6NOgw1NPsunrzJQPw4jYDg6xrUzBoTexTnPkFdkgkuBGj0NAfgAry7gwEFZFERqhmlz3X2QbZ2AIF7WQRZByeywSGKE4Ajdn0pSu44+nStcMjMaBRCZdKC8r+jjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI+0rc2H; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6962950c6bfso1919676d6.2;
        Mon, 18 Mar 2024 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767515; x=1711372315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR1PVTYigSsX/lfBBb8BrTI0Bk6Qcqxklf6J6zVF8SI=;
        b=mI+0rc2HsPpIX+78dHtdtFKWhdBUOa1I+yu7O7RBrtXeFhETPeZpNlWO53q/V/mJek
         UEf7Zg2u+IxwX736X34kXB3sxaFbpNVDequw5s+r+8YTkSP1Z5PxB8ltidRJVgYafRQq
         +uIrmVaTOkQywwsnHN8U2R3ouh1XMGt9oqiQqLhxVVNG3lcTDUHFZPlqee7vw9tYFL1H
         ZZFIIq+GZXF60akA+h3RSNBnPMuhWxjwfTtlF45AOOVRKe6ZJe8+vk3tDRCswahHKzCm
         zwk3kzO5ulCgkf2ybJY1YRAX2QQfjD5Bim+2YRukNAWya144Fq3PwaxungUgFUjjVoXy
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767515; x=1711372315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iR1PVTYigSsX/lfBBb8BrTI0Bk6Qcqxklf6J6zVF8SI=;
        b=w43fNc1MMJDz3lmpygymm8/6reBtBYeBzTRO9ITRTnNoW1jKgUkVX9h+dEqVh53Hua
         dwWHj0XY7/kOy+K1Rw0lkjmIvGbKo7JzQJ+q9E75EnJC8eHJbBpdHy/U9E+gBdl00eJv
         J6QIzFNubJudqRfTxW9MoAIp6fJP6Szx1qBFYPVgXp10+NxeBUoyuMhlsxBjYBZb8+/r
         xnt7nla6Ys0wmnSxW4NgmmuchH2PwunLod/1X0CUk+LkHBt0sKYCGnABnHzHbTiWHaKI
         TIwXmsP2+TcdrHb3snibYND91E/RqE6rISLD/RdBWzdxQUMIJD5OfJgNEDez0Rq2D4Mv
         1H5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU6MCVti7v9y4n2Ilznf+nrOO4r5LpE0sBf4ftqXbR6F5yaGVVkIGZP7o24cKKqkUn5USKzRW2B0jnYleZKCiTM3i7blPxoupQkV8SXGqZ4w5cb55Q4hrIp4Ds6VPIN0SuI7YI
X-Gm-Message-State: AOJu0YxgaPK90rJERAzvHVy83PbHHLDuyS45b41BknYtldGGnz/3wzrx
	atwq+yHwmNe8y6z1zWtuuECCw5GETylnDpbeNTr0KUmtLSpUYTtg
X-Google-Smtp-Source: AGHT+IEyZvLimIql/3umoWPezmAL/scvy5OqI+bhWQ0vzUndpy1LV31gNE1h9DgMDwYY3wJZJqyCsA==
X-Received: by 2002:ad4:550d:0:b0:691:5c3:bdcb with SMTP id pz13-20020ad4550d000000b0069105c3bdcbmr11468009qvb.32.1710767514642;
        Mon, 18 Mar 2024 06:11:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 4-20020a0562140dc400b006940b9ec66fsm2381423qvt.82.2024.03.18.06.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 06:11:54 -0700 (PDT)
Message-ID: <85bc49e5-a086-4484-86d2-bc2c3829de87@gmail.com>
Date: Mon, 18 Mar 2024 06:11:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: dsa: mt7530: fix enabling EEE on MT7531 switch
 on all boards
Content-Language: en-US
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
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <65f7f17d.050a0220.7383e.5eeeSMTPIN_ADDED_BROKEN@mx.google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <65f7f17d.050a0220.7383e.5eeeSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/2024 12:46 AM, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The commit 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> brought EEE support but did not enable EEE on MT7531 switch MACs. EEE is
> enabled on MT7531 switch MACs either by pulling the LAN2LED0 pin low on the
> board (bootstrapping), or unsetting the EEE_DIS bit on the trap register.
> 
> There are existing boards that were not designed to pull the pin low.
> Therefore, unset the EEE_DIS bit on the trap register.
> 
> Unlike MT7530, the modifiable trap register won't be populated identical to
> the trap status register after reset. Therefore, read from the trap status
> register, modify the bits, then write to the modifiable trap register.
> 
> The disable EEE bit on the trap pertains to the LAN2LED0 pin which is
> usually used to control an LED. Once the bit is unset, the pin will be low.
> That will make the active low LED turn on.
> 
> The pin is controlled by the switch PHY. It seems that the PHY controls the
> pin in the way that it inverts the pin state. That means depending on the
> wiring of the LED connected to LAN2LED0 on the board, the LED may be on
> without an active link.
> 
> Fixes: 40b5d2f15c09 ("net: dsa: mt7530: Add support for EEE features")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


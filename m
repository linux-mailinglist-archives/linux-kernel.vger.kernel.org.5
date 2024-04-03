Return-Path: <linux-kernel+bounces-129772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE0896FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD371F23D7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51850147C78;
	Wed,  3 Apr 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POnvFKb0"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1ED146D41;
	Wed,  3 Apr 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149370; cv=none; b=HcZ/2S4dIqlVDN1XDGiwNwuOsjJvtl+KlaehZC2aexR8IJQ9YA0SSmPElAaPyVwBEM2JTNDNYD9hwGPztLC/ummc4CWeJThM/v/ZK42j9AshJxnIKEWT7d21Jb6OWC+4eS95oQ9Bhzyd8BvbX5hBG+OBuix2EurWBuQOJsbeM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149370; c=relaxed/simple;
	bh=hw5nstH/aWLZR28LRNGx4WiHTqN364SKNIoy/xYa0aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHGvCeZiILKMGqUhB1unVGIpZagD8MKGKdPLIomK8MdlgY9qjKRo8mKAdmNDnkfhX37eSas7rKCTnH10T1wXo6oCrSi/hQ05EHv+UsLK+WtRcg213u2+SOe6isHDxME7qHsZhcbW72KmmAv7189BTeO0TgYS1mZrug/M8Al3Cyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POnvFKb0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69185f093f5so42678996d6.3;
        Wed, 03 Apr 2024 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149368; x=1712754168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hx7EYv4IJOIkb32SY+wDuXVbwY8ZU9DgTcpcBOESv0k=;
        b=POnvFKb0wB/wFQZSBw1A4cNYfXTXdN6h5x/R7lJvrDrfaRcOM1UODB483k606/bK8I
         ygzDIupHbykQ1e/iWSVlKAogvqyptgBaAQ9fyLs+oAyqbRKfnPgUvgMon1stVVS9AvYg
         C01zWWd07P9MqUjSdxFZVMC9hWm3ZzCHbkX3NusViEUHaF2NOq4DL9xHhbNwZiBk4vQv
         XNsU0YHYaFj1SDnsgQHy30wlDg7GPbgxMfQubJ4Fiu8m0H6VBY1KlR0IsrQT5G7GhQ5U
         nO+2Pr6cosPXIQzpDvToI/mJMxoaySEx1uGlG83nB87wcu5rr3twGa1wRx6J8IBkrD68
         SNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149368; x=1712754168;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx7EYv4IJOIkb32SY+wDuXVbwY8ZU9DgTcpcBOESv0k=;
        b=UREOInS0DdtEJgkKUwdQKDad6LKVC4Z5Z1eSTNeCcXnhLOe7+hsEeWmqWDCDC+LDK2
         PpGHENRKOfw9SH95tH/+lvcnN9XsXD+IsmTtfB7e+HGwdgrSns1uNDo7M3hKFRW4SVoT
         LPvPUh/zbESRu3V8tOfQGp2UAt4uA4b2+4elY3vrBWptD85uIbMIHbnlqLSapkLIUBMM
         AbYVwjO5i4KRZWtmCFP1JQUzLZb4CZXm0t+2N9BtKSkSEfiSfXbRUpgXyrBlxtR5jLGt
         rs4PBvTrrBMfCHFkKBYyqtWfC+4pZ5NL+2BslEszee+88XDUNZdyzdVSftwKecETlcWu
         sIRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbbbW75CeYOmJ5ZORAMn7E9piOnEdxZvBKwx9+J3xwLKnX1URPD/g6JYxKUu3yUudIYF+Zub0gGHX8qxOHheIFOHEvWeHQZH3liHUX2hw9ubx3mgJPx6nURuRVCqUpYXqRT1A
X-Gm-Message-State: AOJu0YxaBaCLeKh/Rg9Lx/pmUdbjTUqdJ4sk2DWoQ79QXBWBmdUiwRMW
	xtHLqzt7mzEazRi7JEmWTjz9zdcF4EWMl6t1vpPad1dFxF/wnGOo
X-Google-Smtp-Source: AGHT+IGmN9JMj+/LYXLGZvLwqs8yQGbMpt/nmtZyZA3zWTHqlrMOghfo0aVUBEaTp6AygM/MohEdTQ==
X-Received: by 2002:a0c:8cca:0:b0:690:beb7:c6da with SMTP id q10-20020a0c8cca000000b00690beb7c6damr14624701qvb.38.1712149368048;
        Wed, 03 Apr 2024 06:02:48 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id jo28-20020a056214501c00b00698e1f25f22sm1538442qvb.4.2024.04.03.06.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:02:47 -0700 (PDT)
Message-ID: <c66cebd0-11d9-41ce-8fc7-617a1b3a716e@gmail.com>
Date: Wed, 3 Apr 2024 06:02:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/8] net: dsa: microchip: ksz8: Unify variable
 naming in ksz8_r_dyn_mac_table()
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
 <20240403125039.3414824-6-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403125039.3414824-6-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> Use 'ret' instead of 'rc' in ksz8_r_dyn_mac_table() to maintain
> consistency with the rest of the file.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


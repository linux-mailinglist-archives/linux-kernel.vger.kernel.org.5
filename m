Return-Path: <linux-kernel+bounces-145461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5F8A566F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B783AB20ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650178C8C;
	Mon, 15 Apr 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O47FtMFg"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E360EF9;
	Mon, 15 Apr 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195066; cv=none; b=s2o79elzHmoowYluw8Qtz7nq++jKIdZ7V7WSphQJ1mIFSF3NALh4U29bPm7U2pjs7SC6SFjeHD3KDlY8b9RPEtLYTUlZAcTOip+fhLBwGv+Ir4WIGOn1BSsYPZ+obkK3IPmoB5HXnz2SlppVB/jkXpvStSIWssd+L3ykNDnBWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195066; c=relaxed/simple;
	bh=wapBw4V2DrvpOosJ+DOFRqOAHFrTGV9V6EWZ/ocZ8Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbouuTPmRKQ+IBnEg3a14bc2azKqyERiHnLPdBRDuNa5K0AfWl4ycdNJkz1JJz8A302jr7ULoMwDsX4uz/Cak9KZtwP75oxMtGwu/Pgn9ao3mJeiRgfgUiLQ/EYdFbM1RrbgbAWoyVOnWOo1yBtjoen4NLgwcMY44GjIkrwu3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O47FtMFg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78ebcfcd3abso280314185a.1;
        Mon, 15 Apr 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713195063; x=1713799863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MdEQyvlBs8JPSR6sY8l1QfloixZaJaJWiIIgUApzqz8=;
        b=O47FtMFg0FQ6z8ISm2QBhZ2pq4S3xMNURuiQTHLf8lzVjfm2g5gjDoxFWgClDuGLy+
         +Ws+Bg+pGIwv+2D4tmzV+FUj992YPig3MsIZimqUHwK0k+2lHYgXu9Ioen6PekPbkQBQ
         l0XXet7zu+/8vMj693RsF+x96DJeErAbtFTht9Ry2Enf0B3lgt0SJRPwudvAsUPpw4qP
         JAXh4AcP+ziv+7eMJYMn7jin1L6fC3e6znPaoW72XWgAW4umbmIfICul+YnXt0CBH6Yf
         3iRMKqEvCLfZjzqED1JFTLJeTzSsyPqjVescIsBjxqBVUkt3rTI2ttM5iuMK3JckKo74
         40OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713195063; x=1713799863;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdEQyvlBs8JPSR6sY8l1QfloixZaJaJWiIIgUApzqz8=;
        b=BI0Hw9CHSCbqZ8RFPajSuUsK2bpx6VReun1ZEI2mlgVjWutkVhIrfJvdeaA8TP2KVr
         fU3ub7Bxray0GYMMr69ee6g2T7isB9CNdlO4SNGqu7iAyqCvGr6XGY75QVC4sdnsvhD6
         nVQWcGSB5liM5ZY4mnNfj2ICEOSlZ3weK51D4MxDaIzamj0o2WTNyQWtqLuUPlyLKyzf
         9jid0dUwuY5G29Vqn2b9Uz59tRHsl7EHXwfXLkAr+he6woyAmOtqFmBwn4Pg5At0WDfB
         bKWyKoD798s3pCMEI7/IiEbr4zPCqPvcaNn+2A8IgNen3uNfkNNVdlM6C8k7ZNK/gMkK
         OvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEaORe/uDJwibZG6y0rByLEJdTU/mRY6jD7Lf3Y966H8pQYRn0oRf7BaCKWLvqsXwvKtQgRhXEcpfJcm8ChsAu6GuL6JGvG11uv+oVbc6jymO+nl9faPFkEuA7/p4poYZ409n
X-Gm-Message-State: AOJu0Yxon2Zd5BiPAwhkNYnIQ0SrR7cOHp93UIqwnkTcT1uwbtzRflug
	CJcDDUwE0JjbiwoG04vCvaMEjesvqTj8bhP+U1Q6vh89LlTaDHVx
X-Google-Smtp-Source: AGHT+IEhtLO+7hPlAs3otp/4TH5Ey3+BrrnBrw7Dd43SvvDnFqbEILnl6s8hx5eye4E29FtScbMAIw==
X-Received: by 2002:a05:620a:4ad3:b0:78e:bf95:fba6 with SMTP id sq19-20020a05620a4ad300b0078ebf95fba6mr12625309qkn.60.1713195063533;
        Mon, 15 Apr 2024 08:31:03 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id xx18-20020a05620a5d9200b0078d632edfd4sm6479151qkn.14.2024.04.15.08.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:31:02 -0700 (PDT)
Message-ID: <459b31bd-64b3-4804-bc5a-c8ffd145e055@gmail.com>
Date: Mon, 15 Apr 2024 08:30:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530-mdio: read PHY address
 of switch from device tree
To: arinc.unal@arinc9.com, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/13/2024 11:07 PM, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Read the PHY address the switch listens on from the reg property of the
> switch node on the device tree. This change brings support for MT7530
> switches on boards with such bootstrapping configuration where the switch
> listens on a different PHY address than the hardcoded PHY address on the
> driver, 31.
> 
> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
> switch and its PHYs can be configured to listen on the range of 7-12,
> 15-20, 23-28, and 31 and 0-4 PHY addresses.
> 
> There are operations where the switch PHY registers are used. For the PHY
> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
> into a macro and use it. The PHY address for the control PHY is 0 when the
> switch listens on 31. In any other case, it is one greater than the PHY
> address the switch listens on.
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

I would go a step further and name phy_addr switch_mdio_addr, or 
something along those lines to clearly denote this is not a per-port PHY 
address neither a proper PHY device, but we've already had a similar 
discussion before about spelling this out clearly as a "pseudo PHY"....
-- 
Florian


Return-Path: <linux-kernel+bounces-147880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156BE8A7AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A23B2235F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F5E57B;
	Wed, 17 Apr 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxiwm2Tt"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CDF79D8;
	Wed, 17 Apr 2024 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323398; cv=none; b=MhvDuK7C4kIKf7GKalTtYZ0w3wHofOxjJ7vIgmL/kx16E2JzMRGkv9C+Jd4KVm7XUPpZugMlBfPNLa/b/zknwouUmWvxHwL3OhWHLGwXKpflad/7yMxty3DLAJEXfcBW/rzHww3q+aFqb0R4tU7HXzgGKr7nv4hMyTuoFdCVxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323398; c=relaxed/simple;
	bh=CqWv/m6W9/2XEdEZswVlFVzt5xhZhM6JxBcKQDA4jjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMxB1irAf3+Jq+l/qYUcUJp4ntpp9i/cESjcRCIOzNcYzjr7TRuZuKIk7McBCOpj1KAuwg2XAzg7cwLV3rq+f06XIG3MmB6phE7CI8F16AK++9XNfitsX4aL1LzF1oLeWeMyz7ATDA2kv61flQiL16t5Aefj2RPATHu/4WS+aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxiwm2Tt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d68de297fso402844885a.2;
        Tue, 16 Apr 2024 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713323395; x=1713928195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmB2mNgA8q4RGQiquNCt84NUWuA0LWLQljDpEYXLFWI=;
        b=Dxiwm2TtR0B7WdxGCLACkQxigm5O9feWxMIfThRBiAQYd0tVLG0HlxT7qJwYwCI188
         KLsLt4V6wOL7HwHAfI5/nkt8aPrkzs1bJkQ0eQt4KXD1sOsSQ/IAhyO2D2M6oArdumNL
         88C10HqsdjpnlaWtUwtpzC/hi0+acAlsHx2Wu0t/HlnH4Gc4mULHyCuxm+K05W8iMu0K
         GVtu3DVEJ4s+F0b3Ky3kRVV+Wjvwr4xfw5WdNhXo10YMqWjvwvBqOebib/A3tbUz3dCO
         zBCZnimbqSc49cxN5i7+Xbh6Sq+ci8HaxY2OwzLil+YDdJoIWMyztjDSmTYUk7N2OuWT
         8Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713323395; x=1713928195;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmB2mNgA8q4RGQiquNCt84NUWuA0LWLQljDpEYXLFWI=;
        b=xOwvWpS5JlLYI0meUJ4fBT+UCF455vbzz9DA7WlWJATpudHhD9iBx6qrFiQ+ul4cV2
         XRHsM1SqxxUGIPc/Tq2GkRjNJ6WJHGTbhg4DgXrnk2FWgN97irAQWtjqBMAoMGB3XMzX
         cwiNcU/erbuvAcZYAjpvg2EfnINQQCtJdZQaQ0ja8CXG3EOHW8/RuFrPIwDPCo0fIBTP
         vD5poPecG0mnGLqyaVULHnBklfsAsVl06k6AAVN/BzfiAa3/g4DfwK/hyBv2WWJugoMJ
         k40ycAs3wRB5Zz3kubVGJ/Yr7vp1zPhV8k/qU+ryY1RBNoaOvaqr7UIGqOJ+BMwvnQGH
         I2tg==
X-Forwarded-Encrypted: i=1; AJvYcCXpdD/JteTmlocqSi8Xr8e9t1gFwPMX/R3l8eJD6FE5ogbqEPwAV/qjpx+yLJYW34ZnMSnqOUucUGXKyhqg1D7z+Y/dwUz9jkIbeaWuX5dzK0nELPFTHSsX3fpmQtAi8ozqIplz
X-Gm-Message-State: AOJu0Yw5b1uVKY7xJeVLn+nerLcRPZnKDlDudLOH5AG8vfC0zx68v1zf
	SUZ7esKlv4M39iVfDQEMX+MNDlpsCQOCuE74gxBa9gRDGoQcTixL
X-Google-Smtp-Source: AGHT+IETJ9k9mKCNBunC8b0Yz1c8lQDgg7FAC6fT4smpbBh487SS1A3TsJejAqG3PArmUu07sETxxw==
X-Received: by 2002:a05:620a:47aa:b0:78e:dcb2:4cbb with SMTP id dt42-20020a05620a47aa00b0078edcb24cbbmr11078301qkb.31.1713323395272;
        Tue, 16 Apr 2024 20:09:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a090100b0078ede19b680sm4229193qkv.75.2024.04.16.20.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 20:09:54 -0700 (PDT)
Message-ID: <050ef345-9f4c-437c-863b-fdb8e2a47041@gmail.com>
Date: Tue, 16 Apr 2024 20:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530-mdio: read PHY address
 of switch from device tree
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-0-1a7649c4d3b6@arinc9.com>
 <20240414-b4-for-netnext-mt7530-phy-addr-from-dt-and-simplify-core-ops-v2-1-1a7649c4d3b6@arinc9.com>
 <459b31bd-64b3-4804-bc5a-c8ffd145e055@gmail.com>
 <7d0ded52-14f0-4f6a-b639-72f537603be8@arinc9.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <7d0ded52-14f0-4f6a-b639-72f537603be8@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/16/2024 1:32 AM, Arınç ÜNAL wrote:
> On 15/04/2024 18:30, Florian Fainelli wrote:
>>
>>
>> On 4/13/2024 11:07 PM, Arınç ÜNAL via B4 Relay wrote:
>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>
>>> Read the PHY address the switch listens on from the reg property of the
>>> switch node on the device tree. This change brings support for MT7530
>>> switches on boards with such bootstrapping configuration where the 
>>> switch
>>> listens on a different PHY address than the hardcoded PHY address on the
>>> driver, 31.
>>>
>>> As described on the "MT7621 Programming Guide v0.4" document, the MT7530
>>> switch and its PHYs can be configured to listen on the range of 7-12,
>>> 15-20, 23-28, and 31 and 0-4 PHY addresses.
>>>
>>> There are operations where the switch PHY registers are used. For the 
>>> PHY
>>> address of the control PHY, transform the MT753X_CTRL_PHY_ADDR constant
>>> into a macro and use it. The PHY address for the control PHY is 0 
>>> when the
>>> switch listens on 31. In any other case, it is one greater than the PHY
>>> address the switch listens on.
>>>
>>> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
>>> Tested-by: Daniel Golle <daniel@makrotopia.org>
>>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> I would go a step further and name phy_addr switch_mdio_addr, or 
>> something along those lines to clearly denote this is not a per-port 
>> PHY address neither a proper PHY device, but we've already had a 
>> similar discussion before about spelling this out clearly as a "pseudo 
>> PHY"....
> 
> I am fine with calling the switch operating on an MDIO bus a psuedo-PHY.
> But I don't believe this grants making up names on our own instead of using
> the name described in IEEE Std 802.3-2022. The switch listens on a PHY
> address on the MDIO bus. 

The switch listens at a particular address on the MDIO bus, that is the 
key thing. Whether the addressable device happens to be an 
Ethernet/SATA/PCIe/USB PHY, an accelerometer, a light switch or an 
Ethernet switch does not matter as long as it is addressable over clause 
22 and/or 45. For all that matters the switch's MDIO interface is not a 
PHY, otherwise its registers 0-15 would be abiding by the IEEE 
802.3-2022 standard, and that is not the case.

> The description for the phy_addr member of the
> mt753x_info structure clearly explains that so I don't see a reason to
> change the variable name.

IMHO it is clearer to use mdiodev->addr through and through, the 
shorthand is not necessary and does not save that many characters to 
type in the first place. Saving a mdiodev pointer into mt7530_priv and 
accessing priv->mdiodev->addr would be 18 characters to type versus 14 
with priv->phy_addr.

Anyway.
-- 
Florian


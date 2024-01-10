Return-Path: <linux-kernel+bounces-22225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8A829B21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669911F255E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472E48CD2;
	Wed, 10 Jan 2024 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MFyST6Py"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99525487A5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so12412245e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704892822; x=1705497622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCkcD8LjRksDas2PtB8JO47e3MMJedookR84ZvoZyac=;
        b=MFyST6Py6D6ev3dlzQ1fiUFvB93vMMhbBXy1A20u1nMLJfRRFBqB06UduA88eZLsnr
         2+2cufqDBFdWANXQP1eMhTAogXwOGy+MUztrqAoat1JOeX9XyfWAMONtIkob1YEg/Mac
         4AeLI8g1oJMPAG2dauT8yfLa3OKKss5pzao35u2OJ2HnsqSLlHt/BzOcUOCiAH2TJY66
         o+CiB6SVQ//HIvvO70oJrII65qBpGS1odPvuTq/5OEzbmiBX9/AyN1SQ3XfSYrkN2fcS
         ee35NVeC+lZi2aNFDQZGFz12R3PqUnNvH6zI3LjRCndukKMx868w5MlLy3rqBiIV68ub
         Vofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892822; x=1705497622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCkcD8LjRksDas2PtB8JO47e3MMJedookR84ZvoZyac=;
        b=vGOQovYf+e1JN6cRun6zZcSaL2kEE3a3ThYskOcg/P98VbVcW2JW+uXNMQHB7M751M
         vQihUzEUQkr5xICthDv0YUaXnRjpOKZNw6Xgv1YjbNTBL24A6pIGaaJjRFSRR0NqJyNF
         CFMOqRLKwTPeOljy9JBrxDmpGb/c3DTrqKh6/6zu0DXODmw62Gx2PDAZpNDywrrZam/G
         RhgdhECzTw6SSjsyqm1X4Q/1u4aQBc9Jx0d3wKzcDG4sVpZCz5V2TIh2thtx1v3opRp/
         cukr6KUD9azRN/tSj6xZ6IbHmoxVb7NRan5kVtvd5obn+XU+leAKAiFY3S8qo/SxoV6y
         +7/w==
X-Gm-Message-State: AOJu0Yx6umWkTgjW3bmTO3Rc2yn8r4hXeSn7A//iDA0SQlokRHUPkNK8
	no/yt8fIxJwIDv1mkb5TZt7/tsZk18OQmQ==
X-Google-Smtp-Source: AGHT+IEUPnL34ET99Hj/hIbknkQ8fEWGM+WKPwQzx8/5fT7oXahWMojBXFdXXo1XxGp6qARdTIUlJw==
X-Received: by 2002:a05:600c:5014:b0:40d:91b9:436b with SMTP id n20-20020a05600c501400b0040d91b9436bmr611598wmr.183.1704892821813;
        Wed, 10 Jan 2024 05:20:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b0040d62f97e3csm2200114wmq.10.2024.01.10.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:20:21 -0800 (PST)
Message-ID: <c0b5ca41-c145-4adc-86c0-067e5043523b@tuxon.dev>
Date: Wed, 10 Jan 2024 15:20:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, yuiko.oshino@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZZfPOky2p/ZJMKCQ@shell.armlinux.org.uk>
 <a2651f98-b598-4a05-9e05-d2912eeb55d2@lunn.ch>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <a2651f98-b598-4a05-9e05-d2912eeb55d2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Andrew, Russell,

On 05.01.2024 16:36, Andrew Lunn wrote:
> On Fri, Jan 05, 2024 at 09:43:22AM +0000, Russell King (Oracle) wrote:
>> On Fri, Jan 05, 2024 at 10:52:42AM +0200, Claudiu wrote:
>>> The order of PHY-related operations in ravb_open() is as follows:
>>> ravb_open() ->
>>>   ravb_phy_start() ->
>>>     ravb_phy_init() ->
>>>       of_phy_connect() ->
>>>         phy_connect_direct() ->
>>> 	  phy_attach_direct() ->
>>> 	    phy_init_hw() ->
>>> 	      phydev->drv->soft_reset()
>>> 	      phydev->drv->config_init()
>>> 	      phydev->drv->config_intr()
>>> 	    phy_resume()
>>> 	      kszphy_resume()
>>>
>>> The order of PHY-related operations in ravb_close is as follows:
>>> ravb_close() ->
>>>   phy_stop() ->
>>>     phy_suspend() ->
>>>       kszphy_suspend() ->
>>>         genphy_suspend()
>>> 	  // set BMCR_PDOWN bit in MII_BMCR
>>
>> Andrew,
>>
>> This looks wrong to me - shouldn't we be resuming the PHY before
>> attempting to configure it?
> 
> Hummm. The opposite of phy_stop() is phy_start(). So it would be the
> logical order to perform the resume as the first action of
> phy_start(), not phy_attach_direct().
> 
> In phy_connect_direct(), we don't need the PHY to be operational
> yet. That happens with phy_start().
> 
> The standard says:
> 
>   22.2.4.1.5 Power down
> 
>   The PHY may be placed in a low-power consumption state by setting
>   bit 0.11 to a logic one. Clearing bit 0.11 to zero allows normal
>   operation. The specific behavior of a PHY in the power-down state is
>   implementation specific. While in the power-down state, the PHY
>   shall respond to management transactions.
> 
> So i would say this PHY is broken, its not responding to all
> management transactions. So in that respect, Claudiu fix is correct.
> 
> But i also somewhat agree with you, this looks wrong, but in a
> different way to how you see it. However, moving the phy_resume() to
> phy_start() seems a bit risky. So i'm not sure we should actually do
> that.

It's not clear to me if you both agree with this fix. Could you please let
me know?

Thank you,
Claudiu Beznea

> 
> 	Andrew


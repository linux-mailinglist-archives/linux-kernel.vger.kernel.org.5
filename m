Return-Path: <linux-kernel+bounces-129780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625F896FD9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2911F2201E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4A148304;
	Wed,  3 Apr 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX277Qky"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BE147C8C;
	Wed,  3 Apr 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149540; cv=none; b=XMzFfUWxuobmmyJxsleTxcCF36Svq1KBO1s/z0aU5XonHI25Tb8uS8Mydzsb9J/dA0GUdzRN2Y0CegS67qM1wZz6QObcJpcYwKNKXhl1v7kg3kFW69aP2ghF/EaqhAESjOR6jfVZ7/rR7X2CfNz3Jb3HnQYSjalzTxX9aNZQ8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149540; c=relaxed/simple;
	bh=wQNcHiU2egNcf6hBq6VHiTIlV1Qd3a+Jtkh3eSehbdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuCVSeQvITJ9NcREXKQt93zLMGTshwe7nE6P6oOANLncgw+ByaJp3jhEzFqZMxyH/fHr6OYlhHdGW2Dof5lCC4c+EfwgqbpUAor2Yx1FOp6Yh7vrzYvHB2U2AAj0DoqpyzDI+7cPPnq2jIU+c6Kma2gyz4DmTlPYlgVxNyhVpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OX277Qky; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6992d41de57so730566d6.3;
        Wed, 03 Apr 2024 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149538; x=1712754338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3E/5ZKiFCYtAT6YThoONU0/wlO4idhhu4OUR1dvPZWI=;
        b=OX277Qky9PHiYqjYyuZgKK9bzNeufsnXwSpymo10b6XxNujD7AaDwkRif77OP/VxDh
         rFewF3XOyyVtGiJ0SbjaPf8y/CpC7jZ35cU5shaEO8YBtfqv9LslX6NklMBEiSGwJ/CV
         4TcvULHe5w6hfuqXQyJnjXbRNXQj7Rl6QRz2C972SiG7hO2m6mCDF4mXfUf18Irv0mVO
         vTjKTRPG73bx6trgkss89hoqp67062QnaNJmvEVYxmW7Avg0T7mLT0U9t4VhZJj/9Zss
         ut+CPXrQnrHReRRZhpwAB0ZwAvnlpIjDE/7JmgAhaKJ0q/jlPPafcQF2YjFcjqaqUZNL
         9wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149538; x=1712754338;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E/5ZKiFCYtAT6YThoONU0/wlO4idhhu4OUR1dvPZWI=;
        b=Hz+ALWN/AEh7aebHfywJYyjXEqLHT88ilC+VzTUghoKC5Jct9yeU0piK7jK5Fk7fAG
         kuerz2FFcd/575XNAHN+2h/Bsux1amz9lFuk52SwBWCGBLAGmilYuO/9OSoe8qQeAe2G
         lqWngKEi2OVrzgtQsQy+E9Ta3ZsgWLD8ZM2kWP/IVW9rfgwMuqLZ0AUFVKXeqINfsjGs
         3NvzqhamJtlNS8U+fT0+nQ//O15Ckf2tEtShd4uzo9yapdZiKWRQ2AZdR9WVy/X+nmcF
         ViStZoKW/oGhZIzYbNYju3TYfZFoWnMx5/SCxyCX5n4efDq/cZTGfhXKCwUYH8JH//pb
         AuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ItKh2W3HhLAx1IhK16eD+LXLT1ZATgI4Ahb3ETJGExo9PjG4tPrA8X/q7Y4ceAG7BvyvkgwzROhpG3CGcatq/tZhMrFiIykSOiuu28aPK9ljo1MfDMNWv685v5msKty2hYRw
X-Gm-Message-State: AOJu0YxrYmhQ05WiHI9wCoP4dmvRP0PF75lGpyIkx9tvZYxsS/4hlk/3
	X3cSOSdxuLJT4zCaA9nMY7G0dbMW3tnUdxlhcPEh/m8dtrmIWLnB
X-Google-Smtp-Source: AGHT+IEoNF5/Z/Ai9ZoDxOliZjp+T9YvlFfdguVZ9qSKBVONmO0sn2K9lOiVhVkZrheX1w0JgSTOBg==
X-Received: by 2002:a05:6214:400b:b0:699:2d9b:214f with SMTP id kd11-20020a056214400b00b006992d9b214fmr201464qvb.63.1712149538193;
        Wed, 03 Apr 2024 06:05:38 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id kc21-20020a056214411500b00698fccd2e02sm4255923qvb.43.2024.04.03.06.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:05:37 -0700 (PDT)
Message-ID: <29163687-5e76-4231-b551-46c584e5629b@gmail.com>
Date: Wed, 3 Apr 2024 06:05:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/9] net: dsa: add support for DCB get/set
 apptrust configuration
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>
References: <20240403092905.2107522-1-o.rempel@pengutronix.de>
 <20240403092905.2107522-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403092905.2107522-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 2:28 AM, Oleksij Rempel wrote:
> Add DCB support to get/set trust configuration for different packet
> priority information sources. Some switch allow to choice different
> source of packet priority classification. For example on KSZ switches it
> is possible to configure VLAN PCP and/or DSCP sources.

s/to choice/to chose/

or s/to choice/the choice/

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

With that fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


Return-Path: <linux-kernel+bounces-57254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EF84D5BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5DE1F2261D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DEA1CD25;
	Wed,  7 Feb 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUvP5LaQ"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD93149DE1;
	Wed,  7 Feb 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344497; cv=none; b=h723pXzDbyZU7ORwgVZJP4TYnHl6qGL6DpjrEwEbUs6VxeVDM2l6p8HqiYS1RfiTTkxLh5gITMzRg2eMFcnlGZHYfpPGJ2bgBQapLc/1XUBOKqtoaugK9m6RoSL5bC6r/cKzo3J8+L49oAbD8qvqvL6hdN3cjer+oZ/iZd1ueq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344497; c=relaxed/simple;
	bh=7Yu3npk101DAnDKrjGerLcOuTAsg7Rx/yrW5tAqMvRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJTK5drLygvKQJiLu/YpvvPgAuQmk92nQBzwDk+a03kPbcghb/RGQLMTD9byVh1x5Hp42HSeQyebEpx0TvXdQYDTOtJkHer6y8D5VzhlEeviwd/Uc1Y/x+/srXI1gL5+1lmcP+l654oSfKixV982bxN/W/+wQaJqugHNUdP/pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUvP5LaQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59cb1e24e91so451779eaf.0;
        Wed, 07 Feb 2024 14:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707344494; x=1707949294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhWhKt4UvQfn+hHPuSvATyjnFTI4urLTAt1CdH1oJcU=;
        b=gUvP5LaQAR/QQeM07X47VZyfcWFWs1sQ0aSU6hwC8pqX/ZK//5jQVJ0eXT/9cBbiSk
         NnBGzERruwfexriWUjlCcVoJ19p3a4C6icqUjpFVcMEkhRQ18h4sCPavNbwDqF8D8cKe
         ktzgkg2h09F9Chci4mYodf+QcBpZ0pVQDX8zup6y5TVV5GFVZS9iqLFJ0anYzQKJvXGY
         b8iB47kNQeNw1EeloEF7fUsAXNEP0JMHFlNvGdL1hmSJG49NN7vvl620q3CvIXJfCx3h
         8A/QUvRoERxbnv17J7tFyH5lljkVoERabjPE0FDehmZZlHlDPjNz7ddgKpNEL87fLIOs
         4fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707344494; x=1707949294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhWhKt4UvQfn+hHPuSvATyjnFTI4urLTAt1CdH1oJcU=;
        b=iNoHzZuqT19bEVT5elZjJJJKB1XMw61oaJH/+g5UYYV1VbZwRm/qwfl9QGf/8o/rTl
         btsmDAha8KJD/6tVXC6sMo81PSlgvR4F3h56jTFGavo/X71Uwpauito1bW64LskYSXiE
         eM7/X0/RHet/qiQnrC5VmiRW2Hx/ILnhk6rWZoIN5a0856/TJ6kNXZvlzUH5YjQrvEh2
         xfFFTByslsH/+7fTzeD/MELsrXgoMjkyahgFYPRThCP6lXumdWKsb4jAhwtcXg0VZlZM
         /0C3qeuIc1G+JznfSAV1JY+373Eylzq4oKgyan3zRU3USA4LxhQE33hHjt2hRBm8Sd7B
         W0WQ==
X-Gm-Message-State: AOJu0YxaJTbRs0l0XTB8wqPFfVMEfcx0n/s8tSaGwqHoLszjBrQ2YFQv
	WbZPLxXVj3OEdbxj8IxMtfWxCj8niBarksQOgCiqVF1LCTJAR41b
X-Google-Smtp-Source: AGHT+IGVNXLYiyp+WCoCDCWY1EWAEdG9n+N7bi8javw/3HrS6Ymixm9xXAtE9BMeSAUW4jXcyS8pMA==
X-Received: by 2002:a05:6358:7e52:b0:176:a14c:544b with SMTP id p18-20020a0563587e5200b00176a14c544bmr3869949rwm.11.1707344482418;
        Wed, 07 Feb 2024 14:21:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQQYjxGLfIqvqukBD6sUihh1nEZkuPztmhEMUnBQu7drOwi73/6vxNxqcFoFOhYiZrlWoDcYML8yRoBGvBjacxACBDuivBu+Ze78WPqNOG5M5K7LysQBP9ushu0H3ZiLWkiPxt+kf71AUtLbrSGEF8ffIt+qOf+V77IzMBuP29aZdHptFzbHy2/MBN4B5u+OpFeW3X0VZ7py88tcddIsdnvgJn1KYsijRSwNrZbttZBEAJCTkacvpbXrLPA6rjdxSg4qw+EqjcGQvZRcuyS1E=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a28-20020a637f1c000000b005dbf22d6e1asm2194524pgd.56.2024.02.07.14.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 14:21:20 -0800 (PST)
Message-ID: <4c62b202-c2af-400d-bb3c-92d33317620e@gmail.com>
Date: Wed, 7 Feb 2024 14:21:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 9/9] net: fill in MODULE_DESCRIPTION()s for
 dsa_loop_bdinfo
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org
References: <20240207101929.484681-1-leitao@debian.org>
 <20240207101929.484681-10-leitao@debian.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240207101929.484681-10-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 02:19, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the DSA loopback fixed PHY module.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/dsa/dsa_loop_bdinfo.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/dsa_loop_bdinfo.c b/drivers/net/dsa/dsa_loop_bdinfo.c
> index 237066d30704..fd412ae4e84b 100644
> --- a/drivers/net/dsa/dsa_loop_bdinfo.c
> +++ b/drivers/net/dsa/dsa_loop_bdinfo.c
> @@ -32,4 +32,5 @@ static int __init dsa_loop_bdinfo_init(void)
>   }
>   arch_initcall(dsa_loop_bdinfo_init)
>   
> +MODULE_DESCRIPTION("DSA loopback fixed PHY library");

Should be:

DSA mock-up switch driver

>   MODULE_LICENSE("GPL");

-- 
Florian



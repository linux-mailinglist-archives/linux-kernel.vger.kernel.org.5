Return-Path: <linux-kernel+bounces-129769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C388896FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE8EB21BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710F147C79;
	Wed,  3 Apr 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKRfJhe1"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C713775D;
	Wed,  3 Apr 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149274; cv=none; b=JYpORdLkedIIylINSt25sVtJ518RiJjq71vPQXUAsja3oQaSikvCVPcFY4tmamvHgwvo8tj6OizGpuTHqDSx7tE8kfAOFnS/bHGyDTk2ls+KB7eF6Pr9OkeGGOyXcdgnR+QAiRKh5f2Emcw1RzMRs7OTjcSKnCIlWvvUEyUkJHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149274; c=relaxed/simple;
	bh=8Z1z87IVRGvIDJ30z9anQbPjQE110ZtgTUm3EEesock=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hl4uVKFS9XWBzE+JBXh57rxEw82+xf5gR1Om+OYJrK2my0pLoUp+pEy5fFej04mL5jHxtSK8oqfqGK0hTRJfLZ5rC/ks4oMgC5T6P5RMfFtn283Pdtx4SpkhodZ1CQUd0AFIJLwCLRgxE0mq0RyIB4+m52UWvVzZPy2b6qLqmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKRfJhe1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78bd8068b0fso263565585a.1;
        Wed, 03 Apr 2024 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149271; x=1712754071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W221BqTBStZAoR2FwMzuQj2RcNq4bopCNAqXl896PoQ=;
        b=RKRfJhe1y2bsxwUaVrKEdE1o2x+yzCm0OdNfy1SorupkhM6fQkecV8+fV26wG5sP9b
         K1EYk0pLya3VQuYpQddOOg1asERrU9AQrtAia4I04hWRWZGNCR09VEeL7G6iPQtVSa+A
         DbFZO1Ke2UWdPR3EhLayO1BHDElvn44m+PQkZ5xmyN/EnqfAMDjPC+mHdvxAfZPjgP+I
         /G+tGDUo76aTED0wctYFyLnGrLDze9k02WMfDNx/5oPdZ7h1+Zf8CqvjyZQ90y9ptyvo
         7w9E8rsas/GE7JfofW2GgvvTLKtKnzLtzGQWNypvP6Wea81S1YbhVMrOFOnz3nf83qLp
         70tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149271; x=1712754071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W221BqTBStZAoR2FwMzuQj2RcNq4bopCNAqXl896PoQ=;
        b=isVi8p/HZoT5954y6fIjOPxYI5yGshy7X5SiAuzkJqwp4V8VumYki6Jq42ymjxPBgC
         tu9bVz+T4Xf4eyzaLZKCBXsiIviH2H1zjI28qHA0QPslVLzZ8d0N0x0Cuh8jaCQs1YOb
         uA2dietNl3K+LcfDRm86h+/vMoyjiqAkPxGXixMn6Yv3EXOIA+tz+x1LcO5jylgeQkex
         bDcVZ4o7Ff8YIpVaUjHvjM+aZlrnTMo97keEUvbiHPVHo2dF77lzR4E+DXtSJGk1j7Nf
         fK+gBhb58tx0riL8zlDIRT8Wc6PO2Jx7XXiIVLOGAGeziueAKq/5izd5F+mEbpgFpoSF
         jqyA==
X-Forwarded-Encrypted: i=1; AJvYcCUODIGcpjl9OHEYNgmV3LlS77j9kdUFln2CUWpR3z1mqMBS2Z+tQ9pXxTvrNMr6MclKhm7A/k/ZLkSoqMpdsyiG+oNlSHMdOd5vFeWtBZszBVfUTBY0o7vjBG1IgThQKmyyIWxs
X-Gm-Message-State: AOJu0YwT6wYbn0uttMAYvJfLwbzY6WC9X/OW7he/ah/M7Xl432W3slUl
	rwGWBDxQaIYyx/Rtl3SS6DBut4uubuNBhnLYP5Y+pzZbfStfl8fI
X-Google-Smtp-Source: AGHT+IFKmAEEvxWNvqXp0HmbV38s+1XnpGrLGnK3aEE6/Z/G5TawRmD/kP/3ju9mDQV0DjpVPL7a4g==
X-Received: by 2002:a05:620a:462b:b0:78b:e84f:3dd1 with SMTP id br43-20020a05620a462b00b0078be84f3dd1mr8740243qkb.32.1712149271236;
        Wed, 03 Apr 2024 06:01:11 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a090400b0078be9e0f9adsm1781156qkv.43.2024.04.03.06.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:01:10 -0700 (PDT)
Message-ID: <bcdf90f6-b757-46ba-98bf-6380f738a20d@gmail.com>
Date: Wed, 3 Apr 2024 06:01:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] net: dsa: microchip: Make
 ksz8_r_dyn_mac_table() static
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
 <20240403125039.3414824-3-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403125039.3414824-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> ksz8_r_dyn_mac_table() is not used outside the source file. Make it
> static.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


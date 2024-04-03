Return-Path: <linux-kernel+bounces-129775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB03896FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322971F234F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD01474D2;
	Wed,  3 Apr 2024 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dta/X+iN"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0C146D41;
	Wed,  3 Apr 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149429; cv=none; b=TMicV7+PJcwtWkx76WYV2IOTbJSfxxRFHha5vfc/FXz+nqQWP3SPBBUkpL8uKMqLEdS4JAtU+YWgHYewnFOnQBeE8jocyOLnBhRyNnEkd0gZ8A0WIvVcB/ZlnbKamnDM2wgHbBgKQonM5WJ3VFkphWGGfZ+tB5YmLL0/sFCdLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149429; c=relaxed/simple;
	bh=sXBfqvDACL095C8gyRGW8pO+drlNkVJ9CcylK2BYrPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3L1Z9HmrciaA+LeVNVGgQaxplj7MAf8ZA8QAASBhjkkSWXzYs5O8cNv4galGgzMo1E05Iwvi+5rq1XfnSma7OpG4NhNHnDR4dREBk0cjGIZBesvDN4zJHyMUjcYIN/N4lTPHIyXemQ8toLEGyvMLzlbhNAH16tP5BtdsTuDc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dta/X+iN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e296c7aa7cso4138995ad.1;
        Wed, 03 Apr 2024 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149428; x=1712754228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eMyTeEwaMwnypDyzDBWbwalG+SemBZ7Bz8fWlQzlJtI=;
        b=Dta/X+iNFEY5tm2FZCHZip8vw7hV+L/vRcKMHIwPMpDTbUP18TVdVJwlmM0yPS76ov
         rmq8Xc47vqk5G/EIvVBublTC87imGfGGTp7CzivWMsEtIK3Y263Dac8rbPcb7BtdzOIA
         4lB8z2j6nUejdROp+Tksive3r4gVXxnLgoOtz74fzmZF7V3I3pNSh3H8jtoqC6ES4eEE
         qVeAvhK4aiCZlGq1jzMd1yFbfmlxQJR2Jk6EsBYu06LcmkF1rdLtcyVpbAilSCEUBRHc
         EQmPoVybl7xpeml4u+OMuqu/km8P0DhJ6LRX0mQkVYxJnUBuIR9BqbPdgTvzs6sgDyqM
         fG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149428; x=1712754228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMyTeEwaMwnypDyzDBWbwalG+SemBZ7Bz8fWlQzlJtI=;
        b=aDdeg/yThn5KceJpLeTtnSuGBdfSm2OK2CdKauijG/x8CWDKCqGSbj0CcExyq1jIvl
         zuYHF6yLdk2aumjV9x8+yzW5qVYLNd+3PF8MT+8yDYmMuoj3PL5Z4GIutUBM7OBunDAP
         awc7TgzcTg0Ppjuv9w9AhklUhM484HGsjP0lLft4knEOLm52L+Y1ys9IRq8jFUl+C8C6
         t1ybtGYVZakCHqb7g+UlvdscZkXCwsI/cDe827iVMDruWq/iaHsFXb4eprYB5hhOOIj6
         YRV+Ex96LteLojfJ9XCcrm4QN/u3SKe4QDUJJ4PUpKOHXmDZPFXuX8XLd9HzkApQXgYB
         Ek3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBJwZBFdqmU9tPZhfEKmy/Kpbhz9m7RBmRxwwywA/6nBHjVpoZ863E5we+rEZCE/S+62yRzIDWKL1mdaF4tplw8UErxl/6tDCHgc1+djZbVAVc8Bl7/Fc7lVA8K1vf399x42ZQ
X-Gm-Message-State: AOJu0YydRoYBR1q3UDubph6c9YaGJ7YH33szLSbzIi0tEGJ5dcwXtD9O
	1jJN7UHlH6O17WG4v3Tbwd5LFkoYelqXyJVU36UbV+LcTOK0/XFc
X-Google-Smtp-Source: AGHT+IH5x45+Q/exQ13MVFuJICWazG5LA3hGFUjXdmRz2s6EQUDBKwwOP43u8pXCpyjBRTRJEYaRoQ==
X-Received: by 2002:a17:903:2cd:b0:1e1:214:1b67 with SMTP id s13-20020a17090302cd00b001e102141b67mr20008041plk.37.1712149427516;
        Wed, 03 Apr 2024 06:03:47 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001e0bae4490fsm13177657plh.154.2024.04.03.06.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:03:46 -0700 (PDT)
Message-ID: <c2ad42b2-ca13-4473-834c-df4475ae268b@gmail.com>
Date: Wed, 3 Apr 2024 06:03:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): return read/write error if we got any
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
 <20240403125039.3414824-8-o.rempel@pengutronix.de>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240403125039.3414824-8-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> The read/write path may fail. So, return error if we got it.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


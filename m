Return-Path: <linux-kernel+bounces-93084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3349872AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F371F28978
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E94912D216;
	Tue,  5 Mar 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGA30tmM"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3D18EA2;
	Tue,  5 Mar 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680566; cv=none; b=DYHDakwSPopFxbEqyZTg0eR0TmwSeYJXIdCrFp2iD4P9Cm8rLjrP1IgEblvzIlDjy0L0y6qxGiV7a+386watLpB+3SysFpDEhzmRd+YZ9/cAKady4OZJgbj69KIPs8MBiVeNfM4Ffg9fmuAfLu1417N/O40FkxdCGLsr//PFvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680566; c=relaxed/simple;
	bh=BX5UCsZaZvEcwO0RAc1U9LDYaucwh9+d9GDoVskdcbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHkzpGykHBpB29S3K9J3i9GIb08bginIccfweuEHx+l/ucIiA9K7uxMfPLbrmazbh4SYwEqctAa5LBwleY4V5ahyDsnQXD7Me2QLz3wH0oumkYog3ssLtZM4jdfw5YGP/rf6yVwLrwwMgqywF+PMUHWmK6iEXgDRnLh6S61FiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGA30tmM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7882e8f99eeso121097385a.0;
        Tue, 05 Mar 2024 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709680564; x=1710285364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDoZ38kb+O9xSzSugryAPYQriNdo+srCEOEHpCuApdI=;
        b=BGA30tmMZZIcTxeXBF0zO/vxY/duBf9WgK4ZnEbP6qnjzP0aEJP1dWfQ0NL+7U+Yjh
         CXzmjlSGPqEfx0Qaq/J64NSyhrp2AJBnYECnJwWsiY5FvYkYRzDpR8Lj5bqoB8fh5EuC
         6P0poMzoxdo9Z+HLw0RXmrHQSrHcYDEQz/G6w1f/sgj8Y94TsqYdaQQ8iBm/F9su9doL
         A5P3GrNypazYAI4ZcW4DNDalQxUQFhNEXSiBGZrvDuBHsdr+zbCiAsCBgMhNL0cjOJ9S
         XnM6yQXyfE8+qsXZAiFZXbtuh2slnytrkZZYsxNiswD0ufjxBRsM2b/KcsYNL6diV944
         Zf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680564; x=1710285364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDoZ38kb+O9xSzSugryAPYQriNdo+srCEOEHpCuApdI=;
        b=MZv0FJPpo99K1ZyHHo3QC/KlU5/UAxcIxaWe6OSGtw4o9w3wkhscSfpYp5v4oE/KjX
         DOXRfFlwNft6bbs72oYrTqK+0M808IXN/vrUIo/pDacD40albrToSZUjvZqONjGeiEiC
         ERygibJnPHz85xzAKpttVGQlPVF7XoWO9GbN6X0l5lJs6Ie5fjuQQTuzv/g6gFxcY1Ol
         Ahb/7ewdnbFrku5NJ7+WLu+Scg59SYL96srv4sPSecnYECN6Cxl7mU0uRQCCd/qflTLY
         JlgZB+d40n3gOfvKA9kbhDKl96p2qkNmfFlk1X2H3NIrMvnTrIS96PwiYG0Yc4gUVo1E
         PlTw==
X-Forwarded-Encrypted: i=1; AJvYcCX+zpIz+r3hSLwsMrSWyf5kHKZRhr/QLAxB5iBBs8AtI7nBEeDUKR7kPU+3Erv7AF4lBlvdSUXses+ci6FyEylAGZDVEU5HbnRstCF13gg5mXLvsO5aSUVHYLzKVaCYvBtP6T+e
X-Gm-Message-State: AOJu0YwN5Z4FQBpuhZmUuAeVOemoyU09ZTge6f7jalYXWgRHfUSgoKP7
	DtzGnmWNZ5xhurGpu447o3+Qo4jxosl0o6Phx01rVKg01cU5/X9R
X-Google-Smtp-Source: AGHT+IG0Mcaxe5XMmScBT4TMCi5nhvOWwTmN0M7EOqg4bHc9fomkbwDqo6RjhqnT+KCIALEV+S0kLA==
X-Received: by 2002:a05:620a:1a0f:b0:788:1f41:1ead with SMTP id bk15-20020a05620a1a0f00b007881f411eadmr4180716qkb.31.1709680564034;
        Tue, 05 Mar 2024 15:16:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c24-20020ae9e218000000b00788349c0098sm1178824qkc.50.2024.03.05.15.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:16:02 -0800 (PST)
Message-ID: <bcc82364-df74-4de7-a242-0201431fea64@gmail.com>
Date: Tue, 5 Mar 2024 15:15:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/16] net: dsa: vsc73xx: convert to PHYLINK
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-3-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-3-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This patch replaces the adjust_link api with the phylink apis that provide
> equivalent functionality.
> 
> The remaining functionality from the adjust_link is now covered in the
> phylink_mac_link_* and phylink_mac_config.
> 
> Removes:
> .adjust_link
> Adds:
> .phylink_mac_config
> .phylink_mac_link_up
> .phylink_mac_link_down
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



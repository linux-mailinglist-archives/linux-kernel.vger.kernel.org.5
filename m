Return-Path: <linux-kernel+bounces-94701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E08743BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A3AB22CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74AE1CA88;
	Wed,  6 Mar 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENeW0deG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3011C6A4;
	Wed,  6 Mar 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767026; cv=none; b=fhLdY4j9NFWiMjD2qQF/0vBjXbui678BqEUJ1ZiAKdvg+9Hh6srbqZNC7QlWxkWILdCjSX+x4UNdzrq76ljekXODz9AhR/RtroNTwG68tpPZinr8MyrHjUXGVwXu06LOs4RpZC6onKXmVCQMO1605WEkv3qOG+tuCPRIbZcq0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767026; c=relaxed/simple;
	bh=yETlT/1t8oXxCw07RT5USNl10PGwaQN7JjFz5rqRjBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjar6MQlq9Ill2gd5AUTbfnGYFAfsGMo5dYUwILoLhFkNPb+vdpJGLwxKK1zir9GcPTC1sZEEPGRufTqZccx0iHnp8IwtHIjyu+GImYYzPbshpj1B+MbmaUNTUsRgyTNjZ/rmitn/2hkg5r+xhlT2podokkiaaYNzVU2heRxsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENeW0deG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso222068b3a.0;
        Wed, 06 Mar 2024 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709767024; x=1710371824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8qZFVmivw2qoLXeTcWzu8ocoxB3n/4z6PQlau97p1Q=;
        b=ENeW0deG2d5lu01eCBgJ3dcueTfTRHC81Q8jRhsV1pkyo9Gl5rCemVavJdaonWdb4P
         iQgAcrktPzea0A6cKvx4/zTb0aSemnsaXtFBzkc2ArdUpneNziRnNtOuHWdvNBsoLfLS
         uANExKmdogMGF/Fpdy4RKmdRKjmt6Rz+ZIlhmEkjLYPVgHlUU/eba3sAnDDSd5JtYIgK
         m4L60RvlXyVM0+cXS2yV7S5ZfWfhAqXnoEmUil2FsCT9tjyxnDzwFPyyIf70UVpzy1kW
         Gd2QINwlqhcfEpVt5/D2DbKgoB0D5N1EbBY2fLrTQY2sVq3tjxjjgsfoCAS+u3IRy08x
         CewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767024; x=1710371824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8qZFVmivw2qoLXeTcWzu8ocoxB3n/4z6PQlau97p1Q=;
        b=nM92WXBb0V6Id6039ILDQm4zaZTMR2SZHbEXe4cGsogjvWMeC/EMhIUpoH0Y2UDg2h
         S7UkxmxjOFaGvvdzZkKW85k5+7Dm3cOqtnRBUVVllEcRrtDhmaQP8+xbHzBNNfWXiIcA
         V6ircVybssp6v9WpslWGoAKp2anUGa2k4meMyhpQrO6bDf0m296zfrKOCbVIEjPE4Pyq
         LSbJ+84ey4xPf5XxE5MjT6VZiBNsVinKxKVCXyLEnc/YRqgCpGujX9MA+mBrOJeLKI61
         9CBqYpJOnD5PUTBb3LBQ8RCD6aHU27cyCAm2buq9KnIbtjPE0LB7ZO3c9dqFPPNpORGi
         9/0A==
X-Forwarded-Encrypted: i=1; AJvYcCW5BYSSrxnP4hfY044cegDOAq+1Ab7a2owD1x53pVFmw6F0+m7nYTOLbLHHByxYV7NifTNfzRF8cgxcIXhnlUZobD3pny1ezx7rpCWWgVFG2q+6nRga98E5VvOG0DhLzm0WxaaH
X-Gm-Message-State: AOJu0YwNxFteTt5aO+ikczBdRInujajTnGPp/JHs5XYamheoTmZa8jVx
	6fq/1u4N+jEQQEC1hmcC4MRnNU2865qosXvFh9u9Ho7gwIqRLAnw
X-Google-Smtp-Source: AGHT+IGz1RtSKKjdv1Gd3H/wFiBP6CjCVtfu7R9kgKZxVDtzqP+oR8ruAJXwyLm5uBDpImEbFjidUA==
X-Received: by 2002:a05:6a20:2590:b0:1a1:6dea:4fb7 with SMTP id k16-20020a056a20259000b001a16dea4fb7mr925667pzd.29.1709767023722;
        Wed, 06 Mar 2024 15:17:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gd10-20020a17090b0fca00b0029b22d8f5b4sm267293pjb.15.2024.03.06.15.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:17:03 -0800 (PST)
Message-ID: <3c5dd644-2e9e-4961-9642-c06167c07e31@gmail.com>
Date: Wed, 6 Mar 2024 15:16:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 15/16] net: dsa: vsc73xx: Add bridge support
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240301221641.159542-1-paweldembicki@gmail.com>
 <20240301221641.159542-16-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-16-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This patch adds bridge support for vsc73xx driver.
> It introduce two functions for port_bridge_join and
> vsc73xx_port_bridge_leave handling.
> 
> Those functions implement forwarding adjust and use
> dsa_tag_8021q_bridge_* api for adjust VLAN configuration.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



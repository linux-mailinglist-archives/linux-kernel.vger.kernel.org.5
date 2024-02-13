Return-Path: <linux-kernel+bounces-64529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E5853FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E216F28B9C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9E63100;
	Tue, 13 Feb 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnwuX9i4"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BE63105;
	Tue, 13 Feb 2024 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866411; cv=none; b=tdlE3ApMXEdaNyvK9C2yw+XPZBRWO+EgR8pzr311vxyk2Ct0jxNzcuzPCloNkB89cin8hpUSAdf8xuOKDyVOyKunCb7zWi8/Pif1u1V0sJsH7mlIKwmhnEbXw2WmulYsgAe1qlEgZ+N35kVIHwR4OSjphhfdZ0bHG6P5jJqjaNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866411; c=relaxed/simple;
	bh=lVasOFV91XdORO8tYirbAEjYaa3R9b8EFS1C9iGFr5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1MOCGZD1Wkk8WoW7BQak0YwycMBmhlx+SLQPlZAv09w2dsvgKwj3K+3i0pgpFthKKX+e6RU7RyLXj9T9emzIGL9uQQXY4aasJJDruX1yb5cX+4mgz+HX6y275TbgR63EqgiHorDiPXsHhQ2b/jDojRWLha+9iwQJlC/F0XCei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnwuX9i4; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7ce55932330so1963662241.0;
        Tue, 13 Feb 2024 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866409; x=1708471209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW8ta1jpGQzaTVE3VumU3AWg6Fo43iG93quimfUZbHY=;
        b=FnwuX9i49YwQ4ClTTyjgsOztbabb+bBfzwm0RVATV/U9e6SoKbVzVPEV9zFGBAgvFL
         ih892ZtabKnoQLSOPTOCsIyLY2QRfPt/kn0OIXcpTDNyUSQdYP9PHX5YW/Gxz6UqOT9k
         Xv8W/ZfCyQE8tNmkoRAROLWAjYDVyERpXZB2AC2UK5lS5Q3uLvoR95lXYDcz5fg0T3HU
         YihtQD3i7DPQ+Xk9mppml4H4q1V7QAvTjr+gfbQkaSuEWbaFx7FR3dYzePqAMofoA6vS
         KNzXBKFbI67UHbwGJiTvRUvXv+D1CNErdQMyhz0/zFhMhNj0fCx+WXgx5YxnuVxWJL44
         sqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866409; x=1708471209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jW8ta1jpGQzaTVE3VumU3AWg6Fo43iG93quimfUZbHY=;
        b=IARF2etDYfk2pYftLd9rfKJ7TN9PWz9euY/h5n+ck8doptOuMvx4rP1V/IvBXiYZZU
         ISmgoH/6U7SK0SRSTPxddiwJxPhvY2+s2IQdK7Ihb5KHaHofGw1olar1Y2zahlZTFMfZ
         aC5hA5lSWp8zRYwgfmJVaJ9zwt7R6RZZZN11KWY0xIoReX7iF+syH3uzEpAI0M1/Bp4x
         ovWO/iYPXrTExsUFXwgFgp0KJIvsCBDrnMNy3tP6fYHFoT23QjBcn0Txs3uJCABOz0i3
         FwDIDEibg1UkXseX2jPINBwMqn11p/KfWmDND/u32BC2gbRtiXo2/HdqugZbjcnjH+xM
         Ahpg==
X-Forwarded-Encrypted: i=1; AJvYcCWo8fiOV7VjWCh/b2Xt52w1LHBd8jsu7XgfOhTMQ3jq/Ree80vG76ZX1oP0IA4swHyOW1l7eeU03lDikytrJCT472REfaKuK4SCHiazs5DY13ck2+RY3oG36NLQwGNFv5Uxgw8e
X-Gm-Message-State: AOJu0YzWqYv9RVswknNKQtLt8JJL4EGZcDYaFTE9nMn6HCmuVYij9tJl
	EgS+yvAPHkOEX7bOM5M3f0say9tK1f41St6yjedgG2zdA4ExKWu5
X-Google-Smtp-Source: AGHT+IFL5wfdx+vmghI77jxkApO/dY3BiXrQ+V+bdtCgaEvBU5eUelMLoPMae1QQlU9YNbTNdcBRoA==
X-Received: by 2002:a05:6102:114c:b0:46e:c898:310d with SMTP id j12-20020a056102114c00b0046ec898310dmr891739vsg.21.1707866409147;
        Tue, 13 Feb 2024 15:20:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcQdQEm82pkM9WCor6Uq1bMSfSPDmWCZouaIjSYFJxfpDcuVicXASbU/S/YuP/4dc4QIlKFXa+hIcHifi7ONNVusj3ojVpX20O9QVE9/IX4osgpLfiP9mysZLqjWoWZm6O/EpK5ozNdqaaWTp9ATuNNHfkho8TDbzjV6RyOBH+KsUMBesHY0TzgJfgG3qV6mTT1wka5UYDDOyV1rq1XaCdWR+XHaXKm2z9NYx9iYn25PhEqXJ9mSl1zCJC+YuU24I2UyGr11FXje/CX2o+o3qbLD6C8GGkRaPeSEqOizkA2vkD91ggOpQ1ZGzmwEG0rbaODbpjDEwf5qWbO2TUHApRWhuU8GNGuAm82JeH6IiKpBliQY9/a7BU15g96o2BmcqDxSfGdaICe4Gl7hXQjtb0psvGuz6Vc6HiYuF4/3tke1k=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bp42-20020a05622a1baa00b0042c65d05e17sm1513620qtb.21.2024.02.13.15.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:20:08 -0800 (PST)
Message-ID: <887cdd8c-db49-4257-b5b9-cd9a812b5d37@gmail.com>
Date: Tue, 13 Feb 2024 15:20:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 04/15] net: dsa: vsc73xx: Add define for max
 num of ports
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-5-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-5-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
> 
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



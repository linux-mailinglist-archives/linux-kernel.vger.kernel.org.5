Return-Path: <linux-kernel+bounces-69197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B905985859A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6071F2469A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01A137C52;
	Fri, 16 Feb 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY6xZyo5"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFF13665E;
	Fri, 16 Feb 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109024; cv=none; b=pLKLsDx6OCI5QlS0Ua1qSwbsU2snZlEIiBpSLnVxZHEU/Xm0oxBszfUNiICq583a5VtCFfIqSdPmDibWVtcGa7eOlfSa/yR3ywU8mQ2qP3wKUDY3gfH9zuN1/esvQCZQpIYZXTJL2HJ2SWHg+yjA+Y9k4cQznaqeJJKwT/4jSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109024; c=relaxed/simple;
	bh=4+fih0GwYnqoqJELcbBRA7XcIDiy2701RAANwmbU3Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l646NkVfUVEk6M3EsUd0zWCCwiHJjMPnh2hAGyD6c7IgpokEROqKt59p5IWmI2gFVPMMm5CkCdVyVzcj3JYb4rUgI3naU4oyhZNsqAY/CNOabq0NGB9BVS2NAueE/r8cacn4iAC0BiARtbNYhorUJfA87xCSYwR0lyQTUzC4EhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY6xZyo5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbb47852cdso5405085ad.1;
        Fri, 16 Feb 2024 10:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109022; x=1708713822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMxJ3PeyrtjAzp1djsTzQvQIRNx6ZEo1xGYxjB3KLLo=;
        b=EY6xZyo5eCLLQTBh8P+d7hwMFUwjoB2eUQRPqzPaiMKReucJtJLrPXdgGotzTK+T4T
         Ysfy7i27XTiICStYKpSP9fa3S+lFYPfZ+o5FVMjKQqgLCZHrzZ9szmzjbvqqOZfEcXFo
         hkaxCPXhcG11jeqtXGAP6qRa7U/yTv76NE5/F9rA88sZHzSk0w4TE3GA/iKMAlNylOK6
         /bZtVG3nN3cu1bwzhZnvRRGu1QXL5XSZMiZgYQ8PbpkNMY1uhS+mFzEH+HuvlS0irXVo
         dYXywHICmEb+0lmuTQRjpUK+oMc9mUE/1uC5dnYoffBOww55NHWkvCU6X7rccmGMxLH7
         grwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109022; x=1708713822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxJ3PeyrtjAzp1djsTzQvQIRNx6ZEo1xGYxjB3KLLo=;
        b=ud1H/Y7LEZBH2hFfcaLkNJOOAiuaaWG2VOqZVbWWs7TcEuHI/qlhL1xHkrNyJukcVL
         pf6W6MvhAzXKrA9sXtCrVJ7JqR60rFLBESgyOYLO6QzILI9pQ53pCGsBujM3MGd2ReVK
         Ow2mPA+7PTqQYHhgK/PQMA1kUfUGhXodW+59Lhpq9obVsP/l7pb9snj2RwvvtgRVbbDL
         ERYZjxnRL2ZVOI7Rhx0P4dppyYrSQxhVvVS92duN28Sv3h0y98pHyNacpjd7Wdbw4okm
         Hr9/Nv3NcWRr70dOQYvMPSf6M5gkCWZFbXp+lzfmbFOabRgGu21nJiS/BxnDj2e244dP
         o+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW27qhfFYWCag294kL7isZ+VoNF4SFgrTQ4r1LvASAchRx+8BlTcgLTcGe+KeSnm7Jq5H3U/Zchl5eSCrGasCibFhGPraxfxqHoEoMxsQuWTFgSPMlnqhZ6Fm7GTsbCIXS9YiUJJ/LMM0+YWdZJiQwoQySGk/iN19FWG6TJtOb7
X-Gm-Message-State: AOJu0YziCYrn5Tj9jzHvMhtAqn8r0OmjWeqyfAKrSQBFZIaxmsg2bpug
	3RZkIOhSysejl0Hz9Lr8b5yDUtyipAkP0rR1MgF0ITlSWrRgvON0
X-Google-Smtp-Source: AGHT+IHp8ZtQz53npJ0xullStS/Uz8UVp14addxkXMJmDOFp7mNVOFZkaMsusXMgAc+xeNt6dQw06g==
X-Received: by 2002:a17:903:41c8:b0:1db:2ad2:eff5 with SMTP id u8-20020a17090341c800b001db2ad2eff5mr7067827ple.60.1708109022404;
        Fri, 16 Feb 2024 10:43:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c20-20020a170902c1d400b001dbc3f2e7e8sm5586plc.98.2024.02.16.10.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:43:41 -0800 (PST)
Message-ID: <d6c7c6c9-dc8b-4c5d-a324-b4b82f1ddd89@gmail.com>
Date: Fri, 16 Feb 2024 10:43:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v8 01/13] net_tstamp: Add TIMESTAMPING
 SOFTWARE and HARDWARE mask
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Willem de Bruijn <willemb@google.com>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-1-510f42f444fb@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240216-feature_ptp_netnext-v8-1-510f42f444fb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 07:52, Kory Maincent wrote:
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will easier future use.

s/easier/ease/

> 
> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not use at all.

s/use/used/

> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



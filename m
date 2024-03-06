Return-Path: <linux-kernel+bounces-94341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C37873D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359081F2635C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C28813BAFB;
	Wed,  6 Mar 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR+2LDwg"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F313BADC;
	Wed,  6 Mar 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746917; cv=none; b=fGKNggVnOFbP8Rw3FZAO67TWAeTHWOQVz2A/RUq4PMR9INpb9lkML5IeI7Lh34rLf9I33+8UcjQS+PamSRe17FMd1Xol89Jg/CQOUlya5n/mRe+GWIRQD1n0LrPXu6kGjLiKokWL/Q3nDfeiWD+KfHuPLZm9vHfTkhCOsybQ7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746917; c=relaxed/simple;
	bh=AOUS7HU1iUG/e8eQD7OjmY5ew+MT0Q0Av2kRZ3T6SpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYxosCI3D3DDw1omiI5gChfZkyJ5MR/DiHBB/rFwu9OBpi/J15GF3wHEXIJKmY3kegmj3dk7CISlC56VlLLty9b7kr6oh/7YpIxIDNcYsNRrnOs0AoqJE+T+tR39bzWcsm/WN5PYIgP65ok/B+LgRr+8or1KIeGRr6YmvtMUyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR+2LDwg; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6905b62ed2aso8291596d6.1;
        Wed, 06 Mar 2024 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709746915; x=1710351715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoGpBFyUJXIJqUxawCbUvlxpYBQviBzPiWSgkxLAi40=;
        b=WR+2LDwgji9wUOr+n/GG5y0bJg6qbZ+quo/uCQYePWCCD2BZI+8Twa70vT49XHe5+p
         ZR1lY3zJmIvTc0yjLT1lKi+Gb+I/rU2H8zEmqfEErn5nne33BeaPcE8AQmyQU4jER8XD
         ldD2ud3h45gz+D6f7DsOE5YfO8LNR6u5mLR5rRLGJpMfnd70s2fX7qiC3o8r/bSRlVE0
         ityo+e8cchOPrHFK6SvT0ykt+cw7Er74E0kCnRkOH9xoin5Ck0T2uKbqb+TKX60fiBVI
         DbgxvRkGi25DrC4VgXMhKgb+Cv04NdPWHRhy0zmk2FZ4c1gW91iPMZNoS0zmHQtx8DUH
         Q2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746915; x=1710351715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoGpBFyUJXIJqUxawCbUvlxpYBQviBzPiWSgkxLAi40=;
        b=K2FrHjs5Fwsy3xrS8izFIY9DMADP3O8+kXsOfF3YtOFAFfUqXTaI/L6F/OjTIvfWPR
         t4kX/hgXQacfqIVQ8iiiXEysoUHw9rvG0KiC509X1fbEIgIwfl5CCHG7rqUvgFVnCKeP
         JctiqOek7aIbEBiThdRdNu5RtjiM0RNxnYqZ/y2cZMqfX3N63WURawkf/bm40HjeE3Gb
         yhqcC+wkBEFVOmDW96Wye8Af8g7Uhypnbtq/tnlMuTWQeABb6HQGs5VIfEPwCIG9xvQL
         ys5mOQ7fUOJMFrTlE9R4MatZwFDitfP8pbJdFcnnV0qZwb9rrVtX96v5p/BqzZ38s+rp
         Hzew==
X-Forwarded-Encrypted: i=1; AJvYcCXX8jjPfghIYZbqN5xk6cWRXtqKVpCvgldTdV1xjqtEzNajNG9yWoslbi2t7bWcOSeXO3xlDKpXc/6gaYPGXJ5hsx2MT5d7/elonTSFx2eZxU0QLUhTeEwq7OAsPVLvjmrqWwJDKB0AhA==
X-Gm-Message-State: AOJu0YyTWxFoReAQeUIaOIGBtClFGY5If2ybiMw4WcS2J+s6L2MIysOF
	b8BBQRX15ZGiZNxVVA68BnM5rZRh8EtnRp4Gc9TxOR86z53/oXgm
X-Google-Smtp-Source: AGHT+IFD+RKpduUO3UYUWKne+01iux1Pi69wxHgOjz/HwCNYjShAG4SFhDUnQo4ph2bQjFWyjVcpAw==
X-Received: by 2002:a05:6214:1788:b0:68f:fe7f:abff with SMTP id ct8-20020a056214178800b0068ffe7fabffmr5829870qvb.19.1709746914713;
        Wed, 06 Mar 2024 09:41:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kr9-20020a0562142b8900b0068fcd643b9dsm7654626qvb.22.2024.03.06.09.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 09:41:53 -0800 (PST)
Message-ID: <bbe3e611-a310-41f5-a037-4b7d5e914b94@gmail.com>
Date: Wed, 6 Mar 2024 09:41:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Content-Language: en-US
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, xiaoning.wang@nxp.com,
 linux-imx@nxp.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
 <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/24 09:24, Catalin Popescu wrote:
> Add support for PHY WOL capability into dwmac-imx MAC driver.
> This is required to enable WOL feature on a platform where MAC
> WOL capability is not sufficient and WOL capability built into
> the PHY is actually needed.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Nope, this is not about how to do this. You use a Device Tree property 
as a policy rather than properly describe your systems capabilities.

What sort of Wake-on-LAN do you want to be done by the PHY exactly? Does 
the PHY have packet matching capabilities, or do you want to wake-up 
from a PHY event like link up/down/any interrupt?

If the former, then you would need to interrogate the PHY driver via 
phy_ethtool_get_wol() to figure out what Wake-on-LAN modes it is capable 
of supporting and then make a decision whether to prioritize Wake-on-LAN 
from the PHY or the MAC, or maybe only the PHY can actually wake-up the 
system in your case.

If the latter, then you need to add support for WAKE_PHY to the stmmac
driver.

pw-bot: cr
-- 
Florian



Return-Path: <linux-kernel+bounces-46898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C38445FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58361293C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666012CDBA;
	Wed, 31 Jan 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7zsPvSu"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0812BF33;
	Wed, 31 Jan 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721766; cv=none; b=QPD24ZW+Ymy616Pp9UtHy5JSn+CHYKDMVmPv+7N7wI4I2V7tSwlqDTYmYjXnwS/5aMVGfJZBl6aNTSl0S/7DMKTVyx2NeiVYmssRzuyiFVngwlwk0FRC8ZYaCwGuAgmhOJ440N2+EeZ5VVEcY/F4IuEMPPdf+J/SpEXKwUUPZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721766; c=relaxed/simple;
	bh=O+izuHc9QceRklKzOQXeRrlBodwgfDDVfJpjMz0o8Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGHYCR4RPegdocYHnl44E6fBxLcgijtsc7nXASaqjW33T64iMMEQaTRK30urpmRrTcJ4VtxBNLaq4BqDP8uhiPUdLabc5IOocRlsrGUEU//ZlJbA/5YU8ZtjkwJDxlBR1VncAoE2n9xXZzo6ipOtCHhPxBXE/X4Vf11ZD31pPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7zsPvSu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ddb129350cso3397126b3a.3;
        Wed, 31 Jan 2024 09:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706721764; x=1707326564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLiFiQX9YAtM5FI4rfY3m8XaHxuix/cO/3bJw26pXbk=;
        b=R7zsPvSuMeJus8z0N42ALvaVZKU/xy+/KdxDXRtyYh+sejtjglVdnGTrRLOQCVGGDV
         0ss37E/uLIATZmop4xqVJqCGU3PUg0MBd18iYBEHTS4oC6nxHKtqDMj3tW406PrIZfyT
         9vQJvyLsBF73wx/O6ESCN282Fh9B5JCqbghtRcd8A/0rf3LdXnEnw1zY0s9wg9UQABXN
         89rXHu12hfAb2vJKn/qNDEIrjQf6Cp5RVTw/+OYwg7GNYfqOoAKdvbEJzzYgNEXdeNF+
         ITwwZ8zPWTCr++u2rlm4y2bm/Md+ZEz43qTn9/ZAI2K7Qn+aQ8OwEbUXp0F0J6i9a/uD
         AVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706721764; x=1707326564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLiFiQX9YAtM5FI4rfY3m8XaHxuix/cO/3bJw26pXbk=;
        b=T+Z6Gvw6B0xDbfapKVAvndGAeeXijWxUO2MrcjbACvkrFpdgU0INzIVmtcSTMXaKq+
         B9lOMnwl4VD6lVRL3mpmAcCNFDCQSOTD6YKsXi3crcCovsS25jasINyoCS61QjkNKYMU
         VkL8Ss48edEr/EbNDiRS5ZIUXPG01vEl3ZBoUQrcebY5gxBpUXLUgaF0oUb3UOwF7dBk
         RM87It0NqoQoiQM7qNArOJZ8V9VZgWFmzK7G1m/4p+yB+1n52mo9/gtFidP13bboBttz
         PmFgM6TUD2oFcpsqoh6ZCjfYC5hQ3WXRR9HHv92Femx7T7KL01oXzIyp61PjvoekFwLR
         neKQ==
X-Gm-Message-State: AOJu0YyOqj4UgVTo/xQXvIZ0G8lIG4zNuIKc6B1xjo96dcegXteCWSui
	mLkcNvV7YzeKeTU0DllBoVMST0z/vOC/zD0eH3jb3stAJVIMgCmI
X-Google-Smtp-Source: AGHT+IHBVzZhpqGnQFNe/AyO7zPLrdkCVKiK88W6USTvV0vwMgPQjBg7wFcJ2d02f1rAUaJpUJC82w==
X-Received: by 2002:a05:6a00:938b:b0:6dd:db87:6356 with SMTP id ka11-20020a056a00938b00b006dddb876356mr3060893pfb.7.1706721764438;
        Wed, 31 Jan 2024 09:22:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u26-20020aa7849a000000b006dddc3e298esm10155628pfn.150.2024.01.31.09.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 09:22:43 -0800 (PST)
Message-ID: <ea29db60-55a3-4cb5-abae-efb4df93b9d8@gmail.com>
Date: Wed, 31 Jan 2024 09:22:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: Add KSZ8567 switch support
Content-Language: en-US
To: Philippe Schenker <dev@pschenker.ch>, netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Marek Vasut <marex@denx.de>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, stefan.portmann@impulsing.ch,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Philippe Schenker <philippe.schenker@impulsing.ch>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
References: <20240130083419.135763-1-dev@pschenker.ch>
 <20240130083419.135763-2-dev@pschenker.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240130083419.135763-2-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 00:34, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> This commit introduces support for the KSZ8567, a robust 7-port
> Ethernet switch. The KSZ8567 features two RGMII/MII/RMII interfaces,
> each capable of gigabit speeds, complemented by five 10/100 Mbps
> MAC/PHYs.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



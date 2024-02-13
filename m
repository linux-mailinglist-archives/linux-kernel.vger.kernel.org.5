Return-Path: <linux-kernel+bounces-64528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89E853FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961BB1C206A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0962A1C;
	Tue, 13 Feb 2024 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpOvMUOF"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E462A02;
	Tue, 13 Feb 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866380; cv=none; b=e8FK9QGxTqr2nxZsidSnu+yQ94HqUDw6RLmeMQC0akGMWTPSSKCWDmAYz1d6l2NGAyOptwYnqEXfCo1FL1gyM/jQ4bJf18ZleYCzo3AD/JmD8iyA+U7LyU6Q+Iw8MltnoARHA0Rg71MQB3S5ooj71tec4XXhTQYqFVm1+HzXDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866380; c=relaxed/simple;
	bh=x8fQ5hx7mIiC4RN3j8BVg4aobkP4aLgUhIvZhdFynBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Are4OfGuHlRYWFQ+IOdBKKj4GmaVh0DsqT6m+35a8leBfj/e9Nt6TVmseoR8+Mju4nUaGCtfoUrudOkAH0moA5HWPnryZwHq1sQUZzFTvJvgUxaTLyZmh5LKQhISej8bKl/wk1/de0r7DN1XAaxbZr5eNcsdTPdNqk0Ct9gXROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpOvMUOF; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc73148611so1437340276.3;
        Tue, 13 Feb 2024 15:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866377; x=1708471177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9hvikodJQ1XcxYQd9NAnEwKHv8sdzqihjO3cFsNCQM=;
        b=HpOvMUOFtO0HLrbHT7oP6mzdW3++dRfnG36XjDMGLu1WGtXJQyXqkZCAvPllpmQqjT
         TtH7iczjYoJQwM1PEwloxCAsGT+Vr8eztsyMlyavROE5ZTUoCkaImRzaBY2wrbckEgIF
         ghS2LlQi16mSlM/eIdpg1NIx5H6YB7hyMCQ+pj73YPYlreRK/+MLt0sQncX8wEM6XNGu
         bLmTerFwNadXJfrqLTgz6X5miGQfVr0cL4LLiLZezcm2LOLszQL+UlAID8aS5w9PNkx3
         XvTvvh3utFEQc3TJhk66bSAByRALz4fqRguQv7xx1hJUetUNSW9AIBpo8+O/Uqx6af0r
         Fx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866377; x=1708471177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9hvikodJQ1XcxYQd9NAnEwKHv8sdzqihjO3cFsNCQM=;
        b=Pgl21+Jw3FNy4fM66rZCMnEoGDIpvc2puwFwjsuWoWH1pOaMF4buXbAcd9zcfFS8SV
         gSEbfIsFiGDO0cLlJZEi+1zhF8c/VaBrn3HsW6bC/D9UJNZWHiJ9vItntqbZVYeifqT6
         TtRfxELdVE4UkQOS2nei5GMyFyNhJ3GuQcCjulmfHsfjVAHS7KBekjAYPLJp9E6h4TVC
         v2jZIF0e2Xddog9ehYEbfOKj5G8qSUDs4c5BGUfqgjkVxHZRh07g/gFjwo5ndDHwT+J4
         76oZCODmSlJSZNsgRgH3/29fhPvAQNrlMH5PLeH71/TcWILvojp9UQY4q7dZLLG4AzxL
         13IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLKxc+LrhyMfBV6eKa1bsReZG2nuPhLHorOhqsoqmnzSaDTZyRn+DW315ZAc+Js0juSEffTqyDv2/5eg4ZdHNI2Sr5BZHBrOlIVM9vHknxqt3/j8c5wtQofYI+Fn9AEMvwYaO0
X-Gm-Message-State: AOJu0Yw3XaHhM3SUJ2VoAHddr9LBUAnSjj2ON+CRV+yqNIlM+Tiq8Dz1
	+qppPabZg3peG/31ARyAC46mV0KLSgjZkISW16CNf68k4PZ/b3hE
X-Google-Smtp-Source: AGHT+IFDSYubiwCkuLEVayJK8/QfA1S5fAMsdeBeGjUC1017MKzevv/7ZpUqB8VT1Y4MZozd3fLbIg==
X-Received: by 2002:a25:6c0b:0:b0:dc2:3237:ee61 with SMTP id h11-20020a256c0b000000b00dc23237ee61mr651326ybc.53.1707866377432;
        Tue, 13 Feb 2024 15:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyBjKQYH7UIZm5Z8hFQfIee+jyvTuo4wCP4mQWcuCvGI/v/xvFOIb174ewCVExab3uo5Bjefx6dPrjhsVdEq+J+itdQK7Oza5YY1QSfSewfG6iCtZPIZ3aLq8qTSfK0BH8mJ21O36/5L3hAEL8NONvWRExRw/Tok+rv/zldSjV3rVR2R8PSl3sa8Na4p9WDJOMFgDaZN1NRvpqfVMEnyImS1ukLkukEpicP/SYybYRpjBPqOeH4eENb/MqkeNXDmnJZL9YGXJ3sKtg+0fFcqHze5zC5r1snTwHCHDn0OiNrawWzSOxML9uyBT2bNhwUDIxSF1/J1SVaDKwprgxTnVt25YVK/IrW/sdDjdrLEX7uMHSX3pp4VUBZ+bowa4DeIIgHAExIEJ0dE4Bni6EGx843MtuxiPM+glqE3kMr3iNUJ0=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bp42-20020a05622a1baa00b0042c65d05e17sm1513620qtb.21.2024.02.13.15.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:19:36 -0800 (PST)
Message-ID: <6db0fd10-556d-47ec-b15a-d03e805b2621@gmail.com>
Date: Tue, 13 Feb 2024 15:19:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/15] net: dsa: vsc73xx: convert to PHYLINK
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-3-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-3-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
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

The implementation of phylink_mac_link_down() strictly mimics what had 
been done by adjust_link() in the phydev->link == 0 case, but it really 
makes me wonder whether some bits do not logically belong to 
phylink_mac_link_up(), like "Accept packets again" for instance.

Are we certain there was not an assumption before that we would get 
adjust_link() called first with phydev->link = 0, and then phydev->link 
=1 and that this specific sequence would program things just the way we 
want?
-- 
Florian



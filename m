Return-Path: <linux-kernel+bounces-100594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFD879A90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C181F22A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD61384B4;
	Tue, 12 Mar 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8g0aGq2"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50979B88;
	Tue, 12 Mar 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264191; cv=none; b=Qxoyv9fAS4lkmsSzaIKJN9oxf45FFKjwig7NNFeZcJkvawFVS4ia1LWAFNaMQCd+4wq8IJZ4cirTRXAaYWqcHnP2bXRKGit4ag8YtAFRioOlox9lDiqhXwxFYqBAVNRWD+8bQkrdL9Na9PhdPUOsLtYrGLf9tBD5uWzYR1ZlYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264191; c=relaxed/simple;
	bh=0a7EMDpWvPfg2ojGzSsT+iLINndhAewsaVLKf59PvLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAVMW9t7jRjceLQjBuPIMnH/x1vxzW8TIAc+eIUEZPq1ginu9jOGRCKdUgwiO0jdZmT1GW1wzZzfM6i6HC2qvNF57NLvArS9meOlDOIpzy7OBG3reoO0demCucAuPQiO1hVycJKx6lVCOwAfDREZx46eiDiY1HbPmEGAW4Y6g84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8g0aGq2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd6412da28so1134655ad.3;
        Tue, 12 Mar 2024 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710264189; x=1710868989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHdbgeohDa82fmXgO4FmYAwJRfJ2HfOOlJtiNr0xqjA=;
        b=T8g0aGq2Pqgx6xAMcxjR74ZlmLLDyUi+eIhNwBF089hqugy4oDiLsdnIelAtY8fzpy
         ROl+pG2pByyq8rtlOcDUTK9Gem+E8dDi+iEpwQ6NVnxOrbpL7wng0WnnbS1yGIS6n5dW
         j/6CpmmeuWwdoU9ubmwbCzHCAxiFfcjYqSzTy0RT9aFKMHO4iEQ7dlt0c2Y2FXNJSKK0
         e8XfPdwFqCeuXo6HLNQdCB2X9l4KCzNMneUypDR/E3T2rqDqRMVIlrU4UlJ6fixyCKdm
         OuCa7uejxAo54wPHTI7pZZvmBdTKlRAKEGsnjT53Nxir3sAQMba9NEWORmtil9+YDsIC
         3xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710264189; x=1710868989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHdbgeohDa82fmXgO4FmYAwJRfJ2HfOOlJtiNr0xqjA=;
        b=VbvwdoAr5NLvy/hPeU6Te7RJS20f9jkcVTS157BU6CwasMdMBMm/vhs01Cz08CJsrH
         0Z/t8r4ChPAMTb7BZ3P3Gl/qHTEYJU05jn7dfytNx2CQYH+MJiV1kWnk9a4UDv6s8IH4
         bmqmo5vN38pLtWoi2p5t6kLlAuL1/oLOHxazgnr8bEpPyzTdL7eJ2A+NtgcQ5zj/w9XT
         cUkTdKbsVuHoq/dVkf5uLdCS49rrK9lsNt5LVZOc21fLbu0t+ZG7pIhdxGANAbMhuJZb
         EPGys2I7oQBdkaeCCBwekOvBK2f1XgnkNPi/YdSx1W8sc3wItD+im5toalg40WwNvJ7P
         D5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3+NrYk6ptWWpFR8iJswJueuxky0ScaR3QHPYzdHdxu3h7GiQjtEetPQgm4cWHfIiCx7pUfnCR9SRPBCPdBh5luBDFYu6QOMvs+AY+7c7KCCfKxPGj8i1Svmc3sHz7qogDkGw
X-Gm-Message-State: AOJu0YxIk/KBy2Tdtb/VH+xaKpn8mr8Y1S0Pc0Y7Vi3lWSqGmcYv4pq4
	5nz1TGioaETOTTEtWQcm+NpBzqEZt/nZyJtIS1L/cx159KDZrfkdQhx7u0cKcno=
X-Google-Smtp-Source: AGHT+IGQC2hKW9T2l+vgfWqWBPmPBvQMJRsIcHScSePfrxDNLvIOS0iJEaCRQojYX7hAd6WxAdjGqA==
X-Received: by 2002:a17:902:c405:b0:1db:933b:4566 with SMTP id k5-20020a170902c40500b001db933b4566mr4769380plk.38.1710264189065;
        Tue, 12 Mar 2024 10:23:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f14-20020a170902ce8e00b001dd38bce653sm6996236plg.99.2024.03.12.10.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 10:23:08 -0700 (PDT)
Message-ID: <df295be9-d33e-45d2-914f-c9c1554e5ac0@gmail.com>
Date: Tue, 12 Mar 2024 10:23:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Daniil Dulov <d.dulov@aladdin.ru>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Doug Berger <opendmb@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240312165358.7712-1-d.dulov@aladdin.ru>
 <ZfCOb4x/+41y+SW3@shell.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZfCOb4x/+41y+SW3@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/24 10:18, Russell King (Oracle) wrote:
> On Tue, Mar 12, 2024 at 07:53:58PM +0300, Daniil Dulov wrote:
>> The expression priv->clk_freq * 2 can lead to overflow that will cause
>> a division by zero. So, let's cast it to unsigned long to avoid it.
> 
> How does casting this help? "unsigned long" can still be 32-bit.
> Maybe unimac_mdio_probe() should be validating the value it read from
> DT won't overflow? I suspect that a value of 2.1GHz is way too large
> for this property in any case.
> 
> https://en.wikipedia.org/wiki/Management_Data_Input/Output#Electrical_specification
> 
> (note, this driver is clause-22 only.)
> 

Had commented on the previous version (not sure why this was not 
prefixed with v2) that the maximum clock frequency for this clock is 
250MHz, the driver could check that to prevent for an overflow, most 
certainly.
-- 
Florian



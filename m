Return-Path: <linux-kernel+bounces-58874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED484EDF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492EF1F26DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08603524B8;
	Thu,  8 Feb 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btkff4Sx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87D51C5C;
	Thu,  8 Feb 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435442; cv=none; b=L16VO6gpy3EXO80HbK+nFrLUd1SqStG0kV2fRS+p1aqhupzDu/Mmc4YKAAreVH1s5qVbE/Wnu92s+5Ql5/N34Ou2OXOO/jZ7TMavZGfsAIbMruoy7azx7IOip9rLzZC0wDlPX2CeGfmHJ3+enEXM2R07pnwK4IqBispOnV68ELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435442; c=relaxed/simple;
	bh=d2+xD8FkJzwyxE/Em68RtKYMBLoWnjAYk+9OLXSnOw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xz18y5+i5mcb8Py15LSuMR1NR5P329/8o8Gql0vG6SIcOpPEWIvCapLVccBVNduAyjchNOdmfBBkPNyRitO5gNksMh5qxEmEpeAw/ZSHVnxPDNfYF9+SxeoO645d4C9QhPKOqLj4ZPMiO7J+9eGFOwEPysqG60awHOMSAhUEWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btkff4Sx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93ddd76adso2834205ad.2;
        Thu, 08 Feb 2024 15:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707435440; x=1708040240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0GIo8oOQn97rKaire2T+ESMtm74Gijc0Rh2jyQykdo=;
        b=btkff4SxmO3DAJF0bf5vSelZEVX3A/1Dkq3u8O0s24VM4Zup4D4gndCMyG4DGPRCzM
         OePIwvaoFzPSfFe0DvC5GKwrbbhTSMjTK14JF89ND3lbwQW76AO0NbSbkcZUc/02ujHS
         0A7Br9RjJREUxwmEobnNrjP0WZB30oqLbpG6YBOxvoK72tmiU1wa88pbVL4Vi5GvbtHD
         TlSnWild+4qUN5qtShoXYJLsh2pu77AqqYpLNeMKKPP81Ud1TUPkQ59HUdk5yrfrlqWA
         Cylz84w+5gtkJ0jVkmFDx1PI0oWCvHmA66/j+Vapa3vjrkJALz6Jh+X7yfRgxJKAl8FY
         3/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707435440; x=1708040240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0GIo8oOQn97rKaire2T+ESMtm74Gijc0Rh2jyQykdo=;
        b=ZddiXVz1bZ4MYMyHvtoyiooglc7VQWM5vDub8eAJkkTKMrLSdMsIYW8/A0S5b0lP/o
         IjLyh4t6+RsY232swSvaA/JYUVfhUw6z3Zd5MNA7QUMJtruJdrRwCH5R3C1lg8Q2+ZrC
         pGRKAf0yexz5cPA0MguVBZIU+06MPHQYkyXMN+/vJrjuZyjexIYWf+d1l7UABaXcDIVK
         OyMI1Fmpy0yFW0tQucuijULR1SeoJM8px76tzlMpDMwwAxKNkZNWQE3WtOPdW+7uwSfM
         chO83vliCGmTwIHU6ulbu7dJaX7C9zLN4vd8UB/ja+i/MCYEoB5+fMOPWqbTAyNJRhYg
         7hCA==
X-Gm-Message-State: AOJu0Yx/OqRkhc0SlvaPsiC6+k/THthXtaS4yHRd+995R4fRbx7ZaS4g
	UGBGDQX/qosSy9LgToyy45hBTfIS9kCowWdT9S4xfetbtlOJwBpn
X-Google-Smtp-Source: AGHT+IE7iwBRFNC08l5qZ4OvsoKbL1J8VOmf5w6WVLW9EHfagnrZQHB7XsCUfU6WddSXo3+oQTrV2A==
X-Received: by 2002:a17:902:e5cf:b0:1d9:282b:979d with SMTP id u15-20020a170902e5cf00b001d9282b979dmr867638plf.15.1707435440132;
        Thu, 08 Feb 2024 15:37:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRUirbP8Z/LqI9FtT+ucHlm/bTUi+BVBsCGAFFqylo+5vfOd0PSXlOWxRp1CdMKmuIil24NmqiTfIq85W3cE9PT+qptUffW401TwYcz++07h5TuCxqEn6+5MKwBvOMaFwONNCT0RLUdrJ3Y0VyApvo3ayUHWZO9dPkCDKtKbcFQfF/p/Zdn6rryLqge+LQo13Y56lakcPxstDmfxSXXb2pQyEzh9VC6XXTtJaHI60y6Azb9BHAzFQ5epyKZCCWh0601U7OnFwzxizR17zhOWOYwI71ehcyRR7P7fRkG4pP2rM=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jy12-20020a17090342cc00b001d92a2b258esm319227plb.118.2024.02.08.15.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 15:37:19 -0800 (PST)
Message-ID: <daed47f9-3672-40ff-9abf-6cfaabb9b017@gmail.com>
Date: Thu, 8 Feb 2024 15:37:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 9/9] net: fill in MODULE_DESCRIPTION()s for
 dsa_loop_bdinfo
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 jhs@mojatatu.com
References: <20240208164244.3818498-1-leitao@debian.org>
 <20240208164244.3818498-10-leitao@debian.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240208164244.3818498-10-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 08:42, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the DSA loopback fixed PHY module.
> 
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian



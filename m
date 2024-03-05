Return-Path: <linux-kernel+bounces-93087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE67872AED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA0D1C233A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DA12D21A;
	Tue,  5 Mar 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxC0+jyh"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A617112B17E;
	Tue,  5 Mar 2024 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680698; cv=none; b=R6tFi6zUvd1KAc0p/0uZNntKqT9CBhJWbJhMHId62dYBW13ct9SnN4oG3Q0vWujq8Oifuojs4WlPrQO2kXcUtUabf/XKj6KyDtt0CSJjlKGsWPk6V1bwX0JwT1w0szflwIFiGie10j9beKXXzA0fYS8yeFcVP7xBVF7nn3VmziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680698; c=relaxed/simple;
	bh=r/FMUq0cfXtSNCvomT8MM4kqRuTVM4qx8HZFAyYd8uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAXQbOvBiiNe5AeduL5WAsDwnslJh4DIIjt9N0lvG1iqf4EDR5PGczgF6zL9kI+ntrFAAU2iU+Kfq9veiu3V/h/qKvRkXmfPotHb9uO7vrP7rcxx2/roicKWMKKdoMXoz8p4qi5EvxGa8aPklfIbOwDqfUwbbZoNYg0d8W4xBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxC0+jyh; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso4405192a12.3;
        Tue, 05 Mar 2024 15:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709680696; x=1710285496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ei3Ei7fZc+FJpIyukaKpwAv3ENAE9CDqDMBONWmjA38=;
        b=AxC0+jyhRVFgoKpfVSHyODIdksH9GaKlUJ4tTLXCrUcqJ+7hqo/i0KJpkj8FPwURq6
         XXvHHAAxOuDtaMlCk5u/ttXgligDc0sCu3lK8YnUswZgpSzCo5gj3O7M+Q4BSFG7UpQh
         h6TIPNgDBKfBduDu0F8ojPpJqIO3qwB5/pUvK6MP6OrFz2Yt3HIwyGYdo1/729PRaGDB
         PpSj/s9h41gkzk2TaYPcMc01fW3ZCOoVkGA81KIIherp59OnvlN6xEVfIOm+Sl2UIsHo
         KYDb/aS/lDuY7Mnzi4dx+5GkItu24unCNbRF71/l+L4ZVkEw3A1yL9zGdAQBYt7HQRLJ
         r6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680696; x=1710285496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ei3Ei7fZc+FJpIyukaKpwAv3ENAE9CDqDMBONWmjA38=;
        b=pDbFG/127EFiqMeHQVfJWcqSMh1OMK6O8ZrTxsaABwFfpmlHHXemBuML2BrpmlkW8e
         wkinLIo01Y2Ms7eH3/EynKIPCTLBFvfyyN10puF67Tgq6s/77Sjqn+YUXVloihfN3khN
         vlcnvugVsGIo5TOcWuviWNB4hsCaIi4xCzC8+E3FJWbLbvVdLQCM2woYV2xPyQ9mV162
         m3AHTeMD5ONxx7AO385N4Eho5A4jizJsotPWMKuvgWRw2qnruiJ4tgGmXenXbIN+NCaR
         J4nvh/Uz5Pfakdj00w+FPXYViZKQBSGN1C0vRPitClB5gJsfny9y7ei1EiA3/50Xhi0t
         Ph0w==
X-Forwarded-Encrypted: i=1; AJvYcCVuoKUVJEZi7iMYU49pWtYECEsfeb2bEMPnHyJkpezz5auAdNe9Y7ImKNYC2K8eIa7EUgQtI+Gfl55Ws5pHtPPorJYjdk8W+ri1llOSMtx8KNiJpuSOYcNIvjl+xTi8MGRLrJpw
X-Gm-Message-State: AOJu0YwxwpQ+zMZVo4dTR9TU67Pl4qfqdu/AtATg+5hdTgq9oX3h246d
	UGrKLrmriANQrcIs6l1OgEJo7RoW8CmiQKfc6XLvh+/88sbye+S5
X-Google-Smtp-Source: AGHT+IGhoVOhhDq7RFQABt9us+DmeYnLmaNu7PcxEJXe/EzZV9Iys5fbJcw8k2GYrj1L08LlxaPMcQ==
X-Received: by 2002:a05:6a20:daa3:b0:1a0:e089:e292 with SMTP id iy35-20020a056a20daa300b001a0e089e292mr3275198pzb.3.1709680695831;
        Tue, 05 Mar 2024 15:18:15 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r15-20020a17090a0acf00b00299332505d7sm11174919pje.26.2024.03.05.15.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:18:14 -0800 (PST)
Message-ID: <47d7fab5-6247-403e-964c-f0b28416157a@gmail.com>
Date: Tue, 5 Mar 2024 15:18:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
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
 <20240301221641.159542-7-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240301221641.159542-7-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/24 14:16, Pawel Dembicki wrote:
> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
> 
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



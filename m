Return-Path: <linux-kernel+bounces-76785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 120CE85FC8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63F31F25BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8D14E2C3;
	Thu, 22 Feb 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGK1Lq5k"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750F1468F2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616243; cv=none; b=EzTMzcneef2M1iSvtYY6Mfaanx0AIyukiQWnjMhxdmR4poKO6UPqZRtcIZC8SbLERuNi8pfswL2TDmNW6TYWjIIFRUUBUyMUIUdImJOZT26WCDf+ITElhbSilDXCX1E39kWNSyMDmAsaUFPrTqhjO8aI3WVDA+4Tqhlfc8ib6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616243; c=relaxed/simple;
	bh=G6FdFkR1SinAjzKeeCmu/d6YLuca223FdRsHUFO3wPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNDgLE30fFlNPYNJGUffwadIqVR2QVnMhFPlCMFD1keaALZRz2+laeOh6dqb2UNdp66kB6B0lH7QZTrnXwY+qX6QfyH6A7JUMVfsjwT0MlNWTtCnSZ2edOmY5l74LKdVB3/B9ni/bVSz+Ui56yxgqgepw393te9JVV9b9sib9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGK1Lq5k; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d118a181fso4280610f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616240; x=1709221040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ONFC+sKbmZgeU+8ec+H5IbujbZssYRsodi4WGWZ5Qg=;
        b=EGK1Lq5kNsPIGPN2VD8CPDYa7lJTZ/B9GG+YaMAn5765RSOdyirTu4JfBiBIWCMRMI
         33at6d1mPcjKifzZEdcq0yiELAN9QZiPUzHvvBG7ULc6BqxONmi+Xo7G+DPJVjh3MMk7
         XkRWxemb4hU5Ivmvy3jD44Q4eqGrmk1sMiqqEs2gTIB0/bxNTg/XiyWqnyjO6Vt09PrF
         NrkbkGGXnkZwHxFhXaXy3+CGjiJwxu/r0JKnlzhl4Cidcd8mYGjxmPPC6BhZBWlhjbR7
         CX7896FYCxkzPyBSc3adPV5mW8r/d0/tjEJa8J6wBY/xIlJd54cROR31zk+KD2/FqC8a
         eDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616240; x=1709221040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ONFC+sKbmZgeU+8ec+H5IbujbZssYRsodi4WGWZ5Qg=;
        b=qUxOTOCnJONoD9VFbr1QvdXjU2fCyTgj4c9X5C8CGe7VvigETlILhwamV79HGTlKAC
         tiTpzByFvgcMARF2uUanMIVpZAA2xYw1qTNdCDWqhMhS67FcceqzHjLV5q+axuIaS5BX
         HblPGYYprzw8USejv66/K6kcL0W4muqAC27SyEvR1/iMkS9CKFyDbA/Aa2hLW9rGEGHc
         x+mwCzc9qbw9Pv5nbR+OxL1IiZmIjLQgUBkPnVE1ICZZFtLocaTs01DcdUSKi6IvoeD9
         m0tqZZbEI4m4fObIKPrPtKxmGJZYjxelYiVNXu9mf4Q+c4EMn0hZSsxfvFsSdQjt+9xf
         ou/A==
X-Forwarded-Encrypted: i=1; AJvYcCWiU3kx8y+pGy9LhMdcN4gMNX4v7RVzvCtKozxwVnxWHG1fKkk4bBO8gARCa3hW2HQHIZYeaG60koK/Mnxh6MpftaHUB2uWhQJpZYWZ
X-Gm-Message-State: AOJu0YwuPm6A4puq11gZg1PZI7UUTzU/LX4RPE3sug8Ipyr7I1owIH1n
	M+VChMWCJLz6g2LsRyd69dwrSNIVE6k13ADjPv9wOFB40BFKeyHhYcH6YyTGOFI=
X-Google-Smtp-Source: AGHT+IHunUCMJsjJDlX8NcL9abpvM7ZuC/4JFzRgNazdiUVASL0PdNnWK/BRF4OjEz2bKtAMkbZBYg==
X-Received: by 2002:adf:f9cb:0:b0:33d:269d:a80c with SMTP id w11-20020adff9cb000000b0033d269da80cmr12005438wrr.41.1708616240076;
        Thu, 22 Feb 2024 07:37:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ba24-20020a0560001c1800b0033d9ee09b7asm315655wrb.107.2024.02.22.07.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:37:19 -0800 (PST)
Message-ID: <986d5e42-f349-4069-b951-6c0ceb909dfe@linaro.org>
Date: Thu, 22 Feb 2024 16:37:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] thermal: core: Eliminate writable trip points
 masks
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <5913164.MhkbZ0Pkbq@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5913164.MhkbZ0Pkbq@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> All of the thermal_zone_device_register_with_trips() callers pass zero
> writable trip points masks to it, so drop the mask argument from that
> function and update all of its callers accordingly.
> 
> This also removes the artificial trip points per zone limit of 32,
> related to using writable trip points masks.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



Return-Path: <linux-kernel+bounces-153693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2598AD1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDC81C20CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB9153811;
	Mon, 22 Apr 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMxp9/Cb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9BE153588
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802843; cv=none; b=lTk05yF6SIDq7Ea2ItYpEDDhmMiKR+C+YyZbgzNPZyzEuewPyB+y6losv1pBNyerfZ5KW3dfLWcvESmGWkF8ESJLZ6hAnbycbKGhFM/yMShiBrEfzvPlrAPB4Kwrg870h+DSM4rYcO+JqUfJdYbki7gicl9a/q7D+heg3E8Owyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802843; c=relaxed/simple;
	bh=1RVmdqoNjPvhMddsjlY+Xa3pKKSVN/+WNm0VO+799Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tn/g2ipEd9sybhqIDsnPhFYOIreujv/eQwWUUllkl8l9FE21N4tObIObvoPP1jxsm258eLnvIF2fAqWlYbuXJG2UC6/o7do8MdypJpEzOapsfbKAhyBOSwOlA18Ck3Iypw6/P6huWyV9WsJpCwuldb9HpBRHIVIbjCfWGuHTHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qMxp9/Cb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a55be31dfso8651635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713802840; x=1714407640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X18imHTv2CCCHmqGW/+6bF3p/ote05AGlg/ZRuYja/w=;
        b=qMxp9/CbAifSXDricfddLb4xc+2kKW/TS88uxuopIwdRY4SrCJtDkP9Y8H25LXKW+x
         yw2y/BF29LAFcxC19zM+Yl4dgV10e9dr7qRJBsnBEL9l9o/nMjMzcZix1wE497VJklTY
         LEnObtGe5xxxGZDXBDvfi3Sa3QPwSylJ2719zDv3nkYlVBGGakuv/q+Os5nMNlVUeb3n
         jZZsxnB5SocaCSedfDFmcMwUT1E7xE69mhhuCTMEdngmbrQ/6XdYFI5xf+UmprWtKbdc
         yi/sdBTBvVE9vvgTlNHd8t0fDYoJErPAh/zOsyK48WPrcn9WCrfFE/KqXC6+HawJ0Vim
         xGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802840; x=1714407640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X18imHTv2CCCHmqGW/+6bF3p/ote05AGlg/ZRuYja/w=;
        b=q9r/PARgNFiMUlL/K/kSRiY/5WpjL7V+CE+re4mWy8942YQZpT4pDP5DnbgRcRqlTH
         0QccCxqaiKMsU2JtqQFGJL6xcmngeheKnCJmQJqigD7lgqmKrStawYheNBIIqHJLfXzy
         NyZCTne635n8ZS/Poygx9lGgdkJ78fKnKoNbY2hgvDYTuuS+pQCQSCIJULRXT+D57lRm
         izHAeEHzkLUdqyP3R8k0W49dfUGdEDJNVKfTpD3YPVPLIfsKndD10uYX6cvs8ynJC2p6
         U8jWlOMNSkWLlFmWEIVF3BRvAHa+fnr1eCH12+X2Db/EQXCnRc/c3Wz/j+LCY6GkN3oa
         3BjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmrl7b2ZuFR4WgJayWPTQxB7cAZwzuxWPIT7br4kp1zEOMOcYta/CJ3cExD38aOkAMpkvTZa2ZE/1/Wo9Y/qtGZAPgPsn3Yq44/YJ
X-Gm-Message-State: AOJu0Yx+dy1pZArpmzoyL+YZesTxhxa/57/g4wUGKFd2dP6Ql2hpqBYO
	R6D3PiC3oBp5Vztgbp0nXMtpQAc+hdgplraWqHbKo6bb0nPsBS9ECh266Erv0dOhN4bhcmRKXwq
	2
X-Google-Smtp-Source: AGHT+IHPk9adqP6eJkbR/7Nl+/mXtpqukJJpRa60kXcBIC6/iAGnc2ywKkthA/KqVFBeuTaE/5dV8g==
X-Received: by 2002:a05:600c:3d8f:b0:41a:9cb2:752e with SMTP id bi15-20020a05600c3d8f00b0041a9cb2752emr527200wmb.27.1713802840285;
        Mon, 22 Apr 2024 09:20:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a05600c538c00b00415dfa709dasm17032958wmb.15.2024.04.22.09.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:20:39 -0700 (PDT)
Message-ID: <b61cf974-8ab8-461f-9318-d5fc31aa59e7@linaro.org>
Date: Mon, 22 Apr 2024 18:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: thermal: tsens: Fix null pointer dereference
Content-Language: en-US
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240411114021.12203-1-amishin@t-argos.ru>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240411114021.12203-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2024 13:40, Aleksandr Mishin wrote:
> compute_intercept_slope() is called from calibrate_8960() (in tsens-8960.c)
> as compute_intercept_slope(priv, p1, NULL, ONE_PT_CALIB) which lead to null
> pointer dereference (if DEBUG or DYNAMIC_DEBUG set).
> Fix this bug by adding null pointer check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dfc1193d4dbd ("thermal/drivers/tsens: Replace custom 8960 apis with generic apis")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog



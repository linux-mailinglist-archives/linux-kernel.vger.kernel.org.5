Return-Path: <linux-kernel+bounces-155147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D78AE5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BE1281721
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898D83CD3;
	Tue, 23 Apr 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3Qj00ckH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596D5B5D3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874667; cv=none; b=f+4fr+jCHiSr5wQ34B2vKv8OJ6QFunIqyo3ePAFVQxO+1O9S8E9N3mUlJU0kBo+6B19TV7eqCgYWPrccg+vHq0g/X731gsUd1Zszsry0T42tATt9XHgikFBKAtz8Ed4BS50URddkax6HHFaqjm0/2snt5P8TwJv0HGdhX/SnLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874667; c=relaxed/simple;
	bh=YgMJQsKwEunfF3/JdKkVmjQp58JV4DJ5yZc+F7jUYRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUgYb16S2ZwDs11zKOZKKowMPX+Vsd1u0kZsfjBU9GtE21Ma5rgvg/AMcQ3WA53Kxj7UgXXRVGXLEGk5LMi/M2sdNyE7IdfAO9qFJFTIzAG4BHpiEJzHpGm0rBnwzsllClFzhMo29PWURF21NtHN7LuCVBUBvNex6+9sq6eSQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3Qj00ckH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso8370580e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713874664; x=1714479464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObSuVk2cCyYOq9cHChsdNHrTyXA1CAw6LSbkNl700bk=;
        b=3Qj00ckHZJFVIf2eXMCXiuu+pXeCQSFhJEcUY3fUiGkPJ5FKD9Q/W5Bmp4XjLPawMZ
         A0M7Rau8voa6me62BiEaGFhR0w8nq00SuyCVz0RcETsqttPZxf9pNxDNV5pWRbntqoal
         7Ka4Dy9vup0P/MvabRovbCx5YWraHUeEo+9dwDP4YzXl9TbRBpjZjQM9co1n1SJrOuah
         TA3P/SDu2ZPlT6taSM5olgaN5Ixgmx3x9IjVyCZskLDirB0EgTLwUU9GDXa1Bx0oxM+e
         dcezO9W6sJZSBcGE5z36X55IGIDOCSnm+ParftahLJYpmtszmam5jytjNMwtCtN5bKnL
         vMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874664; x=1714479464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObSuVk2cCyYOq9cHChsdNHrTyXA1CAw6LSbkNl700bk=;
        b=RYUDsvTjIGyMkYfm7N8g2BEUG3RgcGTKJ1OU1Dxmm2YdfT36dE/4JcTGsEWcc+RiFE
         wFTN/VB6TPU95EZHa6ZSLP/Y8zRkA+SmWEEI6fEEWCsPpAQzMoAFvZLjnjz4qsAXgrMT
         Q3F7AgR2UqC/wobhfDjBqQ3MjDiQw2yQLyh8OAzsq+Yn0p+3S15w53sEoQmwm2xqEyvG
         C81gLyCVhIBULKjWnEr6M56HTwFEBPjX8aRP97F0TPxD5OOodnkfEaaDWk/HpXRUKwJJ
         rl9exkWJ6brHnulFL7IqpKuX+3ghR+milQHDZNLQj8xt8bYEgCTQZS/Ukij6RG5DU4yP
         ZKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCeZTf3xbpcN1QNtgEPaCVJ/sLvYeb/1Zh0VV9Vht6CbBbTR/iTiZYLFFI0hIp8NJikeohl5Yjdz8F3HtPfm/abQsODLEemq8SuErm
X-Gm-Message-State: AOJu0YytqXpGz3vVwlHQKRswcHPItsu15YKgdhHuGoG8lRBKX5Ujeb/z
	/LpoQx77vef7AOGoZWqn4cA4W3VuD1+bebKh707prcMoAJ102saV99b/QJWZeTY=
X-Google-Smtp-Source: AGHT+IEbnWgJXLndC4r7PMxi12FrfMpBRS1OcRoxhe3SZwm2w23Miy6gbq0HCIfRAKRI1UckQV81bw==
X-Received: by 2002:a05:6512:48c6:b0:51a:f11c:81db with SMTP id er6-20020a05651248c600b0051af11c81dbmr7260880lfb.30.1713874664054;
        Tue, 23 Apr 2024 05:17:44 -0700 (PDT)
Received: from [10.100.1.125] (ip.82.144.213.21.stat.volia.net. [82.144.213.21])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906044600b00a55b9424832sm2245777eja.30.2024.04.23.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:17:43 -0700 (PDT)
Message-ID: <054555f3-4a59-4f99-9b32-244f466c4ae6@blackwall.org>
Date: Tue, 23 Apr 2024 15:17:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, roopa@nvidia.com, xujianhao01@gmail.com
References: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
 <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_5C4968C62CB4BF868761113A754124143108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:58, linke li wrote:
> Thanks for your advice! Should I submit another patch with subject
> "[PATCH net-next] net: bridge: remove redundant check of f->dst" or
> "[PATCH net-next v2] net: bridge: remove redundant check of f->dst"?
> 

Please don't delete the whole thread, just reply below it and snip any 
unnecessary big chunks if needed. As to your question - maintainers
usually take care of this so re-submission is not necessary but in case
they request a re-submission please wait 24 hours before sending another
version. v2 is expected in the subject, also please add a small 
description of what changed in v2.

Thanks,
  Nik



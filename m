Return-Path: <linux-kernel+bounces-48889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F68462DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CD1C23371
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7483F8C7;
	Thu,  1 Feb 2024 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+mgcVlS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B303E49B;
	Thu,  1 Feb 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824139; cv=none; b=i+NxGUhVmfmEMe077A/NOFhkBRBUFg54fpJ43r9UzapuKvWTS5OqHFzw+603Y4JDIT1W+P94B+AWiJcjWxIykuaSsDx1zkKb6cZ4OdnhWqFLa/7RAdYp7Ui3cRqlfXWLy1vGm8GSYvoCpJSsqSLbnqp311vOKheV0NY7JPKqbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824139; c=relaxed/simple;
	bh=rSHU6aazqPrj76ScVaVd+/urj28owCl17xdltFDfGv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi8RlJ65RyS9W9JFQfK131J/KjooE1jEcvwL2HlNOCGyh3JiGnbZA+H3lZdUYsiT/ZOTiykFfZOLblBL1iMK+le7DJAJL7suMAxtKAkCcAc0+9HeSCH9ZMhCwJkFI7YiTQW5ISjeESIgJ5bHy14jA0BZiAr8vUm5OaGQF8CQJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+mgcVlS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fb7427044so2707575e9.0;
        Thu, 01 Feb 2024 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706824136; x=1707428936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccFRB8QaiBoxKb88/t50XVL/tuz3mXapjnDD+Xt2TcA=;
        b=Y+mgcVlSfbHBf034eBdX3/1MKeYTU0ynOZICzV4+217671nyQw4iSX9fw0e97zL1tV
         kUWDNjgfzlcU+0eMn/rOu5cCtu3MLFED7Sk+flXus/otPITWI/KjAUBaAxLdKdxanjvt
         NKG/J7zkdSaCgvWfhXSJ+UMqD/thB6N8HdxdLhMCiv0sRRKdw0shLtd6loNOaF2auZfv
         qrmGrEP213IpzCpRY5DYGmTXBmLwWC6ulc6/qnt8zJUYtv9qE6No1dkzzYypGqo7bFV7
         BqXWehck9Vt6kasrp/gfcQPCz8gCvkt4NJQMvDzOfxkoMxl6jduOhrqztfdv5ErRXInq
         g5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824136; x=1707428936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccFRB8QaiBoxKb88/t50XVL/tuz3mXapjnDD+Xt2TcA=;
        b=WJauEYk4txgKe+HrqA4h0HcnJB6c/81qq6B2XcfhhQHLhM9E3J3BISUW5MN02IKJdQ
         aLEv2IFr5w/h9GxIbHuSK0UtuvyA52bMPH9i/zB95D7Z5xwtseQJEy9Z7nVLzs7ApAYQ
         X33PasHP8CsIGIQWIiy/8eYtonoZuXHyrrA4KKTfjL4mklXkZGKUj1ERUQkJS4DVriyl
         YeVHtBGMt8AuhEu6B0iIUteGt7HhwVkdO3pHSqeOHJP4TeH/LFzo4/TqospeHdVesddn
         6XIY4Auo7QZxoDo4oiOKIMNROlx0jVw2xrsrU/kMPuwhj/vWfjRkF/+a/ChSYJSJBOyY
         GRNw==
X-Forwarded-Encrypted: i=0; AJvYcCVB00Wz41WterqcZWiZQ3JFcI4HbQpaxGFIrnAqXx4qTu2ZlKMckTHSe0WXta7k6pTIDIZZRs8a3igduePv8VsgNHdDpU9kJtdOIDHmvqKsHjmBOZr2BcFO0gpYJh155StHBAgAA7yZzoY=
X-Gm-Message-State: AOJu0Ywe8CUJeUBhdY93PA7v/E5ggMUZtrDjQNd5m+43pC8QqvUW6ESD
	GP1Bys8rLS9K8MDR4/YqsxSng1Ih5h8NUEH067oUw7QDqHXdC0FK
X-Google-Smtp-Source: AGHT+IGqGPEQQhHkKPiWJ51qrMY+zi1COBdmmS7NwairIDUSg8mU6oWiq8/mUQhDBbG+cwpndOEmvA==
X-Received: by 2002:a05:600c:1e05:b0:40f:c5d9:57f with SMTP id ay5-20020a05600c1e0500b0040fc5d9057fmr79814wmb.3.1706824136106;
        Thu, 01 Feb 2024 13:48:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpI5Q2PnsKruJb2ME0QLiDgRbWZyuDnK5CU8zGEz20XHZ7VEclbJ39QxiIbxNxLL1TVizHeNcX6inCn0hOLh9jIk3LZ8CsE4u9PnD02oVWrEaJJxKNA1/dFbWIc9E6HfIGy4WBTBdhDGwMEEDI3yVkcBvYeZmKiytO
Received: from ?IPV6:2a01:4b00:d20e:7300:6518:5489:98df:7ab6? ([2a01:4b00:d20e:7300:6518:5489:98df:7ab6])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b0040fb6295018sm735061wmo.12.2024.02.01.13.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:48:55 -0800 (PST)
Message-ID: <16443928-07b3-4271-b36e-c0f26eb3329b@gmail.com>
Date: Thu, 1 Feb 2024 21:48:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: core: Fix dependencies for SND_CORE_TEST
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201094604.1347793-1-ivan.orlov0322@gmail.com>
 <87eddwz667.wl-tiwai@suse.de>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87eddwz667.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 13:05, Takashi Iwai wrote:
> 
> It should rather select instead of depends-on.  User can't enable
> CONFIG_SND_PCM explicitly, but it's selected by the top-level
> drivers.
> 
> Also, please add Fixes tag.  It's a clear regression fix.
> 

Alright, I'll send the V2 with suggested changes.

Thank you for the review!
-- 
Kind regards,
Ivan Orlov



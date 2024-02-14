Return-Path: <linux-kernel+bounces-64932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CA8544D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780001C219D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8B10A3B;
	Wed, 14 Feb 2024 09:15:15 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA32F2F;
	Wed, 14 Feb 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902115; cv=none; b=lh/WZplEUMu/WTwBg1gbJuM/0Fu9zVgeorN9gJUgET8nByOXZM1UIxBnBVFsXf4NBenut6tYn4G9NnkQzK/D1ihk8Zw/a4pIJxkm6p8ooog3ve4h/XNZNQZmYhB7H+Fj4of3vlIS2vOWtZVzo/SPu0dNc4LnK2eACIc9qyVzn2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902115; c=relaxed/simple;
	bh=jYa1Lr7ZUtJC11+cRFkJLC24Hvdut98Q3M7Of/21KWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+O8yA6ke2X6wTNwJy2RiIVDuh9BpWk6Zy/OhqniwBxzXj1YKqy0EdyKCG41gzHX+Op85i+JdTLcFiw7ttOzvJLzHZZ9GE5mcmX37qmhrgvTHHhCCIElA6S9toowRDqpahhdDfop7zAU7R3Ieu2/SjOh+knk0IHFvr3MBmtT3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so268414966b.2;
        Wed, 14 Feb 2024 01:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902112; x=1708506912;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZRp3AjGt/6aArJlVGQphdXg07o3hYKoIqEKPDAJhb8=;
        b=Kh3ro8QreSUhzLUF0FcxAb8tIeUH1I5WloRxFedh86nLcar61JSA/D/bpeEEdxlxBy
         0BNhhY3Tvm3knGyIaWXhh3SeLfMIhBAxAIqFZ4WOPOEVNdxJIV+lDV/jGldrfEAZ8Hxj
         cuqLb2wFM9o8Lk4Gp+78GOtc6ZbOAI8346tmVCg934Ut+mK0GcBcluoK994dtvhETVeN
         VPo+0FHmP4cn5y9ACpdXQvHpMBz3zl6xMUUMjI7c+7/VRI+C/UVCVBHmo/BC4JhwPVpk
         6QDyu2xCNvPyhwj9afRV99B2e8nXbVhT2ZMkR0aOSxY9VSaYfHgF62icn2CqrVThLBmD
         At2A==
X-Forwarded-Encrypted: i=1; AJvYcCUbRerckN3rX3BWvUGJXZRW/1a1DIR9Ctgq20dZbZS1Gya24R9zoBURA982G3YDl6lJtwMd1xN7Ry87hAEsOWbGafUH04TvlusJQJNWg2y5LHlOXyUtOt1wYt9CfiX4xj2q/m6ZZzWqp5sn
X-Gm-Message-State: AOJu0Yzt0pr7tO2nyD/pIp4flr8HbqbCyWrHXs3+0g6r05Q2eCK1ilv7
	dXVLlAGJuPUefX+0wPw5yZdKsSvDwppbrbPNTWd0B8063vBeDdQV
X-Google-Smtp-Source: AGHT+IEmGiN8n15k8qmTNfQd9MvmpheI845EtDRGzy8SstN1IVgoAgB+d0JXaEwiQPJOL0N2eg0imA==
X-Received: by 2002:a17:906:fb1b:b0:a38:392a:8c71 with SMTP id lz27-20020a170906fb1b00b00a38392a8c71mr1352488ejb.45.1707902111598;
        Wed, 14 Feb 2024 01:15:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRQ1qxhvE9R+51NONBVfBWDqJAEIr7y0IjfENjT7aZsD7HaErTsNqAImJJbrZPv3V1oPPjgEQuhe37QYMO1fJm5cH6Nz6VYW0JmPiWHkEAHRVwCGJwxG4DKvRMXzjsFMIsESymrPRdcFI1wVwv86s2hKhUkAb3LcL+5KAgxeRvfHgnLh4F2tBvEvgpaR90lrrHDc+SQGIHJvzkQJTdlLDyUBo1JgDrOSgEMoF+LxRB4EEiDBKDhJRG6eitrn9ewTOJv2d0G08qOw==
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a3d35bccdf0sm566236ejc.139.2024.02.14.01.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:15:11 -0800 (PST)
Message-ID: <faf36cd9-00c3-4f47-acb7-64881f25d6d9@kernel.org>
Date: Wed, 14 Feb 2024 10:15:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Don't use "proxy" headers
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rengarajan S <rengarajan.s@microchip.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
 Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
References: <20240213193827.3207353-1-andriy.shevchenko@linux.intel.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240213193827.3207353-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13. 02. 24, 20:38, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good, but hard to tell if it is correct :P.

I like this qt-creator feature: "this header is not directly used, 
remove?". Maybe we could extend it to the kernel somehow (as it uses 
clang to decide, I suppose). As was shown recently, removing the 
inclusion hell can decrease the build time significantly…

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

-- 
js
suse labs



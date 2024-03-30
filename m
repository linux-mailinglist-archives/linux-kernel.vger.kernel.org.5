Return-Path: <linux-kernel+bounces-125716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA4892B06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190FD282F57
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4A1374C2;
	Sat, 30 Mar 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doc9atA2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921482C698;
	Sat, 30 Mar 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799913; cv=none; b=HvQY+P8B/rW+aqK70pZ3+nWrLgXkn1xpx/ghY/3bZ39PzMYVB1D/42d+UNh5XGtwP+MxwENhtIfyS/5Kh8c8L7WeOr+aa48irM9VxxlXJWpOp+fSdDCf7oCXPs+pl1HC2GCSJvaJdgr9OhFx0WRH4xlOW+mX01xPvZelWV2dO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799913; c=relaxed/simple;
	bh=TbrIO4XyQEd+k39NL1nF1BZX16Lmo09f878RPERjTjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUl6Ghe5u91L22FfFV2DAopCkne0ZKrQ7OmbswIeg2Z9OpAmt583DqF34V1WRLhT+FpleaS5BoPrgndCBeNpInuChhXmg5CLULDC3e7FOufsYpq2hpSTPN5tYKC3w4Leb7RSHCLoRLsc6lP1OSAs45N1Bj09O8guy5CfbITpcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doc9atA2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0000cdf99so22805895ad.0;
        Sat, 30 Mar 2024 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711799910; x=1712404710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PwQxQ55Te/E+L+J8NXVNW/6D/jEVDpLbVJSx9S8S4Y4=;
        b=doc9atA2gzb5M5MgnMrt9Oi5D/4o0YMGM210rv7cDBEU4BC/E4JD6+54FP5Yp6MNPE
         3mAZogxF/LlUzh98fpzbPBi8OYbPod5m0M2F956wZ7J/WyGXpUGxlOxl6U++Dw3RYAJW
         L9evEWaPbTnLIYV7eP3eGeCkEEefrr1QX6r6HspskQR1I6lkaa2ZLwdOO6ULRIHLkytG
         DoJAzu7uKxueYaaawa2UoCT0MJxXAaLLrgM4GoUgheW9cMjs5gbu7pBYZWxBbylCWeGb
         WY9ObJ2ZiJqxQoHc4BSwjy3Bt1qLLMOzLCB34toJD0aLeO65sa22QwqKmd0b51Yp0OGb
         YgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711799910; x=1712404710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwQxQ55Te/E+L+J8NXVNW/6D/jEVDpLbVJSx9S8S4Y4=;
        b=m4iMlFxLshF2Go4p27kd5FWg6DjXS+EnEkkRIkw+LTey8KlZCTyd9/uWNbBEqJxaul
         jiYvPT69u7f45tEOU/vw3hAPCRFKNEd0gBAjSJrJNaJDa02aGqXuGY+A70mY7S6u3dNt
         7dXEqQcAvYW9JH7S6D1L+n/buuTloDPHw2f27kaWnAZ5isp1XUi1az63DK4IoXTdSqLO
         E/0kmHNCCKT7T3pgs7FXR3WCXF0K/9J3fnr9cLXq+GJSdtCBJe56Z+hdQ2xeaxSdxu0K
         DNF+f6IkCjVACATyW6Jb8c4z+Et1Qs62/cRbKVTt0L1+NGFoRkd+8FHWpZPg4kpnR6yw
         WTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3EGtnnL/zRNDBl776RDHSKKGmNT1HBKzjysnIXrkZMiTC6ou/JQs0dj2Z/w2QACQ5Kc1cdBMhOEi4FnRKUFYLKKh7l3/ZIOmxhC9p2GcdCgDa0dNdEw0qbrAE0HcjwS74vpTWYktt7zP551zdT/jvN1wmV8bDlgTAL76rHXLqt0ATBtpEzZBXOuR2g8zO
X-Gm-Message-State: AOJu0YwHls4WVl+bhhCaloIu1LVDTQysDNoQg9qIV6H/iNUFVigOVmDN
	EqYRC7m4+TI8JcXYg+gTcyOyK+orkH9W2b51Rl7O3a2oRT4b0RlF
X-Google-Smtp-Source: AGHT+IHrYNyjcMgK5FhmudnvORBQefKqxDQMsxVQF8C+iKAKnfJnkfnykYUBBuh6+z6XgGVoPV26JQ==
X-Received: by 2002:a17:902:684e:b0:1e0:ac2b:44ad with SMTP id f14-20020a170902684e00b001e0ac2b44admr5114698pln.35.1711799910247;
        Sat, 30 Mar 2024 04:58:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001e0b863b815sm5107145plf.96.2024.03.30.04.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:58:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d49ea735-3113-4c1f-a8dc-c6d8e821c4f1@roeck-us.net>
Date: Sat, 30 Mar 2024 04:58:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
Content-Language: en-US
To: Maximilian Luz <luzmaximilian@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240330112409.3402943-1-luzmaximilian@gmail.com>
 <20240330112409.3402943-2-luzmaximilian@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240330112409.3402943-2-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/24 04:24, Maximilian Luz wrote:
> Some of the newer Microsoft Surface devices (such as the Surface Book
> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
> Module (the embedded controller on those devices). Add a basic driver
> to read out the temperature values of those sensors.
> 
> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

I very much dislike the idea of having multiple drivers for hardware
monitoring on the same system. Please explain in detail why this and
the fan driver for the same system need separate drivers.

I'll also very much want to know if we will see submissions for separate
voltage, current, power, energy, humidity, and/or other hardware monitoring
entities for the same system later on.

Guenter



Return-Path: <linux-kernel+bounces-30465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D11831F06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0A1F2293E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5F32D61B;
	Thu, 18 Jan 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR35nO9p"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAE2D603;
	Thu, 18 Jan 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601875; cv=none; b=ZzboiFVIviqeQ+sg1+uuJcczYfDkZ+rmpwUHT0Q6JW0Izjq8f6FbHbnjGEZ+piQvxLeRsyBrxS0WpYScysZkWLsAIHnhWx/8AkiIcyB75PYWBkCj56a1G04vuyYGQjTDbUl/OskztzjGOhT6jjJXMFsoj1kWNbEBSf1Pp9vTz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601875; c=relaxed/simple;
	bh=GgYxmDgNgkRKqRQU34wt4wjvEoRSOCZom/wFi94Q4D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orjqcYYqWspRjx4PmCLVx2KEYJ6Oo4VbvpK6smY9DJDEAmcgBVnZaX3Yk/DmFWnVB5X9t9X2EMRSpHMwD00Qy7Q6U8WspfH0/CvAvrjO2bU7eGMu/3bY7S3dvHjjHN6t5DFT0AQXxVnc8HeNfvP4PinK21Eb3ISXrpe1TyJRc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR35nO9p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d480c6342dso95683475ad.2;
        Thu, 18 Jan 2024 10:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601873; x=1706206673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pl7+ELVBzjqED23yow1i0CKbGM/yfHUEyL86AcCYaaE=;
        b=fR35nO9pz4OESuPNSQmonKv27mwiaLlzi/M0C9HIhBI/f+OBJ3cUB2CEFLvjh7Yirb
         MJymeHxZKl9nhtSvpYK4T5EWFTag97/hloyW9H6095Etp3XdfVMJcoGk4Cn+dYw2gKfD
         6Azg0XWTsfmA8bY4maHkqe45s+5JoXMH5Fm/DSJ8kT8H0tt4EsxOXzXjh0DJ0F01ZrEK
         3zz0Sa9Oq/0aWwqFTqa2B28dd3rj83JBw6209do0xLFNxj6l6llqOhyUt7TVf+RD6/pX
         +m3us4SgEb6/uE/+9vgw19Ox3c4DKmjkSc4ZBVPEqdPCWgY7JxU3MHYMOCM6kDRR3YzZ
         uj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601873; x=1706206673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pl7+ELVBzjqED23yow1i0CKbGM/yfHUEyL86AcCYaaE=;
        b=m4MFQN5DODRx/EKsqYnsUVNXWVBZPTYumZjx24GZZHLoSxv+xYA7m4FqBkEDvnchxk
         hsVcoYUzTjjE+nxmAhB1kukGr96+JthNb1tLeO69uyS66riaC0cKQv7pxZ8SMsobNDTK
         FmLjs/xUWXLoaucaN9Ld0jdubVC3h4nCsu72DpL0CsHHpbsV+HeDyMm3yXLlv6QfJjzi
         FLZPpqbOzOl9I0cJNJOv7uuaM/LgzPEo9QLxyaY7L9PhuEhUakFNXK+vm1dfdB2ULaPw
         oqhGzv5WG8RNxhcnPfjaPNMJN8gLkwv0dsIeUf1qhLB4/h4dJbYUzAP/7BUQz9vtSIwh
         80Hg==
X-Gm-Message-State: AOJu0YzbzT1DQoKINUCnpiH3E46T+qMveuwVRv6ewggy9Yc8es6sRzu9
	Ijgct/FL8vUTSaVQWyOpkGlfl3kZomnL/EbittGeo1sVBw5hUbUWV+YDvoGP
X-Google-Smtp-Source: AGHT+IFMKI/LJ1WWtT5pUFoflRfr9kprGoJjufAe4mNSBiLITfqi6LyetPhEVUTBOtx1ja5OK7fypg==
X-Received: by 2002:a17:902:f68f:b0:1d6:f27f:2b51 with SMTP id l15-20020a170902f68f00b001d6f27f2b51mr1463192plg.8.1705601872925;
        Thu, 18 Jan 2024 10:17:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170902f94c00b001d49608e3dfsm1687324plb.50.2024.01.18.10.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:17:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82563d8e-5987-4a1b-8265-22d20f8d6902@roeck-us.net>
Date: Thu, 18 Jan 2024 10:17:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: watchdog: Add ChromeOS EC watchdog
Content-Language: en-US
To: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Radoslaw Biernacki <biernacki@google.com>, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-watchdog@vger.kernel.org
References: <20240117102450.4080839-1-lma@chromium.org>
 <6b1190af-7b28-461d-bcd0-2aaeb0a1fa38@roeck-us.net>
 <CAE5UKNpLmN0sKktML1+hEzgRkHKS_X_wv==MPV8G5djeG+B9FA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAE5UKNpLmN0sKktML1+hEzgRkHKS_X_wv==MPV8G5djeG+B9FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/18/24 10:08, Łukasz Majczak wrote:
> Hi Guenter
> 
> Please see my comments below
> 
> On Wed, Jan 17, 2024 at 5:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/17/24 02:24, Lukasz Majczak wrote:
>>> This adds EC-based watchdog support for ChromeOS
>>> based devices equipped with embedded controller (EC).
>>>
>>> Signed-off-by: Lukasz Majczak <lma@chromium.org>
>>
>> checkpatch --strict says:
>>
>> total: 0 errors, 0 warnings, 14 checks, 455 lines checked
>>
>> Please fix.
> 
> ACK, Although I would keep uint16_t/uint32_t types in
> cros_ec_commands.h as those are shared with EC firmware.
> 

Makes sense. Thanks!

Guenter




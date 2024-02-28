Return-Path: <linux-kernel+bounces-84733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8A86AAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699421C20B22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A1E36AEE;
	Wed, 28 Feb 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yt6KK5zG"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F8364CD;
	Wed, 28 Feb 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111044; cv=none; b=gogsuJewB+vE6aMfVKp6iu6ghnAbJRzCPPQPn7lbXb+eu7QR+7YxjJgN+bnoxnJZjImfnlHY7+3myhKlUwzEebETC+MYUsW2oCryEqhXmz3FmK2mRQS0VoPaUKc2WOPHuaqmqGdbw7rbYmgIyvYA9KN9uYzgXtr5Ny//eInL8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111044; c=relaxed/simple;
	bh=CDCmmBveuUqNZJ2apAV+ihYwz534BZMsrY3cmgntKqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZP2I/Zm1/78/0w+ZQvH8ebGTKBeSB9RqyFJgem2VimgM0I0XV+zZ/rm1FEP/9jTwQ/Eq7n/gCaErNrnETaOzwe6ia29hsj/Uqgat6RVZmF5rvryS3hasT7+dKIwp39CZW5FtC3Crw74aiffb8S2P07bz2dXS+bQ/gZSkLoxVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yt6KK5zG; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-595aa5b1fe0so3504223eaf.2;
        Wed, 28 Feb 2024 01:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709111042; x=1709715842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FenSeDhx37Fn4h4rPIP/X4cfvW1ZC8JOsi6cnZG14Mo=;
        b=Yt6KK5zGoZE7sYHcW8jKLHSAQJ5s9V+YMXNVggmlToTSTj9UpQGMQP3jn33BQfKX7n
         0hmAyx/qD5np3qL+9+2rP7w+wzA2YjZHCqLgpWIR0s9x1QFW5VobRCPtgYGNjAYOpPRn
         7e9/lbeDZ772Cs3lBj3F3t21esUXqGWbg+pT6+5dGnAGEDfW1ok1jILUsBCzulmW2Wtm
         00rBdCX3jSQICp84Cek9znsvJmJUBORAsUs1L9KmPeOrccX4wwliRnbbrYrKKfbZV+14
         lTHa7+XhNrYgBPS0ZoCH04pdn2Pf1lFKxdNz2WlMlmS3tXxmUU6L4g+2P1rfpfi5bj/h
         CkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111042; x=1709715842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FenSeDhx37Fn4h4rPIP/X4cfvW1ZC8JOsi6cnZG14Mo=;
        b=lLpRMoMES/F1LW2MDcUTZhmo2FFgxLWa28SUvSnkM4I+MpqGQhWer82apyDzkBc6gJ
         I8FApqZPe5SwGd3JSKiAA+wV1fqPN967QVF3kfJRWHsZynV+Ej5wnzYk7o9bXWQTl2mz
         Ttlx4dxzaugs4KwG9BJtsG5gwxhyKxYSOiSlhF3V3lNzaogPmZZwafXHZNtPpIWpJN1Q
         BdUH7fvyLKjUq8nDtTtRct5hFJx6DlCdbEYRGKr84cQgL/ja4k5jOFuOAnf3KsFOzc3t
         GePk8P0/Xw/obsz4TmwMCGkgSjXe4G5FxmFMgaCQMP0LTpBIwq1mI+vL7tqHI7pGeUlp
         BO7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ij+jiNZFZ6I10S/RY4JdVnOVkQYaNr8+4iwPl5NjEFg15g2wdAVE78dY1Cio/bClm/094BBWT5cJEX9k5VFADqxcmskfyDgNrl+WQcYmB597RuJNYJ7doTcCUbCtSnLirD0E11J+gikn8vWms4HgXennNwXvMjDzB/fQ62LZj5Q2OYsvMxKgQleZR/dAG3aMW83UsyVmxjjyDZF7k40m
X-Gm-Message-State: AOJu0Yw0zycz8DCZ1RMaewjV3KzrbOCtIFxaDFy+0gKUFPWTX7hy0SpE
	NaSs77E7lUk7uxGryM/W9yNWLf9dIsNglKrBy1mLiTtSHJoNb3B3
X-Google-Smtp-Source: AGHT+IHnRve3OtpyuvD83WrEZqqI1Lk+ep0Bewe4MemDLs++I/if9YlOf41NMMKqP5ugfkes2LfgHw==
X-Received: by 2002:a05:6870:9625:b0:220:15bb:ba43 with SMTP id d37-20020a056870962500b0022015bbba43mr9037258oaq.48.1709111042263;
        Wed, 28 Feb 2024 01:04:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a056a00098400b006e5619b2f83sm874654pfg.7.2024.02.28.01.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:04:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4b06d535-6739-47b5-ad1e-0ff94322620e@roeck-us.net>
Date: Wed, 28 Feb 2024 01:03:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Ban Feng <baneric926@gmail.com>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
 naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 23:57, Paul Menzel wrote:
> Dear Ban,
> 
> 
> Thank you for your patch. Some minor things from my side.
> 
> 
> Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
>> From: Ban Feng <kcfeng0@nuvoton.com>
>>
>> NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
> 
> Please reference the datasheet.
> 

Note that something like

Datasheet: Available from Nuvoton upon request

is quite common for hardware monitoring chips and acceptable.

> Could you please give a high level description of the driver design?
> 

Can you be more specific ? I didn't have time yet to look into details,
but at first glance this looks like a standard hardware monitoring driver.
One could argue that the high level design of such drivers is described
in Documentation/hwmon/hwmon-kernel-api.rst.
I don't usually ask for a additional design information for hwmon drivers
unless some chip interaction is unusual and needs to be explained,
and then I prefer to have it explained in the code. Given that, I am
quite curious and would like to understand what you are looking for.

Thanks,
Guenter



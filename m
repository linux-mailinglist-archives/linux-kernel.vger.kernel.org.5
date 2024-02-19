Return-Path: <linux-kernel+bounces-71947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4B85ACE8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ADB1F23EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1483F5337A;
	Mon, 19 Feb 2024 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAfrnbQy"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FE535A4;
	Mon, 19 Feb 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373724; cv=none; b=BJRHYP3YCAY/KwoB6sqKPYi+fvLiJh1z76xdNelcM1KKfXPkO7Frfurx650BhPVuio0WN8dNFFQeo3sfGqtqApwbgpQZuTk5OaFJQHXw/ZXbxoGso1JgaEo8THTi7Lub/l4t1rPczwzacAqLfFlD3W86cpfil0bdwLrRpP4re78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373724; c=relaxed/simple;
	bh=1i5Z5tmkT3Ig7YFX38izakWgveapzbBQPWyZs2wxtg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajgbZvX7849DcbDXi5grajjimi70AzKHhO3k0Lf1hFNIsgC3ojVnY2lxi6E4bxzKXzt/6pvai66wjSm09aB24Nbs2u7sjzyBdARS5hesI6dh7rFGkRWGYmhf74d8qn/qTU1XyBWVsS+yr9jeyKTjBoIFU+oeVbSuobHLkorkVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAfrnbQy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d8aadc624dso36527655ad.0;
        Mon, 19 Feb 2024 12:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708373721; x=1708978521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/xxPCmI7O5Vn7789fiRXPJc1b6HMLkN+s1b1aXSSnc=;
        b=VAfrnbQyOGDmy53TEjyhU/zSz0Ov0TxBJ2shtm6Qnri+6tu4On0v4+g/aQ1+m9ao+A
         op0gCrHpb6HOSaE+lhqp7ajosE/vfFybv6qTqKUUei8SANt+/WOiqIiLzWDR1/GQ5AwX
         unSKTw8V+Zb77J8CWXCamhwHadwkyEyzz0/WUdCaqDiVv3r4/BwqOD4QIOBLY8TyAEDf
         bmhGSFqRryCnceEmjYD5GGH7j2pWQ0gGWOSxpIEgElU4XfVTZm0chOVMZeeEzbIbdDQU
         lqfWy2ovxxFDCGMqeMP4EWtxb1pKPRJp/1bbuVx1i9TBXRLl+T56NeyFSNmIqes32vhB
         wy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708373721; x=1708978521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/xxPCmI7O5Vn7789fiRXPJc1b6HMLkN+s1b1aXSSnc=;
        b=V+u/9NUCxuXOr1k88XDawBn6rIsb7b6R/0CuDKCVBQK3jarbsb93tYcNLtUr++KQPT
         rD4L0+EL9JQVmOiIvV+frP3aAUBGEi6Sfqo+AyEQ751wHMlI2wxII5dc25gUpNrdD+y1
         0QENlgABm43Kq4av9S8S/d6iat2v5PXXvn/QmKtC6VCJHIqMEky7tAvsKbTPvO0OM/FM
         hk8r+A2iRUWFc1VTIiCYYNrS9y/7+lNBt3wl91csqir0MstsFKNmUTTvHOis8+aL3miA
         LTzO9VlludWR89tI3VpxM5/QopAtoIEOSRus5ByDPx6oFa3x2DCF5fSZrVgRkf1doT/K
         Fq1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkaOAIRTJlBk6HLW5DhIO7ZoV7+sXza5CBFsoshGj2S5AbYsybNO9dDm/Dn1vYA+GVjmyH9iOY7jTKpxNNjnZ40StCRsAQcbaGx+H8jZA6maJFCsMkLZKy5ECrULSmYr45bcQ1
X-Gm-Message-State: AOJu0YwQMC9YYZusi7H6sucDP4MJyeaIgBhLGqKfAodWzbafOqvKD79W
	QZz7SOrqQEgiZYH3Wgf0wDtgnZAvjllB6YDXfXxSechsA0FJWUPt
X-Google-Smtp-Source: AGHT+IEpO+GHLkKDBAojN5FR0yUgTMzo10k4wmvfWA//iAi00Ai6VbMt36aF+ksXmxrSrKDEZ39mfg==
X-Received: by 2002:a17:902:b285:b0:1db:e089:7461 with SMTP id u5-20020a170902b28500b001dbe0897461mr4615033plr.31.1708373720938;
        Mon, 19 Feb 2024 12:15:20 -0800 (PST)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jx7-20020a170903138700b001db68cf242asm4808036plb.49.2024.02.19.12.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 12:15:20 -0800 (PST)
Message-ID: <a1f90d66-fee3-4c03-a04d-0d6c91ce5256@gmail.com>
Date: Mon, 19 Feb 2024 12:15:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC PATCH 6/6] net: phy: bcm7xxx: rework phy_driver
 table to new multiple PHY ID format
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Robert Marko <robimarko@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Puneet Gupta <puneet.gupta@amd.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-7-ansuelsmth@gmail.com>
 <6146eb3b-720a-4523-bcc7-8e2656aeafef@gmail.com>
 <65d384ab.7b0a0220.15279.bf48@mx.google.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <65d384ab.7b0a0220.15279.bf48@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/19/2024 8:41 AM, Christian Marangi wrote:
> On Sun, Feb 18, 2024 at 08:26:29PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/18/2024 11:00 AM, Christian Marangi wrote:
>>> Rework bcm7xxx PHY driver table to new multiple PHY format
>>> implementation to reduce code duplication and final size of the compiled
>>> module.
>>
>> I like the idea of sharing as much code as possible and creating a smaller
>> module, however by changing the name, you are creating an user-space ABI
>> change, we rely upon the exact PHY name being shown under
>> /sys/class/mdio_bus/*/* and this change will break that.
>>
> 
> Thanks for putting this concern on the table but isn't that generated by
> dev_set_name and PHY_ID_FMT? from bus->id and addr?
> 
> Can't find reference of the name entry in sysfs. Am I missing something?
> The name seems to be used only by logging to print info/err/warn.

The name will appear under /sys/ like this:

ls -ls /sys/class/mdio_bus/unimac-mdio-0/unimac-mdio-0\:01/
total 0
      0 lrwxrwxrwx    1 root     root             0 Jan  4 21:27 
attached_dev -> ../../../../net/eth0
      0 lrwxrwxrwx    1 root     root             0 Jan  4 21:27 driver 
-> ../../../../../../../../bus/mdio_bus/drivers/Broadcom BCM7712

it might be OK to change the driver, but I can tell you this is going to 
be breaking a number of our scripts here...
-- 
Florian


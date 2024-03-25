Return-Path: <linux-kernel+bounces-117267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A898988B355
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242DCBE539D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D40144D07;
	Mon, 25 Mar 2024 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIN/Py60"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C001B84D16;
	Mon, 25 Mar 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377357; cv=none; b=qc6C1gSBfBiREh2NSAZDsug0pSnyYs8aF5MP8kWxptkY8IZSMbP3ZGwdHf2ZG4TKe2bZe+fvHeSYKROPoNgBsF9l86SEtEuvkvSA801YiM8tvNwTudPBG/Fy7Dz6+Ys29DKV5BjziJ9rQnLyMo4A5n4PXrwOb9Jlj5AVR//dUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377357; c=relaxed/simple;
	bh=AbHZtja0SfpTRJx+PiD9hfunyx/nel0n7RzJrByWg84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHloXf3M/V5uxCJBbpWrddvOcqRxq+UH2QhjrCqHQpr0z0lcySI9XT9zGH361DDIXYIa7D/w3dSKwjMSjr9hA7/14ISefDQVHAXPl6GJCocoUgMT4hxuGygQUJgDNmz2F4uUqyJIZXXxdk61fc7N7Zp5jMrxRutl54MId9zZ6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIN/Py60; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b3dc3564so3029215b3a.2;
        Mon, 25 Mar 2024 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711377355; x=1711982155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9UnRs5seYg94xdXWV3gWSOHnc92e0KgLqhx9EnRpkDY=;
        b=YIN/Py60kXwvuQFQWvtpINuT1VsrwTIax+YuIRwcVjS+LXPKU9BVI+NSLtJRDUi6Zn
         kxL9+PiRAiuvZyOpGEkx0tnxS8U7hgKLvO2E7ypmsTo6XKP9z1V2Sdt2blt5ZgUmGHrf
         eo6dhf9cIFpKVdc9tpgoh4du2Nbu4/xfTbjOw43QbuQrIvfDD5HA5DvMPHUjGy/WstuL
         2xDBH/VlLJcdiwD4xbr5diwl/VdjXN1XgwNnYiHnc4QjYUqCe+Yz0bDdplwnyoQlt/Bb
         OLyx2PN5dYRsSta7h5VDVNQCmGxzelMIGG9clcG+NSZdL/GIsCpnSnLrBda2+j+fqZ6T
         E03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377355; x=1711982155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UnRs5seYg94xdXWV3gWSOHnc92e0KgLqhx9EnRpkDY=;
        b=fgAzS+6vNWmQP7lHXHfPSB/MxrTF6bQ7wAeq8zU3DnarQS6wQF+6KrrNxXmsy+nCpT
         cpvQGD199xHWf/FsB5zotqcTVM2BP9wOLdhN9dxAciKdoD7xllOaJazET7FK8IkvQWNn
         A0e5mpEfpjBnRRk69JlxatPBeGi8LL+9nfpAXzO/Tj01+ih7v9+eCr6242aB4RY3ItyN
         U3ZCinucrQGM61J376XLl2L1js1j7l7x8ZGzid07sHH9R9mggr2ADbMbe6e/KWOfLR0K
         gl667FHa7vPNZxfOBt1veHa+THIUq7+/2obtj2kJ9W8NzmkCftHFDdPzphMdeJKsB/CH
         JOqA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRZv3mnSF0KLlIr4Jg3YgduJ2VNbxg76kCD1G7yk/t/Wfy46Z913fUP/c7hMpGsFBApnlSC0fiWhzr+FUegTQPAEKI49DKr8kFPKSlB1nZFUx1cIhY298yrdFBchRF5nwDs87zAMV
X-Gm-Message-State: AOJu0Yxo77j+sbeL1Zw6bGjwkMNxSF2KNJ+UsF5lLhdkqYGjHU7LhfHv
	x2IJ8irk/5epkILlcpN+e70eZiE5m/jjJY4ONNJlrN+vXVFbfkJH
X-Google-Smtp-Source: AGHT+IEa+ZkcOdbdbwJM1aEnn3Dae7WZs4v6LnFs8Lbizmo7ZGDcJGSF6PqLH+DkayLKNL4PXd6PsA==
X-Received: by 2002:a05:6a00:938d:b0:6e6:970f:a809 with SMTP id ka13-20020a056a00938d00b006e6970fa809mr7793224pfb.20.1711377353470;
        Mon, 25 Mar 2024 07:35:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x21-20020a056a000bd500b006ea7fbd484csm4153823pfu.192.2024.03.25.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:35:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c2e64b7b-09e0-4c0b-838e-988e6a7bccbc@roeck-us.net>
Date: Mon, 25 Mar 2024 07:35:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo ThinkStation
 motherboards
Content-Language: en-US
To: Andy Shevchenko <andy@black.fi.intel.com>,
 David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
 dober@lenovo.com, mpearson@lenovo.com
References: <20240315115810.15816-1-dober6023@gmail.com>
 <ZgFuLbBe4y1OiRqY@black.fi.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZgFuLbBe4y1OiRqY@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:29, Andy Shevchenko wrote:
> On Fri, Mar 15, 2024 at 07:58:10AM -0400, David Ober wrote:
>> This addition adds in the ability for the system to scan
>> the EC chip in the Lenovo ThinkStation systems to get the
>> current fan RPM speeds the Maximum speed value for each
>> fan also provides the CPU, DIMM other thermal statuses
> 
> Besides the compilation error, see other remarks below.
> 

Thanks a lot for the detailed review. Dropped the driver
for now.

Guenter



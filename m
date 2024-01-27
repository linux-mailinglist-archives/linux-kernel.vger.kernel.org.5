Return-Path: <linux-kernel+bounces-41240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3F83EDE1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C51F22316
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7E28DDA;
	Sat, 27 Jan 2024 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bImckJaG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AA2560C;
	Sat, 27 Jan 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368981; cv=none; b=tgx+goqmWx/q/C6apXkxgnOo+iUNIonAjpdA1cuhylwDYiNAY7RIPogB98tqhT+cOwVAFUlUoLgOXdUv5YDqsQNOV5AbO2hGUHLTrdQhVJi3jAAfTjzSBcJQ6rON7bE2XaYAhsrluyfq5FbBLW+XROsSoTzNvpIE3cG/4uK4YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368981; c=relaxed/simple;
	bh=EJdl90MgoH5kBGjmSvI7dU1KGni89hqf0o2hNIdSJkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qexbuRK9QazClJpn/phk5J7ylPRN1a4YV0+3vLuKmgwHpmYfMkf8tI6rTk1Y4GQ2BXbdxKgKiMnju1fezKYmMu4PmsDb5Th2OBHkWys+ar7sqT6UytE9ElSEsxnfS6F5DeD0+ivo81gbiMntBr3fjOdO6Ly9oiL5ZgJWoZYLwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bImckJaG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7393de183so7076715ad.3;
        Sat, 27 Jan 2024 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706368979; x=1706973779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OkRiytXujd9Yjdg3qm1RPX8UuP6jqGHhK/jxzi2EaE4=;
        b=bImckJaGBWJOYv59BObfiql65lKjk2bNVmCQXts/MLMbtMk1hG31U+BIhamjFHmL05
         Hz9K5QWRv+TNL9pLr8AkDsSo4ZdrVkLB1REa/vHx1k3EZ+ajtDOltRp+PNN8zpbFldt0
         kfgO7H3d+1t/awPOCM8XZksoYJq7C7EJAYaBEiKuCcAq0/FXMPe5B6GAU68oQc7vtLfQ
         QESd3v+73JGnYe+p2jXPwRFGlDTB/ZjNie+G5j26K6ctOZA6hgX4/OZlFq4rAeEf9dUj
         KNKDGbX1ZBMkgrdSd1Txsay/4K7ZCEXvNPagNn2K/GbYKDloqF7C4Axpmo6GOWOb17ud
         owsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706368979; x=1706973779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkRiytXujd9Yjdg3qm1RPX8UuP6jqGHhK/jxzi2EaE4=;
        b=K2S8iCXxMQT8wSLEOsxZEQF06N1YXQgp58QypJpSC8PblqVFD6ckiPi8br8Iz/a6Ev
         pNqlKgHaebovQrYka101bjLjvGnzHTM00c55jgDJ8myjwtOvfB1yClehn8tC/oRMFVss
         jFhttahA80u6zZh8TUtdw9q2aoynczK58djwAZIxFd2PoRVaB3SkAeKjJFs9npLT0tTV
         Cgzqh3D8mgasUQdmIS4NiC3BjJlZe7vSUMCRQ0WKziKBE+4a4FqMr9pSxAWiZzWVD0HV
         4xZclzfkvHA9k4Y8l+4mfSOqGyvQUd3oR1tjuNo7Ia+RO48nhdKfV/Ysg6+XvslByG/8
         biHg==
X-Gm-Message-State: AOJu0YzCg0bfkMvhZMpAmgPiSl5xkGnAaQOJjsTodfwjp6BNC9AtagFH
	xzmAVAegdiHTvcxMgRsDMvU0UY/64lkiNuJm5SFk3OOnPf3kJUz5UJychPkV
X-Google-Smtp-Source: AGHT+IFWQNZ2/QVhbd/vkjfNOuLauINgVdFHp9HGjwtFlXLozkbVRE+TTej2IVQW4hlfb4LEgehC5w==
X-Received: by 2002:a17:902:784e:b0:1d5:7cb:7761 with SMTP id e14-20020a170902784e00b001d507cb7761mr880456pln.51.1706368978581;
        Sat, 27 Jan 2024 07:22:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090282cb00b001d7505fd14csm2546520plz.215.2024.01.27.07.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 07:22:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <33da3135-4450-4c5e-92af-0d361c3b7489@roeck-us.net>
Date: Sat, 27 Jan 2024 07:22:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hwmon: (pmbus/mp2975) Fix driver initialization for
 MP2975 device
Content-Language: en-US
To: Konstantin Aladyshev <aladyshev22@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
 Naresh Solanki <Naresh.Solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240127092516.1641-1-aladyshev22@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240127092516.1641-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/24 01:25, Konstantin Aladyshev wrote:
> The commit 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
> has introduced a bug that makes it impossible to initialize MP2975
> device:
> """
> mp2975 5-0020: Failed to identify chip capabilities
> i2c i2c-5: new_device: Instantiated device mp2975 at 0x20
> i2c i2c-5: delete_device: Deleting device mp2975 at 0x20
> """
> Since the 'read_byte_data' function was removed from the
> 'pmbus_driver_info ' structure the driver no longer reports correctly
> that VOUT mode is direct. Therefore 'pmbus_identify_common' fails
> with error, making it impossible to initialize the device.
> 
> Restore 'read_byte_data' function to fix the issue.
> 
> Tested:
> - before: it is not possible to initialize MP2975 device with the
> 'mp2975' driver,
> - after: 'mp2975' correctly initializes MP2975 device and all sensor
> data is correct.
> 
> Fixes: 1feb31e810b0 ("hwmon: (pmbus/mp2975) Simplify VOUT code")
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---
> Changes in v4:
>   - Correct comment inside the 'mp2975_read_byte_data' function as
> suggested by Patrick Rudolph
> 

I already applied version 3 of the patch. Feel free to send a follow-up
to that patch. It is too late for a v4 of the original patch.

Guenter



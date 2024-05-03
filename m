Return-Path: <linux-kernel+bounces-167707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9728BADBF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3051A1C22226
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64315383F;
	Fri,  3 May 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzbAi4Eb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F914A4C6;
	Fri,  3 May 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743175; cv=none; b=s4UupD9J6jJNcP3GjH1/1J8oYoyiLp+VPcdMkxOgW5O299eOTLW1tEKrSMhWcZtcjf4yCSpN0rAtbCxqp/lY3CTasTsZNSt19G+Q1+UBwOur1pEKgqCp7JHwjAYvJhRfU4AwJPPoMVQQZeXzNVJv22HocKusJxVbejURRujBhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743175; c=relaxed/simple;
	bh=g5n7QCf9+px9E+jSdSAUEDniUMyzo42eFpqV0QKekZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQsuffRZMe9BvciX69YNBQMevPup3/fpdodoRNT7SK40Av6bVPrWenFxbiP6dKlY5rfAC/qO2b3/TgPDiJnzKhfXrrnKjatvZ6x/bkSPf3hUwXC1IF28lB17VJTAyWir0amnj9R5PIVZrHjHhIDSEjPO8mPvz/pfbb3K1kriz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzbAi4Eb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso75993405ad.3;
        Fri, 03 May 2024 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714743174; x=1715347974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R8eBo7KEbkwscKOgGEHDnJ9t9WjU5dMxa7aVsxxtx3Y=;
        b=RzbAi4EbRja4fKAbM1mEM+/6QGkaXtewXjci4pulYuL0Ydi7ZWNFqHYqzA4Zrl2br+
         wPvmWHGB/BgZYpS6/1n9VAkcdlOSDiqS/m2JG5yzfqX1w9vzQi7yh23+DgITJLBcor3N
         2oC9AwhNZihDzJFCHjnDH3l1Q/3sJvI2wFnuzFPyXuPfVu3GV5/uW5H8lpZNK2UCQZD9
         nzYpJ5nlMa8Igh3fGaDPnXAe97CAiE+kgBgjXc2AcMJp3IXZjPuB1bNIBqvXHt11YgMS
         Ntgw4FRm8IHD/+uqZ6IrFEs5vVU66OLkbPndHDzq9fqRS9obwfvA3fZLixw66uY1XN5P
         cyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714743174; x=1715347974;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8eBo7KEbkwscKOgGEHDnJ9t9WjU5dMxa7aVsxxtx3Y=;
        b=oAxhEZxPeuttUpJBi5qW7wXoSQxXilRtQXb798tWEY62ySrJCXN1xqwZ0vgrv21uuN
         iyoYPeJWXjVwe8Y4n7kuE2HDEEWgnsk0vMc2JCdjiSGBSFVerfqokWQTtgZNAJyETwxI
         PNidV/Ot7rgxcQJ3MAwwuLtGNPSa5tgacREz+r6WQjy4M9OauHFGNAIVZgE5RV7KXCpd
         WhH5Ur15E2vnmCP1ZxfXxeQXE4S6Dt0nriH6P2ZriGFtnmwxSh3mq26wTFGjWADmpNsJ
         kCfye/ow9FPR6LpX3/pjJtfFOhQZGg2HmRXUWLcbpjTWw146ybjAVeBI+78VGqQJjpf4
         LimA==
X-Forwarded-Encrypted: i=1; AJvYcCX9YtvtlVtaEVlBuP14tnvmWYruGs3ElDB/UipXfuvM5emJo7aONDsbVtR+D36lCd+i4+ZoLoH0dpoYxwTDOcyiyAKrZWG1/0GZUAFyqeLdvqm3zPGZVxiDGUPNHGH7C+pinLCLzhpLNMY=
X-Gm-Message-State: AOJu0Yxz6xSVJlUGoEfGS86FMK9TSroi/CVq6vPpvGx3LPxvjEPBEKt3
	KXlz5PS1rbybPxsqjkuZeEvJriaMS/g8IQqFbXypb8bs/FsIyx3D8xAvfw==
X-Google-Smtp-Source: AGHT+IEhxwVUnKSTzJxiJQV1Ec91RIMddC0qhAgrXfH0BVFVt25VKe3hoStVAzDk2Elj6s14fsUdJw==
X-Received: by 2002:a17:902:ac98:b0:1ea:274:756e with SMTP id h24-20020a170902ac9800b001ea0274756emr2491611plr.21.1714743173546;
        Fri, 03 May 2024 06:32:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kt7-20020a170903088700b001e862f0b319sm3223834plb.264.2024.05.03.06.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 06:32:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5c6a02cc-76d0-4004-ba4d-544cbe767fb1@roeck-us.net>
Date: Fri, 3 May 2024 06:32:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RTF PATCH] hwmon: (emc1403) Convert to with_info API
To: Lars Petter Mostad <larspm@gmail.com>
Cc: lars.petter.mostad@appear.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <521c0829-95de-4cc4-894b-6167c4f943a6@roeck-us.net>
 <20240503124146.220224-1-lars.petter.mostad@appear.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240503124146.220224-1-lars.petter.mostad@appear.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/3/24 05:41, Lars Petter Mostad wrote:
> I have tested this patch on EMC1438 (by extending to 8 channels and supporting
> signed registers). This has worked fine for me.
> 

Excellent, thanks a lot for testing. I'll send the final version (probably later
today), reworked to simplify adding support for 11 bit accuracy, plus a second
patch adding that support.

Thanks,
Guenter



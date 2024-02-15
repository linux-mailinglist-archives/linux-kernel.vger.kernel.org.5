Return-Path: <linux-kernel+bounces-66173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7185581A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F60284BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022C817;
	Thu, 15 Feb 2024 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyYCwzrl"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F719A;
	Thu, 15 Feb 2024 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955546; cv=none; b=GduJfJLbWaECRZrwdOWV/RCdlRTbQkX5XBWkMB3BLY36QAEZQ/gRumTRIBPhurMRcx/SwM19tvG6AFDkxlaxZALplr6YMexyo/YCKUMzD98bgIpDd2J+pKoHKt20JSxrC22MAMqOW6rqY+B5v6P9aarPe8PmiDvlg8uSej8zMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955546; c=relaxed/simple;
	bh=RyT0hAFnyZXFspK1xF3WX3kXpHesaIlud3qAHvWfYQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AalmuE0/7ECz2MxrFqWfK3hvd8V3lJeRh61hVIXodRnaIJHVouHzL9sXsxfpHAiyj99kKlTVi6VLXHTua8NoYeeyzZlR+UdWPNRU7reP19fW/GhvTOdCoK49LKIZIRhunAoF1ucwSlKi8EsOu2hQy7rgDoHyRLFCP3V4TVC6ejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyYCwzrl; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-785d4dba20cso21497385a.3;
        Wed, 14 Feb 2024 16:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955544; x=1708560344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RoGSg2VttRw4fae6dvJDXsrdDpNftzBOM5PYVXiVHg=;
        b=QyYCwzrlPqDYwZWDknwfByM5xU6oDRigoj6cAGfBpNCE+Jwmx4BDUsY9arhPA8ArkC
         kdPwm/KrygqgVAFSl/Raatd/6/4Io6hq4br1dJ1oGYVuZGoAn3GxwsXEsj755uOxTGVf
         eFyLwW6RC7mXed64uygbXctmRY0g7T39TkUCJjPR2J6Ki4WHFlgA1n6IIi5kRswY40rO
         dTnbnL2Jynx98TD4aAZZIrfeCvJYn8/eVoglrD8WxH0zY4cQcopXpDEdYOksjgOcGONN
         qTizpdYd7hTUwVd+yyAoO6e4SUCRDoGDuYCArGvb0nbrXuTR2ZIO2Asy22yDPu0rMjZ3
         kShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955544; x=1708560344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RoGSg2VttRw4fae6dvJDXsrdDpNftzBOM5PYVXiVHg=;
        b=mnsDLUV4t8PyJOjq3ec7thKwmntou3IcZzurOmdDm1EJYUdMxkFko/GNceLv8UIGf7
         c0iMtI8KpwgQxaJM7rm9ZgaXSeDyzTDaaWSYono1Rxd2kawxVoP0oBVxJ04GamDrDLvo
         n+9M4qTUgYeJ4OT7v7U3fj/BNHCHH3kz5V/lP5cGdhJnYwt7Icc3qcuLhJ/bQx99PDdQ
         QAXKbTjWxLKSYMGMSM4WZWNsMkENtHKOcDhxe/WIWUfjmRkpYJWbNYhxSAl17xLhGvpa
         A9E7sxW6ix+e/SWs4QXQxAEuYwjcyj2ykieYu/0gnkPR6tEb+2GLKddn97LlVf8xa3+K
         /SNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+jlYcMuez65xImd2v34MAPLaSMmKETfHl7D+sZmV4vDPDDbhd2VROYha5E5vgbtmBMTZqXHwVtDufc5uSKCIvDQTgSRKRqhuSrtVpReBVTOjiF19hF5ek5oTPncpAwJOUZYH
X-Gm-Message-State: AOJu0YyjZO5W4LvN+lehCkMzyo6h/fn8faF4yRJm+jhp84VqeCAFoVJP
	QC8fgBVCPU+uWzpnPLgP/7BwlFaG9yKyK27Ww7bDxuklMlZoXNe+
X-Google-Smtp-Source: AGHT+IFpjE8rZ/HqeC/vKl01yY1yV6zz1HzKkGi6yhJBnaiEDIrmnxls2pdAv8XI9iMUXxFwVbHNVQ==
X-Received: by 2002:a05:622a:45:b0:42c:7c3d:e20e with SMTP id y5-20020a05622a004500b0042c7c3de20emr310372qtw.41.1707955544138;
        Wed, 14 Feb 2024 16:05:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i6-20020ac85e46000000b0042c5ec26eccsm43286qtx.72.2024.02.14.16.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 16:05:43 -0800 (PST)
Message-ID: <1533ba43-c622-4a1e-b2f6-5ba0a6a8a1a2@gmail.com>
Date: Wed, 14 Feb 2024 16:05:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240214142247.920076071@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 06:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



Return-Path: <linux-kernel+bounces-7845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42681AE25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B537B23A39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87078F5C;
	Thu, 21 Dec 2023 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWpQE0/Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237A8F52
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2037ef59df0so52335fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 20:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703134354; x=1703739154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bz5m5ul72l4RhCvdkAAZDejQ0Cy9sHzUwoLbrF+jVCs=;
        b=KWpQE0/ZIZe0PHUnoHO0XzhADJujxKQGCrEEIiJcvvpuzPpkaJr2JxebOkM+Rrkopt
         RoS6DfRdA4r66Rnwr3xcogsXp2tiMiBoRIeI5C8JK4wu70CGNx7s8NL7fRoqha/mrW9V
         fr51hZ69Tj5k+x6qy1Bs9WDWZKe/e/1XhdBlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134354; x=1703739154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz5m5ul72l4RhCvdkAAZDejQ0Cy9sHzUwoLbrF+jVCs=;
        b=pDnqqWVdLDj/6WDhgXhHoW18Dv7MQ2ToBIRO+aVVri3F4eGtGLZQWBxIuD2JRhSrGL
         RLO70uvxBr/yiiAIRyeskLcrZaBVNKHF+8rWG3PjYpR8fEkiF6bXqbKLDm4Kjv/on/yh
         TslcSOdMa5NOb0oFctYkrbWuJBVVWCTqdSIJg4QBmI3F8m55OSXsjHtbZX230L60Gqbb
         mB/0ZjpntOhtWLUP5GmQh9IeCPnRoKE6XvD0PJg/qcpdCNUGhWiGWmctKHJEaQ+17Lqw
         BkECaOAjPXQAT9gNk6HtRf8Itf7pthdL4iNwPkAGfQ+v3jGkC2EPRbWrYkboWhgceKOk
         EiFQ==
X-Gm-Message-State: AOJu0YzZpjb2IvqoshrUQxCn22a5StGu93qx6+r3jfS8D6Y6HmZNumqP
	BKGqezjmSjnoBp9JqJOaJlCFbQ==
X-Google-Smtp-Source: AGHT+IFU6YIKltqtyRWS5Fq80oW1ZM2e2tj8nwLk0KoDFlFz6ocQhueT3KZ7ESKWk7sxooIZC+jWPA==
X-Received: by 2002:a4a:a581:0:b0:591:cdc0:f28d with SMTP id d1-20020a4aa581000000b00591cdc0f28dmr12232023oom.0.1703134354564;
        Wed, 20 Dec 2023 20:52:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j12-20020a02a68c000000b0046b70c98d41sm289714jam.26.2023.12.20.20.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 20:52:33 -0800 (PST)
Message-ID: <56301ac9-ca34-44fa-b18b-9c779fe9b24a@linuxfoundation.org>
Date: Wed, 20 Dec 2023 21:52:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/159] 5.15.145-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/20/23 09:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.145 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Dec 2023 16:08:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.145-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


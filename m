Return-Path: <linux-kernel+bounces-137752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E916989E6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CC71C21444
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6343D64D;
	Wed, 10 Apr 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+52ARJd"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3A19E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708413; cv=none; b=VRDk7+2cT5+A7qenxRdZilcm2XdiMiZBq5j6t2VYPtvhjMWBa6TIa/S8G4KTnPuJ3fJ5J66TRE/eGaoKpOGupRKOuPZYLuxYMWLmZYIzJ6tOcu9Ta2S6XEBbUOzpfdClWI5ho26gPgXYJEqb9r6jqxKc8Xq/rXSbbsM0FbcC1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708413; c=relaxed/simple;
	bh=5uXvHxjZzirfDvkIRhOsYYDI7XACucJRqQE4OGn03HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kwt5sY4tN5ZujKZ58z7cuXnw0F0RZxLgz20Z+iuTacZEAPW8HN4ktH33um28nRTiWbwUqIGneeieRhRWXfdfsSjuZvd6uDao3u9azAYSIAqrHQN1Y/nUgazEQAjZ5VYg9CavlTj/6XxBashMqn9nfdUv+iC4E2l6OKCtY0oDvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+52ARJd; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso25445739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712708411; x=1713313211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dH1sOx8AuuAIwyitTYp4fQEkYb8QaLWM8FC1wyKIYw=;
        b=H+52ARJdBNzEhm5cq6vTVyJN94TwjZFpDklDqt5HIZA32eu7vH0qSsm+St7QLT0EmF
         jVIR0dwk1UUct5RIVLkbbqmAMau/pwptoSsuWIqR1iGzphzeUmRwMvZDh4XIYMBVUaWQ
         1R9fpsdJz/Ne4eCZY1fOFONUBSEJKuGi520x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708411; x=1713313211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dH1sOx8AuuAIwyitTYp4fQEkYb8QaLWM8FC1wyKIYw=;
        b=jHRrFzpfv9y766OA2oel+toRTDNzCi+ZXU/yjlg4W+Dv6urCYksG/y1VAly2ZRlrUP
         ZxpVShMrZqkohneqguO0sGmYiKPbRU0p8OWZTezdvHBnnJTw/7ARcuYimbxIHJvqe6yA
         YJVVp6guBahqs5r2GvdPlIbrBQ4dpfYUfuVbnN2dkbcbDRU4nX1V9t0aeMDHt+/qktW9
         Wm7wy48UrmEQLySawpWIeO3/emsmYW7enB4rf0bw+9OoU3eBrxOjV22I2RdoqcEX/Irs
         4kWnSnLlg+F89Mh9ZQzRDG45EBUbDUeQM4oCIE6MQkBbMWI9Z0z6clVhw15vdkdeSzU2
         hjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqAwI6vfQZ9SJwSvrfTw1ShlQR+DzecwIsIwQWNrY//d+NxtrvG89gHa/oel0TLjAykji6AcVvBWGZBsbKOvFTS9MMjwp9Ica+XgyC
X-Gm-Message-State: AOJu0Yzs5gKIF/1VJgBxF2AaON1K2qQw7lRnCh/YkfuVmBz5WCFmdgRA
	AGctyMWPubabbv29ByHB2uw/awAxK9/Sj+0jf+EDMx5FCyfyNj2b+FlJ9oOCl/E=
X-Google-Smtp-Source: AGHT+IHbvOdT7cqb6UgFwLcn1UkETQPFfzLOFngW91YpGcYtJrG5Zk7Dp6VMjSouo+2g5OCmxYqkyw==
X-Received: by 2002:a05:6e02:1fcb:b0:368:efa4:be12 with SMTP id dj11-20020a056e021fcb00b00368efa4be12mr1803875ilb.3.1712708411222;
        Tue, 09 Apr 2024 17:20:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p11-20020a92d68b000000b00368c37480ffsm2854540iln.82.2024.04.09.17.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:20:10 -0700 (PDT)
Message-ID: <a07a6abd-47d4-4646-805b-ae170b0540a8@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


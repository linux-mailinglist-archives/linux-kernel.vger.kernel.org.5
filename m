Return-Path: <linux-kernel+bounces-161488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FA8B4CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB523281515
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6936FE20;
	Sun, 28 Apr 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOPCNvES"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0796FE0D;
	Sun, 28 Apr 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714321462; cv=none; b=WkCTotOixp1O9rK+m/CBw+p7DgWoZ2hH5rTGE1+HYLqIK/bNsMXvHOGC5xQ1SQIBbZE6vedeRSJuPFzA4hZPMRlOZFNB2C4jbi8ba3zJ0DL1k2mz9nbga91vA05r0D29jPkdDjBDWwETJNnMOIgh2S4dpH0x2veMfT+h/xK7aRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714321462; c=relaxed/simple;
	bh=3pikn3bZ/q6pSwoT63K/PzrujRdRKsme+wtfeGAgkLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhLosFQIjZE1BOJMbRo5FqXfhVo1ZJs4By6NDwyM+VN3ZkRJPgIYwctzRX0mln3vkFprvniQZ2mCZBXu/3oic6gBI99E9p7ntVsfs4SrzV9DqieWDbIooYxFKpMxStopo85By9STB1bA8bhID7yUVRsItlxcTgC6iIJb7iaxhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOPCNvES; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eac92f7c74so27204345ad.3;
        Sun, 28 Apr 2024 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714321460; x=1714926260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0sCch2uVnHMEKN8y0EcawfVfKpRrCWXkwv05+gEKE=;
        b=GOPCNvEShGN9ZK8dW5/vo/mxw0UU4FqQF9HEhKHAjFzFB71vtie6kXZBdFEv/0GZn7
         WjTECGhHjrdr+yTWEmsAgpfXycKTdigl53qwEwY/jV3F32QOHetiiBTDvIEss0/UVoL8
         Mbe8gluix6ab0HQREiBObHrLR7fjaXDaeRuDuvUqiGJAxB3DUT8JXCOh5q+1LU2yDI+W
         GmwA9VZh65Xd4GFAhAooA9t9b4rDIbA6KvvAUbA2GvQqJ0cL1br+Jy1/39888EuI91e5
         OrF0Qf95P27+0mY2ejxybL5/zGLhwihy9VxltRR7rshyPwtANv+OSkJh0QhYXNPf+c66
         wdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714321460; x=1714926260;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KW0sCch2uVnHMEKN8y0EcawfVfKpRrCWXkwv05+gEKE=;
        b=gD0LW8HYYFPTRtPY1+W7Zz9q4YBgGRjlvCV1cfKmWzs3fBkQsaT6VrlkMMHyBPzNFA
         JdJ9lchJ1fgl5EebAEyBkUfUA2kBcX4voIX+XULSff4uI28VivCGXZOd4FNwc0Lm8VE2
         2dQvUkQIKgC+GT2y36weuFLsNCVU18o9+YjMcr5PMOnN6hZCRdsejscj4wtNS9JZtkV9
         /zKF70KPQgFkfAdra+OQ+OZNiqP7krJvd9yPsVTAYBvhUafsDNxxP7XR6nvhKZfFp0sV
         ZUbW2fxCcM+N0sqdBTbT+DT/Fw7b+U63hRJQszz8CuzbukbEYDnS2dyzMYdOall++kyZ
         OBsw==
X-Forwarded-Encrypted: i=1; AJvYcCXhZVGwABjbb2hZj01JfP7216M0HggE4ci10K55HhqHQoSVn3uCLi44bdrDkLUeFdAx6gaGmBi2Cb9JiwF96w0qa/c2IPRE8JNLBGcxE+FHGUkpsFQKqnqve+LftmbgKmcgy8au
X-Gm-Message-State: AOJu0YxCd9oUwFRexdGKEx/How9KmBNOrznQOqLiXvBR3NKUpeLIeBRN
	mHMIfiAmAfx4JKhab1bpCNTorXiDqJvGH3unCfzWREnqu50428E0
X-Google-Smtp-Source: AGHT+IFtN3y7a0lebNWs0c3mgSkrwvR9Hbe8ptHD1guEvftLzxBxYiafmlj+Az7wqIlySWqu9Qr+9Q==
X-Received: by 2002:a17:902:eccc:b0:1ea:c52d:e03e with SMTP id a12-20020a170902eccc00b001eac52de03emr10122727plh.13.1714321460481;
        Sun, 28 Apr 2024 09:24:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001eb51a43562sm2795133plh.185.2024.04.28.09.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 09:24:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <86374002-4585-4e61-8414-33c7612bf940@roeck-us.net>
Date: Sun, 28 Apr 2024 09:24:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Vitaly Chikunov <vt@altlinux.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20240423213853.356988651@linuxfoundation.org>
 <CA+G9fYuv0nH3K9BJTmJyxLXxvKQjh91KdUi4yjJ0ewncW5cSjw@mail.gmail.com>
 <3yj4eo4ww6wfz4ggaurutemobxi7pwdg7gctnhmwytalimpdcz@hve522lspsdv>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3yj4eo4ww6wfz4ggaurutemobxi7pwdg7gctnhmwytalimpdcz@hve522lspsdv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/24 05:32, Vitaly Chikunov wrote:
> Greg,
> 
> On Wed, Apr 24, 2024 at 01:53:35PM +0530, Naresh Kamboju wrote:
>> On Wed, 24 Apr 2024 at 03:14, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> This is the start of the stable review cycle for the 6.1.88 release.
>>> There are 141 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> As Pavel reported,
>>
>> LKFT also found these regressions on 6.1.
>>
>> The arm build failed with gcc-13 and clang-17 on the Linux stable-rc
>> linux.6.1.y branch.
>>
>> arm:
>>   * omap2plus_defconfig - failed
>>   * defconfig  - failed
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> I'm curious why v6.1.88 is still released nevertheless the reports of the
> build regression on ARM32.
> 

It would also be interesting to understand why commit 0f4048e1a0c6 ("ASoC:
ti: Convert Pandora ASoC to GPIO descriptors") was necessary. It doesn't
immediately look like a bug fix.

Thanks,
Guenter



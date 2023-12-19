Return-Path: <linux-kernel+bounces-4714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B48180FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9154F1F24B64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C86AA2;
	Tue, 19 Dec 2023 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juDKmrKs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3A6FAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9d2f2b25aso3057833a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702963667; x=1703568467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bXkmEJvJFAPbKDmMM55QMZx7WRuvaWAYdXvhxYcops=;
        b=juDKmrKs4RrFZxq8wSkbCKKzMoEQPbqHZTAXFo4Ppxt+J+VbwmaB40gkAUWazqTgYF
         qno4mGwyZCrS0SBJLm6Rva/AgtD7w301Yx3wWyGscb/0RY0moadU2ZODOhN+3BeMBskf
         Ft+4oX8s/Ey5SF1KoU1sT3yx3CeE+GBBDx6EyDGTs5Ikq/JLANzp11jHdZApg3rtNS6/
         nzLmx91czMXKM/scWFjCfl25xChTqByRRUVvp3f4PEaW3/JSFIxsqnmOvLYuv5RAXULm
         a6vtL1PEBGhWZwL7Wl56h3UBCnMzaE/XTcM40x0h5mwJb+zVFH51vMfDMddDPCW/aBTx
         UwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702963667; x=1703568467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bXkmEJvJFAPbKDmMM55QMZx7WRuvaWAYdXvhxYcops=;
        b=NfbPrGqv/4rFY+ougirwbt56+1PNQsrCUpaflIZgIwIRbVc77+xupDZrQhKBfadqJM
         qdlIPBlvsDFxbMWKqCEucmBhONQbR9qgShSJYqvkQbro5DlM1Xao8FBDoYscSHMTph+t
         CpDNUh3ZukR+h7AB39DDYQGV9Hq7+++fq2XvKhs1sYexOUkan1Bbw10IZng1iBvNeDJ6
         hyS7ZmZwXF0vGNw3dVPL8c1dBh0ARXxpAp3mYAiYB4EMHuMAY+zcUlBPdmQR4Z3IhAEd
         t1uZDpaKkUBsPj5MMgOtVi+b1n7WY96fWeZZZ7Prk7YqrMkXLuv+nGg9ZdEpnCGPWrTL
         ydcA==
X-Gm-Message-State: AOJu0YxW0XutSVWW14kucTp0yfOzplRxYUVfJmTS8u2vzuxt8p63EKWm
	7hs0WBTOjNFVr+PqQuLIEIR9Vg==
X-Google-Smtp-Source: AGHT+IFYR8E5krFrPMoCmfYZtBKLn6BrnnEnAwB0Y2XpS1epJMbyVd7dRUSY4DriGr6moq6f8vlM6A==
X-Received: by 2002:a9d:750e:0:b0:6d9:e832:3f20 with SMTP id r14-20020a9d750e000000b006d9e8323f20mr16571528otk.53.1702963667147;
        Mon, 18 Dec 2023 21:27:47 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.99])
        by smtp.gmail.com with ESMTPSA id s17-20020a9d7591000000b006d84b3aa650sm4889104otk.73.2023.12.18.21.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 21:27:46 -0800 (PST)
Message-ID: <cf94f746-55d7-4f22-bb53-b5c1be843354@linaro.org>
Date: Mon, 18 Dec 2023 23:27:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/36] 4.19.303-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20231218135041.876499958@linuxfoundation.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231218135041.876499958@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello!

On 18/12/23 7:51 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.303 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.303-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see new warnings introduced in 32-bits system, with GCC 8, GCC 9, GCC 11, GCC 12, and Clang 17, on:
* arm
* i386
* arc
* mips
* powerpc
* s390
* sh
* sparc

It goes like this:

-----8<-----
   In file included from /builds/linux/include/linux/list.h:9,
                    from /builds/linux/include/linux/module.h:9,
                    from /builds/linux/net/core/skbuff.c:41:
   /builds/linux/net/core/skbuff.c: In function 'skb_segment':
   /builds/linux/include/linux/kernel.h:847:43: warning: comparison of distinct pointer types lacks a cast
     847 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                           ^~
   /builds/linux/include/linux/kernel.h:861:18: note: in expansion of macro '__typecheck'
     861 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   /builds/linux/include/linux/kernel.h:871:31: note: in expansion of macro '__safe_cmp'
     871 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   /builds/linux/include/linux/kernel.h:880:25: note: in expansion of macro '__careful_cmp'
     880 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   /builds/linux/net/core/skbuff.c:3630:32: note: in expansion of macro 'min'
    3630 |                 partial_segs = min(len, GSO_BY_FRAGS - 1) / mss;
         |                                ^~~
----->8-----

Greetings!

Daniel Díaz
daniel.diaz@linaro.org



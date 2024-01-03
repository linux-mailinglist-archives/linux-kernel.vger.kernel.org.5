Return-Path: <linux-kernel+bounces-15906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229882356C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A43528652C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECF1CF89;
	Wed,  3 Jan 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIunxPK1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992EA1CAA8;
	Wed,  3 Jan 2024 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca1b4809b5so3247034a12.3;
        Wed, 03 Jan 2024 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704309342; x=1704914142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THg77ifkb1nWeoB2+qgVSINTgAapw6XOZvKpasqorLI=;
        b=YIunxPK1b3eLxlZhuxAh1eHDZWfLOmnNgsBTmKGruKXlGxHTT2IMKs2czJh4zTmjOh
         8ZT7Jk/gP+qD4J2+rdMlyEx++uEo0Ipu09wH5RuIgAwafjrodKesHXSMBKXYBSqYML4o
         DKqESxGDbQF5qt7HCFLhIvrjtsEqfn0qDFy+ioXm7PbHXQYKOSHyD9YlO/qso7uKXlRB
         q/Jw4/u59wV5/OaENz412aAdGA6JsRmxCOl4nvR4Ua0CJ74FnIR21wrV1CSvzk0QimhC
         xGfNQ5LJ3d/n9rNKlfZNhS9ib7D0hos9tsgwaj4CaAAH1HBGHldDpUyyRbObpoFrUfiA
         C3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704309342; x=1704914142;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THg77ifkb1nWeoB2+qgVSINTgAapw6XOZvKpasqorLI=;
        b=eCprM6q8oZnZ6KWkcUIXtKvw103XFR683Bhe+FcEnI1reiUu5hJIa0dGFVqSQrzccy
         PezaFURaUoTQGFA+GM4st6BQkCxLIKuRlxvfp9gEgXAgigjr273Wq7CbQrhSj65c+2a4
         WM7IEB0DQXwwCPkDV4lea7LaYQtxWcNTIWyytCqR37tVjf+kQivjZgXmBpNKNF5yUcmd
         HZmWudH39V0QvT+Haox14DtYlPPOUFNWiW0xkkbdmfz86xyRCIiL8EGn6Sd9TEfu9Yt3
         XYSgqgkR0z/dn9kbR8wLO3o9KIKY+xRiqhnCZObyW84JEhUzDYiEqmA41N2OOrZcxFJk
         W69w==
X-Gm-Message-State: AOJu0Yx4JTN2D8mgWJDFGECCWRcPi7id1ApJn8dnxSNQlSA2ITXPC4HL
	AZKfgEpjNopcdZzT/1E1v5I=
X-Google-Smtp-Source: AGHT+IHa3Md31dvmuaHFAtSG1dwhs2s1EzBoOiqYuNjpKGoKqEynfIKWI6zeugxZ4FTv85lFr45hyw==
X-Received: by 2002:a05:6a20:9799:b0:197:1075:b51f with SMTP id hx25-20020a056a20979900b001971075b51fmr2250052pzc.122.1704309341901;
        Wed, 03 Jan 2024 11:15:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id du8-20020a056a002b4800b006daa809584csm3473076pfb.182.2024.01.03.11.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:15:41 -0800 (PST)
Message-ID: <9b783291-d6ba-46b3-8e91-8deab3f3f777@gmail.com>
Date: Wed, 3 Jan 2024 11:15:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240103164853.921194838@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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



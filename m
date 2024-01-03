Return-Path: <linux-kernel+bounces-15939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F98235F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86ACE1C243C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F901CFB2;
	Wed,  3 Jan 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APEdFICj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D41CF96;
	Wed,  3 Jan 2024 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so552103a12.1;
        Wed, 03 Jan 2024 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704311708; x=1704916508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3iU8aqcre6TJqNl9hYE6bRCOPELUfFdiBKR8Euu9Ys=;
        b=APEdFICjaFmxck+mRbZCGA/1t3Duei/2eWTWzR480uRB+JXjHnYDpCYtQqTPpEw5sM
         CazNIPTrOESeisPP+ILI22ifeUJUE1tQ6wBWJeGhR/wqzaFr4YXd5dggM+4oHgNZ5m8c
         9XjRCDVLMZZb39d83dsHCey6iVwkq004LuZ0gdvooMxVjXMEMEtfjIpLYZMLxDO4KuNQ
         uPcHqc+UAW8TGCQ54TRH+CVVT4+3Is39QgMN6zAzRVvB4g4fS1CpGRSERPI8NMV19WYN
         n3Z0mKV4MogX9BincNHEQYfDk4o8jObfVbtS8/NnuFlW3SLbHTHBcOLIoabT0OwwO2oW
         VwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311708; x=1704916508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3iU8aqcre6TJqNl9hYE6bRCOPELUfFdiBKR8Euu9Ys=;
        b=cZZptr0Q0r3LIzlRTvCwLwa9e7EKdruosvsEgW4+DzJpjCnm2M7ENdP5n7AMF/3Hix
         JFwLC6xXv7PMmnCfshXLdKVNgHBSME6PgeY4l2MlWL46BYdI3Fxk46hlbNKHGtGClBXm
         G60pe5N2iYEr27X2Cd8uA0Pa3QMR3giZ5nHp7KpyZh0BobTf6ZRz5fPkP69qWTmqRmwz
         SKTsbKTeOqyt5A1/+/1xtzAuoJSrCniUPt6iehSoLnmBPj9aMT4DLpZaQSSvx6wtKadB
         e+GEH5J2gXidnK5DfyHdnzkjsRTnla3L4UWkr62r04f1yJkk0uPd/2kpMCqiGaYqJOgt
         V0nw==
X-Gm-Message-State: AOJu0YyL/8QOAXqHMB0/yHLj+4HMXzcN2Fa+Ol1B1YThOi9Ov0HBVAqb
	qs0kUEMb8xgQjSZZd9x82GY=
X-Google-Smtp-Source: AGHT+IGClAPCl9CbqKzsGVTXv82t4CtF/ve+Vpmn61NCHnYs+cWDY36TDd1dJAx61YoOCl3oeA27Rw==
X-Received: by 2002:a05:6a20:4323:b0:198:fe75:5692 with SMTP id h35-20020a056a20432300b00198fe755692mr748022pzk.23.1704311708263;
        Wed, 03 Jan 2024 11:55:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w19-20020a63d753000000b005cd78f13608sm22746267pgi.13.2024.01.03.11.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:55:07 -0800 (PST)
Message-ID: <abd2e7c5-b1f3-4a70-8634-fb7f51080da8@gmail.com>
Date: Wed, 3 Jan 2024 11:55:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.71-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240103164856.169912722@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.71 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.71-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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



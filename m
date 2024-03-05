Return-Path: <linux-kernel+bounces-92948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2448872876
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712891F2B8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2C128807;
	Tue,  5 Mar 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq5eAfUR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4909D27E;
	Tue,  5 Mar 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670007; cv=none; b=sGCt0v+F3Utg3i2a0LZCUFyTSxHbT1kr6rKJj3V858cRoxnr9KHrPOqC9Ij1q8N75ZqZRdfJW4HWeuJTIDpn9pvt0ghG1bo1TQJtI+5V3pcA9YaijI6d5FgcHaI5eSIESM62HvpNVdRsJfmEZFza3VOkYXtQxyoN4qatogYBDg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670007; c=relaxed/simple;
	bh=2yEo52nUqEosalh8acVmH3pa4TOwG+VL1d7ZfEeFLx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlicSfwrlOpBQ2/GybprJvwkWCMBXunQoBRUNCG3Ts96kgZxX+NGNFrYSimcTATjPT6FiwGVwd99EqlA1lj4e4O6PZ+mUdRMOkWyDqkjUe4LDllv1wja79sIRQ1d0SzV2VjxUlJX+Wt+LPjpKEuSeXjM0MW69B9j+qZgrsYaENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq5eAfUR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68ee2c0a237so1164966d6.1;
        Tue, 05 Mar 2024 12:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709670005; x=1710274805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcL6wAeqVuoZZD/5WSQ4uqaLPsMl9CXzbiG1AkNovjo=;
        b=iq5eAfURBuaMPN/0AS2/GjzX3e0u1jT4f4n1/A96Xt9qIYuVrNe5S24bTDBBUm3UrH
         jZ55zwcdd9CXkYkDhhWle3Pg6+S+XIqrziH1XRXMNbiKD6E5bbn/wg6Gjzy/Ne7lyMTq
         OEZusdNq1fRhOfu3/Be5T2JOXUGfWgDskJpG/JLqodvRChgxnc/WwL4Qr9BuMdOIn5ka
         zKd4rm6344r1HICQ4RWzDlca911fTSzXekfb2ErYI6xfvW65xqV8r22E11P6Fz0D5Ufx
         u9JOIRV7zUskNDIgCvC0gYGg3yssmVBuJx5AFTm1i/FXRO0N6kAFyxYRkZ6+0GHbbSEu
         SJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670005; x=1710274805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcL6wAeqVuoZZD/5WSQ4uqaLPsMl9CXzbiG1AkNovjo=;
        b=hmrTfWqYy4sus8uaduesfPOk4Ub9DJ8ZfZA1mTGvRwj5aufpVCri3onbqau4vp9aAO
         9/eeX51sS+N2s9oElmYTuKGZAFryh08F6MNLFRUgtwOhw6oHGgoUCeCi//S+7FuYVkoe
         lHTSclq+LtWwEWOLWtK5xqiVtfHTTyWn+BcZ9EkaY5cvwhH+nHXm158XJAWdfs5jEaDj
         i2FaBkGgkHDYICtvmPYDi1FGrkGYL3MJ41+lT3EzDfm7V4bvrr8PDS86KIH8S5SP+H4n
         hcgyIb8LPwWpjBC2suVGAPmq9DJc6W0c6WN2xkZ4HSLOUpg6+JgDqapmndL07NJbMYvf
         IBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeMShmLvpfyR/nockxukKynNvE4EP1+0NTBHI9zzjBUAUFPGa22G+ezGhVW015DZLmo+DZ1cdmjLWRlhk6nKV97/BjkxxTghTy3w3XJA3rmgpCiVzduymxQ6P6kJ5qM2bbo5B5
X-Gm-Message-State: AOJu0YwCozVFN6I7KwpDCaJDIOyp5twLyg/FnKKLscRrk9Woz3IwGMTq
	TifkEWtNgC5475EVg4CQV/23ZUSmP5FaA47h/Bc3YQSwqWNvc/cs
X-Google-Smtp-Source: AGHT+IGtZnMYmjNXy7Q24MFgCNySt6n03fjiEkX7ZqjtXEWZZ8Lyan3TNq/IbL+j0zffMjdL1p4W6g==
X-Received: by 2002:ad4:4f4a:0:b0:690:8f66:5d3a with SMTP id eu10-20020ad44f4a000000b006908f665d3amr2781140qvb.7.1709670004785;
        Tue, 05 Mar 2024 12:20:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ld8-20020a056214418800b0068fef1264f6sm6529329qvb.101.2024.03.05.12.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:20:03 -0800 (PST)
Message-ID: <70b66780-0f63-4192-b5c9-ab3ddb08b330@gmail.com>
Date: Tue, 5 Mar 2024 12:19:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/25] 5.4.271-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240304211535.741936181@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240304211535.741936181@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 13:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.271 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.271-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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



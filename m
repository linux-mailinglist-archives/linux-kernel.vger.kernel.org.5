Return-Path: <linux-kernel+bounces-51220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A958487FE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474BD1C210FC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4B5FB9D;
	Sat,  3 Feb 2024 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDF/qiTS"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025195F873;
	Sat,  3 Feb 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706982212; cv=none; b=Ul1j4dZxOc+VmiLJRfLci67VBCm6tu/V7LWU8Ks7c7RRW1iZH43X4Pi6p//AjaE/2qS+OH7o1sxkNEpuDHvb3ffTfOP4yPUnFx+2zgHuTYAu1jGkWbh4+OUKfU/MrAgodkDoU8wa21NYUvz1mJ912ZEuk6369PSoJ1zd5Oq42t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706982212; c=relaxed/simple;
	bh=uIzfiwIX15lOgikrT9E2oUlcdqQqRjFgc9iTxmtsI4A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TlvZRTrgVecpuEBTDbskGzmVDOATvOh8Qmi+AyRH/UksbItAqH0FWFxe4FQo4lhW43DwL2LqjzBt3/XS5UCS7CK1Vq5UqQNaC0xMxDMdGD6A6WmRkUuTugd6mLxZD2773EV2IRsA4PQQN36al5lQ4u70Rwv/fhq/iQowfWDFgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDF/qiTS; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d6275d7d4dso1189746241.2;
        Sat, 03 Feb 2024 09:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706982209; x=1707587009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBmQBP573ue+tvywp/qvpcloLt9xEUFFZ8EysucNNWo=;
        b=HDF/qiTSdWwsb0N1UQ+cO28zfalk6Xk594bZtga9IRT6Ntx+kdh6xQFI0y9R+O2S2S
         lSStzEtfL+Nrdj6Q2jfhoJ2CC8OgeC7K2W6PZWSO8FhWpvS15lnoQ4xih+euacC9hA5f
         xtWE8briYok6OgXvFnrDDCsbKT739BAXi+bRD5RrVLT8FggYMDy4vbLdKUOCs1T5Sf9v
         bZv84b1KGE4aCSc2N42kumcMjF6jKCNY5slQ/Bhc3ZuOOpKdk2IGypP2P0O0asUv10NV
         dyYfnWrgL5nBlGQ+1FyqZcpDM/N03Opq+myUJzmkhXg/VNhyRFds3Dby/Mpfki/hK9cC
         PEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706982209; x=1707587009;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBmQBP573ue+tvywp/qvpcloLt9xEUFFZ8EysucNNWo=;
        b=OV44wk9Xzqn1BBuG/J2UjR6+6HLek4IGARcxwbQiwpS3GdoLRmJHmagGRmgGMrqEc6
         Hp50tp/aGuWidsRqR35o7Rzfsb1SKMq9gxqxaafSPVB6SsTRD8qd0tY1lo958Mbpbrr9
         088erzsogPrwh6c1WEJDK13XBQn6Eie40sud/3VbF20uIGw9jDBcSKA9Vl+iZ0MW1rn/
         gWenf/eIQZ4eiP0xGQT7kNQJZie4lZxcjB6iyI/YjBCoZR/yD7c9Qn49V4q+PNTramZd
         PEwkuHVgd13XTh0lLA/HUadj6PBLyeXVjEwLjxBx5rweuFOf8NMvNXDCBdTlUZBmwjGW
         nVSQ==
X-Gm-Message-State: AOJu0YwGaPdzeodvnm0DTGjsthnCjgGsq9DLTd9Xllx/849/emV/YCNC
	8uWNC7HD5L50z5kTVMbRCKIjsBGHQyaJK5pLzzI11IP7Pw2w06pC
X-Google-Smtp-Source: AGHT+IHysS+pjb+ReAPpnIbXjOTqqSlG9ycOVSZE0EUm0/x5KHqLG6upf5KqHxzYpex6/xBuJWFqZQ==
X-Received: by 2002:a05:6102:2252:b0:46c:fb30:8757 with SMTP id e18-20020a056102225200b0046cfb308757mr6126041vsb.10.1706982208685;
        Sat, 03 Feb 2024 09:43:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUx9M3heCOxZ4kweSUjywb5Ggp6C9yvpQAUbm+24qI37hZx4UP/PSWlE+3wxFoeCYkr3Me9mvR6uSL2wCjk4nUVj2itFaxObcL1VMT1vZGkoRPEuV8dLAo//9CZkWEoV2dN9IZuFESrr5aGkyqUgh9B/GezGLnFr9IsLSpKAYepVuCR96gA864j0yeMrP0t8hhjd/CWaoT3vrYiX0QFR6oATx4O6Fub38Yvdw8MON+NqCju0HVdUuspOmoiMZM4ByT66kNkfceuGD9Hid89Js1AjiuiIB+HlNDayhlgMe6EFdUXvgs5nRIFhmk2Q6LBAq/VDDpO5EdkcOpruKmpKnpW8EFNhKC33zcpsVKASklLasOLHC+vimIrVAeMDM67DaX2aMZPE7dwOHj6EKgiLPjnGDuh+QEXK5NSHFYA8HkaSiYuh7IsAYoBsWu6Xw57PbdzadvA5nqeIBticRhut/qA12s7H/DOArcDDpp+91tq8giqnvHCpXl74DntjFIKZPPIx7cX4ig+
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id om6-20020a0562143d8600b0068692ea038esm1981335qvb.91.2024.02.03.09.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 09:43:28 -0800 (PST)
Message-ID: <6fb12d16-e508-42b5-ae9a-b61753e88b21@gmail.com>
Date: Sat, 3 Feb 2024 09:43:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240203035403.657508530@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/2/2024 8:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.4 release.
> There are 353 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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



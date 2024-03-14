Return-Path: <linux-kernel+bounces-103741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F0587C3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336E1B22DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962E76028;
	Thu, 14 Mar 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri5NahH8"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F52A1C7;
	Thu, 14 Mar 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445978; cv=none; b=P1LWbXAs0NvocFOhVbcTAORYAOHEK8BMZRFXtLmSO694h/NXhNjNyssTGq7BvDewGjLPkUsx2TTLjIEi0KzySZ6e2fFbwAUkrXXOjXBChrFrCWFRtY3FFFS8F/ZLQnARGh34PPaYW6Pc8zdBh3SrSdC650jSRKmNpcCHOYCseaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445978; c=relaxed/simple;
	bh=JGzryGDxRS0kA7ha2kZ4fK+5Ufdz38aITpzSKuD8bR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOM1D5jsEFWWErI5zUFkB1LCYpxEx6VE49shreYeeOzH+0rQiCLV4PahE4Prhx4JLXsZi8pSfPejkRXBRbdOdOrGhq9k5ifAsvl3I2FuIO5d17kGQsXnYAIJFbXJY8eRbJ7PqXyHyIXEY/N87DtRpy9cgdE5ToHJNdm7b9G6UCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri5NahH8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-789e2bf854dso9540085a.3;
        Thu, 14 Mar 2024 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710445976; x=1711050776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPyt6MDsvnBUMVZnxBKEe7Kw8t6M1VINKJ11DxxIoJM=;
        b=Ri5NahH8h3m06uzfQfTIAILepx6ZNrMsey4LrQIjTN3vEAI7Wnv0Yk2f+VMRvH9wnF
         2MWIDLfXYRB9fo3hQHja5bTIw2JD0wlBiOLf6G+PSBfQnarhROwvfCAjUcjMm97YZFl1
         s8B8a0EPtHTFc6DRi6WfbjuW/AcC+wcsr56OdQo2L0mjGjGq2jpPYjM4zWzwheJ4NNd9
         b5BU92wkcmRID/J2zzAR8iPeubDcDqAK/3jvfZFVFzreyLTMMZgaOa7yFImzNIHgnaij
         Du7NrTgNM8JxgtRHCEEkck1QiLm/CsFwf+OHcAsRS7fy+av9ZWmzuwZxraWCghZp5Nd6
         CVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445976; x=1711050776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPyt6MDsvnBUMVZnxBKEe7Kw8t6M1VINKJ11DxxIoJM=;
        b=EQb4kSumypLIB+dexYlFjanltjsHatDMTRMIQc818vxWPngED39+aGyndC+x96xy+p
         WH+InUe2JYoPPL0Kar78Uo+JlCM9Nzp/cwq/FCV2d7MaQkq6yjqueJ7pRiWXYeJSuqTH
         7rqMKUS3ga6Oba29QJseInrsOEIO6+Mx34Z3y0aszntLFb26t/+xl48dhmqOL4XvQmez
         0swPwJRPpqGqRxuW4RV0QwtgEJiS2oTTrxedlYdpi0xpQrz73XggCdh2rjwBobUxk1yj
         bh/3CFN4UcdCHHie6W3IjW8MAa1aJVwxF/l/4kMho8pwALBrMtt3Rps9KvwCoYSw8WBz
         lVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPotwK2FXgUOBsvKGC8CYwRDlSekEANDbeVRbuhDPVdX/9/F/PoCPJEExloLzk8VTniZX2xeSbEr2MC63iW5HH3apssmatAgsvZrMDhEkp4QAlkkCf2JngCJw8Xr2DERkqU1Do
X-Gm-Message-State: AOJu0YyroU9XU/ndOD5k0y76+u7NeHx8eb87tOZqv1z1D49p1QysFzH8
	/1UbpYbGB3t3v+pE7TW+29zhu6EclVDPaOHIem6z3bfLrOd72afA
X-Google-Smtp-Source: AGHT+IEJIKcApkflTef7gOlunH8Xz0YZIn+hJxBxlp2vVKVLL0/3n3JFXT863DTTLJgmywD5GYqMnw==
X-Received: by 2002:a05:620a:667:b0:788:7482:ff54 with SMTP id a7-20020a05620a066700b007887482ff54mr2789009qkh.72.1710445975616;
        Thu, 14 Mar 2024 12:52:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n5-20020ae9c305000000b007886bb7826fsm1197403qkg.46.2024.03.14.12.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 12:52:54 -0700 (PDT)
Message-ID: <14e14046-cde8-40a3-b360-af4c8bd3b677@gmail.com>
Date: Thu, 14 Mar 2024 12:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313164640.616049-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 09:45, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.212
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



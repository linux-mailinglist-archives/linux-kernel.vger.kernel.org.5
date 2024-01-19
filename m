Return-Path: <linux-kernel+bounces-31323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676D832C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CC2850FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7054BDA;
	Fri, 19 Jan 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gZ1okhzT"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE754BCB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679325; cv=none; b=Ut7eCs/+4hlmuouFvm65lr1+otz3EcQaGRosjcRhVNwKkstCejn70SfwNx9q6tXjWop6bx39PN9EOpQj3FIYOX3uuXKHqfPeluYG9LWcYX8h1OwF6mb3q709wy2g2zCPV2UPBXd0x3RnD2OSn7Ug3zcq68DCa6EqY30ydwfELLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679325; c=relaxed/simple;
	bh=3KeVb8iHSTXJAHlpC+TiGoBdbDy0ujW0bVUfMh7M/IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeB+w/0ZOfTaDiG4fE4YZbOtGD94od/Z92NnozZ7+f7JkMXhLuthDS+kZ9dTAtWEakhgOHKOKc2WxhbIw4ULJf2/ExqPkpicT1xzMBiO/UGZh33JZfDteka1aicXsImkiSVdedMUfa2GzwoNDzWbRftFO3PTdurW2u7Q769cNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gZ1okhzT; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-46955150a3eso302463137.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705679322; x=1706284122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSbsPC/GT8f3pGBraL0I1C1S6tXlzFxSCmChfpZ5F90=;
        b=gZ1okhzTwTKskuEKoi1ZU9FQWWqERcVvQeSzLlZG1butmD72rJJLGG4HP4+oLmWt/Z
         M0YfIzFszhskJcHcAckeS0eegfhO/cu5Vjtj2pwKvqYgbyafeIj2ebC/8KqtT6S9ihT7
         Z/P178hPskHehh5CNi3iNbKPJHhxQbyGFoATW4NbVaBHAO0gTUoH+RDnSNMq0E2CX2Wf
         E7AeWn8DV5N08IU6JQxCoLw/2V3/4epwY67tWaB4BK2UWefdc0AyUjoJwxw1rtzZamLq
         /lykS6cfYgNvlx1LZmygtSZ99MCGL0ZM/NIUP965FNl81NA0S3QdsXmkMzk46zwgSXRo
         ACSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679322; x=1706284122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSbsPC/GT8f3pGBraL0I1C1S6tXlzFxSCmChfpZ5F90=;
        b=cTIiLTBhSfTNwEMReP4ZzxyniVOYU92o8B7fJeFmJfhMg7t+P0A3Vk1HfXdk/oP1D4
         lhjV05+RhjzfOi6jIdleaADDXBhahmbNJfG40RQn+HrFNhHLWH1jPtwg41otdL9onpEH
         Dzg8vRhRYgfcQObciDV7BG8JXwhN8dJviGWu7fU6JLvGyil9vrcEmKah/9d/dZkRWXZD
         k+QyIZ/AwpLERtzwtqlB5Ff5VbU06tDKIlFMOaZGwVzsSf3/OsKIK24pDIDDuf3d5/vW
         xFTljrL7BIAb1g/mN9O7ccTemnHwPn2eyhDSP7exmXxeKjapxyQsSE5b/CMJDyLSiI2i
         zpHA==
X-Gm-Message-State: AOJu0YxD4gDFUicjMkXsqpDMkcpZYX1v3G8B7wN15q2dDvcf0ocJ5RGd
	WtthQunoVwwSTeQ+v7rmu8JjRtY4pMz8+3I/tqpoGzl0C88vWglSMxNg6UxU6inQE/XDY7LQO8U
	AIKh5ogYsIhemxJx5y9vY+z1VngcDAi//Fil3rA==
X-Google-Smtp-Source: AGHT+IGLafI0xBDL15bbjTBVc+RXc9+ZzQCvlFVzHvfgKr0SoyjWZ+Sb6T/8NraCFHnMzn/9lWlD/bMD7rzeMqgfQvQ=
X-Received: by 2002:a05:6102:3229:b0:469:9fe3:96b3 with SMTP id
 x9-20020a056102322900b004699fe396b3mr510547vsf.9.1705679320997; Fri, 19 Jan
 2024 07:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 Jan 2024 21:18:29 +0530
Message-ID: <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mainlin=
e.
but passed on 6.6.y.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240117=
/testrun/22090095/suite/build/test/clang-17-allmodconfig/details/

## Build
* kernel: 6.7.1-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.7.y
* git commit: ef44e963b02edb00d4de5fa3528a21f3e7b33a85
* git describe: v6.7-29-gef44e963b02e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7-2=
9-gef44e963b02e/


--
Linaro LKFT
https://lkft.linaro.org


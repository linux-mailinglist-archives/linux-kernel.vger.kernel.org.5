Return-Path: <linux-kernel+bounces-5866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F08190A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA9CB24879
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8038FB3;
	Tue, 19 Dec 2023 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCONnssq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7039850;
	Tue, 19 Dec 2023 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4669347c6b6so512034137.1;
        Tue, 19 Dec 2023 11:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703013748; x=1703618548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXpA7ooi/F79bH7BNeUI2ESUWbdjubcQ/fAj+TlOEQg=;
        b=iCONnssqSip1OmqYfsy6Lih6EGjJN8XMadPdsywPevP1zRXS9WLs4oyI9pJVC41PSS
         L8hwhZXtVZV34pqiHWlEH1MPMGazdm02/9Sme770FB9LNxkAlezGkMY5OFerK0V0N2+6
         xSw0mcs77K7ZhbZbjMj+CquE5VY4NrK/BIg86L5JAq1/2XQ8obBBXP/UZ0iDpWGGjkDd
         us2O4IJgC8MXefqlwf5nVi0rHrDPcfa9+oE83Xy5yaZUzgl90MEomznJ8DLo7mqBS8am
         CWCQI2D68u17D+P6n07PA39vI5CSoSrRbvMlDh4qnz2nV2NQVn1AMwchh+2xMY5cdJ7F
         d5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013748; x=1703618548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXpA7ooi/F79bH7BNeUI2ESUWbdjubcQ/fAj+TlOEQg=;
        b=YkFDCnbT4o5G5jZBPw5BC/rRSe4oB45dkv67VowgWdXcg24IyYriw7lWZvEq0aRDmd
         L7/7dUHlYLiyW7HPTAzn6LpJlWetXInJ68/Qk4B4e8ZMtlaTAjHAfX2r6yz3RHAd09+6
         eZHPnCYOFU4mPi0Ac7hEF1dyBq/4/mRIm5hIdgOWLashl+dkZ6o4wUMbou3vJtlmk4E0
         5gDwaitFFk+LfAu87ZNlmZE2cr/JEZGUg1fVgiYTR6PhbJ3/wtTeWMc6gi1BtclDv/Av
         NMZ0SKWRHE2RXzoN1avzi1BZKKr2kJ2Mmpb77AwK3bB9YbZB3s2nJgzPAY1E05DGLNcj
         qBng==
X-Gm-Message-State: AOJu0Yx1e5sHXELrtjRg76FmMSU7bhevp3/LhuEeTcHzuwW0kZ1R2uRG
	VTgypPNqsJ1tOXtAckOmDflCJ7hlwk94e+zS4SzZSgJxpzo=
X-Google-Smtp-Source: AGHT+IGw1pA9ALP7yssdgF3p89vt0ffPjdrBVZ2yij0P1tQGMV2cXGdAN8EuEP03Z1wYLapbAr70kphpkEDRQC2xByY=
X-Received: by 2002:a05:6102:3909:b0:466:ab9f:cdd9 with SMTP id
 e9-20020a056102390900b00466ab9fcdd9mr1404550vsu.11.1703013747834; Tue, 19 Dec
 2023 11:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135049.738602288@linuxfoundation.org>
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 19 Dec 2023 11:22:16 -0800
Message-ID: <CAOMdWSKK9TY45H1MrDKjeyRSBMnvo7ZUAatO5y8U10UjYF5skQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


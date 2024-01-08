Return-Path: <linux-kernel+bounces-19990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FCE8277EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787EA1C229A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660654F8A;
	Mon,  8 Jan 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irUV5BC0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF854BEB;
	Mon,  8 Jan 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b6b8262038so234674e0c.2;
        Mon, 08 Jan 2024 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704739702; x=1705344502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbuPhN1SnrANKO2lmnbl2HWuJmSKTIERpsPhzWFyRj4=;
        b=irUV5BC0WVw7tneNhjNiM94V1btf75LL6D12uVFIDDwtan3ujlt1JuQt/P2pUYgx7o
         vkXobKwDc2pJIxgVTNKJCZBdjLH1RJAymsnupDy6iv4NlqRfmX2dt7EqU/1wOfy1pzwb
         uc3fT2WbMMsDEUru48iKva8Q1hliFhYa3hAb1rOStd9YmU82TQgHq8zIMBIijvWkcWVC
         2uRTu99XoDQgLYrp3oR8f7tPiyJ/6c/F2Ov18h+Cr0QJB/btnB6K49iG9/55lGENVjBg
         18MtSBSpqAwO+BmLnoH0WaK2zvrdimzK0+HZqYhk9I5OZVv6ZXX4x8nUFq1qIgVF6VEK
         9yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739702; x=1705344502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbuPhN1SnrANKO2lmnbl2HWuJmSKTIERpsPhzWFyRj4=;
        b=T3hF0aKkI7gYbqUZRhsFKDdlCtBiqQ9pvfPJct9k2EtXQKeP4BTKnPxMC54Ktyx3eu
         GxbgfbvIhxC3gCrJocykoSgr0mx48mnBuFg3DQhZpBzk4YzWN/qBMqgF+iSUwnQn5dtl
         bCWCjSKWPwspPubNQciRA9OKTSZnDNN10EzPVO1F25a58qFVsFRdPihhA6jqMAc1K0Py
         4Q3hoZ2cwh51B5ba+1bKkRXYXNn8Y8rLWZ3FKmvrQoJXCAxRyJ/+rBS8+KdyiA0j8IJA
         3TRw4Zw0WpoqnPqiolbAgO3ICER2Rv+L5FLdc+tNN8PdYD2xC2klgisr4Feekg7uGtx/
         DiWg==
X-Gm-Message-State: AOJu0YyvBhbt3ZCU7hsFX39Yowa6WlSrFqjJDGUj8qAtAXViXcOmsvNx
	Qhb7+dTtBbDJtnbS7RFHRTnKxBqWCDPkM9p5sF4=
X-Google-Smtp-Source: AGHT+IF/UEBYXN/CrOF0snFaWdYAlGMmBbT8ZRKqH7CDnECRvIVm8aqXQMMzbB5DPamT9R6ELlSTQ8oCLGtGJ/v2vy8=
X-Received: by 2002:a05:6122:3191:b0:4b6:d63c:ca8f with SMTP id
 ch17-20020a056122319100b004b6d63cca8fmr1227144vkb.16.1704739701037; Mon, 08
 Jan 2024 10:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108153511.214254205@linuxfoundation.org>
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 8 Jan 2024 10:48:09 -0800
Message-ID: <CAOMdWSKFANBi0TY-1ECPLZyU-K2xTYcBEstuBUaekB_qD35rAA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.


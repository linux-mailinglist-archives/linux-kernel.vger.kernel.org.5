Return-Path: <linux-kernel+bounces-17002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19C82470A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888FC286DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D162D619;
	Thu,  4 Jan 2024 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWYsc1eK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA142C864;
	Thu,  4 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7cdef012c0eso87946241.2;
        Thu, 04 Jan 2024 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704388368; x=1704993168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TG4BujtMj3cbNtXYHg1i+tLfTW6XvV1xjqQK0OaXaOs=;
        b=ZWYsc1eKiyerw5XmAioDixx9K20Msg3VKrX4zvMk6R+5dEpApezGFXtAscgEtoekm9
         63EDbf3EWH3VUhFani79FpLM58vQ4lutHYcYGzBnVcUQP3bCJdgS1CElOhpyqbx2uxDU
         oblhu4V2PBUwlSYP1qqi8klPAUnHnQ5AanSlSFcDU0hdHboljJDZ1wjZtzesrcmhjqXS
         n4SjoIihWQ78cJ441P3IWbzCCeLUJtzr1OOXcIJCPhnDSigZvkePK4YRgVXs920X5+Z4
         99UEass0TTjb3JM55RcLaCHxKr1OOi0/HFVLeWcOSZkhSsfqnZngKWe+zY9RdDkpfsHN
         6szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704388368; x=1704993168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TG4BujtMj3cbNtXYHg1i+tLfTW6XvV1xjqQK0OaXaOs=;
        b=Kg2Eh/tpGGyViYhFhLe/IsDomr3wtH4phRNv+1kIMkvAGuVfYWaiyfwIEZX5oAqut8
         u6cUtOFO/UDUUJdLNVGpntofU4TTLjA7Lo5F5m0iM2v+KdpvEriZMyDSh5wkJ5gW5CqD
         NNjC0Xl4XA413P7AQ3Y1q+pgy02K1nnY/nryz8TY9h0cfX/y+ebZEqs1kbc9AhgQ/bpc
         VkBaeFtrBbbnCDcE8bPFKA8OajBvfHyQNdUQVOp+gLuzyQ5Z09gbdS9H73Oqe3mJ5mq/
         k4dHAaNOAwKFpMtc1krwEy1OrNta+frskIUM9j6VAE6I5RrVEb/QaT/XR5zyA6ZdtF+e
         HKKg==
X-Gm-Message-State: AOJu0YxHrdKUsMl3lvCWiAHwSjgv2C3xilwRa4TMnIO1VZJzJdnKJ1F6
	riv17bmvAkR5Mtkm3mng9sbwadnhnZvlXUOM3sk=
X-Google-Smtp-Source: AGHT+IFrmcj+Puw2qnuUPoLyUWaS7Db9upBCzJJBRIu5AU6fiRZU4h7S9uS8EWYb7YplDmhM/1tXnnCA4xoP2f3NBt4=
X-Received: by 2002:a05:6122:90e:b0:4b6:be94:acc6 with SMTP id
 j14-20020a056122090e00b004b6be94acc6mr785170vka.10.1704388368500; Thu, 04 Jan
 2024 09:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164834.970234661@linuxfoundation.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 4 Jan 2024 09:12:37 -0800
Message-ID: <CAOMdWSJov=9kVY7DFdS1=p6BCxi8E90xedU44TS90NPq18iZbA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


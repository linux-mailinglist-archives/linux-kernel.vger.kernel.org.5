Return-Path: <linux-kernel+bounces-75162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC57785E402
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDC284203
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4183A0C;
	Wed, 21 Feb 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njbmt9t+"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E2839E5;
	Wed, 21 Feb 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535229; cv=none; b=FR1r2yk/ZWHtsFOdw6Y72cpCYsxSFPaHTl63c8LyJxCUNWb2Js9Ac1rYajUDzdlUkg4SJBvS7i2dt8bii8dGysbaGZioXZ8VmLvLkVMqzsdtDFEMBH0yblJy8NAXuFlGvKRFKHPdZrWzOod5E9rHRwbVFsWWIZSs7QojmMPUJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535229; c=relaxed/simple;
	bh=Zbjy1nQNBfYG4OsIaBytTrxxmwZ460/iOPYg0a5duik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BivIbzlfOzkeJYpBn4r5RrWxkNiE6tnhdu2cE+Aj49Ll+wq8N4hOyayo7bWn+/9HuAnQAJLGkMgJD7fvJpq7ghe+miPIt+rVzHYlXaJSyx3+wk4x41xWqsY1HITGTV+L6H/Ljt3s/Rjc+dXvQ9T6gAx0DPcWJCQQ07vFOPwsd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njbmt9t+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2f0d6c82eso2350971a34.2;
        Wed, 21 Feb 2024 09:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535227; x=1709140027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TEbKyxyZwM4lqzRa2VrkFXSk9mkhjv9u+7PeyRf3sUc=;
        b=njbmt9t+kHJ3uwdyew7dUBuqsMmeV1Ov4/BUfn54PCJeBRnRUIEj4sxxGASxYZ82Vz
         hFGSr9XujU0c6+jHiQdIbWmxiwIjQbujBcfCobbral/6a511xYMQcwFFPaLjIX3GTAsG
         GX2a+usQFWeW5xF0PB+573+ihDwdTqfjLuB/nwrS48aLbkti8T/SXfx3R5Ky7lq8ZkyF
         gwAJxz8Z9/2YqrEAn7eV1YwKD+ABz1iIYrixt0qlJ/5kS4YMD4grBWOEV7NoAcIU5FmW
         Dc+XjjZfLSyzLh56Fc/MGZBnm3w7oXsAcfKJe+1ud4pFdDBPkMjceb7JtYGw5htKVNDm
         P4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535227; x=1709140027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEbKyxyZwM4lqzRa2VrkFXSk9mkhjv9u+7PeyRf3sUc=;
        b=W71F1iznzNEBMVBIUjYNkNgwaQv02DnWMrCs+MD095/57Kr4zY+aqN6T9dhAUaBNBm
         MqFJLLDvGLCcwhTVuBNlqgSy5gbqJcIJxMfI+HtWsrHTCgHr95igUuAkAFJxGtQfcT7i
         0Xe3tR+bnS0tbjGa0TBpzPox818aoVj3w6kXGjc7p24nkzDidd09fKt92uweJnroO3NC
         +t2uRKQnB6u4/wH7RsLd/Eyn0A/95mQqBnXfzp8Vz1nm3lHbJ21XBL1anDqtR2BTZJT6
         Ulxc0AdVDbpuVRuYi1ng3v5qXS7HFwiqdDOB6+v1t8PGMOgNLixgztbuNU/plgFk+v0N
         rfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1pZ9UO/vZYOQqYybkPk9e/6RcR491zZ5Uv/q4H7pRdOqkJTxYkpALzIohyDXrc/Y4atIXAL5CiB0wCB0oLPm7MFfraxfXB1j1TWju
X-Gm-Message-State: AOJu0Yx9m14ZJwIChGUJzDJjFWZqB6iItnWg5MESfpAwBTY1NMyTGgF3
	HCB1Q4as8ymkrjP5yXAImbrSJRenuWlstf/2Xk833TXlkdrXt5/NPSkQ6fmGA65jfyO4KNeTdcl
	l6D70kgybKLDb2cRqpnGu5AOAkfs=
X-Google-Smtp-Source: AGHT+IEoxHM8YyvpUn12Kk/mIyQp2VHQDJVbP78XuEnFpCbzdSHxr1NskXU1axqtZN7iLu2O8GYQxgOYiwDaXWhvY1s=
X-Received: by 2002:a05:6808:3993:b0:3c1:3e92:4d21 with SMTP id
 gq19-20020a056808399300b003c13e924d21mr20285512oib.23.1708535226708; Wed, 21
 Feb 2024 09:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125951.434262489@linuxfoundation.org>
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 21 Feb 2024 09:06:44 -0800
Message-ID: <CAOMdWSLot43Ch5skprWG_QYLN1boZ2exCLVJcGS83nwKHpJ+YA@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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


Return-Path: <linux-kernel+bounces-118986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F9F88C24A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C73E301D49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E35C61F;
	Tue, 26 Mar 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgxS9mQo"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FE50A98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456648; cv=none; b=SspVrtmq71oZAvZ2C+9QMAyokWeOFbFvB/ssdeesFhUVl+XznM+6S4YtQbBXeESnw/9L2fzDsmBdS/fOq3fVYsqRJdMC+SV3ArN+u6atmFyda6YgtYGrNQInl0lmSovI3JPbRUgSw3/BndXoPxGKEMkVlu/dZgVFBmspGPiuH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456648; c=relaxed/simple;
	bh=qOgEt04Cktj3ZOzRSsKojbUHmC+nS7AdLE93qncD5hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckhaqGbYsi9WzBoXEXqOgF8Vb3kEoBnCtdL5MABrO5tAwN6ejGB1ly7hjz0cS90bdXZfAQF+ZSfGddcPibt57HR9MPwLm0VjVfrYPweDIEgJwsqV1Gl1bOlplrmGvtgl9SdFtUWUfqxOhdgwoMJLXYJZ9zT8jS3np9kaGhj+dZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgxS9mQo; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d44e2e9f13so1580711e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711456646; x=1712061446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qckAaAQvDawa2rOtERY8cmOyLEyi0qkEFSxxXb4vMwg=;
        b=YgxS9mQoa6ZQoQd++4TwJUBOHuR5SuUeWE7bouimw+fui7HdZhkFwU4cpW8R2r7iP9
         4x2uncp7dwAIpBK2n7MjATmEEE1ONqK6Y7a4TuAdBiUNEYvymCxEwW9H8MdK0100TjKO
         fzc7811pRUQpq3Tp7SxMa2BBMKRQ2j3vlCrOoA1fK/a9dSSEFe9w+XnJIQ27hda106mX
         tE7+puW5b0RdRSkooQmd2CWlBIJP1AmklI66GVoOqIM0x/GKo+0YDjh6QdHKsvC6Pr4E
         E44RkCQRcDUlyoAIV3GtDyBq0FuTOQ0/2g1JuBHLKOwxdSunjDegFPy8FpKKUclWVb1G
         Le1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456646; x=1712061446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qckAaAQvDawa2rOtERY8cmOyLEyi0qkEFSxxXb4vMwg=;
        b=pC9PRv/G5mWusYMtuzBlv6WK6dwHQjTSs9f63PwBVpW6LljPA9UxQRTQhilFhJJ9SY
         hhZHaIBgss3g8mNoAZ1MPG48Z/x4urgvu0n41SJ5V3iEXejZRRbP/kVVdXA+MFh7TpdZ
         KgrMCGU0k0D1ouM/eJRpoNaMD4yWARnSD9pCBGOMlHHNCrRrDb7oHA5TedvSW0l7Iif3
         wV3bDN7brC2ci4P9y5ux3GVUt9ZtpvRv8Kqgf7LbCCm2NUh8FsQtKUFM+0RHFLRJB2qs
         ywdQx8DPEAyUbun9m1WZze5hFCzvDfNLwLIKzf73aC7XaojiiBXtYBs8y/AKdVhb1pZ+
         qdnw==
X-Gm-Message-State: AOJu0YxbifKtnPrX/YqQXZyeBbpJLZCZsYbt8Hce5EFZ7x3pqWRsDFsK
	rqQVlbqmP4usWIbufBMK1uXY1UQr7y0sluHudBdS8wEy76IuUdmC+szJDR3laoaKRJqK9mlZZhp
	Nk5ewqBfizJ01o0NfqZo2MYXpGh0GO0DJEroRog==
X-Google-Smtp-Source: AGHT+IEm2t0vuIygi1Dm4Yr7MU2IhJVp8dkz6GzE7gg/+xkeSUaT1bDZQ97tXChOMdP4g0wsuvJ8Sb+rHHAMC8LYm4I=
X-Received: by 2002:a05:6102:a54:b0:478:224b:5aae with SMTP id
 i20-20020a0561020a5400b00478224b5aaemr4344749vss.11.1711456645714; Tue, 26
 Mar 2024 05:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115854.1764898-1-sashal@kernel.org>
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Mar 2024 18:07:14 +0530
Message-ID: <CA+G9fYttAJcRBq2F-TfOvfsWJQuCKW9SAo_3C1nv5ok43j4Aeg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:29, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

One more important update from Linaro LKFT testing,

LTP syscalls fallocate06 fails on qemu-arm64 and juno-r2 devices.

fallocate06.c:155: TFAIL: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) failed unexpectedly: ENOSPC (28)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We are running bisections on this issue and get back to you.

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-64483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD2853F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F141F218CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D16627EA;
	Tue, 13 Feb 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/Va9/dy"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC68627E6;
	Tue, 13 Feb 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864413; cv=none; b=NzM/oWbPWHZjjnLoh5gt6AfoHTIZdOmtTR1WYSS34X9Zo9zqTqKH2kbeP4kmSJF4mOtxQ/Ugu7kiJ1m+IsiVP6Ky6rQYfUDKtpn+NNYO+pUX/wxj71eynT62mIxkfWFHwKH1U6MsGOzdGr7m/mmmrZwkYY59evbKpcgkMIB0XbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864413; c=relaxed/simple;
	bh=FRDJja71U5DrXktTUBUgHd1rXiPpJ9AuqTb+oGn1JSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/zGzNT1VG/UqNu54YaoQEUTubbVPFRm3eVTWrn3Ng/5KQE0owX/kBEVLeqQq4TcyjZk9g+jemwRWRS4EEEW5K7AMCKPtimXtIbTiRd+Zk0yzC94WNJuDbGhXRTYKe3hOmYflDp/beIlJkEBk/NXye4LO58wUXVCUOy3toq5VCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/Va9/dy; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c025d5329dso1236548e0c.1;
        Tue, 13 Feb 2024 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864411; x=1708469211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy2JEYRD09aqM5i7KnSx7BIhhrKS/3nlwMCyB4mYneA=;
        b=V/Va9/dyClUakCy1gV8lAGadD5zX6SQUtOL/c4vIy3tYICnTvKQjixmoAGQ77e2ytu
         bPsDcjNdvR++G5XyLR7TsRNPWbIM/6RVTRG50kI8FzGHF81gLMuuiAysY3LhAlNHtmFB
         VRJBpnPDmgrcP7iP1eQ2GiqY2KU+JCfV6IIBYdtyOddkhLLMJ2EtMmryBhQdccKtjifR
         +jXObP9+pM0YTxy/kfMfa/Z1f4MN6+x3fOPE2MbQNN/BZWa5JnP/9dC0KKJqn+F9uEP4
         LciqihEIrqQngQsp+o/IP91//RRzNg9CdoEh2iM91C9c3qZYAjmvFlc0dZUvpF9s3j6z
         Wl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864411; x=1708469211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy2JEYRD09aqM5i7KnSx7BIhhrKS/3nlwMCyB4mYneA=;
        b=YCJRX6D+kq/m5ofA8CoxtDYJUk6gY6uD4C+MfxIOWkQUSnO6hAs17GmH9d0jHyzF6w
         QkpPsCH9mEEXQxmQ3+uLLOLSHAFHG8Aeq1wfB93tpcZJ8z4ZuEbniXmRRPumksmYSe4u
         q0bW4R7s8fdNiaziSmmDFTEcK5vVk3017Mgj0h8QanTmnK41jCtTKaKJrowK/tuN99el
         NRNT+9ijBZBcf2FTBLxCls9SBEk8Au+GRRxO2tL8fl7+Tzk8Mbh25GdYX7o2Hl90QsvQ
         mLA1Bk1so4a1hfdmDio+W9Yed+lvQ1pKarL4PyjJ/kpdMu5kGQX1jOD6BnK8/mleCzjM
         cYFg==
X-Forwarded-Encrypted: i=1; AJvYcCVbs5Jtw86Zl6Oej/ExuIfzEijGQVphz8jzSBATIpLGGECy9XwQdxCR5RZQtw/CnGxuBF0tizbAOglDPAmrx5NNUx728oYCA5daIpMw
X-Gm-Message-State: AOJu0YzLOQLR9u0IUOAp0Zxyy5MvPqV4Dm70l7wyJveQjbZTeML7o0Yh
	xsuobMbUAhkoOzYqFoWtE3/nKLiEN1FxyoBhJd+Qz81QCRFBscBCWDhfWIFKydrtEPlRzqOfRLM
	8hO7g6ZiMsN8urDhaUJSMaUoYwXc=
X-Google-Smtp-Source: AGHT+IFOoLL4fRg0zJbClul7V0irJCq4xfQlGRkgqqm0tw7lpzVjxWCGpCimyJ59GPzIsD+EQBElNVzfv+JC/cyMkLA=
X-Received: by 2002:a67:f051:0:b0:46c:f77e:6f28 with SMTP id
 q17-20020a67f051000000b0046cf77e6f28mr1032548vsm.0.1707864411160; Tue, 13 Feb
 2024 14:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171852.948844634@linuxfoundation.org>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 13 Feb 2024 14:46:40 -0800
Message-ID: <CAOMdWSLjAwrdYJYjejkWLRTZTYjgFqJ5=_PoWfQFLA5mpG7Mkw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
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


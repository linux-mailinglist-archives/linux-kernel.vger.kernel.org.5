Return-Path: <linux-kernel+bounces-117697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593788B465
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D72B3C307
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DC06F515;
	Mon, 25 Mar 2024 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HzdHFg32"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D96F50F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390945; cv=none; b=N7DpeDthikXNDIh+rSvwW0988fN5a0k+ykk6PRFbRSPq2ekAVY+cJYZ6YzQsbVIp1Nr17IDSvpVceRJCDcHNaAJ+y+s2hRrcTXX23daIR6fvXEGWbdRWYpqg5zY+tkSygNcIWemr27tIHkGQ3EGL3w5shUNhoYWVvVIV2MnRqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390945; c=relaxed/simple;
	bh=Sm1iIrE3ptMLoiPYWIx7AYIRSBbYXVJFhrXPHLow/OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddz2Og94JTHMfFMqe3O+3XbZP+SZoI5T+Xx44CAFrd2ugo+8BOJX2XpUdAqG0DXYYs/JaY4Y6aN+EDBUIxS3axEKfjlmRJa3d3OR0URl0lyPN5Irdj7oL7LCfKWhFPJUzJ4lMbI46FccRjvzcpOdPpitCGbYJWLXfKd+hSeAFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HzdHFg32; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7dfacd39b9eso3009912241.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711390943; x=1711995743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59RbJeT44SKnY/OmzZIX7K9bbID4Uwd0aO1o7f4SUzg=;
        b=HzdHFg32mQbYqASTOrH9WpFyOK8KNSznF+f7rI+oiWzmXf+HsoIG+UohicioFnp1L2
         EKMF37B+t0bGULEIKvna9jnzo1FhnzYSPLFQY6EDTpOAxZBERKGuqpqrgYXEp6NnoXc4
         SaUXZa6QayHTpUOlMyQa2HLjwx7nl654pHD47KiSSqUvgohrkbyiqQ1PNe3q305iHWJy
         5ILZlN7GwxKrSIFNJ7GV3FmzFU3r/7kXcESNYZkJAD6MZzXLbYdKtWaNeC89/sHF70dL
         BydxaP8nhUoPfB1ca2BWh+yxDOn5MRapczaV8/xrB5DA/kk+z5iU7/c3+Inz6Jec8hpW
         Nhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390943; x=1711995743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59RbJeT44SKnY/OmzZIX7K9bbID4Uwd0aO1o7f4SUzg=;
        b=nSEUrWbeXEGyHA2pxntzLCrOx0ohPQQSGwEDK+oUBuEtE/ApjzWwibim0NyVeBHPih
         BdbC4j+5iKCr8zYZcl+N3CbD7akJ3e+uwKmgQPsIGD4KEfM5TI543hp+9x/7oCm4qIdP
         HVeuCobnCdKiOqT2PfSAEv0+QrexWbPoIu7hMldB+tBCXdlKMMYH2CGIdptrhtVhkhWM
         m2sBYcRx0QpbFTEj0OJ9UM3TXZNYEcxmUQWCw27AGKS3ghBeG5ICGfOGBAj4JxUqNRYm
         sxwgksTB5tZMnFQCmPHtjlfb7Xw6OvEbe1OfQWe4nqj3s53ZoIrVb+foxgKgw10HVmji
         VDNA==
X-Gm-Message-State: AOJu0YwtSDfI/PO3vVqQnxdIO8bw16r0Mg+pUPPdwx0nNSo0XQ7Y+/Cf
	q3EKICCEWQdeejwUgpcOsPrswN0Hu/vqoPjwe9o3rIjfABgBphS7dPePZwry3fiYPfh/Uf04zEN
	YEEbrp6oOkkAXP80oz14MZ2Za3KSNYUAEeX3y/g==
X-Google-Smtp-Source: AGHT+IH6xelstakxvT9pP0w8xKZz5NTAFsAotZ60pQaUO1lWc0bDEKkNu8QUnhirWPjBMwiPYlRz7FH/BebwtVIe1X8=
X-Received: by 2002:a05:6122:2194:b0:4d3:394b:d997 with SMTP id
 j20-20020a056122219400b004d3394bd997mr5085228vkd.4.1711390943180; Mon, 25 Mar
 2024 11:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120003.1767691-1-sashal@kernel.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 23:52:12 +0530
Message-ID: <CA+G9fYtJZAioPkbOVJSRY0k6sSKBLc8_ZeBxv3CNfw-gP7yGtw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Anders Roxell <anders.roxell@linaro.org>, Petr Mladek <pmladek@suse.com>, 
	ohn Ogness <john.ogness@linutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:30, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha


From the previous 6.7.11-rc1 and 6.8.2-rc1 report,
the armv7 and i386 boot failed on v6.8 and v6.7 [1]

Following two patches needed for the boot to pass.
90ad525c2d9a ("printk: Use prb_first_seq() as base for 32bit seq macros")
418ec1961c07 ("printk: Adjust mapping for 32bit seq macros")

Please apply the above two patches on v6.8 and v6.7.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[1]
https://lore.kernel.org/stable/CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-26442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893382E0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385031F22CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EB18E25;
	Mon, 15 Jan 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwzkU2dD"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4118E17;
	Mon, 15 Jan 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46781bd40f8so2130661137.1;
        Mon, 15 Jan 2024 11:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348014; x=1705952814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwPEwRCpFgdHL+2xJbtG/kkdaMyfZ90AQyODncoQ0Gc=;
        b=SwzkU2dDUTh3GthXGddQYMY0R/SQJ1TzRNAj0ikxD8qY45io+y0CwZIKj4ofpOWODe
         dwRhiHd2AjRV7AH46GIiniCIM2yyU1n8eUKzVxNEQ/igmTbWwP25lpCWpCqJ28kA1ybl
         Ybq1fL9YMus4hvJKlbTJyz8/rfce7Aoe0S2aUWYRLC5A1JItQhI4oL3TQxzu7Pn//8iS
         nCx0DhXsMLnGiLRFZa+nmsnIskI+5K5vVPEElcH6rdDdanOgYW+M3p4g9MaQvk8z9YQS
         U34SkT3vscSzhD3uFxknbiZsRvDrvMUSM3DACElB6AihqX3DTooXzzJ3ttP5t+uUNKNz
         2EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348014; x=1705952814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwPEwRCpFgdHL+2xJbtG/kkdaMyfZ90AQyODncoQ0Gc=;
        b=SlYyrg4na/p0Tw8DcK4zjAxTBVxP7o2VT8YyCSdCKc++E19EdTFAyf9Xzm9gvctwY6
         ynB/ZZ98zP7q9jksBqH8x4dbAjqvEdbDTWuCphN34tNcOsUU7SN9TLqYYnnF4uAbSgCz
         9jYp7oa2VVdj73IUNsUGjOJos720ccEd2SwLRrWM3e5veM4Wu+BsnMN0poyYpFhbdkUE
         5mGKelhiI28NVsxg2dWE0bjXxK0hE5qV21a3ihM2xmAVv/LTN58A52ot8L/kfH1ndWkA
         RfGTiM6+ckfgpFex1rx1j8asAoednHZMKja2OYvZdVhj65RW75F1pTw4/HATr4s4/jbt
         ZL3A==
X-Gm-Message-State: AOJu0Yzu4YSZYGji1f+Yai5S+P8XiafH1x0azgahXZOkvhhLGsgeL1IC
	WS5sC5X84h942h8hdC4N4OpqN79/zkOtWxMdSr0=
X-Google-Smtp-Source: AGHT+IG+O6Do43YBKCFtsxPYQyjSkp2exc0bClam7UxvmdXXSoWEtVaV8W4ChIFQ9LjiUmi90jk9Cm+OsTfKWmsBP0c=
X-Received: by 2002:a67:fc86:0:b0:469:5874:d834 with SMTP id
 x6-20020a67fc86000000b004695874d834mr1577917vsp.5.1705348013989; Mon, 15 Jan
 2024 11:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094204.017594027@linuxfoundation.org>
In-Reply-To: <20240113094204.017594027@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 15 Jan 2024 11:46:42 -0800
Message-ID: <CAOMdWSJS58RL1YLhcBGYN50c_4tMbDCmKFNHz=SpX8P06zi5zg@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/4] 6.1.73-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.73 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.73-rc1.gz
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

